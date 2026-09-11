return {
	Play410232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410232001
		arg_1_1.duration_ = 7.27

		local var_1_0 = {
			ja = 7.266,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_1_0:Play410232002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST62 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST62")
				var_4_0.name = "ST62"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST62 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST62

				arg_1_1.bgs_.ST62.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST62" then
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

			local var_4_8 = "10062"

			if arg_1_1.actors_["10062"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_4_9) then
					local var_4_10 = Object.Instantiate(var_4_9, arg_1_1.canvasGo_.transform)

					var_4_10.transform:SetSiblingIndex(1)

					var_4_10.name = var_4_8
					var_4_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_8] = var_4_10

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["10062"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10062 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10062", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_1_1" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -390, -290)
			end

			local var_4_14 = arg_1_1.actors_["10062"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10062 == nil then
				arg_1_1.var_.actorSpriteComps10062 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10062 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10062 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10062 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(410232001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)

				if (6 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 6)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232001", "story_v_out_410232.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_410232", "410232001", "story_v_out_410232.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_410232", "410232001", "story_v_out_410232.awb")

						arg_1_1:RecordAudio("410232001", var_4_31)
						arg_1_1:RecordAudio("410232001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410232", "410232001", "story_v_out_410232.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410232", "410232001", "story_v_out_410232.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410232002
		arg_9_1.duration_ = 4.13

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410232003(arg_9_1)
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

				arg_9_1:CheckSpriteTmpPos("1061", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_5" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_12_5 = arg_9_1.actors_["10062"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10062 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10062", 7)

				for iter_12_3 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_3)

					if var_12_6.name == "" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_12_8 = arg_9_1.actors_["1061"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps1061 == nil then
				arg_9_1.var_.actorSpriteComps1061 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.actorSpriteComps1061 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								iter_12_5.color = Color.New(Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_9), Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_9), (Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_9)))
							else
								local var_12_10 = Mathf.Lerp(iter_12_5.color.r, 1, (arg_9_1.time_ - 0) / var_12_9)

								iter_12_5.color = Color.New(var_12_10, var_12_10, var_12_10)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps1061 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_12_7 then
						iter_12_7.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps1061 = nil
			end

			local var_12_11 = arg_9_1.actors_["10062"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10062 == nil then
				arg_9_1.var_.actorSpriteComps10062 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_12 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 and not isNil(var_12_11) then
				if arg_9_1.var_.actorSpriteComps10062 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_12_9 then
							if arg_9_1.isInRecall_ then
								iter_12_9.color = Color.New(Mathf.Lerp(iter_12_9.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_12), Mathf.Lerp(iter_12_9.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_12), (Mathf.Lerp(iter_12_9.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_12)))
							else
								local var_12_13 = Mathf.Lerp(iter_12_9.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_12)

								iter_12_9.color = Color.New(var_12_13, var_12_13, var_12_13)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10062 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_12_11 then
						iter_12_11.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10062 = nil
			end

			local var_12_14 = 0
			local var_12_15 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
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

				local var_12_16 = arg_9_1:GetWordFromCfg(410232002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 7 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 7)

				if (7 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 7)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232002", "story_v_out_410232.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_410232", "410232002", "story_v_out_410232.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_410232", "410232002", "story_v_out_410232.awb")

						arg_9_1:RecordAudio("410232002", var_12_21)
						arg_9_1:RecordAudio("410232002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410232", "410232002", "story_v_out_410232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410232", "410232002", "story_v_out_410232.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_15, arg_9_1.talkMaxDuration)

			if var_12_14 <= arg_9_1.time_ and arg_9_1.time_ < var_12_14 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_14) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_14 + var_12_22 and arg_9_1.time_ < var_12_14 + var_12_22 + arg_12_0 then
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
				actorName = "10062",
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
	Play410232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410232003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1061 = arg_13_1.actors_["1061"].transform.localPosition
				arg_13_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1061", 7)

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
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_16_2 = arg_13_1.actors_["1061"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1061 == nil then
				arg_13_1.var_.actorSpriteComps1061 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1061 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1061 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps1061 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 1.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(410232003).content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 58 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 58)

				if (58 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_7) / 58)) > 0 and var_16_6 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_10 and arg_13_1.time_ < var_16_5 + var_16_10 + arg_16_0 then
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
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play410232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410232004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(410232004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410232005
		arg_21_1.duration_ = 7.1

		local var_21_0 = {
			ja = 7.1,
			CriLanguages = 6.333,
			zh = 6.333
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
				arg_21_0:Play410232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10062 = arg_21_1.actors_["10062"].transform.localPosition
				arg_21_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10062", 3)

				for iter_24_0 = 0, arg_21_1.actors_["10062"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10062"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_24_2 = arg_21_1.actors_["10062"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10062 == nil then
				arg_21_1.var_.actorSpriteComps10062 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10062 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								iter_24_2.color = Color.New(Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_2.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_2.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10062 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10062 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(410232005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 25 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 25)

				if (25 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 25)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232005", "story_v_out_410232.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232005", "story_v_out_410232.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_410232", "410232005", "story_v_out_410232.awb")

						arg_21_1:RecordAudio("410232005", var_24_12)
						arg_21_1:RecordAudio("410232005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410232", "410232005", "story_v_out_410232.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410232", "410232005", "story_v_out_410232.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410232006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410232007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10062 = arg_25_1.actors_["10062"].transform.localPosition
				arg_25_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10062", 7)

				for iter_28_0 = 0, arg_25_1.actors_["10062"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10062"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_28_2 = arg_25_1.actors_["10062"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10062 == nil then
				arg_25_1.var_.actorSpriteComps10062 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10062 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10062 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10062 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 1.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(410232006).content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 62 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 62)

				if (62 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 62)) > 0 and var_28_6 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_10 and arg_25_1.time_ < var_28_5 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410232007
		arg_29_1.duration_ = 12.43

		local var_29_0 = {
			ja = 12.433,
			CriLanguages = 4.833,
			zh = 4.833
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
				arg_29_0:Play410232008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10062 = arg_29_1.actors_["10062"].transform.localPosition
				arg_29_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10062", 3)

				for iter_32_0 = 0, arg_29_1.actors_["10062"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10062"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_5" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_32_2 = arg_29_1.actors_["10062"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10062 == nil then
				arg_29_1.var_.actorSpriteComps10062 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10062 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10062 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10062 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.45

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(410232007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 18 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 18)

				if (18 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 18)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232007", "story_v_out_410232.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232007", "story_v_out_410232.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_410232", "410232007", "story_v_out_410232.awb")

						arg_29_1:RecordAudio("410232007", var_32_12)
						arg_29_1:RecordAudio("410232007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410232", "410232007", "story_v_out_410232.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410232", "410232007", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410232008
		arg_33_1.duration_ = 7

		local var_33_0 = {
			ja = 7,
			CriLanguages = 4.966,
			zh = 4.966
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
				arg_33_0:Play410232009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10062 = arg_33_1.actors_["10062"].transform.localPosition
				arg_33_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10062", 7)

				for iter_36_0 = 0, arg_33_1.actors_["10062"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10062"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_36_2 = arg_33_1.actors_["1061"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 3)

				for iter_36_1 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_1)

					if var_36_3.name == "split_5" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, Vector3.New(0, -490, 18), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -490, 18)
			end

			local var_36_5 = arg_33_1.actors_["10062"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10062 == nil then
				arg_33_1.var_.actorSpriteComps10062 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps10062 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								iter_36_3.color = Color.New(Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_3.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_3.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10062 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_36_5 then
						iter_36_5.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10062 = nil
			end

			local var_36_8 = arg_33_1.actors_["1061"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 and not isNil(var_36_8) then
				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								iter_36_7.color = Color.New(Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_9), Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_9), (Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_9)))
							else
								local var_36_10 = Mathf.Lerp(iter_36_7.color.r, 1, (arg_33_1.time_ - 0) / var_36_9)

								iter_36_7.color = Color.New(var_36_10, var_36_10, var_36_10)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_9 then
						iter_36_9.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_11 = 0
			local var_36_12 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(410232008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 14 <= 0 and var_36_12 or var_36_12 * (utf8.len(var_36_14) / 14)

				if (14 <= 0 and var_36_12 or var_36_12 * (utf8.len(var_36_14) / 14)) > 0 and var_36_12 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232008", "story_v_out_410232.awb") ~= 0 then
					local var_36_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232008", "story_v_out_410232.awb") / 1000

					if var_36_17 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_11
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_410232", "410232008", "story_v_out_410232.awb")

						arg_33_1:RecordAudio("410232008", var_36_18)
						arg_33_1:RecordAudio("410232008", var_36_18)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410232", "410232008", "story_v_out_410232.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410232", "410232008", "story_v_out_410232.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_19 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_19 and arg_33_1.time_ < var_36_11 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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

		arg_33_1:InitPlayNodeList()
	end,
	Play410232009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410232009
		arg_37_1.duration_ = 4.9

		local var_37_0 = {
			ja = 4.9,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_37_0:Play410232010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = arg_37_1.actors_["1061"].transform.localPosition
				arg_37_1.actors_["1061"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 7)

				for iter_40_0 = 0, arg_37_1.actors_["1061"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1061"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1061"].transform.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_40_2 = arg_37_1.actors_["10062"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10062 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10062", 3)

				for iter_40_1 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_1)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_40_5 = arg_37_1.actors_["1061"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_3.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_3.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_8 = arg_37_1.actors_["10062"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10062 == nil then
				arg_37_1.var_.actorSpriteComps10062 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.actorSpriteComps10062 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								iter_40_7.color = Color.New(Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_9), Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_9), (Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_9)))
							else
								local var_40_10 = Mathf.Lerp(iter_40_7.color.r, 1, (arg_37_1.time_ - 0) / var_40_9)

								iter_40_7.color = Color.New(var_40_10, var_40_10, var_40_10)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10062 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_40_9 then
						iter_40_9.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10062 = nil
			end

			local var_40_11 = 0
			local var_40_12 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(410232009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 7 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 7)

				if (7 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 7)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232009", "story_v_out_410232.awb") ~= 0 then
					local var_40_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232009", "story_v_out_410232.awb") / 1000

					if var_40_17 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_11
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_410232", "410232009", "story_v_out_410232.awb")

						arg_37_1:RecordAudio("410232009", var_40_18)
						arg_37_1:RecordAudio("410232009", var_40_18)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410232", "410232009", "story_v_out_410232.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410232", "410232009", "story_v_out_410232.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
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
			},
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410232010
		arg_41_1.duration_ = 16.87

		local var_41_0 = {
			ja = 16.866,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_41_0:Play410232011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10062 = arg_41_1.actors_["10062"].transform.localPosition
				arg_41_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10062", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10062"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10062"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_44_2 = arg_41_1.actors_["10062"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10062 == nil then
				arg_41_1.var_.actorSpriteComps10062 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10062 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10062 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10062 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.9

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(410232010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 36 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 36)

				if (36 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 36)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232010", "story_v_out_410232.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232010", "story_v_out_410232.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_410232", "410232010", "story_v_out_410232.awb")

						arg_41_1:RecordAudio("410232010", var_44_12)
						arg_41_1:RecordAudio("410232010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410232", "410232010", "story_v_out_410232.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410232", "410232010", "story_v_out_410232.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410232011
		arg_45_1.duration_ = 12.03

		local var_45_0 = {
			ja = 12.033,
			CriLanguages = 5.133,
			zh = 5.133
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
				arg_45_0:Play410232012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10062 = arg_45_1.actors_["10062"].transform.localPosition
				arg_45_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10062", 3)

				for iter_48_0 = 0, arg_45_1.actors_["10062"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10062"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_48_2 = arg_45_1.actors_["10062"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10062 == nil then
				arg_45_1.var_.actorSpriteComps10062 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10062 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10062 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10062 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(410232011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 20 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 20)

				if (20 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 20)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232011", "story_v_out_410232.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232011", "story_v_out_410232.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_410232", "410232011", "story_v_out_410232.awb")

						arg_45_1:RecordAudio("410232011", var_48_12)
						arg_45_1:RecordAudio("410232011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410232", "410232011", "story_v_out_410232.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410232", "410232011", "story_v_out_410232.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410232012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410232013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10062 = arg_49_1.actors_["10062"].transform.localPosition
				arg_49_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10062", 7)

				for iter_52_0 = 0, arg_49_1.actors_["10062"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10062"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_52_2 = arg_49_1.actors_["10062"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10062 == nil then
				arg_49_1.var_.actorSpriteComps10062 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.034

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10062 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								iter_52_2.color = Color.New(Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_2.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_2.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10062 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_52_4 then
						iter_52_4.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10062 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 1.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(410232012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 59 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 59)

				if (59 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 59)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410232013
		arg_53_1.duration_ = 5.8

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410232014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_0 = 1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				local var_56_1 = Color.New(1, 1, 1)

				var_56_1.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.mask_.color = var_56_1
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				local var_56_2 = Color.New(1, 1, 1)

				arg_53_1.mask_.enabled = false
				var_56_2.a = 0
				arg_53_1.mask_.color = var_56_2
			end

			local var_56_3 = manager.ui.mainCamera.transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_3.localPosition
			end

			local var_56_4 = 1

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				local var_56_5, var_56_6 = math.modf((arg_53_1.time_ - 0) / 0.066)

				var_56_3.localPosition = Vector3.New(var_56_6 * 0.13, var_56_6 * 0.13, var_56_6 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_7 = 0.8
			local var_56_8 = 1.125

			if 0.8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_9 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_9:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(410232013).content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 45 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_10) / 45)

				if (45 <= 0 and var_56_8 or var_56_8 * (utf8.len(var_56_10) / 45)) > 0 and var_56_8 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12
					var_56_7 = var_56_7 + 0.3

					if var_56_12 + var_56_7 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_7
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = var_56_7 + 0.3
			local var_56_14 = math.max(var_56_8, arg_53_1.talkMaxDuration)

			if var_56_7 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_13 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_13) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_13 + var_56_14 and arg_53_1.time_ < var_56_13 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410232014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410232014
		arg_59_1.duration_ = 13.6

		local var_59_0 = {
			ja = 13.6,
			CriLanguages = 8.366,
			zh = 8.366
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
				arg_59_0:Play410232015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10062 = arg_59_1.actors_["10062"].transform.localPosition
				arg_59_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10062", 2)

				for iter_62_0 = 0, arg_59_1.actors_["10062"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["10062"].transform:GetChild(iter_62_0)

					if var_62_0.name == "" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_62_2 = "10059"

			if arg_59_1.actors_["10059"] == nil then
				local var_62_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_62_3) then
					local var_62_4 = Object.Instantiate(var_62_3, arg_59_1.canvasGo_.transform)

					var_62_4.transform:SetSiblingIndex(1)

					var_62_4.name = var_62_2
					var_62_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_59_1.actors_[var_62_2] = var_62_4

					if arg_59_1.isInRecall_ then
						for iter_62_1, iter_62_2 in ipairs((var_62_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_62_2.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_62_5 = arg_59_1.actors_["10059"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10059 = var_62_5.localPosition
				var_62_5.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10059", 4)

				for iter_62_3 = 0, var_62_5.childCount - 1 do
					local var_62_6 = var_62_5:GetChild(iter_62_3)

					if var_62_6.name == "" or not string.find(var_62_6.name, "split") then
						var_62_6.gameObject:SetActive(true)
					else
						var_62_6.gameObject:SetActive(false)
					end
				end
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_59_1.time_ - 0) / var_62_7)
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(390, -530, 35)
			end

			local var_62_8 = arg_59_1.actors_["10062"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10062 == nil then
				arg_59_1.var_.actorSpriteComps10062 = var_62_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_9 = 0.034

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_9 and not isNil(var_62_8) then
				if arg_59_1.var_.actorSpriteComps10062 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								iter_62_5.color = Color.New(Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_9), Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_9), (Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_9)))
							else
								local var_62_10 = Mathf.Lerp(iter_62_5.color.r, 1, (arg_59_1.time_ - 0) / var_62_9)

								iter_62_5.color = Color.New(var_62_10, var_62_10, var_62_10)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_9 and arg_59_1.time_ < 0 + var_62_9 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10062 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_62_7 then
						iter_62_7.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps10062 = nil
			end

			local var_62_11 = arg_59_1.actors_["10059"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_11) and arg_59_1.var_.actorSpriteComps10059 == nil then
				arg_59_1.var_.actorSpriteComps10059 = var_62_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_12 = 0.034

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_12 and not isNil(var_62_11) then
				if arg_59_1.var_.actorSpriteComps10059 then
					for iter_62_8, iter_62_9 in pairs(arg_59_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_62_9 then
							if arg_59_1.isInRecall_ then
								iter_62_9.color = Color.New(Mathf.Lerp(iter_62_9.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_12), Mathf.Lerp(iter_62_9.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_12), (Mathf.Lerp(iter_62_9.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_12)))
							else
								local var_62_13 = Mathf.Lerp(iter_62_9.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_12)

								iter_62_9.color = Color.New(var_62_13, var_62_13, var_62_13)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_12 and arg_59_1.time_ < 0 + var_62_12 + arg_62_0 and not isNil(var_62_11) and arg_59_1.var_.actorSpriteComps10059 then
				for iter_62_10, iter_62_11 in pairs(arg_59_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_62_11 then
						iter_62_11.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10059 = nil
			end

			local var_62_14 = 0
			local var_62_15 = 0.9

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_16 = arg_59_1:GetWordFromCfg(410232014)
				local var_62_17 = arg_59_1:FormatText(var_62_16.content)

				arg_59_1.text_.text = var_62_17

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_19 = 36 <= 0 and var_62_15 or var_62_15 * (utf8.len(var_62_17) / 36)

				if (36 <= 0 and var_62_15 or var_62_15 * (utf8.len(var_62_17) / 36)) > 0 and var_62_15 < var_62_19 then
					arg_59_1.talkMaxDuration = var_62_19

					if var_62_19 + var_62_14 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_14
					end
				end

				arg_59_1.text_.text = var_62_17
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232014", "story_v_out_410232.awb") ~= 0 then
					local var_62_20 = manager.audio:GetVoiceLength("story_v_out_410232", "410232014", "story_v_out_410232.awb") / 1000

					if var_62_20 + var_62_14 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_20 + var_62_14
					end

					if var_62_16.prefab_name ~= "" and arg_59_1.actors_[var_62_16.prefab_name] ~= nil then
						local var_62_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_16.prefab_name].transform, "story_v_out_410232", "410232014", "story_v_out_410232.awb")

						arg_59_1:RecordAudio("410232014", var_62_21)
						arg_59_1:RecordAudio("410232014", var_62_21)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_410232", "410232014", "story_v_out_410232.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_410232", "410232014", "story_v_out_410232.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_22 = math.max(var_62_15, arg_59_1.talkMaxDuration)

			if var_62_14 <= arg_59_1.time_ and arg_59_1.time_ < var_62_14 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_14) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_14 + var_62_22 and arg_59_1.time_ < var_62_14 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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

		arg_59_1:InitPlayNodeList()
	end,
	Play410232015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410232015
		arg_63_1.duration_ = 1.6

		local var_63_0 = {
			ja = 1.566,
			CriLanguages = 1.6,
			zh = 1.6
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
				arg_63_0:Play410232016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10059 = arg_63_1.actors_["10059"].transform.localPosition
				arg_63_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10059", 4)

				for iter_66_0 = 0, arg_63_1.actors_["10059"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["10059"].transform:GetChild(iter_66_0)

					if var_66_0.name == "" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_66_2 = arg_63_1.actors_["10059"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10059 == nil then
				arg_63_1.var_.actorSpriteComps10059 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.034

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10059 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								iter_66_2.color = Color.New(Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_2.color.r, 1, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_2.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10059 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_66_4 then
						iter_66_4.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10059 = nil
			end

			local var_66_5 = arg_63_1.actors_["10062"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.actorSpriteComps10062 == nil then
				arg_63_1.var_.actorSpriteComps10062 = var_66_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_6 = 0.034

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.actorSpriteComps10062 then
					for iter_66_5, iter_66_6 in pairs(arg_63_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_66_6 then
							if arg_63_1.isInRecall_ then
								iter_66_6.color = Color.New(Mathf.Lerp(iter_66_6.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_6), Mathf.Lerp(iter_66_6.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_6), (Mathf.Lerp(iter_66_6.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_6)))
							else
								local var_66_7 = Mathf.Lerp(iter_66_6.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_6)

								iter_66_6.color = Color.New(var_66_7, var_66_7, var_66_7)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.actorSpriteComps10062 then
				for iter_66_7, iter_66_8 in pairs(arg_63_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_66_8 then
						iter_66_8.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10062 = nil
			end

			local var_66_8 = 0
			local var_66_9 = 0.175

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(410232015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 7 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 7)

				if (7 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 7)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232015", "story_v_out_410232.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232015", "story_v_out_410232.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_410232", "410232015", "story_v_out_410232.awb")

						arg_63_1:RecordAudio("410232015", var_66_15)
						arg_63_1:RecordAudio("410232015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410232", "410232015", "story_v_out_410232.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410232", "410232015", "story_v_out_410232.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play410232016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410232016
		arg_67_1.duration_ = 13.3

		local var_67_0 = {
			ja = 13.3,
			CriLanguages = 8.2,
			zh = 8.2
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
				arg_67_0:Play410232017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10062 = arg_67_1.actors_["10062"].transform.localPosition
				arg_67_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10062", 2)

				for iter_70_0 = 0, arg_67_1.actors_["10062"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["10062"].transform:GetChild(iter_70_0)

					if var_70_0.name == "" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_70_2 = arg_67_1.actors_["10059"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps10059 == nil then
				arg_67_1.var_.actorSpriteComps10059 = var_70_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_3 = 0.034

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.actorSpriteComps10059 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								iter_70_2.color = Color.New(Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor2.r, (arg_67_1.time_ - 0) / var_70_3), Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor2.g, (arg_67_1.time_ - 0) / var_70_3), (Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor2.b, (arg_67_1.time_ - 0) / var_70_3)))
							else
								local var_70_4 = Mathf.Lerp(iter_70_2.color.r, 0.5, (arg_67_1.time_ - 0) / var_70_3)

								iter_70_2.color = Color.New(var_70_4, var_70_4, var_70_4)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps10059 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_70_4 then
						iter_70_4.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_67_1.var_.actorSpriteComps10059 = nil
			end

			local var_70_5 = arg_67_1.actors_["10062"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps10062 == nil then
				arg_67_1.var_.actorSpriteComps10062 = var_70_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_6 = 0.034

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.actorSpriteComps10062 then
					for iter_70_5, iter_70_6 in pairs(arg_67_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_70_6 then
							if arg_67_1.isInRecall_ then
								iter_70_6.color = Color.New(Mathf.Lerp(iter_70_6.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_6), Mathf.Lerp(iter_70_6.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_6), (Mathf.Lerp(iter_70_6.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_6)))
							else
								local var_70_7 = Mathf.Lerp(iter_70_6.color.r, 1, (arg_67_1.time_ - 0) / var_70_6)

								iter_70_6.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.actorSpriteComps10062 then
				for iter_70_7, iter_70_8 in pairs(arg_67_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_70_8 then
						iter_70_8.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps10062 = nil
			end

			local var_70_8 = 0
			local var_70_9 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(410232016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 32 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 32)

				if (32 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 32)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232016", "story_v_out_410232.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232016", "story_v_out_410232.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_410232", "410232016", "story_v_out_410232.awb")

						arg_67_1:RecordAudio("410232016", var_70_15)
						arg_67_1:RecordAudio("410232016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_410232", "410232016", "story_v_out_410232.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_410232", "410232016", "story_v_out_410232.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410232017
		arg_71_1.duration_ = 17.67

		local var_71_0 = {
			ja = 17.666,
			CriLanguages = 9.2,
			zh = 9.2
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
				arg_71_0:Play410232018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10062 = arg_71_1.actors_["10062"].transform.localPosition
				arg_71_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10062", 2)

				for iter_74_0 = 0, arg_71_1.actors_["10062"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["10062"].transform:GetChild(iter_74_0)

					if var_74_0.name == "" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_74_2 = arg_71_1.actors_["10062"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10062 == nil then
				arg_71_1.var_.actorSpriteComps10062 = var_74_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_3 = 0.034

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.actorSpriteComps10062 then
					for iter_74_1, iter_74_2 in pairs(arg_71_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_74_2 then
							if arg_71_1.isInRecall_ then
								iter_74_2.color = Color.New(Mathf.Lerp(iter_74_2.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_3), Mathf.Lerp(iter_74_2.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_3), (Mathf.Lerp(iter_74_2.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_3)))
							else
								local var_74_4 = Mathf.Lerp(iter_74_2.color.r, 1, (arg_71_1.time_ - 0) / var_74_3)

								iter_74_2.color = Color.New(var_74_4, var_74_4, var_74_4)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.actorSpriteComps10062 then
				for iter_74_3, iter_74_4 in pairs(arg_71_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_74_4 then
						iter_74_4.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps10062 = nil
			end

			local var_74_5 = 0
			local var_74_6 = 1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(410232017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 40 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 40)

				if (40 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 40)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232017", "story_v_out_410232.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232017", "story_v_out_410232.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_410232", "410232017", "story_v_out_410232.awb")

						arg_71_1:RecordAudio("410232017", var_74_12)
						arg_71_1:RecordAudio("410232017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410232", "410232017", "story_v_out_410232.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410232", "410232017", "story_v_out_410232.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410232018
		arg_75_1.duration_ = 1.63

		local var_75_0 = {
			ja = 1.4,
			CriLanguages = 1.633,
			zh = 1.633
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
				arg_75_0:Play410232019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10059 = arg_75_1.actors_["10059"].transform.localPosition
				arg_75_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10059", 4)

				for iter_78_0 = 0, arg_75_1.actors_["10059"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["10059"].transform:GetChild(iter_78_0)

					if var_78_0.name == "" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["10059"].transform.localPosition = Vector3.New(390, -530, 35)
			end

			local var_78_2 = arg_75_1.actors_["10059"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10059 == nil then
				arg_75_1.var_.actorSpriteComps10059 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps10059 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								iter_78_2.color = Color.New(Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_2.color.r, 1, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_2.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10059 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps10059 = nil
			end

			local var_78_5 = arg_75_1.actors_["10062"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.actorSpriteComps10062 == nil then
				arg_75_1.var_.actorSpriteComps10062 = var_78_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_6 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.actorSpriteComps10062 then
					for iter_78_5, iter_78_6 in pairs(arg_75_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_78_6 then
							if arg_75_1.isInRecall_ then
								iter_78_6.color = Color.New(Mathf.Lerp(iter_78_6.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_6), Mathf.Lerp(iter_78_6.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_6), (Mathf.Lerp(iter_78_6.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_6)))
							else
								local var_78_7 = Mathf.Lerp(iter_78_6.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_6)

								iter_78_6.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.actorSpriteComps10062 then
				for iter_78_7, iter_78_8 in pairs(arg_75_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_78_8 then
						iter_78_8.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps10062 = nil
			end

			local var_78_8 = 0
			local var_78_9 = 0.1

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(410232018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 4 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 4)

				if (4 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 4)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232018", "story_v_out_410232.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232018", "story_v_out_410232.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_410232", "410232018", "story_v_out_410232.awb")

						arg_75_1:RecordAudio("410232018", var_78_15)
						arg_75_1:RecordAudio("410232018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410232", "410232018", "story_v_out_410232.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410232", "410232018", "story_v_out_410232.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play410232019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410232019
		arg_79_1.duration_ = 3.57

		local var_79_0 = {
			ja = 3.566,
			CriLanguages = 1.833,
			zh = 1.833
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410232020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10062 = arg_79_1.actors_["10062"].transform.localPosition
				arg_79_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10062", 7)

				for iter_82_0 = 0, arg_79_1.actors_["10062"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10062"].transform:GetChild(iter_82_0)

					if var_82_0.name == "" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10062"].transform.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_82_2 = arg_79_1.actors_["10059"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10059 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10059", 7)

				for iter_82_1 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_1)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_82_5 = "10060"

			if arg_79_1.actors_["10060"] == nil then
				local var_82_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_82_6) then
					local var_82_7 = Object.Instantiate(var_82_6, arg_79_1.canvasGo_.transform)

					var_82_7.transform:SetSiblingIndex(1)

					var_82_7.name = var_82_5
					var_82_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_79_1.actors_[var_82_5] = var_82_7

					if arg_79_1.isInRecall_ then
						for iter_82_2, iter_82_3 in ipairs((var_82_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_82_3.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_82_8 = arg_79_1.actors_["10060"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10060 = var_82_8.localPosition
				var_82_8.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10060", 3)

				for iter_82_4 = 0, var_82_8.childCount - 1 do
					local var_82_9 = var_82_8:GetChild(iter_82_4)

					if var_82_9.name == "split_5" or not string.find(var_82_9.name, "split") then
						var_82_9.gameObject:SetActive(true)
					else
						var_82_9.gameObject:SetActive(false)
					end
				end
			end

			local var_82_10 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_10 then
				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_79_1.time_ - 0) / var_82_10)
			end

			if arg_79_1.time_ >= 0 + var_82_10 and arg_79_1.time_ < 0 + var_82_10 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, -400, 0)
			end

			local var_82_11 = arg_79_1.actors_["10062"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.actorSpriteComps10062 == nil then
				arg_79_1.var_.actorSpriteComps10062 = var_82_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_12 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_12 and not isNil(var_82_11) then
				if arg_79_1.var_.actorSpriteComps10062 then
					for iter_82_5, iter_82_6 in pairs(arg_79_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_82_6 then
							if arg_79_1.isInRecall_ then
								iter_82_6.color = Color.New(Mathf.Lerp(iter_82_6.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_12), Mathf.Lerp(iter_82_6.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_12), (Mathf.Lerp(iter_82_6.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_12)))
							else
								local var_82_13 = Mathf.Lerp(iter_82_6.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_12)

								iter_82_6.color = Color.New(var_82_13, var_82_13, var_82_13)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_12 and arg_79_1.time_ < 0 + var_82_12 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.actorSpriteComps10062 then
				for iter_82_7, iter_82_8 in pairs(arg_79_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_82_8 then
						iter_82_8.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps10062 = nil
			end

			local var_82_14 = arg_79_1.actors_["10059"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_14) and arg_79_1.var_.actorSpriteComps10059 == nil then
				arg_79_1.var_.actorSpriteComps10059 = var_82_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_15 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_15 and not isNil(var_82_14) then
				if arg_79_1.var_.actorSpriteComps10059 then
					for iter_82_9, iter_82_10 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_82_10 then
							if arg_79_1.isInRecall_ then
								iter_82_10.color = Color.New(Mathf.Lerp(iter_82_10.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_15), Mathf.Lerp(iter_82_10.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_15), (Mathf.Lerp(iter_82_10.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_15)))
							else
								local var_82_16 = Mathf.Lerp(iter_82_10.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_15)

								iter_82_10.color = Color.New(var_82_16, var_82_16, var_82_16)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_15 and arg_79_1.time_ < 0 + var_82_15 + arg_82_0 and not isNil(var_82_14) and arg_79_1.var_.actorSpriteComps10059 then
				for iter_82_11, iter_82_12 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_82_12 then
						iter_82_12.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps10059 = nil
			end

			local var_82_17 = arg_79_1.actors_["10060"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_17) and arg_79_1.var_.actorSpriteComps10060 == nil then
				arg_79_1.var_.actorSpriteComps10060 = var_82_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_18 = 0.034

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_18 and not isNil(var_82_17) then
				if arg_79_1.var_.actorSpriteComps10060 then
					for iter_82_13, iter_82_14 in pairs(arg_79_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_82_14 then
							if arg_79_1.isInRecall_ then
								iter_82_14.color = Color.New(Mathf.Lerp(iter_82_14.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_18), Mathf.Lerp(iter_82_14.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_18), (Mathf.Lerp(iter_82_14.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_18)))
							else
								local var_82_19 = Mathf.Lerp(iter_82_14.color.r, 1, (arg_79_1.time_ - 0) / var_82_18)

								iter_82_14.color = Color.New(var_82_19, var_82_19, var_82_19)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_18 and arg_79_1.time_ < 0 + var_82_18 + arg_82_0 and not isNil(var_82_17) and arg_79_1.var_.actorSpriteComps10060 then
				for iter_82_15, iter_82_16 in pairs(arg_79_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_82_16 then
						iter_82_16.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps10060 = nil
			end

			local var_82_20 = 0
			local var_82_21 = 0.225

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_22 = arg_79_1:GetWordFromCfg(410232019)
				local var_82_23 = arg_79_1:FormatText(var_82_22.content)

				arg_79_1.text_.text = var_82_23

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 9 <= 0 and var_82_21 or var_82_21 * (utf8.len(var_82_23) / 9)

				if (9 <= 0 and var_82_21 or var_82_21 * (utf8.len(var_82_23) / 9)) > 0 and var_82_21 < var_82_25 then
					arg_79_1.talkMaxDuration = var_82_25

					if var_82_25 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_25 + var_82_20
					end
				end

				arg_79_1.text_.text = var_82_23
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232019", "story_v_out_410232.awb") ~= 0 then
					local var_82_26 = manager.audio:GetVoiceLength("story_v_out_410232", "410232019", "story_v_out_410232.awb") / 1000

					if var_82_26 + var_82_20 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_26 + var_82_20
					end

					if var_82_22.prefab_name ~= "" and arg_79_1.actors_[var_82_22.prefab_name] ~= nil then
						local var_82_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_22.prefab_name].transform, "story_v_out_410232", "410232019", "story_v_out_410232.awb")

						arg_79_1:RecordAudio("410232019", var_82_27)
						arg_79_1:RecordAudio("410232019", var_82_27)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410232", "410232019", "story_v_out_410232.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410232", "410232019", "story_v_out_410232.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_28 = math.max(var_82_21, arg_79_1.talkMaxDuration)

			if var_82_20 <= arg_79_1.time_ and arg_79_1.time_ < var_82_20 + var_82_28 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_20) / var_82_28

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_20 + var_82_28 and arg_79_1.time_ < var_82_20 + var_82_28 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
			},
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

		arg_79_1:InitPlayNodeList()
	end,
	Play410232020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410232020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play410232021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10060"]) and arg_83_1.var_.actorSpriteComps10060 == nil then
				arg_83_1.var_.actorSpriteComps10060 = arg_83_1.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.034

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10060"]) then
				if arg_83_1.var_.actorSpriteComps10060 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10060"]) and arg_83_1.var_.actorSpriteComps10060 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps10060 = nil
			end

			local var_86_2 = 0
			local var_86_3 = 1.525

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(410232020).content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 61 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 61)

				if (61 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 61)) > 0 and var_86_3 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_7 and arg_83_1.time_ < var_86_2 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play410232021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410232021
		arg_87_1.duration_ = 9.53

		local var_87_0 = {
			ja = 9.533,
			CriLanguages = 5.066,
			zh = 5.066
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
				arg_87_0:Play410232022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10060 = arg_87_1.actors_["10060"].transform.localPosition
				arg_87_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10060", 7)

				for iter_90_0 = 0, arg_87_1.actors_["10060"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["10060"].transform:GetChild(iter_90_0)

					if var_90_0.name == "" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_2 = arg_87_1.actors_["10062"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10062 = var_90_2.localPosition
				var_90_2.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10062", 3)

				for iter_90_1 = 0, var_90_2.childCount - 1 do
					local var_90_3 = var_90_2:GetChild(iter_90_1)

					if var_90_3.name == "split_1_1" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_87_1.time_ - 0) / var_90_4)
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_90_5 = arg_87_1.actors_["10060"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps10060 == nil then
				arg_87_1.var_.actorSpriteComps10060 = var_90_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.actorSpriteComps10060 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								iter_90_3.color = Color.New(Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_6), Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_6), (Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_6)))
							else
								local var_90_7 = Mathf.Lerp(iter_90_3.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_6)

								iter_90_3.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps10060 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_90_5 then
						iter_90_5.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps10060 = nil
			end

			local var_90_8 = arg_87_1.actors_["10062"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10062 == nil then
				arg_87_1.var_.actorSpriteComps10062 = var_90_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.034

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_9 and not isNil(var_90_8) then
				if arg_87_1.var_.actorSpriteComps10062 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								iter_90_7.color = Color.New(Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_9), Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_9), (Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_9)))
							else
								local var_90_10 = Mathf.Lerp(iter_90_7.color.r, 1, (arg_87_1.time_ - 0) / var_90_9)

								iter_90_7.color = Color.New(var_90_10, var_90_10, var_90_10)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_9 and arg_87_1.time_ < 0 + var_90_9 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps10062 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_90_9 then
						iter_90_9.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps10062 = nil
			end

			local var_90_11 = 0
			local var_90_12 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_13 = arg_87_1:GetWordFromCfg(410232021)
				local var_90_14 = arg_87_1:FormatText(var_90_13.content)

				arg_87_1.text_.text = var_90_14

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_16 = 21 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 21)

				if (21 <= 0 and var_90_12 or var_90_12 * (utf8.len(var_90_14) / 21)) > 0 and var_90_12 < var_90_16 then
					arg_87_1.talkMaxDuration = var_90_16

					if var_90_16 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_11
					end
				end

				arg_87_1.text_.text = var_90_14
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232021", "story_v_out_410232.awb") ~= 0 then
					local var_90_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232021", "story_v_out_410232.awb") / 1000

					if var_90_17 + var_90_11 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_17 + var_90_11
					end

					if var_90_13.prefab_name ~= "" and arg_87_1.actors_[var_90_13.prefab_name] ~= nil then
						local var_90_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_13.prefab_name].transform, "story_v_out_410232", "410232021", "story_v_out_410232.awb")

						arg_87_1:RecordAudio("410232021", var_90_18)
						arg_87_1:RecordAudio("410232021", var_90_18)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410232", "410232021", "story_v_out_410232.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410232", "410232021", "story_v_out_410232.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = math.max(var_90_12, arg_87_1.talkMaxDuration)

			if var_90_11 <= arg_87_1.time_ and arg_87_1.time_ < var_90_11 + var_90_19 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_11) / var_90_19

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_11 + var_90_19 and arg_87_1.time_ < var_90_11 + var_90_19 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410232022
		arg_91_1.duration_ = 3.23

		local var_91_0 = {
			ja = 3.233,
			CriLanguages = 3.166,
			zh = 3.166
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
				arg_91_0:Play410232023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10060 = arg_91_1.actors_["10060"].transform.localPosition
				arg_91_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10060", 3)

				for iter_94_0 = 0, arg_91_1.actors_["10060"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["10060"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_3" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["10060"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_94_2 = arg_91_1.actors_["10062"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10062 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10062", 7)

				for iter_94_1 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_1)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_94_5 = arg_91_1.actors_["10060"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps10060 == nil then
				arg_91_1.var_.actorSpriteComps10060 = var_94_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_6 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.actorSpriteComps10060 then
					for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_94_3 then
							if arg_91_1.isInRecall_ then
								iter_94_3.color = Color.New(Mathf.Lerp(iter_94_3.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_6), Mathf.Lerp(iter_94_3.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_6), (Mathf.Lerp(iter_94_3.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_6)))
							else
								local var_94_7 = Mathf.Lerp(iter_94_3.color.r, 1, (arg_91_1.time_ - 0) / var_94_6)

								iter_94_3.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps10060 then
				for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_94_5 then
						iter_94_5.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10060 = nil
			end

			local var_94_8 = arg_91_1.actors_["10062"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10062 == nil then
				arg_91_1.var_.actorSpriteComps10062 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 and not isNil(var_94_8) then
				if arg_91_1.var_.actorSpriteComps10062 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								iter_94_7.color = Color.New(Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_9), Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_9), (Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_9)))
							else
								local var_94_10 = Mathf.Lerp(iter_94_7.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_9)

								iter_94_7.color = Color.New(var_94_10, var_94_10, var_94_10)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10062 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_94_9 then
						iter_94_9.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10062 = nil
			end

			local var_94_11 = 0
			local var_94_12 = 0.325

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_13 = arg_91_1:GetWordFromCfg(410232022)
				local var_94_14 = arg_91_1:FormatText(var_94_13.content)

				arg_91_1.text_.text = var_94_14

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_16 = 13 <= 0 and var_94_12 or var_94_12 * (utf8.len(var_94_14) / 13)

				if (13 <= 0 and var_94_12 or var_94_12 * (utf8.len(var_94_14) / 13)) > 0 and var_94_12 < var_94_16 then
					arg_91_1.talkMaxDuration = var_94_16

					if var_94_16 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_11
					end
				end

				arg_91_1.text_.text = var_94_14
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232022", "story_v_out_410232.awb") ~= 0 then
					local var_94_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232022", "story_v_out_410232.awb") / 1000

					if var_94_17 + var_94_11 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_11
					end

					if var_94_13.prefab_name ~= "" and arg_91_1.actors_[var_94_13.prefab_name] ~= nil then
						local var_94_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_13.prefab_name].transform, "story_v_out_410232", "410232022", "story_v_out_410232.awb")

						arg_91_1:RecordAudio("410232022", var_94_18)
						arg_91_1:RecordAudio("410232022", var_94_18)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410232", "410232022", "story_v_out_410232.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410232", "410232022", "story_v_out_410232.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_19 = math.max(var_94_12, arg_91_1.talkMaxDuration)

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_19 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_11) / var_94_19

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_11 + var_94_19 and arg_91_1.time_ < var_94_11 + var_94_19 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410232023
		arg_95_1.duration_ = 9.13

		local var_95_0 = {
			ja = 9.133,
			CriLanguages = 5.266,
			zh = 5.266
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
				arg_95_0:Play410232024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10060 = arg_95_1.actors_["10060"].transform.localPosition
				arg_95_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10060", 7)

				for iter_98_0 = 0, arg_95_1.actors_["10060"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["10060"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_2 = arg_95_1.actors_["10062"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10062 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10062", 3)

				for iter_98_1 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_1)

					if var_98_3.name == "split_5" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_98_5 = arg_95_1.actors_["10060"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10060 == nil then
				arg_95_1.var_.actorSpriteComps10060 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps10060 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								iter_98_3.color = Color.New(Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_6), Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_6), (Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_3.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_6)

								iter_98_3.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps10060 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_98_5 then
						iter_98_5.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10060 = nil
			end

			local var_98_8 = arg_95_1.actors_["10062"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps10062 == nil then
				arg_95_1.var_.actorSpriteComps10062 = var_98_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_9 and not isNil(var_98_8) then
				if arg_95_1.var_.actorSpriteComps10062 then
					for iter_98_6, iter_98_7 in pairs(arg_95_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_98_7 then
							if arg_95_1.isInRecall_ then
								iter_98_7.color = Color.New(Mathf.Lerp(iter_98_7.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_9), Mathf.Lerp(iter_98_7.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_9), (Mathf.Lerp(iter_98_7.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_9)))
							else
								local var_98_10 = Mathf.Lerp(iter_98_7.color.r, 1, (arg_95_1.time_ - 0) / var_98_9)

								iter_98_7.color = Color.New(var_98_10, var_98_10, var_98_10)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_9 and arg_95_1.time_ < 0 + var_98_9 + arg_98_0 and not isNil(var_98_8) and arg_95_1.var_.actorSpriteComps10062 then
				for iter_98_8, iter_98_9 in pairs(arg_95_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_98_9 then
						iter_98_9.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps10062 = nil
			end

			local var_98_11 = 0
			local var_98_12 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_13 = arg_95_1:GetWordFromCfg(410232023)
				local var_98_14 = arg_95_1:FormatText(var_98_13.content)

				arg_95_1.text_.text = var_98_14

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_16 = 22 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 22)

				if (22 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 22)) > 0 and var_98_12 < var_98_16 then
					arg_95_1.talkMaxDuration = var_98_16

					if var_98_16 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_16 + var_98_11
					end
				end

				arg_95_1.text_.text = var_98_14
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232023", "story_v_out_410232.awb") ~= 0 then
					local var_98_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232023", "story_v_out_410232.awb") / 1000

					if var_98_17 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_17 + var_98_11
					end

					if var_98_13.prefab_name ~= "" and arg_95_1.actors_[var_98_13.prefab_name] ~= nil then
						local var_98_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_13.prefab_name].transform, "story_v_out_410232", "410232023", "story_v_out_410232.awb")

						arg_95_1:RecordAudio("410232023", var_98_18)
						arg_95_1:RecordAudio("410232023", var_98_18)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410232", "410232023", "story_v_out_410232.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410232", "410232023", "story_v_out_410232.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_19 = math.max(var_98_12, arg_95_1.talkMaxDuration)

			if var_98_11 <= arg_95_1.time_ and arg_95_1.time_ < var_98_11 + var_98_19 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_11) / var_98_19

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_11 + var_98_19 and arg_95_1.time_ < var_98_11 + var_98_19 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410232024
		arg_99_1.duration_ = 2.9

		local var_99_0 = {
			ja = 2.866,
			CriLanguages = 2.9,
			zh = 2.9
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
				arg_99_0:Play410232025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10060 = arg_99_1.actors_["10060"].transform.localPosition
				arg_99_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10060", 2)

				for iter_102_0 = 0, arg_99_1.actors_["10060"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["10060"].transform:GetChild(iter_102_0)

					if var_102_0.name == "" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10060, Vector3.New(-390, -400, 0), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["10060"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_102_2 = arg_99_1.actors_["10059"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10059 = var_102_2.localPosition
				var_102_2.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10059", 4)

				for iter_102_1 = 0, var_102_2.childCount - 1 do
					local var_102_3 = var_102_2:GetChild(iter_102_1)

					if var_102_3.name == "split_4" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10059, Vector3.New(390, -530, 35), (arg_99_1.time_ - 0) / var_102_4)
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(390, -530, 35)
			end

			local var_102_5 = arg_99_1.actors_["10060"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.actorSpriteComps10060 == nil then
				arg_99_1.var_.actorSpriteComps10060 = var_102_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_6 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.actorSpriteComps10060 then
					for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_102_3 then
							if arg_99_1.isInRecall_ then
								iter_102_3.color = Color.New(Mathf.Lerp(iter_102_3.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_6), Mathf.Lerp(iter_102_3.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_6), (Mathf.Lerp(iter_102_3.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_6)))
							else
								local var_102_7 = Mathf.Lerp(iter_102_3.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_6)

								iter_102_3.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.actorSpriteComps10060 then
				for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_102_5 then
						iter_102_5.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps10060 = nil
			end

			local var_102_8 = arg_99_1.actors_["10059"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps10059 == nil then
				arg_99_1.var_.actorSpriteComps10059 = var_102_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_9 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_9 and not isNil(var_102_8) then
				if arg_99_1.var_.actorSpriteComps10059 then
					for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_102_7 then
							if arg_99_1.isInRecall_ then
								iter_102_7.color = Color.New(Mathf.Lerp(iter_102_7.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_9), Mathf.Lerp(iter_102_7.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_9), (Mathf.Lerp(iter_102_7.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_9)))
							else
								local var_102_10 = Mathf.Lerp(iter_102_7.color.r, 1, (arg_99_1.time_ - 0) / var_102_9)

								iter_102_7.color = Color.New(var_102_10, var_102_10, var_102_10)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_9 and arg_99_1.time_ < 0 + var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps10059 then
				for iter_102_8, iter_102_9 in pairs(arg_99_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_102_9 then
						iter_102_9.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps10059 = nil
			end

			local var_102_11 = arg_99_1.actors_["10062"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10062 = var_102_11.localPosition
				var_102_11.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10062", 7)

				for iter_102_10 = 0, var_102_11.childCount - 1 do
					local var_102_12 = var_102_11:GetChild(iter_102_10)

					if var_102_12.name == "split_5" or not string.find(var_102_12.name, "split") then
						var_102_12.gameObject:SetActive(true)
					else
						var_102_12.gameObject:SetActive(false)
					end
				end
			end

			local var_102_13 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_13 then
				var_102_11.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_99_1.time_ - 0) / var_102_13)
			end

			if arg_99_1.time_ >= 0 + var_102_13 and arg_99_1.time_ < 0 + var_102_13 + arg_102_0 then
				var_102_11.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_102_14 = 0
			local var_102_15 = 0.275

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_16 = arg_99_1:GetWordFromCfg(410232024)
				local var_102_17 = arg_99_1:FormatText(var_102_16.content)

				arg_99_1.text_.text = var_102_17

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_19 = 11 <= 0 and var_102_15 or var_102_15 * (utf8.len(var_102_17) / 11)

				if (11 <= 0 and var_102_15 or var_102_15 * (utf8.len(var_102_17) / 11)) > 0 and var_102_15 < var_102_19 then
					arg_99_1.talkMaxDuration = var_102_19

					if var_102_19 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_19 + var_102_14
					end
				end

				arg_99_1.text_.text = var_102_17
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232024", "story_v_out_410232.awb") ~= 0 then
					local var_102_20 = manager.audio:GetVoiceLength("story_v_out_410232", "410232024", "story_v_out_410232.awb") / 1000

					if var_102_20 + var_102_14 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_20 + var_102_14
					end

					if var_102_16.prefab_name ~= "" and arg_99_1.actors_[var_102_16.prefab_name] ~= nil then
						local var_102_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_16.prefab_name].transform, "story_v_out_410232", "410232024", "story_v_out_410232.awb")

						arg_99_1:RecordAudio("410232024", var_102_21)
						arg_99_1:RecordAudio("410232024", var_102_21)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410232", "410232024", "story_v_out_410232.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410232", "410232024", "story_v_out_410232.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_22 = math.max(var_102_15, arg_99_1.talkMaxDuration)

			if var_102_14 <= arg_99_1.time_ and arg_99_1.time_ < var_102_14 + var_102_22 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_14) / var_102_22

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_14 + var_102_22 and arg_99_1.time_ < var_102_14 + var_102_22 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play410232025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410232025
		arg_103_1.duration_ = 4.7

		local var_103_0 = {
			ja = 4.7,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_103_0:Play410232026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10062 = arg_103_1.actors_["10062"].transform.localPosition
				arg_103_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10062", 3)

				for iter_106_0 = 0, arg_103_1.actors_["10062"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["10062"].transform:GetChild(iter_106_0)

					if var_106_0.name == "" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["10062"].transform.localPosition = Vector3.New(0, -390, -290)
			end

			local var_106_2 = arg_103_1.actors_["10060"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10060 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10060", 7)

				for iter_106_1 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_1)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_106_5 = arg_103_1.actors_["10059"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10059 = var_106_5.localPosition
				var_106_5.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10059", 7)

				for iter_106_2 = 0, var_106_5.childCount - 1 do
					local var_106_6 = var_106_5:GetChild(iter_106_2)

					if var_106_6.name == "" or not string.find(var_106_6.name, "split") then
						var_106_6.gameObject:SetActive(true)
					else
						var_106_6.gameObject:SetActive(false)
					end
				end
			end

			local var_106_7 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				var_106_5.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_103_1.time_ - 0) / var_106_7)
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				var_106_5.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_106_8 = arg_103_1.actors_["10062"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10062 == nil then
				arg_103_1.var_.actorSpriteComps10062 = var_106_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_9 and not isNil(var_106_8) then
				if arg_103_1.var_.actorSpriteComps10062 then
					for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_106_4 then
							if arg_103_1.isInRecall_ then
								iter_106_4.color = Color.New(Mathf.Lerp(iter_106_4.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_9), Mathf.Lerp(iter_106_4.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_9), (Mathf.Lerp(iter_106_4.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_9)))
							else
								local var_106_10 = Mathf.Lerp(iter_106_4.color.r, 1, (arg_103_1.time_ - 0) / var_106_9)

								iter_106_4.color = Color.New(var_106_10, var_106_10, var_106_10)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_9 and arg_103_1.time_ < 0 + var_106_9 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10062 then
				for iter_106_5, iter_106_6 in pairs(arg_103_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_106_6 then
						iter_106_6.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10062 = nil
			end

			local var_106_11 = arg_103_1.actors_["10060"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.actorSpriteComps10060 == nil then
				arg_103_1.var_.actorSpriteComps10060 = var_106_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_12 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_12 and not isNil(var_106_11) then
				if arg_103_1.var_.actorSpriteComps10060 then
					for iter_106_7, iter_106_8 in pairs(arg_103_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_106_8 then
							if arg_103_1.isInRecall_ then
								iter_106_8.color = Color.New(Mathf.Lerp(iter_106_8.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_12), Mathf.Lerp(iter_106_8.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_12), (Mathf.Lerp(iter_106_8.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_12)))
							else
								local var_106_13 = Mathf.Lerp(iter_106_8.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_12)

								iter_106_8.color = Color.New(var_106_13, var_106_13, var_106_13)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_12 and arg_103_1.time_ < 0 + var_106_12 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.actorSpriteComps10060 then
				for iter_106_9, iter_106_10 in pairs(arg_103_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_106_10 then
						iter_106_10.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10060 = nil
			end

			local var_106_14 = arg_103_1.actors_["10059"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_14) and arg_103_1.var_.actorSpriteComps10059 == nil then
				arg_103_1.var_.actorSpriteComps10059 = var_106_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_15 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_15 and not isNil(var_106_14) then
				if arg_103_1.var_.actorSpriteComps10059 then
					for iter_106_11, iter_106_12 in pairs(arg_103_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_106_12 then
							if arg_103_1.isInRecall_ then
								iter_106_12.color = Color.New(Mathf.Lerp(iter_106_12.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_15), Mathf.Lerp(iter_106_12.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_15), (Mathf.Lerp(iter_106_12.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_15)))
							else
								local var_106_16 = Mathf.Lerp(iter_106_12.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_15)

								iter_106_12.color = Color.New(var_106_16, var_106_16, var_106_16)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_15 and arg_103_1.time_ < 0 + var_106_15 + arg_106_0 and not isNil(var_106_14) and arg_103_1.var_.actorSpriteComps10059 then
				for iter_106_13, iter_106_14 in pairs(arg_103_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_106_14 then
						iter_106_14.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10059 = nil
			end

			local var_106_17 = 0
			local var_106_18 = 0.275

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_17 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_19 = arg_103_1:GetWordFromCfg(410232025)
				local var_106_20 = arg_103_1:FormatText(var_106_19.content)

				arg_103_1.text_.text = var_106_20

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_22 = 11 <= 0 and var_106_18 or var_106_18 * (utf8.len(var_106_20) / 11)

				if (11 <= 0 and var_106_18 or var_106_18 * (utf8.len(var_106_20) / 11)) > 0 and var_106_18 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_17 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_17
					end
				end

				arg_103_1.text_.text = var_106_20
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232025", "story_v_out_410232.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_410232", "410232025", "story_v_out_410232.awb") / 1000

					if var_106_23 + var_106_17 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_17
					end

					if var_106_19.prefab_name ~= "" and arg_103_1.actors_[var_106_19.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_19.prefab_name].transform, "story_v_out_410232", "410232025", "story_v_out_410232.awb")

						arg_103_1:RecordAudio("410232025", var_106_24)
						arg_103_1:RecordAudio("410232025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410232", "410232025", "story_v_out_410232.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410232", "410232025", "story_v_out_410232.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_18, arg_103_1.talkMaxDuration)

			if var_106_17 <= arg_103_1.time_ and arg_103_1.time_ < var_106_17 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_17) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_17 + var_106_25 and arg_103_1.time_ < var_106_17 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_103_1:InitPlayNodeList()
	end,
	Play410232026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410232026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410232027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10062"]) and arg_107_1.var_.actorSpriteComps10062 == nil then
				arg_107_1.var_.actorSpriteComps10062 = arg_107_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10062"]) then
				if arg_107_1.var_.actorSpriteComps10062 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10062"]) and arg_107_1.var_.actorSpriteComps10062 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10062 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.975

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

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(410232026).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 39 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 39)

				if (39 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 39)) > 0 and var_110_3 < var_110_6 then
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
	Play410232027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410232027
		arg_111_1.duration_ = 3

		local var_111_0 = {
			ja = 3,
			CriLanguages = 2.933,
			zh = 2.933
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
				arg_111_0:Play410232028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10060 = arg_111_1.actors_["10060"].transform.localPosition
				arg_111_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10060", 2)

				for iter_114_0 = 0, arg_111_1.actors_["10060"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["10060"].transform:GetChild(iter_114_0)

					if var_114_0.name == "" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10060, Vector3.New(-390, -400, 0), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10060"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_114_2 = arg_111_1.actors_["10062"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10062 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10062", 4)

				for iter_114_1 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_1)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(370, -390, -290)
			end

			local var_114_5 = arg_111_1.actors_["10060"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10060 == nil then
				arg_111_1.var_.actorSpriteComps10060 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps10060 then
					for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_114_3 then
							if arg_111_1.isInRecall_ then
								iter_114_3.color = Color.New(Mathf.Lerp(iter_114_3.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_3.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_3.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_3.color.r, 1, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_3.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10060 then
				for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_114_5 then
						iter_114_5.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10060 = nil
			end

			local var_114_8 = arg_111_1.actors_["10062"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10062 == nil then
				arg_111_1.var_.actorSpriteComps10062 = var_114_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 and not isNil(var_114_8) then
				if arg_111_1.var_.actorSpriteComps10062 then
					for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_114_7 then
							if arg_111_1.isInRecall_ then
								iter_114_7.color = Color.New(Mathf.Lerp(iter_114_7.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_9), Mathf.Lerp(iter_114_7.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_9), (Mathf.Lerp(iter_114_7.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_9)))
							else
								local var_114_10 = Mathf.Lerp(iter_114_7.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_9)

								iter_114_7.color = Color.New(var_114_10, var_114_10, var_114_10)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 and not isNil(var_114_8) and arg_111_1.var_.actorSpriteComps10062 then
				for iter_114_8, iter_114_9 in pairs(arg_111_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_114_9 then
						iter_114_9.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10062 = nil
			end

			local var_114_11 = 0
			local var_114_12 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_13 = arg_111_1:GetWordFromCfg(410232027)
				local var_114_14 = arg_111_1:FormatText(var_114_13.content)

				arg_111_1.text_.text = var_114_14

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_16 = 11 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_14) / 11)

				if (11 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_14) / 11)) > 0 and var_114_12 < var_114_16 then
					arg_111_1.talkMaxDuration = var_114_16

					if var_114_16 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_14
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232027", "story_v_out_410232.awb") ~= 0 then
					local var_114_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232027", "story_v_out_410232.awb") / 1000

					if var_114_17 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_11
					end

					if var_114_13.prefab_name ~= "" and arg_111_1.actors_[var_114_13.prefab_name] ~= nil then
						local var_114_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_13.prefab_name].transform, "story_v_out_410232", "410232027", "story_v_out_410232.awb")

						arg_111_1:RecordAudio("410232027", var_114_18)
						arg_111_1:RecordAudio("410232027", var_114_18)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410232", "410232027", "story_v_out_410232.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410232", "410232027", "story_v_out_410232.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_19 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_19 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_19

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_19 and arg_111_1.time_ < var_114_11 + var_114_19 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410232028
		arg_115_1.duration_ = 8.97

		local var_115_0 = {
			ja = 8.966,
			CriLanguages = 6.6,
			zh = 6.6
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
				arg_115_0:Play410232029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10062 = arg_115_1.actors_["10062"].transform.localPosition
				arg_115_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10062", 4)

				for iter_118_0 = 0, arg_115_1.actors_["10062"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10062"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10062, Vector3.New(370, -390, -290), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10062"].transform.localPosition = Vector3.New(370, -390, -290)
			end

			local var_118_2 = arg_115_1.actors_["10062"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10062 == nil then
				arg_115_1.var_.actorSpriteComps10062 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10062 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10062 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10062 = nil
			end

			local var_118_5 = arg_115_1.actors_["10060"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10060 == nil then
				arg_115_1.var_.actorSpriteComps10060 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps10060 then
					for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_118_6 then
							if arg_115_1.isInRecall_ then
								iter_118_6.color = Color.New(Mathf.Lerp(iter_118_6.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_6), Mathf.Lerp(iter_118_6.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_6), (Mathf.Lerp(iter_118_6.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_6)))
							else
								local var_118_7 = Mathf.Lerp(iter_118_6.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_6)

								iter_118_6.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10060 then
				for iter_118_7, iter_118_8 in pairs(arg_115_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_118_8 then
						iter_118_8.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10060 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 0.425

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(410232028)
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

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232028", "story_v_out_410232.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232028", "story_v_out_410232.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_410232", "410232028", "story_v_out_410232.awb")

						arg_115_1:RecordAudio("410232028", var_118_15)
						arg_115_1:RecordAudio("410232028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410232", "410232028", "story_v_out_410232.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410232", "410232028", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410232029
		arg_119_1.duration_ = 9.6

		local var_119_0 = {
			ja = 8.5,
			CriLanguages = 9.6,
			zh = 9.6
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
				arg_119_0:Play410232030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10060 = arg_119_1.actors_["10060"].transform.localPosition
				arg_119_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10060", 2)

				for iter_122_0 = 0, arg_119_1.actors_["10060"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10060"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10060, Vector3.New(-390, -400, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10060"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_122_2 = arg_119_1.actors_["10060"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10060 == nil then
				arg_119_1.var_.actorSpriteComps10060 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10060 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10060 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10060 = nil
			end

			local var_122_5 = arg_119_1.actors_["10062"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10062 == nil then
				arg_119_1.var_.actorSpriteComps10062 = var_122_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_6 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.actorSpriteComps10062 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_122_6 then
							if arg_119_1.isInRecall_ then
								iter_122_6.color = Color.New(Mathf.Lerp(iter_122_6.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_6), Mathf.Lerp(iter_122_6.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_6), (Mathf.Lerp(iter_122_6.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_6)))
							else
								local var_122_7 = Mathf.Lerp(iter_122_6.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_6)

								iter_122_6.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.actorSpriteComps10062 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_122_8 then
						iter_122_8.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10062 = nil
			end

			local var_122_8 = 0
			local var_122_9 = 0.875

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(410232029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 35 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 35)

				if (35 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 35)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232029", "story_v_out_410232.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232029", "story_v_out_410232.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_410232", "410232029", "story_v_out_410232.awb")

						arg_119_1:RecordAudio("410232029", var_122_15)
						arg_119_1:RecordAudio("410232029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410232", "410232029", "story_v_out_410232.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410232", "410232029", "story_v_out_410232.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play410232030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410232030
		arg_123_1.duration_ = 5.07

		local var_123_0 = {
			ja = 5.066,
			CriLanguages = 4.866,
			zh = 4.866
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
				arg_123_0:Play410232031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10060 = arg_123_1.actors_["10060"].transform.localPosition
				arg_123_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10060", 2)

				for iter_126_0 = 0, arg_123_1.actors_["10060"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10060"].transform:GetChild(iter_126_0)

					if var_126_0.name == "" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10060, Vector3.New(-390, -400, 0), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10060"].transform.localPosition = Vector3.New(-390, -400, 0)
			end

			local var_126_2 = arg_123_1.actors_["10060"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10060 == nil then
				arg_123_1.var_.actorSpriteComps10060 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10060 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10060 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10060 = nil
			end

			local var_126_5 = 0
			local var_126_6 = 0.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(410232030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 19 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 19)

				if (19 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 19)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232030", "story_v_out_410232.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232030", "story_v_out_410232.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_410232", "410232030", "story_v_out_410232.awb")

						arg_123_1:RecordAudio("410232030", var_126_12)
						arg_123_1:RecordAudio("410232030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410232", "410232030", "story_v_out_410232.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410232", "410232030", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410232031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play410232032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10060 = arg_127_1.actors_["10060"].transform.localPosition
				arg_127_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10060", 7)

				for iter_130_0 = 0, arg_127_1.actors_["10060"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10060"].transform:GetChild(iter_130_0)

					if var_130_0.name == "" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_2 = arg_127_1.actors_["10062"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10062 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10062", 7)

				for iter_130_1 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_1)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_130_5 = arg_127_1.actors_["10059"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10059 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10059", 3)

				for iter_130_2 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_2)

					if var_130_6.name == "split_3" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10059, Vector3.New(0, -530, 35), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0, -530, 35)
			end

			local var_130_8 = arg_127_1.actors_["10060"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10060 == nil then
				arg_127_1.var_.actorSpriteComps10060 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.actorSpriteComps10060 then
					for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_130_4 then
							if arg_127_1.isInRecall_ then
								iter_130_4.color = Color.New(Mathf.Lerp(iter_130_4.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_4.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_4.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_4.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_4.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10060 then
				for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_130_6 then
						iter_130_6.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10060 = nil
			end

			local var_130_11 = arg_127_1.actors_["10062"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps10062 == nil then
				arg_127_1.var_.actorSpriteComps10062 = var_130_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_12 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_12 and not isNil(var_130_11) then
				if arg_127_1.var_.actorSpriteComps10062 then
					for iter_130_7, iter_130_8 in pairs(arg_127_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_130_8 then
							if arg_127_1.isInRecall_ then
								iter_130_8.color = Color.New(Mathf.Lerp(iter_130_8.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_12), Mathf.Lerp(iter_130_8.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_12), (Mathf.Lerp(iter_130_8.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_12)))
							else
								local var_130_13 = Mathf.Lerp(iter_130_8.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_12)

								iter_130_8.color = Color.New(var_130_13, var_130_13, var_130_13)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_12 and arg_127_1.time_ < 0 + var_130_12 + arg_130_0 and not isNil(var_130_11) and arg_127_1.var_.actorSpriteComps10062 then
				for iter_130_9, iter_130_10 in pairs(arg_127_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_130_10 then
						iter_130_10.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10062 = nil
			end

			local var_130_14 = arg_127_1.actors_["10059"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.actorSpriteComps10059 == nil then
				arg_127_1.var_.actorSpriteComps10059 = var_130_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_15 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_15 and not isNil(var_130_14) then
				if arg_127_1.var_.actorSpriteComps10059 then
					for iter_130_11, iter_130_12 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_130_12 then
							if arg_127_1.isInRecall_ then
								iter_130_12.color = Color.New(Mathf.Lerp(iter_130_12.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_15), Mathf.Lerp(iter_130_12.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_15), (Mathf.Lerp(iter_130_12.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_15)))
							else
								local var_130_16 = Mathf.Lerp(iter_130_12.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_15)

								iter_130_12.color = Color.New(var_130_16, var_130_16, var_130_16)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_15 and arg_127_1.time_ < 0 + var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.actorSpriteComps10059 then
				for iter_130_13, iter_130_14 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_130_14 then
						iter_130_14.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10059 = nil
			end

			local var_130_17 = 0
			local var_130_18 = 0.975

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_19 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(410232031).content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_21 = 39 <= 0 and var_130_18 or var_130_18 * (utf8.len(var_130_19) / 39)

				if (39 <= 0 and var_130_18 or var_130_18 * (utf8.len(var_130_19) / 39)) > 0 and var_130_18 < var_130_21 then
					arg_127_1.talkMaxDuration = var_130_21

					if var_130_21 + var_130_17 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_21 + var_130_17
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_18, arg_127_1.talkMaxDuration)

			if var_130_17 <= arg_127_1.time_ and arg_127_1.time_ < var_130_17 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_17) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_17 + var_130_22 and arg_127_1.time_ < var_130_17 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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
				actorName = "10062",
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

		arg_127_1:InitPlayNodeList()
	end,
	Play410232032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410232032
		arg_131_1.duration_ = 10

		local var_131_0 = {
			ja = 7.333,
			CriLanguages = 10,
			zh = 10
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
				arg_131_0:Play410232033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10059 = arg_131_1.actors_["10059"].transform.localPosition
				arg_131_1.actors_["10059"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10059", 7)

				for iter_134_0 = 0, arg_131_1.actors_["10059"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10059"].transform:GetChild(iter_134_0)

					if var_134_0.name == "" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10059"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10059"].transform.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_134_2 = arg_131_1.actors_["10062"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10062 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10062", 3)

				for iter_134_1 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_1)

					if var_134_3.name == "split_2" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_131_1.time_ - 0) / var_134_4)
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -390, -290)
			end

			local var_134_5 = arg_131_1.actors_["10059"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10059 == nil then
				arg_131_1.var_.actorSpriteComps10059 = var_134_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_6 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.actorSpriteComps10059 then
					for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_134_3 then
							if arg_131_1.isInRecall_ then
								iter_134_3.color = Color.New(Mathf.Lerp(iter_134_3.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_6), Mathf.Lerp(iter_134_3.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_6), (Mathf.Lerp(iter_134_3.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_6)))
							else
								local var_134_7 = Mathf.Lerp(iter_134_3.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_6)

								iter_134_3.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.actorSpriteComps10059 then
				for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_134_5 then
						iter_134_5.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10059 = nil
			end

			local var_134_8 = arg_131_1.actors_["10062"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10062 == nil then
				arg_131_1.var_.actorSpriteComps10062 = var_134_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_9 and not isNil(var_134_8) then
				if arg_131_1.var_.actorSpriteComps10062 then
					for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_134_7 then
							if arg_131_1.isInRecall_ then
								iter_134_7.color = Color.New(Mathf.Lerp(iter_134_7.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_9), Mathf.Lerp(iter_134_7.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_9), (Mathf.Lerp(iter_134_7.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_9)))
							else
								local var_134_10 = Mathf.Lerp(iter_134_7.color.r, 1, (arg_131_1.time_ - 0) / var_134_9)

								iter_134_7.color = Color.New(var_134_10, var_134_10, var_134_10)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_9 and arg_131_1.time_ < 0 + var_134_9 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10062 then
				for iter_134_8, iter_134_9 in pairs(arg_131_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_134_9 then
						iter_134_9.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10062 = nil
			end

			local var_134_11 = 0
			local var_134_12 = 0.425

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(410232032)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 17 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 17)

				if (17 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 17)) > 0 and var_134_12 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232032", "story_v_out_410232.awb") ~= 0 then
					local var_134_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232032", "story_v_out_410232.awb") / 1000

					if var_134_17 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_11
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_410232", "410232032", "story_v_out_410232.awb")

						arg_131_1:RecordAudio("410232032", var_134_18)
						arg_131_1:RecordAudio("410232032", var_134_18)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410232", "410232032", "story_v_out_410232.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410232", "410232032", "story_v_out_410232.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_19 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_19 and arg_131_1.time_ < var_134_11 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410232033
		arg_135_1.duration_ = 6.5

		local var_135_0 = {
			ja = 6.5,
			CriLanguages = 6.266,
			zh = 6.266
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
				arg_135_0:Play410232034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.bgs_.ST67 == nil then
				local var_138_0 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_138_0.name = "ST67"
				var_138_0.transform.parent = arg_135_1.stage_.transform
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_.ST67 = var_138_0
			end

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				local var_138_1 = arg_135_1.bgs_.ST67

				arg_135_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_2 = var_138_1:GetComponent("SpriteRenderer")

				if var_138_2 and var_138_2.sprite then
					local var_138_3 = 2 * (var_138_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_1.transform.localScale = Vector3.New(var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "ST67" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_4 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_5 = 2

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_5 then
				local var_138_6 = Color.New(0, 0, 0)

				var_138_6.a = Mathf.Lerp(0, 1, (arg_135_1.time_ - var_138_4) / var_138_5)
				arg_135_1.mask_.color = var_138_6
			end

			if arg_135_1.time_ >= var_138_4 + var_138_5 and arg_135_1.time_ < var_138_4 + var_138_5 + arg_138_0 then
				local var_138_7 = Color.New(0, 0, 0)

				var_138_7.a = 1
				arg_135_1.mask_.color = var_138_7
			end

			local var_138_8 = 2

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_9 = 2

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 then
				local var_138_10 = Color.New(0, 0, 0)

				var_138_10.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_8) / var_138_9)
				arg_135_1.mask_.color = var_138_10
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 then
				local var_138_11 = Color.New(0, 0, 0)

				arg_135_1.mask_.enabled = false
				var_138_11.a = 0
				arg_135_1.mask_.color = var_138_11
			end

			local var_138_12 = arg_135_1.actors_["10062"].transform

			if 4 < arg_135_1.time_ and arg_135_1.time_ <= 4 + arg_138_0 then
				arg_135_1.var_.moveOldPos10062 = var_138_12.localPosition
				var_138_12.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10062", 3)

				for iter_138_2 = 0, var_138_12.childCount - 1 do
					local var_138_13 = var_138_12:GetChild(iter_138_2)

					if var_138_13.name == "" or not string.find(var_138_13.name, "split") then
						var_138_13.gameObject:SetActive(true)
					else
						var_138_13.gameObject:SetActive(false)
					end
				end
			end

			local var_138_14 = 0.001

			if 4 <= arg_135_1.time_ and arg_135_1.time_ < 4 + var_138_14 then
				var_138_12.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10062, Vector3.New(0, -390, -290), (arg_135_1.time_ - 4) / var_138_14)
			end

			if arg_135_1.time_ >= 4 + var_138_14 and arg_135_1.time_ < 4 + var_138_14 + arg_138_0 then
				var_138_12.localPosition = Vector3.New(0, -390, -290)
			end

			local var_138_15 = arg_135_1.actors_["10062"]

			if 4 < arg_135_1.time_ and arg_135_1.time_ <= 4 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10062 == nil then
				arg_135_1.var_.actorSpriteComps10062 = var_138_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_16 = 0.034

			if 4 <= arg_135_1.time_ and arg_135_1.time_ < 4 + var_138_16 and not isNil(var_138_15) then
				if arg_135_1.var_.actorSpriteComps10062 then
					for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_138_4 then
							if arg_135_1.isInRecall_ then
								iter_138_4.color = Color.New(Mathf.Lerp(iter_138_4.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 4) / var_138_16), Mathf.Lerp(iter_138_4.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 4) / var_138_16), (Mathf.Lerp(iter_138_4.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 4) / var_138_16)))
							else
								local var_138_17 = Mathf.Lerp(iter_138_4.color.r, 1, (arg_135_1.time_ - 4) / var_138_16)

								iter_138_4.color = Color.New(var_138_17, var_138_17, var_138_17)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 4 + var_138_16 and arg_135_1.time_ < 4 + var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10062 then
				for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_138_6 then
						iter_138_6.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10062 = nil
			end

			local var_138_18 = arg_135_1.actors_["10062"].transform

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= 2 + arg_138_0 then
				arg_135_1.var_.moveOldPos10062 = var_138_18.localPosition
				var_138_18.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10062", 7)

				for iter_138_7 = 0, var_138_18.childCount - 1 do
					local var_138_19 = var_138_18:GetChild(iter_138_7)

					if var_138_19.name == "" or not string.find(var_138_19.name, "split") then
						var_138_19.gameObject:SetActive(true)
					else
						var_138_19.gameObject:SetActive(false)
					end
				end
			end

			local var_138_20 = 0.001

			if 2 <= arg_135_1.time_ and arg_135_1.time_ < 2 + var_138_20 then
				var_138_18.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_135_1.time_ - 2) / var_138_20)
			end

			if arg_135_1.time_ >= 2 + var_138_20 and arg_135_1.time_ < 2 + var_138_20 + arg_138_0 then
				var_138_18.localPosition = Vector3.New(0, -2000, -290)
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_21 = 4
			local var_138_22 = 0.2

			if 4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_23 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_23:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_24 = arg_135_1:GetWordFromCfg(410232033)
				local var_138_25 = arg_135_1:FormatText(var_138_24.content)

				arg_135_1.text_.text = var_138_25

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_27 = 8 <= 0 and var_138_22 or var_138_22 * (utf8.len(var_138_25) / 8)

				if (8 <= 0 and var_138_22 or var_138_22 * (utf8.len(var_138_25) / 8)) > 0 and var_138_22 < var_138_27 then
					arg_135_1.talkMaxDuration = var_138_27
					var_138_21 = var_138_21 + 0.3

					if var_138_27 + var_138_21 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_27 + var_138_21
					end
				end

				arg_135_1.text_.text = var_138_25
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232033", "story_v_out_410232.awb") ~= 0 then
					local var_138_28 = manager.audio:GetVoiceLength("story_v_out_410232", "410232033", "story_v_out_410232.awb") / 1000

					if var_138_28 + var_138_21 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_28 + var_138_21
					end

					if var_138_24.prefab_name ~= "" and arg_135_1.actors_[var_138_24.prefab_name] ~= nil then
						local var_138_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_24.prefab_name].transform, "story_v_out_410232", "410232033", "story_v_out_410232.awb")

						arg_135_1:RecordAudio("410232033", var_138_29)
						arg_135_1:RecordAudio("410232033", var_138_29)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410232", "410232033", "story_v_out_410232.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410232", "410232033", "story_v_out_410232.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_30 = var_138_21 + 0.3
			local var_138_31 = math.max(var_138_22, arg_135_1.talkMaxDuration)

			if var_138_21 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_31 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_30) / var_138_31

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_30 + var_138_31 and arg_135_1.time_ < var_138_30 + var_138_31 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play410232034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410232034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play410232035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10062"]) and arg_141_1.var_.actorSpriteComps10062 == nil then
				arg_141_1.var_.actorSpriteComps10062 = arg_141_1.actors_["10062"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10062"]) then
				if arg_141_1.var_.actorSpriteComps10062 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10062"]) and arg_141_1.var_.actorSpriteComps10062 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10062 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 0.925

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(410232034).content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 37 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 37)

				if (37 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 37)) > 0 and var_144_3 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_7 and arg_141_1.time_ < var_144_2 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play410232035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410232035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410232036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.925

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(410232035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 37 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 37)

				if (37 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 37)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play410232036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410232036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410232037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.575

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(410232036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 63 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 63)

				if (63 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 63)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play410232037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410232037
		arg_153_1.duration_ = 5.23

		local var_153_0 = {
			ja = 5.233,
			CriLanguages = 1.8,
			zh = 1.8
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
				arg_153_0:Play410232038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10062 = arg_153_1.actors_["10062"].transform.localPosition
				arg_153_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_156_0 = 0, arg_153_1.actors_["10062"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["10062"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_156_2 = arg_153_1.actors_["10060"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10060 = var_156_2.localPosition
				var_156_2.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10060", 4)

				for iter_156_1 = 0, var_156_2.childCount - 1 do
					local var_156_3 = var_156_2:GetChild(iter_156_1)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_2.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_153_1.time_ - 0) / var_156_4)
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_2.localPosition = Vector3.New(390, -400, 0)
			end

			local var_156_5 = arg_153_1.actors_["10062"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10062 == nil then
				arg_153_1.var_.actorSpriteComps10062 = var_156_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.actorSpriteComps10062 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								iter_156_3.color = Color.New(Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_6), Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_6), (Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_6)))
							else
								local var_156_7 = Mathf.Lerp(iter_156_3.color.r, 1, (arg_153_1.time_ - 0) / var_156_6)

								iter_156_3.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10062 then
				for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_156_5 then
						iter_156_5.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10062 = nil
			end

			local var_156_8 = arg_153_1.actors_["10060"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10060 == nil then
				arg_153_1.var_.actorSpriteComps10060 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_9 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_9 and not isNil(var_156_8) then
				if arg_153_1.var_.actorSpriteComps10060 then
					for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_156_7 then
							if arg_153_1.isInRecall_ then
								iter_156_7.color = Color.New(Mathf.Lerp(iter_156_7.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_9), Mathf.Lerp(iter_156_7.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_9), (Mathf.Lerp(iter_156_7.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_9)))
							else
								local var_156_10 = Mathf.Lerp(iter_156_7.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_9)

								iter_156_7.color = Color.New(var_156_10, var_156_10, var_156_10)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_9 and arg_153_1.time_ < 0 + var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps10060 then
				for iter_156_8, iter_156_9 in pairs(arg_153_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_156_9 then
						iter_156_9.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10060 = nil
			end

			local var_156_11 = 0
			local var_156_12 = 0.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_13 = arg_153_1:GetWordFromCfg(410232037)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 4 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 4)

				if (4 <= 0 and var_156_12 or var_156_12 * (utf8.len(var_156_14) / 4)) > 0 and var_156_12 < var_156_16 then
					arg_153_1.talkMaxDuration = var_156_16

					if var_156_16 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232037", "story_v_out_410232.awb") ~= 0 then
					local var_156_17 = manager.audio:GetVoiceLength("story_v_out_410232", "410232037", "story_v_out_410232.awb") / 1000

					if var_156_17 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_11
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_410232", "410232037", "story_v_out_410232.awb")

						arg_153_1:RecordAudio("410232037", var_156_18)
						arg_153_1:RecordAudio("410232037", var_156_18)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410232", "410232037", "story_v_out_410232.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410232", "410232037", "story_v_out_410232.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_19 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_19 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_19

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_19 and arg_153_1.time_ < var_156_11 + var_156_19 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_153_1:InitPlayNodeList()
	end,
	Play410232038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410232038
		arg_157_1.duration_ = 3.17

		local var_157_0 = {
			ja = 3.166,
			CriLanguages = 2.1,
			zh = 2.1
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play410232039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10060 = arg_157_1.actors_["10060"].transform.localPosition
				arg_157_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10060", 4)

				for iter_160_0 = 0, arg_157_1.actors_["10060"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["10060"].transform:GetChild(iter_160_0)

					if var_160_0.name == "" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_160_2 = arg_157_1.actors_["10060"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10060 == nil then
				arg_157_1.var_.actorSpriteComps10060 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps10060 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10060 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10060 = nil
			end

			local var_160_5 = arg_157_1.actors_["10062"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10062 == nil then
				arg_157_1.var_.actorSpriteComps10062 = var_160_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 0.034

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.actorSpriteComps10062 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								iter_160_6.color = Color.New(Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_6), Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_6), (Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_6)))
							else
								local var_160_7 = Mathf.Lerp(iter_160_6.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_6)

								iter_160_6.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10062 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_160_8 then
						iter_160_8.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10062 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.2

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(410232038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)

				if (8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232038", "story_v_out_410232.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232038", "story_v_out_410232.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_410232", "410232038", "story_v_out_410232.awb")

						arg_157_1:RecordAudio("410232038", var_160_15)
						arg_157_1:RecordAudio("410232038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410232", "410232038", "story_v_out_410232.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410232", "410232038", "story_v_out_410232.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play410232039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410232039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play410232040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10060"]) and arg_161_1.var_.actorSpriteComps10060 == nil then
				arg_161_1.var_.actorSpriteComps10060 = arg_161_1.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.034

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10060"]) then
				if arg_161_1.var_.actorSpriteComps10060 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10060"]) and arg_161_1.var_.actorSpriteComps10060 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10060 = nil
			end

			local var_164_2 = 0
			local var_164_3 = 1.4

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(410232039).content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_6 = 56 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_4) / 56)

				if (56 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_4) / 56)) > 0 and var_164_3 < var_164_6 then
					arg_161_1.talkMaxDuration = var_164_6

					if var_164_6 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_7 and arg_161_1.time_ < var_164_2 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play410232040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410232040
		arg_165_1.duration_ = 15.23

		local var_165_0 = {
			ja = 15.233,
			CriLanguages = 9.433,
			zh = 9.433
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
				arg_165_0:Play410232041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10062 = arg_165_1.actors_["10062"].transform.localPosition
				arg_165_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_168_0 = 0, arg_165_1.actors_["10062"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["10062"].transform:GetChild(iter_168_0)

					if var_168_0.name == "" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_168_2 = arg_165_1.actors_["10062"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps10062 == nil then
				arg_165_1.var_.actorSpriteComps10062 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps10062 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps10062 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10062 = nil
			end

			local var_168_5 = 0
			local var_168_6 = 0.975

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(410232040)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 39 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 39)

				if (39 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 39)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232040", "story_v_out_410232.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232040", "story_v_out_410232.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_410232", "410232040", "story_v_out_410232.awb")

						arg_165_1:RecordAudio("410232040", var_168_12)
						arg_165_1:RecordAudio("410232040", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_410232", "410232040", "story_v_out_410232.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_410232", "410232040", "story_v_out_410232.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410232041
		arg_169_1.duration_ = 17

		local var_169_0 = {
			ja = 17,
			CriLanguages = 10.7,
			zh = 10.7
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
				arg_169_0:Play410232042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.95

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(410232041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 38 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 38)

				if (38 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 38)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232041", "story_v_out_410232.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_410232", "410232041", "story_v_out_410232.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_410232", "410232041", "story_v_out_410232.awb")

						arg_169_1:RecordAudio("410232041", var_172_6)
						arg_169_1:RecordAudio("410232041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_410232", "410232041", "story_v_out_410232.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_410232", "410232041", "story_v_out_410232.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410232042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410232042
		arg_173_1.duration_ = 2.5

		local var_173_0 = {
			ja = 2.233,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_173_0:Play410232043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10060 = arg_173_1.actors_["10060"].transform.localPosition
				arg_173_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10060", 4)

				for iter_176_0 = 0, arg_173_1.actors_["10060"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["10060"].transform:GetChild(iter_176_0)

					if var_176_0.name == "split_4" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_176_2 = arg_173_1.actors_["10060"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10060 == nil then
				arg_173_1.var_.actorSpriteComps10060 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10060 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10060 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10060 = nil
			end

			local var_176_5 = arg_173_1.actors_["10062"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10062 == nil then
				arg_173_1.var_.actorSpriteComps10062 = var_176_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.actorSpriteComps10062 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10062 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_176_8 then
						iter_176_8.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10062 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(410232042)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 7 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 7)

				if (7 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 7)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232042", "story_v_out_410232.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232042", "story_v_out_410232.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_410232", "410232042", "story_v_out_410232.awb")

						arg_173_1:RecordAudio("410232042", var_176_15)
						arg_173_1:RecordAudio("410232042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410232", "410232042", "story_v_out_410232.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410232", "410232042", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	Play410232043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410232043
		arg_177_1.duration_ = 9.13

		local var_177_0 = {
			ja = 9.133,
			CriLanguages = 7.3,
			zh = 7.3
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
				arg_177_0:Play410232044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10062 = arg_177_1.actors_["10062"].transform.localPosition
				arg_177_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_180_0 = 0, arg_177_1.actors_["10062"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10062"].transform:GetChild(iter_180_0)

					if var_180_0.name == "" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_180_2 = arg_177_1.actors_["10060"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10060 == nil then
				arg_177_1.var_.actorSpriteComps10060 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10060 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10060 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10060 = nil
			end

			local var_180_5 = arg_177_1.actors_["10062"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10062 == nil then
				arg_177_1.var_.actorSpriteComps10062 = var_180_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_6 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_6 and not isNil(var_180_5) then
				if arg_177_1.var_.actorSpriteComps10062 then
					for iter_180_5, iter_180_6 in pairs(arg_177_1.var_.actorSpriteComps10062:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_6 and arg_177_1.time_ < 0 + var_180_6 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.actorSpriteComps10062 then
				for iter_180_7, iter_180_8 in pairs(arg_177_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_180_8 then
						iter_180_8.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10062 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 0.75

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(410232043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 30 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 30)

				if (30 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_11) / 30)) > 0 and var_180_9 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232043", "story_v_out_410232.awb") ~= 0 then
					local var_180_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232043", "story_v_out_410232.awb") / 1000

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_410232", "410232043", "story_v_out_410232.awb")

						arg_177_1:RecordAudio("410232043", var_180_15)
						arg_177_1:RecordAudio("410232043", var_180_15)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_410232", "410232043", "story_v_out_410232.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_410232", "410232043", "story_v_out_410232.awb")
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
				actorName = "10062",
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
	Play410232044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410232044
		arg_181_1.duration_ = 5.57

		local var_181_0 = {
			ja = 5.566,
			CriLanguages = 2.866,
			zh = 2.866
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
				arg_181_0:Play410232045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10060 = arg_181_1.actors_["10060"].transform.localPosition
				arg_181_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10060", 4)

				for iter_184_0 = 0, arg_181_1.actors_["10060"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10060"].transform:GetChild(iter_184_0)

					if var_184_0.name == "" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_184_2 = arg_181_1.actors_["10060"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10060 == nil then
				arg_181_1.var_.actorSpriteComps10060 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps10060 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								iter_184_2.color = Color.New(Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_2.color.r, 1, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_2.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10060 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_184_4 then
						iter_184_4.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10060 = nil
			end

			local var_184_5 = arg_181_1.actors_["10062"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10062 == nil then
				arg_181_1.var_.actorSpriteComps10062 = var_184_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_6 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.actorSpriteComps10062 then
					for iter_184_5, iter_184_6 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_184_6 then
							if arg_181_1.isInRecall_ then
								iter_184_6.color = Color.New(Mathf.Lerp(iter_184_6.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_6), Mathf.Lerp(iter_184_6.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_6), (Mathf.Lerp(iter_184_6.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_6)))
							else
								local var_184_7 = Mathf.Lerp(iter_184_6.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_6)

								iter_184_6.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.actorSpriteComps10062 then
				for iter_184_7, iter_184_8 in pairs(arg_181_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_184_8 then
						iter_184_8.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10062 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(410232044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 9 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 9)

				if (9 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 9)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232044", "story_v_out_410232.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232044", "story_v_out_410232.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_410232", "410232044", "story_v_out_410232.awb")

						arg_181_1:RecordAudio("410232044", var_184_15)
						arg_181_1:RecordAudio("410232044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410232", "410232044", "story_v_out_410232.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410232", "410232044", "story_v_out_410232.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play410232045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410232045
		arg_185_1.duration_ = 12.57

		local var_185_0 = {
			ja = 12.566,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_185_0:Play410232046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10062 = arg_185_1.actors_["10062"].transform.localPosition
				arg_185_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_188_0 = 0, arg_185_1.actors_["10062"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10062"].transform:GetChild(iter_188_0)

					if var_188_0.name == "" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_188_2 = arg_185_1.actors_["10060"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10060 == nil then
				arg_185_1.var_.actorSpriteComps10060 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10060 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10060 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10060 = nil
			end

			local var_188_5 = arg_185_1.actors_["10062"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10062 == nil then
				arg_185_1.var_.actorSpriteComps10062 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10062 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 1, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10062 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10062 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.7

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(410232045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 28 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 28)

				if (28 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 28)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232045", "story_v_out_410232.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232045", "story_v_out_410232.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_410232", "410232045", "story_v_out_410232.awb")

						arg_185_1:RecordAudio("410232045", var_188_15)
						arg_185_1:RecordAudio("410232045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410232", "410232045", "story_v_out_410232.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410232", "410232045", "story_v_out_410232.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410232046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410232046
		arg_189_1.duration_ = 16.33

		local var_189_0 = {
			ja = 16.333,
			CriLanguages = 10.433,
			zh = 10.433
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
				arg_189_0:Play410232047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(410232046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)

				if (40 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 40)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232046", "story_v_out_410232.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_410232", "410232046", "story_v_out_410232.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_410232", "410232046", "story_v_out_410232.awb")

						arg_189_1:RecordAudio("410232046", var_192_6)
						arg_189_1:RecordAudio("410232046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410232", "410232046", "story_v_out_410232.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410232", "410232046", "story_v_out_410232.awb")
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
	Play410232047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410232047
		arg_193_1.duration_ = 7.3

		local var_193_0 = {
			ja = 7.3,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_193_0:Play410232048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10060 = arg_193_1.actors_["10060"].transform.localPosition
				arg_193_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10060", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10060"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10060"].transform:GetChild(iter_196_0)

					if var_196_0.name == "" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10060, Vector3.New(390, -400, 0), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10060"].transform.localPosition = Vector3.New(390, -400, 0)
			end

			local var_196_2 = arg_193_1.actors_["10060"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10060 == nil then
				arg_193_1.var_.actorSpriteComps10060 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10060 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10060 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10060 = nil
			end

			local var_196_5 = arg_193_1.actors_["10062"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10062 == nil then
				arg_193_1.var_.actorSpriteComps10062 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps10062 then
					for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_196_6 then
							if arg_193_1.isInRecall_ then
								iter_196_6.color = Color.New(Mathf.Lerp(iter_196_6.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_6.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_6.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_6.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_6.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps10062 then
				for iter_196_7, iter_196_8 in pairs(arg_193_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_196_8 then
						iter_196_8.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10062 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 0.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(410232047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 15 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 15)

				if (15 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 15)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232047", "story_v_out_410232.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232047", "story_v_out_410232.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_410232", "410232047", "story_v_out_410232.awb")

						arg_193_1:RecordAudio("410232047", var_196_15)
						arg_193_1:RecordAudio("410232047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410232", "410232047", "story_v_out_410232.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410232", "410232047", "story_v_out_410232.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play410232048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410232048
		arg_197_1.duration_ = 12.4

		local var_197_0 = {
			ja = 12.4,
			CriLanguages = 5.366,
			zh = 5.366
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410232049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10062 = arg_197_1.actors_["10062"].transform.localPosition
				arg_197_1.actors_["10062"].transform.localScale = Vector3.New(1, 1, 1)

				for iter_200_0 = 0, arg_197_1.actors_["10062"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10062"].transform:GetChild(iter_200_0)

					if var_200_0.name == "" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10062"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10062, Vector3.New(-370, -390, -290), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10062"].transform.localPosition = Vector3.New(-370, -390, -290)
			end

			local var_200_2 = arg_197_1.actors_["10060"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10060 == nil then
				arg_197_1.var_.actorSpriteComps10060 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10060 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10060 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10060 = nil
			end

			local var_200_5 = arg_197_1.actors_["10062"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10062 == nil then
				arg_197_1.var_.actorSpriteComps10062 = var_200_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_6 = 0.034

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.actorSpriteComps10062 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								iter_200_6.color = Color.New(Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_6), Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_6), (Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_6)))
							else
								local var_200_7 = Mathf.Lerp(iter_200_6.color.r, 1, (arg_197_1.time_ - 0) / var_200_6)

								iter_200_6.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10062 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_200_8 then
						iter_200_8.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10062 = nil
			end

			local var_200_8 = 0
			local var_200_9 = 0.6

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(410232048)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 24 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 24)

				if (24 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 24)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232048", "story_v_out_410232.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_410232", "410232048", "story_v_out_410232.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_410232", "410232048", "story_v_out_410232.awb")

						arg_197_1:RecordAudio("410232048", var_200_15)
						arg_197_1:RecordAudio("410232048", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410232", "410232048", "story_v_out_410232.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410232", "410232048", "story_v_out_410232.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
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
	Play410232049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410232049
		arg_201_1.duration_ = 15.03

		local var_201_0 = {
			ja = 15.033,
			CriLanguages = 8.233,
			zh = 8.233
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
				arg_201_0:Play410232050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.9

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(410232049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 36 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 36)

				if (36 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 36)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232049", "story_v_out_410232.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_410232", "410232049", "story_v_out_410232.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_410232", "410232049", "story_v_out_410232.awb")

						arg_201_1:RecordAudio("410232049", var_204_6)
						arg_201_1:RecordAudio("410232049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_410232", "410232049", "story_v_out_410232.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_410232", "410232049", "story_v_out_410232.awb")
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
	Play410232050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410232050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410232051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10060 = arg_205_1.actors_["10060"].transform.localPosition
				arg_205_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10060", 7)

				for iter_208_0 = 0, arg_205_1.actors_["10060"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10060"].transform:GetChild(iter_208_0)

					if var_208_0.name == "" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10060, Vector3.New(0, -2000, 0), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10060"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_208_2 = arg_205_1.actors_["10062"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10062 = var_208_2.localPosition
				var_208_2.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10062", 7)

				for iter_208_1 = 0, var_208_2.childCount - 1 do
					local var_208_3 = var_208_2:GetChild(iter_208_1)

					if var_208_3.name == "" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				var_208_2.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10062, Vector3.New(0, -2000, -290), (arg_205_1.time_ - 0) / var_208_4)
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				var_208_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_208_5 = arg_205_1.actors_["10060"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps10060 == nil then
				arg_205_1.var_.actorSpriteComps10060 = var_208_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_6 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 and not isNil(var_208_5) then
				if arg_205_1.var_.actorSpriteComps10060 then
					for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_208_3 then
							if arg_205_1.isInRecall_ then
								iter_208_3.color = Color.New(Mathf.Lerp(iter_208_3.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_6), Mathf.Lerp(iter_208_3.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_6), (Mathf.Lerp(iter_208_3.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_6)))
							else
								local var_208_7 = Mathf.Lerp(iter_208_3.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_6)

								iter_208_3.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and not isNil(var_208_5) and arg_205_1.var_.actorSpriteComps10060 then
				for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_208_5 then
						iter_208_5.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10060 = nil
			end

			local var_208_8 = arg_205_1.actors_["10062"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10062 == nil then
				arg_205_1.var_.actorSpriteComps10062 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_9 and not isNil(var_208_8) then
				if arg_205_1.var_.actorSpriteComps10062 then
					for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_208_7 then
							if arg_205_1.isInRecall_ then
								iter_208_7.color = Color.New(Mathf.Lerp(iter_208_7.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_9), Mathf.Lerp(iter_208_7.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_9), (Mathf.Lerp(iter_208_7.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_9)))
							else
								local var_208_10 = Mathf.Lerp(iter_208_7.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_9)

								iter_208_7.color = Color.New(var_208_10, var_208_10, var_208_10)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_9 and arg_205_1.time_ < 0 + var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10062 then
				for iter_208_8, iter_208_9 in pairs(arg_205_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_208_9 then
						iter_208_9.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10062 = nil
			end

			local var_208_11 = 0
			local var_208_12 = 1.975

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_13 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(410232050).content)

				arg_205_1.text_.text = var_208_13

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_15 = 79 <= 0 and var_208_12 or var_208_12 * (utf8.len(var_208_13) / 79)

				if (79 <= 0 and var_208_12 or var_208_12 * (utf8.len(var_208_13) / 79)) > 0 and var_208_12 < var_208_15 then
					arg_205_1.talkMaxDuration = var_208_15

					if var_208_15 + var_208_11 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_15 + var_208_11
					end
				end

				arg_205_1.text_.text = var_208_13
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_12, arg_205_1.talkMaxDuration)

			if var_208_11 <= arg_205_1.time_ and arg_205_1.time_ < var_208_11 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_11) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_11 + var_208_16 and arg_205_1.time_ < var_208_11 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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
				actorName = "10062",
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
	Play410232051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410232051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410232052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.175

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

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(410232051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 47 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 47)

				if (47 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 47)) > 0 and var_212_0 < var_212_3 then
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
	Play410232052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410232052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play410232053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.875

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

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(410232052).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 35 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 35)

				if (35 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 35)) > 0 and var_216_0 < var_216_3 then
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
	Play410232053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410232053
		arg_217_1.duration_ = 9.87

		local var_217_0 = {
			ja = 9.866,
			CriLanguages = 7.633,
			zh = 7.633
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
				arg_217_0:Play410232054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10060 = arg_217_1.actors_["10060"].transform.localPosition
				arg_217_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10060", 3)

				for iter_220_0 = 0, arg_217_1.actors_["10060"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10060"].transform:GetChild(iter_220_0)

					if var_220_0.name == "" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10060"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_220_2 = arg_217_1.actors_["10060"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10060 == nil then
				arg_217_1.var_.actorSpriteComps10060 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps10060 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								iter_220_2.color = Color.New(Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_2.color.r, 1, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_2.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10060 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10060 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(410232053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 26 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 26)

				if (26 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 26)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232053", "story_v_out_410232.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232053", "story_v_out_410232.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_410232", "410232053", "story_v_out_410232.awb")

						arg_217_1:RecordAudio("410232053", var_220_12)
						arg_217_1:RecordAudio("410232053", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410232", "410232053", "story_v_out_410232.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410232", "410232053", "story_v_out_410232.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play410232054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410232054
		arg_221_1.duration_ = 4.13

		local var_221_0 = {
			ja = 4.133,
			CriLanguages = 2.2,
			zh = 1.733
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
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10060 = arg_221_1.actors_["10060"].transform.localPosition
				arg_221_1.actors_["10060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10060", 3)

				for iter_224_0 = 0, arg_221_1.actors_["10060"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10060"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10060"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10060, Vector3.New(0, -400, 0), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10060"].transform.localPosition = Vector3.New(0, -400, 0)
			end

			local var_224_2 = arg_221_1.actors_["10060"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10060 == nil then
				arg_221_1.var_.actorSpriteComps10060 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10060 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
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

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10060 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10060 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.125

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(410232054)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 5 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 5)

				if (5 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 5)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410232", "410232054", "story_v_out_410232.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_410232", "410232054", "story_v_out_410232.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_410232", "410232054", "story_v_out_410232.awb")

						arg_221_1:RecordAudio("410232054", var_224_12)
						arg_221_1:RecordAudio("410232054", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410232", "410232054", "story_v_out_410232.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410232", "410232054", "story_v_out_410232.awb")
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
				actorName = "10060",
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
	assets = {
		"TextureConfig/Background/ST62",
		"TextureConfig/Background/ST67"
	},
	voices = {
		"story_v_out_410232.awb"
	}
}
