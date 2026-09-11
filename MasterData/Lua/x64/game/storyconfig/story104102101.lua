return {
	Play410211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST66 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST66")
				var_4_0.name = "ST66"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST66 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST66

				arg_1_1.bgs_.ST66.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST66" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 1.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(410211001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 42 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 42)

				if (42 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 42)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410211002
		arg_9_1.duration_ = 15.23

		local var_9_0 = {
			ja = 15.233,
			CriLanguages = 9.166,
			zh = 9.166
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1061"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "1061"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["1061"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["1061"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1061 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1061", 2)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_12_5 = "10059"

			if arg_9_1.actors_["10059"] == nil then
				local var_12_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_12_6) then
					local var_12_7 = Object.Instantiate(var_12_6, arg_9_1.canvasGo_.transform)

					var_12_7.transform:SetSiblingIndex(1)

					var_12_7.name = var_12_5
					var_12_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_5] = var_12_7

					if arg_9_1.isInRecall_ then
						for iter_12_3, iter_12_4 in ipairs((var_12_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_4.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_8 = arg_9_1.actors_["10059"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10059 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10059", 4)

				for iter_12_5 = 0, var_12_8.childCount - 1 do
					local var_12_9 = var_12_8:GetChild(iter_12_5)

					if var_12_9.name == "" or not string.find(var_12_9.name, "split") then
						var_12_9.gameObject:SetActive(true)
					else
						var_12_9.gameObject:SetActive(false)
					end
				end
			end

			local var_12_10 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_9_1.time_ - 0) / var_12_10)
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(390, -530, 35)
			end

			local var_12_11 = arg_9_1.actors_["1061"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_12 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 and not isNil(var_12_11) then
				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								iter_12_7.color = Color.New(Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_12), Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_12), (Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_12)))
							else
								local var_12_13 = Mathf.Lerp(iter_12_7.color.r, 1, (arg_9_1.time_ - 0) / var_12_12)

								iter_12_7.color = Color.New(var_12_13, var_12_13, var_12_13)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_9 then
						iter_12_9.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_14 = arg_9_1.actors_["10059"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.actorSpriteComps10059 == nil then
				arg_9_1.var_.actorSpriteComps10059 = var_12_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_15 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 and not isNil(var_12_14) then
				if arg_9_1.var_.actorSpriteComps10059 then
					for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_12_11 then
							if arg_9_1.isInRecall_ then
								iter_12_11.color = Color.New(Mathf.Lerp(iter_12_11.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_15), Mathf.Lerp(iter_12_11.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_15), (Mathf.Lerp(iter_12_11.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_15)))
							else
								local var_12_16 = Mathf.Lerp(iter_12_11.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_15)

								iter_12_11.color = Color.New(var_12_16, var_12_16, var_12_16)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.actorSpriteComps10059 then
				for iter_12_12, iter_12_13 in pairs(arg_9_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_12_13 then
						iter_12_13.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10059 = nil
			end

			local var_12_17 = 0
			local var_12_18 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_19 = arg_9_1:GetWordFromCfg(410211002)
				local var_12_20 = arg_9_1:FormatText(var_12_19.content)

				arg_9_1.text_.text = var_12_20

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_22 = 39 <= 0 and var_12_18 or var_12_18 * (utf8.len(var_12_20) / 39)

				if (39 <= 0 and var_12_18 or var_12_18 * (utf8.len(var_12_20) / 39)) > 0 and var_12_18 < var_12_22 then
					arg_9_1.talkMaxDuration = var_12_22

					if var_12_22 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_17
					end
				end

				arg_9_1.text_.text = var_12_20
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") ~= 0 then
					local var_12_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") / 1000

					if var_12_23 + var_12_17 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_23 + var_12_17
					end

					if var_12_19.prefab_name ~= "" and arg_9_1.actors_[var_12_19.prefab_name] ~= nil then
						local var_12_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_19.prefab_name].transform, "story_v_out_410211", "410211002", "story_v_out_410211.awb")

						arg_9_1:RecordAudio("410211002", var_12_24)
						arg_9_1:RecordAudio("410211002", var_12_24)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410211", "410211002", "story_v_out_410211.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410211", "410211002", "story_v_out_410211.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_25 = math.max(var_12_18, arg_9_1.talkMaxDuration)

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_25 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_17) / var_12_25

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_17 + var_12_25 and arg_9_1.time_ < var_12_17 + var_12_25 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play410211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410211003
		arg_13_1.duration_ = 1.9

		local var_13_0 = {
			ja = 1.6,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_13_0:Play410211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = arg_13_1.actors_["1061"].transform.localPosition
				arg_13_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 2)

				for iter_16_0 = 0, arg_13_1.actors_["1061"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1061"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_16_2 = arg_13_1.actors_["10059"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10059 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10059", 4)

				for iter_16_1 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_1)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_16_5 = arg_13_1.actors_["1061"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								iter_16_3.color = Color.New(Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_3.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_3.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_8 = arg_13_1.actors_["10059"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10059 == nil then
				arg_13_1.var_.actorSpriteComps10059 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.actorSpriteComps10059 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								iter_16_7.color = Color.New(Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_9), Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_9), (Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_9)))
							else
								local var_16_10 = Mathf.Lerp(iter_16_7.color.r, 1, (arg_13_1.time_ - 0) / var_16_9)

								iter_16_7.color = Color.New(var_16_10, var_16_10, var_16_10)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10059 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_16_9 then
						iter_16_9.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10059 = nil
			end

			local var_16_11 = 0
			local var_16_12 = 0.15

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(410211003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 6 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 6)

				if (6 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 6)) > 0 and var_16_12 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") / 1000

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_410211", "410211003", "story_v_out_410211.awb")

						arg_13_1:RecordAudio("410211003", var_16_18)
						arg_13_1:RecordAudio("410211003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410211", "410211003", "story_v_out_410211.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410211", "410211003", "story_v_out_410211.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_19 and arg_13_1.time_ < var_16_11 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410211004
		arg_17_1.duration_ = 17.5

		local var_17_0 = {
			ja = 17.5,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_17_0:Play410211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = arg_17_1.actors_["1061"].transform.localPosition
				arg_17_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 2)

				for iter_20_0 = 0, arg_17_1.actors_["1061"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["1061"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_20_2 = arg_17_1.actors_["10059"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10059 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10059", 4)

				for iter_20_1 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_1)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_20_5 = arg_17_1.actors_["1061"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								iter_20_3.color = Color.New(Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_3.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_3.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_8 = arg_17_1.actors_["10059"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10059 == nil then
				arg_17_1.var_.actorSpriteComps10059 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 and not isNil(var_20_8) then
				if arg_17_1.var_.actorSpriteComps10059 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								iter_20_7.color = Color.New(Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_9), Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_9), (Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_9)))
							else
								local var_20_10 = Mathf.Lerp(iter_20_7.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_9)

								iter_20_7.color = Color.New(var_20_10, var_20_10, var_20_10)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps10059 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_20_9 then
						iter_20_9.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10059 = nil
			end

			local var_20_11 = 0
			local var_20_12 = 1.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(410211004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 49 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 49)

				if (49 <= 0 and var_20_12 or var_20_12 * (utf8.len(var_20_14) / 49)) > 0 and var_20_12 < var_20_16 then
					arg_17_1.talkMaxDuration = var_20_16

					if var_20_16 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") ~= 0 then
					local var_20_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") / 1000

					if var_20_17 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_11
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_410211", "410211004", "story_v_out_410211.awb")

						arg_17_1:RecordAudio("410211004", var_20_18)
						arg_17_1:RecordAudio("410211004", var_20_18)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410211", "410211004", "story_v_out_410211.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410211", "410211004", "story_v_out_410211.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_19 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_19

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_19 and arg_17_1.time_ < var_20_11 + var_20_19 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play410211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410211005
		arg_21_1.duration_ = 4.4

		local var_21_0 = {
			ja = 4.4,
			CriLanguages = 1.9,
			zh = 1.9
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
				arg_21_0:Play410211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = arg_21_1.actors_["1061"].transform.localPosition
				arg_21_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 2)

				for iter_24_0 = 0, arg_21_1.actors_["1061"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["1061"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_24_2 = arg_21_1.actors_["10059"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10059 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10059", 4)

				for iter_24_1 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_1)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_24_5 = arg_21_1.actors_["1061"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_3.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_3.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_8 = arg_21_1.actors_["10059"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								iter_24_7.color = Color.New(Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_9), Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_9), (Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_9)))
							else
								local var_24_10 = Mathf.Lerp(iter_24_7.color.r, 1, (arg_21_1.time_ - 0) / var_24_9)

								iter_24_7.color = Color.New(var_24_10, var_24_10, var_24_10)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_9 then
						iter_24_9.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_11 = 0
			local var_24_12 = 0.225

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(410211005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 9 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 9)

				if (9 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 9)) > 0 and var_24_12 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") / 1000

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_410211", "410211005", "story_v_out_410211.awb")

						arg_21_1:RecordAudio("410211005", var_24_18)
						arg_21_1:RecordAudio("410211005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410211", "410211005", "story_v_out_410211.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410211", "410211005", "story_v_out_410211.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = math.max(var_24_12, arg_21_1.talkMaxDuration)

			if var_24_11 <= arg_21_1.time_ and arg_21_1.time_ < var_24_11 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_11) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_11 + var_24_19 and arg_21_1.time_ < var_24_11 + var_24_19 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play410211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410211006
		arg_25_1.duration_ = 7.27

		local var_25_0 = {
			ja = 7.266,
			CriLanguages = 3.833,
			zh = 3.833
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
				arg_25_0:Play410211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = arg_25_1.actors_["1061"].transform.localPosition
				arg_25_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 2)

				for iter_28_0 = 0, arg_25_1.actors_["1061"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1061"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_28_2 = arg_25_1.actors_["10059"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10059 = var_28_2.localPosition
				var_28_2.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10059", 4)

				for iter_28_1 = 0, var_28_2.childCount - 1 do
					local var_28_3 = var_28_2:GetChild(iter_28_1)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_2.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_25_1.time_ - 0) / var_28_4)
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_28_5 = arg_25_1.actors_["1061"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_6 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_3 then
							if arg_25_1.isInRecall_ then
								iter_28_3.color = Color.New(Mathf.Lerp(iter_28_3.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_6), Mathf.Lerp(iter_28_3.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_6), (Mathf.Lerp(iter_28_3.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_6)))
							else
								local var_28_7 = Mathf.Lerp(iter_28_3.color.r, 1, (arg_25_1.time_ - 0) / var_28_6)

								iter_28_3.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_5 then
						iter_28_5.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_8 = arg_25_1.actors_["10059"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 and not isNil(var_28_8) then
				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_28_7 then
							if arg_25_1.isInRecall_ then
								iter_28_7.color = Color.New(Mathf.Lerp(iter_28_7.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_9), Mathf.Lerp(iter_28_7.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_9), (Mathf.Lerp(iter_28_7.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_9)))
							else
								local var_28_10 = Mathf.Lerp(iter_28_7.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_9)

								iter_28_7.color = Color.New(var_28_10, var_28_10, var_28_10)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_9 then
						iter_28_9.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_11 = 0
			local var_28_12 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(410211006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 19 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 19)

				if (19 <= 0 and var_28_12 or var_28_12 * (utf8.len(var_28_14) / 19)) > 0 and var_28_12 < var_28_16 then
					arg_25_1.talkMaxDuration = var_28_16

					if var_28_16 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") ~= 0 then
					local var_28_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") / 1000

					if var_28_17 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_11
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_410211", "410211006", "story_v_out_410211.awb")

						arg_25_1:RecordAudio("410211006", var_28_18)
						arg_25_1:RecordAudio("410211006", var_28_18)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410211", "410211006", "story_v_out_410211.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410211", "410211006", "story_v_out_410211.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_19 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_19 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_19

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_19 and arg_25_1.time_ < var_28_11 + var_28_19 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410211007
		arg_29_1.duration_ = 1

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10060"] == nil then
				local var_32_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_32_0) then
					local var_32_1 = Object.Instantiate(var_32_0, arg_29_1.canvasGo_.transform)

					var_32_1.transform:SetSiblingIndex(1)

					var_32_1.name = "10060"
					var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_["10060"] = var_32_1

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs((var_32_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_2 = arg_29_1.actors_["10060"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10060 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10060", 4)

				for iter_32_2 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_2)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(390, -400, 0)
			end

			local var_32_5 = arg_29_1.actors_["10059"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10059 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10059", 7)

				for iter_32_3 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_3)

					if var_32_6.name == "" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_32_8 = arg_29_1.actors_["10060"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10060 == nil then
				arg_29_1.var_.actorSpriteComps10060 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.actorSpriteComps10060 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_9), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_9), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_9)))
							else
								local var_32_10 = Mathf.Lerp(iter_32_5.color.r, 1, (arg_29_1.time_ - 0) / var_32_9)

								iter_32_5.color = Color.New(var_32_10, var_32_10, var_32_10)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10060 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10060 = nil
			end

			local var_32_11 = arg_29_1.actors_["10059"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.actorSpriteComps10059 == nil then
				arg_29_1.var_.actorSpriteComps10059 = var_32_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_12 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_12 and not isNil(var_32_11) then
				if arg_29_1.var_.actorSpriteComps10059 then
					for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_32_9 then
							if arg_29_1.isInRecall_ then
								iter_32_9.color = Color.New(Mathf.Lerp(iter_32_9.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_12), Mathf.Lerp(iter_32_9.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_12), (Mathf.Lerp(iter_32_9.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_12)))
							else
								local var_32_13 = Mathf.Lerp(iter_32_9.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_12)

								iter_32_9.color = Color.New(var_32_13, var_32_13, var_32_13)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_12 and arg_29_1.time_ < 0 + var_32_12 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.actorSpriteComps10059 then
				for iter_32_10, iter_32_11 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_32_11 then
						iter_32_11.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10059 = nil
			end

			local var_32_14 = arg_29_1.actors_["1061"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_15 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_15 and not isNil(var_32_14) then
				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_12, iter_32_13 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_13 then
							if arg_29_1.isInRecall_ then
								iter_32_13.color = Color.New(Mathf.Lerp(iter_32_13.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_15), Mathf.Lerp(iter_32_13.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_15), (Mathf.Lerp(iter_32_13.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_15)))
							else
								local var_32_16 = Mathf.Lerp(iter_32_13.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_15)

								iter_32_13.color = Color.New(var_32_16, var_32_16, var_32_16)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_15 and arg_29_1.time_ < 0 + var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_14, iter_32_15 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_15 then
						iter_32_15.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_17 = 0
			local var_32_18 = 0.05

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(410211007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_22 = 2 <= 0 and var_32_18 or var_32_18 * (utf8.len(var_32_20) / 2)

				if (2 <= 0 and var_32_18 or var_32_18 * (utf8.len(var_32_20) / 2)) > 0 and var_32_18 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_17
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") / 1000

					if var_32_23 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_17
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_410211", "410211007", "story_v_out_410211.awb")

						arg_29_1:RecordAudio("410211007", var_32_24)
						arg_29_1:RecordAudio("410211007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410211", "410211007", "story_v_out_410211.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410211", "410211007", "story_v_out_410211.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_18, arg_29_1.talkMaxDuration)

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_17) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_17 + var_32_25 and arg_29_1.time_ < var_32_17 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410211008
		arg_33_1.duration_ = 5.07

		local var_33_0 = {
			ja = 5.066,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_33_0:Play410211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10060 = arg_33_1.actors_["10060"].transform.localPosition
				arg_33_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10060", 4)

				for iter_36_0 = 0, arg_33_1.actors_["10060"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10060"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_36_2 = arg_33_1.actors_["10060"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10060 == nil then
				arg_33_1.var_.actorSpriteComps10060 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10060 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.3

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410211008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 12 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 12)

				if (12 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 12)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410211", "410211008", "story_v_out_410211.awb")

						arg_33_1:RecordAudio("410211008", var_36_12)
						arg_33_1:RecordAudio("410211008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410211", "410211008", "story_v_out_410211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410211", "410211008", "story_v_out_410211.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410211009
		arg_37_1.duration_ = 14.93

		local var_37_0 = {
			ja = 14.933,
			CriLanguages = 9,
			zh = 9
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
				arg_37_0:Play410211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = arg_37_1.actors_["1061"].transform.localPosition
				arg_37_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 2)

				for iter_40_0 = 0, arg_37_1.actors_["1061"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1061"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_5" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_40_2 = arg_37_1.actors_["1061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								iter_40_2.color = Color.New(Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_2.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_2.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_5 = arg_37_1.actors_["10060"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps10060 == nil then
				arg_37_1.var_.actorSpriteComps10060 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps10060 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_40_6 then
							if arg_37_1.isInRecall_ then
								iter_40_6.color = Color.New(Mathf.Lerp(iter_40_6.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_6.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_6.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_6.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_6.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps10060 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_40_8 then
						iter_40_8.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10060 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(410211009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 40 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 40)

				if (40 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 40)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_410211", "410211009", "story_v_out_410211.awb")

						arg_37_1:RecordAudio("410211009", var_40_15)
						arg_37_1:RecordAudio("410211009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410211", "410211009", "story_v_out_410211.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410211", "410211009", "story_v_out_410211.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play410211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410211010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play410211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10060 = arg_41_1.actors_["10060"].transform.localPosition
				arg_41_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10060", 7)

				for iter_44_0 = 0, arg_41_1.actors_["10060"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10060"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10060, Vector3.New(0, -2000, 18), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_44_2 = arg_41_1.actors_["10060"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10060 == nil then
				arg_41_1.var_.actorSpriteComps10060 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10060 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10060 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10060 = nil
			end

			local var_44_5 = arg_41_1.actors_["1061"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 7)

				for iter_44_5 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_5)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_44_8 = 0
			local var_44_9 = 1.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(410211010).content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 69 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_10) / 69)

				if (69 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_10) / 69)) > 0 and var_44_9 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_13 and arg_41_1.time_ < var_44_8 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410211011
		arg_45_1.duration_ = 7.27

		local var_45_0 = {
			ja = 7.266,
			CriLanguages = 6.633,
			zh = 6.633
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
				arg_45_0:Play410211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10059 = arg_45_1.actors_["10059"].transform.localPosition
				arg_45_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10059", 4)

				for iter_48_0 = 0, arg_45_1.actors_["10059"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10059"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_48_2 = arg_45_1.actors_["10059"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10059 == nil then
				arg_45_1.var_.actorSpriteComps10059 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10059 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								iter_48_2.color = Color.New(Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_2.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_2.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10059 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10059 = nil
			end

			local var_48_5 = arg_45_1.actors_["1061"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = var_48_5.localPosition
				var_48_5.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 2)

				for iter_48_5 = 0, var_48_5.childCount - 1 do
					local var_48_6 = var_48_5:GetChild(iter_48_5)

					if var_48_6.name == "" or not string.find(var_48_6.name, "split") then
						var_48_6.gameObject:SetActive(true)
					else
						var_48_6.gameObject:SetActive(false)
					end
				end
			end

			local var_48_7 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_45_1.time_ - 0) / var_48_7)
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_48_8 = arg_45_1.actors_["1061"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 and not isNil(var_48_8) then
				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								iter_48_7.color = Color.New(Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_9), Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_9), (Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_9)))
							else
								local var_48_10 = Mathf.Lerp(iter_48_7.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_9)

								iter_48_7.color = Color.New(var_48_10, var_48_10, var_48_10)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_9 then
						iter_48_9.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_11 = 0
			local var_48_12 = 0.8

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(410211011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 32 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 32)

				if (32 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 32)) > 0 and var_48_12 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") ~= 0 then
					local var_48_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") / 1000

					if var_48_17 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_11
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_410211", "410211011", "story_v_out_410211.awb")

						arg_45_1:RecordAudio("410211011", var_48_18)
						arg_45_1:RecordAudio("410211011", var_48_18)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410211", "410211011", "story_v_out_410211.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410211", "410211011", "story_v_out_410211.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410211012
		arg_49_1.duration_ = 15.8

		local var_49_0 = {
			ja = 15.8,
			CriLanguages = 7.433,
			zh = 7.433
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
				arg_49_0:Play410211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = arg_49_1.actors_["1061"].transform.localPosition
				arg_49_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 2)

				for iter_52_0 = 0, arg_49_1.actors_["1061"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1061"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_52_2 = arg_49_1.actors_["1061"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 1, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_5 = arg_49_1.actors_["10059"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps10059 == nil then
				arg_49_1.var_.actorSpriteComps10059 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps10059 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								iter_52_6.color = Color.New(Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_6.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_6.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps10059 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_52_8 then
						iter_52_8.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10059 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.85

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(410211012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 34 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 34)

				if (34 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 34)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_410211", "410211012", "story_v_out_410211.awb")

						arg_49_1:RecordAudio("410211012", var_52_15)
						arg_49_1:RecordAudio("410211012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410211", "410211012", "story_v_out_410211.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410211", "410211012", "story_v_out_410211.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410211013
		arg_53_1.duration_ = 6.73

		local var_53_0 = {
			ja = 6.733,
			CriLanguages = 4.333,
			zh = 4.333
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
				arg_53_0:Play410211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10059 = arg_53_1.actors_["10059"].transform.localPosition
				arg_53_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10059", 4)

				for iter_56_0 = 0, arg_53_1.actors_["10059"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10059"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_56_2 = arg_53_1.actors_["10059"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10059 == nil then
				arg_53_1.var_.actorSpriteComps10059 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10059 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								iter_56_2.color = Color.New(Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_2.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_2.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10059 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10059 = nil
			end

			local var_56_5 = arg_53_1.actors_["1061"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_6 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_6 then
							if arg_53_1.isInRecall_ then
								iter_56_6.color = Color.New(Mathf.Lerp(iter_56_6.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_6), Mathf.Lerp(iter_56_6.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_6), (Mathf.Lerp(iter_56_6.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_6)))
							else
								local var_56_7 = Mathf.Lerp(iter_56_6.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_6)

								iter_56_6.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_8 then
						iter_56_8.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(410211013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 20 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 20)

				if (20 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 20)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_410211", "410211013", "story_v_out_410211.awb")

						arg_53_1:RecordAudio("410211013", var_56_15)
						arg_53_1:RecordAudio("410211013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410211", "410211013", "story_v_out_410211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410211", "410211013", "story_v_out_410211.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410211014
		arg_57_1.duration_ = 12.33

		local var_57_0 = {
			ja = 12.333,
			CriLanguages = 7.9,
			zh = 7.9
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
				arg_57_0:Play410211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10059 = arg_57_1.actors_["10059"].transform.localPosition
				arg_57_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10059", 4)

				for iter_60_0 = 0, arg_57_1.actors_["10059"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10059"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_60_2 = arg_57_1.actors_["10059"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10059 == nil then
				arg_57_1.var_.actorSpriteComps10059 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.034

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10059 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								iter_60_2.color = Color.New(Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_2.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_2.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10059 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10059 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.925

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(410211014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 37 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 37)

				if (37 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 37)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_410211", "410211014", "story_v_out_410211.awb")

						arg_57_1:RecordAudio("410211014", var_60_12)
						arg_57_1:RecordAudio("410211014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410211", "410211014", "story_v_out_410211.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410211", "410211014", "story_v_out_410211.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410211015
		arg_61_1.duration_ = 3.9

		local var_61_0 = {
			ja = 3.9,
			CriLanguages = 3.4,
			zh = 3.4
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
				arg_61_0:Play410211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = arg_61_1.actors_["1061"].transform.localPosition
				arg_61_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 2)

				for iter_64_0 = 0, arg_61_1.actors_["1061"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1061"].transform:GetChild(iter_64_0)

					if var_64_0.name == "split_5" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_64_2 = arg_61_1.actors_["1061"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								iter_64_2.color = Color.New(Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_2.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_2.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_4 then
						iter_64_4.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_5 = arg_61_1.actors_["10059"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10059 == nil then
				arg_61_1.var_.actorSpriteComps10059 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps10059 then
					for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_64_6 then
							if arg_61_1.isInRecall_ then
								iter_64_6.color = Color.New(Mathf.Lerp(iter_64_6.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_6.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_6.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_6.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_6.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10059 then
				for iter_64_7, iter_64_8 in pairs(arg_61_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_64_8 then
						iter_64_8.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10059 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(410211015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 10 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 10)

				if (10 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 10)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_410211", "410211015", "story_v_out_410211.awb")

						arg_61_1:RecordAudio("410211015", var_64_15)
						arg_61_1:RecordAudio("410211015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410211", "410211015", "story_v_out_410211.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410211", "410211015", "story_v_out_410211.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410211016
		arg_65_1.duration_ = 2.9

		local var_65_0 = {
			ja = 2.9,
			CriLanguages = 1.3,
			zh = 1.3
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
				arg_65_0:Play410211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = arg_65_1.actors_["10059"].transform.localPosition
				arg_65_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 4)

				for iter_68_0 = 0, arg_65_1.actors_["10059"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10059"].transform:GetChild(iter_68_0)

					if var_68_0.name == "" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_68_2 = arg_65_1.actors_["10059"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								iter_68_2.color = Color.New(Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_2.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_2.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_5 = arg_65_1.actors_["1061"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								iter_68_6.color = Color.New(Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_6.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_6.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						iter_68_8.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(410211016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 4 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 4)

				if (4 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 4)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_410211", "410211016", "story_v_out_410211.awb")

						arg_65_1:RecordAudio("410211016", var_68_15)
						arg_65_1:RecordAudio("410211016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410211", "410211016", "story_v_out_410211.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410211", "410211016", "story_v_out_410211.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410211017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10059 = arg_69_1.actors_["10059"].transform.localPosition
				arg_69_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10059", 7)

				for iter_72_0 = 0, arg_69_1.actors_["10059"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10059"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_72_2 = arg_69_1.actors_["1061"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 7)

				for iter_72_1 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_1)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_72_5 = 0
			local var_72_6 = 0.525

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(410211017).content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 21 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 21)

				if (21 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 21)) > 0 and var_72_6 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_10 and arg_69_1.time_ < var_72_5 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410211018
		arg_73_1.duration_ = 4.17

		local var_73_0 = {
			ja = 4.166,
			CriLanguages = 3.333,
			zh = 3.333
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
				arg_73_0:Play410211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = arg_73_1.actors_["10059"].transform.localPosition
				arg_73_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 4)

				for iter_76_0 = 0, arg_73_1.actors_["10059"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10059"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_76_2 = arg_73_1.actors_["10059"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								iter_76_2.color = Color.New(Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_2.color.r, 1, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_2.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_5 = arg_73_1.actors_["1061"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061 = var_76_5.localPosition
				var_76_5.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1061", 2)

				for iter_76_5 = 0, var_76_5.childCount - 1 do
					local var_76_6 = var_76_5:GetChild(iter_76_5)

					if var_76_6.name == "" or not string.find(var_76_6.name, "split") then
						var_76_6.gameObject:SetActive(true)
					else
						var_76_6.gameObject:SetActive(false)
					end
				end
			end

			local var_76_7 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_73_1.time_ - 0) / var_76_7)
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_76_8 = arg_73_1.actors_["1061"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1061 == nil then
				arg_73_1.var_.actorSpriteComps1061 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 and not isNil(var_76_8) then
				if arg_73_1.var_.actorSpriteComps1061 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								iter_76_7.color = Color.New(Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_9), Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_9), (Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_9)))
							else
								local var_76_10 = Mathf.Lerp(iter_76_7.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_9)

								iter_76_7.color = Color.New(var_76_10, var_76_10, var_76_10)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps1061 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_76_9 then
						iter_76_9.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1061 = nil
			end

			local var_76_11 = 0
			local var_76_12 = 0.35

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(410211018)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 14 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 14)

				if (14 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 14)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_410211", "410211018", "story_v_out_410211.awb")

						arg_73_1:RecordAudio("410211018", var_76_18)
						arg_73_1:RecordAudio("410211018", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410211", "410211018", "story_v_out_410211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410211", "410211018", "story_v_out_410211.awb")
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
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410211019
		arg_77_1.duration_ = 12.5

		local var_77_0 = {
			ja = 12.5,
			CriLanguages = 8,
			zh = 8
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
				arg_77_0:Play410211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if arg_77_1.bgs_.ST64a == nil then
				local var_80_0 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST64a")
				var_80_0.name = "ST64a"
				var_80_0.transform.parent = arg_77_1.stage_.transform
				var_80_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_.ST64a = var_80_0
			end

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				local var_80_1 = arg_77_1.bgs_.ST64a

				arg_77_1.bgs_.ST64a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_80_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_2 = var_80_1:GetComponent("SpriteRenderer")

				if var_80_2 and var_80_2.sprite then
					local var_80_3 = 2 * (var_80_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_80_1.transform.localScale = Vector3.New(var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, var_80_3 / var_80_2.sprite.bounds.size.y < var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x and var_80_3 * manager.ui.mainCameraCom_.aspect / var_80_2.sprite.bounds.size.x or var_80_3 / var_80_2.sprite.bounds.size.y, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST64a" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_4 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_5 = 2

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_5 then
				local var_80_6 = Color.New(0, 0, 0)

				var_80_6.a = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_4) / var_80_5)
				arg_77_1.mask_.color = var_80_6
			end

			if arg_77_1.time_ >= var_80_4 + var_80_5 and arg_77_1.time_ < var_80_4 + var_80_5 + arg_80_0 then
				local var_80_7 = Color.New(0, 0, 0)

				var_80_7.a = 1
				arg_77_1.mask_.color = var_80_7
			end

			local var_80_8 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 then
				local var_80_10 = Color.New(0, 0, 0)

				var_80_10.a = Mathf.Lerp(1, 0, (arg_77_1.time_ - var_80_8) / var_80_9)
				arg_77_1.mask_.color = var_80_10
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 then
				local var_80_11 = Color.New(0, 0, 0)

				arg_77_1.mask_.enabled = false
				var_80_11.a = 0
				arg_77_1.mask_.color = var_80_11
			end

			local var_80_12 = arg_77_1.actors_["1061"].transform

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = var_80_12.localPosition
				var_80_12.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 3)

				for iter_80_2 = 0, var_80_12.childCount - 1 do
					local var_80_13 = var_80_12:GetChild(iter_80_2)

					if var_80_13.name == "" or not string.find(var_80_13.name, "split") then
						var_80_13.gameObject:SetActive(true)
					else
						var_80_13.gameObject:SetActive(false)
					end
				end
			end

			local var_80_14 = 0.001

			if 4 <= arg_77_1.time_ and arg_77_1.time_ < 4 + var_80_14 then
				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_77_1.time_ - 4) / var_80_14)
			end

			if arg_77_1.time_ >= 4 + var_80_14 and arg_77_1.time_ < 4 + var_80_14 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(0, -490, 18)
			end

			local var_80_15 = arg_77_1.actors_["1061"]

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= 4 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_16 = 0.034

			if 4 <= arg_77_1.time_ and arg_77_1.time_ < 4 + var_80_16 and not isNil(var_80_15) then
				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_4 then
							if arg_77_1.isInRecall_ then
								iter_80_4.color = Color.New(Mathf.Lerp(iter_80_4.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 4) / var_80_16), Mathf.Lerp(iter_80_4.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 4) / var_80_16), (Mathf.Lerp(iter_80_4.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 4) / var_80_16)))
							else
								local var_80_17 = Mathf.Lerp(iter_80_4.color.r, 1, (arg_77_1.time_ - 4) / var_80_16)

								iter_80_4.color = Color.New(var_80_17, var_80_17, var_80_17)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 4 + var_80_16 and arg_77_1.time_ < 4 + var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_6 then
						iter_80_6.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_18 = arg_77_1.actors_["10059"].transform

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				arg_77_1.var_.moveOldPos10059 = var_80_18.localPosition
				var_80_18.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10059", 7)

				for iter_80_7 = 0, var_80_18.childCount - 1 do
					local var_80_19 = var_80_18:GetChild(iter_80_7)

					if var_80_19.name == "" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if 2 <= arg_77_1.time_ and arg_77_1.time_ < 2 + var_80_20 then
				var_80_18.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (arg_77_1.time_ - 2) / var_80_20)
			end

			if arg_77_1.time_ >= 2 + var_80_20 and arg_77_1.time_ < 2 + var_80_20 + arg_80_0 then
				var_80_18.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_80_21 = arg_77_1.actors_["1061"].transform

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				arg_77_1.var_.moveOldPos1061 = var_80_21.localPosition
				var_80_21.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1061", 7)

				for iter_80_8 = 0, var_80_21.childCount - 1 do
					local var_80_22 = var_80_21:GetChild(iter_80_8)

					if var_80_22.name == "" or not string.find(var_80_22.name, "split") then
						var_80_22.gameObject:SetActive(true)
					else
						var_80_22.gameObject:SetActive(false)
					end
				end
			end

			local var_80_23 = 0.001

			if 2 <= arg_77_1.time_ and arg_77_1.time_ < 2 + var_80_23 then
				var_80_21.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_77_1.time_ - 2) / var_80_23)
			end

			if arg_77_1.time_ >= 2 + var_80_23 and arg_77_1.time_ < 2 + var_80_23 + arg_80_0 then
				var_80_21.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_80_24 = 2

			arg_77_1.isInRecall_ = false

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				arg_77_1.screenFilterGo_:SetActive(true)

				arg_77_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_80_9, iter_80_10 in pairs(arg_77_1.actors_) do
					for iter_80_11, iter_80_12 in ipairs((iter_80_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_80_12.color = iter_80_12.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_80_25 = 0.0166666666666667

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_25 then
				arg_77_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_77_1.time_ - var_80_24) / var_80_25)
			end

			if arg_77_1.time_ >= var_80_24 + var_80_25 and arg_77_1.time_ < var_80_24 + var_80_25 + arg_80_0 then
				arg_77_1.screenFilterEffect_.weight = 1
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_26 = 4
			local var_80_27 = 0.475

			if 4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_28 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_28:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_29 = arg_77_1:GetWordFromCfg(410211019)
				local var_80_30 = arg_77_1:FormatText(var_80_29.content)

				arg_77_1.text_.text = var_80_30

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_32 = 19 <= 0 and var_80_27 or var_80_27 * (utf8.len(var_80_30) / 19)

				if (19 <= 0 and var_80_27 or var_80_27 * (utf8.len(var_80_30) / 19)) > 0 and var_80_27 < var_80_32 then
					arg_77_1.talkMaxDuration = var_80_32
					var_80_26 = var_80_26 + 0.3

					if var_80_32 + var_80_26 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_32 + var_80_26
					end
				end

				arg_77_1.text_.text = var_80_30
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") ~= 0 then
					local var_80_33 = manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") / 1000

					if var_80_33 + var_80_26 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_33 + var_80_26
					end

					if var_80_29.prefab_name ~= "" and arg_77_1.actors_[var_80_29.prefab_name] ~= nil then
						local var_80_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_29.prefab_name].transform, "story_v_out_410211", "410211019", "story_v_out_410211.awb")

						arg_77_1:RecordAudio("410211019", var_80_34)
						arg_77_1:RecordAudio("410211019", var_80_34)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410211", "410211019", "story_v_out_410211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410211", "410211019", "story_v_out_410211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_35 = var_80_26 + 0.3
			local var_80_36 = math.max(var_80_27, arg_77_1.talkMaxDuration)

			if var_80_26 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_36 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_35) / var_80_36

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_35 + var_80_36 and arg_77_1.time_ < var_80_35 + var_80_36 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410211020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410211020
		arg_83_1.duration_ = 8.6

		local var_83_0 = {
			ja = 6.166,
			CriLanguages = 8.6,
			zh = 8.6
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
				arg_83_0:Play410211021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(410211020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 40 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 40)

				if (40 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 40)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_410211", "410211020", "story_v_out_410211.awb")

						arg_83_1:RecordAudio("410211020", var_86_6)
						arg_83_1:RecordAudio("410211020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410211", "410211020", "story_v_out_410211.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410211", "410211020", "story_v_out_410211.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play410211021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410211021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play410211022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1061"]) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = arg_87_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_0 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1061"]) then
				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								iter_90_1.color = Color.New(Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_0), Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_0), (Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_0)))
							else
								local var_90_1 = Mathf.Lerp(iter_90_1.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_0)

								iter_90_1.color = Color.New(var_90_1, var_90_1, var_90_1)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1061"]) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_3 then
						iter_90_3.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_2 = 0
			local var_90_3 = 0.8

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(410211021).content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_6 = 32 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_4) / 32)

				if (32 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_4) / 32)) > 0 and var_90_3 < var_90_6 then
					arg_87_1.talkMaxDuration = var_90_6

					if var_90_6 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_7 and arg_87_1.time_ < var_90_2 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play410211022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410211022
		arg_91_1.duration_ = 9.87

		local var_91_0 = {
			ja = 8.8,
			CriLanguages = 9.866,
			zh = 9.866
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
				arg_91_0:Play410211023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1061 = arg_91_1.actors_["1061"].transform.localPosition
				arg_91_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1061", 3)

				for iter_94_0 = 0, arg_91_1.actors_["1061"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1061"].transform:GetChild(iter_94_0)

					if var_94_0.name == "" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_94_2 = arg_91_1.actors_["1061"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								iter_94_2.color = Color.New(Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_2.color.r, 1, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_2.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_5 = 0
			local var_94_6 = 1.175

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(410211022)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 47 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 47)

				if (47 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_8) / 47)) > 0 and var_94_6 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") ~= 0 then
					local var_94_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") / 1000

					if var_94_11 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_5
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_410211", "410211022", "story_v_out_410211.awb")

						arg_91_1:RecordAudio("410211022", var_94_12)
						arg_91_1:RecordAudio("410211022", var_94_12)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410211", "410211022", "story_v_out_410211.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410211", "410211022", "story_v_out_410211.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_13 and arg_91_1.time_ < var_94_5 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410211023
		arg_95_1.duration_ = 12.03

		local var_95_0 = {
			ja = 12.033,
			CriLanguages = 11.533,
			zh = 11.533
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
				arg_95_0:Play410211024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = arg_95_1.actors_["1061"].transform.localPosition
				arg_95_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 3)

				for iter_98_0 = 0, arg_95_1.actors_["1061"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["1061"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_98_2 = arg_95_1.actors_["1061"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 1, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_5 = 0
			local var_98_6 = 1.15

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(410211023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 46 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 46)

				if (46 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 46)) > 0 and var_98_6 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") ~= 0 then
					local var_98_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") / 1000

					if var_98_11 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_5
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_410211", "410211023", "story_v_out_410211.awb")

						arg_95_1:RecordAudio("410211023", var_98_12)
						arg_95_1:RecordAudio("410211023", var_98_12)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410211", "410211023", "story_v_out_410211.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410211", "410211023", "story_v_out_410211.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_13 and arg_95_1.time_ < var_98_5 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410211024
		arg_99_1.duration_ = 4.93

		local var_99_0 = {
			ja = 4.933,
			CriLanguages = 3.666,
			zh = 3.666
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
				arg_99_0:Play410211025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1061"]) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = arg_99_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1061"]) then
				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1061"]) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_2 = 0
			local var_102_3 = 0.3

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[610].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_4 = arg_99_1:GetWordFromCfg(410211024)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 12 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 12)

				if (12 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 12)) > 0 and var_102_3 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") / 1000

					if var_102_8 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_2
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_out_410211", "410211024", "story_v_out_410211.awb")

						arg_99_1:RecordAudio("410211024", var_102_9)
						arg_99_1:RecordAudio("410211024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410211", "410211024", "story_v_out_410211.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410211", "410211024", "story_v_out_410211.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_10 and arg_99_1.time_ < var_102_2 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play410211025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410211025
		arg_103_1.duration_ = 11.3

		local var_103_0 = {
			ja = 11.3,
			CriLanguages = 10.7,
			zh = 10.7
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
				arg_103_0:Play410211026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1061 = arg_103_1.actors_["1061"].transform.localPosition
				arg_103_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1061", 3)

				for iter_106_0 = 0, arg_103_1.actors_["1061"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["1061"].transform:GetChild(iter_106_0)

					if var_106_0.name == "" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_106_2 = arg_103_1.actors_["1061"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1061 == nil then
				arg_103_1.var_.actorSpriteComps1061 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1061 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								iter_106_2.color = Color.New(Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_3), Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_3), (Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_3)))
							else
								local var_106_4 = Mathf.Lerp(iter_106_2.color.r, 1, (arg_103_1.time_ - 0) / var_106_3)

								iter_106_2.color = Color.New(var_106_4, var_106_4, var_106_4)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1061 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_106_4 then
						iter_106_4.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1061 = nil
			end

			local var_106_5 = 0
			local var_106_6 = 1.225

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(410211025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 49 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 49)

				if (49 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 49)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_410211", "410211025", "story_v_out_410211.awb")

						arg_103_1:RecordAudio("410211025", var_106_12)
						arg_103_1:RecordAudio("410211025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410211", "410211025", "story_v_out_410211.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410211", "410211025", "story_v_out_410211.awb")
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

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play410211026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410211026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410211027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1061"]) and arg_107_1.var_.actorSpriteComps1061 == nil then
				arg_107_1.var_.actorSpriteComps1061 = arg_107_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1061"]) then
				if arg_107_1.var_.actorSpriteComps1061 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1061"]) and arg_107_1.var_.actorSpriteComps1061 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1061 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.375

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

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(410211026).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 15 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 15)

				if (15 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 15)) > 0 and var_110_3 < var_110_6 then
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
	Play410211027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410211027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play410211028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.475

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(410211027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 59 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 59)

				if (59 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 59)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410211028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410211028
		arg_115_1.duration_ = 16.9

		local var_115_0 = {
			ja = 16.9,
			CriLanguages = 12.233,
			zh = 12.233
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
				arg_115_0:Play410211029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1061 = arg_115_1.actors_["1061"].transform.localPosition
				arg_115_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1061", 3)

				for iter_118_0 = 0, arg_115_1.actors_["1061"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1061"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_118_2 = arg_115_1.actors_["1061"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								iter_118_2.color = Color.New(Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_2.color.r, 1, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_2.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_5 = 0
			local var_118_6 = 1.35

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(410211028)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 54 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 54)

				if (54 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 54)) > 0 and var_118_6 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") / 1000

					if var_118_11 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_5
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_410211", "410211028", "story_v_out_410211.awb")

						arg_115_1:RecordAudio("410211028", var_118_12)
						arg_115_1:RecordAudio("410211028", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410211", "410211028", "story_v_out_410211.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410211", "410211028", "story_v_out_410211.awb")
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

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410211029
		arg_119_1.duration_ = 12.07

		local var_119_0 = {
			ja = 12.066,
			CriLanguages = 11.3,
			zh = 11.3
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
				arg_119_0:Play410211030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = arg_119_1.actors_["1061"].transform.localPosition
				arg_119_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 3)

				for iter_122_0 = 0, arg_119_1.actors_["1061"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1061"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_122_2 = arg_119_1.actors_["1061"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 1.375

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(410211029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 55 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 55)

				if (55 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 55)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_410211", "410211029", "story_v_out_410211.awb")

						arg_119_1:RecordAudio("410211029", var_122_12)
						arg_119_1:RecordAudio("410211029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410211", "410211029", "story_v_out_410211.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410211", "410211029", "story_v_out_410211.awb")
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

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410211030
		arg_123_1.duration_ = 6.07

		local var_123_0 = {
			ja = 6.066,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_123_0:Play410211031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1061 = arg_123_1.actors_["1061"].transform.localPosition
				arg_123_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1061", 3)

				for iter_126_0 = 0, arg_123_1.actors_["1061"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["1061"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_5" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_126_2 = arg_123_1.actors_["1061"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_5 = 0
			local var_126_6 = 0.525

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(410211030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 21 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 21)

				if (21 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 21)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_410211", "410211030", "story_v_out_410211.awb")

						arg_123_1:RecordAudio("410211030", var_126_12)
						arg_123_1:RecordAudio("410211030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410211", "410211030", "story_v_out_410211.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410211", "410211030", "story_v_out_410211.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_13 and arg_123_1.time_ < var_126_5 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410211031
		arg_127_1.duration_ = 8.63

		local var_127_0 = {
			ja = 8.633,
			CriLanguages = 8.366,
			zh = 8.366
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
				arg_127_0:Play410211032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["10063"] == nil then
				local var_130_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10063")

				if not isNil(var_130_0) then
					local var_130_1 = Object.Instantiate(var_130_0, arg_127_1.canvasGo_.transform)

					var_130_1.transform:SetSiblingIndex(1)

					var_130_1.name = "10063"
					var_130_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_127_1.actors_["10063"] = var_130_1

					if arg_127_1.isInRecall_ then
						for iter_130_0, iter_130_1 in ipairs((var_130_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_130_1.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_130_2 = arg_127_1.actors_["10063"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10063 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10063", 3)

				for iter_130_2 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_2)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10063, Vector3.New(0, -535, -105), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -535, -105)
			end

			local var_130_5 = arg_127_1.actors_["10063"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10063 == nil then
				arg_127_1.var_.actorSpriteComps10063 = var_130_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_6 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.actorSpriteComps10063 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								iter_130_4.color = Color.New(Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_6), Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_6), (Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_6)))
							else
								local var_130_7 = Mathf.Lerp(iter_130_4.color.r, 1, (arg_127_1.time_ - 0) / var_130_6)

								iter_130_4.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10063 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_130_6 then
						iter_130_6.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10063 = nil
			end

			local var_130_8 = arg_127_1.actors_["1061"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1061 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1061", 7)

				for iter_130_7 = 0, var_130_8.childCount - 1 do
					local var_130_9 = var_130_8:GetChild(iter_130_7)

					if var_130_9.name == "" or not string.find(var_130_9.name, "split") then
						var_130_9.gameObject:SetActive(true)
					else
						var_130_9.gameObject:SetActive(false)
					end
				end
			end

			local var_130_10 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_10 then
				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_127_1.time_ - 0) / var_130_10)
			end

			if arg_127_1.time_ >= 0 + var_130_10 and arg_127_1.time_ < 0 + var_130_10 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_130_11 = 0
			local var_130_12 = 0.625

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(410211031)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 25 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 25)

				if (25 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 25)) > 0 and var_130_12 < var_130_16 then
					arg_127_1.talkMaxDuration = var_130_16

					if var_130_16 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") ~= 0 then
					local var_130_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") / 1000

					if var_130_17 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_11
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_410211", "410211031", "story_v_out_410211.awb")

						arg_127_1:RecordAudio("410211031", var_130_18)
						arg_127_1:RecordAudio("410211031", var_130_18)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410211", "410211031", "story_v_out_410211.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410211", "410211031", "story_v_out_410211.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_19 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_19

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_19 and arg_127_1.time_ < var_130_11 + var_130_19 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410211032
		arg_131_1.duration_ = 2.27

		local var_131_0 = {
			ja = 2.266,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_131_0:Play410211033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = arg_131_1.actors_["1061"].transform.localPosition
				arg_131_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 3)

				for iter_134_0 = 0, arg_131_1.actors_["1061"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["1061"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_2" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_134_2 = arg_131_1.actors_["1061"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 1, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_5 = arg_131_1.actors_["10063"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10063 = var_134_5.localPosition
				var_134_5.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10063", 7)

				for iter_134_5 = 0, var_134_5.childCount - 1 do
					local var_134_6 = var_134_5:GetChild(iter_134_5)

					if var_134_6.name == "" or not string.find(var_134_6.name, "split") then
						var_134_6.gameObject:SetActive(true)
					else
						var_134_6.gameObject:SetActive(false)
					end
				end
			end

			local var_134_7 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_131_1.time_ - 0) / var_134_7)
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_134_8 = 0
			local var_134_9 = 0.1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(410211032)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 4 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 4)

				if (4 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 4)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_410211", "410211032", "story_v_out_410211.awb")

						arg_131_1:RecordAudio("410211032", var_134_15)
						arg_131_1:RecordAudio("410211032", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410211", "410211032", "story_v_out_410211.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410211", "410211032", "story_v_out_410211.awb")
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
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
	Play410211033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410211033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play410211034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1061"]) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = arg_135_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1061"]) then
				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1061"]) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 1.05

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(410211033).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 42 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 42)

				if (42 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 42)) > 0 and var_138_3 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_7 and arg_135_1.time_ < var_138_2 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410211034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410211034
		arg_139_1.duration_ = 12.23

		local var_139_0 = {
			ja = 12.233,
			CriLanguages = 9.933,
			zh = 9.933
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
				arg_139_0:Play410211035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1061 = arg_139_1.actors_["1061"].transform.localPosition
				arg_139_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1061", 3)

				for iter_142_0 = 0, arg_139_1.actors_["1061"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["1061"].transform:GetChild(iter_142_0)

					if var_142_0.name == "" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_142_2 = arg_139_1.actors_["1061"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1061 == nil then
				arg_139_1.var_.actorSpriteComps1061 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1061 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 1, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1061 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1061 = nil
			end

			local var_142_5 = 0
			local var_142_6 = 0.975

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(410211034)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 39 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 39)

				if (39 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 39)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_410211", "410211034", "story_v_out_410211.awb")

						arg_139_1:RecordAudio("410211034", var_142_12)
						arg_139_1:RecordAudio("410211034", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410211", "410211034", "story_v_out_410211.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410211", "410211034", "story_v_out_410211.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_13 and arg_139_1.time_ < var_142_5 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410211035
		arg_143_1.duration_ = 19.6

		local var_143_0 = {
			ja = 19.6,
			CriLanguages = 12.6,
			zh = 12.6
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
				arg_143_0:Play410211036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1061 = arg_143_1.actors_["1061"].transform.localPosition
				arg_143_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1061", 3)

				for iter_146_0 = 0, arg_143_1.actors_["1061"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["1061"].transform:GetChild(iter_146_0)

					if var_146_0.name == "" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1061"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_146_2 = arg_143_1.actors_["1061"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1061 == nil then
				arg_143_1.var_.actorSpriteComps1061 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1061 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								iter_146_2.color = Color.New(Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_2.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_2.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1061 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1061 = nil
			end

			local var_146_5 = 0
			local var_146_6 = 1.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(410211035)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 47 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 47)

				if (47 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 47)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_410211", "410211035", "story_v_out_410211.awb")

						arg_143_1:RecordAudio("410211035", var_146_12)
						arg_143_1:RecordAudio("410211035", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410211", "410211035", "story_v_out_410211.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410211", "410211035", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410211036
		arg_147_1.duration_ = 6.67

		local var_147_0 = {
			ja = 6.466,
			CriLanguages = 6.666,
			zh = 6.666
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
				arg_147_0:Play410211037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.L04i == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L04i")
				var_150_0.name = "L04i"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.L04i = var_150_0
			end

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.L04i

				arg_147_1.bgs_.L04i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "L04i" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 2

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = 1
				arg_147_1.mask_.color = var_150_7
			end

			local var_150_8 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_9 = 2

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 then
				local var_150_10 = Color.New(0, 0, 0)

				var_150_10.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_8) / var_150_9)
				arg_147_1.mask_.color = var_150_10
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 then
				local var_150_11 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_11.a = 0
				arg_147_1.mask_.color = var_150_11
			end

			local var_150_12 = arg_147_1.actors_["1061"].transform

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_12.localPosition
				var_150_12.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 2)

				for iter_150_2 = 0, var_150_12.childCount - 1 do
					local var_150_13 = var_150_12:GetChild(iter_150_2)

					if var_150_13.name == "" or not string.find(var_150_13.name, "split") then
						var_150_13.gameObject:SetActive(true)
					else
						var_150_13.gameObject:SetActive(false)
					end
				end
			end

			local var_150_14 = 0.001

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_14 then
				var_150_12.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_147_1.time_ - 4) / var_150_14)
			end

			if arg_147_1.time_ >= 4 + var_150_14 and arg_147_1.time_ < 4 + var_150_14 + arg_150_0 then
				var_150_12.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_150_15 = arg_147_1.actors_["10059"].transform

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 then
				arg_147_1.var_.moveOldPos10059 = var_150_15.localPosition
				var_150_15.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10059", 4)

				for iter_150_3 = 0, var_150_15.childCount - 1 do
					local var_150_16 = var_150_15:GetChild(iter_150_3)

					if var_150_16.name == "" or not string.find(var_150_16.name, "split") then
						var_150_16.gameObject:SetActive(true)
					else
						var_150_16.gameObject:SetActive(false)
					end
				end
			end

			local var_150_17 = 0.001

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_17 then
				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_147_1.time_ - 4) / var_150_17)
			end

			if arg_147_1.time_ >= 4 + var_150_17 and arg_147_1.time_ < 4 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(390, -530, 35)
			end

			local var_150_18 = arg_147_1.actors_["10063"].transform

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 then
				arg_147_1.var_.moveOldPos10063 = var_150_18.localPosition
				var_150_18.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10063", 7)

				for iter_150_4 = 0, var_150_18.childCount - 1 do
					local var_150_19 = var_150_18:GetChild(iter_150_4)

					if var_150_19.name == "" or not string.find(var_150_19.name, "split") then
						var_150_19.gameObject:SetActive(true)
					else
						var_150_19.gameObject:SetActive(false)
					end
				end
			end

			local var_150_20 = 0.001

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_20 then
				var_150_18.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_147_1.time_ - 4) / var_150_20)
			end

			if arg_147_1.time_ >= 4 + var_150_20 and arg_147_1.time_ < 4 + var_150_20 + arg_150_0 then
				var_150_18.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_150_21 = arg_147_1.actors_["1061"]

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 and not isNil(var_150_21) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_22 = 0.034

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_22 and not isNil(var_150_21) then
				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_150_6 then
							if arg_147_1.isInRecall_ then
								iter_150_6.color = Color.New(Mathf.Lerp(iter_150_6.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 4) / var_150_22), Mathf.Lerp(iter_150_6.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 4) / var_150_22), (Mathf.Lerp(iter_150_6.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 4) / var_150_22)))
							else
								local var_150_23 = Mathf.Lerp(iter_150_6.color.r, 1, (arg_147_1.time_ - 4) / var_150_22)

								iter_150_6.color = Color.New(var_150_23, var_150_23, var_150_23)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 4 + var_150_22 and arg_147_1.time_ < 4 + var_150_22 + arg_150_0 and not isNil(var_150_21) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_8 then
						iter_150_8.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_24 = arg_147_1.actors_["10059"]

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.actorSpriteComps10059 == nil then
				arg_147_1.var_.actorSpriteComps10059 = var_150_24:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_25 = 0.034

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_25 and not isNil(var_150_24) then
				if arg_147_1.var_.actorSpriteComps10059 then
					for iter_150_9, iter_150_10 in pairs(arg_147_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_150_10 then
							if arg_147_1.isInRecall_ then
								iter_150_10.color = Color.New(Mathf.Lerp(iter_150_10.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 4) / var_150_25), Mathf.Lerp(iter_150_10.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 4) / var_150_25), (Mathf.Lerp(iter_150_10.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 4) / var_150_25)))
							else
								local var_150_26 = Mathf.Lerp(iter_150_10.color.r, 0.5, (arg_147_1.time_ - 4) / var_150_25)

								iter_150_10.color = Color.New(var_150_26, var_150_26, var_150_26)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 4 + var_150_25 and arg_147_1.time_ < 4 + var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.actorSpriteComps10059 then
				for iter_150_11, iter_150_12 in pairs(arg_147_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_150_12 then
						iter_150_12.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10059 = nil
			end

			local var_150_27 = arg_147_1.actors_["10063"]

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= 4 + arg_150_0 and not isNil(var_150_27) and arg_147_1.var_.actorSpriteComps10063 == nil then
				arg_147_1.var_.actorSpriteComps10063 = var_150_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_28 = 0.034

			if 4 <= arg_147_1.time_ and arg_147_1.time_ < 4 + var_150_28 and not isNil(var_150_27) then
				if arg_147_1.var_.actorSpriteComps10063 then
					for iter_150_13, iter_150_14 in pairs(arg_147_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_150_14 then
							if arg_147_1.isInRecall_ then
								iter_150_14.color = Color.New(Mathf.Lerp(iter_150_14.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 4) / var_150_28), Mathf.Lerp(iter_150_14.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 4) / var_150_28), (Mathf.Lerp(iter_150_14.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 4) / var_150_28)))
							else
								local var_150_29 = Mathf.Lerp(iter_150_14.color.r, 0.5, (arg_147_1.time_ - 4) / var_150_28)

								iter_150_14.color = Color.New(var_150_29, var_150_29, var_150_29)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 4 + var_150_28 and arg_147_1.time_ < 4 + var_150_28 + arg_150_0 and not isNil(var_150_27) and arg_147_1.var_.actorSpriteComps10063 then
				for iter_150_15, iter_150_16 in pairs(arg_147_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_150_16 then
						iter_150_16.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10063 = nil
			end

			local var_150_30 = arg_147_1.actors_["1061"].transform

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_30.localPosition
				var_150_30.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 7)

				for iter_150_17 = 0, var_150_30.childCount - 1 do
					local var_150_31 = var_150_30:GetChild(iter_150_17)

					if var_150_31.name == "" or not string.find(var_150_31.name, "split") then
						var_150_31.gameObject:SetActive(true)
					else
						var_150_31.gameObject:SetActive(false)
					end
				end
			end

			local var_150_32 = 0.001

			if 2 <= arg_147_1.time_ and arg_147_1.time_ < 2 + var_150_32 then
				var_150_30.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_147_1.time_ - 2) / var_150_32)
			end

			if arg_147_1.time_ >= 2 + var_150_32 and arg_147_1.time_ < 2 + var_150_32 + arg_150_0 then
				var_150_30.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_150_33 = 4

			arg_147_1.isInRecall_ = false

			if var_150_33 < arg_147_1.time_ and arg_147_1.time_ <= var_150_33 + arg_150_0 then
				arg_147_1.screenFilterGo_:SetActive(false)

				for iter_150_18, iter_150_19 in pairs(arg_147_1.actors_) do
					for iter_150_20, iter_150_21 in ipairs((iter_150_19:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_150_21.color = iter_150_21.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_150_34 = 0.0166666666666667

			if var_150_33 <= arg_147_1.time_ and arg_147_1.time_ < var_150_33 + var_150_34 then
				arg_147_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_33) / var_150_34)
			end

			if arg_147_1.time_ >= var_150_33 + var_150_34 and arg_147_1.time_ < var_150_33 + var_150_34 + arg_150_0 then
				arg_147_1.screenFilterEffect_.weight = 0
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_35 = 4
			local var_150_36 = 0.275

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_35 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_37 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_37:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_38 = arg_147_1:GetWordFromCfg(410211036)
				local var_150_39 = arg_147_1:FormatText(var_150_38.content)

				arg_147_1.text_.text = var_150_39

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_41 = 11 <= 0 and var_150_36 or var_150_36 * (utf8.len(var_150_39) / 11)

				if (11 <= 0 and var_150_36 or var_150_36 * (utf8.len(var_150_39) / 11)) > 0 and var_150_36 < var_150_41 then
					arg_147_1.talkMaxDuration = var_150_41
					var_150_35 = var_150_35 + 0.3

					if var_150_41 + var_150_35 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_41 + var_150_35
					end
				end

				arg_147_1.text_.text = var_150_39
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") ~= 0 then
					local var_150_42 = manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") / 1000

					if var_150_42 + var_150_35 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_42 + var_150_35
					end

					if var_150_38.prefab_name ~= "" and arg_147_1.actors_[var_150_38.prefab_name] ~= nil then
						local var_150_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_38.prefab_name].transform, "story_v_out_410211", "410211036", "story_v_out_410211.awb")

						arg_147_1:RecordAudio("410211036", var_150_43)
						arg_147_1:RecordAudio("410211036", var_150_43)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410211", "410211036", "story_v_out_410211.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410211", "410211036", "story_v_out_410211.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_44 = var_150_35 + 0.3
			local var_150_45 = math.max(var_150_36, arg_147_1.talkMaxDuration)

			if var_150_35 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_44 + var_150_45 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_44) / var_150_45

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_44 + var_150_45 and arg_147_1.time_ < var_150_44 + var_150_45 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play410211037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410211037
		arg_153_1.duration_ = 2.83

		local var_153_0 = {
			ja = 2.833,
			CriLanguages = 1.833,
			zh = 1.833
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
				arg_153_0:Play410211038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1061 = arg_153_1.actors_["1061"].transform.localPosition
				arg_153_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1061", 2)

				for iter_156_0 = 0, arg_153_1.actors_["1061"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["1061"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_156_2 = arg_153_1.actors_["1061"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 == nil then
				arg_153_1.var_.actorSpriteComps1061 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps1061 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps1061 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1061 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(410211037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 6 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 6)

				if (6 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 6)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_410211", "410211037", "story_v_out_410211.awb")

						arg_153_1:RecordAudio("410211037", var_156_12)
						arg_153_1:RecordAudio("410211037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410211", "410211037", "story_v_out_410211.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410211", "410211037", "story_v_out_410211.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play410211038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410211038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410211039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1061"]) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = arg_157_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1061"]) then
				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1061"]) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.95

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(410211038).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 38 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 38)

				if (38 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 38)) > 0 and var_160_3 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_7 and arg_157_1.time_ < var_160_2 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play410211039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410211039
		arg_161_1.duration_ = 3.17

		local var_161_0 = {
			ja = 3.166,
			CriLanguages = 1.633,
			zh = 1.633
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410211040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10059 = arg_161_1.actors_["10059"].transform.localPosition
				arg_161_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10059", 4)

				for iter_164_0 = 0, arg_161_1.actors_["10059"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["10059"].transform:GetChild(iter_164_0)

					if var_164_0.name == "" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_164_2 = arg_161_1.actors_["10059"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10059 == nil then
				arg_161_1.var_.actorSpriteComps10059 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps10059 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								iter_164_2.color = Color.New(Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_2.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_2.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps10059 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_164_4 then
						iter_164_4.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps10059 = nil
			end

			local var_164_5 = 0
			local var_164_6 = 0.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(410211039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 7 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 7)

				if (7 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 7)) > 0 and var_164_6 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") ~= 0 then
					local var_164_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") / 1000

					if var_164_11 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_5
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_410211", "410211039", "story_v_out_410211.awb")

						arg_161_1:RecordAudio("410211039", var_164_12)
						arg_161_1:RecordAudio("410211039", var_164_12)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410211", "410211039", "story_v_out_410211.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410211", "410211039", "story_v_out_410211.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_13 and arg_161_1.time_ < var_164_5 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410211040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410211040
		arg_165_1.duration_ = 12.97

		local var_165_0 = {
			ja = 12.966,
			CriLanguages = 11.266,
			zh = 11.266
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
				arg_165_0:Play410211041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1061 = arg_165_1.actors_["1061"].transform.localPosition
				arg_165_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1061", 2)

				for iter_168_0 = 0, arg_165_1.actors_["1061"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1061"].transform:GetChild(iter_168_0)

					if var_168_0.name == "" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_168_2 = arg_165_1.actors_["1061"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1061 == nil then
				arg_165_1.var_.actorSpriteComps1061 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1061 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								iter_168_2.color = Color.New(Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_2.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_2.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1061 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1061 = nil
			end

			local var_168_5 = arg_165_1.actors_["10059"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps10059 == nil then
				arg_165_1.var_.actorSpriteComps10059 = var_168_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.actorSpriteComps10059 then
					for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_168_6 then
							if arg_165_1.isInRecall_ then
								iter_168_6.color = Color.New(Mathf.Lerp(iter_168_6.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_6), Mathf.Lerp(iter_168_6.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_6), (Mathf.Lerp(iter_168_6.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_6)))
							else
								local var_168_7 = Mathf.Lerp(iter_168_6.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_6)

								iter_168_6.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps10059 then
				for iter_168_7, iter_168_8 in pairs(arg_165_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_168_8 then
						iter_168_8.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10059 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 1.35

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(410211040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 54 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 54)

				if (54 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 54)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_410211", "410211040", "story_v_out_410211.awb")

						arg_165_1:RecordAudio("410211040", var_168_15)
						arg_165_1:RecordAudio("410211040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410211", "410211040", "story_v_out_410211.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410211", "410211040", "story_v_out_410211.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_16 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_16 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_16

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_16 and arg_165_1.time_ < var_168_8 + var_168_16 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410211041
		arg_169_1.duration_ = 4.9

		local var_169_0 = {
			ja = 4.433,
			CriLanguages = 4.9,
			zh = 4.9
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
				arg_169_0:Play410211042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10059 = arg_169_1.actors_["10059"].transform.localPosition
				arg_169_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10059", 4)

				for iter_172_0 = 0, arg_169_1.actors_["10059"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10059"].transform:GetChild(iter_172_0)

					if var_172_0.name == "" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_172_2 = arg_169_1.actors_["1061"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1061 == nil then
				arg_169_1.var_.actorSpriteComps1061 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps1061 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1061 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps1061 = nil
			end

			local var_172_5 = arg_169_1.actors_["10059"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10059 == nil then
				arg_169_1.var_.actorSpriteComps10059 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps10059 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								iter_172_6.color = Color.New(Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_6.color.r, 1, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_6.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10059 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_172_8 then
						iter_172_8.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10059 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.425

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(410211041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 17 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 17)

				if (17 <= 0 and var_172_9 or var_172_9 * (utf8.len(var_172_11) / 17)) > 0 and var_172_9 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") ~= 0 then
					local var_172_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") / 1000

					if var_172_14 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_8
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_410211", "410211041", "story_v_out_410211.awb")

						arg_169_1:RecordAudio("410211041", var_172_15)
						arg_169_1:RecordAudio("410211041", var_172_15)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410211", "410211041", "story_v_out_410211.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410211", "410211041", "story_v_out_410211.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play410211042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410211042
		arg_173_1.duration_ = 3.83

		local var_173_0 = {
			ja = 3.833,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_173_0:Play410211043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = arg_173_1.actors_["1061"].transform.localPosition
				arg_173_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 2)

				for iter_176_0 = 0, arg_173_1.actors_["1061"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["1061"].transform:GetChild(iter_176_0)

					if var_176_0.name == "" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_176_2 = arg_173_1.actors_["1061"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								iter_176_2.color = Color.New(Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_2.color.r, 1, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_2.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_5 = arg_173_1.actors_["10059"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10059 == nil then
				arg_173_1.var_.actorSpriteComps10059 = var_176_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.actorSpriteComps10059 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								iter_176_6.color = Color.New(Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_6), Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_6), (Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_6)))
							else
								local var_176_7 = Mathf.Lerp(iter_176_6.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_6)

								iter_176_6.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10059 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_176_8 then
						iter_176_8.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10059 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.325

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(410211042)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 13 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 13)

				if (13 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 13)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_410211", "410211042", "story_v_out_410211.awb")

						arg_173_1:RecordAudio("410211042", var_176_15)
						arg_173_1:RecordAudio("410211042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410211", "410211042", "story_v_out_410211.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410211", "410211042", "story_v_out_410211.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play410211043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410211043
		arg_177_1.duration_ = 4.73

		local var_177_0 = {
			ja = 4.733,
			CriLanguages = 4.3,
			zh = 4.3
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
				arg_177_0:Play410211044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10059 = arg_177_1.actors_["10059"].transform.localPosition
				arg_177_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10059", 4)

				for iter_180_0 = 0, arg_177_1.actors_["10059"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10059"].transform:GetChild(iter_180_0)

					if var_180_0.name == "" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_180_2 = arg_177_1.actors_["1061"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								iter_180_2.color = Color.New(Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_2.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_2.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_5 = arg_177_1.actors_["10059"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10059 == nil then
				arg_177_1.var_.actorSpriteComps10059 = var_180_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_6 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_6 and not isNil(var_180_5) then
				if arg_177_1.var_.actorSpriteComps10059 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_180_6 then
							if arg_177_1.isInRecall_ then
								iter_180_6.color = Color.New(Mathf.Lerp(iter_180_6.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_6), Mathf.Lerp(iter_180_6.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_6), (Mathf.Lerp(iter_180_6.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_6)))
							else
								local var_180_7 = Mathf.Lerp(iter_180_6.color.r, 1, (arg_177_1.time_ - 0) / var_180_6)

								iter_180_6.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_6 and arg_177_1.time_ < 0 + var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10059 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_180_8 then
						iter_180_8.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10059 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 0.275

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(410211043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 11 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 11)

				if (11 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 11)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_410211", "410211043", "story_v_out_410211.awb")

						arg_177_1:RecordAudio("410211043", var_180_15)
						arg_177_1:RecordAudio("410211043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410211", "410211043", "story_v_out_410211.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410211", "410211043", "story_v_out_410211.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_16 and arg_177_1.time_ < var_180_8 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play410211044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410211044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410211045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10059 = arg_181_1.actors_["10059"].transform.localPosition
				arg_181_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10059", 7)

				for iter_184_0 = 0, arg_181_1.actors_["10059"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10059"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_184_2 = arg_181_1.actors_["1061"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1061 = var_184_2.localPosition
				var_184_2.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1061", 7)

				for iter_184_1 = 0, var_184_2.childCount - 1 do
					local var_184_3 = var_184_2:GetChild(iter_184_1)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_2.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_181_1.time_ - 0) / var_184_4)
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_184_5 = arg_181_1.actors_["10059"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10059 == nil then
				arg_181_1.var_.actorSpriteComps10059 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10059 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								iter_184_3.color = Color.New(Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_3.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_3.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10059 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_184_5 then
						iter_184_5.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10059 = nil
			end

			local var_184_8 = arg_181_1.actors_["1061"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1061 == nil then
				arg_181_1.var_.actorSpriteComps1061 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_9 and not isNil(var_184_8) then
				if arg_181_1.var_.actorSpriteComps1061 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								iter_184_7.color = Color.New(Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_9), Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_9), (Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_9)))
							else
								local var_184_10 = Mathf.Lerp(iter_184_7.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_9)

								iter_184_7.color = Color.New(var_184_10, var_184_10, var_184_10)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_9 and arg_181_1.time_ < 0 + var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1061 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_184_9 then
						iter_184_9.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1061 = nil
			end

			local var_184_11 = 0
			local var_184_12 = 1.125

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(410211044).content)

				arg_181_1.text_.text = var_184_13

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_15 = 45 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_13) / 45)

				if (45 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_13) / 45)) > 0 and var_184_12 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_13
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_16 and arg_181_1.time_ < var_184_11 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410211045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play410211046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.9

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

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(410211045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 36 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 36)

				if (36 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 36)) > 0 and var_188_0 < var_188_3 then
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
	Play410211046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410211046
		arg_189_1.duration_ = 1.63

		local var_189_0 = {
			ja = 1.4,
			CriLanguages = 1.633,
			zh = 1.633
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
				arg_189_0:Play410211047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10063 = arg_189_1.actors_["10063"].transform.localPosition
				arg_189_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10063", 2)

				for iter_192_0 = 0, arg_189_1.actors_["10063"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10063"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_5" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10063, Vector3.New(-390, -535, -105), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10063"].transform.localPosition = Vector3.New(-390, -535, -105)
			end

			local var_192_2 = arg_189_1.actors_["10059"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10059 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10059", 4)

				for iter_192_1 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_1)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_192_5 = arg_189_1.actors_["10063"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10063 == nil then
				arg_189_1.var_.actorSpriteComps10063 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps10063 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								iter_192_3.color = Color.New(Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_3.color.r, 1, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_3.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10063 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_192_5 then
						iter_192_5.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10063 = nil
			end

			local var_192_8 = arg_189_1.actors_["10059"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10059 == nil then
				arg_189_1.var_.actorSpriteComps10059 = var_192_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 and not isNil(var_192_8) then
				if arg_189_1.var_.actorSpriteComps10059 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								iter_192_7.color = Color.New(Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_9), Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_9), (Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_9)))
							else
								local var_192_10 = Mathf.Lerp(iter_192_7.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_9)

								iter_192_7.color = Color.New(var_192_10, var_192_10, var_192_10)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10059 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_192_9 then
						iter_192_9.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10059 = nil
			end

			local var_192_11 = 0
			local var_192_12 = 0.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(410211046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_16 = 4 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_14) / 4)

				if (4 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_14) / 4)) > 0 and var_192_12 < var_192_16 then
					arg_189_1.talkMaxDuration = var_192_16

					if var_192_16 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_11
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") ~= 0 then
					local var_192_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") / 1000

					if var_192_17 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_11
					end

					if var_192_13.prefab_name ~= "" and arg_189_1.actors_[var_192_13.prefab_name] ~= nil then
						local var_192_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_13.prefab_name].transform, "story_v_out_410211", "410211046", "story_v_out_410211.awb")

						arg_189_1:RecordAudio("410211046", var_192_18)
						arg_189_1:RecordAudio("410211046", var_192_18)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410211", "410211046", "story_v_out_410211.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410211", "410211046", "story_v_out_410211.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_19 = math.max(var_192_12, arg_189_1.talkMaxDuration)

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_19 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_11) / var_192_19

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_11 + var_192_19 and arg_189_1.time_ < var_192_11 + var_192_19 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play410211047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410211047
		arg_193_1.duration_ = 4.27

		local var_193_0 = {
			ja = 4.266,
			CriLanguages = 2.533,
			zh = 2.533
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410211048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10063"]) and arg_193_1.var_.actorSpriteComps10063 == nil then
				arg_193_1.var_.actorSpriteComps10063 = arg_193_1.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10063"]) then
				if arg_193_1.var_.actorSpriteComps10063 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10063"]) and arg_193_1.var_.actorSpriteComps10063 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10063 = nil
			end

			local var_196_2 = arg_193_1.actors_["10059"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10059 == nil then
				arg_193_1.var_.actorSpriteComps10059 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10059 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_5.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_5.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10059 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10059 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.25

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(410211047)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 10 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 10)

				if (10 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 10)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_410211", "410211047", "story_v_out_410211.awb")

						arg_193_1:RecordAudio("410211047", var_196_12)
						arg_193_1:RecordAudio("410211047", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410211", "410211047", "story_v_out_410211.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410211", "410211047", "story_v_out_410211.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play410211048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410211048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410211049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10063 = arg_197_1.actors_["10063"].transform.localPosition
				arg_197_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10063", 7)

				for iter_200_0 = 0, arg_197_1.actors_["10063"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10063"].transform:GetChild(iter_200_0)

					if var_200_0.name == "" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, -105)
			end

			local var_200_2 = arg_197_1.actors_["10059"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10059 = var_200_2.localPosition
				var_200_2.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10059", 7)

				for iter_200_1 = 0, var_200_2.childCount - 1 do
					local var_200_3 = var_200_2:GetChild(iter_200_1)

					if var_200_3.name == "" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_2.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_197_1.time_ - 0) / var_200_4)
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_2.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_200_5 = 0
			local var_200_6 = 1.15

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(410211048).content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 46 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_7) / 46)

				if (46 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_7) / 46)) > 0 and var_200_6 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_10 and arg_197_1.time_ < var_200_5 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410211049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410211049
		arg_201_1.duration_ = 4.67

		local var_201_0 = {
			ja = 2.6,
			CriLanguages = 4.666,
			zh = 4.666
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
				arg_201_0:Play410211050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10059 = arg_201_1.actors_["10059"].transform.localPosition
				arg_201_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10059", 4)

				for iter_204_0 = 0, arg_201_1.actors_["10059"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10059"].transform:GetChild(iter_204_0)

					if var_204_0.name == "" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_204_2 = arg_201_1.actors_["1061"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1061 = var_204_2.localPosition
				var_204_2.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1061", 2)

				for iter_204_1 = 0, var_204_2.childCount - 1 do
					local var_204_3 = var_204_2:GetChild(iter_204_1)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_201_1.time_ - 0) / var_204_4)
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_204_5 = arg_201_1.actors_["10059"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps10059 == nil then
				arg_201_1.var_.actorSpriteComps10059 = var_204_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_6 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.actorSpriteComps10059 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								iter_204_3.color = Color.New(Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_6), Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_6), (Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_6)))
							else
								local var_204_7 = Mathf.Lerp(iter_204_3.color.r, 1, (arg_201_1.time_ - 0) / var_204_6)

								iter_204_3.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.actorSpriteComps10059 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_204_5 then
						iter_204_5.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10059 = nil
			end

			local var_204_8 = arg_201_1.actors_["1061"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps1061 == nil then
				arg_201_1.var_.actorSpriteComps1061 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_9 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_9 and not isNil(var_204_8) then
				if arg_201_1.var_.actorSpriteComps1061 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								iter_204_7.color = Color.New(Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_9), Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_9), (Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_9)))
							else
								local var_204_10 = Mathf.Lerp(iter_204_7.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_9)

								iter_204_7.color = Color.New(var_204_10, var_204_10, var_204_10)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_9 and arg_201_1.time_ < 0 + var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps1061 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_204_9 then
						iter_204_9.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1061 = nil
			end

			local var_204_11 = 0
			local var_204_12 = 0.45

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_13 = arg_201_1:GetWordFromCfg(410211049)
				local var_204_14 = arg_201_1:FormatText(var_204_13.content)

				arg_201_1.text_.text = var_204_14

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_16 = 18 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_14) / 18)

				if (18 <= 0 and var_204_12 or var_204_12 * (utf8.len(var_204_14) / 18)) > 0 and var_204_12 < var_204_16 then
					arg_201_1.talkMaxDuration = var_204_16

					if var_204_16 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_16 + var_204_11
					end
				end

				arg_201_1.text_.text = var_204_14
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") ~= 0 then
					local var_204_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") / 1000

					if var_204_17 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_17 + var_204_11
					end

					if var_204_13.prefab_name ~= "" and arg_201_1.actors_[var_204_13.prefab_name] ~= nil then
						local var_204_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_13.prefab_name].transform, "story_v_out_410211", "410211049", "story_v_out_410211.awb")

						arg_201_1:RecordAudio("410211049", var_204_18)
						arg_201_1:RecordAudio("410211049", var_204_18)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410211", "410211049", "story_v_out_410211.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410211", "410211049", "story_v_out_410211.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_19 = math.max(var_204_12, arg_201_1.talkMaxDuration)

			if var_204_11 <= arg_201_1.time_ and arg_201_1.time_ < var_204_11 + var_204_19 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_11) / var_204_19

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_11 + var_204_19 and arg_201_1.time_ < var_204_11 + var_204_19 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410211050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410211050
		arg_205_1.duration_ = 4.53

		local var_205_0 = {
			ja = 4.533,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_205_0:Play410211051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = arg_205_1.actors_["1061"].transform.localPosition
				arg_205_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 2)

				for iter_208_0 = 0, arg_205_1.actors_["1061"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1061"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_5" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_208_2 = arg_205_1.actors_["10059"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10059 == nil then
				arg_205_1.var_.actorSpriteComps10059 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10059 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10059 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10059 = nil
			end

			local var_208_5 = arg_205_1.actors_["1061"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_6 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 and not isNil(var_208_5) then
				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_5, iter_208_6 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_208_6 then
							if arg_205_1.isInRecall_ then
								iter_208_6.color = Color.New(Mathf.Lerp(iter_208_6.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_6), Mathf.Lerp(iter_208_6.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_6), (Mathf.Lerp(iter_208_6.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_6)))
							else
								local var_208_7 = Mathf.Lerp(iter_208_6.color.r, 1, (arg_205_1.time_ - 0) / var_208_6)

								iter_208_6.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_7, iter_208_8 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_8 then
						iter_208_8.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.2

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(410211050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 8 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 8)

				if (8 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 8)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_410211", "410211050", "story_v_out_410211.awb")

						arg_205_1:RecordAudio("410211050", var_208_15)
						arg_205_1:RecordAudio("410211050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410211", "410211050", "story_v_out_410211.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410211", "410211050", "story_v_out_410211.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play410211051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410211051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410211052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10059 = arg_209_1.actors_["10059"].transform.localPosition
				arg_209_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10059", 7)

				for iter_212_0 = 0, arg_209_1.actors_["10059"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10059"].transform:GetChild(iter_212_0)

					if var_212_0.name == "" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_212_2 = arg_209_1.actors_["1061"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1061 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1061", 7)

				for iter_212_1 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_1)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_212_5 = 0
			local var_212_6 = 1.5

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(410211051).content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 60 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 60)

				if (60 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_7) / 60)) > 0 and var_212_6 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_10 and arg_209_1.time_ < var_212_5 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play410211052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410211052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410211053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.675

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

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(410211052).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 67 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 67)

				if (67 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 67)) > 0 and var_216_0 < var_216_3 then
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
	Play410211053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410211053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play410211054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.05

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[604].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3046")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(410211053).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 2 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 2)

				if (2 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 2)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play410211054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410211054
		arg_221_1.duration_ = 1.17

		local var_221_0 = {
			ja = 1.133,
			CriLanguages = 1.166,
			zh = 1.166
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
				arg_221_0:Play410211055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10059 = arg_221_1.actors_["10059"].transform.localPosition
				arg_221_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10059", 3)

				for iter_224_0 = 0, arg_221_1.actors_["10059"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10059"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10059"].transform.localPosition = Vector3.New(0, -530, 35)
			end

			local var_224_2 = arg_221_1.actors_["10059"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10059 == nil then
				arg_221_1.var_.actorSpriteComps10059 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10059 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 1, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10059 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10059 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.075

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(410211054)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 3 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 3)

				if (3 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 3)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_410211", "410211054", "story_v_out_410211.awb")

						arg_221_1:RecordAudio("410211054", var_224_12)
						arg_221_1:RecordAudio("410211054", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410211", "410211054", "story_v_out_410211.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410211", "410211054", "story_v_out_410211.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_13 and arg_221_1.time_ < var_224_5 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play410211055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410211055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play410211056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10059 = arg_225_1.actors_["10059"].transform.localPosition
				arg_225_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10059", 7)

				for iter_228_0 = 0, arg_225_1.actors_["10059"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["10059"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_228_2 = arg_225_1.actors_["10059"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps10059 == nil then
				arg_225_1.var_.actorSpriteComps10059 = var_228_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_3 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.actorSpriteComps10059 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								iter_228_2.color = Color.New(Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_3), Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_3), (Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_3)))
							else
								local var_228_4 = Mathf.Lerp(iter_228_2.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_3)

								iter_228_2.color = Color.New(var_228_4, var_228_4, var_228_4)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps10059 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_228_4 then
						iter_228_4.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10059 = nil
			end

			local var_228_5 = 0
			local var_228_6 = 0.625

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(410211055).content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 25 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_7) / 25)

				if (25 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_7) / 25)) > 0 and var_228_6 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_10 and arg_225_1.time_ < var_228_5 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play410211056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410211056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play410211057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.275

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(410211056).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 51 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 51)

				if (51 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 51)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play410211057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410211057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410211058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.6

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(410211057).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 24 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 24)

				if (24 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 24)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play410211058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410211058
		arg_237_1.duration_ = 6.1

		local var_237_0 = {
			ja = 6.1,
			CriLanguages = 3.466,
			zh = 3.466
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410211059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10063 = arg_237_1.actors_["10063"].transform.localPosition
				arg_237_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10063", 3)

				for iter_240_0 = 0, arg_237_1.actors_["10063"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10063"].transform:GetChild(iter_240_0)

					if var_240_0.name == "split_3" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10063, Vector3.New(0, -490, 18), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10063"].transform.localPosition = Vector3.New(0, -490, 18)
			end

			local var_240_2 = arg_237_1.actors_["10063"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10063 == nil then
				arg_237_1.var_.actorSpriteComps10063 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps10063 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 1, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10063 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10063 = nil
			end

			local var_240_5 = 0
			local var_240_6 = 0.275

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:GetWordFromCfg(410211058)
				local var_240_8 = arg_237_1:FormatText(var_240_7.content)

				arg_237_1.text_.text = var_240_8

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 11 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 11)

				if (11 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 11)) > 0 and var_240_6 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_8
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") ~= 0 then
					local var_240_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") / 1000

					if var_240_11 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_5
					end

					if var_240_7.prefab_name ~= "" and arg_237_1.actors_[var_240_7.prefab_name] ~= nil then
						local var_240_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_7.prefab_name].transform, "story_v_out_410211", "410211058", "story_v_out_410211.awb")

						arg_237_1:RecordAudio("410211058", var_240_12)
						arg_237_1:RecordAudio("410211058", var_240_12)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410211", "410211058", "story_v_out_410211.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410211", "410211058", "story_v_out_410211.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_6, arg_237_1.talkMaxDuration)

			if var_240_5 <= arg_237_1.time_ and arg_237_1.time_ < var_240_5 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_5) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_5 + var_240_13 and arg_237_1.time_ < var_240_5 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410211059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410211059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play410211060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10063 = arg_241_1.actors_["10063"].transform.localPosition
				arg_241_1.actors_["10063"].transform.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10063", 7)

				for iter_244_0 = 0, arg_241_1.actors_["10063"].transform.childCount - 1 do
					local var_244_0 = arg_241_1.actors_["10063"].transform:GetChild(iter_244_0)

					if var_244_0.name == "" or not string.find(var_244_0.name, "split") then
						var_244_0.gameObject:SetActive(true)
					else
						var_244_0.gameObject:SetActive(false)
					end
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["10063"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10063, Vector3.New(0, -2000, 18), (arg_241_1.time_ - 0) / var_244_1)
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["10063"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_244_2 = arg_241_1.actors_["10063"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10063 == nil then
				arg_241_1.var_.actorSpriteComps10063 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps10063 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								iter_244_2.color = Color.New(Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_2.color.r, 0.5, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_2.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10063 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10063:ToTable()) do
					if iter_244_4 then
						iter_244_4.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps10063 = nil
			end

			local var_244_5 = 0
			local var_244_6 = 1.7

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(410211059).content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 68 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_7) / 68)

				if (68 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_7) / 68)) > 0 and var_244_6 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_10 and arg_241_1.time_ < var_244_5 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10063",
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
	Play410211060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410211060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410211061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.35

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(410211060).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 54 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 54)

				if (54 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 54)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410211061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410211061
		arg_249_1.duration_ = 6.87

		local var_249_0 = {
			ja = 6.866,
			CriLanguages = 3.5,
			zh = 3.5
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
				arg_249_0:Play410211062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = arg_249_1.actors_["1061"].transform.localPosition
				arg_249_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 2)

				for iter_252_0 = 0, arg_249_1.actors_["1061"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["1061"].transform:GetChild(iter_252_0)

					if var_252_0.name == "split_5" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_252_2 = arg_249_1.actors_["10059"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10059 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10059", 4)

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
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_252_5 = arg_249_1.actors_["1061"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_8 = arg_249_1.actors_["10059"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10059 == nil then
				arg_249_1.var_.actorSpriteComps10059 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.actorSpriteComps10059 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10059 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_252_9 then
						iter_252_9.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10059 = nil
			end

			local var_252_11 = 0
			local var_252_12 = 0.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_13 = arg_249_1:GetWordFromCfg(410211061)
				local var_252_14 = arg_249_1:FormatText(var_252_13.content)

				arg_249_1.text_.text = var_252_14

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 18 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 18)

				if (18 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 18)) > 0 and var_252_12 < var_252_16 then
					arg_249_1.talkMaxDuration = var_252_16

					if var_252_16 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_14
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") ~= 0 then
					local var_252_17 = manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") / 1000

					if var_252_17 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_11
					end

					if var_252_13.prefab_name ~= "" and arg_249_1.actors_[var_252_13.prefab_name] ~= nil then
						local var_252_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_13.prefab_name].transform, "story_v_out_410211", "410211061", "story_v_out_410211.awb")

						arg_249_1:RecordAudio("410211061", var_252_18)
						arg_249_1:RecordAudio("410211061", var_252_18)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410211", "410211061", "story_v_out_410211.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410211", "410211061", "story_v_out_410211.awb")
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
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
	Play410211062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410211062
		arg_253_1.duration_ = 12.33

		local var_253_0 = {
			ja = 12.333,
			CriLanguages = 6.466,
			zh = 6.466
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
				arg_253_0:Play410211063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10059"]) and arg_253_1.var_.actorSpriteComps10059 == nil then
				arg_253_1.var_.actorSpriteComps10059 = arg_253_1.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10059"]) then
				if arg_253_1.var_.actorSpriteComps10059 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 1, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10059"]) and arg_253_1.var_.actorSpriteComps10059 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10059 = nil
			end

			local var_256_2 = arg_253_1.actors_["1061"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1061 == nil then
				arg_253_1.var_.actorSpriteComps1061 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1061 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_5.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1061 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps1061 = nil
			end

			local var_256_5 = 0
			local var_256_6 = 0.825

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_7 = arg_253_1:GetWordFromCfg(410211062)
				local var_256_8 = arg_253_1:FormatText(var_256_7.content)

				arg_253_1.text_.text = var_256_8

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 33 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 33)

				if (33 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_8) / 33)) > 0 and var_256_6 < var_256_10 then
					arg_253_1.talkMaxDuration = var_256_10

					if var_256_10 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_5
					end
				end

				arg_253_1.text_.text = var_256_8
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") ~= 0 then
					local var_256_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") / 1000

					if var_256_11 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_5
					end

					if var_256_7.prefab_name ~= "" and arg_253_1.actors_[var_256_7.prefab_name] ~= nil then
						local var_256_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_7.prefab_name].transform, "story_v_out_410211", "410211062", "story_v_out_410211.awb")

						arg_253_1:RecordAudio("410211062", var_256_12)
						arg_253_1:RecordAudio("410211062", var_256_12)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410211", "410211062", "story_v_out_410211.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410211", "410211062", "story_v_out_410211.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_13 = math.max(var_256_6, arg_253_1.talkMaxDuration)

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_13 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_5) / var_256_13

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_5 + var_256_13 and arg_253_1.time_ < var_256_5 + var_256_13 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410211063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410211063
		arg_257_1.duration_ = 3.37

		local var_257_0 = {
			ja = 3.366,
			CriLanguages = 1.4,
			zh = 1.4
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
				arg_257_0:Play410211064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = arg_257_1.actors_["1061"].transform.localPosition
				arg_257_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 2)

				for iter_260_0 = 0, arg_257_1.actors_["1061"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["1061"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_5" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_260_2 = arg_257_1.actors_["1061"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								iter_260_2.color = Color.New(Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_2.color.r, 1, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_2.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_5 = arg_257_1.actors_["10059"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10059 == nil then
				arg_257_1.var_.actorSpriteComps10059 = var_260_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_6 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.actorSpriteComps10059 then
					for iter_260_5, iter_260_6 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_260_6 then
							if arg_257_1.isInRecall_ then
								iter_260_6.color = Color.New(Mathf.Lerp(iter_260_6.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_6), Mathf.Lerp(iter_260_6.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_6), (Mathf.Lerp(iter_260_6.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_6)))
							else
								local var_260_7 = Mathf.Lerp(iter_260_6.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_6)

								iter_260_6.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.actorSpriteComps10059 then
				for iter_260_7, iter_260_8 in pairs(arg_257_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_260_8 then
						iter_260_8.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10059 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(410211063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 7 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 7)

				if (7 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 7)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_410211", "410211063", "story_v_out_410211.awb")

						arg_257_1:RecordAudio("410211063", var_260_15)
						arg_257_1:RecordAudio("410211063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410211", "410211063", "story_v_out_410211.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410211", "410211063", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410211064
		arg_261_1.duration_ = 4.63

		local var_261_0 = {
			ja = 4.266,
			CriLanguages = 4.633,
			zh = 4.633
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
				arg_261_0:Play410211065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1061"]) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = arg_261_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1061"]) then
				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1061"]) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_2 = arg_261_1.actors_["10059"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10059 == nil then
				arg_261_1.var_.actorSpriteComps10059 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10059 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								iter_264_5.color = Color.New(Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_5.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_5.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10059 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_264_7 then
						iter_264_7.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10059 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.375

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(410211064)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 15 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 15)

				if (15 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 15)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_410211", "410211064", "story_v_out_410211.awb")

						arg_261_1:RecordAudio("410211064", var_264_12)
						arg_261_1:RecordAudio("410211064", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410211", "410211064", "story_v_out_410211.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410211", "410211064", "story_v_out_410211.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play410211065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410211065
		arg_265_1.duration_ = 9.4

		local var_265_0 = {
			ja = 8.9,
			CriLanguages = 9.4,
			zh = 9.4
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
				arg_265_0:Play410211066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1061"]) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = arg_265_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1061"]) then
				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 1, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1061"]) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_2 = arg_265_1.actors_["10059"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10059 == nil then
				arg_265_1.var_.actorSpriteComps10059 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps10059 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								iter_268_5.color = Color.New(Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_5.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_5.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10059 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_268_7 then
						iter_268_7.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10059 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 1.025

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:GetWordFromCfg(410211065)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 41 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 41)

				if (41 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 41)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_out_410211", "410211065", "story_v_out_410211.awb")

						arg_265_1:RecordAudio("410211065", var_268_12)
						arg_265_1:RecordAudio("410211065", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410211", "410211065", "story_v_out_410211.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410211", "410211065", "story_v_out_410211.awb")
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

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play410211066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410211066
		arg_269_1.duration_ = 6

		local var_269_0 = {
			ja = 6,
			CriLanguages = 1.466,
			zh = 1.466
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
				arg_269_0:Play410211067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1061"]) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = arg_269_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1061"]) then
				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								iter_272_1.color = Color.New(Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_0), Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_0), (Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_0)))
							else
								local var_272_1 = Mathf.Lerp(iter_272_1.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_0)

								iter_272_1.color = Color.New(var_272_1, var_272_1, var_272_1)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1061"]) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_2 = arg_269_1.actors_["10059"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10059 == nil then
				arg_269_1.var_.actorSpriteComps10059 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10059 then
					for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_272_5 then
							if arg_269_1.isInRecall_ then
								iter_272_5.color = Color.New(Mathf.Lerp(iter_272_5.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_5.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_5.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_5.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_5.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10059 then
				for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_272_7 then
						iter_272_7.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10059 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.2

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(410211066)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 8 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 8)

				if (8 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 8)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_410211", "410211066", "story_v_out_410211.awb")

						arg_269_1:RecordAudio("410211066", var_272_12)
						arg_269_1:RecordAudio("410211066", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410211", "410211066", "story_v_out_410211.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410211", "410211066", "story_v_out_410211.awb")
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

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410211067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410211067
		arg_273_1.duration_ = 3.2

		local var_273_0 = {
			ja = 3.2,
			CriLanguages = 1.4,
			zh = 1.4
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
				arg_273_0:Play410211068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1061"]) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = arg_273_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1061"]) then
				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 1, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1061"]) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_2 = arg_273_1.actors_["10059"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10059 == nil then
				arg_273_1.var_.actorSpriteComps10059 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps10059 then
					for iter_276_4, iter_276_5 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_276_5 then
							if arg_273_1.isInRecall_ then
								iter_276_5.color = Color.New(Mathf.Lerp(iter_276_5.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_5.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_5.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_5.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_5.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10059 then
				for iter_276_6, iter_276_7 in pairs(arg_273_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_276_7 then
						iter_276_7.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10059 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(410211067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 7 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 7)

				if (7 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 7)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_410211", "410211067", "story_v_out_410211.awb")

						arg_273_1:RecordAudio("410211067", var_276_12)
						arg_273_1:RecordAudio("410211067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410211", "410211067", "story_v_out_410211.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410211", "410211067", "story_v_out_410211.awb")
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

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play410211068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410211068
		arg_277_1.duration_ = 13.1

		local var_277_0 = {
			ja = 13.1,
			CriLanguages = 9.066,
			zh = 9.066
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play410211069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = arg_277_1.actors_["1061"].transform.localPosition
				arg_277_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 2)

				for iter_280_0 = 0, arg_277_1.actors_["1061"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1061"].transform:GetChild(iter_280_0)

					if var_280_0.name == "" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_280_2 = arg_277_1.actors_["1061"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 1.1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(410211068)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 44 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 44)

				if (44 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 44)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_410211", "410211068", "story_v_out_410211.awb")

						arg_277_1:RecordAudio("410211068", var_280_12)
						arg_277_1:RecordAudio("410211068", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410211", "410211068", "story_v_out_410211.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410211", "410211068", "story_v_out_410211.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play410211069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410211069
		arg_281_1.duration_ = 8.1

		local var_281_0 = {
			ja = 8.1,
			CriLanguages = 5.066,
			zh = 5.066
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
				arg_281_0:Play410211070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1061 = arg_281_1.actors_["1061"].transform.localPosition
				arg_281_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1061", 2)

				for iter_284_0 = 0, arg_281_1.actors_["1061"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["1061"].transform:GetChild(iter_284_0)

					if var_284_0.name == "" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_284_2 = arg_281_1.actors_["1061"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.675

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(410211069)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_410211", "410211069", "story_v_out_410211.awb")

						arg_281_1:RecordAudio("410211069", var_284_12)
						arg_281_1:RecordAudio("410211069", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410211", "410211069", "story_v_out_410211.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410211", "410211069", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410211070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410211071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1061"]) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = arg_285_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1061"]) then
				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1061"]) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 1.325

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(410211070).content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 53 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 53)

				if (53 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 53)) > 0 and var_288_3 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_7 and arg_285_1.time_ < var_288_2 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play410211071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410211071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410211072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(410211071).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 49 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 49)

				if (49 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 49)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play410211072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410211072
		arg_293_1.duration_ = 1.5

		local var_293_0 = {
			ja = 1.5,
			CriLanguages = 1.133,
			zh = 1.133
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
				arg_293_0:Play410211073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1061 = arg_293_1.actors_["1061"].transform.localPosition
				arg_293_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1061", 2)

				for iter_296_0 = 0, arg_293_1.actors_["1061"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1061"].transform:GetChild(iter_296_0)

					if var_296_0.name == "split_5" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_296_2 = arg_293_1.actors_["1061"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1061 == nil then
				arg_293_1.var_.actorSpriteComps1061 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps1061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps1061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1061 = nil
			end

			local var_296_5 = 0
			local var_296_6 = 0.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(410211072)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 5 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 5)

				if (5 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 5)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_410211", "410211072", "story_v_out_410211.awb")

						arg_293_1:RecordAudio("410211072", var_296_12)
						arg_293_1:RecordAudio("410211072", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410211", "410211072", "story_v_out_410211.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410211", "410211072", "story_v_out_410211.awb")
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
				actorName = "1061",
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
	Play410211073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410211073
		arg_297_1.duration_ = 9.17

		local var_297_0 = {
			ja = 9.166,
			CriLanguages = 6.566,
			zh = 6.566
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
				arg_297_0:Play410211074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1061"]) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = arg_297_1.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1061"]) then
				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1061"]) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_2 = arg_297_1.actors_["10059"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps10059 == nil then
				arg_297_1.var_.actorSpriteComps10059 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps10059 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								iter_300_5.color = Color.New(Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_5.color.r, 1, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_5.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps10059 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_300_7 then
						iter_300_7.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10059 = nil
			end

			local var_300_5 = 0
			local var_300_6 = 0.675

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(410211073)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 27 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 27)

				if (27 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 27)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_410211", "410211073", "story_v_out_410211.awb")

						arg_297_1:RecordAudio("410211073", var_300_12)
						arg_297_1:RecordAudio("410211073", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410211", "410211073", "story_v_out_410211.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410211", "410211073", "story_v_out_410211.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_13 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_13 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_13

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_13 and arg_297_1.time_ < var_300_5 + var_300_13 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play410211074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410211074
		arg_301_1.duration_ = 2.83

		local var_301_0 = {
			ja = 2.833,
			CriLanguages = 2.466,
			zh = 2.466
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410211075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1061 = arg_301_1.actors_["1061"].transform.localPosition
				arg_301_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1061", 2)

				for iter_304_0 = 0, arg_301_1.actors_["1061"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["1061"].transform:GetChild(iter_304_0)

					if var_304_0.name == "" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["1061"].transform.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_304_2 = arg_301_1.actors_["1061"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 1, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_5 = arg_301_1.actors_["10059"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps10059 == nil then
				arg_301_1.var_.actorSpriteComps10059 = var_304_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_6 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_6 and not isNil(var_304_5) then
				if arg_301_1.var_.actorSpriteComps10059 then
					for iter_304_5, iter_304_6 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_304_6 then
							if arg_301_1.isInRecall_ then
								iter_304_6.color = Color.New(Mathf.Lerp(iter_304_6.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_6), Mathf.Lerp(iter_304_6.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_6), (Mathf.Lerp(iter_304_6.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_6)))
							else
								local var_304_7 = Mathf.Lerp(iter_304_6.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_6)

								iter_304_6.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_6 and arg_301_1.time_ < 0 + var_304_6 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.actorSpriteComps10059 then
				for iter_304_7, iter_304_8 in pairs(arg_301_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_304_8 then
						iter_304_8.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10059 = nil
			end

			local var_304_8 = 0
			local var_304_9 = 0.225

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(410211074)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 9 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 9)

				if (9 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 9)) > 0 and var_304_9 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") ~= 0 then
					local var_304_14 = manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") / 1000

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_410211", "410211074", "story_v_out_410211.awb")

						arg_301_1:RecordAudio("410211074", var_304_15)
						arg_301_1:RecordAudio("410211074", var_304_15)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_410211", "410211074", "story_v_out_410211.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_410211", "410211074", "story_v_out_410211.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_16 and arg_301_1.time_ < var_304_8 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410211075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410211075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
			arg_305_1.auto_ = false
		end

		function arg_305_1.playNext_(arg_307_0)
			arg_305_1.onStoryFinished_()
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1061 = arg_305_1.actors_["1061"].transform.localPosition
				arg_305_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1061", 7)

				for iter_308_0 = 0, arg_305_1.actors_["1061"].transform.childCount - 1 do
					local var_308_0 = arg_305_1.actors_["1061"].transform:GetChild(iter_308_0)

					if var_308_0.name == "" or not string.find(var_308_0.name, "split") then
						var_308_0.gameObject:SetActive(true)
					else
						var_308_0.gameObject:SetActive(false)
					end
				end
			end

			local var_308_1 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 then
				arg_305_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_305_1.time_ - 0) / var_308_1)
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 then
				arg_305_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_308_2 = arg_305_1.actors_["10059"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10059 = var_308_2.localPosition
				var_308_2.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10059", 7)

				for iter_308_1 = 0, var_308_2.childCount - 1 do
					local var_308_3 = var_308_2:GetChild(iter_308_1)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				var_308_2.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_305_1.time_ - 0) / var_308_4)
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				var_308_2.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_308_5 = 0
			local var_308_6 = 0.975

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(410211075).content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 39 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_7) / 39)

				if (39 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_7) / 39)) > 0 and var_308_6 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_10 and arg_305_1.time_ < var_308_5 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST66",
		"TextureConfig/Background/ST64a",
		"TextureConfig/Background/L04i"
	},
	voices = {
		"story_v_out_410211.awb"
	}
}
