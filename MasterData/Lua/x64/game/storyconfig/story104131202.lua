return {
	Play413122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413122001
		arg_1_1.duration_ = 7.83

		local var_1_0 = {
			zh = 6.333,
			ja = 7.833
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
				arg_1_0:Play413122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0603a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0603a")
				var_4_0.name = "ST0603a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0603a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0603a

				arg_1_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0603a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10092_1"

			if arg_1_1.actors_["10092_1"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

				if not isNil(var_4_10) then
					local var_4_11 = Object.Instantiate(var_4_10, arg_1_1.canvasGo_.transform)

					var_4_11.transform:SetSiblingIndex(1)

					var_4_11.name = var_4_9
					var_4_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_9] = var_4_11

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_12 = arg_1_1.actors_["10092_1"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10092_1 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_4_15 = arg_1_1.actors_["10092_1"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10092_1 == nil then
				arg_1_1.var_.actorSpriteComps10092_1 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10092_1 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10092_1 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10092_1 = nil
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10092_1"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10092_1 = var_4_18.alpha
					arg_1_1.var_.characterEffect10092_1 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10092_1 = 0
			end

			local var_4_19 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_19 then
				if arg_1_1.var_.characterEffect10092_1 then
					arg_1_1.var_.characterEffect10092_1.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10092_1, 1, (arg_1_1.time_ - 1.8) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_19 and arg_1_1.time_ < 1.8 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10092_1 then
				arg_1_1.var_.characterEffect10092_1.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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

			local var_4_26 = 0

			arg_1_1.isInRecall_ = false

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(false)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					for iter_4_11, iter_4_12 in ipairs((iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_12.color = iter_4_12.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_27 = 0.2

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_26) / var_4_27)
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 0
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2.2
			local var_4_29 = 0.35

			if 2.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(413122001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 14 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 14)

				if (14 <= 0 and var_4_29 or var_4_29 * (utf8.len(var_4_32) / 14)) > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_28 = var_4_28 + 0.3

					if var_4_34 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122001", "story_v_out_413122.awb") ~= 0 then
					local var_4_35 = manager.audio:GetVoiceLength("story_v_out_413122", "413122001", "story_v_out_413122.awb") / 1000

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end

					if var_4_31.prefab_name ~= "" and arg_1_1.actors_[var_4_31.prefab_name] ~= nil then
						local var_4_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_31.prefab_name].transform, "story_v_out_413122", "413122001", "story_v_out_413122.awb")

						arg_1_1:RecordAudio("413122001", var_4_36)
						arg_1_1:RecordAudio("413122001", var_4_36)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413122", "413122001", "story_v_out_413122.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413122", "413122001", "story_v_out_413122.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_28 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413122002
		arg_9_1.duration_ = 5.73

		local var_9_0 = {
			zh = 3.366,
			ja = 5.733
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
				arg_9_0:Play413122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10093"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10093"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10093"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10093"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 4)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_4" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_12_5 = arg_9_1.actors_["10092_1"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092_1 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092_1", 2)

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
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_12_8 = arg_9_1.actors_["10093"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_7 then
						iter_12_7.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_11 = arg_9_1.actors_["10092_1"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10092_1 == nil then
				arg_9_1.var_.actorSpriteComps10092_1 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_12 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 and not isNil(var_12_11) then
				if arg_9_1.var_.actorSpriteComps10092_1 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10092_1 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_12_11 then
						iter_12_11.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_12_14 = 0
			local var_12_15 = 0.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_16 = arg_9_1:GetWordFromCfg(413122002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 19 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 19)

				if (19 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 19)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122002", "story_v_out_413122.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_413122", "413122002", "story_v_out_413122.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_413122", "413122002", "story_v_out_413122.awb")

						arg_9_1:RecordAudio("413122002", var_12_21)
						arg_9_1:RecordAudio("413122002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413122", "413122002", "story_v_out_413122.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413122", "413122002", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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
	Play413122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413122003
		arg_13_1.duration_ = 9

		local var_13_0 = {
			zh = 9,
			ja = 7.3
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
				arg_13_0:Play413122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10092_1"]) and arg_13_1.var_.actorSpriteComps10092_1 == nil then
				arg_13_1.var_.actorSpriteComps10092_1 = arg_13_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10092_1"]) then
				if arg_13_1.var_.actorSpriteComps10092_1 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 1, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10092_1"]) and arg_13_1.var_.actorSpriteComps10092_1 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_16_2 = arg_13_1.actors_["10093"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								iter_16_5.color = Color.New(Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_5.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_5.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_7 then
						iter_16_7.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 1.025

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(413122003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 41 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 41)

				if (41 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 41)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122003", "story_v_out_413122.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122003", "story_v_out_413122.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_413122", "413122003", "story_v_out_413122.awb")

						arg_13_1:RecordAudio("413122003", var_16_12)
						arg_13_1:RecordAudio("413122003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413122", "413122003", "story_v_out_413122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413122", "413122003", "story_v_out_413122.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_13 and arg_13_1.time_ < var_16_5 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413122004
		arg_17_1.duration_ = 5

		local var_17_0 = {
			zh = 5,
			ja = 4.366
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
				arg_17_0:Play413122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10093 = arg_17_1.actors_["10093"].transform.localPosition
				arg_17_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10093", 4)

				for iter_20_0 = 0, arg_17_1.actors_["10093"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10093"].transform:GetChild(iter_20_0)

					if var_20_0.name == "split_3" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_20_2 = arg_17_1.actors_["10093"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 == nil then
				arg_17_1.var_.actorSpriteComps10093 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10093 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10093 = nil
			end

			local var_20_5 = arg_17_1.actors_["10092_1"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092_1 == nil then
				arg_17_1.var_.actorSpriteComps10092_1 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10092_1 then
					for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_20_6 then
							if arg_17_1.isInRecall_ then
								iter_20_6.color = Color.New(Mathf.Lerp(iter_20_6.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_6.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_6.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_6.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_6.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10092_1 then
				for iter_20_7, iter_20_8 in pairs(arg_17_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_20_8 then
						iter_20_8.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.775

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(413122004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 31 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 31)

				if (31 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 31)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122004", "story_v_out_413122.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122004", "story_v_out_413122.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_413122", "413122004", "story_v_out_413122.awb")

						arg_17_1:RecordAudio("413122004", var_20_15)
						arg_17_1:RecordAudio("413122004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413122", "413122004", "story_v_out_413122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413122", "413122004", "story_v_out_413122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play413122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413122005
		arg_21_1.duration_ = 6.57

		local var_21_0 = {
			zh = 6.566,
			ja = 5.2
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
				arg_21_0:Play413122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092_1 = arg_21_1.actors_["10092_1"].transform.localPosition
				arg_21_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_24_0 = 0, arg_21_1.actors_["10092_1"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10092_1"].transform:GetChild(iter_24_0)

					if var_24_0.name == "split_1_1" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_24_2 = arg_21_1.actors_["10092_1"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10092_1 == nil then
				arg_21_1.var_.actorSpriteComps10092_1 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10092_1 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10092_1 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_24_5 = arg_21_1.actors_["10093"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10093 == nil then
				arg_21_1.var_.actorSpriteComps10093 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps10093 then
					for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_24_6 then
							if arg_21_1.isInRecall_ then
								iter_24_6.color = Color.New(Mathf.Lerp(iter_24_6.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_6.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_6.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_6.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_6.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps10093 then
				for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_24_8 then
						iter_24_8.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10093 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(413122005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 35 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 35)

				if (35 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 35)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122005", "story_v_out_413122.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122005", "story_v_out_413122.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_413122", "413122005", "story_v_out_413122.awb")

						arg_21_1:RecordAudio("413122005", var_24_15)
						arg_21_1:RecordAudio("413122005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413122", "413122005", "story_v_out_413122.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413122", "413122005", "story_v_out_413122.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413122006
		arg_25_1.duration_ = 9.27

		local var_25_0 = {
			zh = 6.766,
			ja = 9.266
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
				arg_25_0:Play413122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10093"]) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = arg_25_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10093"]) then
				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 1, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10093"]) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_2 = arg_25_1.actors_["10092_1"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10092_1 == nil then
				arg_25_1.var_.actorSpriteComps10092_1 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10092_1 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10092_1 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(413122006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 41 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 41)

				if (41 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 41)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122006", "story_v_out_413122.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122006", "story_v_out_413122.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_413122", "413122006", "story_v_out_413122.awb")

						arg_25_1:RecordAudio("413122006", var_28_12)
						arg_25_1:RecordAudio("413122006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413122", "413122006", "story_v_out_413122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413122", "413122006", "story_v_out_413122.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play413122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413122007
		arg_29_1.duration_ = 8.97

		local var_29_0 = {
			zh = 7.233,
			ja = 8.966
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
				arg_29_0:Play413122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10092_1 = arg_29_1.actors_["10092_1"].transform.localPosition
				arg_29_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_32_0 = 0, arg_29_1.actors_["10092_1"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10092_1"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_1_1" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_32_2 = arg_29_1.actors_["10092_1"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10092_1 == nil then
				arg_29_1.var_.actorSpriteComps10092_1 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10092_1 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10092_1 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_32_5 = arg_29_1.actors_["10093"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10093 == nil then
				arg_29_1.var_.actorSpriteComps10093 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps10093 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								iter_32_6.color = Color.New(Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_6), Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_6), (Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_6)))
							else
								local var_32_7 = Mathf.Lerp(iter_32_6.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_6)

								iter_32_6.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10093 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_32_8 then
						iter_32_8.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10093 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(413122007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 37 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 37)

				if (37 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 37)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122007", "story_v_out_413122.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122007", "story_v_out_413122.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_413122", "413122007", "story_v_out_413122.awb")

						arg_29_1:RecordAudio("413122007", var_32_15)
						arg_29_1:RecordAudio("413122007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413122", "413122007", "story_v_out_413122.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413122", "413122007", "story_v_out_413122.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413122008
		arg_33_1.duration_ = 7.07

		local var_33_0 = {
			zh = 4.366,
			ja = 7.066
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
				arg_33_0:Play413122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.65

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(413122008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 26 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 26)

				if (26 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 26)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122008", "story_v_out_413122.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122008", "story_v_out_413122.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_413122", "413122008", "story_v_out_413122.awb")

						arg_33_1:RecordAudio("413122008", var_36_6)
						arg_33_1:RecordAudio("413122008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413122", "413122008", "story_v_out_413122.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413122", "413122008", "story_v_out_413122.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413122009
		arg_37_1.duration_ = 3.2

		local var_37_0 = {
			zh = 2.966,
			ja = 3.2
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
				arg_37_0:Play413122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092_1 = arg_37_1.actors_["10092_1"].transform.localPosition
				arg_37_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_40_0 = 0, arg_37_1.actors_["10092_1"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10092_1"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_40_2 = arg_37_1.actors_["10092_1"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_4 then
						iter_40_4.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413122009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 17 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 17)

				if (17 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 17)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122009", "story_v_out_413122.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122009", "story_v_out_413122.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413122", "413122009", "story_v_out_413122.awb")

						arg_37_1:RecordAudio("413122009", var_40_12)
						arg_37_1:RecordAudio("413122009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413122", "413122009", "story_v_out_413122.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413122", "413122009", "story_v_out_413122.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413122010
		arg_41_1.duration_ = 6.6

		local var_41_0 = {
			zh = 4.9,
			ja = 6.6
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
				arg_41_0:Play413122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["10022"] == nil then
				local var_44_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_44_0) then
					local var_44_1 = Object.Instantiate(var_44_0, arg_41_1.canvasGo_.transform)

					var_44_1.transform:SetSiblingIndex(1)

					var_44_1.name = "10022"
					var_44_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_["10022"] = var_44_1

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs((var_44_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_2 = arg_41_1.actors_["10022"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10022 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10022", 4)

				for iter_44_2 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_2)

					if var_44_3.name == "split_6" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_44_5 = arg_41_1.actors_["10092_1"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092_1 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_44_3 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_3)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_44_8 = arg_41_1.actors_["10022"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10022 == nil then
				arg_41_1.var_.actorSpriteComps10022 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps10022 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_5.color.r, 1, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_5.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10022 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10022 = nil
			end

			local var_44_11 = arg_41_1.actors_["10092_1"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = var_44_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_12 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_12 and not isNil(var_44_11) then
				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_9 then
							if arg_41_1.isInRecall_ then
								iter_44_9.color = Color.New(Mathf.Lerp(iter_44_9.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_12), Mathf.Lerp(iter_44_9.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_12), (Mathf.Lerp(iter_44_9.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_12)))
							else
								local var_44_13 = Mathf.Lerp(iter_44_9.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_12)

								iter_44_9.color = Color.New(var_44_13, var_44_13, var_44_13)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_12 and arg_41_1.time_ < 0 + var_44_12 + arg_44_0 and not isNil(var_44_11) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_10, iter_44_11 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_11 then
						iter_44_11.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_14 = 0
			local var_44_15 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(413122010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 26 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 26)

				if (26 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 26)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122010", "story_v_out_413122.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_413122", "413122010", "story_v_out_413122.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_413122", "413122010", "story_v_out_413122.awb")

						arg_41_1:RecordAudio("413122010", var_44_21)
						arg_41_1:RecordAudio("413122010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413122", "413122010", "story_v_out_413122.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413122", "413122010", "story_v_out_413122.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_15, arg_41_1.talkMaxDuration)

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_22 and arg_41_1.time_ < var_44_14 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413122011
		arg_45_1.duration_ = 6.57

		local var_45_0 = {
			zh = 2.7,
			ja = 6.566
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
				arg_45_0:Play413122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092_1 = arg_45_1.actors_["10092_1"].transform.localPosition
				arg_45_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_48_0 = 0, arg_45_1.actors_["10092_1"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10092_1"].transform:GetChild(iter_48_0)

					if var_48_0.name == "" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_48_2 = arg_45_1.actors_["10092_1"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10092_1 == nil then
				arg_45_1.var_.actorSpriteComps10092_1 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10092_1 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10092_1 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_48_4 then
						iter_48_4.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_48_5 = arg_45_1.actors_["10022"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								iter_48_6.color = Color.New(Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_6.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_6.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_8 then
						iter_48_8.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.3

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(413122011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 12 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 12)

				if (12 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 12)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122011", "story_v_out_413122.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122011", "story_v_out_413122.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_413122", "413122011", "story_v_out_413122.awb")

						arg_45_1:RecordAudio("413122011", var_48_15)
						arg_45_1:RecordAudio("413122011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413122", "413122011", "story_v_out_413122.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413122", "413122011", "story_v_out_413122.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413122012
		arg_49_1.duration_ = 4.6

		local var_49_0 = {
			zh = 4.6,
			ja = 3.1
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
				arg_49_0:Play413122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10022"]) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = arg_49_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10022"]) then
				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10022"]) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_2 = arg_49_1.actors_["10092_1"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10092_1 == nil then
				arg_49_1.var_.actorSpriteComps10092_1 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10092_1 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								iter_52_5.color = Color.New(Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_5.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_5.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10092_1 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(413122012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 24 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 24)

				if (24 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 24)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122012", "story_v_out_413122.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122012", "story_v_out_413122.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_413122", "413122012", "story_v_out_413122.awb")

						arg_49_1:RecordAudio("413122012", var_52_12)
						arg_49_1:RecordAudio("413122012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413122", "413122012", "story_v_out_413122.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413122", "413122012", "story_v_out_413122.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_13 and arg_49_1.time_ < var_52_5 + var_52_13 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413122013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 7.4,
			ja = 6.933
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
				arg_53_0:Play413122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10092_1"]) and arg_53_1.var_.actorSpriteComps10092_1 == nil then
				arg_53_1.var_.actorSpriteComps10092_1 = arg_53_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10092_1"]) then
				if arg_53_1.var_.actorSpriteComps10092_1 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10092_1"]) and arg_53_1.var_.actorSpriteComps10092_1 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_56_2 = arg_53_1.actors_["10022"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10022 == nil then
				arg_53_1.var_.actorSpriteComps10022 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10022 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								iter_56_5.color = Color.New(Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_5.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_5.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_7 then
						iter_56_7.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.925

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(413122013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 37 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 37)

				if (37 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 37)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122013", "story_v_out_413122.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122013", "story_v_out_413122.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413122", "413122013", "story_v_out_413122.awb")

						arg_53_1:RecordAudio("413122013", var_56_12)
						arg_53_1:RecordAudio("413122013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413122", "413122013", "story_v_out_413122.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413122", "413122013", "story_v_out_413122.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413122014
		arg_57_1.duration_ = 5.73

		local var_57_0 = {
			zh = 3.366,
			ja = 5.733
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
				arg_57_0:Play413122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10092_1 = arg_57_1.actors_["10092_1"].transform.localPosition
				arg_57_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_60_0 = 0, arg_57_1.actors_["10092_1"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10092_1"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_8" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_60_2 = arg_57_1.actors_["10092_1"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10092_1 == nil then
				arg_57_1.var_.actorSpriteComps10092_1 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10092_1 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10092_1 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.6

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(413122014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 24 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 24)

				if (24 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 24)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122014", "story_v_out_413122.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122014", "story_v_out_413122.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_413122", "413122014", "story_v_out_413122.awb")

						arg_57_1:RecordAudio("413122014", var_60_12)
						arg_57_1:RecordAudio("413122014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413122", "413122014", "story_v_out_413122.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413122", "413122014", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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
	Play413122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413122015
		arg_61_1.duration_ = 10.53

		local var_61_0 = {
			zh = 8.433,
			ja = 10.533
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
				arg_61_0:Play413122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10022"]) and arg_61_1.var_.actorSpriteComps10022 == nil then
				arg_61_1.var_.actorSpriteComps10022 = arg_61_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10022"]) then
				if arg_61_1.var_.actorSpriteComps10022 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10022"]) and arg_61_1.var_.actorSpriteComps10022 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10022 = nil
			end

			local var_64_2 = arg_61_1.actors_["10092_1"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10092_1 == nil then
				arg_61_1.var_.actorSpriteComps10092_1 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10092_1 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10092_1 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 1.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(413122015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 46 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 46)

				if (46 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 46)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122015", "story_v_out_413122.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122015", "story_v_out_413122.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_413122", "413122015", "story_v_out_413122.awb")

						arg_61_1:RecordAudio("413122015", var_64_12)
						arg_61_1:RecordAudio("413122015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413122", "413122015", "story_v_out_413122.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413122", "413122015", "story_v_out_413122.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413122016
		arg_65_1.duration_ = 10.73

		local var_65_0 = {
			zh = 7,
			ja = 10.733
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
				arg_65_0:Play413122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10022"]) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = arg_65_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10022"]) then
				if arg_65_1.var_.actorSpriteComps10022 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10022"]) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.975

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(413122016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 39 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 39)

				if (39 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 39)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122016", "story_v_out_413122.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122016", "story_v_out_413122.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_413122", "413122016", "story_v_out_413122.awb")

						arg_65_1:RecordAudio("413122016", var_68_9)
						arg_65_1:RecordAudio("413122016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413122", "413122016", "story_v_out_413122.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413122", "413122016", "story_v_out_413122.awb")
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
	Play413122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413122017
		arg_69_1.duration_ = 5.4

		local var_69_0 = {
			zh = 5.4,
			ja = 4.033
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
				arg_69_0:Play413122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092_1 = arg_69_1.actors_["10092_1"].transform.localPosition
				arg_69_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_72_0 = 0, arg_69_1.actors_["10092_1"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10092_1"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_8" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_72_2 = arg_69_1.actors_["10092_1"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10092_1 == nil then
				arg_69_1.var_.actorSpriteComps10092_1 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10092_1 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10092_1 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_72_5 = arg_69_1.actors_["10022"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10022 == nil then
				arg_69_1.var_.actorSpriteComps10022 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps10022 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								iter_72_6.color = Color.New(Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_6.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_6.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10022 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_72_8 then
						iter_72_8.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10022 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 0.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(413122017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 27 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 27)

				if (27 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 27)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122017", "story_v_out_413122.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122017", "story_v_out_413122.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_413122", "413122017", "story_v_out_413122.awb")

						arg_69_1:RecordAudio("413122017", var_72_15)
						arg_69_1:RecordAudio("413122017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413122", "413122017", "story_v_out_413122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413122", "413122017", "story_v_out_413122.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413122018
		arg_73_1.duration_ = 4.5

		local var_73_0 = {
			zh = 3.466,
			ja = 4.5
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
				arg_73_0:Play413122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10092_1"]) and arg_73_1.var_.actorSpriteComps10092_1 == nil then
				arg_73_1.var_.actorSpriteComps10092_1 = arg_73_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10092_1"]) then
				if arg_73_1.var_.actorSpriteComps10092_1 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10092_1"]) and arg_73_1.var_.actorSpriteComps10092_1 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(413122018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 19)

				if (19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 19)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122018", "story_v_out_413122.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122018", "story_v_out_413122.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_413122", "413122018", "story_v_out_413122.awb")

						arg_73_1:RecordAudio("413122018", var_76_9)
						arg_73_1:RecordAudio("413122018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413122", "413122018", "story_v_out_413122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413122", "413122018", "story_v_out_413122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413122019
		arg_77_1.duration_ = 5.4

		local var_77_0 = {
			zh = 4.766,
			ja = 5.4
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
				arg_77_0:Play413122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10022"]) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = arg_77_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10022"]) then
				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10022"]) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_2 = arg_77_1.actors_["10092_1"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092_1 == nil then
				arg_77_1.var_.actorSpriteComps10092_1 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10092_1 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10092_1 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.65

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413122019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 26 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 26)

				if (26 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 26)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122019", "story_v_out_413122.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122019", "story_v_out_413122.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413122", "413122019", "story_v_out_413122.awb")

						arg_77_1:RecordAudio("413122019", var_80_12)
						arg_77_1:RecordAudio("413122019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413122", "413122019", "story_v_out_413122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413122", "413122019", "story_v_out_413122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play413122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413122020
		arg_81_1.duration_ = 8.8

		local var_81_0 = {
			zh = 6.566,
			ja = 8.8
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
				arg_81_0:Play413122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = arg_81_1.actors_["10092_1"].transform.localPosition
				arg_81_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_84_0 = 0, arg_81_1.actors_["10092_1"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10092_1"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_2" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_84_2 = arg_81_1.actors_["10092_1"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10092_1 == nil then
				arg_81_1.var_.actorSpriteComps10092_1 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10092_1 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10092_1 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_84_5 = arg_81_1.actors_["10022"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_6.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_6.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.875

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(413122020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 35 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 35)

				if (35 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 35)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122020", "story_v_out_413122.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122020", "story_v_out_413122.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_413122", "413122020", "story_v_out_413122.awb")

						arg_81_1:RecordAudio("413122020", var_84_15)
						arg_81_1:RecordAudio("413122020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413122", "413122020", "story_v_out_413122.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413122", "413122020", "story_v_out_413122.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play413122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413122021
		arg_85_1.duration_ = 7.33

		local var_85_0 = {
			zh = 5.166,
			ja = 7.333
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
				arg_85_0:Play413122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = arg_85_1.actors_["10092_1"].transform.localPosition
				arg_85_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_88_0 = 0, arg_85_1.actors_["10092_1"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10092_1"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_1_1" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_88_2 = 0
			local var_88_3 = 0.675

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(413122021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 27 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 27)

				if (27 <= 0 and var_88_3 or var_88_3 * (utf8.len(var_88_5) / 27)) > 0 and var_88_3 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122021", "story_v_out_413122.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122021", "story_v_out_413122.awb") / 1000

					if var_88_8 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_2
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_413122", "413122021", "story_v_out_413122.awb")

						arg_85_1:RecordAudio("413122021", var_88_9)
						arg_85_1:RecordAudio("413122021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413122", "413122021", "story_v_out_413122.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413122", "413122021", "story_v_out_413122.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413122022
		arg_89_1.duration_ = 5.77

		local var_89_0 = {
			zh = 4.366,
			ja = 5.766
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
				arg_89_0:Play413122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.525

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413122022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 21 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 21)

				if (21 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 21)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122022", "story_v_out_413122.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122022", "story_v_out_413122.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413122", "413122022", "story_v_out_413122.awb")

						arg_89_1:RecordAudio("413122022", var_92_6)
						arg_89_1:RecordAudio("413122022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413122", "413122022", "story_v_out_413122.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413122", "413122022", "story_v_out_413122.awb")
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
	Play413122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413122023
		arg_93_1.duration_ = 7

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 1 < arg_93_1.time_ and arg_93_1.time_ <= 1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092_1 = arg_93_1.actors_["10092_1"].transform.localPosition
				arg_93_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_96_0 = 0, arg_93_1.actors_["10092_1"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10092_1"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 1 <= arg_93_1.time_ and arg_93_1.time_ < 1 + var_96_1 then
				arg_93_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_93_1.time_ - 1) / var_96_1)
			end

			if arg_93_1.time_ >= 1 + var_96_1 and arg_93_1.time_ < 1 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_96_2 = arg_93_1.actors_["10022"].transform

			if 1 < arg_93_1.time_ and arg_93_1.time_ <= 1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 6)

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

			if 1 <= arg_93_1.time_ and arg_93_1.time_ < 1 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_93_1.time_ - 1) / var_96_4)
			end

			if arg_93_1.time_ >= 1 + var_96_4 and arg_93_1.time_ < 1 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(1500, -315, -320)
			end

			if 1 < arg_93_1.time_ and arg_93_1.time_ <= 1 + arg_96_0 then
				local var_96_5 = arg_93_1.bgs_.ST0603a

				arg_93_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = 2 * (var_96_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_5.transform.localScale = Vector3.New(var_96_7 / var_96_6.sprite.bounds.size.y < var_96_7 * manager.ui.mainCameraCom_.aspect / var_96_6.sprite.bounds.size.x and var_96_7 * manager.ui.mainCameraCom_.aspect / var_96_6.sprite.bounds.size.x or var_96_7 / var_96_6.sprite.bounds.size.y, var_96_7 / var_96_6.sprite.bounds.size.y < var_96_7 * manager.ui.mainCameraCom_.aspect / var_96_6.sprite.bounds.size.x and var_96_7 * manager.ui.mainCameraCom_.aspect / var_96_6.sprite.bounds.size.x or var_96_7 / var_96_6.sprite.bounds.size.y, 0)
				end

				for iter_96_2, iter_96_3 in pairs(arg_93_1.bgs_) do
					if iter_96_2 ~= "ST0603a" then
						iter_96_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_8 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_9 = 1

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 then
				local var_96_10 = Color.New(0, 0, 0)

				var_96_10.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_8) / var_96_9)
				arg_93_1.mask_.color = var_96_10
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 then
				local var_96_11 = Color.New(0, 0, 0)

				var_96_11.a = 1
				arg_93_1.mask_.color = var_96_11
			end

			local var_96_12 = 1

			if 1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_13 = 1

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_13 then
				local var_96_14 = Color.New(0, 0, 0)

				var_96_14.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_12) / var_96_13)
				arg_93_1.mask_.color = var_96_14
			end

			if arg_93_1.time_ >= var_96_12 + var_96_13 and arg_93_1.time_ < var_96_12 + var_96_13 + arg_96_0 then
				local var_96_15 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_15.a = 0
				arg_93_1.mask_.color = var_96_15
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_16 = 2
			local var_96_17 = 1.45

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_18 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_18:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(413122023).content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 58 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 58)

				if (58 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 58)) > 0 and var_96_17 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21
					var_96_16 = var_96_16 + 0.3

					if var_96_21 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = var_96_16 + 0.3
			local var_96_23 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_23 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_22) / var_96_23

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_22 + var_96_23 and arg_93_1.time_ < var_96_22 + var_96_23 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play413122024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 413122024
		arg_99_1.duration_ = 5.53

		local var_99_0 = {
			zh = 3.166,
			ja = 5.533
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
				arg_99_0:Play413122025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10092_1 = arg_99_1.actors_["10092_1"].transform.localPosition
				arg_99_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_102_0 = 0, arg_99_1.actors_["10092_1"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["10092_1"].transform:GetChild(iter_102_0)

					if var_102_0.name == "" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_102_2 = arg_99_1.actors_["10022"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10022 = var_102_2.localPosition
				var_102_2.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10022", 7)

				for iter_102_1 = 0, var_102_2.childCount - 1 do
					local var_102_3 = var_102_2:GetChild(iter_102_1)

					if var_102_3.name == "" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_99_1.time_ - 0) / var_102_4)
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_102_5 = arg_99_1.actors_["10092_1"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.actorSpriteComps10092_1 == nil then
				arg_99_1.var_.actorSpriteComps10092_1 = var_102_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_6 = 2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.actorSpriteComps10092_1 then
					for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_102_3 then
							if arg_99_1.isInRecall_ then
								iter_102_3.color = Color.New(Mathf.Lerp(iter_102_3.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_6), Mathf.Lerp(iter_102_3.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_6), (Mathf.Lerp(iter_102_3.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_6)))
							else
								local var_102_7 = Mathf.Lerp(iter_102_3.color.r, 1, (arg_99_1.time_ - 0) / var_102_6)

								iter_102_3.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.actorSpriteComps10092_1 then
				for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_102_5 then
						iter_102_5.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_102_8 = arg_99_1.actors_["10022"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps10022 == nil then
				arg_99_1.var_.actorSpriteComps10022 = var_102_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_9 = 2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_9 and not isNil(var_102_8) then
				if arg_99_1.var_.actorSpriteComps10022 then
					for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_102_7 then
							if arg_99_1.isInRecall_ then
								iter_102_7.color = Color.New(Mathf.Lerp(iter_102_7.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_9), Mathf.Lerp(iter_102_7.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_9), (Mathf.Lerp(iter_102_7.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_9)))
							else
								local var_102_10 = Mathf.Lerp(iter_102_7.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_9)

								iter_102_7.color = Color.New(var_102_10, var_102_10, var_102_10)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_9 and arg_99_1.time_ < 0 + var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps10022 then
				for iter_102_8, iter_102_9 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_102_9 then
						iter_102_9.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps10022 = nil
			end

			local var_102_11 = 0
			local var_102_12 = 0.325

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_11 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_13 = arg_99_1:GetWordFromCfg(413122024)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 13 <= 0 and var_102_12 or var_102_12 * (utf8.len(var_102_14) / 13)

				if (13 <= 0 and var_102_12 or var_102_12 * (utf8.len(var_102_14) / 13)) > 0 and var_102_12 < var_102_16 then
					arg_99_1.talkMaxDuration = var_102_16

					if var_102_16 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_11
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122024", "story_v_out_413122.awb") ~= 0 then
					local var_102_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122024", "story_v_out_413122.awb") / 1000

					if var_102_17 + var_102_11 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_11
					end

					if var_102_13.prefab_name ~= "" and arg_99_1.actors_[var_102_13.prefab_name] ~= nil then
						local var_102_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_13.prefab_name].transform, "story_v_out_413122", "413122024", "story_v_out_413122.awb")

						arg_99_1:RecordAudio("413122024", var_102_18)
						arg_99_1:RecordAudio("413122024", var_102_18)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_413122", "413122024", "story_v_out_413122.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_413122", "413122024", "story_v_out_413122.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = math.max(var_102_12, arg_99_1.talkMaxDuration)

			if var_102_11 <= arg_99_1.time_ and arg_99_1.time_ < var_102_11 + var_102_19 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_11) / var_102_19

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_11 + var_102_19 and arg_99_1.time_ < var_102_11 + var_102_19 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413122025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413122025
		arg_103_1.duration_ = 4.7

		local var_103_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_103_0:Play413122026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10022 = arg_103_1.actors_["10022"].transform.localPosition
				arg_103_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10022", 4)

				for iter_106_0 = 0, arg_103_1.actors_["10022"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["10022"].transform:GetChild(iter_106_0)

					if var_106_0.name == "" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_106_2 = arg_103_1.actors_["10092_1"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10092_1 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10092_1", 2)

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
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_106_5 = arg_103_1.actors_["10022"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.actorSpriteComps10022 == nil then
				arg_103_1.var_.actorSpriteComps10022 = var_106_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_6 = 2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_6 and not isNil(var_106_5) then
				if arg_103_1.var_.actorSpriteComps10022 then
					for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_106_3 then
							if arg_103_1.isInRecall_ then
								iter_106_3.color = Color.New(Mathf.Lerp(iter_106_3.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_6), Mathf.Lerp(iter_106_3.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_6), (Mathf.Lerp(iter_106_3.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_6)))
							else
								local var_106_7 = Mathf.Lerp(iter_106_3.color.r, 1, (arg_103_1.time_ - 0) / var_106_6)

								iter_106_3.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_6 and arg_103_1.time_ < 0 + var_106_6 + arg_106_0 and not isNil(var_106_5) and arg_103_1.var_.actorSpriteComps10022 then
				for iter_106_4, iter_106_5 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_106_5 then
						iter_106_5.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10022 = nil
			end

			local var_106_8 = arg_103_1.actors_["10092_1"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10092_1 == nil then
				arg_103_1.var_.actorSpriteComps10092_1 = var_106_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_9 and not isNil(var_106_8) then
				if arg_103_1.var_.actorSpriteComps10092_1 then
					for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_106_7 then
							if arg_103_1.isInRecall_ then
								iter_106_7.color = Color.New(Mathf.Lerp(iter_106_7.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_9), Mathf.Lerp(iter_106_7.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_9), (Mathf.Lerp(iter_106_7.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_9)))
							else
								local var_106_10 = Mathf.Lerp(iter_106_7.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_9)

								iter_106_7.color = Color.New(var_106_10, var_106_10, var_106_10)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_9 and arg_103_1.time_ < 0 + var_106_9 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10092_1 then
				for iter_106_8, iter_106_9 in pairs(arg_103_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_106_9 then
						iter_106_9.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_106_11 = 0
			local var_106_12 = 0.375

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_13 = arg_103_1:GetWordFromCfg(413122025)
				local var_106_14 = arg_103_1:FormatText(var_106_13.content)

				arg_103_1.text_.text = var_106_14

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 15 <= 0 and var_106_12 or var_106_12 * (utf8.len(var_106_14) / 15)

				if (15 <= 0 and var_106_12 or var_106_12 * (utf8.len(var_106_14) / 15)) > 0 and var_106_12 < var_106_16 then
					arg_103_1.talkMaxDuration = var_106_16

					if var_106_16 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_14
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122025", "story_v_out_413122.awb") ~= 0 then
					local var_106_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122025", "story_v_out_413122.awb") / 1000

					if var_106_17 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_17 + var_106_11
					end

					if var_106_13.prefab_name ~= "" and arg_103_1.actors_[var_106_13.prefab_name] ~= nil then
						local var_106_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_13.prefab_name].transform, "story_v_out_413122", "413122025", "story_v_out_413122.awb")

						arg_103_1:RecordAudio("413122025", var_106_18)
						arg_103_1:RecordAudio("413122025", var_106_18)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413122", "413122025", "story_v_out_413122.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413122", "413122025", "story_v_out_413122.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_19 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_19 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_19

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_19 and arg_103_1.time_ < var_106_11 + var_106_19 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413122026
		arg_107_1.duration_ = 5.3

		local var_107_0 = {
			zh = 5.3,
			ja = 2.866
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play413122027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10092_1 = arg_107_1.actors_["10092_1"].transform.localPosition
				arg_107_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_110_0 = 0, arg_107_1.actors_["10092_1"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10092_1"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_2" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_110_2 = arg_107_1.actors_["10022"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10022 = var_110_2.localPosition
				var_110_2.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10022", 4)

				for iter_110_1 = 0, var_110_2.childCount - 1 do
					local var_110_3 = var_110_2:GetChild(iter_110_1)

					if var_110_3.name == "" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_107_1.time_ - 0) / var_110_4)
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(390, -315, -320)
			end

			local var_110_5 = arg_107_1.actors_["10022"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.actorSpriteComps10022 == nil then
				arg_107_1.var_.actorSpriteComps10022 = var_110_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_6 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 and not isNil(var_110_5) then
				if arg_107_1.var_.actorSpriteComps10022 then
					for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_110_3 then
							if arg_107_1.isInRecall_ then
								iter_110_3.color = Color.New(Mathf.Lerp(iter_110_3.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_6), Mathf.Lerp(iter_110_3.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_6), (Mathf.Lerp(iter_110_3.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_6)))
							else
								local var_110_7 = Mathf.Lerp(iter_110_3.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_6)

								iter_110_3.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and not isNil(var_110_5) and arg_107_1.var_.actorSpriteComps10022 then
				for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_110_5 then
						iter_110_5.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10022 = nil
			end

			local var_110_8 = arg_107_1.actors_["10092_1"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10092_1 == nil then
				arg_107_1.var_.actorSpriteComps10092_1 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 and not isNil(var_110_8) then
				if arg_107_1.var_.actorSpriteComps10092_1 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								iter_110_7.color = Color.New(Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_9), Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_9), (Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_9)))
							else
								local var_110_10 = Mathf.Lerp(iter_110_7.color.r, 1, (arg_107_1.time_ - 0) / var_110_9)

								iter_110_7.color = Color.New(var_110_10, var_110_10, var_110_10)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps10092_1 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_110_9 then
						iter_110_9.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_110_11 = 0
			local var_110_12 = 0.7

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_13 = arg_107_1:GetWordFromCfg(413122026)
				local var_110_14 = arg_107_1:FormatText(var_110_13.content)

				arg_107_1.text_.text = var_110_14

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_16 = 28 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 28)

				if (28 <= 0 and var_110_12 or var_110_12 * (utf8.len(var_110_14) / 28)) > 0 and var_110_12 < var_110_16 then
					arg_107_1.talkMaxDuration = var_110_16

					if var_110_16 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_16 + var_110_11
					end
				end

				arg_107_1.text_.text = var_110_14
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122026", "story_v_out_413122.awb") ~= 0 then
					local var_110_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122026", "story_v_out_413122.awb") / 1000

					if var_110_17 + var_110_11 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_17 + var_110_11
					end

					if var_110_13.prefab_name ~= "" and arg_107_1.actors_[var_110_13.prefab_name] ~= nil then
						local var_110_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_13.prefab_name].transform, "story_v_out_413122", "413122026", "story_v_out_413122.awb")

						arg_107_1:RecordAudio("413122026", var_110_18)
						arg_107_1:RecordAudio("413122026", var_110_18)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413122", "413122026", "story_v_out_413122.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413122", "413122026", "story_v_out_413122.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_19 = math.max(var_110_12, arg_107_1.talkMaxDuration)

			if var_110_11 <= arg_107_1.time_ and arg_107_1.time_ < var_110_11 + var_110_19 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_11) / var_110_19

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_11 + var_110_19 and arg_107_1.time_ < var_110_11 + var_110_19 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play413122027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413122027
		arg_111_1.duration_ = 5.47

		local var_111_0 = {
			zh = 3.933,
			ja = 5.466
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
				arg_111_0:Play413122028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10022 = arg_111_1.actors_["10022"].transform.localPosition
				arg_111_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10022", 4)

				for iter_114_0 = 0, arg_111_1.actors_["10022"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["10022"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_6" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_114_2 = arg_111_1.actors_["10022"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10022 == nil then
				arg_111_1.var_.actorSpriteComps10022 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps10022 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								iter_114_2.color = Color.New(Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_2.color.r, 1, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_2.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10022 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10022 = nil
			end

			local var_114_5 = arg_111_1.actors_["10092_1"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10092_1 == nil then
				arg_111_1.var_.actorSpriteComps10092_1 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps10092_1 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								iter_114_6.color = Color.New(Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_6.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_6.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10092_1 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_114_8 then
						iter_114_8.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(413122027)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 20 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 20)

				if (20 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 20)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122027", "story_v_out_413122.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122027", "story_v_out_413122.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_413122", "413122027", "story_v_out_413122.awb")

						arg_111_1:RecordAudio("413122027", var_114_15)
						arg_111_1:RecordAudio("413122027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413122", "413122027", "story_v_out_413122.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413122", "413122027", "story_v_out_413122.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413122028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413122028
		arg_115_1.duration_ = 12.1

		local var_115_0 = {
			zh = 10.7,
			ja = 12.1
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
				arg_115_0:Play413122029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10092_1 = arg_115_1.actors_["10092_1"].transform.localPosition
				arg_115_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_118_0 = 0, arg_115_1.actors_["10092_1"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["10092_1"].transform:GetChild(iter_118_0)

					if var_118_0.name == "split_1_1" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_118_2 = arg_115_1.actors_["10092_1"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10092_1 == nil then
				arg_115_1.var_.actorSpriteComps10092_1 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps10092_1 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps10092_1 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_118_5 = arg_115_1.actors_["10022"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 == nil then
				arg_115_1.var_.actorSpriteComps10022 = var_118_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 and not isNil(var_118_5) then
				if arg_115_1.var_.actorSpriteComps10022 then
					for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 and not isNil(var_118_5) and arg_115_1.var_.actorSpriteComps10022 then
				for iter_118_7, iter_118_8 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_118_8 then
						iter_118_8.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps10022 = nil
			end

			local var_118_8 = 0
			local var_118_9 = 1.3

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_10 = arg_115_1:GetWordFromCfg(413122028)
				local var_118_11 = arg_115_1:FormatText(var_118_10.content)

				arg_115_1.text_.text = var_118_11

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_13 = 52 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 52)

				if (52 <= 0 and var_118_9 or var_118_9 * (utf8.len(var_118_11) / 52)) > 0 and var_118_9 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_8
					end
				end

				arg_115_1.text_.text = var_118_11
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122028", "story_v_out_413122.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122028", "story_v_out_413122.awb") / 1000

					if var_118_14 + var_118_8 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_8
					end

					if var_118_10.prefab_name ~= "" and arg_115_1.actors_[var_118_10.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_10.prefab_name].transform, "story_v_out_413122", "413122028", "story_v_out_413122.awb")

						arg_115_1:RecordAudio("413122028", var_118_15)
						arg_115_1:RecordAudio("413122028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413122", "413122028", "story_v_out_413122.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413122", "413122028", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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
	Play413122029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413122029
		arg_119_1.duration_ = 5.53

		local var_119_0 = {
			zh = 3.866,
			ja = 5.533
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
				arg_119_0:Play413122030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10022"]) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = arg_119_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10022"]) then
				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10022"]) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_2 = arg_119_1.actors_["10092_1"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10092_1 == nil then
				arg_119_1.var_.actorSpriteComps10092_1 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10092_1 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10092_1 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(413122029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 19 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 19)

				if (19 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 19)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122029", "story_v_out_413122.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122029", "story_v_out_413122.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_413122", "413122029", "story_v_out_413122.awb")

						arg_119_1:RecordAudio("413122029", var_122_12)
						arg_119_1:RecordAudio("413122029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413122", "413122029", "story_v_out_413122.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413122", "413122029", "story_v_out_413122.awb")
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
	Play413122030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413122030
		arg_123_1.duration_ = 9.27

		local var_123_0 = {
			zh = 7.466,
			ja = 9.266
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
				arg_123_0:Play413122031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092_1 = arg_123_1.actors_["10092_1"].transform.localPosition
				arg_123_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_126_0 = 0, arg_123_1.actors_["10092_1"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["10092_1"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_1_1" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_126_2 = arg_123_1.actors_["10092_1"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10092_1 == nil then
				arg_123_1.var_.actorSpriteComps10092_1 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10092_1 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10092_1 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_126_5 = arg_123_1.actors_["10022"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_6 = 2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_6 then
							if arg_123_1.isInRecall_ then
								iter_126_6.color = Color.New(Mathf.Lerp(iter_126_6.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_6), Mathf.Lerp(iter_126_6.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_6), (Mathf.Lerp(iter_126_6.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_6)))
							else
								local var_126_7 = Mathf.Lerp(iter_126_6.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_6)

								iter_126_6.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_7, iter_126_8 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_8 then
						iter_126_8.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.95

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
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

				local var_126_10 = arg_123_1:GetWordFromCfg(413122030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 38 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 38)

				if (38 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 38)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122030", "story_v_out_413122.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122030", "story_v_out_413122.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_413122", "413122030", "story_v_out_413122.awb")

						arg_123_1:RecordAudio("413122030", var_126_15)
						arg_123_1:RecordAudio("413122030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413122", "413122030", "story_v_out_413122.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413122", "413122030", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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
	Play413122031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413122031
		arg_127_1.duration_ = 5.4

		local var_127_0 = {
			zh = 3.366,
			ja = 5.4
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
				arg_127_0:Play413122032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10092_1 = arg_127_1.actors_["10092_1"].transform.localPosition
				arg_127_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_130_0 = 0, arg_127_1.actors_["10092_1"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10092_1"].transform:GetChild(iter_130_0)

					if var_130_0.name == "" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_130_2 = arg_127_1.actors_["10092_1"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10092_1 == nil then
				arg_127_1.var_.actorSpriteComps10092_1 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10092_1 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10092_1 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_5")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_7 = arg_127_1:GetWordFromCfg(413122031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 14 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 14)

				if (14 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 14)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122031", "story_v_out_413122.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122031", "story_v_out_413122.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_413122", "413122031", "story_v_out_413122.awb")

						arg_127_1:RecordAudio("413122031", var_130_12)
						arg_127_1:RecordAudio("413122031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413122", "413122031", "story_v_out_413122.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413122", "413122031", "story_v_out_413122.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413122032
		arg_131_1.duration_ = 5.8

		local var_131_0 = {
			zh = 3.033,
			ja = 5.8
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
				arg_131_0:Play413122033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10022 = arg_131_1.actors_["10022"].transform.localPosition
				arg_131_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10022", 4)

				for iter_134_0 = 0, arg_131_1.actors_["10022"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10022"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_8" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_134_2 = arg_131_1.actors_["10022"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_5 = 0
			local var_134_6 = 0.325

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(413122032)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 13 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 13)

				if (13 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 13)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122032", "story_v_out_413122.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122032", "story_v_out_413122.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_413122", "413122032", "story_v_out_413122.awb")

						arg_131_1:RecordAudio("413122032", var_134_12)
						arg_131_1:RecordAudio("413122032", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413122", "413122032", "story_v_out_413122.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413122", "413122032", "story_v_out_413122.awb")
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
				actorName = "10022",
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
	Play413122033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413122033
		arg_135_1.duration_ = 11.23

		local var_135_0 = {
			zh = 7.2,
			ja = 11.233
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
				arg_135_0:Play413122034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10092_1 = arg_135_1.actors_["10092_1"].transform.localPosition
				arg_135_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10092_1"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10092_1"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_1_1" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_138_2 = arg_135_1.actors_["10092_1"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10092_1 == nil then
				arg_135_1.var_.actorSpriteComps10092_1 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10092_1 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10092_1 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_138_5 = arg_135_1.actors_["10022"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 1.05

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(413122033)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 42 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 42)

				if (42 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 42)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122033", "story_v_out_413122.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122033", "story_v_out_413122.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_413122", "413122033", "story_v_out_413122.awb")

						arg_135_1:RecordAudio("413122033", var_138_15)
						arg_135_1:RecordAudio("413122033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413122", "413122033", "story_v_out_413122.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413122", "413122033", "story_v_out_413122.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play413122034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413122034
		arg_139_1.duration_ = 3.83

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 3.833
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
				arg_139_0:Play413122035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10093 = arg_139_1.actors_["10093"].transform.localPosition
				arg_139_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10093", 4)

				for iter_142_0 = 0, arg_139_1.actors_["10093"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10093"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_6" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_142_2 = arg_139_1.actors_["10022"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10022 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10022", 7)

				for iter_142_1 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_1)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_5 = arg_139_1.actors_["10093"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10093 == nil then
				arg_139_1.var_.actorSpriteComps10093 = var_142_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_6 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.actorSpriteComps10093 then
					for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_142_3 then
							if arg_139_1.isInRecall_ then
								iter_142_3.color = Color.New(Mathf.Lerp(iter_142_3.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_6), Mathf.Lerp(iter_142_3.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_6), (Mathf.Lerp(iter_142_3.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_6)))
							else
								local var_142_7 = Mathf.Lerp(iter_142_3.color.r, 1, (arg_139_1.time_ - 0) / var_142_6)

								iter_142_3.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10093 then
				for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_142_5 then
						iter_142_5.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10093 = nil
			end

			local var_142_8 = arg_139_1.actors_["10092_1"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10092_1 == nil then
				arg_139_1.var_.actorSpriteComps10092_1 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 and not isNil(var_142_8) then
				if arg_139_1.var_.actorSpriteComps10092_1 then
					for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_142_7 then
							if arg_139_1.isInRecall_ then
								iter_142_7.color = Color.New(Mathf.Lerp(iter_142_7.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_9), Mathf.Lerp(iter_142_7.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_9), (Mathf.Lerp(iter_142_7.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_9)))
							else
								local var_142_10 = Mathf.Lerp(iter_142_7.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_9)

								iter_142_7.color = Color.New(var_142_10, var_142_10, var_142_10)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10092_1 then
				for iter_142_8, iter_142_9 in pairs(arg_139_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_142_9 then
						iter_142_9.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_142_11 = 0
			local var_142_12 = 0.35

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
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

				local var_142_13 = arg_139_1:GetWordFromCfg(413122034)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 14 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 14)

				if (14 <= 0 and var_142_12 or var_142_12 * (utf8.len(var_142_14) / 14)) > 0 and var_142_12 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122034", "story_v_out_413122.awb") ~= 0 then
					local var_142_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122034", "story_v_out_413122.awb") / 1000

					if var_142_17 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_11
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_413122", "413122034", "story_v_out_413122.awb")

						arg_139_1:RecordAudio("413122034", var_142_18)
						arg_139_1:RecordAudio("413122034", var_142_18)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413122", "413122034", "story_v_out_413122.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413122", "413122034", "story_v_out_413122.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_19 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_19

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_19 and arg_139_1.time_ < var_142_11 + var_142_19 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413122035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413122035
		arg_143_1.duration_ = 7.53

		local var_143_0 = {
			zh = 6.2,
			ja = 7.533
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
				arg_143_0:Play413122036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10093 = arg_143_1.actors_["10093"].transform.localPosition
				arg_143_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10093", 4)

				for iter_146_0 = 0, arg_143_1.actors_["10093"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10093"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_4" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
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
								iter_146_2.color = Color.New(Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_2.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_2.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps10093 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10093 = nil
			end

			local var_146_5 = 0
			local var_146_6 = 0.725

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(413122035)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 29 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 29)

				if (29 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 29)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122035", "story_v_out_413122.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122035", "story_v_out_413122.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_413122", "413122035", "story_v_out_413122.awb")

						arg_143_1:RecordAudio("413122035", var_146_12)
						arg_143_1:RecordAudio("413122035", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413122", "413122035", "story_v_out_413122.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413122", "413122035", "story_v_out_413122.awb")
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
				actorName = "10093",
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
	Play413122036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413122036
		arg_147_1.duration_ = 10.7

		local var_147_0 = {
			zh = 5.866,
			ja = 10.7
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
				arg_147_0:Play413122037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10092_1 = arg_147_1.actors_["10092_1"].transform.localPosition
				arg_147_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_150_0 = 0, arg_147_1.actors_["10092_1"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10092_1"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_1_1" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_150_2 = arg_147_1.actors_["10092_1"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10092_1 == nil then
				arg_147_1.var_.actorSpriteComps10092_1 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps10092_1 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10092_1 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_150_5 = arg_147_1.actors_["10093"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10093 == nil then
				arg_147_1.var_.actorSpriteComps10093 = var_150_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.actorSpriteComps10093 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10093 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_150_8 then
						iter_150_8.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10093 = nil
			end

			local var_150_8 = 0
			local var_150_9 = 0.575

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(413122036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 23 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 23)

				if (23 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 23)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122036", "story_v_out_413122.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122036", "story_v_out_413122.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_413122", "413122036", "story_v_out_413122.awb")

						arg_147_1:RecordAudio("413122036", var_150_15)
						arg_147_1:RecordAudio("413122036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413122", "413122036", "story_v_out_413122.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413122", "413122036", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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
	Play413122037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413122037
		arg_151_1.duration_ = 4.27

		local var_151_0 = {
			zh = 2,
			ja = 4.266
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
				arg_151_0:Play413122038(arg_151_1)
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
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10093"]) and arg_151_1.var_.actorSpriteComps10093 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps10093 = nil
			end

			local var_154_2 = arg_151_1.actors_["10092_1"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10092_1 == nil then
				arg_151_1.var_.actorSpriteComps10092_1 = var_154_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_3 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.actorSpriteComps10092_1 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.actorSpriteComps10092_1 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_154_7 then
						iter_154_7.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_154_5 = 0
			local var_154_6 = 0.15

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(413122037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 6 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 6)

				if (6 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 6)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122037", "story_v_out_413122.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122037", "story_v_out_413122.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_413122", "413122037", "story_v_out_413122.awb")

						arg_151_1:RecordAudio("413122037", var_154_12)
						arg_151_1:RecordAudio("413122037", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413122", "413122037", "story_v_out_413122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413122", "413122037", "story_v_out_413122.awb")
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
	Play413122038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413122038
		arg_155_1.duration_ = 12.07

		local var_155_0 = {
			zh = 5.533,
			ja = 12.066
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
				arg_155_0:Play413122039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10092_1 = arg_155_1.actors_["10092_1"].transform.localPosition
				arg_155_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_158_0 = 0, arg_155_1.actors_["10092_1"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10092_1"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_2" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_158_2 = arg_155_1.actors_["10092_1"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10092_1 == nil then
				arg_155_1.var_.actorSpriteComps10092_1 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10092_1 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10092_1 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_158_5 = arg_155_1.actors_["10093"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10093 == nil then
				arg_155_1.var_.actorSpriteComps10093 = var_158_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_6 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_6 and not isNil(var_158_5) then
				if arg_155_1.var_.actorSpriteComps10093 then
					for iter_158_5, iter_158_6 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_158_6 then
							if arg_155_1.isInRecall_ then
								iter_158_6.color = Color.New(Mathf.Lerp(iter_158_6.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_6), Mathf.Lerp(iter_158_6.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_6), (Mathf.Lerp(iter_158_6.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_6)))
							else
								local var_158_7 = Mathf.Lerp(iter_158_6.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_6)

								iter_158_6.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_6 and arg_155_1.time_ < 0 + var_158_6 + arg_158_0 and not isNil(var_158_5) and arg_155_1.var_.actorSpriteComps10093 then
				for iter_158_7, iter_158_8 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_158_8 then
						iter_158_8.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10093 = nil
			end

			local var_158_8 = 0
			local var_158_9 = 0.625

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
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

				local var_158_10 = arg_155_1:GetWordFromCfg(413122038)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 25 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 25)

				if (25 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 25)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122038", "story_v_out_413122.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122038", "story_v_out_413122.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_413122", "413122038", "story_v_out_413122.awb")

						arg_155_1:RecordAudio("413122038", var_158_15)
						arg_155_1:RecordAudio("413122038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413122", "413122038", "story_v_out_413122.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413122", "413122038", "story_v_out_413122.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play413122039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413122039
		arg_159_1.duration_ = 7.87

		local var_159_0 = {
			zh = 4.566,
			ja = 7.866
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
				arg_159_0:Play413122040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10092_1"]) and arg_159_1.var_.actorSpriteComps10092_1 == nil then
				arg_159_1.var_.actorSpriteComps10092_1 = arg_159_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10092_1"]) then
				if arg_159_1.var_.actorSpriteComps10092_1 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 1, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10092_1"]) and arg_159_1.var_.actorSpriteComps10092_1 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.65

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(413122039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 26 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 26)

				if (26 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 26)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122039", "story_v_out_413122.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122039", "story_v_out_413122.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_413122", "413122039", "story_v_out_413122.awb")

						arg_159_1:RecordAudio("413122039", var_162_9)
						arg_159_1:RecordAudio("413122039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413122", "413122039", "story_v_out_413122.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413122", "413122039", "story_v_out_413122.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play413122040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413122040
		arg_163_1.duration_ = 7.77

		local var_163_0 = {
			zh = 4.333,
			ja = 7.766
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
				arg_163_0:Play413122041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10093 = arg_163_1.actors_["10093"].transform.localPosition
				arg_163_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10093", 4)

				for iter_166_0 = 0, arg_163_1.actors_["10093"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10093"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_6" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_166_2 = arg_163_1.actors_["10092_1"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10092_1 = var_166_2.localPosition
				var_166_2.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_166_1 = 0, var_166_2.childCount - 1 do
					local var_166_3 = var_166_2:GetChild(iter_166_1)

					if var_166_3.name == "" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_2.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_163_1.time_ - 0) / var_166_4)
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_166_5 = arg_163_1.actors_["10093"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10093 == nil then
				arg_163_1.var_.actorSpriteComps10093 = var_166_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.actorSpriteComps10093 then
					for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_166_3 then
							if arg_163_1.isInRecall_ then
								iter_166_3.color = Color.New(Mathf.Lerp(iter_166_3.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_6), Mathf.Lerp(iter_166_3.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_6), (Mathf.Lerp(iter_166_3.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_6)))
							else
								local var_166_7 = Mathf.Lerp(iter_166_3.color.r, 1, (arg_163_1.time_ - 0) / var_166_6)

								iter_166_3.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10093 then
				for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_166_5 then
						iter_166_5.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10093 = nil
			end

			local var_166_8 = arg_163_1.actors_["10092_1"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10092_1 == nil then
				arg_163_1.var_.actorSpriteComps10092_1 = var_166_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_9 and not isNil(var_166_8) then
				if arg_163_1.var_.actorSpriteComps10092_1 then
					for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_166_7 then
							if arg_163_1.isInRecall_ then
								iter_166_7.color = Color.New(Mathf.Lerp(iter_166_7.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_9), Mathf.Lerp(iter_166_7.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_9), (Mathf.Lerp(iter_166_7.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_9)))
							else
								local var_166_10 = Mathf.Lerp(iter_166_7.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_9)

								iter_166_7.color = Color.New(var_166_10, var_166_10, var_166_10)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_9 and arg_163_1.time_ < 0 + var_166_9 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10092_1 then
				for iter_166_8, iter_166_9 in pairs(arg_163_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_166_9 then
						iter_166_9.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_166_11 = 0
			local var_166_12 = 0.5

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(413122040)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_16 = 20 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 20)

				if (20 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 20)) > 0 and var_166_12 < var_166_16 then
					arg_163_1.talkMaxDuration = var_166_16

					if var_166_16 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_11
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122040", "story_v_out_413122.awb") ~= 0 then
					local var_166_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122040", "story_v_out_413122.awb") / 1000

					if var_166_17 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_11
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_413122", "413122040", "story_v_out_413122.awb")

						arg_163_1:RecordAudio("413122040", var_166_18)
						arg_163_1:RecordAudio("413122040", var_166_18)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413122", "413122040", "story_v_out_413122.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413122", "413122040", "story_v_out_413122.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_19 = math.max(var_166_12, arg_163_1.talkMaxDuration)

			if var_166_11 <= arg_163_1.time_ and arg_163_1.time_ < var_166_11 + var_166_19 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_11) / var_166_19

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_11 + var_166_19 and arg_163_1.time_ < var_166_11 + var_166_19 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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
				actorName = "10092_1",
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
	Play413122041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413122041
		arg_167_1.duration_ = 5

		local var_167_0 = {
			zh = 3.2,
			ja = 5
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
				arg_167_0:Play413122042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092_1 = arg_167_1.actors_["10092_1"].transform.localPosition
				arg_167_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_170_0 = 0, arg_167_1.actors_["10092_1"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10092_1"].transform:GetChild(iter_170_0)

					if var_170_0.name == "split_2" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_170_2 = arg_167_1.actors_["10093"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10093 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10093", 4)

				for iter_170_1 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_1)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_170_5 = arg_167_1.actors_["10092_1"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092_1 == nil then
				arg_167_1.var_.actorSpriteComps10092_1 = var_170_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_6 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.actorSpriteComps10092_1 then
					for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_170_3 then
							if arg_167_1.isInRecall_ then
								iter_170_3.color = Color.New(Mathf.Lerp(iter_170_3.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_6), Mathf.Lerp(iter_170_3.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_6), (Mathf.Lerp(iter_170_3.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_6)))
							else
								local var_170_7 = Mathf.Lerp(iter_170_3.color.r, 1, (arg_167_1.time_ - 0) / var_170_6)

								iter_170_3.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092_1 then
				for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_170_5 then
						iter_170_5.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_170_8 = arg_167_1.actors_["10093"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 and not isNil(var_170_8) then
				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_7 then
							if arg_167_1.isInRecall_ then
								iter_170_7.color = Color.New(Mathf.Lerp(iter_170_7.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_9), Mathf.Lerp(iter_170_7.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_9), (Mathf.Lerp(iter_170_7.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_9)))
							else
								local var_170_10 = Mathf.Lerp(iter_170_7.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_9)

								iter_170_7.color = Color.New(var_170_10, var_170_10, var_170_10)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_8, iter_170_9 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_9 then
						iter_170_9.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_11 = 0
			local var_170_12 = 0.3

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_13 = arg_167_1:GetWordFromCfg(413122041)
				local var_170_14 = arg_167_1:FormatText(var_170_13.content)

				arg_167_1.text_.text = var_170_14

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 12 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 12)

				if (12 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 12)) > 0 and var_170_12 < var_170_16 then
					arg_167_1.talkMaxDuration = var_170_16

					if var_170_16 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_14
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122041", "story_v_out_413122.awb") ~= 0 then
					local var_170_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122041", "story_v_out_413122.awb") / 1000

					if var_170_17 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_11
					end

					if var_170_13.prefab_name ~= "" and arg_167_1.actors_[var_170_13.prefab_name] ~= nil then
						local var_170_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_13.prefab_name].transform, "story_v_out_413122", "413122041", "story_v_out_413122.awb")

						arg_167_1:RecordAudio("413122041", var_170_18)
						arg_167_1:RecordAudio("413122041", var_170_18)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413122", "413122041", "story_v_out_413122.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413122", "413122041", "story_v_out_413122.awb")
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
				actorName = "10092_1",
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

		arg_167_1:InitPlayNodeList()
	end,
	Play413122042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413122042
		arg_171_1.duration_ = 11.6

		local var_171_0 = {
			zh = 7.7,
			ja = 11.6
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
				arg_171_0:Play413122043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10092_1"]) and arg_171_1.var_.actorSpriteComps10092_1 == nil then
				arg_171_1.var_.actorSpriteComps10092_1 = arg_171_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10092_1"]) then
				if arg_171_1.var_.actorSpriteComps10092_1 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10092_1"]) and arg_171_1.var_.actorSpriteComps10092_1 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_174_2 = 0
			local var_174_3 = 1

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
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

				local var_174_4 = arg_171_1:GetWordFromCfg(413122042)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 40 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 40)

				if (40 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 40)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122042", "story_v_out_413122.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122042", "story_v_out_413122.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_413122", "413122042", "story_v_out_413122.awb")

						arg_171_1:RecordAudio("413122042", var_174_9)
						arg_171_1:RecordAudio("413122042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413122", "413122042", "story_v_out_413122.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413122", "413122042", "story_v_out_413122.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play413122043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413122043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413122044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10092_1 = arg_175_1.actors_["10092_1"].transform.localPosition
				arg_175_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_178_0 = 0, arg_175_1.actors_["10092_1"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["10092_1"].transform:GetChild(iter_178_0)

					if var_178_0.name == "" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["10092_1"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_178_2 = arg_175_1.actors_["10093"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10093 = var_178_2.localPosition
				var_178_2.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10093", 6)

				for iter_178_1 = 0, var_178_2.childCount - 1 do
					local var_178_3 = var_178_2:GetChild(iter_178_1)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				var_178_2.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_175_1.time_ - 0) / var_178_4)
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				var_178_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_178_5 = arg_175_1.actors_["10092_1"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10092_1 == nil then
				arg_175_1.var_.actorSpriteComps10092_1 = var_178_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_6 = 2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.actorSpriteComps10092_1 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_178_3 then
							if arg_175_1.isInRecall_ then
								iter_178_3.color = Color.New(Mathf.Lerp(iter_178_3.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_6), Mathf.Lerp(iter_178_3.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_6), (Mathf.Lerp(iter_178_3.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_6)))
							else
								local var_178_7 = Mathf.Lerp(iter_178_3.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_6)

								iter_178_3.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.actorSpriteComps10092_1 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_178_5 then
						iter_178_5.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_178_8 = arg_175_1.actors_["10093"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps10093 == nil then
				arg_175_1.var_.actorSpriteComps10093 = var_178_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 and not isNil(var_178_8) then
				if arg_175_1.var_.actorSpriteComps10093 then
					for iter_178_6, iter_178_7 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_178_7 then
							if arg_175_1.isInRecall_ then
								iter_178_7.color = Color.New(Mathf.Lerp(iter_178_7.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_9), Mathf.Lerp(iter_178_7.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_9), (Mathf.Lerp(iter_178_7.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_9)))
							else
								local var_178_10 = Mathf.Lerp(iter_178_7.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_9)

								iter_178_7.color = Color.New(var_178_10, var_178_10, var_178_10)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.actorSpriteComps10093 then
				for iter_178_8, iter_178_9 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_178_9 then
						iter_178_9.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps10093 = nil
			end

			local var_178_11 = 0
			local var_178_12 = 1.025

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_13 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(413122043).content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 41 <= 0 and var_178_12 or var_178_12 * (utf8.len(var_178_13) / 41)

				if (41 <= 0 and var_178_12 or var_178_12 * (utf8.len(var_178_13) / 41)) > 0 and var_178_12 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_11 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_11
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_12, arg_175_1.talkMaxDuration)

			if var_178_11 <= arg_175_1.time_ and arg_175_1.time_ < var_178_11 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_11) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_11 + var_178_16 and arg_175_1.time_ < var_178_11 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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

		arg_175_1:InitPlayNodeList()
	end,
	Play413122044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413122044
		arg_179_1.duration_ = 6.6

		local var_179_0 = {
			zh = 6.6,
			ja = 5.9
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
				arg_179_0:Play413122045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10022 = arg_179_1.actors_["10022"].transform.localPosition
				arg_179_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10022", 3)

				for iter_182_0 = 0, arg_179_1.actors_["10022"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10022"].transform:GetChild(iter_182_0)

					if var_182_0.name == "split_6" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_179_1.time_ - 0) / var_182_1)
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_182_2 = arg_179_1.actors_["10022"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10022 == nil then
				arg_179_1.var_.actorSpriteComps10022 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps10022 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								iter_182_2.color = Color.New(Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_2.color.r, 1, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_2.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps10022 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_182_4 then
						iter_182_4.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10022 = nil
			end

			local var_182_5 = 0
			local var_182_6 = 0.65

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(413122044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 26 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 26)

				if (26 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 26)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122044", "story_v_out_413122.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122044", "story_v_out_413122.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_413122", "413122044", "story_v_out_413122.awb")

						arg_179_1:RecordAudio("413122044", var_182_12)
						arg_179_1:RecordAudio("413122044", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_413122", "413122044", "story_v_out_413122.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_413122", "413122044", "story_v_out_413122.awb")
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

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play413122045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413122045
		arg_183_1.duration_ = 4.77

		local var_183_0 = {
			zh = 3.866,
			ja = 4.766
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
				arg_183_0:Play413122046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10022 = arg_183_1.actors_["10022"].transform.localPosition
				arg_183_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10022", 2)

				for iter_186_0 = 0, arg_183_1.actors_["10022"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["10022"].transform:GetChild(iter_186_0)

					if var_186_0.name == "" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_186_2 = "10094"

			if arg_183_1.actors_["10094"] == nil then
				local var_186_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_186_3) then
					local var_186_4 = Object.Instantiate(var_186_3, arg_183_1.canvasGo_.transform)

					var_186_4.transform:SetSiblingIndex(1)

					var_186_4.name = var_186_2
					var_186_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_183_1.actors_[var_186_2] = var_186_4

					if arg_183_1.isInRecall_ then
						for iter_186_1, iter_186_2 in ipairs((var_186_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_186_2.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_186_5 = arg_183_1.actors_["10094"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10094 = var_186_5.localPosition
				var_186_5.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10094", 4)

				for iter_186_3 = 0, var_186_5.childCount - 1 do
					local var_186_6 = var_186_5:GetChild(iter_186_3)

					if var_186_6.name == "split_1" or not string.find(var_186_6.name, "split") then
						var_186_6.gameObject:SetActive(true)
					else
						var_186_6.gameObject:SetActive(false)
					end
				end
			end

			local var_186_7 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				var_186_5.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_183_1.time_ - 0) / var_186_7)
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				var_186_5.localPosition = Vector3.New(390, -340, -414)
			end

			local var_186_8 = arg_183_1.actors_["10022"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps10022 == nil then
				arg_183_1.var_.actorSpriteComps10022 = var_186_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_9 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_9 and not isNil(var_186_8) then
				if arg_183_1.var_.actorSpriteComps10022 then
					for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_186_5 then
							if arg_183_1.isInRecall_ then
								iter_186_5.color = Color.New(Mathf.Lerp(iter_186_5.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_9), Mathf.Lerp(iter_186_5.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_9), (Mathf.Lerp(iter_186_5.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_9)))
							else
								local var_186_10 = Mathf.Lerp(iter_186_5.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_9)

								iter_186_5.color = Color.New(var_186_10, var_186_10, var_186_10)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_9 and arg_183_1.time_ < 0 + var_186_9 + arg_186_0 and not isNil(var_186_8) and arg_183_1.var_.actorSpriteComps10022 then
				for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_186_7 then
						iter_186_7.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10022 = nil
			end

			local var_186_11 = arg_183_1.actors_["10094"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.actorSpriteComps10094 == nil then
				arg_183_1.var_.actorSpriteComps10094 = var_186_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_12 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_12 and not isNil(var_186_11) then
				if arg_183_1.var_.actorSpriteComps10094 then
					for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_186_9 then
							if arg_183_1.isInRecall_ then
								iter_186_9.color = Color.New(Mathf.Lerp(iter_186_9.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_12), Mathf.Lerp(iter_186_9.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_12), (Mathf.Lerp(iter_186_9.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_12)))
							else
								local var_186_13 = Mathf.Lerp(iter_186_9.color.r, 1, (arg_183_1.time_ - 0) / var_186_12)

								iter_186_9.color = Color.New(var_186_13, var_186_13, var_186_13)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_12 and arg_183_1.time_ < 0 + var_186_12 + arg_186_0 and not isNil(var_186_11) and arg_183_1.var_.actorSpriteComps10094 then
				for iter_186_10, iter_186_11 in pairs(arg_183_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_186_11 then
						iter_186_11.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10094 = nil
			end

			local var_186_14 = 0
			local var_186_15 = 0.5

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_16 = arg_183_1:GetWordFromCfg(413122045)
				local var_186_17 = arg_183_1:FormatText(var_186_16.content)

				arg_183_1.text_.text = var_186_17

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 20 <= 0 and var_186_15 or var_186_15 * (utf8.len(var_186_17) / 20)

				if (20 <= 0 and var_186_15 or var_186_15 * (utf8.len(var_186_17) / 20)) > 0 and var_186_15 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19

					if var_186_19 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_14
					end
				end

				arg_183_1.text_.text = var_186_17
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122045", "story_v_out_413122.awb") ~= 0 then
					local var_186_20 = manager.audio:GetVoiceLength("story_v_out_413122", "413122045", "story_v_out_413122.awb") / 1000

					if var_186_20 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_14
					end

					if var_186_16.prefab_name ~= "" and arg_183_1.actors_[var_186_16.prefab_name] ~= nil then
						local var_186_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_16.prefab_name].transform, "story_v_out_413122", "413122045", "story_v_out_413122.awb")

						arg_183_1:RecordAudio("413122045", var_186_21)
						arg_183_1:RecordAudio("413122045", var_186_21)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_413122", "413122045", "story_v_out_413122.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_413122", "413122045", "story_v_out_413122.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_15, arg_183_1.talkMaxDuration)

			if var_186_14 <= arg_183_1.time_ and arg_183_1.time_ < var_186_14 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_14) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_14 + var_186_22 and arg_183_1.time_ < var_186_14 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_183_1:InitPlayNodeList()
	end,
	Play413122046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413122046
		arg_187_1.duration_ = 2

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413122047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10022 = arg_187_1.actors_["10022"].transform.localPosition
				arg_187_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10022", 2)

				for iter_190_0 = 0, arg_187_1.actors_["10022"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["10022"].transform:GetChild(iter_190_0)

					if var_190_0.name == "split_8" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_190_2 = arg_187_1.actors_["10094"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10094 = var_190_2.localPosition
				var_190_2.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10094", 4)

				for iter_190_1 = 0, var_190_2.childCount - 1 do
					local var_190_3 = var_190_2:GetChild(iter_190_1)

					if var_190_3.name == "split_1" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_2.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_187_1.time_ - 0) / var_190_4)
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_190_5 = arg_187_1.actors_["10022"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps10022 == nil then
				arg_187_1.var_.actorSpriteComps10022 = var_190_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_6 = 2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.actorSpriteComps10022 then
					for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_190_3 then
							if arg_187_1.isInRecall_ then
								iter_190_3.color = Color.New(Mathf.Lerp(iter_190_3.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_6), Mathf.Lerp(iter_190_3.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_6), (Mathf.Lerp(iter_190_3.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_6)))
							else
								local var_190_7 = Mathf.Lerp(iter_190_3.color.r, 1, (arg_187_1.time_ - 0) / var_190_6)

								iter_190_3.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps10022 then
				for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_190_5 then
						iter_190_5.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps10022 = nil
			end

			local var_190_8 = arg_187_1.actors_["10094"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10094 == nil then
				arg_187_1.var_.actorSpriteComps10094 = var_190_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_9 and not isNil(var_190_8) then
				if arg_187_1.var_.actorSpriteComps10094 then
					for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_190_7 then
							if arg_187_1.isInRecall_ then
								iter_190_7.color = Color.New(Mathf.Lerp(iter_190_7.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_9), Mathf.Lerp(iter_190_7.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_9), (Mathf.Lerp(iter_190_7.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_9)))
							else
								local var_190_10 = Mathf.Lerp(iter_190_7.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_9)

								iter_190_7.color = Color.New(var_190_10, var_190_10, var_190_10)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_9 and arg_187_1.time_ < 0 + var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.actorSpriteComps10094 then
				for iter_190_8, iter_190_9 in pairs(arg_187_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_190_9 then
						iter_190_9.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10094 = nil
			end

			local var_190_11 = 0
			local var_190_12 = 0.075

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(413122046)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_16 = 3 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 3)

				if (3 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 3)) > 0 and var_190_12 < var_190_16 then
					arg_187_1.talkMaxDuration = var_190_16

					if var_190_16 + var_190_11 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_16 + var_190_11
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122046", "story_v_out_413122.awb") ~= 0 then
					local var_190_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122046", "story_v_out_413122.awb") / 1000

					if var_190_17 + var_190_11 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_11
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_413122", "413122046", "story_v_out_413122.awb")

						arg_187_1:RecordAudio("413122046", var_190_18)
						arg_187_1:RecordAudio("413122046", var_190_18)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413122", "413122046", "story_v_out_413122.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413122", "413122046", "story_v_out_413122.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_19 = math.max(var_190_12, arg_187_1.talkMaxDuration)

			if var_190_11 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_19 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_11) / var_190_19

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_11 + var_190_19 and arg_187_1.time_ < var_190_11 + var_190_19 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_187_1:InitPlayNodeList()
	end,
	Play413122047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413122047
		arg_191_1.duration_ = 11.8

		local var_191_0 = {
			zh = 7.733,
			ja = 11.8
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
				arg_191_0:Play413122048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10022"]) and arg_191_1.var_.actorSpriteComps10022 == nil then
				arg_191_1.var_.actorSpriteComps10022 = arg_191_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10022"]) then
				if arg_191_1.var_.actorSpriteComps10022 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10022"]) and arg_191_1.var_.actorSpriteComps10022 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10022 = nil
			end

			local var_194_2 = arg_191_1.actors_["10094"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10094 == nil then
				arg_191_1.var_.actorSpriteComps10094 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps10094 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								iter_194_5.color = Color.New(Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_5.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_5.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps10094 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_194_7 then
						iter_194_7.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10094 = nil
			end

			local var_194_5 = 0
			local var_194_6 = 0.825

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(413122047)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 33 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 33)

				if (33 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 33)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122047", "story_v_out_413122.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122047", "story_v_out_413122.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_413122", "413122047", "story_v_out_413122.awb")

						arg_191_1:RecordAudio("413122047", var_194_12)
						arg_191_1:RecordAudio("413122047", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_413122", "413122047", "story_v_out_413122.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_413122", "413122047", "story_v_out_413122.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play413122048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413122048
		arg_195_1.duration_ = 9.23

		local var_195_0 = {
			zh = 5.7,
			ja = 9.233
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
				arg_195_0:Play413122049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10022"]) and arg_195_1.var_.actorSpriteComps10022 == nil then
				arg_195_1.var_.actorSpriteComps10022 = arg_195_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10022"]) then
				if arg_195_1.var_.actorSpriteComps10022 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10022"]) and arg_195_1.var_.actorSpriteComps10022 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps10022 = nil
			end

			local var_198_2 = arg_195_1.actors_["10094"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10094 == nil then
				arg_195_1.var_.actorSpriteComps10094 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps10094 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								iter_198_5.color = Color.New(Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_5.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_5.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps10094 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps10094 = nil
			end

			local var_198_5 = 0
			local var_198_6 = 0.75

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_7 = arg_195_1:GetWordFromCfg(413122048)
				local var_198_8 = arg_195_1:FormatText(var_198_7.content)

				arg_195_1.text_.text = var_198_8

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 30 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 30)

				if (30 <= 0 and var_198_6 or var_198_6 * (utf8.len(var_198_8) / 30)) > 0 and var_198_6 < var_198_10 then
					arg_195_1.talkMaxDuration = var_198_10

					if var_198_10 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_5
					end
				end

				arg_195_1.text_.text = var_198_8
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122048", "story_v_out_413122.awb") ~= 0 then
					local var_198_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122048", "story_v_out_413122.awb") / 1000

					if var_198_11 + var_198_5 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_5
					end

					if var_198_7.prefab_name ~= "" and arg_195_1.actors_[var_198_7.prefab_name] ~= nil then
						local var_198_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_7.prefab_name].transform, "story_v_out_413122", "413122048", "story_v_out_413122.awb")

						arg_195_1:RecordAudio("413122048", var_198_12)
						arg_195_1:RecordAudio("413122048", var_198_12)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413122", "413122048", "story_v_out_413122.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413122", "413122048", "story_v_out_413122.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_6, arg_195_1.talkMaxDuration)

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_5) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_5 + var_198_13 and arg_195_1.time_ < var_198_5 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play413122049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413122049
		arg_199_1.duration_ = 7.5

		local var_199_0 = {
			zh = 6.1,
			ja = 7.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play413122050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10022"]) and arg_199_1.var_.actorSpriteComps10022 == nil then
				arg_199_1.var_.actorSpriteComps10022 = arg_199_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10022"]) then
				if arg_199_1.var_.actorSpriteComps10022 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10022"]) and arg_199_1.var_.actorSpriteComps10022 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10022 = nil
			end

			local var_202_2 = arg_199_1.actors_["10094"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10094 == nil then
				arg_199_1.var_.actorSpriteComps10094 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10094 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								iter_202_5.color = Color.New(Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_5.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_5.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10094 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_202_7 then
						iter_202_7.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10094 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(413122049)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 27 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 27)

				if (27 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 27)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122049", "story_v_out_413122.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122049", "story_v_out_413122.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_413122", "413122049", "story_v_out_413122.awb")

						arg_199_1:RecordAudio("413122049", var_202_12)
						arg_199_1:RecordAudio("413122049", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413122", "413122049", "story_v_out_413122.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413122", "413122049", "story_v_out_413122.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_13 and arg_199_1.time_ < var_202_5 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play413122050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413122050
		arg_203_1.duration_ = 5.93

		local var_203_0 = {
			zh = 4.833,
			ja = 5.933
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
				arg_203_0:Play413122051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10022"]) and arg_203_1.var_.actorSpriteComps10022 == nil then
				arg_203_1.var_.actorSpriteComps10022 = arg_203_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10022"]) then
				if arg_203_1.var_.actorSpriteComps10022 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 1, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10022"]) and arg_203_1.var_.actorSpriteComps10022 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps10022 = nil
			end

			local var_206_2 = arg_203_1.actors_["10094"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps10094 == nil then
				arg_203_1.var_.actorSpriteComps10094 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps10094 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_206_5 then
							if arg_203_1.isInRecall_ then
								iter_206_5.color = Color.New(Mathf.Lerp(iter_206_5.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_5.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_5.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_5.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_5.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps10094 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_206_7 then
						iter_206_7.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps10094 = nil
			end

			local var_206_5 = 0
			local var_206_6 = 0.675

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(413122050)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 27 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 27)

				if (27 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 27)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122050", "story_v_out_413122.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122050", "story_v_out_413122.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_413122", "413122050", "story_v_out_413122.awb")

						arg_203_1:RecordAudio("413122050", var_206_12)
						arg_203_1:RecordAudio("413122050", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_413122", "413122050", "story_v_out_413122.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_413122", "413122050", "story_v_out_413122.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play413122051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 413122051
		arg_207_1.duration_ = 11.63

		local var_207_0 = {
			zh = 9.066,
			ja = 11.633
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play413122052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10022"]) and arg_207_1.var_.actorSpriteComps10022 == nil then
				arg_207_1.var_.actorSpriteComps10022 = arg_207_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10022"]) then
				if arg_207_1.var_.actorSpriteComps10022 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10022"]) and arg_207_1.var_.actorSpriteComps10022 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps10022 = nil
			end

			local var_210_2 = arg_207_1.actors_["10094"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10094 == nil then
				arg_207_1.var_.actorSpriteComps10094 = var_210_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_3 = 2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.actorSpriteComps10094 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_210_5 then
							if arg_207_1.isInRecall_ then
								iter_210_5.color = Color.New(Mathf.Lerp(iter_210_5.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_3), Mathf.Lerp(iter_210_5.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_3), (Mathf.Lerp(iter_210_5.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_3)))
							else
								local var_210_4 = Mathf.Lerp(iter_210_5.color.r, 1, (arg_207_1.time_ - 0) / var_210_3)

								iter_210_5.color = Color.New(var_210_4, var_210_4, var_210_4)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.actorSpriteComps10094 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_210_7 then
						iter_210_7.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps10094 = nil
			end

			local var_210_5 = 0
			local var_210_6 = 1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(413122051)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 40 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 40)

				if (40 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 40)) > 0 and var_210_6 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122051", "story_v_out_413122.awb") ~= 0 then
					local var_210_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122051", "story_v_out_413122.awb") / 1000

					if var_210_11 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_5
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_413122", "413122051", "story_v_out_413122.awb")

						arg_207_1:RecordAudio("413122051", var_210_12)
						arg_207_1:RecordAudio("413122051", var_210_12)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_413122", "413122051", "story_v_out_413122.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_413122", "413122051", "story_v_out_413122.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_13 and arg_207_1.time_ < var_210_5 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play413122052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413122052
		arg_211_1.duration_ = 6.07

		local var_211_0 = {
			zh = 5.833,
			ja = 6.066
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play413122053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10022"]) and arg_211_1.var_.actorSpriteComps10022 == nil then
				arg_211_1.var_.actorSpriteComps10022 = arg_211_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10022"]) then
				if arg_211_1.var_.actorSpriteComps10022 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 1, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10022"]) and arg_211_1.var_.actorSpriteComps10022 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps10022 = nil
			end

			local var_214_2 = arg_211_1.actors_["10094"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps10094 == nil then
				arg_211_1.var_.actorSpriteComps10094 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps10094 then
					for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_214_5 then
							if arg_211_1.isInRecall_ then
								iter_214_5.color = Color.New(Mathf.Lerp(iter_214_5.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_5.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_5.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_5.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_5.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps10094 then
				for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_214_7 then
						iter_214_7.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10094 = nil
			end

			local var_214_5 = 0
			local var_214_6 = 0.625

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(413122052)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 25 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 25)

				if (25 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 25)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122052", "story_v_out_413122.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122052", "story_v_out_413122.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_413122", "413122052", "story_v_out_413122.awb")

						arg_211_1:RecordAudio("413122052", var_214_12)
						arg_211_1:RecordAudio("413122052", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_413122", "413122052", "story_v_out_413122.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_413122", "413122052", "story_v_out_413122.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play413122053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413122053
		arg_215_1.duration_ = 5.47

		local var_215_0 = {
			zh = 3.7,
			ja = 5.466
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413122054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10022"]) and arg_215_1.var_.actorSpriteComps10022 == nil then
				arg_215_1.var_.actorSpriteComps10022 = arg_215_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10022"]) then
				if arg_215_1.var_.actorSpriteComps10022 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10022"]) and arg_215_1.var_.actorSpriteComps10022 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps10022 = nil
			end

			local var_218_2 = arg_215_1.actors_["10094"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10094 == nil then
				arg_215_1.var_.actorSpriteComps10094 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps10094 then
					for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_218_5 then
							if arg_215_1.isInRecall_ then
								iter_218_5.color = Color.New(Mathf.Lerp(iter_218_5.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_5.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_5.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_5.color.r, 1, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_5.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10094 then
				for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_218_7 then
						iter_218_7.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps10094 = nil
			end

			local var_218_5 = 0
			local var_218_6 = 0.4

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:GetWordFromCfg(413122053)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 16 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 16)

				if (16 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 16)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122053", "story_v_out_413122.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122053", "story_v_out_413122.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_413122", "413122053", "story_v_out_413122.awb")

						arg_215_1:RecordAudio("413122053", var_218_12)
						arg_215_1:RecordAudio("413122053", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413122", "413122053", "story_v_out_413122.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413122", "413122053", "story_v_out_413122.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_13 and arg_215_1.time_ < var_218_5 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play413122054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413122054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413122055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10022 = arg_219_1.actors_["10022"].transform.localPosition
				arg_219_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10022", 7)

				for iter_222_0 = 0, arg_219_1.actors_["10022"].transform.childCount - 1 do
					local var_222_0 = arg_219_1.actors_["10022"].transform:GetChild(iter_222_0)

					if var_222_0.name == "split_4" or not string.find(var_222_0.name, "split") then
						var_222_0.gameObject:SetActive(true)
					else
						var_222_0.gameObject:SetActive(false)
					end
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_219_1.time_ - 0) / var_222_1)
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_2 = arg_219_1.actors_["10094"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10094 = var_222_2.localPosition
				var_222_2.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10094", 7)

				for iter_222_1 = 0, var_222_2.childCount - 1 do
					local var_222_3 = var_222_2:GetChild(iter_222_1)

					if var_222_3.name == "" or not string.find(var_222_3.name, "split") then
						var_222_3.gameObject:SetActive(true)
					else
						var_222_3.gameObject:SetActive(false)
					end
				end
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_2.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_219_1.time_ - 0) / var_222_4)
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_5 = 0
			local var_222_6 = 1.4

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_7 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(413122054).content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 56 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_7) / 56)

				if (56 <= 0 and var_222_6 or var_222_6 * (utf8.len(var_222_7) / 56)) > 0 and var_222_6 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_5
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_6, arg_219_1.talkMaxDuration)

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_5) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_5 + var_222_10 and arg_219_1.time_ < var_222_5 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_219_1:InitPlayNodeList()
	end,
	Play413122055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413122055
		arg_223_1.duration_ = 6.7

		local var_223_0 = {
			zh = 6.7,
			ja = 5.366
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play413122056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10022 = arg_223_1.actors_["10022"].transform.localPosition
				arg_223_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10022", 3)

				for iter_226_0 = 0, arg_223_1.actors_["10022"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["10022"].transform:GetChild(iter_226_0)

					if var_226_0.name == "" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_226_2 = arg_223_1.actors_["10022"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps10022 == nil then
				arg_223_1.var_.actorSpriteComps10022 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps10022 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								iter_226_2.color = Color.New(Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_2.color.r, 1, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_2.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps10022 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_226_4 then
						iter_226_4.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10022 = nil
			end

			local var_226_5 = 0
			local var_226_6 = 0.8

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(413122055)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 32 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 32)

				if (32 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 32)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122055", "story_v_out_413122.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122055", "story_v_out_413122.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_413122", "413122055", "story_v_out_413122.awb")

						arg_223_1:RecordAudio("413122055", var_226_12)
						arg_223_1:RecordAudio("413122055", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413122", "413122055", "story_v_out_413122.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413122", "413122055", "story_v_out_413122.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play413122056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413122056
		arg_227_1.duration_ = 10.67

		local var_227_0 = {
			zh = 6.8,
			ja = 10.666
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play413122057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.875

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(413122056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 35 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 35)

				if (35 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 35)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122056", "story_v_out_413122.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122056", "story_v_out_413122.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_413122", "413122056", "story_v_out_413122.awb")

						arg_227_1:RecordAudio("413122056", var_230_6)
						arg_227_1:RecordAudio("413122056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413122", "413122056", "story_v_out_413122.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413122", "413122056", "story_v_out_413122.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play413122057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413122057
		arg_231_1.duration_ = 8.47

		local var_231_0 = {
			zh = 6.766,
			ja = 8.466
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413122058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10022"]) and arg_231_1.var_.actorSpriteComps10022 == nil then
				arg_231_1.var_.actorSpriteComps10022 = arg_231_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10022"]) then
				if arg_231_1.var_.actorSpriteComps10022 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10022"]) and arg_231_1.var_.actorSpriteComps10022 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10022 = nil
			end

			local var_234_2 = arg_231_1.actors_["10022"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10022 = var_234_2.localPosition
				var_234_2.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10022", 3)

				for iter_234_4 = 0, var_234_2.childCount - 1 do
					local var_234_3 = var_234_2:GetChild(iter_234_4)

					if var_234_3.name == "split_3" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_2.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_231_1.time_ - 0) / var_234_4)
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_234_5 = 0
			local var_234_6 = 0.725

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(413122057)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 29 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 29)

				if (29 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 29)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122057", "story_v_out_413122.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122057", "story_v_out_413122.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_413122", "413122057", "story_v_out_413122.awb")

						arg_231_1:RecordAudio("413122057", var_234_12)
						arg_231_1:RecordAudio("413122057", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_413122", "413122057", "story_v_out_413122.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_413122", "413122057", "story_v_out_413122.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play413122058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413122058
		arg_235_1.duration_ = 9.63

		local var_235_0 = {
			zh = 8.166,
			ja = 9.633
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413122059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10022 = arg_235_1.actors_["10022"].transform.localPosition
				arg_235_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10022", 2)

				for iter_238_0 = 0, arg_235_1.actors_["10022"].transform.childCount - 1 do
					local var_238_0 = arg_235_1.actors_["10022"].transform:GetChild(iter_238_0)

					if var_238_0.name == "split_3" or not string.find(var_238_0.name, "split") then
						var_238_0.gameObject:SetActive(true)
					else
						var_238_0.gameObject:SetActive(false)
					end
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_235_1.time_ - 0) / var_238_1)
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_238_2 = arg_235_1.actors_["10094"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10094 = var_238_2.localPosition
				var_238_2.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10094", 4)

				for iter_238_1 = 0, var_238_2.childCount - 1 do
					local var_238_3 = var_238_2:GetChild(iter_238_1)

					if var_238_3.name == "" or not string.find(var_238_3.name, "split") then
						var_238_3.gameObject:SetActive(true)
					else
						var_238_3.gameObject:SetActive(false)
					end
				end
			end

			local var_238_4 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				var_238_2.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_235_1.time_ - 0) / var_238_4)
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				var_238_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_238_5 = arg_235_1.actors_["10022"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.actorSpriteComps10022 == nil then
				arg_235_1.var_.actorSpriteComps10022 = var_238_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_6 = 2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_6 and not isNil(var_238_5) then
				if arg_235_1.var_.actorSpriteComps10022 then
					for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_238_3 then
							if arg_235_1.isInRecall_ then
								iter_238_3.color = Color.New(Mathf.Lerp(iter_238_3.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_6), Mathf.Lerp(iter_238_3.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_6), (Mathf.Lerp(iter_238_3.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_6)))
							else
								local var_238_7 = Mathf.Lerp(iter_238_3.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_6)

								iter_238_3.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_6 and arg_235_1.time_ < 0 + var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.actorSpriteComps10022 then
				for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_238_5 then
						iter_238_5.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps10022 = nil
			end

			local var_238_8 = arg_235_1.actors_["10094"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10094 == nil then
				arg_235_1.var_.actorSpriteComps10094 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_9 = 2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_9 and not isNil(var_238_8) then
				if arg_235_1.var_.actorSpriteComps10094 then
					for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_238_7 then
							if arg_235_1.isInRecall_ then
								iter_238_7.color = Color.New(Mathf.Lerp(iter_238_7.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_9), Mathf.Lerp(iter_238_7.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_9), (Mathf.Lerp(iter_238_7.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_9)))
							else
								local var_238_10 = Mathf.Lerp(iter_238_7.color.r, 1, (arg_235_1.time_ - 0) / var_238_9)

								iter_238_7.color = Color.New(var_238_10, var_238_10, var_238_10)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_9 and arg_235_1.time_ < 0 + var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10094 then
				for iter_238_8, iter_238_9 in pairs(arg_235_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_238_9 then
						iter_238_9.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10094 = nil
			end

			local var_238_11 = 0
			local var_238_12 = 1.025

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_13 = arg_235_1:GetWordFromCfg(413122058)
				local var_238_14 = arg_235_1:FormatText(var_238_13.content)

				arg_235_1.text_.text = var_238_14

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_16 = 41 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 41)

				if (41 <= 0 and var_238_12 or var_238_12 * (utf8.len(var_238_14) / 41)) > 0 and var_238_12 < var_238_16 then
					arg_235_1.talkMaxDuration = var_238_16

					if var_238_16 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_11
					end
				end

				arg_235_1.text_.text = var_238_14
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122058", "story_v_out_413122.awb") ~= 0 then
					local var_238_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122058", "story_v_out_413122.awb") / 1000

					if var_238_17 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_17 + var_238_11
					end

					if var_238_13.prefab_name ~= "" and arg_235_1.actors_[var_238_13.prefab_name] ~= nil then
						local var_238_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_13.prefab_name].transform, "story_v_out_413122", "413122058", "story_v_out_413122.awb")

						arg_235_1:RecordAudio("413122058", var_238_18)
						arg_235_1:RecordAudio("413122058", var_238_18)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413122", "413122058", "story_v_out_413122.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413122", "413122058", "story_v_out_413122.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_19 = math.max(var_238_12, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_19 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_11) / var_238_19

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_19 and arg_235_1.time_ < var_238_11 + var_238_19 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_235_1:InitPlayNodeList()
	end,
	Play413122059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413122059
		arg_239_1.duration_ = 7.23

		local var_239_0 = {
			zh = 4.166,
			ja = 7.233
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413122060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10022"]) and arg_239_1.var_.actorSpriteComps10022 == nil then
				arg_239_1.var_.actorSpriteComps10022 = arg_239_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10022"]) then
				if arg_239_1.var_.actorSpriteComps10022 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 1, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10022"]) and arg_239_1.var_.actorSpriteComps10022 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps10022 = nil
			end

			local var_242_2 = arg_239_1.actors_["10094"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10094 == nil then
				arg_239_1.var_.actorSpriteComps10094 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10094 then
					for iter_242_4, iter_242_5 in pairs(arg_239_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_242_5 then
							if arg_239_1.isInRecall_ then
								iter_242_5.color = Color.New(Mathf.Lerp(iter_242_5.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_5.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_5.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_5.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_5.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10094 then
				for iter_242_6, iter_242_7 in pairs(arg_239_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_242_7 then
						iter_242_7.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10094 = nil
			end

			local var_242_5 = 0
			local var_242_6 = 0.525

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:GetWordFromCfg(413122059)
				local var_242_8 = arg_239_1:FormatText(var_242_7.content)

				arg_239_1.text_.text = var_242_8

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 21 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 21)

				if (21 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 21)) > 0 and var_242_6 < var_242_10 then
					arg_239_1.talkMaxDuration = var_242_10

					if var_242_10 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_8
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122059", "story_v_out_413122.awb") ~= 0 then
					local var_242_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122059", "story_v_out_413122.awb") / 1000

					if var_242_11 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_5
					end

					if var_242_7.prefab_name ~= "" and arg_239_1.actors_[var_242_7.prefab_name] ~= nil then
						local var_242_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_7.prefab_name].transform, "story_v_out_413122", "413122059", "story_v_out_413122.awb")

						arg_239_1:RecordAudio("413122059", var_242_12)
						arg_239_1:RecordAudio("413122059", var_242_12)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413122", "413122059", "story_v_out_413122.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413122", "413122059", "story_v_out_413122.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_13 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_13 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_13

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_13 and arg_239_1.time_ < var_242_5 + var_242_13 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play413122060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413122060
		arg_243_1.duration_ = 11.67

		local var_243_0 = {
			zh = 7.733,
			ja = 11.666
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play413122061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.975

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(413122060)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 39 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 39)

				if (39 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 39)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122060", "story_v_out_413122.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122060", "story_v_out_413122.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_413122", "413122060", "story_v_out_413122.awb")

						arg_243_1:RecordAudio("413122060", var_246_6)
						arg_243_1:RecordAudio("413122060", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_413122", "413122060", "story_v_out_413122.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_413122", "413122060", "story_v_out_413122.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play413122061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413122061
		arg_247_1.duration_ = 6.03

		local var_247_0 = {
			zh = 6.033,
			ja = 5.9
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play413122062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10022"]) and arg_247_1.var_.actorSpriteComps10022 == nil then
				arg_247_1.var_.actorSpriteComps10022 = arg_247_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10022"]) then
				if arg_247_1.var_.actorSpriteComps10022 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10022"]) and arg_247_1.var_.actorSpriteComps10022 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10022 = nil
			end

			local var_250_2 = 0
			local var_250_3 = 0.675

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(413122061)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 27 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 27)

				if (27 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 27)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122061", "story_v_out_413122.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122061", "story_v_out_413122.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_out_413122", "413122061", "story_v_out_413122.awb")

						arg_247_1:RecordAudio("413122061", var_250_9)
						arg_247_1:RecordAudio("413122061", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413122", "413122061", "story_v_out_413122.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413122", "413122061", "story_v_out_413122.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413122062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413122062
		arg_251_1.duration_ = 10.03

		local var_251_0 = {
			zh = 6.166,
			ja = 10.033
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play413122063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10022"]) and arg_251_1.var_.actorSpriteComps10022 == nil then
				arg_251_1.var_.actorSpriteComps10022 = arg_251_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10022"]) then
				if arg_251_1.var_.actorSpriteComps10022 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10022"]) and arg_251_1.var_.actorSpriteComps10022 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10022 = nil
			end

			local var_254_2 = arg_251_1.actors_["10094"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10094 == nil then
				arg_251_1.var_.actorSpriteComps10094 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps10094 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								iter_254_5.color = Color.New(Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_3), Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_3), (Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_3)))
							else
								local var_254_4 = Mathf.Lerp(iter_254_5.color.r, 1, (arg_251_1.time_ - 0) / var_254_3)

								iter_254_5.color = Color.New(var_254_4, var_254_4, var_254_4)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10094 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_254_7 then
						iter_254_7.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10094 = nil
			end

			local var_254_5 = 0
			local var_254_6 = 0.65

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(413122062)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 26 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 26)

				if (26 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 26)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122062", "story_v_out_413122.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122062", "story_v_out_413122.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_413122", "413122062", "story_v_out_413122.awb")

						arg_251_1:RecordAudio("413122062", var_254_12)
						arg_251_1:RecordAudio("413122062", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413122", "413122062", "story_v_out_413122.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413122", "413122062", "story_v_out_413122.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_13 and arg_251_1.time_ < var_254_5 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play413122063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 413122063
		arg_255_1.duration_ = 13.03

		local var_255_0 = {
			zh = 8.266,
			ja = 13.033
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play413122064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.95

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(413122063)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 38 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 38)

				if (38 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 38)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122063", "story_v_out_413122.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122063", "story_v_out_413122.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_413122", "413122063", "story_v_out_413122.awb")

						arg_255_1:RecordAudio("413122063", var_258_6)
						arg_255_1:RecordAudio("413122063", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_413122", "413122063", "story_v_out_413122.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_413122", "413122063", "story_v_out_413122.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play413122064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 413122064
		arg_259_1.duration_ = 9.03

		local var_259_0 = {
			zh = 4.7,
			ja = 9.033
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play413122065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.55

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(413122064)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 22 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 22)

				if (22 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 22)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122064", "story_v_out_413122.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122064", "story_v_out_413122.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_413122", "413122064", "story_v_out_413122.awb")

						arg_259_1:RecordAudio("413122064", var_262_6)
						arg_259_1:RecordAudio("413122064", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_413122", "413122064", "story_v_out_413122.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_413122", "413122064", "story_v_out_413122.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play413122065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 413122065
		arg_263_1.duration_ = 9.33

		local var_263_0 = {
			zh = 8.666,
			ja = 9.333
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play413122066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10094 = arg_263_1.actors_["10094"].transform.localPosition
				arg_263_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10094", 4)

				for iter_266_0 = 0, arg_263_1.actors_["10094"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["10094"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_266_2 = arg_263_1.actors_["10094"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10094 == nil then
				arg_263_1.var_.actorSpriteComps10094 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps10094 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								iter_266_2.color = Color.New(Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_2.color.r, 1, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_2.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10094 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_266_4 then
						iter_266_4.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps10094 = nil
			end

			local var_266_5 = 0
			local var_266_6 = 0.775

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(413122065)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 31 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 31)

				if (31 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_8) / 31)) > 0 and var_266_6 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122065", "story_v_out_413122.awb") ~= 0 then
					local var_266_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122065", "story_v_out_413122.awb") / 1000

					if var_266_11 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_5
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_413122", "413122065", "story_v_out_413122.awb")

						arg_263_1:RecordAudio("413122065", var_266_12)
						arg_263_1:RecordAudio("413122065", var_266_12)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_413122", "413122065", "story_v_out_413122.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_413122", "413122065", "story_v_out_413122.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_13 and arg_263_1.time_ < var_266_5 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play413122066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413122066
		arg_267_1.duration_ = 7.1

		local var_267_0 = {
			zh = 3.6,
			ja = 7.1
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play413122067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10022"]) and arg_267_1.var_.actorSpriteComps10022 == nil then
				arg_267_1.var_.actorSpriteComps10022 = arg_267_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10022"]) then
				if arg_267_1.var_.actorSpriteComps10022 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10022"]) and arg_267_1.var_.actorSpriteComps10022 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps10022 = nil
			end

			local var_270_2 = arg_267_1.actors_["10094"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps10094 == nil then
				arg_267_1.var_.actorSpriteComps10094 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps10094 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								iter_270_5.color = Color.New(Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_5.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_5.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps10094 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_270_7 then
						iter_270_7.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps10094 = nil
			end

			local var_270_5 = 0
			local var_270_6 = 0.45

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(413122066)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 18 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 18)

				if (18 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 18)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122066", "story_v_out_413122.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122066", "story_v_out_413122.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_413122", "413122066", "story_v_out_413122.awb")

						arg_267_1:RecordAudio("413122066", var_270_12)
						arg_267_1:RecordAudio("413122066", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413122", "413122066", "story_v_out_413122.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413122", "413122066", "story_v_out_413122.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413122067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413122067
		arg_271_1.duration_ = 6

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play413122068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.725

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(413122067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 29 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 29)

				if (29 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 29)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122067", "story_v_out_413122.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122067", "story_v_out_413122.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_413122", "413122067", "story_v_out_413122.awb")

						arg_271_1:RecordAudio("413122067", var_274_6)
						arg_271_1:RecordAudio("413122067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413122", "413122067", "story_v_out_413122.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413122", "413122067", "story_v_out_413122.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play413122068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 413122068
		arg_275_1.duration_ = 15.27

		local var_275_0 = {
			zh = 10.166,
			ja = 15.266
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play413122069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10022 = arg_275_1.actors_["10022"].transform.localPosition
				arg_275_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10022", 2)

				for iter_278_0 = 0, arg_275_1.actors_["10022"].transform.childCount - 1 do
					local var_278_0 = arg_275_1.actors_["10022"].transform:GetChild(iter_278_0)

					if var_278_0.name == "split_3" or not string.find(var_278_0.name, "split") then
						var_278_0.gameObject:SetActive(true)
					else
						var_278_0.gameObject:SetActive(false)
					end
				end
			end

			local var_278_1 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 then
				arg_275_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_275_1.time_ - 0) / var_278_1)
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 then
				arg_275_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_278_2 = arg_275_1.actors_["10022"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10022 == nil then
				arg_275_1.var_.actorSpriteComps10022 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps10022 then
					for iter_278_1, iter_278_2 in pairs(arg_275_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_278_2 then
							if arg_275_1.isInRecall_ then
								iter_278_2.color = Color.New(Mathf.Lerp(iter_278_2.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_3), Mathf.Lerp(iter_278_2.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_3), (Mathf.Lerp(iter_278_2.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_3)))
							else
								local var_278_4 = Mathf.Lerp(iter_278_2.color.r, 1, (arg_275_1.time_ - 0) / var_278_3)

								iter_278_2.color = Color.New(var_278_4, var_278_4, var_278_4)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10022 then
				for iter_278_3, iter_278_4 in pairs(arg_275_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_278_4 then
						iter_278_4.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10022 = nil
			end

			local var_278_5 = 0
			local var_278_6 = 1.225

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(413122068)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 49 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 49)

				if (49 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 49)) > 0 and var_278_6 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122068", "story_v_out_413122.awb") ~= 0 then
					local var_278_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122068", "story_v_out_413122.awb") / 1000

					if var_278_11 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_5
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_413122", "413122068", "story_v_out_413122.awb")

						arg_275_1:RecordAudio("413122068", var_278_12)
						arg_275_1:RecordAudio("413122068", var_278_12)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_413122", "413122068", "story_v_out_413122.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_413122", "413122068", "story_v_out_413122.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_13 and arg_275_1.time_ < var_278_5 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413122069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 413122069
		arg_279_1.duration_ = 7.5

		local var_279_0 = {
			zh = 6.733,
			ja = 7.5
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
				arg_279_0:Play413122070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10094 = arg_279_1.actors_["10094"].transform.localPosition
				arg_279_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10094", 4)

				for iter_282_0 = 0, arg_279_1.actors_["10094"].transform.childCount - 1 do
					local var_282_0 = arg_279_1.actors_["10094"].transform:GetChild(iter_282_0)

					if var_282_0.name == "" or not string.find(var_282_0.name, "split") then
						var_282_0.gameObject:SetActive(true)
					else
						var_282_0.gameObject:SetActive(false)
					end
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_279_1.time_ - 0) / var_282_1)
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_282_2 = arg_279_1.actors_["10022"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10022 == nil then
				arg_279_1.var_.actorSpriteComps10022 = var_282_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_3 = 2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.actorSpriteComps10022 then
					for iter_282_1, iter_282_2 in pairs(arg_279_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_282_2 then
							if arg_279_1.isInRecall_ then
								iter_282_2.color = Color.New(Mathf.Lerp(iter_282_2.color.r, arg_279_1.hightColor2.r, (arg_279_1.time_ - 0) / var_282_3), Mathf.Lerp(iter_282_2.color.g, arg_279_1.hightColor2.g, (arg_279_1.time_ - 0) / var_282_3), (Mathf.Lerp(iter_282_2.color.b, arg_279_1.hightColor2.b, (arg_279_1.time_ - 0) / var_282_3)))
							else
								local var_282_4 = Mathf.Lerp(iter_282_2.color.r, 0.5, (arg_279_1.time_ - 0) / var_282_3)

								iter_282_2.color = Color.New(var_282_4, var_282_4, var_282_4)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10022 then
				for iter_282_3, iter_282_4 in pairs(arg_279_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_282_4 then
						iter_282_4.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10022 = nil
			end

			local var_282_5 = arg_279_1.actors_["10094"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.actorSpriteComps10094 == nil then
				arg_279_1.var_.actorSpriteComps10094 = var_282_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_6 = 2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_6 and not isNil(var_282_5) then
				if arg_279_1.var_.actorSpriteComps10094 then
					for iter_282_5, iter_282_6 in pairs(arg_279_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_282_6 then
							if arg_279_1.isInRecall_ then
								iter_282_6.color = Color.New(Mathf.Lerp(iter_282_6.color.r, arg_279_1.hightColor1.r, (arg_279_1.time_ - 0) / var_282_6), Mathf.Lerp(iter_282_6.color.g, arg_279_1.hightColor1.g, (arg_279_1.time_ - 0) / var_282_6), (Mathf.Lerp(iter_282_6.color.b, arg_279_1.hightColor1.b, (arg_279_1.time_ - 0) / var_282_6)))
							else
								local var_282_7 = Mathf.Lerp(iter_282_6.color.r, 1, (arg_279_1.time_ - 0) / var_282_6)

								iter_282_6.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_6 and arg_279_1.time_ < 0 + var_282_6 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.actorSpriteComps10094 then
				for iter_282_7, iter_282_8 in pairs(arg_279_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_282_8 then
						iter_282_8.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10094 = nil
			end

			local var_282_8 = 0
			local var_282_9 = 0.7

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:GetWordFromCfg(413122069)
				local var_282_11 = arg_279_1:FormatText(var_282_10.content)

				arg_279_1.text_.text = var_282_11

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_13 = 28 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 28)

				if (28 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_11) / 28)) > 0 and var_282_9 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_11
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122069", "story_v_out_413122.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122069", "story_v_out_413122.awb") / 1000

					if var_282_14 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_8
					end

					if var_282_10.prefab_name ~= "" and arg_279_1.actors_[var_282_10.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_10.prefab_name].transform, "story_v_out_413122", "413122069", "story_v_out_413122.awb")

						arg_279_1:RecordAudio("413122069", var_282_15)
						arg_279_1:RecordAudio("413122069", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_413122", "413122069", "story_v_out_413122.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_413122", "413122069", "story_v_out_413122.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_16 and arg_279_1.time_ < var_282_8 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play413122070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 413122070
		arg_283_1.duration_ = 12.7

		local var_283_0 = {
			zh = 8.466,
			ja = 12.7
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play413122071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10022"]) and arg_283_1.var_.actorSpriteComps10022 == nil then
				arg_283_1.var_.actorSpriteComps10022 = arg_283_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10022"]) then
				if arg_283_1.var_.actorSpriteComps10022 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10022"]) and arg_283_1.var_.actorSpriteComps10022 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps10022 = nil
			end

			local var_286_2 = arg_283_1.actors_["10094"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps10094 == nil then
				arg_283_1.var_.actorSpriteComps10094 = var_286_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_3 = 2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.actorSpriteComps10094 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_286_5 then
							if arg_283_1.isInRecall_ then
								iter_286_5.color = Color.New(Mathf.Lerp(iter_286_5.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_3), Mathf.Lerp(iter_286_5.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_3), (Mathf.Lerp(iter_286_5.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_3)))
							else
								local var_286_4 = Mathf.Lerp(iter_286_5.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_3)

								iter_286_5.color = Color.New(var_286_4, var_286_4, var_286_4)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps10094 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_286_7 then
						iter_286_7.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps10094 = nil
			end

			local var_286_5 = 0
			local var_286_6 = 1

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_7 = arg_283_1:GetWordFromCfg(413122070)
				local var_286_8 = arg_283_1:FormatText(var_286_7.content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 40 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 40)

				if (40 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 40)) > 0 and var_286_6 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122070", "story_v_out_413122.awb") ~= 0 then
					local var_286_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122070", "story_v_out_413122.awb") / 1000

					if var_286_11 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_5
					end

					if var_286_7.prefab_name ~= "" and arg_283_1.actors_[var_286_7.prefab_name] ~= nil then
						local var_286_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_7.prefab_name].transform, "story_v_out_413122", "413122070", "story_v_out_413122.awb")

						arg_283_1:RecordAudio("413122070", var_286_12)
						arg_283_1:RecordAudio("413122070", var_286_12)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_413122", "413122070", "story_v_out_413122.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_413122", "413122070", "story_v_out_413122.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_13 and arg_283_1.time_ < var_286_5 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play413122071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413122071
		arg_287_1.duration_ = 10.47

		local var_287_0 = {
			zh = 10.466,
			ja = 9.866
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
				arg_287_0:Play413122072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.1

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(413122071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 44 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 44)

				if (44 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 44)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122071", "story_v_out_413122.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122071", "story_v_out_413122.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_413122", "413122071", "story_v_out_413122.awb")

						arg_287_1:RecordAudio("413122071", var_290_6)
						arg_287_1:RecordAudio("413122071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_413122", "413122071", "story_v_out_413122.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_413122", "413122071", "story_v_out_413122.awb")
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
	Play413122072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413122072
		arg_291_1.duration_ = 12.2

		local var_291_0 = {
			zh = 7.633,
			ja = 12.2
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
				arg_291_0:Play413122073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10022"]) and arg_291_1.var_.actorSpriteComps10022 == nil then
				arg_291_1.var_.actorSpriteComps10022 = arg_291_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10022"]) then
				if arg_291_1.var_.actorSpriteComps10022 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10022"]) and arg_291_1.var_.actorSpriteComps10022 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10022 = nil
			end

			local var_294_2 = arg_291_1.actors_["10094"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10094 == nil then
				arg_291_1.var_.actorSpriteComps10094 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps10094 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_294_5 then
							if arg_291_1.isInRecall_ then
								iter_294_5.color = Color.New(Mathf.Lerp(iter_294_5.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_3), Mathf.Lerp(iter_294_5.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_3), (Mathf.Lerp(iter_294_5.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_3)))
							else
								local var_294_4 = Mathf.Lerp(iter_294_5.color.r, 1, (arg_291_1.time_ - 0) / var_294_3)

								iter_294_5.color = Color.New(var_294_4, var_294_4, var_294_4)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10094 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_294_7 then
						iter_294_7.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10094 = nil
			end

			local var_294_5 = arg_291_1.actors_["10094"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10094 = var_294_5.localPosition
				var_294_5.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10094", 4)

				for iter_294_8 = 0, var_294_5.childCount - 1 do
					local var_294_6 = var_294_5:GetChild(iter_294_8)

					if var_294_6.name == "split_1" or not string.find(var_294_6.name, "split") then
						var_294_6.gameObject:SetActive(true)
					else
						var_294_6.gameObject:SetActive(false)
					end
				end
			end

			local var_294_7 = 0.1

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				var_294_5.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_291_1.time_ - 0) / var_294_7)
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				var_294_5.localPosition = Vector3.New(390, -340, -414)
			end

			local var_294_8 = 0
			local var_294_9 = 0.8

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:GetWordFromCfg(413122072)
				local var_294_11 = arg_291_1:FormatText(var_294_10.content)

				arg_291_1.text_.text = var_294_11

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 32 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 32)

				if (32 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_11) / 32)) > 0 and var_294_9 < var_294_13 then
					arg_291_1.talkMaxDuration = var_294_13

					if var_294_13 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_13 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_11
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122072", "story_v_out_413122.awb") ~= 0 then
					local var_294_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122072", "story_v_out_413122.awb") / 1000

					if var_294_14 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_8
					end

					if var_294_10.prefab_name ~= "" and arg_291_1.actors_[var_294_10.prefab_name] ~= nil then
						local var_294_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_10.prefab_name].transform, "story_v_out_413122", "413122072", "story_v_out_413122.awb")

						arg_291_1:RecordAudio("413122072", var_294_15)
						arg_291_1:RecordAudio("413122072", var_294_15)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413122", "413122072", "story_v_out_413122.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413122", "413122072", "story_v_out_413122.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play413122073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413122073
		arg_295_1.duration_ = 12.47

		local var_295_0 = {
			zh = 9.066,
			ja = 12.466
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
				arg_295_0:Play413122074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10022"]) and arg_295_1.var_.actorSpriteComps10022 == nil then
				arg_295_1.var_.actorSpriteComps10022 = arg_295_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10022"]) then
				if arg_295_1.var_.actorSpriteComps10022 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10022"]) and arg_295_1.var_.actorSpriteComps10022 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10022 = nil
			end

			local var_298_2 = arg_295_1.actors_["10094"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10094 == nil then
				arg_295_1.var_.actorSpriteComps10094 = var_298_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_3 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.actorSpriteComps10094 then
					for iter_298_4, iter_298_5 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_298_5 then
							if arg_295_1.isInRecall_ then
								iter_298_5.color = Color.New(Mathf.Lerp(iter_298_5.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_3), Mathf.Lerp(iter_298_5.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_3), (Mathf.Lerp(iter_298_5.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_3)))
							else
								local var_298_4 = Mathf.Lerp(iter_298_5.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_3)

								iter_298_5.color = Color.New(var_298_4, var_298_4, var_298_4)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10094 then
				for iter_298_6, iter_298_7 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_298_7 then
						iter_298_7.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10094 = nil
			end

			local var_298_5 = arg_295_1.actors_["10022"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10022 = var_298_5.localPosition
				var_298_5.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10022", 2)

				for iter_298_8 = 0, var_298_5.childCount - 1 do
					local var_298_6 = var_298_5:GetChild(iter_298_8)

					if var_298_6.name == "split_4" or not string.find(var_298_6.name, "split") then
						var_298_6.gameObject:SetActive(true)
					else
						var_298_6.gameObject:SetActive(false)
					end
				end
			end

			local var_298_7 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				var_298_5.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_295_1.time_ - 0) / var_298_7)
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				var_298_5.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_298_8 = 0
			local var_298_9 = 0.775

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(413122073)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 31 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 31)

				if (31 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_11) / 31)) > 0 and var_298_9 < var_298_13 then
					arg_295_1.talkMaxDuration = var_298_13

					if var_298_13 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_13 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122073", "story_v_out_413122.awb") ~= 0 then
					local var_298_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122073", "story_v_out_413122.awb") / 1000

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end

					if var_298_10.prefab_name ~= "" and arg_295_1.actors_[var_298_10.prefab_name] ~= nil then
						local var_298_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_10.prefab_name].transform, "story_v_out_413122", "413122073", "story_v_out_413122.awb")

						arg_295_1:RecordAudio("413122073", var_298_15)
						arg_295_1:RecordAudio("413122073", var_298_15)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413122", "413122073", "story_v_out_413122.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413122", "413122073", "story_v_out_413122.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_16 and arg_295_1.time_ < var_298_8 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play413122074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413122074
		arg_299_1.duration_ = 5.37

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play413122075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10022 = arg_299_1.actors_["10022"].transform.localPosition
				arg_299_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10022", 2)

				for iter_302_0 = 0, arg_299_1.actors_["10022"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10022"].transform:GetChild(iter_302_0)

					if var_302_0.name == "" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_302_2 = arg_299_1.actors_["10022"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10022 == nil then
				arg_299_1.var_.actorSpriteComps10022 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10022 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10022 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps10022 = nil
			end

			local var_302_5 = arg_299_1.actors_["10022"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10022 = var_302_5.localPosition
				var_302_5.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10022", 7)

				for iter_302_5 = 0, var_302_5.childCount - 1 do
					local var_302_6 = var_302_5:GetChild(iter_302_5)

					if var_302_6.name == "split_3" or not string.find(var_302_6.name, "split") then
						var_302_6.gameObject:SetActive(true)
					else
						var_302_6.gameObject:SetActive(false)
					end
				end
			end

			local var_302_7 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				var_302_5.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_299_1.time_ - 0) / var_302_7)
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				var_302_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_302_8 = arg_299_1.actors_["10094"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10094 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10094", 7)

				for iter_302_6 = 0, var_302_8.childCount - 1 do
					local var_302_9 = var_302_8:GetChild(iter_302_6)

					if var_302_9.name == "" or not string.find(var_302_9.name, "split") then
						var_302_9.gameObject:SetActive(true)
					else
						var_302_9.gameObject:SetActive(false)
					end
				end
			end

			local var_302_10 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_10 then
				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_299_1.time_ - 0) / var_302_10)
			end

			if arg_299_1.time_ >= 0 + var_302_10 and arg_299_1.time_ < 0 + var_302_10 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_11 = 0.366666666666667
			local var_302_12 = 1.075

			if 0.366666666666667 < arg_299_1.time_ and arg_299_1.time_ <= var_302_11 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_13 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_13:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_14 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(413122074).content)

				arg_299_1.text_.text = var_302_14

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_16 = 43 <= 0 and var_302_12 or var_302_12 * (utf8.len(var_302_14) / 43)

				if (43 <= 0 and var_302_12 or var_302_12 * (utf8.len(var_302_14) / 43)) > 0 and var_302_12 < var_302_16 then
					arg_299_1.talkMaxDuration = var_302_16
					var_302_11 = var_302_11 + 0.3

					if var_302_16 + var_302_11 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_16 + var_302_11
					end
				end

				arg_299_1.text_.text = var_302_14
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_17 = var_302_11 + 0.3
			local var_302_18 = math.max(var_302_12, arg_299_1.talkMaxDuration)

			if var_302_11 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_17 + var_302_18 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_17) / var_302_18

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_17 + var_302_18 and arg_299_1.time_ < var_302_17 + var_302_18 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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

		arg_299_1:InitPlayNodeList()
	end,
	Play413122075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413122075
		arg_305_1.duration_ = 3.6

		local var_305_0 = {
			zh = 3.233,
			ja = 3.6
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play413122076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10094 = arg_305_1.actors_["10094"].transform.localPosition
				arg_305_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10094", 4)

				for iter_308_0 = 0, arg_305_1.actors_["10094"].transform.childCount - 1 do
					local var_308_0 = arg_305_1.actors_["10094"].transform:GetChild(iter_308_0)

					if var_308_0.name == "" or not string.find(var_308_0.name, "split") then
						var_308_0.gameObject:SetActive(true)
					else
						var_308_0.gameObject:SetActive(false)
					end
				end
			end

			local var_308_1 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 then
				arg_305_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_305_1.time_ - 0) / var_308_1)
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 then
				arg_305_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_308_2 = arg_305_1.actors_["10094"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10094 == nil then
				arg_305_1.var_.actorSpriteComps10094 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps10094 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								iter_308_2.color = Color.New(Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_2.color.r, 1, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_2.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10094 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_308_4 then
						iter_308_4.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps10094 = nil
			end

			local var_308_5 = 0
			local var_308_6 = 0.35

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(413122075)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 14 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 14)

				if (14 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 14)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122075", "story_v_out_413122.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122075", "story_v_out_413122.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_413122", "413122075", "story_v_out_413122.awb")

						arg_305_1:RecordAudio("413122075", var_308_12)
						arg_305_1:RecordAudio("413122075", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_413122", "413122075", "story_v_out_413122.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_413122", "413122075", "story_v_out_413122.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play413122076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413122076
		arg_309_1.duration_ = 5.53

		local var_309_0 = {
			zh = 4.766,
			ja = 5.533
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play413122077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10022 = arg_309_1.actors_["10022"].transform.localPosition
				arg_309_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10022", 2)

				for iter_312_0 = 0, arg_309_1.actors_["10022"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["10022"].transform:GetChild(iter_312_0)

					if var_312_0.name == "split_8" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_312_2 = arg_309_1.actors_["10094"].transform

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10094 = var_312_2.localPosition
				var_312_2.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10094", 4)

				for iter_312_1 = 0, var_312_2.childCount - 1 do
					local var_312_3 = var_312_2:GetChild(iter_312_1)

					if var_312_3.name == "" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				var_312_2.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_309_1.time_ - 0) / var_312_4)
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				var_312_2.localPosition = Vector3.New(390, -340, -414)
			end

			local var_312_5 = arg_309_1.actors_["10022"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.actorSpriteComps10022 == nil then
				arg_309_1.var_.actorSpriteComps10022 = var_312_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_6 = 2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_6 and not isNil(var_312_5) then
				if arg_309_1.var_.actorSpriteComps10022 then
					for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_312_3 then
							if arg_309_1.isInRecall_ then
								iter_312_3.color = Color.New(Mathf.Lerp(iter_312_3.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_6), Mathf.Lerp(iter_312_3.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_6), (Mathf.Lerp(iter_312_3.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_6)))
							else
								local var_312_7 = Mathf.Lerp(iter_312_3.color.r, 1, (arg_309_1.time_ - 0) / var_312_6)

								iter_312_3.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_6 and arg_309_1.time_ < 0 + var_312_6 + arg_312_0 and not isNil(var_312_5) and arg_309_1.var_.actorSpriteComps10022 then
				for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_312_5 then
						iter_312_5.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps10022 = nil
			end

			local var_312_8 = arg_309_1.actors_["10094"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps10094 == nil then
				arg_309_1.var_.actorSpriteComps10094 = var_312_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_9 = 2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_9 and not isNil(var_312_8) then
				if arg_309_1.var_.actorSpriteComps10094 then
					for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_312_7 then
							if arg_309_1.isInRecall_ then
								iter_312_7.color = Color.New(Mathf.Lerp(iter_312_7.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_9), Mathf.Lerp(iter_312_7.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_9), (Mathf.Lerp(iter_312_7.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_9)))
							else
								local var_312_10 = Mathf.Lerp(iter_312_7.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_9)

								iter_312_7.color = Color.New(var_312_10, var_312_10, var_312_10)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_9 and arg_309_1.time_ < 0 + var_312_9 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps10094 then
				for iter_312_8, iter_312_9 in pairs(arg_309_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_312_9 then
						iter_312_9.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps10094 = nil
			end

			local var_312_11 = 0
			local var_312_12 = 0.6

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_11 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_13 = arg_309_1:GetWordFromCfg(413122076)
				local var_312_14 = arg_309_1:FormatText(var_312_13.content)

				arg_309_1.text_.text = var_312_14

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_16 = 24 <= 0 and var_312_12 or var_312_12 * (utf8.len(var_312_14) / 24)

				if (24 <= 0 and var_312_12 or var_312_12 * (utf8.len(var_312_14) / 24)) > 0 and var_312_12 < var_312_16 then
					arg_309_1.talkMaxDuration = var_312_16

					if var_312_16 + var_312_11 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_16 + var_312_11
					end
				end

				arg_309_1.text_.text = var_312_14
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122076", "story_v_out_413122.awb") ~= 0 then
					local var_312_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122076", "story_v_out_413122.awb") / 1000

					if var_312_17 + var_312_11 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_17 + var_312_11
					end

					if var_312_13.prefab_name ~= "" and arg_309_1.actors_[var_312_13.prefab_name] ~= nil then
						local var_312_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_13.prefab_name].transform, "story_v_out_413122", "413122076", "story_v_out_413122.awb")

						arg_309_1:RecordAudio("413122076", var_312_18)
						arg_309_1:RecordAudio("413122076", var_312_18)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_413122", "413122076", "story_v_out_413122.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_413122", "413122076", "story_v_out_413122.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_19 = math.max(var_312_12, arg_309_1.talkMaxDuration)

			if var_312_11 <= arg_309_1.time_ and arg_309_1.time_ < var_312_11 + var_312_19 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_11) / var_312_19

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_11 + var_312_19 and arg_309_1.time_ < var_312_11 + var_312_19 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_309_1:InitPlayNodeList()
	end,
	Play413122077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 413122077
		arg_313_1.duration_ = 12.2

		local var_313_0 = {
			zh = 9.533,
			ja = 12.2
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
				arg_313_0:Play413122078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10022"]) and arg_313_1.var_.actorSpriteComps10022 == nil then
				arg_313_1.var_.actorSpriteComps10022 = arg_313_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10022"]) then
				if arg_313_1.var_.actorSpriteComps10022 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 1, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10022"]) and arg_313_1.var_.actorSpriteComps10022 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10022 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 1.05

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(413122077)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 42 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 42)

				if (42 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 42)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122077", "story_v_out_413122.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122077", "story_v_out_413122.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_413122", "413122077", "story_v_out_413122.awb")

						arg_313_1:RecordAudio("413122077", var_316_9)
						arg_313_1:RecordAudio("413122077", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_413122", "413122077", "story_v_out_413122.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_413122", "413122077", "story_v_out_413122.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play413122078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 413122078
		arg_317_1.duration_ = 4.07

		local var_317_0 = {
			zh = 4.066,
			ja = 3.533
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play413122079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10092_1 = arg_317_1.actors_["10092_1"].transform.localPosition
				arg_317_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_320_0 = 0, arg_317_1.actors_["10092_1"].transform.childCount - 1 do
					local var_320_0 = arg_317_1.actors_["10092_1"].transform:GetChild(iter_320_0)

					if var_320_0.name == "" or not string.find(var_320_0.name, "split") then
						var_320_0.gameObject:SetActive(true)
					else
						var_320_0.gameObject:SetActive(false)
					end
				end
			end

			local var_320_1 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 then
				arg_317_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_317_1.time_ - 0) / var_320_1)
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 then
				arg_317_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_320_2 = arg_317_1.actors_["10022"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10022 = var_320_2.localPosition
				var_320_2.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10022", 2)

				for iter_320_1 = 0, var_320_2.childCount - 1 do
					local var_320_3 = var_320_2:GetChild(iter_320_1)

					if var_320_3.name == "" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_2.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_317_1.time_ - 0) / var_320_4)
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_320_5 = arg_317_1.actors_["10092_1"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps10092_1 == nil then
				arg_317_1.var_.actorSpriteComps10092_1 = var_320_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_6 = 2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.actorSpriteComps10092_1 then
					for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_320_3 then
							if arg_317_1.isInRecall_ then
								iter_320_3.color = Color.New(Mathf.Lerp(iter_320_3.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_6), Mathf.Lerp(iter_320_3.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_6), (Mathf.Lerp(iter_320_3.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_6)))
							else
								local var_320_7 = Mathf.Lerp(iter_320_3.color.r, 1, (arg_317_1.time_ - 0) / var_320_6)

								iter_320_3.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.actorSpriteComps10092_1 then
				for iter_320_4, iter_320_5 in pairs(arg_317_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_320_5 then
						iter_320_5.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_320_8 = arg_317_1.actors_["10022"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10022 == nil then
				arg_317_1.var_.actorSpriteComps10022 = var_320_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_9 and not isNil(var_320_8) then
				if arg_317_1.var_.actorSpriteComps10022 then
					for iter_320_6, iter_320_7 in pairs(arg_317_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_320_7 then
							if arg_317_1.isInRecall_ then
								iter_320_7.color = Color.New(Mathf.Lerp(iter_320_7.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_9), Mathf.Lerp(iter_320_7.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_9), (Mathf.Lerp(iter_320_7.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_9)))
							else
								local var_320_10 = Mathf.Lerp(iter_320_7.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_9)

								iter_320_7.color = Color.New(var_320_10, var_320_10, var_320_10)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_9 and arg_317_1.time_ < 0 + var_320_9 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10022 then
				for iter_320_8, iter_320_9 in pairs(arg_317_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_320_9 then
						iter_320_9.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10022 = nil
			end

			local var_320_11 = 0
			local var_320_12 = 0.6

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_13 = arg_317_1:GetWordFromCfg(413122078)
				local var_320_14 = arg_317_1:FormatText(var_320_13.content)

				arg_317_1.text_.text = var_320_14

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_16 = 24 <= 0 and var_320_12 or var_320_12 * (utf8.len(var_320_14) / 24)

				if (24 <= 0 and var_320_12 or var_320_12 * (utf8.len(var_320_14) / 24)) > 0 and var_320_12 < var_320_16 then
					arg_317_1.talkMaxDuration = var_320_16

					if var_320_16 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_16 + var_320_11
					end
				end

				arg_317_1.text_.text = var_320_14
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122078", "story_v_out_413122.awb") ~= 0 then
					local var_320_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122078", "story_v_out_413122.awb") / 1000

					if var_320_17 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_17 + var_320_11
					end

					if var_320_13.prefab_name ~= "" and arg_317_1.actors_[var_320_13.prefab_name] ~= nil then
						local var_320_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_13.prefab_name].transform, "story_v_out_413122", "413122078", "story_v_out_413122.awb")

						arg_317_1:RecordAudio("413122078", var_320_18)
						arg_317_1:RecordAudio("413122078", var_320_18)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_413122", "413122078", "story_v_out_413122.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_413122", "413122078", "story_v_out_413122.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_19 = math.max(var_320_12, arg_317_1.talkMaxDuration)

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_19 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_11) / var_320_19

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_11 + var_320_19 and arg_317_1.time_ < var_320_11 + var_320_19 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play413122079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 413122079
		arg_321_1.duration_ = 8.57

		local var_321_0 = {
			zh = 8.533,
			ja = 8.566
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play413122080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10022"]) and arg_321_1.var_.actorSpriteComps10022 == nil then
				arg_321_1.var_.actorSpriteComps10022 = arg_321_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10022"]) then
				if arg_321_1.var_.actorSpriteComps10022 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10022"]) and arg_321_1.var_.actorSpriteComps10022 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps10022 = nil
			end

			local var_324_2 = arg_321_1.actors_["10092_1"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10092_1 == nil then
				arg_321_1.var_.actorSpriteComps10092_1 = var_324_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_3 = 2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.actorSpriteComps10092_1 then
					for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_324_5 then
							if arg_321_1.isInRecall_ then
								iter_324_5.color = Color.New(Mathf.Lerp(iter_324_5.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_3), Mathf.Lerp(iter_324_5.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_3), (Mathf.Lerp(iter_324_5.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_3)))
							else
								local var_324_4 = Mathf.Lerp(iter_324_5.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_3)

								iter_324_5.color = Color.New(var_324_4, var_324_4, var_324_4)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10092_1 then
				for iter_324_6, iter_324_7 in pairs(arg_321_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_324_7 then
						iter_324_7.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_324_5 = 0
			local var_324_6 = 1.125

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(413122079)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 45 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 45)

				if (45 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 45)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122079", "story_v_out_413122.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122079", "story_v_out_413122.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_413122", "413122079", "story_v_out_413122.awb")

						arg_321_1:RecordAudio("413122079", var_324_12)
						arg_321_1:RecordAudio("413122079", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_413122", "413122079", "story_v_out_413122.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_413122", "413122079", "story_v_out_413122.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play413122080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 413122080
		arg_325_1.duration_ = 6.7

		local var_325_0 = {
			zh = 4.233,
			ja = 6.7
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
				arg_325_0:Play413122081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10092_1"]) and arg_325_1.var_.actorSpriteComps10092_1 == nil then
				arg_325_1.var_.actorSpriteComps10092_1 = arg_325_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10092_1"]) then
				if arg_325_1.var_.actorSpriteComps10092_1 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 1, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10092_1"]) and arg_325_1.var_.actorSpriteComps10092_1 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_325_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_328_2 = arg_325_1.actors_["10022"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps10022 == nil then
				arg_325_1.var_.actorSpriteComps10022 = var_328_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_3 = 2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.actorSpriteComps10022 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_328_5 then
							if arg_325_1.isInRecall_ then
								iter_328_5.color = Color.New(Mathf.Lerp(iter_328_5.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_3), Mathf.Lerp(iter_328_5.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_3), (Mathf.Lerp(iter_328_5.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_3)))
							else
								local var_328_4 = Mathf.Lerp(iter_328_5.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_3)

								iter_328_5.color = Color.New(var_328_4, var_328_4, var_328_4)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.actorSpriteComps10022 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_328_7 then
						iter_328_7.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps10022 = nil
			end

			local var_328_5 = 0
			local var_328_6 = 0.4

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(413122080)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 16 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 16)

				if (16 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 16)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122080", "story_v_out_413122.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122080", "story_v_out_413122.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_413122", "413122080", "story_v_out_413122.awb")

						arg_325_1:RecordAudio("413122080", var_328_12)
						arg_325_1:RecordAudio("413122080", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_413122", "413122080", "story_v_out_413122.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_413122", "413122080", "story_v_out_413122.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_13 and arg_325_1.time_ < var_328_5 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play413122081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 413122081
		arg_329_1.duration_ = 7.6

		local var_329_0 = {
			zh = 7.6,
			ja = 7.333
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play413122082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10022 = arg_329_1.actors_["10022"].transform.localPosition
				arg_329_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("10022", 2)

				for iter_332_0 = 0, arg_329_1.actors_["10022"].transform.childCount - 1 do
					local var_332_0 = arg_329_1.actors_["10022"].transform:GetChild(iter_332_0)

					if var_332_0.name == "split_6" or not string.find(var_332_0.name, "split") then
						var_332_0.gameObject:SetActive(true)
					else
						var_332_0.gameObject:SetActive(false)
					end
				end
			end

			local var_332_1 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_1 then
				arg_329_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_329_1.time_ - 0) / var_332_1)
			end

			if arg_329_1.time_ >= 0 + var_332_1 and arg_329_1.time_ < 0 + var_332_1 + arg_332_0 then
				arg_329_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_332_2 = arg_329_1.actors_["10022"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps10022 == nil then
				arg_329_1.var_.actorSpriteComps10022 = var_332_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_3 = 2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.actorSpriteComps10022 then
					for iter_332_1, iter_332_2 in pairs(arg_329_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_332_2 then
							if arg_329_1.isInRecall_ then
								iter_332_2.color = Color.New(Mathf.Lerp(iter_332_2.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_3), Mathf.Lerp(iter_332_2.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_3), (Mathf.Lerp(iter_332_2.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_3)))
							else
								local var_332_4 = Mathf.Lerp(iter_332_2.color.r, 1, (arg_329_1.time_ - 0) / var_332_3)

								iter_332_2.color = Color.New(var_332_4, var_332_4, var_332_4)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.actorSpriteComps10022 then
				for iter_332_3, iter_332_4 in pairs(arg_329_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_332_4 then
						iter_332_4.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps10022 = nil
			end

			local var_332_5 = arg_329_1.actors_["10092_1"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.actorSpriteComps10092_1 == nil then
				arg_329_1.var_.actorSpriteComps10092_1 = var_332_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_6 = 2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_6 and not isNil(var_332_5) then
				if arg_329_1.var_.actorSpriteComps10092_1 then
					for iter_332_5, iter_332_6 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_332_6 then
							if arg_329_1.isInRecall_ then
								iter_332_6.color = Color.New(Mathf.Lerp(iter_332_6.color.r, arg_329_1.hightColor2.r, (arg_329_1.time_ - 0) / var_332_6), Mathf.Lerp(iter_332_6.color.g, arg_329_1.hightColor2.g, (arg_329_1.time_ - 0) / var_332_6), (Mathf.Lerp(iter_332_6.color.b, arg_329_1.hightColor2.b, (arg_329_1.time_ - 0) / var_332_6)))
							else
								local var_332_7 = Mathf.Lerp(iter_332_6.color.r, 0.5, (arg_329_1.time_ - 0) / var_332_6)

								iter_332_6.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_6 and arg_329_1.time_ < 0 + var_332_6 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.actorSpriteComps10092_1 then
				for iter_332_7, iter_332_8 in pairs(arg_329_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_332_8 then
						iter_332_8.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_329_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_332_8 = 0
			local var_332_9 = 0.825

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(413122081)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 33 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 33)

				if (33 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 33)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122081", "story_v_out_413122.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122081", "story_v_out_413122.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_413122", "413122081", "story_v_out_413122.awb")

						arg_329_1:RecordAudio("413122081", var_332_15)
						arg_329_1:RecordAudio("413122081", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_413122", "413122081", "story_v_out_413122.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_413122", "413122081", "story_v_out_413122.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play413122082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 413122082
		arg_333_1.duration_ = 7.17

		local var_333_0 = {
			zh = 5.2,
			ja = 7.166
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play413122083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10022"]) and arg_333_1.var_.actorSpriteComps10022 == nil then
				arg_333_1.var_.actorSpriteComps10022 = arg_333_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10022"]) then
				if arg_333_1.var_.actorSpriteComps10022 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 1, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10022"]) and arg_333_1.var_.actorSpriteComps10022 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps10022 = nil
			end

			local var_336_2 = 0
			local var_336_3 = 0.6

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(413122082)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 24 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 24)

				if (24 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 24)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122082", "story_v_out_413122.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122082", "story_v_out_413122.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_out_413122", "413122082", "story_v_out_413122.awb")

						arg_333_1:RecordAudio("413122082", var_336_9)
						arg_333_1:RecordAudio("413122082", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_413122", "413122082", "story_v_out_413122.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_413122", "413122082", "story_v_out_413122.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play413122083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 413122083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play413122084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10022 = arg_337_1.actors_["10022"].transform.localPosition
				arg_337_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10022", 7)

				for iter_340_0 = 0, arg_337_1.actors_["10022"].transform.childCount - 1 do
					local var_340_0 = arg_337_1.actors_["10022"].transform:GetChild(iter_340_0)

					if var_340_0.name == "" or not string.find(var_340_0.name, "split") then
						var_340_0.gameObject:SetActive(true)
					else
						var_340_0.gameObject:SetActive(false)
					end
				end
			end

			local var_340_1 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				arg_337_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_337_1.time_ - 0) / var_340_1)
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 then
				arg_337_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_340_2 = arg_337_1.actors_["10022"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10022 == nil then
				arg_337_1.var_.actorSpriteComps10022 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps10022 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								iter_340_2.color = Color.New(Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_2.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_2.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10022 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_340_4 then
						iter_340_4.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps10022 = nil
			end

			local var_340_5 = arg_337_1.actors_["10092_1"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10092_1 = var_340_5.localPosition
				var_340_5.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_340_5 = 0, var_340_5.childCount - 1 do
					local var_340_6 = var_340_5:GetChild(iter_340_5)

					if var_340_6.name == "" or not string.find(var_340_6.name, "split") then
						var_340_6.gameObject:SetActive(true)
					else
						var_340_6.gameObject:SetActive(false)
					end
				end
			end

			local var_340_7 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				var_340_5.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_337_1.time_ - 0) / var_340_7)
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				var_340_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_340_8 = 0
			local var_340_9 = 1.375

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_10 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(413122083).content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_12 = 55 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_10) / 55)

				if (55 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_10) / 55)) > 0 and var_340_9 < var_340_12 then
					arg_337_1.talkMaxDuration = var_340_12

					if var_340_12 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_8
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_13 = math.max(var_340_9, arg_337_1.talkMaxDuration)

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_13 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_8) / var_340_13

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_8 + var_340_13 and arg_337_1.time_ < var_340_8 + var_340_13 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play413122084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 413122084
		arg_341_1.duration_ = 5.1

		local var_341_0 = {
			zh = 3.066,
			ja = 5.1
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play413122085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10092_1 = arg_341_1.actors_["10092_1"].transform.localPosition
				arg_341_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_344_0 = 0, arg_341_1.actors_["10092_1"].transform.childCount - 1 do
					local var_344_0 = arg_341_1.actors_["10092_1"].transform:GetChild(iter_344_0)

					if var_344_0.name == "" or not string.find(var_344_0.name, "split") then
						var_344_0.gameObject:SetActive(true)
					else
						var_344_0.gameObject:SetActive(false)
					end
				end
			end

			local var_344_1 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 then
				arg_341_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_341_1.time_ - 0) / var_344_1)
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 then
				arg_341_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_344_2 = arg_341_1.actors_["10092_1"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps10092_1 == nil then
				arg_341_1.var_.actorSpriteComps10092_1 = var_344_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_3 = 2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.actorSpriteComps10092_1 then
					for iter_344_1, iter_344_2 in pairs(arg_341_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_344_2 then
							if arg_341_1.isInRecall_ then
								iter_344_2.color = Color.New(Mathf.Lerp(iter_344_2.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_3), Mathf.Lerp(iter_344_2.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_3), (Mathf.Lerp(iter_344_2.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_3)))
							else
								local var_344_4 = Mathf.Lerp(iter_344_2.color.r, 1, (arg_341_1.time_ - 0) / var_344_3)

								iter_344_2.color = Color.New(var_344_4, var_344_4, var_344_4)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps10092_1 then
				for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_344_4 then
						iter_344_4.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_344_5 = 0
			local var_344_6 = 0.325

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:GetWordFromCfg(413122084)
				local var_344_8 = arg_341_1:FormatText(var_344_7.content)

				arg_341_1.text_.text = var_344_8

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 13 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 13)

				if (13 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 13)) > 0 and var_344_6 < var_344_10 then
					arg_341_1.talkMaxDuration = var_344_10

					if var_344_10 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_8
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122084", "story_v_out_413122.awb") ~= 0 then
					local var_344_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122084", "story_v_out_413122.awb") / 1000

					if var_344_11 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_11 + var_344_5
					end

					if var_344_7.prefab_name ~= "" and arg_341_1.actors_[var_344_7.prefab_name] ~= nil then
						local var_344_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_7.prefab_name].transform, "story_v_out_413122", "413122084", "story_v_out_413122.awb")

						arg_341_1:RecordAudio("413122084", var_344_12)
						arg_341_1:RecordAudio("413122084", var_344_12)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_413122", "413122084", "story_v_out_413122.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_413122", "413122084", "story_v_out_413122.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_13 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_13 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_13

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_13 and arg_341_1.time_ < var_344_5 + var_344_13 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play413122085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 413122085
		arg_345_1.duration_ = 8.37

		local var_345_0 = {
			zh = 8.366,
			ja = 6.466
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play413122086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10022 = arg_345_1.actors_["10022"].transform.localPosition
				arg_345_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10022", 2)

				for iter_348_0 = 0, arg_345_1.actors_["10022"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["10022"].transform:GetChild(iter_348_0)

					if var_348_0.name == "split_6" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_348_2 = arg_345_1.actors_["10092_1"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10092_1 = var_348_2.localPosition
				var_348_2.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_348_1 = 0, var_348_2.childCount - 1 do
					local var_348_3 = var_348_2:GetChild(iter_348_1)

					if var_348_3.name == "" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_2.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_345_1.time_ - 0) / var_348_4)
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_348_5 = arg_345_1.actors_["10022"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps10022 == nil then
				arg_345_1.var_.actorSpriteComps10022 = var_348_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_6 = 2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 and not isNil(var_348_5) then
				if arg_345_1.var_.actorSpriteComps10022 then
					for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_348_3 then
							if arg_345_1.isInRecall_ then
								iter_348_3.color = Color.New(Mathf.Lerp(iter_348_3.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_6), Mathf.Lerp(iter_348_3.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_6), (Mathf.Lerp(iter_348_3.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_6)))
							else
								local var_348_7 = Mathf.Lerp(iter_348_3.color.r, 1, (arg_345_1.time_ - 0) / var_348_6)

								iter_348_3.color = Color.New(var_348_7, var_348_7, var_348_7)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.actorSpriteComps10022 then
				for iter_348_4, iter_348_5 in pairs(arg_345_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_348_5 then
						iter_348_5.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10022 = nil
			end

			local var_348_8 = arg_345_1.actors_["10092_1"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_8) and arg_345_1.var_.actorSpriteComps10092_1 == nil then
				arg_345_1.var_.actorSpriteComps10092_1 = var_348_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_9 = 2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_9 and not isNil(var_348_8) then
				if arg_345_1.var_.actorSpriteComps10092_1 then
					for iter_348_6, iter_348_7 in pairs(arg_345_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_348_7 then
							if arg_345_1.isInRecall_ then
								iter_348_7.color = Color.New(Mathf.Lerp(iter_348_7.color.r, arg_345_1.hightColor2.r, (arg_345_1.time_ - 0) / var_348_9), Mathf.Lerp(iter_348_7.color.g, arg_345_1.hightColor2.g, (arg_345_1.time_ - 0) / var_348_9), (Mathf.Lerp(iter_348_7.color.b, arg_345_1.hightColor2.b, (arg_345_1.time_ - 0) / var_348_9)))
							else
								local var_348_10 = Mathf.Lerp(iter_348_7.color.r, 0.5, (arg_345_1.time_ - 0) / var_348_9)

								iter_348_7.color = Color.New(var_348_10, var_348_10, var_348_10)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_9 and arg_345_1.time_ < 0 + var_348_9 + arg_348_0 and not isNil(var_348_8) and arg_345_1.var_.actorSpriteComps10092_1 then
				for iter_348_8, iter_348_9 in pairs(arg_345_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_348_9 then
						iter_348_9.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_345_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_348_11 = arg_345_1.actors_["10092_1"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10092_1 = var_348_11.localPosition
				var_348_11.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_348_10 = 0, var_348_11.childCount - 1 do
					local var_348_12 = var_348_11:GetChild(iter_348_10)

					if var_348_12.name == "" or not string.find(var_348_12.name, "split") then
						var_348_12.gameObject:SetActive(true)
					else
						var_348_12.gameObject:SetActive(false)
					end
				end
			end

			local var_348_13 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_13 then
				var_348_11.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_345_1.time_ - 0) / var_348_13)
			end

			if arg_345_1.time_ >= 0 + var_348_13 and arg_345_1.time_ < 0 + var_348_13 + arg_348_0 then
				var_348_11.localPosition = Vector3.New(390, -300, -295)
			end

			local var_348_14 = 0
			local var_348_15 = 1.075

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_16 = arg_345_1:GetWordFromCfg(413122085)
				local var_348_17 = arg_345_1:FormatText(var_348_16.content)

				arg_345_1.text_.text = var_348_17

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_19 = 43 <= 0 and var_348_15 or var_348_15 * (utf8.len(var_348_17) / 43)

				if (43 <= 0 and var_348_15 or var_348_15 * (utf8.len(var_348_17) / 43)) > 0 and var_348_15 < var_348_19 then
					arg_345_1.talkMaxDuration = var_348_19

					if var_348_19 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_19 + var_348_14
					end
				end

				arg_345_1.text_.text = var_348_17
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122085", "story_v_out_413122.awb") ~= 0 then
					local var_348_20 = manager.audio:GetVoiceLength("story_v_out_413122", "413122085", "story_v_out_413122.awb") / 1000

					if var_348_20 + var_348_14 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_20 + var_348_14
					end

					if var_348_16.prefab_name ~= "" and arg_345_1.actors_[var_348_16.prefab_name] ~= nil then
						local var_348_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_16.prefab_name].transform, "story_v_out_413122", "413122085", "story_v_out_413122.awb")

						arg_345_1:RecordAudio("413122085", var_348_21)
						arg_345_1:RecordAudio("413122085", var_348_21)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_413122", "413122085", "story_v_out_413122.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_413122", "413122085", "story_v_out_413122.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_22 = math.max(var_348_15, arg_345_1.talkMaxDuration)

			if var_348_14 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_22 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_14) / var_348_22

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_14 + var_348_22 and arg_345_1.time_ < var_348_14 + var_348_22 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play413122086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 413122086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play413122087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10092_1 = arg_349_1.actors_["10092_1"].transform.localPosition
				arg_349_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_352_0 = 0, arg_349_1.actors_["10092_1"].transform.childCount - 1 do
					local var_352_0 = arg_349_1.actors_["10092_1"].transform:GetChild(iter_352_0)

					if var_352_0.name == "" or not string.find(var_352_0.name, "split") then
						var_352_0.gameObject:SetActive(true)
					else
						var_352_0.gameObject:SetActive(false)
					end
				end
			end

			local var_352_1 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_1 then
				arg_349_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_349_1.time_ - 0) / var_352_1)
			end

			if arg_349_1.time_ >= 0 + var_352_1 and arg_349_1.time_ < 0 + var_352_1 + arg_352_0 then
				arg_349_1.actors_["10092_1"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_352_2 = arg_349_1.actors_["10022"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10022 = var_352_2.localPosition
				var_352_2.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10022", 7)

				for iter_352_1 = 0, var_352_2.childCount - 1 do
					local var_352_3 = var_352_2:GetChild(iter_352_1)

					if var_352_3.name == "split_3" or not string.find(var_352_3.name, "split") then
						var_352_3.gameObject:SetActive(true)
					else
						var_352_3.gameObject:SetActive(false)
					end
				end
			end

			local var_352_4 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				var_352_2.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_349_1.time_ - 0) / var_352_4)
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				var_352_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_352_5 = 0
			local var_352_6 = 0.975

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(413122086).content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 39 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_7) / 39)

				if (39 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_7) / 39)) > 0 and var_352_6 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_5) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_5 + var_352_10 and arg_349_1.time_ < var_352_5 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play413122087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 413122087
		arg_353_1.duration_ = 6.93

		local var_353_0 = {
			zh = 5.366,
			ja = 6.933
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play413122088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10092_1 = arg_353_1.actors_["10092_1"].transform.localPosition
				arg_353_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_356_0 = 0, arg_353_1.actors_["10092_1"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["10092_1"].transform:GetChild(iter_356_0)

					if var_356_0.name == "split_1_1" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_356_2 = arg_353_1.actors_["10092_1"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10092_1 == nil then
				arg_353_1.var_.actorSpriteComps10092_1 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps10092_1 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								iter_356_2.color = Color.New(Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_2.color.r, 1, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_2.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10092_1 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_356_4 then
						iter_356_4.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_356_5 = 0
			local var_356_6 = 0.55

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(413122087)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 22 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 22)

				if (22 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 22)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122087", "story_v_out_413122.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122087", "story_v_out_413122.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_413122", "413122087", "story_v_out_413122.awb")

						arg_353_1:RecordAudio("413122087", var_356_12)
						arg_353_1:RecordAudio("413122087", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_413122", "413122087", "story_v_out_413122.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_413122", "413122087", "story_v_out_413122.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_6, arg_353_1.talkMaxDuration)

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_5) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_5 + var_356_13 and arg_353_1.time_ < var_356_5 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play413122088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 413122088
		arg_357_1.duration_ = 3.7

		local var_357_0 = {
			zh = 3.366,
			ja = 3.7
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play413122089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10092_1 = arg_357_1.actors_["10092_1"].transform.localPosition
				arg_357_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_360_0 = 0, arg_357_1.actors_["10092_1"].transform.childCount - 1 do
					local var_360_0 = arg_357_1.actors_["10092_1"].transform:GetChild(iter_360_0)

					if var_360_0.name == "" or not string.find(var_360_0.name, "split") then
						var_360_0.gameObject:SetActive(true)
					else
						var_360_0.gameObject:SetActive(false)
					end
				end
			end

			local var_360_1 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_1 then
				arg_357_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_357_1.time_ - 0) / var_360_1)
			end

			if arg_357_1.time_ >= 0 + var_360_1 and arg_357_1.time_ < 0 + var_360_1 + arg_360_0 then
				arg_357_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_360_2 = arg_357_1.actors_["10092_1"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10092_1 == nil then
				arg_357_1.var_.actorSpriteComps10092_1 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps10092_1 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_360_2 then
							if arg_357_1.isInRecall_ then
								iter_360_2.color = Color.New(Mathf.Lerp(iter_360_2.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_2.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_2.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_2.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_2.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10092_1 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_360_4 then
						iter_360_4.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_360_5 = arg_357_1.actors_["10094"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_5) and arg_357_1.var_.actorSpriteComps10094 == nil then
				arg_357_1.var_.actorSpriteComps10094 = var_360_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_6 = 2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_6 and not isNil(var_360_5) then
				if arg_357_1.var_.actorSpriteComps10094 then
					for iter_360_5, iter_360_6 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_360_6 then
							if arg_357_1.isInRecall_ then
								iter_360_6.color = Color.New(Mathf.Lerp(iter_360_6.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_6), Mathf.Lerp(iter_360_6.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_6), (Mathf.Lerp(iter_360_6.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_6)))
							else
								local var_360_7 = Mathf.Lerp(iter_360_6.color.r, 1, (arg_357_1.time_ - 0) / var_360_6)

								iter_360_6.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_6 and arg_357_1.time_ < 0 + var_360_6 + arg_360_0 and not isNil(var_360_5) and arg_357_1.var_.actorSpriteComps10094 then
				for iter_360_7, iter_360_8 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_360_8 then
						iter_360_8.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps10094 = nil
			end

			local var_360_8 = arg_357_1.actors_["10094"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10094 = var_360_8.localPosition
				var_360_8.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10094", 4)

				for iter_360_9 = 0, var_360_8.childCount - 1 do
					local var_360_9 = var_360_8:GetChild(iter_360_9)

					if var_360_9.name == "" or not string.find(var_360_9.name, "split") then
						var_360_9.gameObject:SetActive(true)
					else
						var_360_9.gameObject:SetActive(false)
					end
				end
			end

			local var_360_10 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_10 then
				var_360_8.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_357_1.time_ - 0) / var_360_10)
			end

			if arg_357_1.time_ >= 0 + var_360_10 and arg_357_1.time_ < 0 + var_360_10 + arg_360_0 then
				var_360_8.localPosition = Vector3.New(390, -340, -414)
			end

			local var_360_11 = 0
			local var_360_12 = 0.45

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_11 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_13 = arg_357_1:GetWordFromCfg(413122088)
				local var_360_14 = arg_357_1:FormatText(var_360_13.content)

				arg_357_1.text_.text = var_360_14

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_16 = 18 <= 0 and var_360_12 or var_360_12 * (utf8.len(var_360_14) / 18)

				if (18 <= 0 and var_360_12 or var_360_12 * (utf8.len(var_360_14) / 18)) > 0 and var_360_12 < var_360_16 then
					arg_357_1.talkMaxDuration = var_360_16

					if var_360_16 + var_360_11 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_16 + var_360_11
					end
				end

				arg_357_1.text_.text = var_360_14
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122088", "story_v_out_413122.awb") ~= 0 then
					local var_360_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122088", "story_v_out_413122.awb") / 1000

					if var_360_17 + var_360_11 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_17 + var_360_11
					end

					if var_360_13.prefab_name ~= "" and arg_357_1.actors_[var_360_13.prefab_name] ~= nil then
						local var_360_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_13.prefab_name].transform, "story_v_out_413122", "413122088", "story_v_out_413122.awb")

						arg_357_1:RecordAudio("413122088", var_360_18)
						arg_357_1:RecordAudio("413122088", var_360_18)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_413122", "413122088", "story_v_out_413122.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_413122", "413122088", "story_v_out_413122.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_19 = math.max(var_360_12, arg_357_1.talkMaxDuration)

			if var_360_11 <= arg_357_1.time_ and arg_357_1.time_ < var_360_11 + var_360_19 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_11) / var_360_19

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_11 + var_360_19 and arg_357_1.time_ < var_360_11 + var_360_19 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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

		arg_357_1:InitPlayNodeList()
	end,
	Play413122089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 413122089
		arg_361_1.duration_ = 2.87

		local var_361_0 = {
			zh = 2.866,
			ja = 2.533
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play413122090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10093 = arg_361_1.actors_["10093"].transform.localPosition
				arg_361_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10093", 4)

				for iter_364_0 = 0, arg_361_1.actors_["10093"].transform.childCount - 1 do
					local var_364_0 = arg_361_1.actors_["10093"].transform:GetChild(iter_364_0)

					if var_364_0.name == "" or not string.find(var_364_0.name, "split") then
						var_364_0.gameObject:SetActive(true)
					else
						var_364_0.gameObject:SetActive(false)
					end
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_361_1.time_ - 0) / var_364_1)
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_364_2 = arg_361_1.actors_["10092_1"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10092_1 = var_364_2.localPosition
				var_364_2.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_364_1 = 0, var_364_2.childCount - 1 do
					local var_364_3 = var_364_2:GetChild(iter_364_1)

					if var_364_3.name == "" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_2.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_361_1.time_ - 0) / var_364_4)
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_5 = arg_361_1.actors_["10093"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.actorSpriteComps10093 == nil then
				arg_361_1.var_.actorSpriteComps10093 = var_364_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_6 = 2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_6 and not isNil(var_364_5) then
				if arg_361_1.var_.actorSpriteComps10093 then
					for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_364_3 then
							if arg_361_1.isInRecall_ then
								iter_364_3.color = Color.New(Mathf.Lerp(iter_364_3.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_6), Mathf.Lerp(iter_364_3.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_6), (Mathf.Lerp(iter_364_3.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_6)))
							else
								local var_364_7 = Mathf.Lerp(iter_364_3.color.r, 1, (arg_361_1.time_ - 0) / var_364_6)

								iter_364_3.color = Color.New(var_364_7, var_364_7, var_364_7)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_6 and arg_361_1.time_ < 0 + var_364_6 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.actorSpriteComps10093 then
				for iter_364_4, iter_364_5 in pairs(arg_361_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_364_5 then
						iter_364_5.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps10093 = nil
			end

			local var_364_8 = arg_361_1.actors_["10093"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10093 = var_364_8.localPosition
				var_364_8.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10093", 3)

				for iter_364_6 = 0, var_364_8.childCount - 1 do
					local var_364_9 = var_364_8:GetChild(iter_364_6)

					if var_364_9.name == "split_4" or not string.find(var_364_9.name, "split") then
						var_364_9.gameObject:SetActive(true)
					else
						var_364_9.gameObject:SetActive(false)
					end
				end
			end

			local var_364_10 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_10 then
				var_364_8.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_361_1.time_ - 0) / var_364_10)
			end

			if arg_361_1.time_ >= 0 + var_364_10 and arg_361_1.time_ < 0 + var_364_10 + arg_364_0 then
				var_364_8.localPosition = Vector3.New(0, -345, -245)
			end

			local var_364_11 = 0
			local var_364_12 = 0.35

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_11 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_13 = arg_361_1:GetWordFromCfg(413122089)
				local var_364_14 = arg_361_1:FormatText(var_364_13.content)

				arg_361_1.text_.text = var_364_14

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_16 = 14 <= 0 and var_364_12 or var_364_12 * (utf8.len(var_364_14) / 14)

				if (14 <= 0 and var_364_12 or var_364_12 * (utf8.len(var_364_14) / 14)) > 0 and var_364_12 < var_364_16 then
					arg_361_1.talkMaxDuration = var_364_16

					if var_364_16 + var_364_11 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_16 + var_364_11
					end
				end

				arg_361_1.text_.text = var_364_14
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122089", "story_v_out_413122.awb") ~= 0 then
					local var_364_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122089", "story_v_out_413122.awb") / 1000

					if var_364_17 + var_364_11 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_17 + var_364_11
					end

					if var_364_13.prefab_name ~= "" and arg_361_1.actors_[var_364_13.prefab_name] ~= nil then
						local var_364_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_13.prefab_name].transform, "story_v_out_413122", "413122089", "story_v_out_413122.awb")

						arg_361_1:RecordAudio("413122089", var_364_18)
						arg_361_1:RecordAudio("413122089", var_364_18)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_413122", "413122089", "story_v_out_413122.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_413122", "413122089", "story_v_out_413122.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_19 = math.max(var_364_12, arg_361_1.talkMaxDuration)

			if var_364_11 <= arg_361_1.time_ and arg_361_1.time_ < var_364_11 + var_364_19 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_11) / var_364_19

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_11 + var_364_19 and arg_361_1.time_ < var_364_11 + var_364_19 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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
				actorName = "10092_1",
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

		arg_361_1:InitPlayNodeList()
	end,
	Play413122090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 413122090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play413122091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10093 = arg_365_1.actors_["10093"].transform.localPosition
				arg_365_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10093", 6)

				for iter_368_0 = 0, arg_365_1.actors_["10093"].transform.childCount - 1 do
					local var_368_0 = arg_365_1.actors_["10093"].transform:GetChild(iter_368_0)

					if var_368_0.name == "" or not string.find(var_368_0.name, "split") then
						var_368_0.gameObject:SetActive(true)
					else
						var_368_0.gameObject:SetActive(false)
					end
				end
			end

			local var_368_1 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				arg_365_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_365_1.time_ - 0) / var_368_1)
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 then
				arg_365_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_368_2 = arg_365_1.actors_["10092_1"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10092_1 = var_368_2.localPosition
				var_368_2.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_368_1 = 0, var_368_2.childCount - 1 do
					local var_368_3 = var_368_2:GetChild(iter_368_1)

					if var_368_3.name == "" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				var_368_2.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_365_1.time_ - 0) / var_368_4)
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				var_368_2.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_368_5 = arg_365_1.actors_["10093"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps10093 == nil then
				arg_365_1.var_.actorSpriteComps10093 = var_368_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_6 = 2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.actorSpriteComps10093 then
					for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_368_3 then
							if arg_365_1.isInRecall_ then
								iter_368_3.color = Color.New(Mathf.Lerp(iter_368_3.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_6), Mathf.Lerp(iter_368_3.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_6), (Mathf.Lerp(iter_368_3.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_6)))
							else
								local var_368_7 = Mathf.Lerp(iter_368_3.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_6)

								iter_368_3.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.actorSpriteComps10093 then
				for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_368_5 then
						iter_368_5.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps10093 = nil
			end

			local var_368_8 = arg_365_1.actors_["10092_1"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10092_1 == nil then
				arg_365_1.var_.actorSpriteComps10092_1 = var_368_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_9 and not isNil(var_368_8) then
				if arg_365_1.var_.actorSpriteComps10092_1 then
					for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_368_7 then
							if arg_365_1.isInRecall_ then
								iter_368_7.color = Color.New(Mathf.Lerp(iter_368_7.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_9), Mathf.Lerp(iter_368_7.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_9), (Mathf.Lerp(iter_368_7.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_9)))
							else
								local var_368_10 = Mathf.Lerp(iter_368_7.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_9)

								iter_368_7.color = Color.New(var_368_10, var_368_10, var_368_10)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_9 and arg_365_1.time_ < 0 + var_368_9 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10092_1 then
				for iter_368_8, iter_368_9 in pairs(arg_365_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_368_9 then
						iter_368_9.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_368_11 = 0
			local var_368_12 = 1.1

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_11 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_13 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(413122090).content)

				arg_365_1.text_.text = var_368_13

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_15 = 44 <= 0 and var_368_12 or var_368_12 * (utf8.len(var_368_13) / 44)

				if (44 <= 0 and var_368_12 or var_368_12 * (utf8.len(var_368_13) / 44)) > 0 and var_368_12 < var_368_15 then
					arg_365_1.talkMaxDuration = var_368_15

					if var_368_15 + var_368_11 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_15 + var_368_11
					end
				end

				arg_365_1.text_.text = var_368_13
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_16 = math.max(var_368_12, arg_365_1.talkMaxDuration)

			if var_368_11 <= arg_365_1.time_ and arg_365_1.time_ < var_368_11 + var_368_16 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_11) / var_368_16

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_11 + var_368_16 and arg_365_1.time_ < var_368_11 + var_368_16 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play413122091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 413122091
		arg_369_1.duration_ = 6.4

		local var_369_0 = {
			zh = 5.266,
			ja = 6.4
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play413122092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10022 = arg_369_1.actors_["10022"].transform.localPosition
				arg_369_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10022", 3)

				for iter_372_0 = 0, arg_369_1.actors_["10022"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["10022"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_6" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_372_2 = arg_369_1.actors_["10022"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10022 == nil then
				arg_369_1.var_.actorSpriteComps10022 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps10022 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10022 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10022 = nil
			end

			local var_372_5 = 0
			local var_372_6 = 0.7

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(413122091)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_10 = 28 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 28)

				if (28 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 28)) > 0 and var_372_6 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122091", "story_v_out_413122.awb") ~= 0 then
					local var_372_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122091", "story_v_out_413122.awb") / 1000

					if var_372_11 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_5
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_413122", "413122091", "story_v_out_413122.awb")

						arg_369_1:RecordAudio("413122091", var_372_12)
						arg_369_1:RecordAudio("413122091", var_372_12)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_413122", "413122091", "story_v_out_413122.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_413122", "413122091", "story_v_out_413122.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_13 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_13 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_13

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_13 and arg_369_1.time_ < var_372_5 + var_372_13 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play413122092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 413122092
		arg_373_1.duration_ = 8.83

		local var_373_0 = {
			zh = 8.833,
			ja = 7.133
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play413122093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10022"]) and arg_373_1.var_.actorSpriteComps10022 == nil then
				arg_373_1.var_.actorSpriteComps10022 = arg_373_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10022"]) then
				if arg_373_1.var_.actorSpriteComps10022 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 1, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10022"]) and arg_373_1.var_.actorSpriteComps10022 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps10022 = nil
			end

			local var_376_2 = 0
			local var_376_3 = 1.025

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(413122092)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 41 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 41)

				if (41 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 41)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122092", "story_v_out_413122.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122092", "story_v_out_413122.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_413122", "413122092", "story_v_out_413122.awb")

						arg_373_1:RecordAudio("413122092", var_376_9)
						arg_373_1:RecordAudio("413122092", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_413122", "413122092", "story_v_out_413122.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_413122", "413122092", "story_v_out_413122.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play413122093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 413122093
		arg_377_1.duration_ = 5.6

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play413122094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10022 = arg_377_1.actors_["10022"].transform.localPosition
				arg_377_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10022", 2)

				for iter_380_0 = 0, arg_377_1.actors_["10022"].transform.childCount - 1 do
					local var_380_0 = arg_377_1.actors_["10022"].transform:GetChild(iter_380_0)

					if var_380_0.name == "split_6" or not string.find(var_380_0.name, "split") then
						var_380_0.gameObject:SetActive(true)
					else
						var_380_0.gameObject:SetActive(false)
					end
				end
			end

			local var_380_1 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_1 then
				arg_377_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_377_1.time_ - 0) / var_380_1)
			end

			if arg_377_1.time_ >= 0 + var_380_1 and arg_377_1.time_ < 0 + var_380_1 + arg_380_0 then
				arg_377_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_380_2 = arg_377_1.actors_["10092_1"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos10092_1 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_380_1 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_1)

					if var_380_3.name == "split_1_1" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_380_5 = arg_377_1.actors_["10022"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps10022 == nil then
				arg_377_1.var_.actorSpriteComps10022 = var_380_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_6 = 2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_6 and not isNil(var_380_5) then
				if arg_377_1.var_.actorSpriteComps10022 then
					for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_380_3 then
							if arg_377_1.isInRecall_ then
								iter_380_3.color = Color.New(Mathf.Lerp(iter_380_3.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_6), Mathf.Lerp(iter_380_3.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_6), (Mathf.Lerp(iter_380_3.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_6)))
							else
								local var_380_7 = Mathf.Lerp(iter_380_3.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_6)

								iter_380_3.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_6 and arg_377_1.time_ < 0 + var_380_6 + arg_380_0 and not isNil(var_380_5) and arg_377_1.var_.actorSpriteComps10022 then
				for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_380_5 then
						iter_380_5.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps10022 = nil
			end

			local var_380_8 = arg_377_1.actors_["10092_1"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps10092_1 == nil then
				arg_377_1.var_.actorSpriteComps10092_1 = var_380_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_9 = 2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_9 and not isNil(var_380_8) then
				if arg_377_1.var_.actorSpriteComps10092_1 then
					for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_380_7 then
							if arg_377_1.isInRecall_ then
								iter_380_7.color = Color.New(Mathf.Lerp(iter_380_7.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_9), Mathf.Lerp(iter_380_7.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_9), (Mathf.Lerp(iter_380_7.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_9)))
							else
								local var_380_10 = Mathf.Lerp(iter_380_7.color.r, 1, (arg_377_1.time_ - 0) / var_380_9)

								iter_380_7.color = Color.New(var_380_10, var_380_10, var_380_10)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_9 and arg_377_1.time_ < 0 + var_380_9 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps10092_1 then
				for iter_380_8, iter_380_9 in pairs(arg_377_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_380_9 then
						iter_380_9.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_380_11 = 0
			local var_380_12 = 0.725

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_13 = arg_377_1:GetWordFromCfg(413122093)
				local var_380_14 = arg_377_1:FormatText(var_380_13.content)

				arg_377_1.text_.text = var_380_14

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_16 = 29 <= 0 and var_380_12 or var_380_12 * (utf8.len(var_380_14) / 29)

				if (29 <= 0 and var_380_12 or var_380_12 * (utf8.len(var_380_14) / 29)) > 0 and var_380_12 < var_380_16 then
					arg_377_1.talkMaxDuration = var_380_16

					if var_380_16 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_16 + var_380_11
					end
				end

				arg_377_1.text_.text = var_380_14
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122093", "story_v_out_413122.awb") ~= 0 then
					local var_380_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122093", "story_v_out_413122.awb") / 1000

					if var_380_17 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_11
					end

					if var_380_13.prefab_name ~= "" and arg_377_1.actors_[var_380_13.prefab_name] ~= nil then
						local var_380_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_13.prefab_name].transform, "story_v_out_413122", "413122093", "story_v_out_413122.awb")

						arg_377_1:RecordAudio("413122093", var_380_18)
						arg_377_1:RecordAudio("413122093", var_380_18)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_413122", "413122093", "story_v_out_413122.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_413122", "413122093", "story_v_out_413122.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_19 = math.max(var_380_12, arg_377_1.talkMaxDuration)

			if var_380_11 <= arg_377_1.time_ and arg_377_1.time_ < var_380_11 + var_380_19 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_11) / var_380_19

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_11 + var_380_19 and arg_377_1.time_ < var_380_11 + var_380_19 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play413122094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 413122094
		arg_381_1.duration_ = 3.6

		local var_381_0 = {
			zh = 3.6,
			ja = 2.766
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play413122095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10022"]) and arg_381_1.var_.actorSpriteComps10022 == nil then
				arg_381_1.var_.actorSpriteComps10022 = arg_381_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10022"]) then
				if arg_381_1.var_.actorSpriteComps10022 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								iter_384_1.color = Color.New(Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_0), Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_0), (Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_0)))
							else
								local var_384_1 = Mathf.Lerp(iter_384_1.color.r, 1, (arg_381_1.time_ - 0) / var_384_0)

								iter_384_1.color = Color.New(var_384_1, var_384_1, var_384_1)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10022"]) and arg_381_1.var_.actorSpriteComps10022 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10022 = nil
			end

			local var_384_2 = arg_381_1.actors_["10092_1"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps10092_1 == nil then
				arg_381_1.var_.actorSpriteComps10092_1 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps10092_1 then
					for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_384_5 then
							if arg_381_1.isInRecall_ then
								iter_384_5.color = Color.New(Mathf.Lerp(iter_384_5.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_5.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_5.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_5.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_5.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps10092_1 then
				for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_384_7 then
						iter_384_7.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_384_5 = 0
			local var_384_6 = 0.425

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:GetWordFromCfg(413122094)
				local var_384_8 = arg_381_1:FormatText(var_384_7.content)

				arg_381_1.text_.text = var_384_8

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_10 = 17 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 17)

				if (17 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 17)) > 0 and var_384_6 < var_384_10 then
					arg_381_1.talkMaxDuration = var_384_10

					if var_384_10 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_5
					end
				end

				arg_381_1.text_.text = var_384_8
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122094", "story_v_out_413122.awb") ~= 0 then
					local var_384_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122094", "story_v_out_413122.awb") / 1000

					if var_384_11 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_5
					end

					if var_384_7.prefab_name ~= "" and arg_381_1.actors_[var_384_7.prefab_name] ~= nil then
						local var_384_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_7.prefab_name].transform, "story_v_out_413122", "413122094", "story_v_out_413122.awb")

						arg_381_1:RecordAudio("413122094", var_384_12)
						arg_381_1:RecordAudio("413122094", var_384_12)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_413122", "413122094", "story_v_out_413122.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_413122", "413122094", "story_v_out_413122.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_13 = math.max(var_384_6, arg_381_1.talkMaxDuration)

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_13 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_5) / var_384_13

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_5 + var_384_13 and arg_381_1.time_ < var_384_5 + var_384_13 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play413122095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 413122095
		arg_385_1.duration_ = 10.07

		local var_385_0 = {
			zh = 7.466,
			ja = 10.066
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play413122096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10022"]) and arg_385_1.var_.actorSpriteComps10022 == nil then
				arg_385_1.var_.actorSpriteComps10022 = arg_385_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10022"]) then
				if arg_385_1.var_.actorSpriteComps10022 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 1, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10022"]) and arg_385_1.var_.actorSpriteComps10022 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps10022 = nil
			end

			local var_388_2 = 0
			local var_388_3 = 0.9

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_2 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_4 = arg_385_1:GetWordFromCfg(413122095)
				local var_388_5 = arg_385_1:FormatText(var_388_4.content)

				arg_385_1.text_.text = var_388_5

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_7 = 36 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 36)

				if (36 <= 0 and var_388_3 or var_388_3 * (utf8.len(var_388_5) / 36)) > 0 and var_388_3 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_2
					end
				end

				arg_385_1.text_.text = var_388_5
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122095", "story_v_out_413122.awb") ~= 0 then
					local var_388_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122095", "story_v_out_413122.awb") / 1000

					if var_388_8 + var_388_2 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_2
					end

					if var_388_4.prefab_name ~= "" and arg_385_1.actors_[var_388_4.prefab_name] ~= nil then
						local var_388_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_4.prefab_name].transform, "story_v_out_413122", "413122095", "story_v_out_413122.awb")

						arg_385_1:RecordAudio("413122095", var_388_9)
						arg_385_1:RecordAudio("413122095", var_388_9)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_413122", "413122095", "story_v_out_413122.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_413122", "413122095", "story_v_out_413122.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_3, arg_385_1.talkMaxDuration)

			if var_388_2 <= arg_385_1.time_ and arg_385_1.time_ < var_388_2 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_2) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_2 + var_388_10 and arg_385_1.time_ < var_388_2 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play413122096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 413122096
		arg_389_1.duration_ = 8.6

		local var_389_0 = {
			zh = 5.1,
			ja = 8.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play413122097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10022"]) and arg_389_1.var_.actorSpriteComps10022 == nil then
				arg_389_1.var_.actorSpriteComps10022 = arg_389_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10022"]) then
				if arg_389_1.var_.actorSpriteComps10022 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 1, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10022"]) and arg_389_1.var_.actorSpriteComps10022 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps10022 = nil
			end

			local var_392_2 = 0
			local var_392_3 = 0.65

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(413122096)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 26 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 26)

				if (26 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 26)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122096", "story_v_out_413122.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122096", "story_v_out_413122.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_out_413122", "413122096", "story_v_out_413122.awb")

						arg_389_1:RecordAudio("413122096", var_392_9)
						arg_389_1:RecordAudio("413122096", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_413122", "413122096", "story_v_out_413122.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_413122", "413122096", "story_v_out_413122.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play413122097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 413122097
		arg_393_1.duration_ = 7.6

		local var_393_0 = {
			zh = 6.266,
			ja = 7.6
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play413122098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos10092_1 = arg_393_1.actors_["10092_1"].transform.localPosition
				arg_393_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_396_0 = 0, arg_393_1.actors_["10092_1"].transform.childCount - 1 do
					local var_396_0 = arg_393_1.actors_["10092_1"].transform:GetChild(iter_396_0)

					if var_396_0.name == "split_8" or not string.find(var_396_0.name, "split") then
						var_396_0.gameObject:SetActive(true)
					else
						var_396_0.gameObject:SetActive(false)
					end
				end
			end

			local var_396_1 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_1 then
				arg_393_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_393_1.time_ - 0) / var_396_1)
			end

			if arg_393_1.time_ >= 0 + var_396_1 and arg_393_1.time_ < 0 + var_396_1 + arg_396_0 then
				arg_393_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_396_2 = arg_393_1.actors_["10022"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps10022 == nil then
				arg_393_1.var_.actorSpriteComps10022 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps10022 then
					for iter_396_1, iter_396_2 in pairs(arg_393_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_396_2 then
							if arg_393_1.isInRecall_ then
								iter_396_2.color = Color.New(Mathf.Lerp(iter_396_2.color.r, arg_393_1.hightColor2.r, (arg_393_1.time_ - 0) / var_396_3), Mathf.Lerp(iter_396_2.color.g, arg_393_1.hightColor2.g, (arg_393_1.time_ - 0) / var_396_3), (Mathf.Lerp(iter_396_2.color.b, arg_393_1.hightColor2.b, (arg_393_1.time_ - 0) / var_396_3)))
							else
								local var_396_4 = Mathf.Lerp(iter_396_2.color.r, 0.5, (arg_393_1.time_ - 0) / var_396_3)

								iter_396_2.color = Color.New(var_396_4, var_396_4, var_396_4)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps10022 then
				for iter_396_3, iter_396_4 in pairs(arg_393_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_396_4 then
						iter_396_4.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_393_1.var_.actorSpriteComps10022 = nil
			end

			local var_396_5 = arg_393_1.actors_["10092_1"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_5) and arg_393_1.var_.actorSpriteComps10092_1 == nil then
				arg_393_1.var_.actorSpriteComps10092_1 = var_396_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_6 = 2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_6 and not isNil(var_396_5) then
				if arg_393_1.var_.actorSpriteComps10092_1 then
					for iter_396_5, iter_396_6 in pairs(arg_393_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_396_6 then
							if arg_393_1.isInRecall_ then
								iter_396_6.color = Color.New(Mathf.Lerp(iter_396_6.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_6), Mathf.Lerp(iter_396_6.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_6), (Mathf.Lerp(iter_396_6.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_6)))
							else
								local var_396_7 = Mathf.Lerp(iter_396_6.color.r, 1, (arg_393_1.time_ - 0) / var_396_6)

								iter_396_6.color = Color.New(var_396_7, var_396_7, var_396_7)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_6 and arg_393_1.time_ < 0 + var_396_6 + arg_396_0 and not isNil(var_396_5) and arg_393_1.var_.actorSpriteComps10092_1 then
				for iter_396_7, iter_396_8 in pairs(arg_393_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_396_8 then
						iter_396_8.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_396_8 = 0
			local var_396_9 = 0.8

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_8 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_10 = arg_393_1:GetWordFromCfg(413122097)
				local var_396_11 = arg_393_1:FormatText(var_396_10.content)

				arg_393_1.text_.text = var_396_11

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_13 = 32 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 32)

				if (32 <= 0 and var_396_9 or var_396_9 * (utf8.len(var_396_11) / 32)) > 0 and var_396_9 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_8
					end
				end

				arg_393_1.text_.text = var_396_11
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122097", "story_v_out_413122.awb") ~= 0 then
					local var_396_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122097", "story_v_out_413122.awb") / 1000

					if var_396_14 + var_396_8 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_14 + var_396_8
					end

					if var_396_10.prefab_name ~= "" and arg_393_1.actors_[var_396_10.prefab_name] ~= nil then
						local var_396_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_10.prefab_name].transform, "story_v_out_413122", "413122097", "story_v_out_413122.awb")

						arg_393_1:RecordAudio("413122097", var_396_15)
						arg_393_1:RecordAudio("413122097", var_396_15)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_413122", "413122097", "story_v_out_413122.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_413122", "413122097", "story_v_out_413122.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_16 = math.max(var_396_9, arg_393_1.talkMaxDuration)

			if var_396_8 <= arg_393_1.time_ and arg_393_1.time_ < var_396_8 + var_396_16 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_8) / var_396_16

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_8 + var_396_16 and arg_393_1.time_ < var_396_8 + var_396_16 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play413122098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 413122098
		arg_397_1.duration_ = 7.23

		local var_397_0 = {
			zh = 5.8,
			ja = 7.233
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play413122099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10022 = arg_397_1.actors_["10022"].transform.localPosition
				arg_397_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10022", 2)

				for iter_400_0 = 0, arg_397_1.actors_["10022"].transform.childCount - 1 do
					local var_400_0 = arg_397_1.actors_["10022"].transform:GetChild(iter_400_0)

					if var_400_0.name == "split_6" or not string.find(var_400_0.name, "split") then
						var_400_0.gameObject:SetActive(true)
					else
						var_400_0.gameObject:SetActive(false)
					end
				end
			end

			local var_400_1 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_397_1.time_ - 0) / var_400_1)
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_400_2 = arg_397_1.actors_["10022"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10022 == nil then
				arg_397_1.var_.actorSpriteComps10022 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps10022 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								iter_400_2.color = Color.New(Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_2.color.r, 1, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_2.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10022 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_400_4 then
						iter_400_4.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10022 = nil
			end

			local var_400_5 = arg_397_1.actors_["10092_1"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.actorSpriteComps10092_1 == nil then
				arg_397_1.var_.actorSpriteComps10092_1 = var_400_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_6 = 2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_6 and not isNil(var_400_5) then
				if arg_397_1.var_.actorSpriteComps10092_1 then
					for iter_400_5, iter_400_6 in pairs(arg_397_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_400_6 then
							if arg_397_1.isInRecall_ then
								iter_400_6.color = Color.New(Mathf.Lerp(iter_400_6.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_6), Mathf.Lerp(iter_400_6.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_6), (Mathf.Lerp(iter_400_6.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_6)))
							else
								local var_400_7 = Mathf.Lerp(iter_400_6.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_6)

								iter_400_6.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_6 and arg_397_1.time_ < 0 + var_400_6 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.actorSpriteComps10092_1 then
				for iter_400_7, iter_400_8 in pairs(arg_397_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_400_8 then
						iter_400_8.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_400_8 = 0
			local var_400_9 = 0.8

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:GetWordFromCfg(413122098)
				local var_400_11 = arg_397_1:FormatText(var_400_10.content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_13 = 32 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 32)

				if (32 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 32)) > 0 and var_400_9 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122098", "story_v_out_413122.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122098", "story_v_out_413122.awb") / 1000

					if var_400_14 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_8
					end

					if var_400_10.prefab_name ~= "" and arg_397_1.actors_[var_400_10.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_10.prefab_name].transform, "story_v_out_413122", "413122098", "story_v_out_413122.awb")

						arg_397_1:RecordAudio("413122098", var_400_15)
						arg_397_1:RecordAudio("413122098", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_413122", "413122098", "story_v_out_413122.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_413122", "413122098", "story_v_out_413122.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_16 and arg_397_1.time_ < var_400_8 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play413122099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 413122099
		arg_401_1.duration_ = 7.27

		local var_401_0 = {
			zh = 5.966,
			ja = 7.266
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play413122100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10022 = arg_401_1.actors_["10022"].transform.localPosition
				arg_401_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10022", 2)

				for iter_404_0 = 0, arg_401_1.actors_["10022"].transform.childCount - 1 do
					local var_404_0 = arg_401_1.actors_["10022"].transform:GetChild(iter_404_0)

					if var_404_0.name == "split_2" or not string.find(var_404_0.name, "split") then
						var_404_0.gameObject:SetActive(true)
					else
						var_404_0.gameObject:SetActive(false)
					end
				end
			end

			local var_404_1 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				arg_401_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_401_1.time_ - 0) / var_404_1)
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 then
				arg_401_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_404_2 = arg_401_1.actors_["10022"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10022 == nil then
				arg_401_1.var_.actorSpriteComps10022 = var_404_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_3 = 2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 and not isNil(var_404_2) then
				if arg_401_1.var_.actorSpriteComps10022 then
					for iter_404_1, iter_404_2 in pairs(arg_401_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_404_2 then
							if arg_401_1.isInRecall_ then
								iter_404_2.color = Color.New(Mathf.Lerp(iter_404_2.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_3), Mathf.Lerp(iter_404_2.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_3), (Mathf.Lerp(iter_404_2.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_3)))
							else
								local var_404_4 = Mathf.Lerp(iter_404_2.color.r, 1, (arg_401_1.time_ - 0) / var_404_3)

								iter_404_2.color = Color.New(var_404_4, var_404_4, var_404_4)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps10022 then
				for iter_404_3, iter_404_4 in pairs(arg_401_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_404_4 then
						iter_404_4.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps10022 = nil
			end

			local var_404_5 = 0
			local var_404_6 = 0.9

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:GetWordFromCfg(413122099)
				local var_404_8 = arg_401_1:FormatText(var_404_7.content)

				arg_401_1.text_.text = var_404_8

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_10 = 36 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 36)

				if (36 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 36)) > 0 and var_404_6 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10

					if var_404_10 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_8
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122099", "story_v_out_413122.awb") ~= 0 then
					local var_404_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122099", "story_v_out_413122.awb") / 1000

					if var_404_11 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_5
					end

					if var_404_7.prefab_name ~= "" and arg_401_1.actors_[var_404_7.prefab_name] ~= nil then
						local var_404_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_7.prefab_name].transform, "story_v_out_413122", "413122099", "story_v_out_413122.awb")

						arg_401_1:RecordAudio("413122099", var_404_12)
						arg_401_1:RecordAudio("413122099", var_404_12)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_413122", "413122099", "story_v_out_413122.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_413122", "413122099", "story_v_out_413122.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_13 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_13 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_13

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_13 and arg_401_1.time_ < var_404_5 + var_404_13 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play413122100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 413122100
		arg_405_1.duration_ = 15.93

		local var_405_0 = {
			zh = 5.5,
			ja = 15.933
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play413122101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10092_1 = arg_405_1.actors_["10092_1"].transform.localPosition
				arg_405_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_408_0 = 0, arg_405_1.actors_["10092_1"].transform.childCount - 1 do
					local var_408_0 = arg_405_1.actors_["10092_1"].transform:GetChild(iter_408_0)

					if var_408_0.name == "split_8" or not string.find(var_408_0.name, "split") then
						var_408_0.gameObject:SetActive(true)
					else
						var_408_0.gameObject:SetActive(false)
					end
				end
			end

			local var_408_1 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 then
				arg_405_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_405_1.time_ - 0) / var_408_1)
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 then
				arg_405_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_408_2 = arg_405_1.actors_["10022"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps10022 == nil then
				arg_405_1.var_.actorSpriteComps10022 = var_408_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_3 = 2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_3 and not isNil(var_408_2) then
				if arg_405_1.var_.actorSpriteComps10022 then
					for iter_408_1, iter_408_2 in pairs(arg_405_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_408_2 then
							if arg_405_1.isInRecall_ then
								iter_408_2.color = Color.New(Mathf.Lerp(iter_408_2.color.r, arg_405_1.hightColor2.r, (arg_405_1.time_ - 0) / var_408_3), Mathf.Lerp(iter_408_2.color.g, arg_405_1.hightColor2.g, (arg_405_1.time_ - 0) / var_408_3), (Mathf.Lerp(iter_408_2.color.b, arg_405_1.hightColor2.b, (arg_405_1.time_ - 0) / var_408_3)))
							else
								local var_408_4 = Mathf.Lerp(iter_408_2.color.r, 0.5, (arg_405_1.time_ - 0) / var_408_3)

								iter_408_2.color = Color.New(var_408_4, var_408_4, var_408_4)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_3 and arg_405_1.time_ < 0 + var_408_3 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps10022 then
				for iter_408_3, iter_408_4 in pairs(arg_405_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_408_4 then
						iter_408_4.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_405_1.var_.actorSpriteComps10022 = nil
			end

			local var_408_5 = arg_405_1.actors_["10092_1"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.actorSpriteComps10092_1 == nil then
				arg_405_1.var_.actorSpriteComps10092_1 = var_408_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_6 = 2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_6 and not isNil(var_408_5) then
				if arg_405_1.var_.actorSpriteComps10092_1 then
					for iter_408_5, iter_408_6 in pairs(arg_405_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_408_6 then
							if arg_405_1.isInRecall_ then
								iter_408_6.color = Color.New(Mathf.Lerp(iter_408_6.color.r, arg_405_1.hightColor1.r, (arg_405_1.time_ - 0) / var_408_6), Mathf.Lerp(iter_408_6.color.g, arg_405_1.hightColor1.g, (arg_405_1.time_ - 0) / var_408_6), (Mathf.Lerp(iter_408_6.color.b, arg_405_1.hightColor1.b, (arg_405_1.time_ - 0) / var_408_6)))
							else
								local var_408_7 = Mathf.Lerp(iter_408_6.color.r, 1, (arg_405_1.time_ - 0) / var_408_6)

								iter_408_6.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_6 and arg_405_1.time_ < 0 + var_408_6 + arg_408_0 and not isNil(var_408_5) and arg_405_1.var_.actorSpriteComps10092_1 then
				for iter_408_7, iter_408_8 in pairs(arg_405_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_408_8 then
						iter_408_8.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_405_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_408_8 = 0
			local var_408_9 = 0.8

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(413122100)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_13 = 32 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 32)

				if (32 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 32)) > 0 and var_408_9 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122100", "story_v_out_413122.awb") ~= 0 then
					local var_408_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122100", "story_v_out_413122.awb") / 1000

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end

					if var_408_10.prefab_name ~= "" and arg_405_1.actors_[var_408_10.prefab_name] ~= nil then
						local var_408_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_10.prefab_name].transform, "story_v_out_413122", "413122100", "story_v_out_413122.awb")

						arg_405_1:RecordAudio("413122100", var_408_15)
						arg_405_1:RecordAudio("413122100", var_408_15)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_413122", "413122100", "story_v_out_413122.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_413122", "413122100", "story_v_out_413122.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_16 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_16 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_16

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_16 and arg_405_1.time_ < var_408_8 + var_408_16 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play413122101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 413122101
		arg_409_1.duration_ = 9.27

		local var_409_0 = {
			zh = 5.833,
			ja = 9.266
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
				arg_409_0:Play413122102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10092_1"]) and arg_409_1.var_.actorSpriteComps10092_1 == nil then
				arg_409_1.var_.actorSpriteComps10092_1 = arg_409_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10092_1"]) then
				if arg_409_1.var_.actorSpriteComps10092_1 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 1, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10092_1"]) and arg_409_1.var_.actorSpriteComps10092_1 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_412_2 = 0
			local var_412_3 = 0.875

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(413122101)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 35 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 35)

				if (35 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 35)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122101", "story_v_out_413122.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122101", "story_v_out_413122.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_out_413122", "413122101", "story_v_out_413122.awb")

						arg_409_1:RecordAudio("413122101", var_412_9)
						arg_409_1:RecordAudio("413122101", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_413122", "413122101", "story_v_out_413122.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_413122", "413122101", "story_v_out_413122.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play413122102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 413122102
		arg_413_1.duration_ = 15.13

		local var_413_0 = {
			zh = 7.033,
			ja = 15.133
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
				arg_413_0:Play413122103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.8

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
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

				local var_416_1 = arg_413_1:GetWordFromCfg(413122102)
				local var_416_2 = arg_413_1:FormatText(var_416_1.content)

				arg_413_1.text_.text = var_416_2

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 32)

				if (32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 32)) > 0 and var_416_0 < var_416_4 then
					arg_413_1.talkMaxDuration = var_416_4

					if var_416_4 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_4 + 0
					end
				end

				arg_413_1.text_.text = var_416_2
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122102", "story_v_out_413122.awb") ~= 0 then
					local var_416_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122102", "story_v_out_413122.awb") / 1000

					if var_416_5 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + 0
					end

					if var_416_1.prefab_name ~= "" and arg_413_1.actors_[var_416_1.prefab_name] ~= nil then
						local var_416_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_1.prefab_name].transform, "story_v_out_413122", "413122102", "story_v_out_413122.awb")

						arg_413_1:RecordAudio("413122102", var_416_6)
						arg_413_1:RecordAudio("413122102", var_416_6)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_413122", "413122102", "story_v_out_413122.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_413122", "413122102", "story_v_out_413122.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play413122103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 413122103
		arg_417_1.duration_ = 12.03

		local var_417_0 = {
			zh = 7.6,
			ja = 12.033
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
				arg_417_0:Play413122104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10092_1"]) and arg_417_1.var_.actorSpriteComps10092_1 == nil then
				arg_417_1.var_.actorSpriteComps10092_1 = arg_417_1.actors_["10092_1"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10092_1"]) then
				if arg_417_1.var_.actorSpriteComps10092_1 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 1, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10092_1"]) and arg_417_1.var_.actorSpriteComps10092_1 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_420_2 = 0
			local var_420_3 = 0.925

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_2 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:GetWordFromCfg(413122103)
				local var_420_5 = arg_417_1:FormatText(var_420_4.content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 37 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 37)

				if (37 <= 0 and var_420_3 or var_420_3 * (utf8.len(var_420_5) / 37)) > 0 and var_420_3 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_2
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122103", "story_v_out_413122.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122103", "story_v_out_413122.awb") / 1000

					if var_420_8 + var_420_2 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_2
					end

					if var_420_4.prefab_name ~= "" and arg_417_1.actors_[var_420_4.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_4.prefab_name].transform, "story_v_out_413122", "413122103", "story_v_out_413122.awb")

						arg_417_1:RecordAudio("413122103", var_420_9)
						arg_417_1:RecordAudio("413122103", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_413122", "413122103", "story_v_out_413122.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_413122", "413122103", "story_v_out_413122.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_3, arg_417_1.talkMaxDuration)

			if var_420_2 <= arg_417_1.time_ and arg_417_1.time_ < var_420_2 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_2) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_2 + var_420_10 and arg_417_1.time_ < var_420_2 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play413122104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 413122104
		arg_421_1.duration_ = 13.17

		local var_421_0 = {
			zh = 7,
			ja = 13.166
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play413122105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos10022 = arg_421_1.actors_["10022"].transform.localPosition
				arg_421_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_421_1:CheckSpriteTmpPos("10022", 2)

				for iter_424_0 = 0, arg_421_1.actors_["10022"].transform.childCount - 1 do
					local var_424_0 = arg_421_1.actors_["10022"].transform:GetChild(iter_424_0)

					if var_424_0.name == "split_6" or not string.find(var_424_0.name, "split") then
						var_424_0.gameObject:SetActive(true)
					else
						var_424_0.gameObject:SetActive(false)
					end
				end
			end

			local var_424_1 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_1 then
				arg_421_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_421_1.time_ - 0) / var_424_1)
			end

			if arg_421_1.time_ >= 0 + var_424_1 and arg_421_1.time_ < 0 + var_424_1 + arg_424_0 then
				arg_421_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_424_2 = arg_421_1.actors_["10022"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps10022 == nil then
				arg_421_1.var_.actorSpriteComps10022 = var_424_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_3 = 2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_3 and not isNil(var_424_2) then
				if arg_421_1.var_.actorSpriteComps10022 then
					for iter_424_1, iter_424_2 in pairs(arg_421_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_424_2 then
							if arg_421_1.isInRecall_ then
								iter_424_2.color = Color.New(Mathf.Lerp(iter_424_2.color.r, arg_421_1.hightColor1.r, (arg_421_1.time_ - 0) / var_424_3), Mathf.Lerp(iter_424_2.color.g, arg_421_1.hightColor1.g, (arg_421_1.time_ - 0) / var_424_3), (Mathf.Lerp(iter_424_2.color.b, arg_421_1.hightColor1.b, (arg_421_1.time_ - 0) / var_424_3)))
							else
								local var_424_4 = Mathf.Lerp(iter_424_2.color.r, 1, (arg_421_1.time_ - 0) / var_424_3)

								iter_424_2.color = Color.New(var_424_4, var_424_4, var_424_4)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_3 and arg_421_1.time_ < 0 + var_424_3 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps10022 then
				for iter_424_3, iter_424_4 in pairs(arg_421_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_424_4 then
						iter_424_4.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_421_1.var_.actorSpriteComps10022 = nil
			end

			local var_424_5 = arg_421_1.actors_["10092_1"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.actorSpriteComps10092_1 == nil then
				arg_421_1.var_.actorSpriteComps10092_1 = var_424_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_6 = 2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_6 and not isNil(var_424_5) then
				if arg_421_1.var_.actorSpriteComps10092_1 then
					for iter_424_5, iter_424_6 in pairs(arg_421_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_424_6 then
							if arg_421_1.isInRecall_ then
								iter_424_6.color = Color.New(Mathf.Lerp(iter_424_6.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_6), Mathf.Lerp(iter_424_6.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_6), (Mathf.Lerp(iter_424_6.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_6)))
							else
								local var_424_7 = Mathf.Lerp(iter_424_6.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_6)

								iter_424_6.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_6 and arg_421_1.time_ < 0 + var_424_6 + arg_424_0 and not isNil(var_424_5) and arg_421_1.var_.actorSpriteComps10092_1 then
				for iter_424_7, iter_424_8 in pairs(arg_421_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_424_8 then
						iter_424_8.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_424_8 = 0
			local var_424_9 = 0.925

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_10 = arg_421_1:GetWordFromCfg(413122104)
				local var_424_11 = arg_421_1:FormatText(var_424_10.content)

				arg_421_1.text_.text = var_424_11

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_13 = 37 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 37)

				if (37 <= 0 and var_424_9 or var_424_9 * (utf8.len(var_424_11) / 37)) > 0 and var_424_9 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_8
					end
				end

				arg_421_1.text_.text = var_424_11
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122104", "story_v_out_413122.awb") ~= 0 then
					local var_424_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122104", "story_v_out_413122.awb") / 1000

					if var_424_14 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_14 + var_424_8
					end

					if var_424_10.prefab_name ~= "" and arg_421_1.actors_[var_424_10.prefab_name] ~= nil then
						local var_424_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_10.prefab_name].transform, "story_v_out_413122", "413122104", "story_v_out_413122.awb")

						arg_421_1:RecordAudio("413122104", var_424_15)
						arg_421_1:RecordAudio("413122104", var_424_15)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_413122", "413122104", "story_v_out_413122.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_413122", "413122104", "story_v_out_413122.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_16 = math.max(var_424_9, arg_421_1.talkMaxDuration)

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_16 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_8) / var_424_16

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_8 + var_424_16 and arg_421_1.time_ < var_424_8 + var_424_16 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play413122105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 413122105
		arg_425_1.duration_ = 12.93

		local var_425_0 = {
			zh = 7.666,
			ja = 12.933
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play413122106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10022"]) and arg_425_1.var_.actorSpriteComps10022 == nil then
				arg_425_1.var_.actorSpriteComps10022 = arg_425_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["10022"]) then
				if arg_425_1.var_.actorSpriteComps10022 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor2.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor2.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor2.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 0.5, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["10022"]) and arg_425_1.var_.actorSpriteComps10022 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_425_1.var_.actorSpriteComps10022 = nil
			end

			local var_428_2 = arg_425_1.actors_["10092_1"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_2) and arg_425_1.var_.actorSpriteComps10092_1 == nil then
				arg_425_1.var_.actorSpriteComps10092_1 = var_428_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_3 = 2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_3 and not isNil(var_428_2) then
				if arg_425_1.var_.actorSpriteComps10092_1 then
					for iter_428_4, iter_428_5 in pairs(arg_425_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_428_5 then
							if arg_425_1.isInRecall_ then
								iter_428_5.color = Color.New(Mathf.Lerp(iter_428_5.color.r, arg_425_1.hightColor1.r, (arg_425_1.time_ - 0) / var_428_3), Mathf.Lerp(iter_428_5.color.g, arg_425_1.hightColor1.g, (arg_425_1.time_ - 0) / var_428_3), (Mathf.Lerp(iter_428_5.color.b, arg_425_1.hightColor1.b, (arg_425_1.time_ - 0) / var_428_3)))
							else
								local var_428_4 = Mathf.Lerp(iter_428_5.color.r, 1, (arg_425_1.time_ - 0) / var_428_3)

								iter_428_5.color = Color.New(var_428_4, var_428_4, var_428_4)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_3 and arg_425_1.time_ < 0 + var_428_3 + arg_428_0 and not isNil(var_428_2) and arg_425_1.var_.actorSpriteComps10092_1 then
				for iter_428_6, iter_428_7 in pairs(arg_425_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_428_7 then
						iter_428_7.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_425_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_428_5 = arg_425_1.actors_["10092_1"].transform

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos10092_1 = var_428_5.localPosition
				var_428_5.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_428_8 = 0, var_428_5.childCount - 1 do
					local var_428_6 = var_428_5:GetChild(iter_428_8)

					if var_428_6.name == "split_1_1" or not string.find(var_428_6.name, "split") then
						var_428_6.gameObject:SetActive(true)
					else
						var_428_6.gameObject:SetActive(false)
					end
				end
			end

			local var_428_7 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				var_428_5.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_425_1.time_ - 0) / var_428_7)
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				var_428_5.localPosition = Vector3.New(390, -300, -295)
			end

			local var_428_8 = 0
			local var_428_9 = 1.15

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_10 = arg_425_1:GetWordFromCfg(413122105)
				local var_428_11 = arg_425_1:FormatText(var_428_10.content)

				arg_425_1.text_.text = var_428_11

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_13 = 46 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 46)

				if (46 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 46)) > 0 and var_428_9 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_8
					end
				end

				arg_425_1.text_.text = var_428_11
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122105", "story_v_out_413122.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122105", "story_v_out_413122.awb") / 1000

					if var_428_14 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_8
					end

					if var_428_10.prefab_name ~= "" and arg_425_1.actors_[var_428_10.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_10.prefab_name].transform, "story_v_out_413122", "413122105", "story_v_out_413122.awb")

						arg_425_1:RecordAudio("413122105", var_428_15)
						arg_425_1:RecordAudio("413122105", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_413122", "413122105", "story_v_out_413122.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_413122", "413122105", "story_v_out_413122.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_9, arg_425_1.talkMaxDuration)

			if var_428_8 <= arg_425_1.time_ and arg_425_1.time_ < var_428_8 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_8) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_8 + var_428_16 and arg_425_1.time_ < var_428_8 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play413122106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 413122106
		arg_429_1.duration_ = 3.37

		local var_429_0 = {
			zh = 2.733,
			ja = 3.366
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play413122107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10022"]) and arg_429_1.var_.actorSpriteComps10022 == nil then
				arg_429_1.var_.actorSpriteComps10022 = arg_429_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["10022"]) then
				if arg_429_1.var_.actorSpriteComps10022 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								iter_432_1.color = Color.New(Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor1.r, (arg_429_1.time_ - 0) / var_432_0), Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor1.g, (arg_429_1.time_ - 0) / var_432_0), (Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor1.b, (arg_429_1.time_ - 0) / var_432_0)))
							else
								local var_432_1 = Mathf.Lerp(iter_432_1.color.r, 1, (arg_429_1.time_ - 0) / var_432_0)

								iter_432_1.color = Color.New(var_432_1, var_432_1, var_432_1)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["10022"]) and arg_429_1.var_.actorSpriteComps10022 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_429_1.var_.actorSpriteComps10022 = nil
			end

			local var_432_2 = arg_429_1.actors_["10092_1"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.actorSpriteComps10092_1 == nil then
				arg_429_1.var_.actorSpriteComps10092_1 = var_432_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_3 = 2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_3 and not isNil(var_432_2) then
				if arg_429_1.var_.actorSpriteComps10092_1 then
					for iter_432_4, iter_432_5 in pairs(arg_429_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_432_5 then
							if arg_429_1.isInRecall_ then
								iter_432_5.color = Color.New(Mathf.Lerp(iter_432_5.color.r, arg_429_1.hightColor2.r, (arg_429_1.time_ - 0) / var_432_3), Mathf.Lerp(iter_432_5.color.g, arg_429_1.hightColor2.g, (arg_429_1.time_ - 0) / var_432_3), (Mathf.Lerp(iter_432_5.color.b, arg_429_1.hightColor2.b, (arg_429_1.time_ - 0) / var_432_3)))
							else
								local var_432_4 = Mathf.Lerp(iter_432_5.color.r, 0.5, (arg_429_1.time_ - 0) / var_432_3)

								iter_432_5.color = Color.New(var_432_4, var_432_4, var_432_4)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_3 and arg_429_1.time_ < 0 + var_432_3 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.actorSpriteComps10092_1 then
				for iter_432_6, iter_432_7 in pairs(arg_429_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_432_7 then
						iter_432_7.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_429_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_432_5 = 0
			local var_432_6 = 0.375

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_7 = arg_429_1:GetWordFromCfg(413122106)
				local var_432_8 = arg_429_1:FormatText(var_432_7.content)

				arg_429_1.text_.text = var_432_8

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_10 = 15 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 15)

				if (15 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 15)) > 0 and var_432_6 < var_432_10 then
					arg_429_1.talkMaxDuration = var_432_10

					if var_432_10 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_5
					end
				end

				arg_429_1.text_.text = var_432_8
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122106", "story_v_out_413122.awb") ~= 0 then
					local var_432_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122106", "story_v_out_413122.awb") / 1000

					if var_432_11 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_5
					end

					if var_432_7.prefab_name ~= "" and arg_429_1.actors_[var_432_7.prefab_name] ~= nil then
						local var_432_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_7.prefab_name].transform, "story_v_out_413122", "413122106", "story_v_out_413122.awb")

						arg_429_1:RecordAudio("413122106", var_432_12)
						arg_429_1:RecordAudio("413122106", var_432_12)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_413122", "413122106", "story_v_out_413122.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_413122", "413122106", "story_v_out_413122.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_13 = math.max(var_432_6, arg_429_1.talkMaxDuration)

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_13 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_5) / var_432_13

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_5 + var_432_13 and arg_429_1.time_ < var_432_5 + var_432_13 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play413122107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 413122107
		arg_433_1.duration_ = 15.1

		local var_433_0 = {
			zh = 10.7,
			ja = 15.1
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
				arg_433_0:Play413122108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10022 = arg_433_1.actors_["10022"].transform.localPosition
				arg_433_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10022", 2)

				for iter_436_0 = 0, arg_433_1.actors_["10022"].transform.childCount - 1 do
					local var_436_0 = arg_433_1.actors_["10022"].transform:GetChild(iter_436_0)

					if var_436_0.name == "" or not string.find(var_436_0.name, "split") then
						var_436_0.gameObject:SetActive(true)
					else
						var_436_0.gameObject:SetActive(false)
					end
				end
			end

			local var_436_1 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_1 then
				arg_433_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_433_1.time_ - 0) / var_436_1)
			end

			if arg_433_1.time_ >= 0 + var_436_1 and arg_433_1.time_ < 0 + var_436_1 + arg_436_0 then
				arg_433_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_436_2 = arg_433_1.actors_["10092_1"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10092_1 = var_436_2.localPosition
				var_436_2.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_436_1 = 0, var_436_2.childCount - 1 do
					local var_436_3 = var_436_2:GetChild(iter_436_1)

					if var_436_3.name == "split_1_1" or not string.find(var_436_3.name, "split") then
						var_436_3.gameObject:SetActive(true)
					else
						var_436_3.gameObject:SetActive(false)
					end
				end
			end

			local var_436_4 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				var_436_2.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_433_1.time_ - 0) / var_436_4)
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				var_436_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_436_5 = arg_433_1.actors_["10022"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_5) and arg_433_1.var_.actorSpriteComps10022 == nil then
				arg_433_1.var_.actorSpriteComps10022 = var_436_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_6 = 2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_6 and not isNil(var_436_5) then
				if arg_433_1.var_.actorSpriteComps10022 then
					for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_436_3 then
							if arg_433_1.isInRecall_ then
								iter_436_3.color = Color.New(Mathf.Lerp(iter_436_3.color.r, arg_433_1.hightColor2.r, (arg_433_1.time_ - 0) / var_436_6), Mathf.Lerp(iter_436_3.color.g, arg_433_1.hightColor2.g, (arg_433_1.time_ - 0) / var_436_6), (Mathf.Lerp(iter_436_3.color.b, arg_433_1.hightColor2.b, (arg_433_1.time_ - 0) / var_436_6)))
							else
								local var_436_7 = Mathf.Lerp(iter_436_3.color.r, 0.5, (arg_433_1.time_ - 0) / var_436_6)

								iter_436_3.color = Color.New(var_436_7, var_436_7, var_436_7)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_6 and arg_433_1.time_ < 0 + var_436_6 + arg_436_0 and not isNil(var_436_5) and arg_433_1.var_.actorSpriteComps10022 then
				for iter_436_4, iter_436_5 in pairs(arg_433_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_436_5 then
						iter_436_5.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_433_1.var_.actorSpriteComps10022 = nil
			end

			local var_436_8 = arg_433_1.actors_["10092_1"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_8) and arg_433_1.var_.actorSpriteComps10092_1 == nil then
				arg_433_1.var_.actorSpriteComps10092_1 = var_436_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_9 = 2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_9 and not isNil(var_436_8) then
				if arg_433_1.var_.actorSpriteComps10092_1 then
					for iter_436_6, iter_436_7 in pairs(arg_433_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_436_7 then
							if arg_433_1.isInRecall_ then
								iter_436_7.color = Color.New(Mathf.Lerp(iter_436_7.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_9), Mathf.Lerp(iter_436_7.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_9), (Mathf.Lerp(iter_436_7.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_9)))
							else
								local var_436_10 = Mathf.Lerp(iter_436_7.color.r, 1, (arg_433_1.time_ - 0) / var_436_9)

								iter_436_7.color = Color.New(var_436_10, var_436_10, var_436_10)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_9 and arg_433_1.time_ < 0 + var_436_9 + arg_436_0 and not isNil(var_436_8) and arg_433_1.var_.actorSpriteComps10092_1 then
				for iter_436_8, iter_436_9 in pairs(arg_433_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_436_9 then
						iter_436_9.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_436_11 = 0
			local var_436_12 = 1.225

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_11 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_13 = arg_433_1:GetWordFromCfg(413122107)
				local var_436_14 = arg_433_1:FormatText(var_436_13.content)

				arg_433_1.text_.text = var_436_14

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_16 = 49 <= 0 and var_436_12 or var_436_12 * (utf8.len(var_436_14) / 49)

				if (49 <= 0 and var_436_12 or var_436_12 * (utf8.len(var_436_14) / 49)) > 0 and var_436_12 < var_436_16 then
					arg_433_1.talkMaxDuration = var_436_16

					if var_436_16 + var_436_11 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_16 + var_436_11
					end
				end

				arg_433_1.text_.text = var_436_14
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122107", "story_v_out_413122.awb") ~= 0 then
					local var_436_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122107", "story_v_out_413122.awb") / 1000

					if var_436_17 + var_436_11 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_17 + var_436_11
					end

					if var_436_13.prefab_name ~= "" and arg_433_1.actors_[var_436_13.prefab_name] ~= nil then
						local var_436_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_13.prefab_name].transform, "story_v_out_413122", "413122107", "story_v_out_413122.awb")

						arg_433_1:RecordAudio("413122107", var_436_18)
						arg_433_1:RecordAudio("413122107", var_436_18)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_413122", "413122107", "story_v_out_413122.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_413122", "413122107", "story_v_out_413122.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_19 = math.max(var_436_12, arg_433_1.talkMaxDuration)

			if var_436_11 <= arg_433_1.time_ and arg_433_1.time_ < var_436_11 + var_436_19 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_11) / var_436_19

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_11 + var_436_19 and arg_433_1.time_ < var_436_11 + var_436_19 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 413122108
		arg_437_1.duration_ = 2.7

		local var_437_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_437_0:Play413122109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10022"]) and arg_437_1.var_.actorSpriteComps10022 == nil then
				arg_437_1.var_.actorSpriteComps10022 = arg_437_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_0 = 2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10022"]) then
				if arg_437_1.var_.actorSpriteComps10022 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								iter_440_1.color = Color.New(Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor1.r, (arg_437_1.time_ - 0) / var_440_0), Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor1.g, (arg_437_1.time_ - 0) / var_440_0), (Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor1.b, (arg_437_1.time_ - 0) / var_440_0)))
							else
								local var_440_1 = Mathf.Lerp(iter_440_1.color.r, 1, (arg_437_1.time_ - 0) / var_440_0)

								iter_440_1.color = Color.New(var_440_1, var_440_1, var_440_1)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10022"]) and arg_437_1.var_.actorSpriteComps10022 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_440_3 then
						iter_440_3.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_437_1.var_.actorSpriteComps10022 = nil
			end

			local var_440_2 = arg_437_1.actors_["10092_1"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.actorSpriteComps10092_1 == nil then
				arg_437_1.var_.actorSpriteComps10092_1 = var_440_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_3 = 2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_3 and not isNil(var_440_2) then
				if arg_437_1.var_.actorSpriteComps10092_1 then
					for iter_440_4, iter_440_5 in pairs(arg_437_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_440_5 then
							if arg_437_1.isInRecall_ then
								iter_440_5.color = Color.New(Mathf.Lerp(iter_440_5.color.r, arg_437_1.hightColor2.r, (arg_437_1.time_ - 0) / var_440_3), Mathf.Lerp(iter_440_5.color.g, arg_437_1.hightColor2.g, (arg_437_1.time_ - 0) / var_440_3), (Mathf.Lerp(iter_440_5.color.b, arg_437_1.hightColor2.b, (arg_437_1.time_ - 0) / var_440_3)))
							else
								local var_440_4 = Mathf.Lerp(iter_440_5.color.r, 0.5, (arg_437_1.time_ - 0) / var_440_3)

								iter_440_5.color = Color.New(var_440_4, var_440_4, var_440_4)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_3 and arg_437_1.time_ < 0 + var_440_3 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.actorSpriteComps10092_1 then
				for iter_440_6, iter_440_7 in pairs(arg_437_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_440_7 then
						iter_440_7.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_437_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_440_5 = arg_437_1.actors_["10022"].transform

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos10022 = var_440_5.localPosition
				var_440_5.localScale = Vector3.New(1, 1, 1)

				arg_437_1:CheckSpriteTmpPos("10022", 2)

				for iter_440_8 = 0, var_440_5.childCount - 1 do
					local var_440_6 = var_440_5:GetChild(iter_440_8)

					if var_440_6.name == "split_6" or not string.find(var_440_6.name, "split") then
						var_440_6.gameObject:SetActive(true)
					else
						var_440_6.gameObject:SetActive(false)
					end
				end
			end

			local var_440_7 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				var_440_5.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_437_1.time_ - 0) / var_440_7)
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				var_440_5.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_440_8 = 0
			local var_440_9 = 0.2

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_8 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_10 = arg_437_1:GetWordFromCfg(413122108)
				local var_440_11 = arg_437_1:FormatText(var_440_10.content)

				arg_437_1.text_.text = var_440_11

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_13 = 8 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_11) / 8)

				if (8 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_11) / 8)) > 0 and var_440_9 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_8
					end
				end

				arg_437_1.text_.text = var_440_11
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122108", "story_v_out_413122.awb") ~= 0 then
					local var_440_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122108", "story_v_out_413122.awb") / 1000

					if var_440_14 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_14 + var_440_8
					end

					if var_440_10.prefab_name ~= "" and arg_437_1.actors_[var_440_10.prefab_name] ~= nil then
						local var_440_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_10.prefab_name].transform, "story_v_out_413122", "413122108", "story_v_out_413122.awb")

						arg_437_1:RecordAudio("413122108", var_440_15)
						arg_437_1:RecordAudio("413122108", var_440_15)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_413122", "413122108", "story_v_out_413122.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_413122", "413122108", "story_v_out_413122.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_16 = math.max(var_440_9, arg_437_1.talkMaxDuration)

			if var_440_8 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_16 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_16

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_16 and arg_437_1.time_ < var_440_8 + var_440_16 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play413122109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 413122109
		arg_441_1.duration_ = 14.37

		local var_441_0 = {
			zh = 11.766,
			ja = 14.366
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play413122110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos10092_1 = arg_441_1.actors_["10092_1"].transform.localPosition
				arg_441_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_444_0 = 0, arg_441_1.actors_["10092_1"].transform.childCount - 1 do
					local var_444_0 = arg_441_1.actors_["10092_1"].transform:GetChild(iter_444_0)

					if var_444_0.name == "split_2" or not string.find(var_444_0.name, "split") then
						var_444_0.gameObject:SetActive(true)
					else
						var_444_0.gameObject:SetActive(false)
					end
				end
			end

			local var_444_1 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_1 then
				arg_441_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_441_1.time_ - 0) / var_444_1)
			end

			if arg_441_1.time_ >= 0 + var_444_1 and arg_441_1.time_ < 0 + var_444_1 + arg_444_0 then
				arg_441_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_444_2 = arg_441_1.actors_["10022"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps10022 == nil then
				arg_441_1.var_.actorSpriteComps10022 = var_444_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_3 = 2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_3 and not isNil(var_444_2) then
				if arg_441_1.var_.actorSpriteComps10022 then
					for iter_444_1, iter_444_2 in pairs(arg_441_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_441_1.time_ >= 0 + var_444_3 and arg_441_1.time_ < 0 + var_444_3 + arg_444_0 and not isNil(var_444_2) and arg_441_1.var_.actorSpriteComps10022 then
				for iter_444_3, iter_444_4 in pairs(arg_441_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_444_4 then
						iter_444_4.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_441_1.var_.actorSpriteComps10022 = nil
			end

			local var_444_5 = arg_441_1.actors_["10092_1"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_5) and arg_441_1.var_.actorSpriteComps10092_1 == nil then
				arg_441_1.var_.actorSpriteComps10092_1 = var_444_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_6 = 2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_6 and not isNil(var_444_5) then
				if arg_441_1.var_.actorSpriteComps10092_1 then
					for iter_444_5, iter_444_6 in pairs(arg_441_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_444_6 then
							if arg_441_1.isInRecall_ then
								iter_444_6.color = Color.New(Mathf.Lerp(iter_444_6.color.r, arg_441_1.hightColor1.r, (arg_441_1.time_ - 0) / var_444_6), Mathf.Lerp(iter_444_6.color.g, arg_441_1.hightColor1.g, (arg_441_1.time_ - 0) / var_444_6), (Mathf.Lerp(iter_444_6.color.b, arg_441_1.hightColor1.b, (arg_441_1.time_ - 0) / var_444_6)))
							else
								local var_444_7 = Mathf.Lerp(iter_444_6.color.r, 1, (arg_441_1.time_ - 0) / var_444_6)

								iter_444_6.color = Color.New(var_444_7, var_444_7, var_444_7)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_6 and arg_441_1.time_ < 0 + var_444_6 + arg_444_0 and not isNil(var_444_5) and arg_441_1.var_.actorSpriteComps10092_1 then
				for iter_444_7, iter_444_8 in pairs(arg_441_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_444_8 then
						iter_444_8.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_441_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_444_8 = 0
			local var_444_9 = 1.325

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_8 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_10 = arg_441_1:GetWordFromCfg(413122109)
				local var_444_11 = arg_441_1:FormatText(var_444_10.content)

				arg_441_1.text_.text = var_444_11

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_13 = 53 <= 0 and var_444_9 or var_444_9 * (utf8.len(var_444_11) / 53)

				if (53 <= 0 and var_444_9 or var_444_9 * (utf8.len(var_444_11) / 53)) > 0 and var_444_9 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_8 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_8
					end
				end

				arg_441_1.text_.text = var_444_11
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122109", "story_v_out_413122.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122109", "story_v_out_413122.awb") / 1000

					if var_444_14 + var_444_8 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_8
					end

					if var_444_10.prefab_name ~= "" and arg_441_1.actors_[var_444_10.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_10.prefab_name].transform, "story_v_out_413122", "413122109", "story_v_out_413122.awb")

						arg_441_1:RecordAudio("413122109", var_444_15)
						arg_441_1:RecordAudio("413122109", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_413122", "413122109", "story_v_out_413122.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_413122", "413122109", "story_v_out_413122.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_9, arg_441_1.talkMaxDuration)

			if var_444_8 <= arg_441_1.time_ and arg_441_1.time_ < var_444_8 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_8) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_8 + var_444_16 and arg_441_1.time_ < var_444_8 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 413122110
		arg_445_1.duration_ = 13.33

		local var_445_0 = {
			zh = 6.433,
			ja = 13.333
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play413122111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10092_1 = arg_445_1.actors_["10092_1"].transform.localPosition
				arg_445_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_448_0 = 0, arg_445_1.actors_["10092_1"].transform.childCount - 1 do
					local var_448_0 = arg_445_1.actors_["10092_1"].transform:GetChild(iter_448_0)

					if var_448_0.name == "split_1_1" or not string.find(var_448_0.name, "split") then
						var_448_0.gameObject:SetActive(true)
					else
						var_448_0.gameObject:SetActive(false)
					end
				end
			end

			local var_448_1 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_1 then
				arg_445_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_445_1.time_ - 0) / var_448_1)
			end

			if arg_445_1.time_ >= 0 + var_448_1 and arg_445_1.time_ < 0 + var_448_1 + arg_448_0 then
				arg_445_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_448_2 = 0
			local var_448_3 = 1

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(413122110)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 40 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 40)

				if (40 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 40)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122110", "story_v_out_413122.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122110", "story_v_out_413122.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_out_413122", "413122110", "story_v_out_413122.awb")

						arg_445_1:RecordAudio("413122110", var_448_9)
						arg_445_1:RecordAudio("413122110", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_413122", "413122110", "story_v_out_413122.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_413122", "413122110", "story_v_out_413122.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_10 and arg_445_1.time_ < var_448_2 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play413122111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 413122111
		arg_449_1.duration_ = 11.63

		local var_449_0 = {
			zh = 9.433,
			ja = 11.633
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play413122112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.175

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(413122111)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 47 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 47)

				if (47 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 47)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122111", "story_v_out_413122.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122111", "story_v_out_413122.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_413122", "413122111", "story_v_out_413122.awb")

						arg_449_1:RecordAudio("413122111", var_452_6)
						arg_449_1:RecordAudio("413122111", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_413122", "413122111", "story_v_out_413122.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_413122", "413122111", "story_v_out_413122.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play413122112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 413122112
		arg_453_1.duration_ = 14.63

		local var_453_0 = {
			zh = 6.166,
			ja = 14.633
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play413122113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos10092_1 = arg_453_1.actors_["10092_1"].transform.localPosition
				arg_453_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_453_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_456_0 = 0, arg_453_1.actors_["10092_1"].transform.childCount - 1 do
					local var_456_0 = arg_453_1.actors_["10092_1"].transform:GetChild(iter_456_0)

					if var_456_0.name == "split_8" or not string.find(var_456_0.name, "split") then
						var_456_0.gameObject:SetActive(true)
					else
						var_456_0.gameObject:SetActive(false)
					end
				end
			end

			local var_456_1 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_1 then
				arg_453_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_453_1.time_ - 0) / var_456_1)
			end

			if arg_453_1.time_ >= 0 + var_456_1 and arg_453_1.time_ < 0 + var_456_1 + arg_456_0 then
				arg_453_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_456_2 = arg_453_1.actors_["10092_1"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_2) and arg_453_1.var_.actorSpriteComps10092_1 == nil then
				arg_453_1.var_.actorSpriteComps10092_1 = var_456_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_3 = 2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_3 and not isNil(var_456_2) then
				if arg_453_1.var_.actorSpriteComps10092_1 then
					for iter_456_1, iter_456_2 in pairs(arg_453_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_456_2 then
							if arg_453_1.isInRecall_ then
								iter_456_2.color = Color.New(Mathf.Lerp(iter_456_2.color.r, arg_453_1.hightColor1.r, (arg_453_1.time_ - 0) / var_456_3), Mathf.Lerp(iter_456_2.color.g, arg_453_1.hightColor1.g, (arg_453_1.time_ - 0) / var_456_3), (Mathf.Lerp(iter_456_2.color.b, arg_453_1.hightColor1.b, (arg_453_1.time_ - 0) / var_456_3)))
							else
								local var_456_4 = Mathf.Lerp(iter_456_2.color.r, 1, (arg_453_1.time_ - 0) / var_456_3)

								iter_456_2.color = Color.New(var_456_4, var_456_4, var_456_4)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= 0 + var_456_3 and arg_453_1.time_ < 0 + var_456_3 + arg_456_0 and not isNil(var_456_2) and arg_453_1.var_.actorSpriteComps10092_1 then
				for iter_456_3, iter_456_4 in pairs(arg_453_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_456_4 then
						iter_456_4.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_453_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_456_5 = 0
			local var_456_6 = 0.65

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_7 = arg_453_1:GetWordFromCfg(413122112)
				local var_456_8 = arg_453_1:FormatText(var_456_7.content)

				arg_453_1.text_.text = var_456_8

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_10 = 26 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 26)

				if (26 <= 0 and var_456_6 or var_456_6 * (utf8.len(var_456_8) / 26)) > 0 and var_456_6 < var_456_10 then
					arg_453_1.talkMaxDuration = var_456_10

					if var_456_10 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_5
					end
				end

				arg_453_1.text_.text = var_456_8
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122112", "story_v_out_413122.awb") ~= 0 then
					local var_456_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122112", "story_v_out_413122.awb") / 1000

					if var_456_11 + var_456_5 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_11 + var_456_5
					end

					if var_456_7.prefab_name ~= "" and arg_453_1.actors_[var_456_7.prefab_name] ~= nil then
						local var_456_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_7.prefab_name].transform, "story_v_out_413122", "413122112", "story_v_out_413122.awb")

						arg_453_1:RecordAudio("413122112", var_456_12)
						arg_453_1:RecordAudio("413122112", var_456_12)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_413122", "413122112", "story_v_out_413122.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_413122", "413122112", "story_v_out_413122.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_13 = math.max(var_456_6, arg_453_1.talkMaxDuration)

			if var_456_5 <= arg_453_1.time_ and arg_453_1.time_ < var_456_5 + var_456_13 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_5) / var_456_13

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_5 + var_456_13 and arg_453_1.time_ < var_456_5 + var_456_13 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play413122113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 413122113
		arg_457_1.duration_ = 11.8

		local var_457_0 = {
			zh = 10.2996666666667,
			ja = 11.7996666666667
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play413122114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10022 = arg_457_1.actors_["10022"].transform.localPosition
				arg_457_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10022", 2)

				for iter_460_0 = 0, arg_457_1.actors_["10022"].transform.childCount - 1 do
					local var_460_0 = arg_457_1.actors_["10022"].transform:GetChild(iter_460_0)

					if var_460_0.name == "split_3" or not string.find(var_460_0.name, "split") then
						var_460_0.gameObject:SetActive(true)
					else
						var_460_0.gameObject:SetActive(false)
					end
				end
			end

			local var_460_1 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_1 then
				arg_457_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_457_1.time_ - 0) / var_460_1)
			end

			if arg_457_1.time_ >= 0 + var_460_1 and arg_457_1.time_ < 0 + var_460_1 + arg_460_0 then
				arg_457_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_460_2 = arg_457_1.actors_["10022"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_2) and arg_457_1.var_.actorSpriteComps10022 == nil then
				arg_457_1.var_.actorSpriteComps10022 = var_460_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_3 = 2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_3 and not isNil(var_460_2) then
				if arg_457_1.var_.actorSpriteComps10022 then
					for iter_460_1, iter_460_2 in pairs(arg_457_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_460_2 then
							if arg_457_1.isInRecall_ then
								iter_460_2.color = Color.New(Mathf.Lerp(iter_460_2.color.r, arg_457_1.hightColor1.r, (arg_457_1.time_ - 0) / var_460_3), Mathf.Lerp(iter_460_2.color.g, arg_457_1.hightColor1.g, (arg_457_1.time_ - 0) / var_460_3), (Mathf.Lerp(iter_460_2.color.b, arg_457_1.hightColor1.b, (arg_457_1.time_ - 0) / var_460_3)))
							else
								local var_460_4 = Mathf.Lerp(iter_460_2.color.r, 1, (arg_457_1.time_ - 0) / var_460_3)

								iter_460_2.color = Color.New(var_460_4, var_460_4, var_460_4)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= 0 + var_460_3 and arg_457_1.time_ < 0 + var_460_3 + arg_460_0 and not isNil(var_460_2) and arg_457_1.var_.actorSpriteComps10022 then
				for iter_460_3, iter_460_4 in pairs(arg_457_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_460_4 then
						iter_460_4.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_457_1.var_.actorSpriteComps10022 = nil
			end

			local var_460_5 = arg_457_1.actors_["10092_1"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_5) and arg_457_1.var_.actorSpriteComps10092_1 == nil then
				arg_457_1.var_.actorSpriteComps10092_1 = var_460_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_6 = 2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_6 and not isNil(var_460_5) then
				if arg_457_1.var_.actorSpriteComps10092_1 then
					for iter_460_5, iter_460_6 in pairs(arg_457_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_460_6 then
							if arg_457_1.isInRecall_ then
								iter_460_6.color = Color.New(Mathf.Lerp(iter_460_6.color.r, arg_457_1.hightColor2.r, (arg_457_1.time_ - 0) / var_460_6), Mathf.Lerp(iter_460_6.color.g, arg_457_1.hightColor2.g, (arg_457_1.time_ - 0) / var_460_6), (Mathf.Lerp(iter_460_6.color.b, arg_457_1.hightColor2.b, (arg_457_1.time_ - 0) / var_460_6)))
							else
								local var_460_7 = Mathf.Lerp(iter_460_6.color.r, 0.5, (arg_457_1.time_ - 0) / var_460_6)

								iter_460_6.color = Color.New(var_460_7, var_460_7, var_460_7)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= 0 + var_460_6 and arg_457_1.time_ < 0 + var_460_6 + arg_460_0 and not isNil(var_460_5) and arg_457_1.var_.actorSpriteComps10092_1 then
				for iter_460_7, iter_460_8 in pairs(arg_457_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_460_8 then
						iter_460_8.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_457_1.var_.actorSpriteComps10092_1 = nil
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_8 = 0.466666666666667
			local var_460_9 = 1.25

			if 0.466666666666667 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_10 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_10:setOnUpdate(LuaHelper.FloatAction(function(arg_461_0)
					arg_457_1.dialogCg_.alpha = arg_461_0
				end))
				var_460_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_11 = arg_457_1:GetWordFromCfg(413122113)
				local var_460_12 = arg_457_1:FormatText(var_460_11.content)

				arg_457_1.text_.text = var_460_12

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_14 = 50 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_12) / 50)

				if (50 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_12) / 50)) > 0 and var_460_9 < var_460_14 then
					arg_457_1.talkMaxDuration = var_460_14
					var_460_8 = var_460_8 + 0.3

					if var_460_14 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_12
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122113", "story_v_out_413122.awb") ~= 0 then
					local var_460_15 = manager.audio:GetVoiceLength("story_v_out_413122", "413122113", "story_v_out_413122.awb") / 1000

					if var_460_15 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_15 + var_460_8
					end

					if var_460_11.prefab_name ~= "" and arg_457_1.actors_[var_460_11.prefab_name] ~= nil then
						local var_460_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_11.prefab_name].transform, "story_v_out_413122", "413122113", "story_v_out_413122.awb")

						arg_457_1:RecordAudio("413122113", var_460_16)
						arg_457_1:RecordAudio("413122113", var_460_16)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_413122", "413122113", "story_v_out_413122.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_413122", "413122113", "story_v_out_413122.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_17 = var_460_8 + 0.3
			local var_460_18 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 + 0.3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_17 + var_460_18 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_17) / var_460_18

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_17 + var_460_18 and arg_457_1.time_ < var_460_17 + var_460_18 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play413122114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 413122114
		arg_463_1.duration_ = 7.37

		local var_463_0 = {
			zh = 4.1,
			ja = 7.366
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play413122115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos10092_1 = arg_463_1.actors_["10092_1"].transform.localPosition
				arg_463_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_463_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_466_0 = 0, arg_463_1.actors_["10092_1"].transform.childCount - 1 do
					local var_466_0 = arg_463_1.actors_["10092_1"].transform:GetChild(iter_466_0)

					if var_466_0.name == "split_2" or not string.find(var_466_0.name, "split") then
						var_466_0.gameObject:SetActive(true)
					else
						var_466_0.gameObject:SetActive(false)
					end
				end
			end

			local var_466_1 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_1 then
				arg_463_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_463_1.time_ - 0) / var_466_1)
			end

			if arg_463_1.time_ >= 0 + var_466_1 and arg_463_1.time_ < 0 + var_466_1 + arg_466_0 then
				arg_463_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_466_2 = arg_463_1.actors_["10022"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10022 == nil then
				arg_463_1.var_.actorSpriteComps10022 = var_466_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_3 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_3 and not isNil(var_466_2) then
				if arg_463_1.var_.actorSpriteComps10022 then
					for iter_466_1, iter_466_2 in pairs(arg_463_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_466_2 then
							if arg_463_1.isInRecall_ then
								iter_466_2.color = Color.New(Mathf.Lerp(iter_466_2.color.r, arg_463_1.hightColor2.r, (arg_463_1.time_ - 0) / var_466_3), Mathf.Lerp(iter_466_2.color.g, arg_463_1.hightColor2.g, (arg_463_1.time_ - 0) / var_466_3), (Mathf.Lerp(iter_466_2.color.b, arg_463_1.hightColor2.b, (arg_463_1.time_ - 0) / var_466_3)))
							else
								local var_466_4 = Mathf.Lerp(iter_466_2.color.r, 0.5, (arg_463_1.time_ - 0) / var_466_3)

								iter_466_2.color = Color.New(var_466_4, var_466_4, var_466_4)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_3 and arg_463_1.time_ < 0 + var_466_3 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10022 then
				for iter_466_3, iter_466_4 in pairs(arg_463_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_466_4 then
						iter_466_4.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_463_1.var_.actorSpriteComps10022 = nil
			end

			local var_466_5 = arg_463_1.actors_["10092_1"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_5) and arg_463_1.var_.actorSpriteComps10092_1 == nil then
				arg_463_1.var_.actorSpriteComps10092_1 = var_466_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_6 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_6 and not isNil(var_466_5) then
				if arg_463_1.var_.actorSpriteComps10092_1 then
					for iter_466_5, iter_466_6 in pairs(arg_463_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_466_6 then
							if arg_463_1.isInRecall_ then
								iter_466_6.color = Color.New(Mathf.Lerp(iter_466_6.color.r, arg_463_1.hightColor1.r, (arg_463_1.time_ - 0) / var_466_6), Mathf.Lerp(iter_466_6.color.g, arg_463_1.hightColor1.g, (arg_463_1.time_ - 0) / var_466_6), (Mathf.Lerp(iter_466_6.color.b, arg_463_1.hightColor1.b, (arg_463_1.time_ - 0) / var_466_6)))
							else
								local var_466_7 = Mathf.Lerp(iter_466_6.color.r, 1, (arg_463_1.time_ - 0) / var_466_6)

								iter_466_6.color = Color.New(var_466_7, var_466_7, var_466_7)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_6 and arg_463_1.time_ < 0 + var_466_6 + arg_466_0 and not isNil(var_466_5) and arg_463_1.var_.actorSpriteComps10092_1 then
				for iter_466_7, iter_466_8 in pairs(arg_463_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_466_8 then
						iter_466_8.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_463_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_466_8 = 0
			local var_466_9 = 0.55

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_10 = arg_463_1:GetWordFromCfg(413122114)
				local var_466_11 = arg_463_1:FormatText(var_466_10.content)

				arg_463_1.text_.text = var_466_11

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_13 = 22 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_11) / 22)

				if (22 <= 0 and var_466_9 or var_466_9 * (utf8.len(var_466_11) / 22)) > 0 and var_466_9 < var_466_13 then
					arg_463_1.talkMaxDuration = var_466_13

					if var_466_13 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_13 + var_466_8
					end
				end

				arg_463_1.text_.text = var_466_11
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122114", "story_v_out_413122.awb") ~= 0 then
					local var_466_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122114", "story_v_out_413122.awb") / 1000

					if var_466_14 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_14 + var_466_8
					end

					if var_466_10.prefab_name ~= "" and arg_463_1.actors_[var_466_10.prefab_name] ~= nil then
						local var_466_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_10.prefab_name].transform, "story_v_out_413122", "413122114", "story_v_out_413122.awb")

						arg_463_1:RecordAudio("413122114", var_466_15)
						arg_463_1:RecordAudio("413122114", var_466_15)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_413122", "413122114", "story_v_out_413122.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_413122", "413122114", "story_v_out_413122.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_16 = math.max(var_466_9, arg_463_1.talkMaxDuration)

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_16 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_8) / var_466_16

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_8 + var_466_16 and arg_463_1.time_ < var_466_8 + var_466_16 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 413122115
		arg_467_1.duration_ = 10.1

		local var_467_0 = {
			zh = 8.2,
			ja = 10.1
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
				arg_467_0:Play413122116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos10092_1 = arg_467_1.actors_["10092_1"].transform.localPosition
				arg_467_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_470_0 = 0, arg_467_1.actors_["10092_1"].transform.childCount - 1 do
					local var_470_0 = arg_467_1.actors_["10092_1"].transform:GetChild(iter_470_0)

					if var_470_0.name == "split_1_1" or not string.find(var_470_0.name, "split") then
						var_470_0.gameObject:SetActive(true)
					else
						var_470_0.gameObject:SetActive(false)
					end
				end
			end

			local var_470_1 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_1 then
				arg_467_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_467_1.time_ - 0) / var_470_1)
			end

			if arg_467_1.time_ >= 0 + var_470_1 and arg_467_1.time_ < 0 + var_470_1 + arg_470_0 then
				arg_467_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_470_2 = arg_467_1.actors_["10022"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.actorSpriteComps10022 == nil then
				arg_467_1.var_.actorSpriteComps10022 = var_470_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_3 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_3 and not isNil(var_470_2) then
				if arg_467_1.var_.actorSpriteComps10022 then
					for iter_470_1, iter_470_2 in pairs(arg_467_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_470_2 then
							if arg_467_1.isInRecall_ then
								iter_470_2.color = Color.New(Mathf.Lerp(iter_470_2.color.r, arg_467_1.hightColor1.r, (arg_467_1.time_ - 0) / var_470_3), Mathf.Lerp(iter_470_2.color.g, arg_467_1.hightColor1.g, (arg_467_1.time_ - 0) / var_470_3), (Mathf.Lerp(iter_470_2.color.b, arg_467_1.hightColor1.b, (arg_467_1.time_ - 0) / var_470_3)))
							else
								local var_470_4 = Mathf.Lerp(iter_470_2.color.r, 1, (arg_467_1.time_ - 0) / var_470_3)

								iter_470_2.color = Color.New(var_470_4, var_470_4, var_470_4)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_3 and arg_467_1.time_ < 0 + var_470_3 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.actorSpriteComps10022 then
				for iter_470_3, iter_470_4 in pairs(arg_467_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_470_4 then
						iter_470_4.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_467_1.var_.actorSpriteComps10022 = nil
			end

			local var_470_5 = arg_467_1.actors_["10092_1"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_5) and arg_467_1.var_.actorSpriteComps10092_1 == nil then
				arg_467_1.var_.actorSpriteComps10092_1 = var_470_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_6 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_6 and not isNil(var_470_5) then
				if arg_467_1.var_.actorSpriteComps10092_1 then
					for iter_470_5, iter_470_6 in pairs(arg_467_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_470_6 then
							if arg_467_1.isInRecall_ then
								iter_470_6.color = Color.New(Mathf.Lerp(iter_470_6.color.r, arg_467_1.hightColor2.r, (arg_467_1.time_ - 0) / var_470_6), Mathf.Lerp(iter_470_6.color.g, arg_467_1.hightColor2.g, (arg_467_1.time_ - 0) / var_470_6), (Mathf.Lerp(iter_470_6.color.b, arg_467_1.hightColor2.b, (arg_467_1.time_ - 0) / var_470_6)))
							else
								local var_470_7 = Mathf.Lerp(iter_470_6.color.r, 0.5, (arg_467_1.time_ - 0) / var_470_6)

								iter_470_6.color = Color.New(var_470_7, var_470_7, var_470_7)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_6 and arg_467_1.time_ < 0 + var_470_6 + arg_470_0 and not isNil(var_470_5) and arg_467_1.var_.actorSpriteComps10092_1 then
				for iter_470_7, iter_470_8 in pairs(arg_467_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_470_8 then
						iter_470_8.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_467_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_470_8 = 0
			local var_470_9 = 0.975

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_8 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_10 = arg_467_1:GetWordFromCfg(413122115)
				local var_470_11 = arg_467_1:FormatText(var_470_10.content)

				arg_467_1.text_.text = var_470_11

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_13 = 39 <= 0 and var_470_9 or var_470_9 * (utf8.len(var_470_11) / 39)

				if (39 <= 0 and var_470_9 or var_470_9 * (utf8.len(var_470_11) / 39)) > 0 and var_470_9 < var_470_13 then
					arg_467_1.talkMaxDuration = var_470_13

					if var_470_13 + var_470_8 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_13 + var_470_8
					end
				end

				arg_467_1.text_.text = var_470_11
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122115", "story_v_out_413122.awb") ~= 0 then
					local var_470_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122115", "story_v_out_413122.awb") / 1000

					if var_470_14 + var_470_8 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_14 + var_470_8
					end

					if var_470_10.prefab_name ~= "" and arg_467_1.actors_[var_470_10.prefab_name] ~= nil then
						local var_470_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_10.prefab_name].transform, "story_v_out_413122", "413122115", "story_v_out_413122.awb")

						arg_467_1:RecordAudio("413122115", var_470_15)
						arg_467_1:RecordAudio("413122115", var_470_15)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_413122", "413122115", "story_v_out_413122.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_413122", "413122115", "story_v_out_413122.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_16 = math.max(var_470_9, arg_467_1.talkMaxDuration)

			if var_470_8 <= arg_467_1.time_ and arg_467_1.time_ < var_470_8 + var_470_16 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_8) / var_470_16

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_8 + var_470_16 and arg_467_1.time_ < var_470_8 + var_470_16 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 413122116
		arg_471_1.duration_ = 2.93

		local var_471_0 = {
			zh = 2.033,
			ja = 2.933
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
				arg_471_0:Play413122117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos10022 = arg_471_1.actors_["10022"].transform.localPosition
				arg_471_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_471_1:CheckSpriteTmpPos("10022", 2)

				for iter_474_0 = 0, arg_471_1.actors_["10022"].transform.childCount - 1 do
					local var_474_0 = arg_471_1.actors_["10022"].transform:GetChild(iter_474_0)

					if var_474_0.name == "" or not string.find(var_474_0.name, "split") then
						var_474_0.gameObject:SetActive(true)
					else
						var_474_0.gameObject:SetActive(false)
					end
				end
			end

			local var_474_1 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_1 then
				arg_471_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_471_1.time_ - 0) / var_474_1)
			end

			if arg_471_1.time_ >= 0 + var_474_1 and arg_471_1.time_ < 0 + var_474_1 + arg_474_0 then
				arg_471_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_474_2 = arg_471_1.actors_["10022"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10022 == nil then
				arg_471_1.var_.actorSpriteComps10022 = var_474_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_3 = 2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_3 and not isNil(var_474_2) then
				if arg_471_1.var_.actorSpriteComps10022 then
					for iter_474_1, iter_474_2 in pairs(arg_471_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_474_2 then
							if arg_471_1.isInRecall_ then
								iter_474_2.color = Color.New(Mathf.Lerp(iter_474_2.color.r, arg_471_1.hightColor1.r, (arg_471_1.time_ - 0) / var_474_3), Mathf.Lerp(iter_474_2.color.g, arg_471_1.hightColor1.g, (arg_471_1.time_ - 0) / var_474_3), (Mathf.Lerp(iter_474_2.color.b, arg_471_1.hightColor1.b, (arg_471_1.time_ - 0) / var_474_3)))
							else
								local var_474_4 = Mathf.Lerp(iter_474_2.color.r, 1, (arg_471_1.time_ - 0) / var_474_3)

								iter_474_2.color = Color.New(var_474_4, var_474_4, var_474_4)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_3 and arg_471_1.time_ < 0 + var_474_3 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10022 then
				for iter_474_3, iter_474_4 in pairs(arg_471_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_474_4 then
						iter_474_4.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_471_1.var_.actorSpriteComps10022 = nil
			end

			local var_474_5 = 0
			local var_474_6 = 0.225

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_7 = arg_471_1:GetWordFromCfg(413122116)
				local var_474_8 = arg_471_1:FormatText(var_474_7.content)

				arg_471_1.text_.text = var_474_8

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_10 = 9 <= 0 and var_474_6 or var_474_6 * (utf8.len(var_474_8) / 9)

				if (9 <= 0 and var_474_6 or var_474_6 * (utf8.len(var_474_8) / 9)) > 0 and var_474_6 < var_474_10 then
					arg_471_1.talkMaxDuration = var_474_10

					if var_474_10 + var_474_5 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_5
					end
				end

				arg_471_1.text_.text = var_474_8
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122116", "story_v_out_413122.awb") ~= 0 then
					local var_474_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122116", "story_v_out_413122.awb") / 1000

					if var_474_11 + var_474_5 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_11 + var_474_5
					end

					if var_474_7.prefab_name ~= "" and arg_471_1.actors_[var_474_7.prefab_name] ~= nil then
						local var_474_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_7.prefab_name].transform, "story_v_out_413122", "413122116", "story_v_out_413122.awb")

						arg_471_1:RecordAudio("413122116", var_474_12)
						arg_471_1:RecordAudio("413122116", var_474_12)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_413122", "413122116", "story_v_out_413122.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_413122", "413122116", "story_v_out_413122.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_13 = math.max(var_474_6, arg_471_1.talkMaxDuration)

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_13 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_5) / var_474_13

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_5 + var_474_13 and arg_471_1.time_ < var_474_5 + var_474_13 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play413122117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 413122117
		arg_475_1.duration_ = 9.3

		local var_475_0 = {
			zh = 6.266,
			ja = 9.3
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
				arg_475_0:Play413122118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10022 = arg_475_1.actors_["10022"].transform.localPosition
				arg_475_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10022", 7)

				for iter_478_0 = 0, arg_475_1.actors_["10022"].transform.childCount - 1 do
					local var_478_0 = arg_475_1.actors_["10022"].transform:GetChild(iter_478_0)

					if var_478_0.name == "" or not string.find(var_478_0.name, "split") then
						var_478_0.gameObject:SetActive(true)
					else
						var_478_0.gameObject:SetActive(false)
					end
				end
			end

			local var_478_1 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_1 then
				arg_475_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_475_1.time_ - 0) / var_478_1)
			end

			if arg_475_1.time_ >= 0 + var_478_1 and arg_475_1.time_ < 0 + var_478_1 + arg_478_0 then
				arg_475_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_478_2 = arg_475_1.actors_["10094"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10094 = var_478_2.localPosition
				var_478_2.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10094", 3)

				for iter_478_1 = 0, var_478_2.childCount - 1 do
					local var_478_3 = var_478_2:GetChild(iter_478_1)

					if var_478_3.name == "" or not string.find(var_478_3.name, "split") then
						var_478_3.gameObject:SetActive(true)
					else
						var_478_3.gameObject:SetActive(false)
					end
				end
			end

			local var_478_4 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				var_478_2.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_475_1.time_ - 0) / var_478_4)
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				var_478_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_478_5 = arg_475_1.actors_["10022"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.actorSpriteComps10022 == nil then
				arg_475_1.var_.actorSpriteComps10022 = var_478_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_6 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_6 and not isNil(var_478_5) then
				if arg_475_1.var_.actorSpriteComps10022 then
					for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_475_1.time_ >= 0 + var_478_6 and arg_475_1.time_ < 0 + var_478_6 + arg_478_0 and not isNil(var_478_5) and arg_475_1.var_.actorSpriteComps10022 then
				for iter_478_4, iter_478_5 in pairs(arg_475_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_478_5 then
						iter_478_5.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_475_1.var_.actorSpriteComps10022 = nil
			end

			local var_478_8 = arg_475_1.actors_["10094"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10094 == nil then
				arg_475_1.var_.actorSpriteComps10094 = var_478_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_9 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_9 and not isNil(var_478_8) then
				if arg_475_1.var_.actorSpriteComps10094 then
					for iter_478_6, iter_478_7 in pairs(arg_475_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_475_1.time_ >= 0 + var_478_9 and arg_475_1.time_ < 0 + var_478_9 + arg_478_0 and not isNil(var_478_8) and arg_475_1.var_.actorSpriteComps10094 then
				for iter_478_8, iter_478_9 in pairs(arg_475_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_478_9 then
						iter_478_9.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps10094 = nil
			end

			local var_478_11 = arg_475_1.actors_["10092_1"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10092_1 = var_478_11.localPosition
				var_478_11.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10092_1", 7)

				for iter_478_10 = 0, var_478_11.childCount - 1 do
					local var_478_12 = var_478_11:GetChild(iter_478_10)

					if var_478_12.name == "" or not string.find(var_478_12.name, "split") then
						var_478_12.gameObject:SetActive(true)
					else
						var_478_12.gameObject:SetActive(false)
					end
				end
			end

			local var_478_13 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_13 then
				var_478_11.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10092_1, Vector3.New(0, -2000, 0), (arg_475_1.time_ - 0) / var_478_13)
			end

			if arg_475_1.time_ >= 0 + var_478_13 and arg_475_1.time_ < 0 + var_478_13 + arg_478_0 then
				var_478_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_478_14 = 0
			local var_478_15 = 0.725

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_14 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_16 = arg_475_1:GetWordFromCfg(413122117)
				local var_478_17 = arg_475_1:FormatText(var_478_16.content)

				arg_475_1.text_.text = var_478_17

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_19 = 29 <= 0 and var_478_15 or var_478_15 * (utf8.len(var_478_17) / 29)

				if (29 <= 0 and var_478_15 or var_478_15 * (utf8.len(var_478_17) / 29)) > 0 and var_478_15 < var_478_19 then
					arg_475_1.talkMaxDuration = var_478_19

					if var_478_19 + var_478_14 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_19 + var_478_14
					end
				end

				arg_475_1.text_.text = var_478_17
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122117", "story_v_out_413122.awb") ~= 0 then
					local var_478_20 = manager.audio:GetVoiceLength("story_v_out_413122", "413122117", "story_v_out_413122.awb") / 1000

					if var_478_20 + var_478_14 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_20 + var_478_14
					end

					if var_478_16.prefab_name ~= "" and arg_475_1.actors_[var_478_16.prefab_name] ~= nil then
						local var_478_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_16.prefab_name].transform, "story_v_out_413122", "413122117", "story_v_out_413122.awb")

						arg_475_1:RecordAudio("413122117", var_478_21)
						arg_475_1:RecordAudio("413122117", var_478_21)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_413122", "413122117", "story_v_out_413122.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_413122", "413122117", "story_v_out_413122.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_22 = math.max(var_478_15, arg_475_1.talkMaxDuration)

			if var_478_14 <= arg_475_1.time_ and arg_475_1.time_ < var_478_14 + var_478_22 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_14) / var_478_22

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_14 + var_478_22 and arg_475_1.time_ < var_478_14 + var_478_22 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413122118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 413122118
		arg_479_1.duration_ = 14.3

		local var_479_0 = {
			zh = 14.3,
			ja = 13.5
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play413122119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["10094"]) and arg_479_1.var_.actorSpriteComps10094 == nil then
				arg_479_1.var_.actorSpriteComps10094 = arg_479_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["10094"]) then
				if arg_479_1.var_.actorSpriteComps10094 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor1.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor1.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor1.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 1, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["10094"]) and arg_479_1.var_.actorSpriteComps10094 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_479_1.var_.actorSpriteComps10094 = nil
			end

			local var_482_2 = 0
			local var_482_3 = 1.45

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_2 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_4 = arg_479_1:GetWordFromCfg(413122118)
				local var_482_5 = arg_479_1:FormatText(var_482_4.content)

				arg_479_1.text_.text = var_482_5

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_7 = 58 <= 0 and var_482_3 or var_482_3 * (utf8.len(var_482_5) / 58)

				if (58 <= 0 and var_482_3 or var_482_3 * (utf8.len(var_482_5) / 58)) > 0 and var_482_3 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_2
					end
				end

				arg_479_1.text_.text = var_482_5
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122118", "story_v_out_413122.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122118", "story_v_out_413122.awb") / 1000

					if var_482_8 + var_482_2 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_2
					end

					if var_482_4.prefab_name ~= "" and arg_479_1.actors_[var_482_4.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_4.prefab_name].transform, "story_v_out_413122", "413122118", "story_v_out_413122.awb")

						arg_479_1:RecordAudio("413122118", var_482_9)
						arg_479_1:RecordAudio("413122118", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_413122", "413122118", "story_v_out_413122.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_413122", "413122118", "story_v_out_413122.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_3, arg_479_1.talkMaxDuration)

			if var_482_2 <= arg_479_1.time_ and arg_479_1.time_ < var_482_2 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_2) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_2 + var_482_10 and arg_479_1.time_ < var_482_2 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play413122119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 413122119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play413122120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10094 = arg_483_1.actors_["10094"].transform.localPosition
				arg_483_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10094", 7)

				for iter_486_0 = 0, arg_483_1.actors_["10094"].transform.childCount - 1 do
					local var_486_0 = arg_483_1.actors_["10094"].transform:GetChild(iter_486_0)

					if var_486_0.name == "" or not string.find(var_486_0.name, "split") then
						var_486_0.gameObject:SetActive(true)
					else
						var_486_0.gameObject:SetActive(false)
					end
				end
			end

			local var_486_1 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_1 then
				arg_483_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_483_1.time_ - 0) / var_486_1)
			end

			if arg_483_1.time_ >= 0 + var_486_1 and arg_483_1.time_ < 0 + var_486_1 + arg_486_0 then
				arg_483_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_486_2 = arg_483_1.actors_["10022"].transform

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10022 = var_486_2.localPosition
				var_486_2.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("10022", 6)

				for iter_486_1 = 0, var_486_2.childCount - 1 do
					local var_486_3 = var_486_2:GetChild(iter_486_1)

					if var_486_3.name == "" or not string.find(var_486_3.name, "split") then
						var_486_3.gameObject:SetActive(true)
					else
						var_486_3.gameObject:SetActive(false)
					end
				end
			end

			local var_486_4 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				var_486_2.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_483_1.time_ - 0) / var_486_4)
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				var_486_2.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_486_5 = arg_483_1.actors_["10094"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_5) and arg_483_1.var_.actorSpriteComps10094 == nil then
				arg_483_1.var_.actorSpriteComps10094 = var_486_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_6 = 2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_6 and not isNil(var_486_5) then
				if arg_483_1.var_.actorSpriteComps10094 then
					for iter_486_2, iter_486_3 in pairs(arg_483_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_486_3 then
							if arg_483_1.isInRecall_ then
								iter_486_3.color = Color.New(Mathf.Lerp(iter_486_3.color.r, arg_483_1.hightColor2.r, (arg_483_1.time_ - 0) / var_486_6), Mathf.Lerp(iter_486_3.color.g, arg_483_1.hightColor2.g, (arg_483_1.time_ - 0) / var_486_6), (Mathf.Lerp(iter_486_3.color.b, arg_483_1.hightColor2.b, (arg_483_1.time_ - 0) / var_486_6)))
							else
								local var_486_7 = Mathf.Lerp(iter_486_3.color.r, 0.5, (arg_483_1.time_ - 0) / var_486_6)

								iter_486_3.color = Color.New(var_486_7, var_486_7, var_486_7)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_6 and arg_483_1.time_ < 0 + var_486_6 + arg_486_0 and not isNil(var_486_5) and arg_483_1.var_.actorSpriteComps10094 then
				for iter_486_4, iter_486_5 in pairs(arg_483_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_486_5 then
						iter_486_5.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_483_1.var_.actorSpriteComps10094 = nil
			end

			local var_486_8 = arg_483_1.actors_["10022"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_8) and arg_483_1.var_.actorSpriteComps10022 == nil then
				arg_483_1.var_.actorSpriteComps10022 = var_486_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_9 = 2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_9 and not isNil(var_486_8) then
				if arg_483_1.var_.actorSpriteComps10022 then
					for iter_486_6, iter_486_7 in pairs(arg_483_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_486_7 then
							if arg_483_1.isInRecall_ then
								iter_486_7.color = Color.New(Mathf.Lerp(iter_486_7.color.r, arg_483_1.hightColor2.r, (arg_483_1.time_ - 0) / var_486_9), Mathf.Lerp(iter_486_7.color.g, arg_483_1.hightColor2.g, (arg_483_1.time_ - 0) / var_486_9), (Mathf.Lerp(iter_486_7.color.b, arg_483_1.hightColor2.b, (arg_483_1.time_ - 0) / var_486_9)))
							else
								local var_486_10 = Mathf.Lerp(iter_486_7.color.r, 0.5, (arg_483_1.time_ - 0) / var_486_9)

								iter_486_7.color = Color.New(var_486_10, var_486_10, var_486_10)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_9 and arg_483_1.time_ < 0 + var_486_9 + arg_486_0 and not isNil(var_486_8) and arg_483_1.var_.actorSpriteComps10022 then
				for iter_486_8, iter_486_9 in pairs(arg_483_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_486_9 then
						iter_486_9.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_483_1.var_.actorSpriteComps10022 = nil
			end

			local var_486_11 = 0
			local var_486_12 = 0.725

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_11 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_13 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(413122119).content)

				arg_483_1.text_.text = var_486_13

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_15 = 29 <= 0 and var_486_12 or var_486_12 * (utf8.len(var_486_13) / 29)

				if (29 <= 0 and var_486_12 or var_486_12 * (utf8.len(var_486_13) / 29)) > 0 and var_486_12 < var_486_15 then
					arg_483_1.talkMaxDuration = var_486_15

					if var_486_15 + var_486_11 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_15 + var_486_11
					end
				end

				arg_483_1.text_.text = var_486_13
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_16 = math.max(var_486_12, arg_483_1.talkMaxDuration)

			if var_486_11 <= arg_483_1.time_ and arg_483_1.time_ < var_486_11 + var_486_16 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_11) / var_486_16

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_11 + var_486_16 and arg_483_1.time_ < var_486_11 + var_486_16 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play413122120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 413122120
		arg_487_1.duration_ = 3.67

		local var_487_0 = {
			zh = 2.7,
			ja = 3.666
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play413122121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos10022 = arg_487_1.actors_["10022"].transform.localPosition
				arg_487_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10022", 2)

				for iter_490_0 = 0, arg_487_1.actors_["10022"].transform.childCount - 1 do
					local var_490_0 = arg_487_1.actors_["10022"].transform:GetChild(iter_490_0)

					if var_490_0.name == "split_3" or not string.find(var_490_0.name, "split") then
						var_490_0.gameObject:SetActive(true)
					else
						var_490_0.gameObject:SetActive(false)
					end
				end
			end

			local var_490_1 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_1 then
				arg_487_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_487_1.time_ - 0) / var_490_1)
			end

			if arg_487_1.time_ >= 0 + var_490_1 and arg_487_1.time_ < 0 + var_490_1 + arg_490_0 then
				arg_487_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_490_2 = arg_487_1.actors_["10022"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_2) and arg_487_1.var_.actorSpriteComps10022 == nil then
				arg_487_1.var_.actorSpriteComps10022 = var_490_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_3 = 2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_3 and not isNil(var_490_2) then
				if arg_487_1.var_.actorSpriteComps10022 then
					for iter_490_1, iter_490_2 in pairs(arg_487_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_490_2 then
							if arg_487_1.isInRecall_ then
								iter_490_2.color = Color.New(Mathf.Lerp(iter_490_2.color.r, arg_487_1.hightColor1.r, (arg_487_1.time_ - 0) / var_490_3), Mathf.Lerp(iter_490_2.color.g, arg_487_1.hightColor1.g, (arg_487_1.time_ - 0) / var_490_3), (Mathf.Lerp(iter_490_2.color.b, arg_487_1.hightColor1.b, (arg_487_1.time_ - 0) / var_490_3)))
							else
								local var_490_4 = Mathf.Lerp(iter_490_2.color.r, 1, (arg_487_1.time_ - 0) / var_490_3)

								iter_490_2.color = Color.New(var_490_4, var_490_4, var_490_4)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= 0 + var_490_3 and arg_487_1.time_ < 0 + var_490_3 + arg_490_0 and not isNil(var_490_2) and arg_487_1.var_.actorSpriteComps10022 then
				for iter_490_3, iter_490_4 in pairs(arg_487_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_490_4 then
						iter_490_4.color = arg_487_1.isInRecall_ and (arg_487_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_487_1.var_.actorSpriteComps10022 = nil
			end

			local var_490_5 = 0
			local var_490_6 = 0.35

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_5 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_7 = arg_487_1:GetWordFromCfg(413122120)
				local var_490_8 = arg_487_1:FormatText(var_490_7.content)

				arg_487_1.text_.text = var_490_8

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_10 = 14 <= 0 and var_490_6 or var_490_6 * (utf8.len(var_490_8) / 14)

				if (14 <= 0 and var_490_6 or var_490_6 * (utf8.len(var_490_8) / 14)) > 0 and var_490_6 < var_490_10 then
					arg_487_1.talkMaxDuration = var_490_10

					if var_490_10 + var_490_5 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_5
					end
				end

				arg_487_1.text_.text = var_490_8
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122120", "story_v_out_413122.awb") ~= 0 then
					local var_490_11 = manager.audio:GetVoiceLength("story_v_out_413122", "413122120", "story_v_out_413122.awb") / 1000

					if var_490_11 + var_490_5 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_11 + var_490_5
					end

					if var_490_7.prefab_name ~= "" and arg_487_1.actors_[var_490_7.prefab_name] ~= nil then
						local var_490_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_7.prefab_name].transform, "story_v_out_413122", "413122120", "story_v_out_413122.awb")

						arg_487_1:RecordAudio("413122120", var_490_12)
						arg_487_1:RecordAudio("413122120", var_490_12)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_413122", "413122120", "story_v_out_413122.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_413122", "413122120", "story_v_out_413122.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_13 = math.max(var_490_6, arg_487_1.talkMaxDuration)

			if var_490_5 <= arg_487_1.time_ and arg_487_1.time_ < var_490_5 + var_490_13 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_5) / var_490_13

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_5 + var_490_13 and arg_487_1.time_ < var_490_5 + var_490_13 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play413122121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 413122121
		arg_491_1.duration_ = 5.7

		local var_491_0 = {
			zh = 5.533,
			ja = 5.7
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
				arg_491_0:Play413122122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10092_1 = arg_491_1.actors_["10092_1"].transform.localPosition
				arg_491_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10092_1", 4)

				for iter_494_0 = 0, arg_491_1.actors_["10092_1"].transform.childCount - 1 do
					local var_494_0 = arg_491_1.actors_["10092_1"].transform:GetChild(iter_494_0)

					if var_494_0.name == "split_1_1" or not string.find(var_494_0.name, "split") then
						var_494_0.gameObject:SetActive(true)
					else
						var_494_0.gameObject:SetActive(false)
					end
				end
			end

			local var_494_1 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_1 then
				arg_491_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10092_1, Vector3.New(390, -300, -295), (arg_491_1.time_ - 0) / var_494_1)
			end

			if arg_491_1.time_ >= 0 + var_494_1 and arg_491_1.time_ < 0 + var_494_1 + arg_494_0 then
				arg_491_1.actors_["10092_1"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_494_2 = arg_491_1.actors_["10022"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos10022 = var_494_2.localPosition
				var_494_2.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("10022", 2)

				for iter_494_1 = 0, var_494_2.childCount - 1 do
					local var_494_3 = var_494_2:GetChild(iter_494_1)

					if var_494_3.name == "split_3" or not string.find(var_494_3.name, "split") then
						var_494_3.gameObject:SetActive(true)
					else
						var_494_3.gameObject:SetActive(false)
					end
				end
			end

			local var_494_4 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				var_494_2.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_491_1.time_ - 0) / var_494_4)
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				var_494_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_494_5 = arg_491_1.actors_["10092_1"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_5) and arg_491_1.var_.actorSpriteComps10092_1 == nil then
				arg_491_1.var_.actorSpriteComps10092_1 = var_494_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_6 = 2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_6 and not isNil(var_494_5) then
				if arg_491_1.var_.actorSpriteComps10092_1 then
					for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_494_3 then
							if arg_491_1.isInRecall_ then
								iter_494_3.color = Color.New(Mathf.Lerp(iter_494_3.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_6), Mathf.Lerp(iter_494_3.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_6), (Mathf.Lerp(iter_494_3.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_6)))
							else
								local var_494_7 = Mathf.Lerp(iter_494_3.color.r, 1, (arg_491_1.time_ - 0) / var_494_6)

								iter_494_3.color = Color.New(var_494_7, var_494_7, var_494_7)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_6 and arg_491_1.time_ < 0 + var_494_6 + arg_494_0 and not isNil(var_494_5) and arg_491_1.var_.actorSpriteComps10092_1 then
				for iter_494_4, iter_494_5 in pairs(arg_491_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_494_5 then
						iter_494_5.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_494_8 = arg_491_1.actors_["10022"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10022 == nil then
				arg_491_1.var_.actorSpriteComps10022 = var_494_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_9 = 2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_9 and not isNil(var_494_8) then
				if arg_491_1.var_.actorSpriteComps10022 then
					for iter_494_6, iter_494_7 in pairs(arg_491_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_494_7 then
							if arg_491_1.isInRecall_ then
								iter_494_7.color = Color.New(Mathf.Lerp(iter_494_7.color.r, arg_491_1.hightColor2.r, (arg_491_1.time_ - 0) / var_494_9), Mathf.Lerp(iter_494_7.color.g, arg_491_1.hightColor2.g, (arg_491_1.time_ - 0) / var_494_9), (Mathf.Lerp(iter_494_7.color.b, arg_491_1.hightColor2.b, (arg_491_1.time_ - 0) / var_494_9)))
							else
								local var_494_10 = Mathf.Lerp(iter_494_7.color.r, 0.5, (arg_491_1.time_ - 0) / var_494_9)

								iter_494_7.color = Color.New(var_494_10, var_494_10, var_494_10)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_9 and arg_491_1.time_ < 0 + var_494_9 + arg_494_0 and not isNil(var_494_8) and arg_491_1.var_.actorSpriteComps10022 then
				for iter_494_8, iter_494_9 in pairs(arg_491_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_494_9 then
						iter_494_9.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_491_1.var_.actorSpriteComps10022 = nil
			end

			local var_494_11 = 0
			local var_494_12 = 0.7

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_11 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_13 = arg_491_1:GetWordFromCfg(413122121)
				local var_494_14 = arg_491_1:FormatText(var_494_13.content)

				arg_491_1.text_.text = var_494_14

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_16 = 28 <= 0 and var_494_12 or var_494_12 * (utf8.len(var_494_14) / 28)

				if (28 <= 0 and var_494_12 or var_494_12 * (utf8.len(var_494_14) / 28)) > 0 and var_494_12 < var_494_16 then
					arg_491_1.talkMaxDuration = var_494_16

					if var_494_16 + var_494_11 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_16 + var_494_11
					end
				end

				arg_491_1.text_.text = var_494_14
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122121", "story_v_out_413122.awb") ~= 0 then
					local var_494_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122121", "story_v_out_413122.awb") / 1000

					if var_494_17 + var_494_11 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_17 + var_494_11
					end

					if var_494_13.prefab_name ~= "" and arg_491_1.actors_[var_494_13.prefab_name] ~= nil then
						local var_494_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_13.prefab_name].transform, "story_v_out_413122", "413122121", "story_v_out_413122.awb")

						arg_491_1:RecordAudio("413122121", var_494_18)
						arg_491_1:RecordAudio("413122121", var_494_18)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_413122", "413122121", "story_v_out_413122.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_413122", "413122121", "story_v_out_413122.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_19 = math.max(var_494_12, arg_491_1.talkMaxDuration)

			if var_494_11 <= arg_491_1.time_ and arg_491_1.time_ < var_494_11 + var_494_19 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_11) / var_494_19

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_11 + var_494_19 and arg_491_1.time_ < var_494_11 + var_494_19 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play413122122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 413122122
		arg_495_1.duration_ = 9.67

		local var_495_0 = {
			zh = 6.7,
			ja = 9.666
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
				arg_495_0:Play413122123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10022 = arg_495_1.actors_["10022"].transform.localPosition
				arg_495_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10022", 6)

				for iter_498_0 = 0, arg_495_1.actors_["10022"].transform.childCount - 1 do
					local var_498_0 = arg_495_1.actors_["10022"].transform:GetChild(iter_498_0)

					if var_498_0.name == "" or not string.find(var_498_0.name, "split") then
						var_498_0.gameObject:SetActive(true)
					else
						var_498_0.gameObject:SetActive(false)
					end
				end
			end

			local var_498_1 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_1 then
				arg_495_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_495_1.time_ - 0) / var_498_1)
			end

			if arg_495_1.time_ >= 0 + var_498_1 and arg_495_1.time_ < 0 + var_498_1 + arg_498_0 then
				arg_495_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_498_2 = arg_495_1.actors_["10092_1"].transform

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10092_1 = var_498_2.localPosition
				var_498_2.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_498_1 = 0, var_498_2.childCount - 1 do
					local var_498_3 = var_498_2:GetChild(iter_498_1)

					if var_498_3.name == "" or not string.find(var_498_3.name, "split") then
						var_498_3.gameObject:SetActive(true)
					else
						var_498_3.gameObject:SetActive(false)
					end
				end
			end

			local var_498_4 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				var_498_2.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_495_1.time_ - 0) / var_498_4)
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				var_498_2.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_498_5 = arg_495_1.actors_["10094"].transform

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10094 = var_498_5.localPosition
				var_498_5.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10094", 3)

				for iter_498_2 = 0, var_498_5.childCount - 1 do
					local var_498_6 = var_498_5:GetChild(iter_498_2)

					if var_498_6.name == "" or not string.find(var_498_6.name, "split") then
						var_498_6.gameObject:SetActive(true)
					else
						var_498_6.gameObject:SetActive(false)
					end
				end
			end

			local var_498_7 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				var_498_5.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_495_1.time_ - 0) / var_498_7)
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				var_498_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_498_8 = arg_495_1.actors_["10022"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_8) and arg_495_1.var_.actorSpriteComps10022 == nil then
				arg_495_1.var_.actorSpriteComps10022 = var_498_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_9 = 2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_9 and not isNil(var_498_8) then
				if arg_495_1.var_.actorSpriteComps10022 then
					for iter_498_3, iter_498_4 in pairs(arg_495_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_498_4 then
							if arg_495_1.isInRecall_ then
								iter_498_4.color = Color.New(Mathf.Lerp(iter_498_4.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_9), Mathf.Lerp(iter_498_4.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_9), (Mathf.Lerp(iter_498_4.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_9)))
							else
								local var_498_10 = Mathf.Lerp(iter_498_4.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_9)

								iter_498_4.color = Color.New(var_498_10, var_498_10, var_498_10)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_9 and arg_495_1.time_ < 0 + var_498_9 + arg_498_0 and not isNil(var_498_8) and arg_495_1.var_.actorSpriteComps10022 then
				for iter_498_5, iter_498_6 in pairs(arg_495_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_498_6 then
						iter_498_6.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps10022 = nil
			end

			local var_498_11 = arg_495_1.actors_["10092_1"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_11) and arg_495_1.var_.actorSpriteComps10092_1 == nil then
				arg_495_1.var_.actorSpriteComps10092_1 = var_498_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_12 = 2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_12 and not isNil(var_498_11) then
				if arg_495_1.var_.actorSpriteComps10092_1 then
					for iter_498_7, iter_498_8 in pairs(arg_495_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_498_8 then
							if arg_495_1.isInRecall_ then
								iter_498_8.color = Color.New(Mathf.Lerp(iter_498_8.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_12), Mathf.Lerp(iter_498_8.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_12), (Mathf.Lerp(iter_498_8.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_12)))
							else
								local var_498_13 = Mathf.Lerp(iter_498_8.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_12)

								iter_498_8.color = Color.New(var_498_13, var_498_13, var_498_13)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_12 and arg_495_1.time_ < 0 + var_498_12 + arg_498_0 and not isNil(var_498_11) and arg_495_1.var_.actorSpriteComps10092_1 then
				for iter_498_9, iter_498_10 in pairs(arg_495_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_498_10 then
						iter_498_10.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_498_14 = arg_495_1.actors_["10094"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_14) and arg_495_1.var_.actorSpriteComps10094 == nil then
				arg_495_1.var_.actorSpriteComps10094 = var_498_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_15 = 2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_15 and not isNil(var_498_14) then
				if arg_495_1.var_.actorSpriteComps10094 then
					for iter_498_11, iter_498_12 in pairs(arg_495_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_498_12 then
							if arg_495_1.isInRecall_ then
								iter_498_12.color = Color.New(Mathf.Lerp(iter_498_12.color.r, arg_495_1.hightColor1.r, (arg_495_1.time_ - 0) / var_498_15), Mathf.Lerp(iter_498_12.color.g, arg_495_1.hightColor1.g, (arg_495_1.time_ - 0) / var_498_15), (Mathf.Lerp(iter_498_12.color.b, arg_495_1.hightColor1.b, (arg_495_1.time_ - 0) / var_498_15)))
							else
								local var_498_16 = Mathf.Lerp(iter_498_12.color.r, 1, (arg_495_1.time_ - 0) / var_498_15)

								iter_498_12.color = Color.New(var_498_16, var_498_16, var_498_16)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_15 and arg_495_1.time_ < 0 + var_498_15 + arg_498_0 and not isNil(var_498_14) and arg_495_1.var_.actorSpriteComps10094 then
				for iter_498_13, iter_498_14 in pairs(arg_495_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_498_14 then
						iter_498_14.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_495_1.var_.actorSpriteComps10094 = nil
			end

			local var_498_17 = 0
			local var_498_18 = 0.875

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_17 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_19 = arg_495_1:GetWordFromCfg(413122122)
				local var_498_20 = arg_495_1:FormatText(var_498_19.content)

				arg_495_1.text_.text = var_498_20

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_22 = 35 <= 0 and var_498_18 or var_498_18 * (utf8.len(var_498_20) / 35)

				if (35 <= 0 and var_498_18 or var_498_18 * (utf8.len(var_498_20) / 35)) > 0 and var_498_18 < var_498_22 then
					arg_495_1.talkMaxDuration = var_498_22

					if var_498_22 + var_498_17 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_22 + var_498_17
					end
				end

				arg_495_1.text_.text = var_498_20
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122122", "story_v_out_413122.awb") ~= 0 then
					local var_498_23 = manager.audio:GetVoiceLength("story_v_out_413122", "413122122", "story_v_out_413122.awb") / 1000

					if var_498_23 + var_498_17 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_23 + var_498_17
					end

					if var_498_19.prefab_name ~= "" and arg_495_1.actors_[var_498_19.prefab_name] ~= nil then
						local var_498_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_19.prefab_name].transform, "story_v_out_413122", "413122122", "story_v_out_413122.awb")

						arg_495_1:RecordAudio("413122122", var_498_24)
						arg_495_1:RecordAudio("413122122", var_498_24)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_413122", "413122122", "story_v_out_413122.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_413122", "413122122", "story_v_out_413122.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_25 = math.max(var_498_18, arg_495_1.talkMaxDuration)

			if var_498_17 <= arg_495_1.time_ and arg_495_1.time_ < var_498_17 + var_498_25 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_17) / var_498_25

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_17 + var_498_25 and arg_495_1.time_ < var_498_17 + var_498_25 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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

		arg_495_1:InitPlayNodeList()
	end,
	Play413122123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 413122123
		arg_499_1.duration_ = 11.7

		local var_499_0 = {
			zh = 7.633,
			ja = 11.7
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
				arg_499_0:Play413122124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["10094"]) and arg_499_1.var_.actorSpriteComps10094 == nil then
				arg_499_1.var_.actorSpriteComps10094 = arg_499_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["10094"]) then
				if arg_499_1.var_.actorSpriteComps10094 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								iter_502_1.color = Color.New(Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_0), Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_0), (Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_0)))
							else
								local var_502_1 = Mathf.Lerp(iter_502_1.color.r, 1, (arg_499_1.time_ - 0) / var_502_0)

								iter_502_1.color = Color.New(var_502_1, var_502_1, var_502_1)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["10094"]) and arg_499_1.var_.actorSpriteComps10094 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps10094 = nil
			end

			local var_502_2 = 0
			local var_502_3 = 0.825

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_2 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_4 = arg_499_1:GetWordFromCfg(413122123)
				local var_502_5 = arg_499_1:FormatText(var_502_4.content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 33 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 33)

				if (33 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 33)) > 0 and var_502_3 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_2
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122123", "story_v_out_413122.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_413122", "413122123", "story_v_out_413122.awb") / 1000

					if var_502_8 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_2
					end

					if var_502_4.prefab_name ~= "" and arg_499_1.actors_[var_502_4.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_4.prefab_name].transform, "story_v_out_413122", "413122123", "story_v_out_413122.awb")

						arg_499_1:RecordAudio("413122123", var_502_9)
						arg_499_1:RecordAudio("413122123", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_413122", "413122123", "story_v_out_413122.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_413122", "413122123", "story_v_out_413122.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_3, arg_499_1.talkMaxDuration)

			if var_502_2 <= arg_499_1.time_ and arg_499_1.time_ < var_502_2 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_2) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_2 + var_502_10 and arg_499_1.time_ < var_502_2 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play413122124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 413122124
		arg_503_1.duration_ = 2.7

		local var_503_0 = {
			zh = 2.3,
			ja = 2.7
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
				arg_503_0:Play413122125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10094 = arg_503_1.actors_["10094"].transform.localPosition
				arg_503_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10094", 6)

				for iter_506_0 = 0, arg_503_1.actors_["10094"].transform.childCount - 1 do
					local var_506_0 = arg_503_1.actors_["10094"].transform:GetChild(iter_506_0)

					if var_506_0.name == "" or not string.find(var_506_0.name, "split") then
						var_506_0.gameObject:SetActive(true)
					else
						var_506_0.gameObject:SetActive(false)
					end
				end
			end

			local var_506_1 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_1 then
				arg_503_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10094, Vector3.New(1500, -340, -414), (arg_503_1.time_ - 0) / var_506_1)
			end

			if arg_503_1.time_ >= 0 + var_506_1 and arg_503_1.time_ < 0 + var_506_1 + arg_506_0 then
				arg_503_1.actors_["10094"].transform.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_506_2 = arg_503_1.actors_["10092_1"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10092_1 = var_506_2.localPosition
				var_506_2.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_506_1 = 0, var_506_2.childCount - 1 do
					local var_506_3 = var_506_2:GetChild(iter_506_1)

					if var_506_3.name == "split_1_1" or not string.find(var_506_3.name, "split") then
						var_506_3.gameObject:SetActive(true)
					else
						var_506_3.gameObject:SetActive(false)
					end
				end
			end

			local var_506_4 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				var_506_2.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_503_1.time_ - 0) / var_506_4)
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				var_506_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_506_5 = arg_503_1.actors_["10094"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_5) and arg_503_1.var_.actorSpriteComps10094 == nil then
				arg_503_1.var_.actorSpriteComps10094 = var_506_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_6 = 2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_6 and not isNil(var_506_5) then
				if arg_503_1.var_.actorSpriteComps10094 then
					for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_506_3 then
							if arg_503_1.isInRecall_ then
								iter_506_3.color = Color.New(Mathf.Lerp(iter_506_3.color.r, arg_503_1.hightColor2.r, (arg_503_1.time_ - 0) / var_506_6), Mathf.Lerp(iter_506_3.color.g, arg_503_1.hightColor2.g, (arg_503_1.time_ - 0) / var_506_6), (Mathf.Lerp(iter_506_3.color.b, arg_503_1.hightColor2.b, (arg_503_1.time_ - 0) / var_506_6)))
							else
								local var_506_7 = Mathf.Lerp(iter_506_3.color.r, 0.5, (arg_503_1.time_ - 0) / var_506_6)

								iter_506_3.color = Color.New(var_506_7, var_506_7, var_506_7)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_6 and arg_503_1.time_ < 0 + var_506_6 + arg_506_0 and not isNil(var_506_5) and arg_503_1.var_.actorSpriteComps10094 then
				for iter_506_4, iter_506_5 in pairs(arg_503_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_506_5 then
						iter_506_5.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_503_1.var_.actorSpriteComps10094 = nil
			end

			local var_506_8 = arg_503_1.actors_["10092_1"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_8) and arg_503_1.var_.actorSpriteComps10092_1 == nil then
				arg_503_1.var_.actorSpriteComps10092_1 = var_506_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_9 = 2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_9 and not isNil(var_506_8) then
				if arg_503_1.var_.actorSpriteComps10092_1 then
					for iter_506_6, iter_506_7 in pairs(arg_503_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_506_7 then
							if arg_503_1.isInRecall_ then
								iter_506_7.color = Color.New(Mathf.Lerp(iter_506_7.color.r, arg_503_1.hightColor1.r, (arg_503_1.time_ - 0) / var_506_9), Mathf.Lerp(iter_506_7.color.g, arg_503_1.hightColor1.g, (arg_503_1.time_ - 0) / var_506_9), (Mathf.Lerp(iter_506_7.color.b, arg_503_1.hightColor1.b, (arg_503_1.time_ - 0) / var_506_9)))
							else
								local var_506_10 = Mathf.Lerp(iter_506_7.color.r, 1, (arg_503_1.time_ - 0) / var_506_9)

								iter_506_7.color = Color.New(var_506_10, var_506_10, var_506_10)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_9 and arg_503_1.time_ < 0 + var_506_9 + arg_506_0 and not isNil(var_506_8) and arg_503_1.var_.actorSpriteComps10092_1 then
				for iter_506_8, iter_506_9 in pairs(arg_503_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_506_9 then
						iter_506_9.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_503_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_506_11 = 0
			local var_506_12 = 0.3

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_11 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_13 = arg_503_1:GetWordFromCfg(413122124)
				local var_506_14 = arg_503_1:FormatText(var_506_13.content)

				arg_503_1.text_.text = var_506_14

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_16 = 12 <= 0 and var_506_12 or var_506_12 * (utf8.len(var_506_14) / 12)

				if (12 <= 0 and var_506_12 or var_506_12 * (utf8.len(var_506_14) / 12)) > 0 and var_506_12 < var_506_16 then
					arg_503_1.talkMaxDuration = var_506_16

					if var_506_16 + var_506_11 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_16 + var_506_11
					end
				end

				arg_503_1.text_.text = var_506_14
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122124", "story_v_out_413122.awb") ~= 0 then
					local var_506_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122124", "story_v_out_413122.awb") / 1000

					if var_506_17 + var_506_11 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_17 + var_506_11
					end

					if var_506_13.prefab_name ~= "" and arg_503_1.actors_[var_506_13.prefab_name] ~= nil then
						local var_506_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_13.prefab_name].transform, "story_v_out_413122", "413122124", "story_v_out_413122.awb")

						arg_503_1:RecordAudio("413122124", var_506_18)
						arg_503_1:RecordAudio("413122124", var_506_18)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_413122", "413122124", "story_v_out_413122.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_413122", "413122124", "story_v_out_413122.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_19 = math.max(var_506_12, arg_503_1.talkMaxDuration)

			if var_506_11 <= arg_503_1.time_ and arg_503_1.time_ < var_506_11 + var_506_19 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_11) / var_506_19

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_11 + var_506_19 and arg_503_1.time_ < var_506_11 + var_506_19 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
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
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play413122125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 413122125
		arg_507_1.duration_ = 10.8

		local var_507_0 = {
			zh = 9.266,
			ja = 10.8
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play413122126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10022 = arg_507_1.actors_["10022"].transform.localPosition
				arg_507_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10022", 4)

				for iter_510_0 = 0, arg_507_1.actors_["10022"].transform.childCount - 1 do
					local var_510_0 = arg_507_1.actors_["10022"].transform:GetChild(iter_510_0)

					if var_510_0.name == "" or not string.find(var_510_0.name, "split") then
						var_510_0.gameObject:SetActive(true)
					else
						var_510_0.gameObject:SetActive(false)
					end
				end
			end

			local var_510_1 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_1 then
				arg_507_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_507_1.time_ - 0) / var_510_1)
			end

			if arg_507_1.time_ >= 0 + var_510_1 and arg_507_1.time_ < 0 + var_510_1 + arg_510_0 then
				arg_507_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_510_2 = arg_507_1.actors_["10092_1"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10092_1 == nil then
				arg_507_1.var_.actorSpriteComps10092_1 = var_510_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_3 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_3 and not isNil(var_510_2) then
				if arg_507_1.var_.actorSpriteComps10092_1 then
					for iter_510_1, iter_510_2 in pairs(arg_507_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_510_2 then
							if arg_507_1.isInRecall_ then
								iter_510_2.color = Color.New(Mathf.Lerp(iter_510_2.color.r, arg_507_1.hightColor2.r, (arg_507_1.time_ - 0) / var_510_3), Mathf.Lerp(iter_510_2.color.g, arg_507_1.hightColor2.g, (arg_507_1.time_ - 0) / var_510_3), (Mathf.Lerp(iter_510_2.color.b, arg_507_1.hightColor2.b, (arg_507_1.time_ - 0) / var_510_3)))
							else
								local var_510_4 = Mathf.Lerp(iter_510_2.color.r, 0.5, (arg_507_1.time_ - 0) / var_510_3)

								iter_510_2.color = Color.New(var_510_4, var_510_4, var_510_4)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_3 and arg_507_1.time_ < 0 + var_510_3 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10092_1 then
				for iter_510_3, iter_510_4 in pairs(arg_507_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_510_4 then
						iter_510_4.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_507_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_510_5 = arg_507_1.actors_["10022"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_5) and arg_507_1.var_.actorSpriteComps10022 == nil then
				arg_507_1.var_.actorSpriteComps10022 = var_510_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_6 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_6 and not isNil(var_510_5) then
				if arg_507_1.var_.actorSpriteComps10022 then
					for iter_510_5, iter_510_6 in pairs(arg_507_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_510_6 then
							if arg_507_1.isInRecall_ then
								iter_510_6.color = Color.New(Mathf.Lerp(iter_510_6.color.r, arg_507_1.hightColor1.r, (arg_507_1.time_ - 0) / var_510_6), Mathf.Lerp(iter_510_6.color.g, arg_507_1.hightColor1.g, (arg_507_1.time_ - 0) / var_510_6), (Mathf.Lerp(iter_510_6.color.b, arg_507_1.hightColor1.b, (arg_507_1.time_ - 0) / var_510_6)))
							else
								local var_510_7 = Mathf.Lerp(iter_510_6.color.r, 1, (arg_507_1.time_ - 0) / var_510_6)

								iter_510_6.color = Color.New(var_510_7, var_510_7, var_510_7)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_6 and arg_507_1.time_ < 0 + var_510_6 + arg_510_0 and not isNil(var_510_5) and arg_507_1.var_.actorSpriteComps10022 then
				for iter_510_7, iter_510_8 in pairs(arg_507_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_510_8 then
						iter_510_8.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10022 = nil
			end

			local var_510_8 = 0
			local var_510_9 = 1.15

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_8 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_10 = arg_507_1:GetWordFromCfg(413122125)
				local var_510_11 = arg_507_1:FormatText(var_510_10.content)

				arg_507_1.text_.text = var_510_11

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_13 = 44 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 44)

				if (44 <= 0 and var_510_9 or var_510_9 * (utf8.len(var_510_11) / 44)) > 0 and var_510_9 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_8
					end
				end

				arg_507_1.text_.text = var_510_11
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122125", "story_v_out_413122.awb") ~= 0 then
					local var_510_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122125", "story_v_out_413122.awb") / 1000

					if var_510_14 + var_510_8 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_8
					end

					if var_510_10.prefab_name ~= "" and arg_507_1.actors_[var_510_10.prefab_name] ~= nil then
						local var_510_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_10.prefab_name].transform, "story_v_out_413122", "413122125", "story_v_out_413122.awb")

						arg_507_1:RecordAudio("413122125", var_510_15)
						arg_507_1:RecordAudio("413122125", var_510_15)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_413122", "413122125", "story_v_out_413122.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_413122", "413122125", "story_v_out_413122.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_16 = math.max(var_510_9, arg_507_1.talkMaxDuration)

			if var_510_8 <= arg_507_1.time_ and arg_507_1.time_ < var_510_8 + var_510_16 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_8) / var_510_16

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_8 + var_510_16 and arg_507_1.time_ < var_510_8 + var_510_16 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play413122126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 413122126
		arg_511_1.duration_ = 3.37

		local var_511_0 = {
			zh = 2.333,
			ja = 3.366
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play413122127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10092_1 = arg_511_1.actors_["10092_1"].transform.localPosition
				arg_511_1.actors_["10092_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10092_1", 2)

				for iter_514_0 = 0, arg_511_1.actors_["10092_1"].transform.childCount - 1 do
					local var_514_0 = arg_511_1.actors_["10092_1"].transform:GetChild(iter_514_0)

					if var_514_0.name == "split_1_1" or not string.find(var_514_0.name, "split") then
						var_514_0.gameObject:SetActive(true)
					else
						var_514_0.gameObject:SetActive(false)
					end
				end
			end

			local var_514_1 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_1 then
				arg_511_1.actors_["10092_1"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10092_1, Vector3.New(-389.49, -300, -295), (arg_511_1.time_ - 0) / var_514_1)
			end

			if arg_511_1.time_ >= 0 + var_514_1 and arg_511_1.time_ < 0 + var_514_1 + arg_514_0 then
				arg_511_1.actors_["10092_1"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_514_2 = arg_511_1.actors_["10092_1"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10092_1 == nil then
				arg_511_1.var_.actorSpriteComps10092_1 = var_514_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_3 = 2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_3 and not isNil(var_514_2) then
				if arg_511_1.var_.actorSpriteComps10092_1 then
					for iter_514_1, iter_514_2 in pairs(arg_511_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_514_2 then
							if arg_511_1.isInRecall_ then
								iter_514_2.color = Color.New(Mathf.Lerp(iter_514_2.color.r, arg_511_1.hightColor1.r, (arg_511_1.time_ - 0) / var_514_3), Mathf.Lerp(iter_514_2.color.g, arg_511_1.hightColor1.g, (arg_511_1.time_ - 0) / var_514_3), (Mathf.Lerp(iter_514_2.color.b, arg_511_1.hightColor1.b, (arg_511_1.time_ - 0) / var_514_3)))
							else
								local var_514_4 = Mathf.Lerp(iter_514_2.color.r, 1, (arg_511_1.time_ - 0) / var_514_3)

								iter_514_2.color = Color.New(var_514_4, var_514_4, var_514_4)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_3 and arg_511_1.time_ < 0 + var_514_3 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10092_1 then
				for iter_514_3, iter_514_4 in pairs(arg_511_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_514_4 then
						iter_514_4.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_511_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_514_5 = arg_511_1.actors_["10022"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_5) and arg_511_1.var_.actorSpriteComps10022 == nil then
				arg_511_1.var_.actorSpriteComps10022 = var_514_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_6 = 2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_6 and not isNil(var_514_5) then
				if arg_511_1.var_.actorSpriteComps10022 then
					for iter_514_5, iter_514_6 in pairs(arg_511_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_514_6 then
							if arg_511_1.isInRecall_ then
								iter_514_6.color = Color.New(Mathf.Lerp(iter_514_6.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_6), Mathf.Lerp(iter_514_6.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_6), (Mathf.Lerp(iter_514_6.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_6)))
							else
								local var_514_7 = Mathf.Lerp(iter_514_6.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_6)

								iter_514_6.color = Color.New(var_514_7, var_514_7, var_514_7)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_6 and arg_511_1.time_ < 0 + var_514_6 + arg_514_0 and not isNil(var_514_5) and arg_511_1.var_.actorSpriteComps10022 then
				for iter_514_7, iter_514_8 in pairs(arg_511_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_514_8 then
						iter_514_8.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps10022 = nil
			end

			local var_514_8 = 0
			local var_514_9 = 0.25

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_10 = arg_511_1:GetWordFromCfg(413122126)
				local var_514_11 = arg_511_1:FormatText(var_514_10.content)

				arg_511_1.text_.text = var_514_11

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_13 = 10 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 10)

				if (10 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 10)) > 0 and var_514_9 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_8
					end
				end

				arg_511_1.text_.text = var_514_11
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122126", "story_v_out_413122.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_out_413122", "413122126", "story_v_out_413122.awb") / 1000

					if var_514_14 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_8
					end

					if var_514_10.prefab_name ~= "" and arg_511_1.actors_[var_514_10.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_10.prefab_name].transform, "story_v_out_413122", "413122126", "story_v_out_413122.awb")

						arg_511_1:RecordAudio("413122126", var_514_15)
						arg_511_1:RecordAudio("413122126", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_413122", "413122126", "story_v_out_413122.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_413122", "413122126", "story_v_out_413122.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_9, arg_511_1.talkMaxDuration)

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_8) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_8 + var_514_16 and arg_511_1.time_ < var_514_8 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play413122127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 413122127
		arg_515_1.duration_ = 2.53

		local var_515_0 = {
			zh = 2.266,
			ja = 2.533
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play413122128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10022 = arg_515_1.actors_["10022"].transform.localPosition
				arg_515_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10022", 6)

				for iter_518_0 = 0, arg_515_1.actors_["10022"].transform.childCount - 1 do
					local var_518_0 = arg_515_1.actors_["10022"].transform:GetChild(iter_518_0)

					if var_518_0.name == "" or not string.find(var_518_0.name, "split") then
						var_518_0.gameObject:SetActive(true)
					else
						var_518_0.gameObject:SetActive(false)
					end
				end
			end

			local var_518_1 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_1 then
				arg_515_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10022, Vector3.New(1500, -315, -320), (arg_515_1.time_ - 0) / var_518_1)
			end

			if arg_515_1.time_ >= 0 + var_518_1 and arg_515_1.time_ < 0 + var_518_1 + arg_518_0 then
				arg_515_1.actors_["10022"].transform.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_518_2 = arg_515_1.actors_["10093"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10093 = var_518_2.localPosition
				var_518_2.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10093", 4)

				for iter_518_1 = 0, var_518_2.childCount - 1 do
					local var_518_3 = var_518_2:GetChild(iter_518_1)

					if var_518_3.name == "split_4" or not string.find(var_518_3.name, "split") then
						var_518_3.gameObject:SetActive(true)
					else
						var_518_3.gameObject:SetActive(false)
					end
				end
			end

			local var_518_4 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				var_518_2.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_515_1.time_ - 0) / var_518_4)
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				var_518_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_518_5 = arg_515_1.actors_["10092_1"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_5) and arg_515_1.var_.actorSpriteComps10092_1 == nil then
				arg_515_1.var_.actorSpriteComps10092_1 = var_518_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_6 = 2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_6 and not isNil(var_518_5) then
				if arg_515_1.var_.actorSpriteComps10092_1 then
					for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_518_3 then
							if arg_515_1.isInRecall_ then
								iter_518_3.color = Color.New(Mathf.Lerp(iter_518_3.color.r, arg_515_1.hightColor2.r, (arg_515_1.time_ - 0) / var_518_6), Mathf.Lerp(iter_518_3.color.g, arg_515_1.hightColor2.g, (arg_515_1.time_ - 0) / var_518_6), (Mathf.Lerp(iter_518_3.color.b, arg_515_1.hightColor2.b, (arg_515_1.time_ - 0) / var_518_6)))
							else
								local var_518_7 = Mathf.Lerp(iter_518_3.color.r, 0.5, (arg_515_1.time_ - 0) / var_518_6)

								iter_518_3.color = Color.New(var_518_7, var_518_7, var_518_7)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_6 and arg_515_1.time_ < 0 + var_518_6 + arg_518_0 and not isNil(var_518_5) and arg_515_1.var_.actorSpriteComps10092_1 then
				for iter_518_4, iter_518_5 in pairs(arg_515_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_518_5 then
						iter_518_5.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_515_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_518_8 = arg_515_1.actors_["10093"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps10093 == nil then
				arg_515_1.var_.actorSpriteComps10093 = var_518_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_9 = 2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_9 and not isNil(var_518_8) then
				if arg_515_1.var_.actorSpriteComps10093 then
					for iter_518_6, iter_518_7 in pairs(arg_515_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_518_7 then
							if arg_515_1.isInRecall_ then
								iter_518_7.color = Color.New(Mathf.Lerp(iter_518_7.color.r, arg_515_1.hightColor1.r, (arg_515_1.time_ - 0) / var_518_9), Mathf.Lerp(iter_518_7.color.g, arg_515_1.hightColor1.g, (arg_515_1.time_ - 0) / var_518_9), (Mathf.Lerp(iter_518_7.color.b, arg_515_1.hightColor1.b, (arg_515_1.time_ - 0) / var_518_9)))
							else
								local var_518_10 = Mathf.Lerp(iter_518_7.color.r, 1, (arg_515_1.time_ - 0) / var_518_9)

								iter_518_7.color = Color.New(var_518_10, var_518_10, var_518_10)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_9 and arg_515_1.time_ < 0 + var_518_9 + arg_518_0 and not isNil(var_518_8) and arg_515_1.var_.actorSpriteComps10093 then
				for iter_518_8, iter_518_9 in pairs(arg_515_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_518_9 then
						iter_518_9.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_515_1.var_.actorSpriteComps10093 = nil
			end

			local var_518_11 = 0
			local var_518_12 = 0.3

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_11 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_13 = arg_515_1:GetWordFromCfg(413122127)
				local var_518_14 = arg_515_1:FormatText(var_518_13.content)

				arg_515_1.text_.text = var_518_14

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_16 = 12 <= 0 and var_518_12 or var_518_12 * (utf8.len(var_518_14) / 12)

				if (12 <= 0 and var_518_12 or var_518_12 * (utf8.len(var_518_14) / 12)) > 0 and var_518_12 < var_518_16 then
					arg_515_1.talkMaxDuration = var_518_16

					if var_518_16 + var_518_11 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_16 + var_518_11
					end
				end

				arg_515_1.text_.text = var_518_14
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122127", "story_v_out_413122.awb") ~= 0 then
					local var_518_17 = manager.audio:GetVoiceLength("story_v_out_413122", "413122127", "story_v_out_413122.awb") / 1000

					if var_518_17 + var_518_11 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_17 + var_518_11
					end

					if var_518_13.prefab_name ~= "" and arg_515_1.actors_[var_518_13.prefab_name] ~= nil then
						local var_518_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_13.prefab_name].transform, "story_v_out_413122", "413122127", "story_v_out_413122.awb")

						arg_515_1:RecordAudio("413122127", var_518_18)
						arg_515_1:RecordAudio("413122127", var_518_18)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_413122", "413122127", "story_v_out_413122.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_413122", "413122127", "story_v_out_413122.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_19 = math.max(var_518_12, arg_515_1.talkMaxDuration)

			if var_518_11 <= arg_515_1.time_ and arg_515_1.time_ < var_518_11 + var_518_19 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_11) / var_518_19

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_11 + var_518_19 and arg_515_1.time_ < var_518_11 + var_518_19 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_515_1:InitPlayNodeList()
	end,
	Play413122128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 413122128
		arg_519_1.duration_ = 9.17

		local var_519_0 = {
			zh = 7.533,
			ja = 9.166
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play413122129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10022 = arg_519_1.actors_["10022"].transform.localPosition
				arg_519_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10022", 3)

				for iter_522_0 = 0, arg_519_1.actors_["10022"].transform.childCount - 1 do
					local var_522_0 = arg_519_1.actors_["10022"].transform:GetChild(iter_522_0)

					if var_522_0.name == "split_8" or not string.find(var_522_0.name, "split") then
						var_522_0.gameObject:SetActive(true)
					else
						var_522_0.gameObject:SetActive(false)
					end
				end
			end

			local var_522_1 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_1 then
				arg_519_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_519_1.time_ - 0) / var_522_1)
			end

			if arg_519_1.time_ >= 0 + var_522_1 and arg_519_1.time_ < 0 + var_522_1 + arg_522_0 then
				arg_519_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_522_2 = arg_519_1.actors_["10093"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10093 = var_522_2.localPosition
				var_522_2.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10093", 6)

				for iter_522_1 = 0, var_522_2.childCount - 1 do
					local var_522_3 = var_522_2:GetChild(iter_522_1)

					if var_522_3.name == "" or not string.find(var_522_3.name, "split") then
						var_522_3.gameObject:SetActive(true)
					else
						var_522_3.gameObject:SetActive(false)
					end
				end
			end

			local var_522_4 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				var_522_2.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_519_1.time_ - 0) / var_522_4)
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				var_522_2.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_522_5 = arg_519_1.actors_["10092_1"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10092_1 = var_522_5.localPosition
				var_522_5.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10092_1", 6)

				for iter_522_2 = 0, var_522_5.childCount - 1 do
					local var_522_6 = var_522_5:GetChild(iter_522_2)

					if var_522_6.name == "" or not string.find(var_522_6.name, "split") then
						var_522_6.gameObject:SetActive(true)
					else
						var_522_6.gameObject:SetActive(false)
					end
				end
			end

			local var_522_7 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				var_522_5.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10092_1, Vector3.New(1500, -300, -295), (arg_519_1.time_ - 0) / var_522_7)
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				var_522_5.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_522_8 = arg_519_1.actors_["10022"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10022 == nil then
				arg_519_1.var_.actorSpriteComps10022 = var_522_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_9 = 2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_9 and not isNil(var_522_8) then
				if arg_519_1.var_.actorSpriteComps10022 then
					for iter_522_3, iter_522_4 in pairs(arg_519_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_522_4 then
							if arg_519_1.isInRecall_ then
								iter_522_4.color = Color.New(Mathf.Lerp(iter_522_4.color.r, arg_519_1.hightColor1.r, (arg_519_1.time_ - 0) / var_522_9), Mathf.Lerp(iter_522_4.color.g, arg_519_1.hightColor1.g, (arg_519_1.time_ - 0) / var_522_9), (Mathf.Lerp(iter_522_4.color.b, arg_519_1.hightColor1.b, (arg_519_1.time_ - 0) / var_522_9)))
							else
								local var_522_10 = Mathf.Lerp(iter_522_4.color.r, 1, (arg_519_1.time_ - 0) / var_522_9)

								iter_522_4.color = Color.New(var_522_10, var_522_10, var_522_10)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_9 and arg_519_1.time_ < 0 + var_522_9 + arg_522_0 and not isNil(var_522_8) and arg_519_1.var_.actorSpriteComps10022 then
				for iter_522_5, iter_522_6 in pairs(arg_519_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_522_6 then
						iter_522_6.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_519_1.var_.actorSpriteComps10022 = nil
			end

			local var_522_11 = arg_519_1.actors_["10093"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_11) and arg_519_1.var_.actorSpriteComps10093 == nil then
				arg_519_1.var_.actorSpriteComps10093 = var_522_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_12 = 2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_12 and not isNil(var_522_11) then
				if arg_519_1.var_.actorSpriteComps10093 then
					for iter_522_7, iter_522_8 in pairs(arg_519_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_522_8 then
							if arg_519_1.isInRecall_ then
								iter_522_8.color = Color.New(Mathf.Lerp(iter_522_8.color.r, arg_519_1.hightColor2.r, (arg_519_1.time_ - 0) / var_522_12), Mathf.Lerp(iter_522_8.color.g, arg_519_1.hightColor2.g, (arg_519_1.time_ - 0) / var_522_12), (Mathf.Lerp(iter_522_8.color.b, arg_519_1.hightColor2.b, (arg_519_1.time_ - 0) / var_522_12)))
							else
								local var_522_13 = Mathf.Lerp(iter_522_8.color.r, 0.5, (arg_519_1.time_ - 0) / var_522_12)

								iter_522_8.color = Color.New(var_522_13, var_522_13, var_522_13)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_12 and arg_519_1.time_ < 0 + var_522_12 + arg_522_0 and not isNil(var_522_11) and arg_519_1.var_.actorSpriteComps10093 then
				for iter_522_9, iter_522_10 in pairs(arg_519_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_522_10 then
						iter_522_10.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10093 = nil
			end

			local var_522_14 = arg_519_1.actors_["10092_1"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_14) and arg_519_1.var_.actorSpriteComps10092_1 == nil then
				arg_519_1.var_.actorSpriteComps10092_1 = var_522_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_15 = 2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_15 and not isNil(var_522_14) then
				if arg_519_1.var_.actorSpriteComps10092_1 then
					for iter_522_11, iter_522_12 in pairs(arg_519_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_522_12 then
							if arg_519_1.isInRecall_ then
								iter_522_12.color = Color.New(Mathf.Lerp(iter_522_12.color.r, arg_519_1.hightColor2.r, (arg_519_1.time_ - 0) / var_522_15), Mathf.Lerp(iter_522_12.color.g, arg_519_1.hightColor2.g, (arg_519_1.time_ - 0) / var_522_15), (Mathf.Lerp(iter_522_12.color.b, arg_519_1.hightColor2.b, (arg_519_1.time_ - 0) / var_522_15)))
							else
								local var_522_16 = Mathf.Lerp(iter_522_12.color.r, 0.5, (arg_519_1.time_ - 0) / var_522_15)

								iter_522_12.color = Color.New(var_522_16, var_522_16, var_522_16)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_15 and arg_519_1.time_ < 0 + var_522_15 + arg_522_0 and not isNil(var_522_14) and arg_519_1.var_.actorSpriteComps10092_1 then
				for iter_522_13, iter_522_14 in pairs(arg_519_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_522_14 then
						iter_522_14.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_522_17 = 0
			local var_522_18 = 0.975

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_17 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_19 = arg_519_1:GetWordFromCfg(413122128)
				local var_522_20 = arg_519_1:FormatText(var_522_19.content)

				arg_519_1.text_.text = var_522_20

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_22 = 39 <= 0 and var_522_18 or var_522_18 * (utf8.len(var_522_20) / 39)

				if (39 <= 0 and var_522_18 or var_522_18 * (utf8.len(var_522_20) / 39)) > 0 and var_522_18 < var_522_22 then
					arg_519_1.talkMaxDuration = var_522_22

					if var_522_22 + var_522_17 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_22 + var_522_17
					end
				end

				arg_519_1.text_.text = var_522_20
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122128", "story_v_out_413122.awb") ~= 0 then
					local var_522_23 = manager.audio:GetVoiceLength("story_v_out_413122", "413122128", "story_v_out_413122.awb") / 1000

					if var_522_23 + var_522_17 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_23 + var_522_17
					end

					if var_522_19.prefab_name ~= "" and arg_519_1.actors_[var_522_19.prefab_name] ~= nil then
						local var_522_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_19.prefab_name].transform, "story_v_out_413122", "413122128", "story_v_out_413122.awb")

						arg_519_1:RecordAudio("413122128", var_522_24)
						arg_519_1:RecordAudio("413122128", var_522_24)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_413122", "413122128", "story_v_out_413122.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_413122", "413122128", "story_v_out_413122.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_25 = math.max(var_522_18, arg_519_1.talkMaxDuration)

			if var_522_17 <= arg_519_1.time_ and arg_519_1.time_ < var_522_17 + var_522_25 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_17) / var_522_25

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_17 + var_522_25 and arg_519_1.time_ < var_522_17 + var_522_25 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play413122129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 413122129
		arg_523_1.duration_ = 5.33

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play413122130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10022 = arg_523_1.actors_["10022"].transform.localPosition
				arg_523_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10022", 7)

				for iter_526_0 = 0, arg_523_1.actors_["10022"].transform.childCount - 1 do
					local var_526_0 = arg_523_1.actors_["10022"].transform:GetChild(iter_526_0)

					if var_526_0.name == "split_3" or not string.find(var_526_0.name, "split") then
						var_526_0.gameObject:SetActive(true)
					else
						var_526_0.gameObject:SetActive(false)
					end
				end
			end

			local var_526_1 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_1 then
				arg_523_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_523_1.time_ - 0) / var_526_1)
			end

			if arg_523_1.time_ >= 0 + var_526_1 and arg_523_1.time_ < 0 + var_526_1 + arg_526_0 then
				arg_523_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_526_2 = 0

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_2 + arg_526_0 then
				arg_523_1.allBtn_.enabled = false
			end

			if arg_523_1.time_ >= var_526_2 + 0.333333333333333 and arg_523_1.time_ < var_526_2 + 0.333333333333333 + arg_526_0 then
				arg_523_1.allBtn_.enabled = true
			end

			if arg_523_1.frameCnt_ <= 1 then
				arg_523_1.dialog_:SetActive(false)
			end

			local var_526_3 = 0.333333333333333
			local var_526_4 = 0.825

			if 0.333333333333333 < arg_523_1.time_ and arg_523_1.time_ <= var_526_3 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0

				arg_523_1.dialog_:SetActive(true)

				arg_523_1.dialogCg_.alpha = 0

				local var_526_5 = LeanTween.value(arg_523_1.dialog_, 0, 1, 0.3)

				var_526_5:setOnUpdate(LuaHelper.FloatAction(function(arg_527_0)
					arg_523_1.dialogCg_.alpha = arg_527_0
				end))
				var_526_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_523_1.dialog_)
					var_526_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_523_1.duration_ = arg_523_1.duration_ + 0.3

				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_6 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(413122129).content)

				arg_523_1.text_.text = var_526_6

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_8 = 33 <= 0 and var_526_4 or var_526_4 * (utf8.len(var_526_6) / 33)

				if (33 <= 0 and var_526_4 or var_526_4 * (utf8.len(var_526_6) / 33)) > 0 and var_526_4 < var_526_8 then
					arg_523_1.talkMaxDuration = var_526_8
					var_526_3 = var_526_3 + 0.3

					if var_526_8 + var_526_3 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_3
					end
				end

				arg_523_1.text_.text = var_526_6
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_9 = var_526_3 + 0.3
			local var_526_10 = math.max(var_526_4, arg_523_1.talkMaxDuration)

			if var_526_3 + 0.3 <= arg_523_1.time_ and arg_523_1.time_ < var_526_9 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_9) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_9 + var_526_10 and arg_523_1.time_ < var_526_9 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play413122130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 413122130
		arg_529_1.duration_ = 6.33

		local var_529_0 = {
			zh = 3.466,
			ja = 6.333
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
			arg_529_1.auto_ = false
		end

		function arg_529_1.playNext_(arg_531_0)
			arg_529_1.onStoryFinished_()
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 0.475

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_529_1.callingController_:SetSelectedState("calling")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_1 = arg_529_1:GetWordFromCfg(413122130)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 19 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 19)

				if (19 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 19)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413122", "413122130", "story_v_out_413122.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_out_413122", "413122130", "story_v_out_413122.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_out_413122", "413122130", "story_v_out_413122.awb")

						arg_529_1:RecordAudio("413122130", var_532_6)
						arg_529_1:RecordAudio("413122130", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_413122", "413122130", "story_v_out_413122.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_413122", "413122130", "story_v_out_413122.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0603a"
	},
	voices = {
		"story_v_out_413122.awb"
	}
}
