return {
	Play417201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417201001
		arg_1_1.duration_ = 7.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501062).content)

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

			local var_4_8 = "ST37"

			if arg_1_1.bgs_.ST37 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.ST37

				arg_1_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST37" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 6.2

			arg_1_1.isInRecall_ = true

			if var_4_13 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
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

			local var_4_14 = 0.266666666666667

			if var_4_13 <= arg_1_1.time_ and arg_1_1.time_ < var_4_13 + var_4_14 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_13) / var_4_14)
			end

			if arg_1_1.time_ >= var_4_13 + var_4_14 and arg_1_1.time_ < var_4_13 + var_4_14 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 5 and arg_1_1.time_ < var_4_15 + 5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_16 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 1

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

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= 6.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417201002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 417201002
		arg_7_1.duration_ = 3.5

		local var_7_0 = {
			zh = 2.833,
			ja = 3.5
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play417201003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.allBtn_.enabled = false
			end

			if arg_7_1.time_ >= 0 + 0.133333333333333 and arg_7_1.time_ < 0 + 0.133333333333333 + arg_10_0 then
				arg_7_1.allBtn_.enabled = true
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_10_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_7_1.bgmTxt_.text ~= var_10_2 and arg_7_1.bgmTxt_.text ~= "" then
						if arg_7_1.bgmTxt2_.text ~= "" then
							arg_7_1.bgmTxt_.text = arg_7_1.bgmTxt2_.text
						end

						arg_7_1.bgmTxt2_.text = var_10_2

						arg_7_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_7_1.bgmTxt_.text = var_10_2
						arg_7_1.bgmTxt2_.text = var_10_2
					end

					if arg_7_1.bgmTimer then
						arg_7_1.bgmTimer:Stop()

						arg_7_1.bgmTimer = nil
					end

					if arg_7_1.settingData.show_music_name == 1 then
						arg_7_1.musicController:SetSelectedState("show")
						arg_7_1.musicAnimator_:Play("open", 0, 0)

						if arg_7_1.settingData.music_time ~= 0 then
							arg_7_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_7_1.settingData.music_time), function()
								if arg_7_1 == nil or isNil(arg_7_1.bgmTxt_) then
									return
								end

								arg_7_1.musicController:SetSelectedState("hide")
								arg_7_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.275 < arg_7_1.time_ and arg_7_1.time_ <= 0.275 + arg_10_0 then
				arg_7_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_10_5 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_7_1.bgmTxt_.text ~= var_10_5 and arg_7_1.bgmTxt_.text ~= "" then
						if arg_7_1.bgmTxt2_.text ~= "" then
							arg_7_1.bgmTxt_.text = arg_7_1.bgmTxt2_.text
						end

						arg_7_1.bgmTxt2_.text = var_10_5

						arg_7_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_7_1.bgmTxt_.text = var_10_5
						arg_7_1.bgmTxt2_.text = var_10_5
					end

					if arg_7_1.bgmTimer then
						arg_7_1.bgmTimer:Stop()

						arg_7_1.bgmTimer = nil
					end

					if arg_7_1.settingData.show_music_name == 1 then
						arg_7_1.musicController:SetSelectedState("show")
						arg_7_1.musicAnimator_:Play("open", 0, 0)

						if arg_7_1.settingData.music_time ~= 0 then
							arg_7_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_7_1.settingData.music_time), function()
								if arg_7_1 == nil or isNil(arg_7_1.bgmTxt_) then
									return
								end

								arg_7_1.musicController:SetSelectedState("hide")
								arg_7_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_10_6 = 0
			local var_10_7 = 0.275

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_8 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_8:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_7_1.dialogCg_.alpha = arg_13_0
				end))
				var_10_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_7_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_10_9 = arg_7_1:GetWordFromCfg(417201002)
				local var_10_10 = arg_7_1:FormatText(var_10_9.content)

				arg_7_1.text_.text = var_10_10

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_12 = 11 <= 0 and var_10_7 or var_10_7 * (utf8.len(var_10_10) / 11)

				if (11 <= 0 and var_10_7 or var_10_7 * (utf8.len(var_10_10) / 11)) > 0 and var_10_7 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12
					var_10_6 = var_10_6 + 0.3

					if var_10_12 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_10
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201002", "story_v_out_417201.awb") ~= 0 then
					local var_10_13 = manager.audio:GetVoiceLength("story_v_out_417201", "417201002", "story_v_out_417201.awb") / 1000

					if var_10_13 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_6
					end

					if var_10_9.prefab_name ~= "" and arg_7_1.actors_[var_10_9.prefab_name] ~= nil then
						local var_10_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_9.prefab_name].transform, "story_v_out_417201", "417201002", "story_v_out_417201.awb")

						arg_7_1:RecordAudio("417201002", var_10_14)
						arg_7_1:RecordAudio("417201002", var_10_14)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_417201", "417201002", "story_v_out_417201.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_417201", "417201002", "story_v_out_417201.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_15 = var_10_6 + 0.3
			local var_10_16 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_15 + var_10_16 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_15) / var_10_16

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_15 + var_10_16 and arg_7_1.time_ < var_10_15 + var_10_16 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play417201003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 417201003
		arg_15_1.duration_ = 5.13

		local var_15_0 = {
			zh = 2.9,
			ja = 5.133
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
				arg_15_0:Play417201004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1060"] == nil then
				local var_18_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_18_0) then
					local var_18_1 = Object.Instantiate(var_18_0, arg_15_1.canvasGo_.transform)

					var_18_1.transform:SetSiblingIndex(1)

					var_18_1.name = "1060"
					var_18_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_["1060"] = var_18_1

					if arg_15_1.isInRecall_ then
						for iter_18_0, iter_18_1 in ipairs((var_18_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_18_1.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_2 = arg_15_1.actors_["1060"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1060 == nil then
				arg_15_1.var_.actorSpriteComps1060 = var_18_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_3 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_3 and not isNil(var_18_2) then
				if arg_15_1.var_.actorSpriteComps1060 then
					for iter_18_2, iter_18_3 in pairs(arg_15_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_18_3 then
							if arg_15_1.isInRecall_ then
								iter_18_3.color = Color.New(Mathf.Lerp(iter_18_3.color.r, arg_15_1.hightColor1.r, (arg_15_1.time_ - 0) / var_18_3), Mathf.Lerp(iter_18_3.color.g, arg_15_1.hightColor1.g, (arg_15_1.time_ - 0) / var_18_3), (Mathf.Lerp(iter_18_3.color.b, arg_15_1.hightColor1.b, (arg_15_1.time_ - 0) / var_18_3)))
							else
								local var_18_4 = Mathf.Lerp(iter_18_3.color.r, 1, (arg_15_1.time_ - 0) / var_18_3)

								iter_18_3.color = Color.New(var_18_4, var_18_4, var_18_4)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_3 and arg_15_1.time_ < 0 + var_18_3 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1060 then
				for iter_18_4, iter_18_5 in pairs(arg_15_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_18_5 then
						iter_18_5.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps1060 = nil
			end

			local var_18_5 = arg_15_1.actors_["1060"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1060 = var_18_5.localPosition
				var_18_5.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1060", 3)

				for iter_18_6 = 0, var_18_5.childCount - 1 do
					local var_18_6 = var_18_5:GetChild(iter_18_6)

					if var_18_6.name == "" or not string.find(var_18_6.name, "split") then
						var_18_6.gameObject:SetActive(true)
					else
						var_18_6.gameObject:SetActive(false)
					end
				end
			end

			local var_18_7 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_15_1.time_ - 0) / var_18_7)
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_18_8 = 0
			local var_18_9 = 0.225

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(417201003)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 9 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 9)

				if (9 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 9)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201003", "story_v_out_417201.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201003", "story_v_out_417201.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_417201", "417201003", "story_v_out_417201.awb")

						arg_15_1:RecordAudio("417201003", var_18_15)
						arg_15_1:RecordAudio("417201003", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_417201", "417201003", "story_v_out_417201.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_417201", "417201003", "story_v_out_417201.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_8) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_16 and arg_15_1.time_ < var_18_8 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play417201004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 417201004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play417201005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1060 = arg_19_1.actors_["1060"].transform.localPosition
				arg_19_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1060", 7)

				for iter_22_0 = 0, arg_19_1.actors_["1060"].transform.childCount - 1 do
					local var_22_0 = arg_19_1.actors_["1060"].transform:GetChild(iter_22_0)

					if var_22_0.name == "" or not string.find(var_22_0.name, "split") then
						var_22_0.gameObject:SetActive(true)
					else
						var_22_0.gameObject:SetActive(false)
					end
				end
			end

			local var_22_1 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 then
				arg_19_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_19_1.time_ - 0) / var_22_1)
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 then
				arg_19_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_22_2 = 0
			local var_22_3 = 1.525

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(417201004).content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 61 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 61)

				if (61 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 61)) > 0 and var_22_3 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_7 and arg_19_1.time_ < var_22_2 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play417201005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 417201005
		arg_23_1.duration_ = 10.37

		local var_23_0 = {
			zh = 6.966,
			ja = 10.366
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play417201006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.725

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_23_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_26_1 = arg_23_1:GetWordFromCfg(417201005)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 29 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 29)

				if (29 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 29)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201005", "story_v_out_417201.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_417201", "417201005", "story_v_out_417201.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_417201", "417201005", "story_v_out_417201.awb")

						arg_23_1:RecordAudio("417201005", var_26_6)
						arg_23_1:RecordAudio("417201005", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_417201", "417201005", "story_v_out_417201.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_417201", "417201005", "story_v_out_417201.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play417201006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 417201006
		arg_27_1.duration_ = 1.53

		local var_27_0 = {
			zh = 1,
			ja = 1.533
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
				arg_27_0:Play417201007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1060"]) and arg_27_1.var_.actorSpriteComps1060 == nil then
				arg_27_1.var_.actorSpriteComps1060 = arg_27_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1060"]) then
				if arg_27_1.var_.actorSpriteComps1060 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 1, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1060"]) and arg_27_1.var_.actorSpriteComps1060 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1060 = nil
			end

			local var_30_2 = arg_27_1.actors_["1060"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1060 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1060", 3)

				for iter_30_4 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_4)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_27_1.time_ - 0) / var_30_4)
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_30_5 = 0
			local var_30_6 = 0.075

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:GetWordFromCfg(417201006)
				local var_30_8 = arg_27_1:FormatText(var_30_7.content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 3 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 3)

				if (3 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 3)) > 0 and var_30_6 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201006", "story_v_out_417201.awb") ~= 0 then
					local var_30_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201006", "story_v_out_417201.awb") / 1000

					if var_30_11 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_5
					end

					if var_30_7.prefab_name ~= "" and arg_27_1.actors_[var_30_7.prefab_name] ~= nil then
						local var_30_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_7.prefab_name].transform, "story_v_out_417201", "417201006", "story_v_out_417201.awb")

						arg_27_1:RecordAudio("417201006", var_30_12)
						arg_27_1:RecordAudio("417201006", var_30_12)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_417201", "417201006", "story_v_out_417201.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_417201", "417201006", "story_v_out_417201.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_13 and arg_27_1.time_ < var_30_5 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play417201007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 417201007
		arg_31_1.duration_ = 3.33

		local var_31_0 = {
			zh = 2.666,
			ja = 3.333
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
				arg_31_0:Play417201008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1060"]) and arg_31_1.var_.actorSpriteComps1060 == nil then
				arg_31_1.var_.actorSpriteComps1060 = arg_31_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1060"]) then
				if arg_31_1.var_.actorSpriteComps1060 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1060"]) and arg_31_1.var_.actorSpriteComps1060 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps1060 = nil
			end

			local var_34_2 = 0
			local var_34_3 = 0.325

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_31_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_34_4 = arg_31_1:GetWordFromCfg(417201007)
				local var_34_5 = arg_31_1:FormatText(var_34_4.content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 13 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 13)

				if (13 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 13)) > 0 and var_34_3 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201007", "story_v_out_417201.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_417201", "417201007", "story_v_out_417201.awb") / 1000

					if var_34_8 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_2
					end

					if var_34_4.prefab_name ~= "" and arg_31_1.actors_[var_34_4.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_4.prefab_name].transform, "story_v_out_417201", "417201007", "story_v_out_417201.awb")

						arg_31_1:RecordAudio("417201007", var_34_9)
						arg_31_1:RecordAudio("417201007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_417201", "417201007", "story_v_out_417201.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_417201", "417201007", "story_v_out_417201.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_10 and arg_31_1.time_ < var_34_2 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play417201008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 417201008
		arg_35_1.duration_ = 5.03

		local var_35_0 = {
			zh = 3.333,
			ja = 5.033
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
				arg_35_0:Play417201009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1060"]) and arg_35_1.var_.actorSpriteComps1060 == nil then
				arg_35_1.var_.actorSpriteComps1060 = arg_35_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1060"]) then
				if arg_35_1.var_.actorSpriteComps1060 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 1, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1060"]) and arg_35_1.var_.actorSpriteComps1060 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps1060 = nil
			end

			local var_38_2 = 0
			local var_38_3 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(417201008)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 16 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 16)

				if (16 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 16)) > 0 and var_38_3 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201008", "story_v_out_417201.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_417201", "417201008", "story_v_out_417201.awb") / 1000

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end

					if var_38_4.prefab_name ~= "" and arg_35_1.actors_[var_38_4.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_4.prefab_name].transform, "story_v_out_417201", "417201008", "story_v_out_417201.awb")

						arg_35_1:RecordAudio("417201008", var_38_9)
						arg_35_1:RecordAudio("417201008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_417201", "417201008", "story_v_out_417201.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_417201", "417201008", "story_v_out_417201.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_10 and arg_35_1.time_ < var_38_2 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play417201009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 417201009
		arg_39_1.duration_ = 10.07

		local var_39_0 = {
			zh = 6.066,
			ja = 10.066
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play417201010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1060"]) and arg_39_1.var_.actorSpriteComps1060 == nil then
				arg_39_1.var_.actorSpriteComps1060 = arg_39_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1060"]) then
				if arg_39_1.var_.actorSpriteComps1060 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								iter_42_1.color = Color.New(Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_0), Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_0), (Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_0)))
							else
								local var_42_1 = Mathf.Lerp(iter_42_1.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_0)

								iter_42_1.color = Color.New(var_42_1, var_42_1, var_42_1)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1060"]) and arg_39_1.var_.actorSpriteComps1060 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_42_3 then
						iter_42_3.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps1060 = nil
			end

			local var_42_2 = 0
			local var_42_3 = 0.75

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_39_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_42_4 = arg_39_1:GetWordFromCfg(417201009)
				local var_42_5 = arg_39_1:FormatText(var_42_4.content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 30 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 30)

				if (30 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_5) / 30)) > 0 and var_42_3 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201009", "story_v_out_417201.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_417201", "417201009", "story_v_out_417201.awb") / 1000

					if var_42_8 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_2
					end

					if var_42_4.prefab_name ~= "" and arg_39_1.actors_[var_42_4.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_4.prefab_name].transform, "story_v_out_417201", "417201009", "story_v_out_417201.awb")

						arg_39_1:RecordAudio("417201009", var_42_9)
						arg_39_1:RecordAudio("417201009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_417201", "417201009", "story_v_out_417201.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_417201", "417201009", "story_v_out_417201.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_10 and arg_39_1.time_ < var_42_2 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play417201010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 417201010
		arg_43_1.duration_ = 7.23

		local var_43_0 = {
			zh = 6.933,
			ja = 7.233
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play417201011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_43_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_46_1 = arg_43_1:GetWordFromCfg(417201010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 27 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 27)

				if (27 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 27)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201010", "story_v_out_417201.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_417201", "417201010", "story_v_out_417201.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_417201", "417201010", "story_v_out_417201.awb")

						arg_43_1:RecordAudio("417201010", var_46_6)
						arg_43_1:RecordAudio("417201010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_417201", "417201010", "story_v_out_417201.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_417201", "417201010", "story_v_out_417201.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play417201011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 417201011
		arg_47_1.duration_ = 3.27

		local var_47_0 = {
			zh = 2.2,
			ja = 3.266
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
				arg_47_0:Play417201012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1060"]) and arg_47_1.var_.actorSpriteComps1060 == nil then
				arg_47_1.var_.actorSpriteComps1060 = arg_47_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1060"]) then
				if arg_47_1.var_.actorSpriteComps1060 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								iter_50_1.color = Color.New(Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_0), Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_0), (Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_0)))
							else
								local var_50_1 = Mathf.Lerp(iter_50_1.color.r, 1, (arg_47_1.time_ - 0) / var_50_0)

								iter_50_1.color = Color.New(var_50_1, var_50_1, var_50_1)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1060"]) and arg_47_1.var_.actorSpriteComps1060 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_50_3 then
						iter_50_3.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1060 = nil
			end

			local var_50_2 = arg_47_1.actors_["1060"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1060 = var_50_2.localPosition
				var_50_2.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1060", 3)

				for iter_50_4 = 0, var_50_2.childCount - 1 do
					local var_50_3 = var_50_2:GetChild(iter_50_4)

					if var_50_3.name == "split_3" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_2.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_47_1.time_ - 0) / var_50_4)
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_50_5 = 0
			local var_50_6 = 0.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:GetWordFromCfg(417201011)
				local var_50_8 = arg_47_1:FormatText(var_50_7.content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 8 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 8)

				if (8 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 8)) > 0 and var_50_6 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201011", "story_v_out_417201.awb") ~= 0 then
					local var_50_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201011", "story_v_out_417201.awb") / 1000

					if var_50_11 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_5
					end

					if var_50_7.prefab_name ~= "" and arg_47_1.actors_[var_50_7.prefab_name] ~= nil then
						local var_50_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_7.prefab_name].transform, "story_v_out_417201", "417201011", "story_v_out_417201.awb")

						arg_47_1:RecordAudio("417201011", var_50_12)
						arg_47_1:RecordAudio("417201011", var_50_12)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_417201", "417201011", "story_v_out_417201.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_417201", "417201011", "story_v_out_417201.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_13 and arg_47_1.time_ < var_50_5 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play417201012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 417201012
		arg_51_1.duration_ = 8.87

		local var_51_0 = {
			zh = 6.5,
			ja = 8.866
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
				arg_51_0:Play417201013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1060"]) and arg_51_1.var_.actorSpriteComps1060 == nil then
				arg_51_1.var_.actorSpriteComps1060 = arg_51_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1060"]) then
				if arg_51_1.var_.actorSpriteComps1060 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1060"]) and arg_51_1.var_.actorSpriteComps1060 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps1060 = nil
			end

			local var_54_2 = 0
			local var_54_3 = 0.7

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1138].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_51_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_54_4 = arg_51_1:GetWordFromCfg(417201012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 28 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 28)

				if (28 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 28)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201012", "story_v_out_417201.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_417201", "417201012", "story_v_out_417201.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_417201", "417201012", "story_v_out_417201.awb")

						arg_51_1:RecordAudio("417201012", var_54_9)
						arg_51_1:RecordAudio("417201012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_417201", "417201012", "story_v_out_417201.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_417201", "417201012", "story_v_out_417201.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play417201013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 417201013
		arg_55_1.duration_ = 5.33

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play417201014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.STblack == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_58_0.name = "STblack"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.STblack = var_58_0
			end

			if 1.02994399941526 < arg_55_1.time_ and arg_55_1.time_ <= 1.02994399941526 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.STblack

				arg_55_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "STblack" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = false

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 1.02994399941526

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 1.02994399941526

			if 1.02994399941526 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = false

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 0.970056000584737

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			if 1.63333333333333 < arg_55_1.time_ and arg_55_1.time_ <= 1.63333333333333 + arg_58_0 then
				arg_55_1.cswbg_:SetActive(true)

				local var_58_12 = arg_55_1.cswt_:GetComponent("RectTransform")

				arg_55_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_58_12.offsetMin = Vector2.New(0, 0)
				var_58_12.offsetMax = Vector2.New(0, 0)
				arg_55_1.cswt_.text = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(419109).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.cswt_)

				arg_55_1.cswt_.fontSize = 120
				arg_55_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_55_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_58_13 = arg_55_1.actors_["1060"].transform

			if 0.995943999415264 < arg_55_1.time_ and arg_55_1.time_ <= 0.995943999415264 + arg_58_0 then
				arg_55_1.var_.moveOldPos1060 = var_58_13.localPosition
				var_58_13.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1060", 7)

				for iter_58_2 = 0, var_58_13.childCount - 1 do
					local var_58_14 = var_58_13:GetChild(iter_58_2)

					if var_58_14.name == "" or not string.find(var_58_14.name, "split") then
						var_58_14.gameObject:SetActive(true)
					else
						var_58_14.gameObject:SetActive(false)
					end
				end
			end

			local var_58_15 = 0.001

			if 0.995943999415264 <= arg_55_1.time_ and arg_55_1.time_ < 0.995943999415264 + var_58_15 then
				var_58_13.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_55_1.time_ - 0.995943999415264) / var_58_15)
			end

			if arg_55_1.time_ >= 0.995943999415264 + var_58_15 and arg_55_1.time_ < 0.995943999415264 + var_58_15 + arg_58_0 then
				var_58_13.localPosition = Vector3.New(0, -2000, -40)
			end

			if 1.02994399941526 < arg_55_1.time_ and arg_55_1.time_ <= 1.02994399941526 + arg_58_0 then
				arg_55_1.fswbg_:SetActive(true)
				arg_55_1.dialog_:SetActive(false)

				arg_55_1.fswtw_.percent = 0
				arg_55_1.fswt_.text = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(417201013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.fswt_)

				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_55_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_55_1.fswtw_:SetDirty()

				arg_55_1.typewritterCharCountI18N = 0

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_16 = 3

			if 3 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.var_.oldValueTypewriter = arg_55_1.fswtw_.percent

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_17 = 35
			local var_58_18 = 2.33333333333333
			local var_58_19, var_58_20 = arg_55_1:GetPercentByPara(arg_55_1:FormatText(arg_55_1:GetWordFromCfg(417201013).content), 1)

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				local var_58_21 = var_58_17 <= 0 and var_58_18 or var_58_18 * ((var_58_20 - arg_55_1.typewritterCharCountI18N) / var_58_17)

				if (var_58_17 <= 0 and var_58_18 or var_58_18 * ((var_58_20 - arg_55_1.typewritterCharCountI18N) / var_58_17)) > 0 and var_58_18 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21

					if var_58_21 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_16
					end
				end
			end

			local var_58_22 = math.max(2.33333333333333, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_22 then
				arg_55_1.fswtw_.percent = Mathf.Lerp(arg_55_1.var_.oldValueTypewriter, var_58_19, (arg_55_1.time_ - var_58_16) / var_58_22)
				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.fswtw_:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_22 and arg_55_1.time_ < var_58_16 + var_58_22 + arg_58_0 then
				arg_55_1.fswtw_.percent = var_58_19

				arg_55_1.fswtw_:SetDirty()
				arg_55_1:ShowNextGo(true)

				arg_55_1.typewritterCharCountI18N = var_58_20
			end

			if 1.63333333333333 < arg_55_1.time_ and arg_55_1.time_ <= 1.63333333333333 + arg_58_0 then
				local var_58_23 = arg_55_1.fswbg_.transform:Find("textbox/adapt/content") or arg_55_1.fswbg_.transform:Find("textbox/content")
				local var_58_24 = arg_55_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_58_25 = var_58_23:GetComponent("RectTransform")

				var_58_23:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_58_25.offsetMin = Vector2.New(0, 0)
				var_58_25.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.995943999415264,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play417201014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 417201014
		arg_59_1.duration_ = 1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play417201015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.fswbg_:SetActive(true)
				arg_59_1.dialog_:SetActive(false)

				arg_59_1.fswtw_.percent = 0
				arg_59_1.fswt_.text = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(417201014).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.fswt_)

				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_59_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_59_1.fswtw_:SetDirty()

				arg_59_1.typewritterCharCountI18N = 0

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.var_.oldValueTypewriter = arg_59_1.fswtw_.percent

				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			local var_62_1 = 4
			local var_62_2 = 0.266666666666667
			local var_62_3, var_62_4 = arg_59_1:GetPercentByPara(arg_59_1:FormatText(arg_59_1:GetWordFromCfg(417201014).content), 1)

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				local var_62_5 = var_62_1 <= 0 and var_62_2 or var_62_2 * ((var_62_4 - arg_59_1.typewritterCharCountI18N) / var_62_1)

				if (var_62_1 <= 0 and var_62_2 or var_62_2 * ((var_62_4 - arg_59_1.typewritterCharCountI18N) / var_62_1)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_0
					end
				end
			end

			local var_62_6 = math.max(0.266666666666667, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_6 then
				arg_59_1.fswtw_.percent = Mathf.Lerp(arg_59_1.var_.oldValueTypewriter, var_62_3, (arg_59_1.time_ - var_62_0) / var_62_6)
				arg_59_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_59_1.fswtw_:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_6 and arg_59_1.time_ < var_62_0 + var_62_6 + arg_62_0 then
				arg_59_1.fswtw_.percent = var_62_3

				arg_59_1.fswtw_:SetDirty()
				arg_59_1:ShowNextGo(true)

				arg_59_1.typewritterCharCountI18N = var_62_4
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_7 = arg_59_1.fswbg_.transform:Find("textbox/adapt/content") or arg_59_1.fswbg_.transform:Find("textbox/content")
				local var_62_8 = arg_59_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_62_9 = var_62_7:GetComponent("RectTransform")

				var_62_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_62_9.offsetMin = Vector2.New(0, 0)
				var_62_9.offsetMax = Vector2.New(0, 0)
			end

			local var_62_10 = 0
			local var_62_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201014", "") / 1000

			if var_62_11 > 0 and 0.8 < var_62_11 and var_62_11 + var_62_10 > arg_59_1.duration_ then
				arg_59_1.duration_ = var_62_11 + var_62_10
			end

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:AudioAction("play", "voice", "story_v_out_417201", "417201014", "")
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play417201015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 417201015
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play417201016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_0 = arg_63_1.bgs_.ST37

				arg_63_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_1 = var_66_0:GetComponent("SpriteRenderer")

				if var_66_1 and var_66_1.sprite then
					local var_66_2 = 2 * (var_66_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_0.transform.localScale = Vector3.New(var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "ST37" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_3 = 4

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_3 + 0.3 and arg_63_1.time_ < var_66_3 + 0.3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_4 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_5 = 2

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_5 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_4) / var_66_5)
				arg_63_1.mask_.color = var_66_6
			end

			if arg_63_1.time_ >= var_66_4 + var_66_5 and arg_63_1.time_ < var_66_4 + var_66_5 + arg_66_0 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = 1
				arg_63_1.mask_.color = var_66_7
			end

			local var_66_8 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_9 = 2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 then
				local var_66_10 = Color.New(0, 0, 0)

				var_66_10.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_8) / var_66_9)
				arg_63_1.mask_.color = var_66_10
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 then
				local var_66_11 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_11.a = 0
				arg_63_1.mask_.color = var_66_11
			end

			local var_66_12 = arg_63_1.actors_["1060"].transform

			if 1.966 < arg_63_1.time_ and arg_63_1.time_ <= 1.966 + arg_66_0 then
				arg_63_1.var_.moveOldPos1060 = var_66_12.localPosition
				var_66_12.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1060", 7)

				for iter_66_2 = 0, var_66_12.childCount - 1 do
					local var_66_13 = var_66_12:GetChild(iter_66_2)

					if var_66_13.name == "" or not string.find(var_66_13.name, "split") then
						var_66_13.gameObject:SetActive(true)
					else
						var_66_13.gameObject:SetActive(false)
					end
				end
			end

			local var_66_14 = 0.001

			if 1.966 <= arg_63_1.time_ and arg_63_1.time_ < 1.966 + var_66_14 then
				var_66_12.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_63_1.time_ - 1.966) / var_66_14)
			end

			if arg_63_1.time_ >= 1.966 + var_66_14 and arg_63_1.time_ < 1.966 + var_66_14 + arg_66_0 then
				var_66_12.localPosition = Vector3.New(0, -2000, -40)
			end

			if 1.86666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 1.86666666666667 + arg_66_0 then
				arg_63_1.cswbg_:SetActive(false)
			end

			if 1.9 < arg_63_1.time_ and arg_63_1.time_ <= 1.9 + arg_66_0 then
				arg_63_1.fswbg_:SetActive(false)
				arg_63_1.dialog_:SetActive(false)
				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_63_1:ShowNextGo(false)
			end

			if 4.3 < arg_63_1.time_ and arg_63_1.time_ <= 4.3 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_16 = 4
			local var_66_17 = 0.75

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_18 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_18:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(417201015).content)

				arg_63_1.text_.text = var_66_19

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 30 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 30)

				if (30 <= 0 and var_66_17 or var_66_17 * (utf8.len(var_66_19) / 30)) > 0 and var_66_17 < var_66_21 then
					arg_63_1.talkMaxDuration = var_66_21
					var_66_16 = var_66_16 + 0.3

					if var_66_21 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_21 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_19
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_22 = var_66_16 + 0.3
			local var_66_23 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_22 + var_66_23 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_22) / var_66_23

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_22 + var_66_23 and arg_63_1.time_ < var_66_22 + var_66_23 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play417201016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 417201016
		arg_69_1.duration_ = 5.6

		local var_69_0 = {
			zh = 3,
			ja = 5.6
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
				arg_69_0:Play417201017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1060"]) and arg_69_1.var_.actorSpriteComps1060 == nil then
				arg_69_1.var_.actorSpriteComps1060 = arg_69_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1060"]) then
				if arg_69_1.var_.actorSpriteComps1060 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1060"]) and arg_69_1.var_.actorSpriteComps1060 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1060 = nil
			end

			local var_72_2 = arg_69_1.actors_["1060"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1060 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1060", 3)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "split_4" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			if 0.02 < arg_69_1.time_ and arg_69_1.time_ <= 0.02 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_72_6 = 0
			local var_72_7 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(417201016)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 16 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 16)

				if (16 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 16)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201016", "story_v_out_417201.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_417201", "417201016", "story_v_out_417201.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_417201", "417201016", "story_v_out_417201.awb")

						arg_69_1:RecordAudio("417201016", var_72_13)
						arg_69_1:RecordAudio("417201016", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_417201", "417201016", "story_v_out_417201.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_417201", "417201016", "story_v_out_417201.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play417201017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 417201017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play417201018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1060"]) and arg_73_1.var_.actorSpriteComps1060 == nil then
				arg_73_1.var_.actorSpriteComps1060 = arg_73_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1060"]) then
				if arg_73_1.var_.actorSpriteComps1060 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1060"]) and arg_73_1.var_.actorSpriteComps1060 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1060 = nil
			end

			local var_76_2 = arg_73_1.actors_["1060"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1060 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1060", 7)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -2000, -40)
			end

			if 1.049999999999 < arg_73_1.time_ and arg_73_1.time_ <= 1.049999999999 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door", "")
			end

			local var_76_6 = 0
			local var_76_7 = 0.925

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(417201017).content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 37 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 37)

				if (37 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 37)) > 0 and var_76_7 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_11 and arg_73_1.time_ < var_76_6 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play417201018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 417201018
		arg_77_1.duration_ = 8

		local var_77_0 = {
			zh = 4.933,
			ja = 8
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
				arg_77_0:Play417201019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.I05c == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05c")
				var_80_0.name = "I05c"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.I05c = var_80_0
			end

			if 1 < arg_77_1.time_ and arg_77_1.time_ <= 1 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.I05c

				arg_77_1.bgs_.I05c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "I05c" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_4 + 0.3 and arg_77_1.time_ < var_80_4 + 0.3 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_5 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_6 = 1

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_5) / var_80_6)
				arg_77_1.mask_.color = var_80_7
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				local var_80_8 = Color.New(0, 0, 0)

				var_80_8.a = 1
				arg_77_1.mask_.color = var_80_8
			end

			local var_80_9 = 1

			if 1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_10 = 1

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 then
				local var_80_11 = Color.New(0, 0, 0)

				var_80_11.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_9) / var_80_10)
				arg_77_1.mask_.color = var_80_11
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 then
				local var_80_12 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_12.a = 0
				arg_77_1.mask_.color = var_80_12
			end

			local var_80_13 = arg_77_1.actors_["1060"]

			if 1.66666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.66666666666667 + arg_80_0 and not isNil(var_80_13) and arg_77_1.var_.actorSpriteComps1060 == nil then
				arg_77_1.var_.actorSpriteComps1060 = var_80_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_14 = 0.2

			if 1.66666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 1.66666666666667 + var_80_14 and not isNil(var_80_13) then
				if arg_77_1.var_.actorSpriteComps1060 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 1.66666666666667) / var_80_14), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 1.66666666666667) / var_80_14), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 1.66666666666667) / var_80_14)))
							else
								local var_80_15 = Mathf.Lerp(iter_80_3.color.r, 1, (arg_77_1.time_ - 1.66666666666667) / var_80_14)

								iter_80_3.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 1.66666666666667 + var_80_14 and arg_77_1.time_ < 1.66666666666667 + var_80_14 + arg_80_0 and not isNil(var_80_13) and arg_77_1.var_.actorSpriteComps1060 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1060 = nil
			end

			local var_80_16 = arg_77_1.actors_["1060"].transform

			if 1.66666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.66666666666667 + arg_80_0 then
				arg_77_1.var_.moveOldPos1060 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1060", 3)

				for iter_80_6 = 0, var_80_16.childCount - 1 do
					local var_80_17 = var_80_16:GetChild(iter_80_6)

					if var_80_17.name == "" or not string.find(var_80_17.name, "split") then
						var_80_17.gameObject:SetActive(true)
					else
						var_80_17.gameObject:SetActive(false)
					end
				end
			end

			local var_80_18 = 0.001

			if 1.66666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 1.66666666666667 + var_80_18 then
				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_77_1.time_ - 1.66666666666667) / var_80_18)
			end

			if arg_77_1.time_ >= 1.66666666666667 + var_80_18 and arg_77_1.time_ < 1.66666666666667 + var_80_18 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			if 1.66666666666667 < arg_77_1.time_ and arg_77_1.time_ <= 1.66666666666667 + arg_80_0 then
				local var_80_19 = arg_77_1.actors_["1060"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_19 then
					arg_77_1.var_.alphaOldValue1060 = var_80_19.alpha
					arg_77_1.var_.characterEffect1060 = var_80_19
				end

				arg_77_1.var_.alphaOldValue1060 = 0
			end

			local var_80_20 = 0.333333333333333

			if 1.66666666666667 <= arg_77_1.time_ and arg_77_1.time_ < 1.66666666666667 + var_80_20 then
				if arg_77_1.var_.characterEffect1060 then
					arg_77_1.var_.characterEffect1060.alpha = Mathf.Lerp(arg_77_1.var_.alphaOldValue1060, 1, (arg_77_1.time_ - 1.66666666666667) / var_80_20)
				end
			end

			if arg_77_1.time_ >= 1.66666666666667 + var_80_20 and arg_77_1.time_ < 1.66666666666667 + var_80_20 + arg_80_0 and arg_77_1.var_.characterEffect1060 then
				arg_77_1.var_.characterEffect1060.alpha = 1
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_21 = 2
			local var_80_22 = 0.3

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_23 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_23:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(417201018)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_27 = 12 <= 0 and var_80_22 or var_80_22 * (utf8.len(var_80_25) / 12)

				if (12 <= 0 and var_80_22 or var_80_22 * (utf8.len(var_80_25) / 12)) > 0 and var_80_22 < var_80_27 then
					arg_77_1.talkMaxDuration = var_80_27
					var_80_21 = var_80_21 + 0.3

					if var_80_27 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_27 + var_80_21
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201018", "story_v_out_417201.awb") ~= 0 then
					local var_80_28 = manager.audio:GetVoiceLength("story_v_out_417201", "417201018", "story_v_out_417201.awb") / 1000

					if var_80_28 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_21
					end

					if var_80_24.prefab_name ~= "" and arg_77_1.actors_[var_80_24.prefab_name] ~= nil then
						local var_80_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_24.prefab_name].transform, "story_v_out_417201", "417201018", "story_v_out_417201.awb")

						arg_77_1:RecordAudio("417201018", var_80_29)
						arg_77_1:RecordAudio("417201018", var_80_29)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_417201", "417201018", "story_v_out_417201.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_417201", "417201018", "story_v_out_417201.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_30 = var_80_21 + 0.3
			local var_80_31 = math.max(var_80_22, arg_77_1.talkMaxDuration)

			if var_80_21 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_31 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_30) / var_80_31

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_31 and arg_77_1.time_ < var_80_30 + var_80_31 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play417201019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 417201019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play417201020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1060"]) and arg_83_1.var_.actorSpriteComps1060 == nil then
				arg_83_1.var_.actorSpriteComps1060 = arg_83_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1060"]) then
				if arg_83_1.var_.actorSpriteComps1060 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1060"]) and arg_83_1.var_.actorSpriteComps1060 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps1060 = nil
			end

			local var_86_2 = arg_83_1.actors_["1060"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1060 = var_86_2.localPosition
				var_86_2.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1060", 7)

				for iter_86_4 = 0, var_86_2.childCount - 1 do
					local var_86_3 = var_86_2:GetChild(iter_86_4)

					if var_86_3.name == "" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_2.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_83_1.time_ - 0) / var_86_4)
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_2.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_86_5 = 0
			local var_86_6 = 1.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(417201019).content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 44 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 44)

				if (44 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 44)) > 0 and var_86_6 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_10 and arg_83_1.time_ < var_86_5 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play417201020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 417201020
		arg_87_1.duration_ = 4.47

		local var_87_0 = {
			zh = 4.466,
			ja = 4.233
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
				arg_87_0:Play417201021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1060"]) and arg_87_1.var_.actorSpriteComps1060 == nil then
				arg_87_1.var_.actorSpriteComps1060 = arg_87_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1060"]) then
				if arg_87_1.var_.actorSpriteComps1060 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_0), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_0), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_0)))
							else
								local var_90_1 = Mathf.Lerp(iter_90_1.color.r, 1, (arg_87_1.time_ - 0) / var_90_0)

								iter_90_1.color = Color.New(var_90_1, var_90_1, var_90_1)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1060"]) and arg_87_1.var_.actorSpriteComps1060 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1060 = nil
			end

			local var_90_2 = arg_87_1.actors_["1060"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1060 = var_90_2.localPosition
				var_90_2.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1060", 3)

				for iter_90_4 = 0, var_90_2.childCount - 1 do
					local var_90_3 = var_90_2:GetChild(iter_90_4)

					if var_90_3.name == "split_5" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_87_1.time_ - 0) / var_90_4)
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_90_5 = 0
			local var_90_6 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_7 = arg_87_1:GetWordFromCfg(417201020)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 18 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 18)

				if (18 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 18)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201020", "story_v_out_417201.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201020", "story_v_out_417201.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_417201", "417201020", "story_v_out_417201.awb")

						arg_87_1:RecordAudio("417201020", var_90_12)
						arg_87_1:RecordAudio("417201020", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_417201", "417201020", "story_v_out_417201.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_417201", "417201020", "story_v_out_417201.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play417201021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 417201021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play417201022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1060 = arg_91_1.actors_["1060"].transform.localPosition
				arg_91_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1060", 7)

				for iter_94_0 = 0, arg_91_1.actors_["1060"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1060"].transform:GetChild(iter_94_0)

					if var_94_0.name == "" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_94_2 = 0
			local var_94_3 = 0.8

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(417201021).content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 32 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 32)

				if (32 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_4) / 32)) > 0 and var_94_3 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_7 and arg_91_1.time_ < var_94_2 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play417201022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 417201022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play417201023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0.766666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 0.766666666666667 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clothhit", "")
			end

			local var_98_1 = 0
			local var_98_2 = 1.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(417201022).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 59 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 59)

				if (59 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 59)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play417201023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 417201023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play417201024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.675

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(417201023).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 67 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 67)

				if (67 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 67)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play417201024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 417201024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play417201025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0.05 < arg_103_1.time_ and arg_103_1.time_ <= 0.05 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_106_1 = 0
			local var_106_2 = 1.425

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(417201024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 57 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 57)

				if (57 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 57)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play417201025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 417201025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play417201026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.6

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(417201025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 24 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 24)

				if (24 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 24)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play417201026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 417201026
		arg_111_1.duration_ = 4.47

		local var_111_0 = {
			zh = 3.733,
			ja = 4.466
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
				arg_111_0:Play417201027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1060"]) and arg_111_1.var_.actorSpriteComps1060 == nil then
				arg_111_1.var_.actorSpriteComps1060 = arg_111_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1060"]) then
				if arg_111_1.var_.actorSpriteComps1060 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1060"]) and arg_111_1.var_.actorSpriteComps1060 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1060 = nil
			end

			local var_114_2 = arg_111_1.actors_["1060"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1060 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1060", 3)

				for iter_114_4 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_4)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_114_5 = 0
			local var_114_6 = 0.425

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(417201026)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 17 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 17)

				if (17 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 17)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201026", "story_v_out_417201.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201026", "story_v_out_417201.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_417201", "417201026", "story_v_out_417201.awb")

						arg_111_1:RecordAudio("417201026", var_114_12)
						arg_111_1:RecordAudio("417201026", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_417201", "417201026", "story_v_out_417201.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_417201", "417201026", "story_v_out_417201.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play417201027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 417201027
		arg_115_1.duration_ = 7.4

		local var_115_0 = {
			zh = 3.866,
			ja = 7.4
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
				arg_115_0:Play417201028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["10128"] == nil then
				local var_118_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_118_0) then
					local var_118_1 = Object.Instantiate(var_118_0, arg_115_1.canvasGo_.transform)

					var_118_1.transform:SetSiblingIndex(1)

					var_118_1.name = "10128"
					var_118_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_["10128"] = var_118_1

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs((var_118_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_2 = arg_115_1.actors_["10128"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10128 == nil then
				arg_115_1.var_.actorSpriteComps10128 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10128 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10128 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_118_5 then
						iter_118_5.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10128 = nil
			end

			local var_118_5 = arg_115_1.actors_["1060"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps1060 == nil then
				arg_115_1.var_.actorSpriteComps1060 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps1060 then
					for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_118_7 then
							if arg_115_1.isInRecall_ then
								iter_118_7.color = Color.New(Mathf.Lerp(iter_118_7.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_6), Mathf.Lerp(iter_118_7.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_6), (Mathf.Lerp(iter_118_7.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_6)))
							else
								local var_118_7 = Mathf.Lerp(iter_118_7.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_6)

								iter_118_7.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps1060 then
				for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_118_9 then
						iter_118_9.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1060 = nil
			end

			local var_118_8 = arg_115_1.actors_["1060"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1060 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1060", 2)

				for iter_118_10 = 0, var_118_8.childCount - 1 do
					local var_118_9 = var_118_8:GetChild(iter_118_10)

					if var_118_9.name == "" or not string.find(var_118_9.name, "split") then
						var_118_9.gameObject:SetActive(true)
					else
						var_118_9.gameObject:SetActive(false)
					end
				end
			end

			local var_118_10 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_10 then
				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_115_1.time_ - 0) / var_118_10)
			end

			if arg_115_1.time_ >= 0 + var_118_10 and arg_115_1.time_ < 0 + var_118_10 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_118_11 = arg_115_1.actors_["10128"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10128 = var_118_11.localPosition
				var_118_11.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10128", 4)

				for iter_118_11 = 0, var_118_11.childCount - 1 do
					local var_118_12 = var_118_11:GetChild(iter_118_11)

					if var_118_12.name == "split_2" or not string.find(var_118_12.name, "split") then
						var_118_12.gameObject:SetActive(true)
					else
						var_118_12.gameObject:SetActive(false)
					end
				end
			end

			local var_118_13 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_13 then
				var_118_11.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_115_1.time_ - 0) / var_118_13)
			end

			if arg_115_1.time_ >= 0 + var_118_13 and arg_115_1.time_ < 0 + var_118_13 + arg_118_0 then
				var_118_11.localPosition = Vector3.New(390, -347, -300)
			end

			local var_118_14 = 0
			local var_118_15 = 0.55

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_16 = arg_115_1:GetWordFromCfg(417201027)
				local var_118_17 = arg_115_1:FormatText(var_118_16.content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 22 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 22)

				if (22 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 22)) > 0 and var_118_15 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201027", "story_v_out_417201.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_417201", "417201027", "story_v_out_417201.awb") / 1000

					if var_118_20 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_14
					end

					if var_118_16.prefab_name ~= "" and arg_115_1.actors_[var_118_16.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_16.prefab_name].transform, "story_v_out_417201", "417201027", "story_v_out_417201.awb")

						arg_115_1:RecordAudio("417201027", var_118_21)
						arg_115_1:RecordAudio("417201027", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_417201", "417201027", "story_v_out_417201.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_417201", "417201027", "story_v_out_417201.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_22 and arg_115_1.time_ < var_118_14 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play417201028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 417201028
		arg_119_1.duration_ = 2.3

		local var_119_0 = {
			zh = 0.999999999999,
			ja = 2.3
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
				arg_119_0:Play417201029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1060"]) and arg_119_1.var_.actorSpriteComps1060 == nil then
				arg_119_1.var_.actorSpriteComps1060 = arg_119_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1060"]) then
				if arg_119_1.var_.actorSpriteComps1060 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1060"]) and arg_119_1.var_.actorSpriteComps1060 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1060 = nil
			end

			local var_122_2 = arg_119_1.actors_["10128"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10128 == nil then
				arg_119_1.var_.actorSpriteComps10128 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10128 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								iter_122_5.color = Color.New(Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_5.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_5.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10128 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10128 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.075

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(417201028)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 3 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 3)

				if (3 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 3)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201028", "story_v_out_417201.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201028", "story_v_out_417201.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_417201", "417201028", "story_v_out_417201.awb")

						arg_119_1:RecordAudio("417201028", var_122_12)
						arg_119_1:RecordAudio("417201028", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_417201", "417201028", "story_v_out_417201.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_417201", "417201028", "story_v_out_417201.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play417201029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 417201029
		arg_123_1.duration_ = 7.4

		local var_123_0 = {
			zh = 5.5,
			ja = 7.4
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
				arg_123_0:Play417201030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10128"]) and arg_123_1.var_.actorSpriteComps10128 == nil then
				arg_123_1.var_.actorSpriteComps10128 = arg_123_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10128"]) then
				if arg_123_1.var_.actorSpriteComps10128 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 1, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10128"]) and arg_123_1.var_.actorSpriteComps10128 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10128 = nil
			end

			local var_126_2 = arg_123_1.actors_["1060"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1060 == nil then
				arg_123_1.var_.actorSpriteComps1060 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps1060 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_126_5 then
							if arg_123_1.isInRecall_ then
								iter_126_5.color = Color.New(Mathf.Lerp(iter_126_5.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_5.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_5.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_5.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_5.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1060 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_126_7 then
						iter_126_7.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1060 = nil
			end

			local var_126_5 = arg_123_1.actors_["10128"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10128 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10128", 4)

				for iter_126_8 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_8)

					if var_126_6.name == "split_6" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_126_8 = 0
			local var_126_9 = 0.7

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(417201029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 28 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 28)

				if (28 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 28)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201029", "story_v_out_417201.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201029", "story_v_out_417201.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_417201", "417201029", "story_v_out_417201.awb")

						arg_123_1:RecordAudio("417201029", var_126_15)
						arg_123_1:RecordAudio("417201029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_417201", "417201029", "story_v_out_417201.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_417201", "417201029", "story_v_out_417201.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play417201030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 417201030
		arg_127_1.duration_ = 8.67

		local var_127_0 = {
			zh = 8.2,
			ja = 8.666
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
				arg_127_0:Play417201031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(417201030)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 45 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 45)

				if (45 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 45)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201030", "story_v_out_417201.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_417201", "417201030", "story_v_out_417201.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_417201", "417201030", "story_v_out_417201.awb")

						arg_127_1:RecordAudio("417201030", var_130_6)
						arg_127_1:RecordAudio("417201030", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_417201", "417201030", "story_v_out_417201.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_417201", "417201030", "story_v_out_417201.awb")
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
	Play417201031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 417201031
		arg_131_1.duration_ = 7.8

		local var_131_0 = {
			zh = 4.866,
			ja = 7.8
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
				arg_131_0:Play417201032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1060"]) and arg_131_1.var_.actorSpriteComps1060 == nil then
				arg_131_1.var_.actorSpriteComps1060 = arg_131_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1060"]) then
				if arg_131_1.var_.actorSpriteComps1060 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1060"]) and arg_131_1.var_.actorSpriteComps1060 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1060 = nil
			end

			local var_134_2 = arg_131_1.actors_["10128"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10128 == nil then
				arg_131_1.var_.actorSpriteComps10128 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10128 then
					for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_134_5 then
							if arg_131_1.isInRecall_ then
								iter_134_5.color = Color.New(Mathf.Lerp(iter_134_5.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_5.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_5.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_5.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_5.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10128 then
				for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_134_7 then
						iter_134_7.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10128 = nil
			end

			local var_134_5 = arg_131_1.actors_["1060"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1060 = var_134_5.localPosition
				var_134_5.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1060", 2)

				for iter_134_8 = 0, var_134_5.childCount - 1 do
					local var_134_6 = var_134_5:GetChild(iter_134_8)

					if var_134_6.name == "split_5" or not string.find(var_134_6.name, "split") then
						var_134_6.gameObject:SetActive(true)
					else
						var_134_6.gameObject:SetActive(false)
					end
				end
			end

			local var_134_7 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_131_1.time_ - 0) / var_134_7)
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_134_8 = 0
			local var_134_9 = 0.55

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(417201031)
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

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201031", "story_v_out_417201.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201031", "story_v_out_417201.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_417201", "417201031", "story_v_out_417201.awb")

						arg_131_1:RecordAudio("417201031", var_134_15)
						arg_131_1:RecordAudio("417201031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_417201", "417201031", "story_v_out_417201.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_417201", "417201031", "story_v_out_417201.awb")
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
				actorName = "1060",
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
	Play417201032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 417201032
		arg_135_1.duration_ = 1.47

		local var_135_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_135_0:Play417201033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10128"]) and arg_135_1.var_.actorSpriteComps10128 == nil then
				arg_135_1.var_.actorSpriteComps10128 = arg_135_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10128"]) then
				if arg_135_1.var_.actorSpriteComps10128 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10128"]) and arg_135_1.var_.actorSpriteComps10128 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10128 = nil
			end

			local var_138_2 = arg_135_1.actors_["1060"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1060 == nil then
				arg_135_1.var_.actorSpriteComps1060 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps1060 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps1060 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1060 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 0.075

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(417201032)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 3 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 3)

				if (3 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 3)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201032", "story_v_out_417201.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201032", "story_v_out_417201.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_417201", "417201032", "story_v_out_417201.awb")

						arg_135_1:RecordAudio("417201032", var_138_12)
						arg_135_1:RecordAudio("417201032", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_417201", "417201032", "story_v_out_417201.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_417201", "417201032", "story_v_out_417201.awb")
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
	Play417201033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 417201033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play417201034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10128"]) and arg_139_1.var_.actorSpriteComps10128 == nil then
				arg_139_1.var_.actorSpriteComps10128 = arg_139_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10128"]) then
				if arg_139_1.var_.actorSpriteComps10128 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10128"]) and arg_139_1.var_.actorSpriteComps10128 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10128 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.95

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(417201033).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 38 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 38)

				if (38 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 38)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play417201034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 417201034
		arg_143_1.duration_ = 4.53

		local var_143_0 = {
			zh = 3,
			ja = 4.533
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
				arg_143_0:Play417201035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10128"]) and arg_143_1.var_.actorSpriteComps10128 == nil then
				arg_143_1.var_.actorSpriteComps10128 = arg_143_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10128"]) then
				if arg_143_1.var_.actorSpriteComps10128 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 1, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10128"]) and arg_143_1.var_.actorSpriteComps10128 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10128 = nil
			end

			local var_146_2 = arg_143_1.actors_["10128"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10128 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10128", 4)

				for iter_146_4 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_4)

					if var_146_3.name == "split_3" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(390, -347, -300)
			end

			local var_146_5 = 0
			local var_146_6 = 0.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(417201034)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 17 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 17)

				if (17 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 17)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201034", "story_v_out_417201.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201034", "story_v_out_417201.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_417201", "417201034", "story_v_out_417201.awb")

						arg_143_1:RecordAudio("417201034", var_146_12)
						arg_143_1:RecordAudio("417201034", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_417201", "417201034", "story_v_out_417201.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_417201", "417201034", "story_v_out_417201.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_13 and arg_143_1.time_ < var_146_5 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play417201035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 417201035
		arg_147_1.duration_ = 3.8

		local var_147_0 = {
			zh = 3.8,
			ja = 2.5
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
				arg_147_0:Play417201036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1060"]) and arg_147_1.var_.actorSpriteComps1060 == nil then
				arg_147_1.var_.actorSpriteComps1060 = arg_147_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1060"]) then
				if arg_147_1.var_.actorSpriteComps1060 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1060"]) and arg_147_1.var_.actorSpriteComps1060 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1060 = nil
			end

			local var_150_2 = arg_147_1.actors_["10128"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10128 == nil then
				arg_147_1.var_.actorSpriteComps10128 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps10128 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_5.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10128 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10128 = nil
			end

			local var_150_5 = arg_147_1.actors_["1060"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1060 = var_150_5.localPosition
				var_150_5.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1060", 2)

				for iter_150_8 = 0, var_150_5.childCount - 1 do
					local var_150_6 = var_150_5:GetChild(iter_150_8)

					if var_150_6.name == "split_1" or not string.find(var_150_6.name, "split") then
						var_150_6.gameObject:SetActive(true)
					else
						var_150_6.gameObject:SetActive(false)
					end
				end
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_147_1.time_ - 0) / var_150_7)
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_150_8 = 0
			local var_150_9 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(417201035)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 20 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 20)

				if (20 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 20)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201035", "story_v_out_417201.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201035", "story_v_out_417201.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_417201", "417201035", "story_v_out_417201.awb")

						arg_147_1:RecordAudio("417201035", var_150_15)
						arg_147_1:RecordAudio("417201035", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_417201", "417201035", "story_v_out_417201.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_417201", "417201035", "story_v_out_417201.awb")
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
				actorName = "1060",
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
	Play417201036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 417201036
		arg_151_1.duration_ = 6.7

		local var_151_0 = {
			zh = 4.9,
			ja = 6.7
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
				arg_151_0:Play417201037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10128"]) and arg_151_1.var_.actorSpriteComps10128 == nil then
				arg_151_1.var_.actorSpriteComps10128 = arg_151_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10128"]) then
				if arg_151_1.var_.actorSpriteComps10128 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10128"]) and arg_151_1.var_.actorSpriteComps10128 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10128 = nil
			end

			local var_154_2 = arg_151_1.actors_["1060"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1060 == nil then
				arg_151_1.var_.actorSpriteComps1060 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps1060 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								iter_154_5.color = Color.New(Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_3), Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_3), (Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_3)))
							else
								local var_154_4 = Mathf.Lerp(iter_154_5.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_3)

								iter_154_5.color = Color.New(var_154_4, var_154_4, var_154_4)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps1060 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1060 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(417201036)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 25 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 25)

				if (25 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 25)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201036", "story_v_out_417201.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201036", "story_v_out_417201.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_417201", "417201036", "story_v_out_417201.awb")

						arg_151_1:RecordAudio("417201036", var_154_12)
						arg_151_1:RecordAudio("417201036", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_417201", "417201036", "story_v_out_417201.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_417201", "417201036", "story_v_out_417201.awb")
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
	Play417201037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 417201037
		arg_155_1.duration_ = 3.3

		local var_155_0 = {
			zh = 1.833,
			ja = 3.3
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
				arg_155_0:Play417201038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.275

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(417201037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 11 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 11)

				if (11 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 11)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201037", "story_v_out_417201.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_417201", "417201037", "story_v_out_417201.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_417201", "417201037", "story_v_out_417201.awb")

						arg_155_1:RecordAudio("417201037", var_158_6)
						arg_155_1:RecordAudio("417201037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_417201", "417201037", "story_v_out_417201.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_417201", "417201037", "story_v_out_417201.awb")
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
	Play417201038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 417201038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play417201039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_9000

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= 0 + 0.613824599888176 and arg_159_1.time_ < 0 + 0.613824599888176 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_0 = arg_159_1.actors_["1060"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1060 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1060", 7)

				for iter_162_0 = 0, var_162_0.childCount - 1 do
					local var_162_1 = var_162_0:GetChild(iter_162_0)

					if var_162_1.name == "" or not string.find(var_162_1.name, "split") then
						var_162_1.gameObject:SetActive(true)
					else
						var_162_1.gameObject:SetActive(false)
					end
				end
			end

			local var_162_2 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 then
				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_159_1.time_ - 0) / var_162_2)
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_162_3 = arg_159_1.actors_["10128"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10128 = var_162_3.localPosition
				var_162_3.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10128", 7)

				for iter_162_1 = 0, var_162_3.childCount - 1 do
					local var_162_4 = var_162_3:GetChild(iter_162_1)

					if var_162_4.name == "" or not string.find(var_162_4.name, "split") then
						var_162_4.gameObject:SetActive(true)
					else
						var_162_4.gameObject:SetActive(false)
					end
				end
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_159_1.time_ - 0) / var_162_5)
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.166666666666667 < arg_159_1.time_ and arg_159_1.time_ <= 0.166666666666667 + arg_162_0 then
				local var_162_6 = arg_159_1.var_.effect201038

				if not arg_159_1.var_.effect201038 then
					var_162_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_162_6.name = "201038"
					arg_159_1.var_.effect201038 = var_162_6
				else
					var_162_6.transform:SetParent(var_162_9000)
				end

				var_162_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_162_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_162_8 = manager.ui.mainCamera.transform

			if 0.266 < arg_159_1.time_ and arg_159_1.time_ <= 0.266 + arg_162_0 then
				arg_159_1.var_.shakeOldPos = var_162_8.localPosition
			end

			local var_162_9 = 0.434

			if 0.266 <= arg_159_1.time_ and arg_159_1.time_ < 0.266 + var_162_9 then
				local var_162_10, var_162_11 = math.modf((arg_159_1.time_ - 0.266) / 0.066)

				var_162_8.localPosition = Vector3.New(var_162_11 * 0.13, var_162_11 * 0.13, var_162_11 * 0.13) + arg_159_1.var_.shakeOldPos
			end

			if arg_159_1.time_ >= 0.266 + var_162_9 and arg_159_1.time_ < 0.266 + var_162_9 + arg_162_0 then
				var_162_8.localPosition = arg_159_1.var_.shakeOldPos
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if 0.266 < arg_159_1.time_ and arg_159_1.time_ <= 0.266 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_162_14 = 0
			local var_162_15 = 1.675

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_16 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(417201038).content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_18 = 67 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_16) / 67)

				if (67 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_16) / 67)) > 0 and var_162_15 < var_162_18 then
					arg_159_1.talkMaxDuration = var_162_18

					if var_162_18 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_14
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_19 = math.max(var_162_15, arg_159_1.talkMaxDuration)

			if var_162_14 <= arg_159_1.time_ and arg_159_1.time_ < var_162_14 + var_162_19 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_14) / var_162_19

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_14 + var_162_19 and arg_159_1.time_ < var_162_14 + var_162_19 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play417201039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 417201039
		arg_163_1.duration_ = 4.1

		local var_163_0 = {
			zh = 1.3,
			ja = 4.1
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
				arg_163_0:Play417201040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1060"]) and arg_163_1.var_.actorSpriteComps1060 == nil then
				arg_163_1.var_.actorSpriteComps1060 = arg_163_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1060"]) then
				if arg_163_1.var_.actorSpriteComps1060 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1060"]) and arg_163_1.var_.actorSpriteComps1060 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1060 = nil
			end

			local var_166_2 = arg_163_1.actors_["1060"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1060 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1060", 3)

				for iter_166_4 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_4)

					if var_166_3.name == "split_3" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_163_1.time_ - 0) / var_166_4)
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_166_5 = 0
			local var_166_6 = 0.15

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_5 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_7 = arg_163_1:GetWordFromCfg(417201039)
				local var_166_8 = arg_163_1:FormatText(var_166_7.content)

				arg_163_1.text_.text = var_166_8

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_10 = 6 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 6)

				if (6 <= 0 and var_166_6 or var_166_6 * (utf8.len(var_166_8) / 6)) > 0 and var_166_6 < var_166_10 then
					arg_163_1.talkMaxDuration = var_166_10

					if var_166_10 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_5
					end
				end

				arg_163_1.text_.text = var_166_8
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201039", "story_v_out_417201.awb") ~= 0 then
					local var_166_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201039", "story_v_out_417201.awb") / 1000

					if var_166_11 + var_166_5 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_5
					end

					if var_166_7.prefab_name ~= "" and arg_163_1.actors_[var_166_7.prefab_name] ~= nil then
						local var_166_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_7.prefab_name].transform, "story_v_out_417201", "417201039", "story_v_out_417201.awb")

						arg_163_1:RecordAudio("417201039", var_166_12)
						arg_163_1:RecordAudio("417201039", var_166_12)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_417201", "417201039", "story_v_out_417201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_417201", "417201039", "story_v_out_417201.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_13 = math.max(var_166_6, arg_163_1.talkMaxDuration)

			if var_166_5 <= arg_163_1.time_ and arg_163_1.time_ < var_166_5 + var_166_13 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_5) / var_166_13

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_5 + var_166_13 and arg_163_1.time_ < var_166_5 + var_166_13 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play417201040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 417201040
		arg_167_1.duration_ = 3.43

		local var_167_0 = {
			zh = 1.766,
			ja = 3.433
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
				arg_167_0:Play417201041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10128"]) and arg_167_1.var_.actorSpriteComps10128 == nil then
				arg_167_1.var_.actorSpriteComps10128 = arg_167_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10128"]) then
				if arg_167_1.var_.actorSpriteComps10128 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10128"]) and arg_167_1.var_.actorSpriteComps10128 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10128 = nil
			end

			local var_170_2 = arg_167_1.actors_["1060"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1060 == nil then
				arg_167_1.var_.actorSpriteComps1060 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps1060 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps1060 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1060 = nil
			end

			local var_170_5 = arg_167_1.actors_["10128"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10128 = var_170_5.localPosition
				var_170_5.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10128", 4)

				for iter_170_8 = 0, var_170_5.childCount - 1 do
					local var_170_6 = var_170_5:GetChild(iter_170_8)

					if var_170_6.name == "split_6" or not string.find(var_170_6.name, "split") then
						var_170_6.gameObject:SetActive(true)
					else
						var_170_6.gameObject:SetActive(false)
					end
				end
			end

			local var_170_7 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_167_1.time_ - 0) / var_170_7)
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_170_8 = arg_167_1.actors_["1060"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1060 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1060", 2)

				for iter_170_9 = 0, var_170_8.childCount - 1 do
					local var_170_9 = var_170_8:GetChild(iter_170_9)

					if var_170_9.name == "" or not string.find(var_170_9.name, "split") then
						var_170_9.gameObject:SetActive(true)
					else
						var_170_9.gameObject:SetActive(false)
					end
				end
			end

			local var_170_10 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_10 then
				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_167_1.time_ - 0) / var_170_10)
			end

			if arg_167_1.time_ >= 0 + var_170_10 and arg_167_1.time_ < 0 + var_170_10 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_170_11 = 0
			local var_170_12 = 0.225

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_13 = arg_167_1:GetWordFromCfg(417201040)
				local var_170_14 = arg_167_1:FormatText(var_170_13.content)

				arg_167_1.text_.text = var_170_14

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 9 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 9)

				if (9 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 9)) > 0 and var_170_12 < var_170_16 then
					arg_167_1.talkMaxDuration = var_170_16

					if var_170_16 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_14
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201040", "story_v_out_417201.awb") ~= 0 then
					local var_170_17 = manager.audio:GetVoiceLength("story_v_out_417201", "417201040", "story_v_out_417201.awb") / 1000

					if var_170_17 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_11
					end

					if var_170_13.prefab_name ~= "" and arg_167_1.actors_[var_170_13.prefab_name] ~= nil then
						local var_170_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_13.prefab_name].transform, "story_v_out_417201", "417201040", "story_v_out_417201.awb")

						arg_167_1:RecordAudio("417201040", var_170_18)
						arg_167_1:RecordAudio("417201040", var_170_18)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_417201", "417201040", "story_v_out_417201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_417201", "417201040", "story_v_out_417201.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_19 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_19 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_19

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_19 and arg_167_1.time_ < var_170_11 + var_170_19 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play417201041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 417201041
		arg_171_1.duration_ = 3.87

		local var_171_0 = {
			zh = 1.666,
			ja = 3.866
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
				arg_171_0:Play417201042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1060"]) and arg_171_1.var_.actorSpriteComps1060 == nil then
				arg_171_1.var_.actorSpriteComps1060 = arg_171_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1060"]) then
				if arg_171_1.var_.actorSpriteComps1060 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1060"]) and arg_171_1.var_.actorSpriteComps1060 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1060 = nil
			end

			local var_174_2 = arg_171_1.actors_["10128"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10128 == nil then
				arg_171_1.var_.actorSpriteComps10128 = var_174_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_3 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.actorSpriteComps10128 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_3), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_3), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_3)))
							else
								local var_174_4 = Mathf.Lerp(iter_174_5.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_3)

								iter_174_5.color = Color.New(var_174_4, var_174_4, var_174_4)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.actorSpriteComps10128 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10128 = nil
			end

			local var_174_5 = 0
			local var_174_6 = 0.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(417201041)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 8 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 8)

				if (8 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 8)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201041", "story_v_out_417201.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201041", "story_v_out_417201.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_417201", "417201041", "story_v_out_417201.awb")

						arg_171_1:RecordAudio("417201041", var_174_12)
						arg_171_1:RecordAudio("417201041", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_417201", "417201041", "story_v_out_417201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_417201", "417201041", "story_v_out_417201.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play417201042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 417201042
		arg_175_1.duration_ = 2.63

		local var_175_0 = {
			zh = 2,
			ja = 2.633
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
				arg_175_0:Play417201043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10128"]) and arg_175_1.var_.actorSpriteComps10128 == nil then
				arg_175_1.var_.actorSpriteComps10128 = arg_175_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10128"]) then
				if arg_175_1.var_.actorSpriteComps10128 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10128"]) and arg_175_1.var_.actorSpriteComps10128 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10128 = nil
			end

			local var_178_2 = arg_175_1.actors_["1060"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1060 == nil then
				arg_175_1.var_.actorSpriteComps1060 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1060 then
					for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_178_5 then
							if arg_175_1.isInRecall_ then
								iter_178_5.color = Color.New(Mathf.Lerp(iter_178_5.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_5.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_5.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_5.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_5.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1060 then
				for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_178_7 then
						iter_178_7.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1060 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 0.2

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(417201042)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 8 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 8)

				if (8 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 8)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201042", "story_v_out_417201.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_417201", "417201042", "story_v_out_417201.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_417201", "417201042", "story_v_out_417201.awb")

						arg_175_1:RecordAudio("417201042", var_178_12)
						arg_175_1:RecordAudio("417201042", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_417201", "417201042", "story_v_out_417201.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_417201", "417201042", "story_v_out_417201.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_13 and arg_175_1.time_ < var_178_5 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play417201043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 417201043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play417201044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10128"]) and arg_179_1.var_.actorSpriteComps10128 == nil then
				arg_179_1.var_.actorSpriteComps10128 = arg_179_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10128"]) then
				if arg_179_1.var_.actorSpriteComps10128 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10128"]) and arg_179_1.var_.actorSpriteComps10128 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10128 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 1.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(417201043).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 51 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 51)

				if (51 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 51)) > 0 and var_182_3 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_7 and arg_179_1.time_ < var_182_2 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play417201044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 417201044
		arg_183_1.duration_ = 1.9

		local var_183_0 = {
			zh = 1.2,
			ja = 1.9
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
				arg_183_0:Play417201045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10128"]) and arg_183_1.var_.actorSpriteComps10128 == nil then
				arg_183_1.var_.actorSpriteComps10128 = arg_183_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10128"]) then
				if arg_183_1.var_.actorSpriteComps10128 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10128"]) and arg_183_1.var_.actorSpriteComps10128 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10128 = nil
			end

			local var_186_2 = arg_183_1.actors_["1060"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1060 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1060", 2)

				for iter_186_4 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_4)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_186_5 = arg_183_1.actors_["10128"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10128 = var_186_5.localPosition
				var_186_5.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10128", 4)

				for iter_186_5 = 0, var_186_5.childCount - 1 do
					local var_186_6 = var_186_5:GetChild(iter_186_5)

					if var_186_6.name == "" or not string.find(var_186_6.name, "split") then
						var_186_6.gameObject:SetActive(true)
					else
						var_186_6.gameObject:SetActive(false)
					end
				end
			end

			local var_186_7 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_183_1.time_ - 0) / var_186_7)
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_186_8 = 0
			local var_186_9 = 0.15

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(417201044)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 6 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 6)

				if (6 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 6)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201044", "story_v_out_417201.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201044", "story_v_out_417201.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_417201", "417201044", "story_v_out_417201.awb")

						arg_183_1:RecordAudio("417201044", var_186_15)
						arg_183_1:RecordAudio("417201044", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_417201", "417201044", "story_v_out_417201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_417201", "417201044", "story_v_out_417201.awb")
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

		arg_183_1:InitPlayNodeList()
	end,
	Play417201045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 417201045
		arg_187_1.duration_ = 4.3

		local var_187_0 = {
			zh = 2.3,
			ja = 4.3
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
			arg_187_1.auto_ = false
		end

		function arg_187_1.playNext_(arg_189_0)
			arg_187_1.onStoryFinished_()
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1060"]) and arg_187_1.var_.actorSpriteComps1060 == nil then
				arg_187_1.var_.actorSpriteComps1060 = arg_187_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1060"]) then
				if arg_187_1.var_.actorSpriteComps1060 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 1, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1060"]) and arg_187_1.var_.actorSpriteComps1060 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1060 = nil
			end

			local var_190_2 = arg_187_1.actors_["10128"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10128 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10128", 7)

				for iter_190_4 = 0, var_190_2.childCount - 1 do
					local var_190_3 = var_190_2:GetChild(iter_190_4)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_190_5 = arg_187_1.actors_["1060"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1060 = var_190_5.localPosition
				var_190_5.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1060", 3)

				for iter_190_5 = 0, var_190_5.childCount - 1 do
					local var_190_6 = var_190_5:GetChild(iter_190_5)

					if var_190_6.name == "split_1" or not string.find(var_190_6.name, "split") then
						var_190_6.gameObject:SetActive(true)
					else
						var_190_6.gameObject:SetActive(false)
					end
				end
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_5.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_187_1.time_ - 0) / var_190_7)
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_5.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_190_8 = 0
			local var_190_9 = 0.25

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(417201045)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 10 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 10)

				if (10 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 10)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417201", "417201045", "story_v_out_417201.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_417201", "417201045", "story_v_out_417201.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_417201", "417201045", "story_v_out_417201.awb")

						arg_187_1:RecordAudio("417201045", var_190_15)
						arg_187_1:RecordAudio("417201045", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_417201", "417201045", "story_v_out_417201.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_417201", "417201045", "story_v_out_417201.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I05c"
	},
	voices = {
		"story_v_out_417201.awb"
	}
}
