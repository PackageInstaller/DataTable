return {
	Play413042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413042001
		arg_1_1.duration_ = 7.1

		local var_1_0 = {
			zh = 7.1,
			ja = 6.233
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
				arg_1_0:Play413042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F10f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10f")
				var_4_0.name = "F10f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F10f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F10f

				arg_1_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F10f" then
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

			local var_4_9 = "10022"

			if arg_1_1.actors_["10022"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

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

			local var_4_12 = arg_1_1.actors_["10022"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10022 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10022", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_8" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_1_1.time_ - 2) / var_4_14)
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -315, -320)
			end

			local var_4_15 = arg_1_1.actors_["10022"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10022 == nil then
				arg_1_1.var_.actorSpriteComps10022 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10022 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10022 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.75

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(413042001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 30 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 30)

				if (30 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 30)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042001", "story_v_out_413042.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_413042", "413042001", "story_v_out_413042.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_413042", "413042001", "story_v_out_413042.awb")

						arg_1_1:RecordAudio("413042001", var_4_32)
						arg_1_1:RecordAudio("413042001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413042", "413042001", "story_v_out_413042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413042", "413042001", "story_v_out_413042.awb")
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413042002
		arg_9_1.duration_ = 12.3

		local var_9_0 = {
			zh = 12.3,
			ja = 3
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
				arg_9_0:Play413042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10097"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10097"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10097"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10097"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10097 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10097", 2)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_3" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_12_5 = arg_9_1.actors_["10022"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10022 == nil then
				arg_9_1.var_.actorSpriteComps10022 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10022 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			local var_12_8 = arg_9_1.actors_["10097"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10097 == nil then
				arg_9_1.var_.actorSpriteComps10097 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.actorSpriteComps10097 then
					for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_12_8 then
							if arg_9_1.isInRecall_ then
								iter_12_8.color = Color.New(Mathf.Lerp(iter_12_8.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_9), Mathf.Lerp(iter_12_8.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_9), (Mathf.Lerp(iter_12_8.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_9)))
							else
								local var_12_10 = Mathf.Lerp(iter_12_8.color.r, 1, (arg_9_1.time_ - 0) / var_12_9)

								iter_12_8.color = Color.New(var_12_10, var_12_10, var_12_10)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps10097 then
				for iter_12_9, iter_12_10 in pairs(arg_9_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_12_10 then
						iter_12_10.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_11 = arg_9_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_11 then
					arg_9_1.var_.alphaOldValue10097 = var_12_11.alpha
					arg_9_1.var_.characterEffect10097 = var_12_11
				end

				arg_9_1.var_.alphaOldValue10097 = 0
			end

			local var_12_12 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_12 then
				if arg_9_1.var_.characterEffect10097 then
					arg_9_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10097, 1, (arg_9_1.time_ - 0) / var_12_12)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_12 and arg_9_1.time_ < 0 + var_12_12 + arg_12_0 and arg_9_1.var_.characterEffect10097 then
				arg_9_1.var_.characterEffect10097.alpha = 1
			end

			local var_12_13 = arg_9_1.actors_["10022"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_13.localPosition
				var_12_13.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 4)

				for iter_12_11 = 0, var_12_13.childCount - 1 do
					local var_12_14 = var_12_13:GetChild(iter_12_11)

					if var_12_14.name == "split_8" or not string.find(var_12_14.name, "split") then
						var_12_14.gameObject:SetActive(true)
					else
						var_12_14.gameObject:SetActive(false)
					end
				end
			end

			local var_12_15 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 then
				var_12_13.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_9_1.time_ - 0) / var_12_15)
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 then
				var_12_13.localPosition = Vector3.New(390, -315, -320)
			end

			local var_12_16 = 0
			local var_12_17 = 0.875

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(413042002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 35 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 35)

				if (35 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 35)) > 0 and var_12_17 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_16
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042002", "story_v_out_413042.awb") ~= 0 then
					local var_12_22 = manager.audio:GetVoiceLength("story_v_out_413042", "413042002", "story_v_out_413042.awb") / 1000

					if var_12_22 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_16
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_413042", "413042002", "story_v_out_413042.awb")

						arg_9_1:RecordAudio("413042002", var_12_23)
						arg_9_1:RecordAudio("413042002", var_12_23)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413042", "413042002", "story_v_out_413042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413042", "413042002", "story_v_out_413042.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_24 = math.max(var_12_17, arg_9_1.talkMaxDuration)

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_24 and arg_9_1.time_ < var_12_16 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413042003
		arg_13_1.duration_ = 7.33

		local var_13_0 = {
			zh = 7.333,
			ja = 5.533
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
				arg_13_0:Play413042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.75

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(413042003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 30)

				if (30 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 30)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042003", "story_v_out_413042.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042003", "story_v_out_413042.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_413042", "413042003", "story_v_out_413042.awb")

						arg_13_1:RecordAudio("413042003", var_16_6)
						arg_13_1:RecordAudio("413042003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413042", "413042003", "story_v_out_413042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413042", "413042003", "story_v_out_413042.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413042004
		arg_17_1.duration_ = 5.93

		local var_17_0 = {
			zh = 3.866,
			ja = 5.933
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
				arg_17_0:Play413042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10022"]) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = arg_17_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10022"]) then
				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 1, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10022"]) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_2 = arg_17_1.actors_["10097"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10097 == nil then
				arg_17_1.var_.actorSpriteComps10097 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10097 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								iter_20_5.color = Color.New(Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_5.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_5.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10097 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_20_7 then
						iter_20_7.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10097 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(413042004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 23 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 23)

				if (23 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 23)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042004", "story_v_out_413042.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042004", "story_v_out_413042.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_413042", "413042004", "story_v_out_413042.awb")

						arg_17_1:RecordAudio("413042004", var_20_12)
						arg_17_1:RecordAudio("413042004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413042", "413042004", "story_v_out_413042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413042", "413042004", "story_v_out_413042.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413042005
		arg_21_1.duration_ = 10.9

		local var_21_0 = {
			zh = 6.733,
			ja = 10.9
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
				arg_21_0:Play413042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10022"]) and arg_21_1.var_.actorSpriteComps10022 == nil then
				arg_21_1.var_.actorSpriteComps10022 = arg_21_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10022"]) then
				if arg_21_1.var_.actorSpriteComps10022 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10022"]) and arg_21_1.var_.actorSpriteComps10022 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10022 = nil
			end

			local var_24_2 = arg_21_1.actors_["10097"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10097 == nil then
				arg_21_1.var_.actorSpriteComps10097 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10097 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10097 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10097 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(413042005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 18 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 18)

				if (18 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 18)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042005", "story_v_out_413042.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042005", "story_v_out_413042.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_413042", "413042005", "story_v_out_413042.awb")

						arg_21_1:RecordAudio("413042005", var_24_12)
						arg_21_1:RecordAudio("413042005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413042", "413042005", "story_v_out_413042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413042", "413042005", "story_v_out_413042.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413042006
		arg_25_1.duration_ = 10.63

		local var_25_0 = {
			zh = 9.533,
			ja = 10.633
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
				arg_25_0:Play413042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.9

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(413042006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 36 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 36)

				if (36 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 36)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042006", "story_v_out_413042.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042006", "story_v_out_413042.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_413042", "413042006", "story_v_out_413042.awb")

						arg_25_1:RecordAudio("413042006", var_28_6)
						arg_25_1:RecordAudio("413042006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413042", "413042006", "story_v_out_413042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413042", "413042006", "story_v_out_413042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play413042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413042007
		arg_29_1.duration_ = 8.2

		local var_29_0 = {
			zh = 7.2,
			ja = 8.2
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
				arg_29_0:Play413042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = arg_29_1.actors_["10022"].transform.localPosition
				arg_29_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 4)

				for iter_32_0 = 0, arg_29_1.actors_["10022"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10022"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_1" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_32_2 = arg_29_1.actors_["10097"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10097 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10097", 2)

				for iter_32_1 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_1)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_32_5 = arg_29_1.actors_["10022"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								iter_32_3.color = Color.New(Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_6), Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_6), (Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_6)))
							else
								local var_32_7 = Mathf.Lerp(iter_32_3.color.r, 1, (arg_29_1.time_ - 0) / var_32_6)

								iter_32_3.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_5 then
						iter_32_5.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_8 = arg_29_1.actors_["10097"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10097 == nil then
				arg_29_1.var_.actorSpriteComps10097 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 and not isNil(var_32_8) then
				if arg_29_1.var_.actorSpriteComps10097 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								iter_32_7.color = Color.New(Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_9), Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_9), (Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_9)))
							else
								local var_32_10 = Mathf.Lerp(iter_32_7.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_9)

								iter_32_7.color = Color.New(var_32_10, var_32_10, var_32_10)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10097 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_32_9 then
						iter_32_9.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10097 = nil
			end

			local var_32_11 = 0
			local var_32_12 = 0.7

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:GetWordFromCfg(413042007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 28 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 28)

				if (28 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 28)) > 0 and var_32_12 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16

					if var_32_16 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042007", "story_v_out_413042.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042007", "story_v_out_413042.awb") / 1000

					if var_32_17 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_11
					end

					if var_32_13.prefab_name ~= "" and arg_29_1.actors_[var_32_13.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_13.prefab_name].transform, "story_v_out_413042", "413042007", "story_v_out_413042.awb")

						arg_29_1:RecordAudio("413042007", var_32_18)
						arg_29_1:RecordAudio("413042007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413042", "413042007", "story_v_out_413042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413042", "413042007", "story_v_out_413042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_19 and arg_29_1.time_ < var_32_11 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413042008
		arg_33_1.duration_ = 9.9

		local var_33_0 = {
			zh = 9.9,
			ja = 7.333
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
				arg_33_0:Play413042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10097 = arg_33_1.actors_["10097"].transform.localPosition
				arg_33_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10097", 2)

				for iter_36_0 = 0, arg_33_1.actors_["10097"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10097"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_2" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_36_2 = arg_33_1.actors_["10022"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_5 = arg_33_1.actors_["10097"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10097 == nil then
				arg_33_1.var_.actorSpriteComps10097 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps10097 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								iter_36_6.color = Color.New(Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_6.color.r, 1, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_6.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps10097 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_36_8 then
						iter_36_8.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10097 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(413042008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 33 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 33)

				if (33 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 33)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042008", "story_v_out_413042.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042008", "story_v_out_413042.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_413042", "413042008", "story_v_out_413042.awb")

						arg_33_1:RecordAudio("413042008", var_36_15)
						arg_33_1:RecordAudio("413042008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413042", "413042008", "story_v_out_413042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413042", "413042008", "story_v_out_413042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413042009
		arg_37_1.duration_ = 8.83

		local var_37_0 = {
			zh = 4.8,
			ja = 8.833
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
				arg_37_0:Play413042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10022"]) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = arg_37_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10022"]) then
				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10022"]) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_2 = arg_37_1.actors_["10097"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10097 == nil then
				arg_37_1.var_.actorSpriteComps10097 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10097 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10097 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10097 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(413042009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 26 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 26)

				if (26 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 26)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042009", "story_v_out_413042.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042009", "story_v_out_413042.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_413042", "413042009", "story_v_out_413042.awb")

						arg_37_1:RecordAudio("413042009", var_40_12)
						arg_37_1:RecordAudio("413042009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413042", "413042009", "story_v_out_413042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413042", "413042009", "story_v_out_413042.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play413042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413042010
		arg_41_1.duration_ = 14

		local var_41_0 = {
			zh = 9.333,
			ja = 14
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
				arg_41_0:Play413042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10022 = arg_41_1.actors_["10022"].transform.localPosition
				arg_41_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10022", 4)

				for iter_44_0 = 0, arg_41_1.actors_["10022"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10022"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_44_2 = 0
			local var_44_3 = 1.175

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
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

				local var_44_4 = arg_41_1:GetWordFromCfg(413042010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 47 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 47)

				if (47 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 47)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042010", "story_v_out_413042.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042010", "story_v_out_413042.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_413042", "413042010", "story_v_out_413042.awb")

						arg_41_1:RecordAudio("413042010", var_44_9)
						arg_41_1:RecordAudio("413042010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413042", "413042010", "story_v_out_413042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413042", "413042010", "story_v_out_413042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
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
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play413042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413042011
		arg_45_1.duration_ = 13.53

		local var_45_0 = {
			zh = 6.6,
			ja = 13.533
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
				arg_45_0:Play413042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.85

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(413042011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)

				if (34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042011", "story_v_out_413042.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042011", "story_v_out_413042.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_413042", "413042011", "story_v_out_413042.awb")

						arg_45_1:RecordAudio("413042011", var_48_6)
						arg_45_1:RecordAudio("413042011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413042", "413042011", "story_v_out_413042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413042", "413042011", "story_v_out_413042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play413042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413042012
		arg_49_1.duration_ = 8.13

		local var_49_0 = {
			zh = 8.133,
			ja = 6.1
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
				arg_49_0:Play413042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10022 = arg_49_1.actors_["10022"].transform.localPosition
				arg_49_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10022", 4)

				for iter_52_0 = 0, arg_49_1.actors_["10022"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["10022"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_52_2 = arg_49_1.actors_["10097"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10097 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10097", 2)

				for iter_52_1 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_1)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_52_5 = arg_49_1.actors_["10022"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								iter_52_3.color = Color.New(Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_6), Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_6), (Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_6)))
							else
								local var_52_7 = Mathf.Lerp(iter_52_3.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_6)

								iter_52_3.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_5 then
						iter_52_5.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_8 = arg_49_1.actors_["10097"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10097 == nil then
				arg_49_1.var_.actorSpriteComps10097 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_9 and not isNil(var_52_8) then
				if arg_49_1.var_.actorSpriteComps10097 then
					for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_52_7 then
							if arg_49_1.isInRecall_ then
								iter_52_7.color = Color.New(Mathf.Lerp(iter_52_7.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_9), Mathf.Lerp(iter_52_7.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_9), (Mathf.Lerp(iter_52_7.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_9)))
							else
								local var_52_10 = Mathf.Lerp(iter_52_7.color.r, 1, (arg_49_1.time_ - 0) / var_52_9)

								iter_52_7.color = Color.New(var_52_10, var_52_10, var_52_10)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_9 and arg_49_1.time_ < 0 + var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10097 then
				for iter_52_8, iter_52_9 in pairs(arg_49_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_52_9 then
						iter_52_9.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10097 = nil
			end

			local var_52_11 = 0
			local var_52_12 = 0.7

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(413042012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 28 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 28)

				if (28 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 28)) > 0 and var_52_12 < var_52_16 then
					arg_49_1.talkMaxDuration = var_52_16

					if var_52_16 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042012", "story_v_out_413042.awb") ~= 0 then
					local var_52_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042012", "story_v_out_413042.awb") / 1000

					if var_52_17 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_11
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_413042", "413042012", "story_v_out_413042.awb")

						arg_49_1:RecordAudio("413042012", var_52_18)
						arg_49_1:RecordAudio("413042012", var_52_18)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413042", "413042012", "story_v_out_413042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413042", "413042012", "story_v_out_413042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_19 and arg_49_1.time_ < var_52_11 + var_52_19 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413042013
		arg_53_1.duration_ = 11

		local var_53_0 = {
			zh = 8.333,
			ja = 11
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
				arg_53_0:Play413042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(413042013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 33 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 33)

				if (33 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 33)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042013", "story_v_out_413042.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042013", "story_v_out_413042.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_413042", "413042013", "story_v_out_413042.awb")

						arg_53_1:RecordAudio("413042013", var_56_6)
						arg_53_1:RecordAudio("413042013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413042", "413042013", "story_v_out_413042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413042", "413042013", "story_v_out_413042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413042014
		arg_57_1.duration_ = 9.97

		local var_57_0 = {
			zh = 6.4,
			ja = 9.966
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
				arg_57_0:Play413042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10022 = arg_57_1.actors_["10022"].transform.localPosition
				arg_57_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10022", 4)

				for iter_60_0 = 0, arg_57_1.actors_["10022"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10022"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_8" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_60_2 = arg_57_1.actors_["10097"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10097 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10097", 2)

				for iter_60_1 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_1)

					if var_60_3.name == "split_1" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_60_5 = arg_57_1.actors_["10022"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								iter_60_3.color = Color.New(Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_6), Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_6), (Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_6)))
							else
								local var_60_7 = Mathf.Lerp(iter_60_3.color.r, 1, (arg_57_1.time_ - 0) / var_60_6)

								iter_60_3.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_5 then
						iter_60_5.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_8 = arg_57_1.actors_["10097"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10097 == nil then
				arg_57_1.var_.actorSpriteComps10097 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_9 and not isNil(var_60_8) then
				if arg_57_1.var_.actorSpriteComps10097 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								iter_60_7.color = Color.New(Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_9), Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_9), (Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_9)))
							else
								local var_60_10 = Mathf.Lerp(iter_60_7.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_9)

								iter_60_7.color = Color.New(var_60_10, var_60_10, var_60_10)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_9 and arg_57_1.time_ < 0 + var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10097 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_60_9 then
						iter_60_9.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10097 = nil
			end

			local var_60_11 = 0
			local var_60_12 = 0.825

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:GetWordFromCfg(413042014)
				local var_60_14 = arg_57_1:FormatText(var_60_13.content)

				arg_57_1.text_.text = var_60_14

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 33 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 33)

				if (33 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 33)) > 0 and var_60_12 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_14
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042014", "story_v_out_413042.awb") ~= 0 then
					local var_60_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042014", "story_v_out_413042.awb") / 1000

					if var_60_17 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_11
					end

					if var_60_13.prefab_name ~= "" and arg_57_1.actors_[var_60_13.prefab_name] ~= nil then
						local var_60_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_13.prefab_name].transform, "story_v_out_413042", "413042014", "story_v_out_413042.awb")

						arg_57_1:RecordAudio("413042014", var_60_18)
						arg_57_1:RecordAudio("413042014", var_60_18)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413042", "413042014", "story_v_out_413042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413042", "413042014", "story_v_out_413042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_19 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_19 and arg_57_1.time_ < var_60_11 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413042015
		arg_61_1.duration_ = 14.1

		local var_61_0 = {
			zh = 8,
			ja = 14.1
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
				arg_61_0:Play413042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
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

				local var_64_1 = arg_61_1:GetWordFromCfg(413042015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 43)

				if (43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 43)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042015", "story_v_out_413042.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042015", "story_v_out_413042.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_413042", "413042015", "story_v_out_413042.awb")

						arg_61_1:RecordAudio("413042015", var_64_6)
						arg_61_1:RecordAudio("413042015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413042", "413042015", "story_v_out_413042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413042", "413042015", "story_v_out_413042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413042016
		arg_65_1.duration_ = 12.77

		local var_65_0 = {
			zh = 12.766,
			ja = 11.866
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
				arg_65_0:Play413042017(arg_65_1)
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
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10022"]) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_2 = arg_65_1.actors_["10097"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10097 == nil then
				arg_65_1.var_.actorSpriteComps10097 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10097 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10097 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10097 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.95

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(413042016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 38 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 38)

				if (38 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 38)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042016", "story_v_out_413042.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042016", "story_v_out_413042.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_413042", "413042016", "story_v_out_413042.awb")

						arg_65_1:RecordAudio("413042016", var_68_12)
						arg_65_1:RecordAudio("413042016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413042", "413042016", "story_v_out_413042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413042", "413042016", "story_v_out_413042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413042017
		arg_69_1.duration_ = 2

		local var_69_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_69_0:Play413042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10022 = arg_69_1.actors_["10022"].transform.localPosition
				arg_69_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10022", 4)

				for iter_72_0 = 0, arg_69_1.actors_["10022"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10022"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_3" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_72_2 = arg_69_1.actors_["10097"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10097 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10097", 2)

				for iter_72_1 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_1)

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_72_5 = arg_69_1.actors_["10022"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10022 == nil then
				arg_69_1.var_.actorSpriteComps10022 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps10022 then
					for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_72_3 then
							if arg_69_1.isInRecall_ then
								iter_72_3.color = Color.New(Mathf.Lerp(iter_72_3.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_3.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_3.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_3.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_3.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10022 then
				for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_72_5 then
						iter_72_5.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10022 = nil
			end

			local var_72_8 = arg_69_1.actors_["10097"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10097 == nil then
				arg_69_1.var_.actorSpriteComps10097 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.actorSpriteComps10097 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								iter_72_7.color = Color.New(Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_9), Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_9), (Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_9)))
							else
								local var_72_10 = Mathf.Lerp(iter_72_7.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_9)

								iter_72_7.color = Color.New(var_72_10, var_72_10, var_72_10)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10097 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_72_9 then
						iter_72_9.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10097 = nil
			end

			local var_72_11 = 0
			local var_72_12 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(413042017)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 6 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 6)

				if (6 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 6)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042017", "story_v_out_413042.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042017", "story_v_out_413042.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_413042", "413042017", "story_v_out_413042.awb")

						arg_69_1:RecordAudio("413042017", var_72_18)
						arg_69_1:RecordAudio("413042017", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413042", "413042017", "story_v_out_413042.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413042", "413042017", "story_v_out_413042.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_19 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_11) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_11 + var_72_19 and arg_69_1.time_ < var_72_11 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413042018
		arg_73_1.duration_ = 6.57

		local var_73_0 = {
			zh = 6.566,
			ja = 5.033
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
				arg_73_0:Play413042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10097 = arg_73_1.actors_["10097"].transform.localPosition
				arg_73_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10097", 2)

				for iter_76_0 = 0, arg_73_1.actors_["10097"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10097"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_76_2 = arg_73_1.actors_["10022"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								iter_76_2.color = Color.New(Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_2.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_2.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_5 = arg_73_1.actors_["10097"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10097 == nil then
				arg_73_1.var_.actorSpriteComps10097 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10097 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								iter_76_6.color = Color.New(Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_6.color.r, 1, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_6.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10097 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_76_8 then
						iter_76_8.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10097 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.55

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(413042018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 22 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 22)

				if (22 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 22)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042018", "story_v_out_413042.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042018", "story_v_out_413042.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_413042", "413042018", "story_v_out_413042.awb")

						arg_73_1:RecordAudio("413042018", var_76_15)
						arg_73_1:RecordAudio("413042018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413042", "413042018", "story_v_out_413042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413042", "413042018", "story_v_out_413042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413042019
		arg_77_1.duration_ = 10.9

		local var_77_0 = {
			zh = 6.566,
			ja = 10.9
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
				arg_77_0:Play413042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(413042019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 28)

				if (28 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 28)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042019", "story_v_out_413042.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042019", "story_v_out_413042.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_413042", "413042019", "story_v_out_413042.awb")

						arg_77_1:RecordAudio("413042019", var_80_6)
						arg_77_1:RecordAudio("413042019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413042", "413042019", "story_v_out_413042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413042", "413042019", "story_v_out_413042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play413042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413042020
		arg_81_1.duration_ = 14.33

		local var_81_0 = {
			zh = 4.366,
			ja = 14.333
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
				arg_81_0:Play413042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10022 = arg_81_1.actors_["10022"].transform.localPosition
				arg_81_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10022", 0)

				for iter_84_0 = 0, arg_81_1.actors_["10022"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10022"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_84_2 = arg_81_1.actors_["10097"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10097 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10097", 0)

				for iter_84_1 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_1)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_84_5 = "10092"

			if arg_81_1.actors_["10092"] == nil then
				local var_84_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_84_6) then
					local var_84_7 = Object.Instantiate(var_84_6, arg_81_1.canvasGo_.transform)

					var_84_7.transform:SetSiblingIndex(1)

					var_84_7.name = var_84_5
					var_84_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_81_1.actors_[var_84_5] = var_84_7

					if arg_81_1.isInRecall_ then
						for iter_84_2, iter_84_3 in ipairs((var_84_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_84_8 = arg_81_1.actors_["10092"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092 = var_84_8.localPosition
				var_84_8.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092", 3)

				for iter_84_4 = 0, var_84_8.childCount - 1 do
					local var_84_9 = var_84_8:GetChild(iter_84_4)

					if var_84_9.name == "split_5" or not string.find(var_84_9.name, "split") then
						var_84_9.gameObject:SetActive(true)
					else
						var_84_9.gameObject:SetActive(false)
					end
				end
			end

			local var_84_10 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_10 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_81_1.time_ - 0) / var_84_10)
			end

			if arg_81_1.time_ >= 0 + var_84_10 and arg_81_1.time_ < 0 + var_84_10 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, -300, -295)
			end

			local var_84_11 = arg_81_1.actors_["10022"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_12 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_12 and not isNil(var_84_11) then
				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_12), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_12), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_12)))
							else
								local var_84_13 = Mathf.Lerp(iter_84_6.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_12)

								iter_84_6.color = Color.New(var_84_13, var_84_13, var_84_13)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_12 and arg_81_1.time_ < 0 + var_84_12 + arg_84_0 and not isNil(var_84_11) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_14 = arg_81_1.actors_["10097"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.actorSpriteComps10097 == nil then
				arg_81_1.var_.actorSpriteComps10097 = var_84_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_15 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_15 and not isNil(var_84_14) then
				if arg_81_1.var_.actorSpriteComps10097 then
					for iter_84_9, iter_84_10 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_84_10 then
							if arg_81_1.isInRecall_ then
								iter_84_10.color = Color.New(Mathf.Lerp(iter_84_10.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_15), Mathf.Lerp(iter_84_10.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_15), (Mathf.Lerp(iter_84_10.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_15)))
							else
								local var_84_16 = Mathf.Lerp(iter_84_10.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_15)

								iter_84_10.color = Color.New(var_84_16, var_84_16, var_84_16)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_15 and arg_81_1.time_ < 0 + var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.actorSpriteComps10097 then
				for iter_84_11, iter_84_12 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_84_12 then
						iter_84_12.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10097 = nil
			end

			local var_84_17 = arg_81_1.actors_["10092"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_17) and arg_81_1.var_.actorSpriteComps10092 == nil then
				arg_81_1.var_.actorSpriteComps10092 = var_84_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_18 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_18 and not isNil(var_84_17) then
				if arg_81_1.var_.actorSpriteComps10092 then
					for iter_84_13, iter_84_14 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_84_14 then
							if arg_81_1.isInRecall_ then
								iter_84_14.color = Color.New(Mathf.Lerp(iter_84_14.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_18), Mathf.Lerp(iter_84_14.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_18), (Mathf.Lerp(iter_84_14.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_18)))
							else
								local var_84_19 = Mathf.Lerp(iter_84_14.color.r, 1, (arg_81_1.time_ - 0) / var_84_18)

								iter_84_14.color = Color.New(var_84_19, var_84_19, var_84_19)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_18 and arg_81_1.time_ < 0 + var_84_18 + arg_84_0 and not isNil(var_84_17) and arg_81_1.var_.actorSpriteComps10092 then
				for iter_84_15, iter_84_16 in pairs(arg_81_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_84_16 then
						iter_84_16.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10092 = nil
			end

			local var_84_20 = 0
			local var_84_21 = 0.55

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
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

				local var_84_22 = arg_81_1:GetWordFromCfg(413042020)
				local var_84_23 = arg_81_1:FormatText(var_84_22.content)

				arg_81_1.text_.text = var_84_23

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_25 = 22 <= 0 and var_84_21 or var_84_21 * (utf8.len(var_84_23) / 22)

				if (22 <= 0 and var_84_21 or var_84_21 * (utf8.len(var_84_23) / 22)) > 0 and var_84_21 < var_84_25 then
					arg_81_1.talkMaxDuration = var_84_25

					if var_84_25 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_25 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_23
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042020", "story_v_out_413042.awb") ~= 0 then
					local var_84_26 = manager.audio:GetVoiceLength("story_v_out_413042", "413042020", "story_v_out_413042.awb") / 1000

					if var_84_26 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_26 + var_84_20
					end

					if var_84_22.prefab_name ~= "" and arg_81_1.actors_[var_84_22.prefab_name] ~= nil then
						local var_84_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_22.prefab_name].transform, "story_v_out_413042", "413042020", "story_v_out_413042.awb")

						arg_81_1:RecordAudio("413042020", var_84_27)
						arg_81_1:RecordAudio("413042020", var_84_27)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413042", "413042020", "story_v_out_413042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413042", "413042020", "story_v_out_413042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_28 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_28 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_28

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_28 and arg_81_1.time_ < var_84_20 + var_84_28 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413042021
		arg_85_1.duration_ = 9.83

		local var_85_0 = {
			zh = 9.633,
			ja = 9.833
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
				arg_85_0:Play413042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.95

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
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

				local var_88_1 = arg_85_1:GetWordFromCfg(413042021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 38 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 38)

				if (38 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 38)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042021", "story_v_out_413042.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042021", "story_v_out_413042.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_413042", "413042021", "story_v_out_413042.awb")

						arg_85_1:RecordAudio("413042021", var_88_6)
						arg_85_1:RecordAudio("413042021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413042", "413042021", "story_v_out_413042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413042", "413042021", "story_v_out_413042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413042022
		arg_89_1.duration_ = 3.8

		local var_89_0 = {
			zh = 3.6,
			ja = 3.8
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
				arg_89_0:Play413042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.325

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

				local var_92_1 = arg_89_1:GetWordFromCfg(413042022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 13 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 13)

				if (13 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 13)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042022", "story_v_out_413042.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042022", "story_v_out_413042.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413042", "413042022", "story_v_out_413042.awb")

						arg_89_1:RecordAudio("413042022", var_92_6)
						arg_89_1:RecordAudio("413042022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413042", "413042022", "story_v_out_413042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413042", "413042022", "story_v_out_413042.awb")
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
	Play413042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413042023
		arg_93_1.duration_ = 2.47

		local var_93_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = arg_93_1.actors_["10092"].transform.localPosition
				arg_93_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 0)

				for iter_96_0 = 0, arg_93_1.actors_["10092"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10092"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_96_2 = arg_93_1.actors_["10022"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 3)

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

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_96_5 = arg_93_1.actors_["10092"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_8 = arg_93_1.actors_["10022"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 1, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(413042023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 3 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 3)

				if (3 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 3)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042023", "story_v_out_413042.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042023", "story_v_out_413042.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_413042", "413042023", "story_v_out_413042.awb")

						arg_93_1:RecordAudio("413042023", var_96_18)
						arg_93_1:RecordAudio("413042023", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413042", "413042023", "story_v_out_413042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413042", "413042023", "story_v_out_413042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413042024
		arg_97_1.duration_ = 2.87

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10092 = arg_97_1.actors_["10092"].transform.localPosition
				arg_97_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10092", 3)

				for iter_100_0 = 0, arg_97_1.actors_["10092"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10092"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_100_2 = arg_97_1.actors_["10022"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10022 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10022", 0)

				for iter_100_1 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_1)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10022, Vector3.New(0, -5000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_100_5 = arg_97_1.actors_["10092"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								iter_100_3.color = Color.New(Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_3.color.r, 1, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_3.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_5 then
						iter_100_5.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_8 = arg_97_1.actors_["10022"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10022 == nil then
				arg_97_1.var_.actorSpriteComps10022 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.actorSpriteComps10022 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								iter_100_7.color = Color.New(Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_9), Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_9), (Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_9)))
							else
								local var_100_10 = Mathf.Lerp(iter_100_7.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_9)

								iter_100_7.color = Color.New(var_100_10, var_100_10, var_100_10)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10022 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_100_9 then
						iter_100_9.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10022 = nil
			end

			local var_100_11 = 0
			local var_100_12 = 0.075

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(413042024)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 3 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 3)

				if (3 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 3)) > 0 and var_100_12 < var_100_16 then
					arg_97_1.talkMaxDuration = var_100_16

					if var_100_16 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042024", "story_v_out_413042.awb") ~= 0 then
					local var_100_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042024", "story_v_out_413042.awb") / 1000

					if var_100_17 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_11
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_413042", "413042024", "story_v_out_413042.awb")

						arg_97_1:RecordAudio("413042024", var_100_18)
						arg_97_1:RecordAudio("413042024", var_100_18)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413042", "413042024", "story_v_out_413042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413042", "413042024", "story_v_out_413042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_19 and arg_97_1.time_ < var_100_11 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_97_1:InitPlayNodeList()
	end,
	Play413042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413042025
		arg_101_1.duration_ = 10.8

		local var_101_0 = {
			zh = 5.633,
			ja = 10.8
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(413042025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)

				if (28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042025", "story_v_out_413042.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042025", "story_v_out_413042.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_413042", "413042025", "story_v_out_413042.awb")

						arg_101_1:RecordAudio("413042025", var_104_6)
						arg_101_1:RecordAudio("413042025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413042", "413042025", "story_v_out_413042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413042", "413042025", "story_v_out_413042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413042026
		arg_105_1.duration_ = 9.37

		local var_105_0 = {
			zh = 5.333,
			ja = 9.366
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
				arg_105_0:Play413042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092 = arg_105_1.actors_["10092"].transform.localPosition
				arg_105_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092", 0)

				for iter_108_0 = 0, arg_105_1.actors_["10092"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10092"].transform:GetChild(iter_108_0)

					if var_108_0.name == "" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_108_2 = arg_105_1.actors_["10022"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10022 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10022", 3)

				for iter_108_1 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_1)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_108_5 = arg_105_1.actors_["10022"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10022 == nil then
				arg_105_1.var_.actorSpriteComps10022 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps10022 then
					for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_108_3 then
							if arg_105_1.isInRecall_ then
								iter_108_3.color = Color.New(Mathf.Lerp(iter_108_3.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_3.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_3.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_3.color.r, 1, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_3.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10022 then
				for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_108_5 then
						iter_108_5.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10022 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(413042026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 27 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 27)

				if (27 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 27)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042026", "story_v_out_413042.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042026", "story_v_out_413042.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_413042", "413042026", "story_v_out_413042.awb")

						arg_105_1:RecordAudio("413042026", var_108_15)
						arg_105_1:RecordAudio("413042026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413042", "413042026", "story_v_out_413042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413042", "413042026", "story_v_out_413042.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_105_1:InitPlayNodeList()
	end,
	Play413042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413042027
		arg_109_1.duration_ = 6.3

		local var_109_0 = {
			zh = 2.766,
			ja = 6.3
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = arg_109_1.actors_["10022"].transform.localPosition
				arg_109_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 0)

				for iter_112_0 = 0, arg_109_1.actors_["10022"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10022"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_112_2 = arg_109_1.actors_["10097"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10097 = var_112_2.localPosition
				var_112_2.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10097", 3)

				for iter_112_1 = 0, var_112_2.childCount - 1 do
					local var_112_3 = var_112_2:GetChild(iter_112_1)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_2.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_109_1.time_ - 0) / var_112_4)
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_112_5 = arg_109_1.actors_["10022"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10022 == nil then
				arg_109_1.var_.actorSpriteComps10022 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps10022 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								iter_112_3.color = Color.New(Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_3.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_3.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10022 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_112_5 then
						iter_112_5.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10022 = nil
			end

			local var_112_8 = arg_109_1.actors_["10097"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10097 == nil then
				arg_109_1.var_.actorSpriteComps10097 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_9 and not isNil(var_112_8) then
				if arg_109_1.var_.actorSpriteComps10097 then
					for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_112_7 then
							if arg_109_1.isInRecall_ then
								iter_112_7.color = Color.New(Mathf.Lerp(iter_112_7.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_9), Mathf.Lerp(iter_112_7.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_9), (Mathf.Lerp(iter_112_7.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_9)))
							else
								local var_112_10 = Mathf.Lerp(iter_112_7.color.r, 1, (arg_109_1.time_ - 0) / var_112_9)

								iter_112_7.color = Color.New(var_112_10, var_112_10, var_112_10)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_9 and arg_109_1.time_ < 0 + var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10097 then
				for iter_112_8, iter_112_9 in pairs(arg_109_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_112_9 then
						iter_112_9.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10097 = nil
			end

			local var_112_11 = 0
			local var_112_12 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(413042027)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_16 = 14 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_14) / 14)

				if (14 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_14) / 14)) > 0 and var_112_12 < var_112_16 then
					arg_109_1.talkMaxDuration = var_112_16

					if var_112_16 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_16 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042027", "story_v_out_413042.awb") ~= 0 then
					local var_112_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042027", "story_v_out_413042.awb") / 1000

					if var_112_17 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_11
					end

					if var_112_13.prefab_name ~= "" and arg_109_1.actors_[var_112_13.prefab_name] ~= nil then
						local var_112_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_13.prefab_name].transform, "story_v_out_413042", "413042027", "story_v_out_413042.awb")

						arg_109_1:RecordAudio("413042027", var_112_18)
						arg_109_1:RecordAudio("413042027", var_112_18)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413042", "413042027", "story_v_out_413042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413042", "413042027", "story_v_out_413042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_19 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 <= arg_109_1.time_ and arg_109_1.time_ < var_112_11 + var_112_19 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_11) / var_112_19

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_11 + var_112_19 and arg_109_1.time_ < var_112_11 + var_112_19 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413042028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413042028
		arg_113_1.duration_ = 13.9

		local var_113_0 = {
			zh = 12.2,
			ja = 13.9
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play413042029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.075

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(413042028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 43 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 43)

				if (43 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 43)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042028", "story_v_out_413042.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042028", "story_v_out_413042.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_413042", "413042028", "story_v_out_413042.awb")

						arg_113_1:RecordAudio("413042028", var_116_6)
						arg_113_1:RecordAudio("413042028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413042", "413042028", "story_v_out_413042.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413042", "413042028", "story_v_out_413042.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413042029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413042029
		arg_117_1.duration_ = 6.47

		local var_117_0 = {
			zh = 2.933,
			ja = 6.466
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play413042030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10097 = arg_117_1.actors_["10097"].transform.localPosition
				arg_117_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10097", 0)

				for iter_120_0 = 0, arg_117_1.actors_["10097"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10097"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_120_2 = arg_117_1.actors_["10022"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10022 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10022", 2)

				for iter_120_1 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_1)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_120_5 = arg_117_1.actors_["10097"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10097 == nil then
				arg_117_1.var_.actorSpriteComps10097 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps10097 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								iter_120_3.color = Color.New(Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_3.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_3.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10097 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_120_5 then
						iter_120_5.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10097 = nil
			end

			local var_120_8 = arg_117_1.actors_["10022"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 and not isNil(var_120_8) then
				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								iter_120_7.color = Color.New(Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_9), Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_9), (Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_9)))
							else
								local var_120_10 = Mathf.Lerp(iter_120_7.color.r, 1, (arg_117_1.time_ - 0) / var_120_9)

								iter_120_7.color = Color.New(var_120_10, var_120_10, var_120_10)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_9 then
						iter_120_9.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			local var_120_11 = 0
			local var_120_12 = 0.375

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:GetWordFromCfg(413042029)
				local var_120_14 = arg_117_1:FormatText(var_120_13.content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 15 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 15)

				if (15 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 15)) > 0 and var_120_12 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16

					if var_120_16 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042029", "story_v_out_413042.awb") ~= 0 then
					local var_120_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042029", "story_v_out_413042.awb") / 1000

					if var_120_17 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_11
					end

					if var_120_13.prefab_name ~= "" and arg_117_1.actors_[var_120_13.prefab_name] ~= nil then
						local var_120_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_13.prefab_name].transform, "story_v_out_413042", "413042029", "story_v_out_413042.awb")

						arg_117_1:RecordAudio("413042029", var_120_18)
						arg_117_1:RecordAudio("413042029", var_120_18)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413042", "413042029", "story_v_out_413042.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413042", "413042029", "story_v_out_413042.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_19 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_19

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_19 and arg_117_1.time_ < var_120_11 + var_120_19 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413042030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413042030
		arg_121_1.duration_ = 10.3

		local var_121_0 = {
			zh = 9.533,
			ja = 10.3
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413042031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092 = arg_121_1.actors_["10092"].transform.localPosition
				arg_121_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092", 4)

				for iter_124_0 = 0, arg_121_1.actors_["10092"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10092"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_8" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_124_2 = arg_121_1.actors_["10022"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10022 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10022", 2)

				for iter_124_1 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_1)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_124_5 = arg_121_1.actors_["10092"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10092 == nil then
				arg_121_1.var_.actorSpriteComps10092 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps10092 then
					for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_124_3 then
							if arg_121_1.isInRecall_ then
								iter_124_3.color = Color.New(Mathf.Lerp(iter_124_3.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_3.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_3.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_3.color.r, 1, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_3.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10092 then
				for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_124_5 then
						iter_124_5.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10092 = nil
			end

			local var_124_8 = arg_121_1.actors_["10022"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10022 == nil then
				arg_121_1.var_.actorSpriteComps10022 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_9 and not isNil(var_124_8) then
				if arg_121_1.var_.actorSpriteComps10022 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_124_7 then
							if arg_121_1.isInRecall_ then
								iter_124_7.color = Color.New(Mathf.Lerp(iter_124_7.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_9), Mathf.Lerp(iter_124_7.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_9), (Mathf.Lerp(iter_124_7.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_9)))
							else
								local var_124_10 = Mathf.Lerp(iter_124_7.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_9)

								iter_124_7.color = Color.New(var_124_10, var_124_10, var_124_10)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_9 and arg_121_1.time_ < 0 + var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10022 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_124_9 then
						iter_124_9.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10022 = nil
			end

			local var_124_11 = 0
			local var_124_12 = 1.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(413042030)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 47 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 47)

				if (47 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 47)) > 0 and var_124_12 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042030", "story_v_out_413042.awb") ~= 0 then
					local var_124_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042030", "story_v_out_413042.awb") / 1000

					if var_124_17 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_11
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_413042", "413042030", "story_v_out_413042.awb")

						arg_121_1:RecordAudio("413042030", var_124_18)
						arg_121_1:RecordAudio("413042030", var_124_18)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413042", "413042030", "story_v_out_413042.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413042", "413042030", "story_v_out_413042.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_19 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_19 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_19

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_19 and arg_121_1.time_ < var_124_11 + var_124_19 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_121_1:InitPlayNodeList()
	end,
	Play413042031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413042031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413042032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10092"]) and arg_125_1.var_.actorSpriteComps10092 == nil then
				arg_125_1.var_.actorSpriteComps10092 = arg_125_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10092"]) then
				if arg_125_1.var_.actorSpriteComps10092 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10092"]) and arg_125_1.var_.actorSpriteComps10092 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10092 = nil
			end

			local var_128_2 = 0
			local var_128_3 = 1.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(413042031).content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 50 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 50)

				if (50 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 50)) > 0 and var_128_3 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_7 and arg_125_1.time_ < var_128_2 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play413042032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413042032
		arg_129_1.duration_ = 2.93

		local var_129_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play413042033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10092"]) and arg_129_1.var_.actorSpriteComps10092 == nil then
				arg_129_1.var_.actorSpriteComps10092 = arg_129_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10092"]) then
				if arg_129_1.var_.actorSpriteComps10092 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10092"]) and arg_129_1.var_.actorSpriteComps10092 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10092 = nil
			end

			local var_132_2 = 0
			local var_132_3 = 0.15

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(413042032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 6 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 6)

				if (6 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 6)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042032", "story_v_out_413042.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_413042", "413042032", "story_v_out_413042.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_413042", "413042032", "story_v_out_413042.awb")

						arg_129_1:RecordAudio("413042032", var_132_9)
						arg_129_1:RecordAudio("413042032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413042", "413042032", "story_v_out_413042.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413042", "413042032", "story_v_out_413042.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413042033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413042033
		arg_133_1.duration_ = 6.03

		local var_133_0 = {
			zh = 4.866,
			ja = 6.033
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413042034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10022 = arg_133_1.actors_["10022"].transform.localPosition
				arg_133_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10022", 2)

				for iter_136_0 = 0, arg_133_1.actors_["10022"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10022"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_8" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_136_2 = arg_133_1.actors_["10022"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10022 == nil then
				arg_133_1.var_.actorSpriteComps10022 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10022 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10022 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10022 = nil
			end

			local var_136_5 = arg_133_1.actors_["10092"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10092 == nil then
				arg_133_1.var_.actorSpriteComps10092 = var_136_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_6 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.actorSpriteComps10092 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								iter_136_6.color = Color.New(Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_6), Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_6), (Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_6)))
							else
								local var_136_7 = Mathf.Lerp(iter_136_6.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_6)

								iter_136_6.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10092 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_136_8 then
						iter_136_8.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10092 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.675

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(413042033)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 27 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 27)

				if (27 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 27)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042033", "story_v_out_413042.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042033", "story_v_out_413042.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_413042", "413042033", "story_v_out_413042.awb")

						arg_133_1:RecordAudio("413042033", var_136_15)
						arg_133_1:RecordAudio("413042033", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413042", "413042033", "story_v_out_413042.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413042", "413042033", "story_v_out_413042.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play413042034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413042034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413042035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				local var_140_0 = arg_137_1.bgs_.F10f

				arg_137_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_1 = var_140_0:GetComponent("SpriteRenderer")

				if var_140_1 and var_140_1.sprite then
					local var_140_2 = 2 * (var_140_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_0.transform.localScale = Vector3.New(var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, var_140_2 / var_140_1.sprite.bounds.size.y < var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x and var_140_2 * manager.ui.mainCameraCom_.aspect / var_140_1.sprite.bounds.size.x or var_140_2 / var_140_1.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "F10f" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_3 = 4

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= var_140_3 + 0.3 and arg_137_1.time_ < var_140_3 + 0.3 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end

			local var_140_4 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_5 = 2

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_5 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_4) / var_140_5)
				arg_137_1.mask_.color = var_140_6
			end

			if arg_137_1.time_ >= var_140_4 + var_140_5 and arg_137_1.time_ < var_140_4 + var_140_5 + arg_140_0 then
				local var_140_7 = Color.New(0, 0, 0)

				var_140_7.a = 1
				arg_137_1.mask_.color = var_140_7
			end

			local var_140_8 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_9 = 2

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 then
				local var_140_10 = Color.New(0, 0, 0)

				var_140_10.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_8) / var_140_9)
				arg_137_1.mask_.color = var_140_10
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 then
				local var_140_11 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_11.a = 0
				arg_137_1.mask_.color = var_140_11
			end

			local var_140_12 = arg_137_1.actors_["10022"].transform

			if 1.966 < arg_137_1.time_ and arg_137_1.time_ <= 1.966 + arg_140_0 then
				arg_137_1.var_.moveOldPos10022 = var_140_12.localPosition
				var_140_12.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10022", 0)

				for iter_140_2 = 0, var_140_12.childCount - 1 do
					local var_140_13 = var_140_12:GetChild(iter_140_2)

					if var_140_13.name == "" or not string.find(var_140_13.name, "split") then
						var_140_13.gameObject:SetActive(true)
					else
						var_140_13.gameObject:SetActive(false)
					end
				end
			end

			local var_140_14 = 0.001

			if 1.966 <= arg_137_1.time_ and arg_137_1.time_ < 1.966 + var_140_14 then
				var_140_12.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_137_1.time_ - 1.966) / var_140_14)
			end

			if arg_137_1.time_ >= 1.966 + var_140_14 and arg_137_1.time_ < 1.966 + var_140_14 + arg_140_0 then
				var_140_12.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_140_15 = arg_137_1.actors_["10092"].transform

			if 1.966 < arg_137_1.time_ and arg_137_1.time_ <= 1.966 + arg_140_0 then
				arg_137_1.var_.moveOldPos10092 = var_140_15.localPosition
				var_140_15.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10092", 0)

				for iter_140_3 = 0, var_140_15.childCount - 1 do
					local var_140_16 = var_140_15:GetChild(iter_140_3)

					if var_140_16.name == "" or not string.find(var_140_16.name, "split") then
						var_140_16.gameObject:SetActive(true)
					else
						var_140_16.gameObject:SetActive(false)
					end
				end
			end

			local var_140_17 = 0.001

			if 1.966 <= arg_137_1.time_ and arg_137_1.time_ < 1.966 + var_140_17 then
				var_140_15.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_137_1.time_ - 1.966) / var_140_17)
			end

			if arg_137_1.time_ >= 1.966 + var_140_17 and arg_137_1.time_ < 1.966 + var_140_17 + arg_140_0 then
				var_140_15.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_140_18 = arg_137_1.actors_["10022"]

			if 1.966 < arg_137_1.time_ and arg_137_1.time_ <= 1.966 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.actorSpriteComps10022 == nil then
				arg_137_1.var_.actorSpriteComps10022 = var_140_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_19 = 0.034

			if 1.966 <= arg_137_1.time_ and arg_137_1.time_ < 1.966 + var_140_19 and not isNil(var_140_18) then
				if arg_137_1.var_.actorSpriteComps10022 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								iter_140_5.color = Color.New(Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 1.966) / var_140_19), Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 1.966) / var_140_19), (Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 1.966) / var_140_19)))
							else
								local var_140_20 = Mathf.Lerp(iter_140_5.color.r, 0.5, (arg_137_1.time_ - 1.966) / var_140_19)

								iter_140_5.color = Color.New(var_140_20, var_140_20, var_140_20)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 1.966 + var_140_19 and arg_137_1.time_ < 1.966 + var_140_19 + arg_140_0 and not isNil(var_140_18) and arg_137_1.var_.actorSpriteComps10022 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_140_7 then
						iter_140_7.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10022 = nil
			end

			local var_140_21 = arg_137_1.actors_["10092"]

			if 1.966 < arg_137_1.time_ and arg_137_1.time_ <= 1.966 + arg_140_0 and not isNil(var_140_21) and arg_137_1.var_.actorSpriteComps10092 == nil then
				arg_137_1.var_.actorSpriteComps10092 = var_140_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_22 = 0.034

			if 1.966 <= arg_137_1.time_ and arg_137_1.time_ < 1.966 + var_140_22 and not isNil(var_140_21) then
				if arg_137_1.var_.actorSpriteComps10092 then
					for iter_140_8, iter_140_9 in pairs(arg_137_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_140_9 then
							if arg_137_1.isInRecall_ then
								iter_140_9.color = Color.New(Mathf.Lerp(iter_140_9.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 1.966) / var_140_22), Mathf.Lerp(iter_140_9.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 1.966) / var_140_22), (Mathf.Lerp(iter_140_9.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 1.966) / var_140_22)))
							else
								local var_140_23 = Mathf.Lerp(iter_140_9.color.r, 0.5, (arg_137_1.time_ - 1.966) / var_140_22)

								iter_140_9.color = Color.New(var_140_23, var_140_23, var_140_23)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 1.966 + var_140_22 and arg_137_1.time_ < 1.966 + var_140_22 + arg_140_0 and not isNil(var_140_21) and arg_137_1.var_.actorSpriteComps10092 then
				for iter_140_10, iter_140_11 in pairs(arg_137_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_140_11 then
						iter_140_11.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10092 = nil
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_24 = 4
			local var_140_25 = 1.175

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_24 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_26 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_26:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_27 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(413042034).content)

				arg_137_1.text_.text = var_140_27

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_29 = 47 <= 0 and var_140_25 or var_140_25 * (utf8.len(var_140_27) / 47)

				if (47 <= 0 and var_140_25 or var_140_25 * (utf8.len(var_140_27) / 47)) > 0 and var_140_25 < var_140_29 then
					arg_137_1.talkMaxDuration = var_140_29
					var_140_24 = var_140_24 + 0.3

					if var_140_29 + var_140_24 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_29 + var_140_24
					end
				end

				arg_137_1.text_.text = var_140_27
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_30 = var_140_24 + 0.3
			local var_140_31 = math.max(var_140_25, arg_137_1.talkMaxDuration)

			if var_140_24 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_31 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_31

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_31 and arg_137_1.time_ < var_140_30 + var_140_31 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play413042035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413042035
		arg_143_1.duration_ = 8.67

		local var_143_0 = {
			zh = 5.133,
			ja = 8.666
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
				arg_143_0:Play413042036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if arg_143_1.actors_["10094"] == nil then
				local var_146_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_146_0) then
					local var_146_1 = Object.Instantiate(var_146_0, arg_143_1.canvasGo_.transform)

					var_146_1.transform:SetSiblingIndex(1)

					var_146_1.name = "10094"
					var_146_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_143_1.actors_["10094"] = var_146_1

					if arg_143_1.isInRecall_ then
						for iter_146_0, iter_146_1 in ipairs((var_146_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_146_1.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_146_2 = arg_143_1.actors_["10094"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10094 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10094", 3)

				for iter_146_2 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_2)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_146_5 = arg_143_1.actors_["10094"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10094 == nil then
				arg_143_1.var_.actorSpriteComps10094 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps10094 then
					for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_146_4 then
							if arg_143_1.isInRecall_ then
								iter_146_4.color = Color.New(Mathf.Lerp(iter_146_4.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_4.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_4.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_4.color.r, 1, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_4.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10094 then
				for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_146_6 then
						iter_146_6.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10094 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 0.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(413042035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 18 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 18)

				if (18 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 18)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042035", "story_v_out_413042.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042035", "story_v_out_413042.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_413042", "413042035", "story_v_out_413042.awb")

						arg_143_1:RecordAudio("413042035", var_146_15)
						arg_143_1:RecordAudio("413042035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413042", "413042035", "story_v_out_413042.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413042", "413042035", "story_v_out_413042.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play413042036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413042036
		arg_147_1.duration_ = 11.5

		local var_147_0 = {
			zh = 5.9,
			ja = 11.5
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
				arg_147_0:Play413042037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10094 = arg_147_1.actors_["10094"].transform.localPosition
				arg_147_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10094", 0)

				for iter_150_0 = 0, arg_147_1.actors_["10094"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10094"].transform:GetChild(iter_150_0)

					if var_150_0.name == "" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_150_2 = arg_147_1.actors_["10022"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10022 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10022", 3)

				for iter_150_1 = 0, var_150_2.childCount - 1 do
					local var_150_3 = var_150_2:GetChild(iter_150_1)

					if var_150_3.name == "" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_147_1.time_ - 0) / var_150_4)
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_150_5 = arg_147_1.actors_["10094"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10094 == nil then
				arg_147_1.var_.actorSpriteComps10094 = var_150_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_6 and not isNil(var_150_5) then
				if arg_147_1.var_.actorSpriteComps10094 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								iter_150_3.color = Color.New(Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_6), Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_6), (Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_6)))
							else
								local var_150_7 = Mathf.Lerp(iter_150_3.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_6)

								iter_150_3.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_6 and arg_147_1.time_ < 0 + var_150_6 + arg_150_0 and not isNil(var_150_5) and arg_147_1.var_.actorSpriteComps10094 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_150_5 then
						iter_150_5.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10094 = nil
			end

			local var_150_8 = arg_147_1.actors_["10022"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_9 = 2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_9 and not isNil(var_150_8) then
				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								iter_150_7.color = Color.New(Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_9), Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_9), (Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_9)))
							else
								local var_150_10 = Mathf.Lerp(iter_150_7.color.r, 1, (arg_147_1.time_ - 0) / var_150_9)

								iter_150_7.color = Color.New(var_150_10, var_150_10, var_150_10)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_9 and arg_147_1.time_ < 0 + var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_9 then
						iter_150_9.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_11 = 0
			local var_150_12 = 0.775

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(413042036)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 31 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 31)

				if (31 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 31)) > 0 and var_150_12 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042036", "story_v_out_413042.awb") ~= 0 then
					local var_150_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042036", "story_v_out_413042.awb") / 1000

					if var_150_17 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_11
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_413042", "413042036", "story_v_out_413042.awb")

						arg_147_1:RecordAudio("413042036", var_150_18)
						arg_147_1:RecordAudio("413042036", var_150_18)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413042", "413042036", "story_v_out_413042.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413042", "413042036", "story_v_out_413042.awb")
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

		arg_147_1:InitPlayNodeList()
	end,
	Play413042037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413042037
		arg_151_1.duration_ = 3.23

		local var_151_0 = {
			zh = 1.366,
			ja = 3.233
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
				arg_151_0:Play413042038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.2

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(413042037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 8 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 8)

				if (8 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 8)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042037", "story_v_out_413042.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042037", "story_v_out_413042.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_413042", "413042037", "story_v_out_413042.awb")

						arg_151_1:RecordAudio("413042037", var_154_6)
						arg_151_1:RecordAudio("413042037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413042", "413042037", "story_v_out_413042.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413042", "413042037", "story_v_out_413042.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413042038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413042038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play413042039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = arg_155_1.actors_["10022"].transform.localPosition
				arg_155_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 0)

				for iter_158_0 = 0, arg_155_1.actors_["10022"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10022"].transform:GetChild(iter_158_0)

					if var_158_0.name == "" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_158_2 = arg_155_1.actors_["10022"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_5 = 0
			local var_158_6 = 1.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(413042038).content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 46 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_7) / 46)

				if (46 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_7) / 46)) > 0 and var_158_6 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_10 and arg_155_1.time_ < var_158_5 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play413042039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413042039
		arg_159_1.duration_ = 2.2

		local var_159_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_159_0:Play413042040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10022"]) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = arg_159_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10022"]) then
				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10022"]) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_2 = arg_159_1.actors_["10022"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = var_162_2.localPosition
				var_162_2.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 3)

				for iter_162_4 = 0, var_162_2.childCount - 1 do
					local var_162_3 = var_162_2:GetChild(iter_162_4)

					if var_162_3.name == "split_6" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_2.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_159_1.time_ - 0) / var_162_4)
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_162_5 = 0
			local var_162_6 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_5 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_7 = arg_159_1:GetWordFromCfg(413042039)
				local var_162_8 = arg_159_1:FormatText(var_162_7.content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 14 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 14)

				if (14 <= 0 and var_162_6 or var_162_6 * (utf8.len(var_162_8) / 14)) > 0 and var_162_6 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_5
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042039", "story_v_out_413042.awb") ~= 0 then
					local var_162_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042039", "story_v_out_413042.awb") / 1000

					if var_162_11 + var_162_5 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_5
					end

					if var_162_7.prefab_name ~= "" and arg_159_1.actors_[var_162_7.prefab_name] ~= nil then
						local var_162_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_7.prefab_name].transform, "story_v_out_413042", "413042039", "story_v_out_413042.awb")

						arg_159_1:RecordAudio("413042039", var_162_12)
						arg_159_1:RecordAudio("413042039", var_162_12)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413042", "413042039", "story_v_out_413042.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413042", "413042039", "story_v_out_413042.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_6, arg_159_1.talkMaxDuration)

			if var_162_5 <= arg_159_1.time_ and arg_159_1.time_ < var_162_5 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_5) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_5 + var_162_13 and arg_159_1.time_ < var_162_5 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play413042040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413042040
		arg_163_1.duration_ = 2.07

		local var_163_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_163_0:Play413042041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10022"]) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = arg_163_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10022"]) then
				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10022"]) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_166_4 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_4 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_4

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_4
						arg_163_1.bgmTxt2_.text = var_166_4
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.7 < arg_163_1.time_ and arg_163_1.time_ <= 0.7 + arg_166_0 then
				arg_163_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_166_6 = 0
			local var_166_7 = 0.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_8 = arg_163_1:GetWordFromCfg(413042040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 3 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 3)

				if (3 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 3)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042040", "story_v_out_413042.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_413042", "413042040", "story_v_out_413042.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_413042", "413042040", "story_v_out_413042.awb")

						arg_163_1:RecordAudio("413042040", var_166_13)
						arg_163_1:RecordAudio("413042040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413042", "413042040", "story_v_out_413042.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413042", "413042040", "story_v_out_413042.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play413042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 413042041
		arg_168_1.duration_ = 2

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play413042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10022 = arg_168_1.actors_["10022"].transform.localPosition
				arg_168_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10022", 3)

				for iter_171_0 = 0, arg_168_1.actors_["10022"].transform.childCount - 1 do
					local var_171_0 = arg_168_1.actors_["10022"].transform:GetChild(iter_171_0)

					if var_171_0.name == "split_2" or not string.find(var_171_0.name, "split") then
						var_171_0.gameObject:SetActive(true)
					else
						var_171_0.gameObject:SetActive(false)
					end
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_168_1.time_ - 0) / var_171_1)
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_171_2 = arg_168_1.actors_["10022"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10022 == nil then
				arg_168_1.var_.actorSpriteComps10022 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps10022 then
					for iter_171_1, iter_171_2 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_171_2 then
							if arg_168_1.isInRecall_ then
								iter_171_2.color = Color.New(Mathf.Lerp(iter_171_2.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_2.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_2.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_2.color.r, 1, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_2.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10022 then
				for iter_171_3, iter_171_4 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_171_4 then
						iter_171_4.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps10022 = nil
			end

			local var_171_5 = 0
			local var_171_6 = 0.175

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_7 = arg_168_1:GetWordFromCfg(413042041)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 7 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 7)

				if (7 <= 0 and var_171_6 or var_171_6 * (utf8.len(var_171_8) / 7)) > 0 and var_171_6 < var_171_10 then
					arg_168_1.talkMaxDuration = var_171_10

					if var_171_10 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_8
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042041", "story_v_out_413042.awb") ~= 0 then
					local var_171_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042041", "story_v_out_413042.awb") / 1000

					if var_171_11 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_5
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_out_413042", "413042041", "story_v_out_413042.awb")

						arg_168_1:RecordAudio("413042041", var_171_12)
						arg_168_1:RecordAudio("413042041", var_171_12)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_413042", "413042041", "story_v_out_413042.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_413042", "413042041", "story_v_out_413042.awb")
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

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play413042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 413042042
		arg_172_1.duration_ = 5

		local var_172_0 = {
			zh = 5,
			ja = 1.999999999999
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
				arg_172_0:Play413042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10022"]) and arg_172_1.var_.actorSpriteComps10022 == nil then
				arg_172_1.var_.actorSpriteComps10022 = arg_172_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10022"]) then
				if arg_172_1.var_.actorSpriteComps10022 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10022"]) and arg_172_1.var_.actorSpriteComps10022 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps10022 = nil
			end

			if 0.366666666666667 < arg_172_1.time_ and arg_172_1.time_ <= 0.366666666666667 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_175_3 = 0
			local var_175_4 = 0.15

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_5 = arg_172_1:GetWordFromCfg(413042042)
				local var_175_6 = arg_172_1:FormatText(var_175_5.content)

				arg_172_1.text_.text = var_175_6

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_8 = 6 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_6) / 6)

				if (6 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_6) / 6)) > 0 and var_175_4 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_3
					end
				end

				arg_172_1.text_.text = var_175_6
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042042", "story_v_out_413042.awb") ~= 0 then
					local var_175_9 = manager.audio:GetVoiceLength("story_v_out_413042", "413042042", "story_v_out_413042.awb") / 1000

					if var_175_9 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_3
					end

					if var_175_5.prefab_name ~= "" and arg_172_1.actors_[var_175_5.prefab_name] ~= nil then
						local var_175_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_5.prefab_name].transform, "story_v_out_413042", "413042042", "story_v_out_413042.awb")

						arg_172_1:RecordAudio("413042042", var_175_10)
						arg_172_1:RecordAudio("413042042", var_175_10)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_413042", "413042042", "story_v_out_413042.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_413042", "413042042", "story_v_out_413042.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_11 = math.max(var_175_4, arg_172_1.talkMaxDuration)

			if var_175_3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_3 + var_175_11 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_3) / var_175_11

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_3 + var_175_11 and arg_172_1.time_ < var_175_3 + var_175_11 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play413042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 413042043
		arg_176_1.duration_ = 4.5

		local var_176_0 = {
			zh = 2.7,
			ja = 4.5
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
				arg_176_0:Play413042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10022 = arg_176_1.actors_["10022"].transform.localPosition
				arg_176_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10022", 0)

				for iter_179_0 = 0, arg_176_1.actors_["10022"].transform.childCount - 1 do
					local var_179_0 = arg_176_1.actors_["10022"].transform:GetChild(iter_179_0)

					if var_179_0.name == "" or not string.find(var_179_0.name, "split") then
						var_179_0.gameObject:SetActive(true)
					else
						var_179_0.gameObject:SetActive(false)
					end
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_176_1.time_ - 0) / var_179_1)
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_179_2 = arg_176_1.actors_["10094"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10094 = var_179_2.localPosition
				var_179_2.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10094", 3)

				for iter_179_1 = 0, var_179_2.childCount - 1 do
					local var_179_3 = var_179_2:GetChild(iter_179_1)

					if var_179_3.name == "" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_176_1.time_ - 0) / var_179_4)
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_179_5 = arg_176_1.actors_["10022"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_5) and arg_176_1.var_.actorSpriteComps10022 == nil then
				arg_176_1.var_.actorSpriteComps10022 = var_179_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_6 = 2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_6 and not isNil(var_179_5) then
				if arg_176_1.var_.actorSpriteComps10022 then
					for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_179_3 then
							if arg_176_1.isInRecall_ then
								iter_179_3.color = Color.New(Mathf.Lerp(iter_179_3.color.r, arg_176_1.hightColor2.r, (arg_176_1.time_ - 0) / var_179_6), Mathf.Lerp(iter_179_3.color.g, arg_176_1.hightColor2.g, (arg_176_1.time_ - 0) / var_179_6), (Mathf.Lerp(iter_179_3.color.b, arg_176_1.hightColor2.b, (arg_176_1.time_ - 0) / var_179_6)))
							else
								local var_179_7 = Mathf.Lerp(iter_179_3.color.r, 0.5, (arg_176_1.time_ - 0) / var_179_6)

								iter_179_3.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_6 and arg_176_1.time_ < 0 + var_179_6 + arg_179_0 and not isNil(var_179_5) and arg_176_1.var_.actorSpriteComps10022 then
				for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_179_5 then
						iter_179_5.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps10022 = nil
			end

			local var_179_8 = arg_176_1.actors_["10094"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10094 == nil then
				arg_176_1.var_.actorSpriteComps10094 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_9 = 2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_9 and not isNil(var_179_8) then
				if arg_176_1.var_.actorSpriteComps10094 then
					for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_179_7 then
							if arg_176_1.isInRecall_ then
								iter_179_7.color = Color.New(Mathf.Lerp(iter_179_7.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_9), Mathf.Lerp(iter_179_7.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_9), (Mathf.Lerp(iter_179_7.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_9)))
							else
								local var_179_10 = Mathf.Lerp(iter_179_7.color.r, 1, (arg_176_1.time_ - 0) / var_179_9)

								iter_179_7.color = Color.New(var_179_10, var_179_10, var_179_10)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_9 and arg_176_1.time_ < 0 + var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10094 then
				for iter_179_8, iter_179_9 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_179_9 then
						iter_179_9.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps10094 = nil
			end

			local var_179_11 = 0
			local var_179_12 = 0.325

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_13 = arg_176_1:GetWordFromCfg(413042043)
				local var_179_14 = arg_176_1:FormatText(var_179_13.content)

				arg_176_1.text_.text = var_179_14

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_16 = 13 <= 0 and var_179_12 or var_179_12 * (utf8.len(var_179_14) / 13)

				if (13 <= 0 and var_179_12 or var_179_12 * (utf8.len(var_179_14) / 13)) > 0 and var_179_12 < var_179_16 then
					arg_176_1.talkMaxDuration = var_179_16

					if var_179_16 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_16 + var_179_11
					end
				end

				arg_176_1.text_.text = var_179_14
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042043", "story_v_out_413042.awb") ~= 0 then
					local var_179_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042043", "story_v_out_413042.awb") / 1000

					if var_179_17 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_17 + var_179_11
					end

					if var_179_13.prefab_name ~= "" and arg_176_1.actors_[var_179_13.prefab_name] ~= nil then
						local var_179_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_13.prefab_name].transform, "story_v_out_413042", "413042043", "story_v_out_413042.awb")

						arg_176_1:RecordAudio("413042043", var_179_18)
						arg_176_1:RecordAudio("413042043", var_179_18)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_413042", "413042043", "story_v_out_413042.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_413042", "413042043", "story_v_out_413042.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_19 = math.max(var_179_12, arg_176_1.talkMaxDuration)

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_19 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_11) / var_179_19

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_11 + var_179_19 and arg_176_1.time_ < var_179_11 + var_179_19 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play413042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 413042044
		arg_180_1.duration_ = 5.97

		local var_180_0 = {
			zh = 3.1,
			ja = 5.966
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
				arg_180_0:Play413042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10094 = arg_180_1.actors_["10094"].transform.localPosition
				arg_180_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10094", 0)

				for iter_183_0 = 0, arg_180_1.actors_["10094"].transform.childCount - 1 do
					local var_183_0 = arg_180_1.actors_["10094"].transform:GetChild(iter_183_0)

					if var_183_0.name == "" or not string.find(var_183_0.name, "split") then
						var_183_0.gameObject:SetActive(true)
					else
						var_183_0.gameObject:SetActive(false)
					end
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_180_1.time_ - 0) / var_183_1)
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_183_2 = arg_180_1.actors_["10022"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10022 = var_183_2.localPosition
				var_183_2.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10022", 3)

				for iter_183_1 = 0, var_183_2.childCount - 1 do
					local var_183_3 = var_183_2:GetChild(iter_183_1)

					if var_183_3.name == "split_8" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_2.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_180_1.time_ - 0) / var_183_4)
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_2.localPosition = Vector3.New(0, -315, -320)
			end

			local var_183_5 = arg_180_1.actors_["10094"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps10094 == nil then
				arg_180_1.var_.actorSpriteComps10094 = var_183_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_6 = 2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_6 and not isNil(var_183_5) then
				if arg_180_1.var_.actorSpriteComps10094 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								iter_183_3.color = Color.New(Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_6), Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_6), (Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_6)))
							else
								local var_183_7 = Mathf.Lerp(iter_183_3.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_6)

								iter_183_3.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_6 and arg_180_1.time_ < 0 + var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps10094 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_183_5 then
						iter_183_5.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10094 = nil
			end

			local var_183_8 = arg_180_1.actors_["10022"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10022 == nil then
				arg_180_1.var_.actorSpriteComps10022 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_9 = 2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_9 and not isNil(var_183_8) then
				if arg_180_1.var_.actorSpriteComps10022 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								iter_183_7.color = Color.New(Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_9), Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_9), (Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_9)))
							else
								local var_183_10 = Mathf.Lerp(iter_183_7.color.r, 1, (arg_180_1.time_ - 0) / var_183_9)

								iter_183_7.color = Color.New(var_183_10, var_183_10, var_183_10)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_9 and arg_180_1.time_ < 0 + var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10022 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_183_9 then
						iter_183_9.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10022 = nil
			end

			local var_183_11 = 0
			local var_183_12 = 0.425

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_13 = arg_180_1:GetWordFromCfg(413042044)
				local var_183_14 = arg_180_1:FormatText(var_183_13.content)

				arg_180_1.text_.text = var_183_14

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_16 = 17 <= 0 and var_183_12 or var_183_12 * (utf8.len(var_183_14) / 17)

				if (17 <= 0 and var_183_12 or var_183_12 * (utf8.len(var_183_14) / 17)) > 0 and var_183_12 < var_183_16 then
					arg_180_1.talkMaxDuration = var_183_16

					if var_183_16 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_11
					end
				end

				arg_180_1.text_.text = var_183_14
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042044", "story_v_out_413042.awb") ~= 0 then
					local var_183_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042044", "story_v_out_413042.awb") / 1000

					if var_183_17 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_17 + var_183_11
					end

					if var_183_13.prefab_name ~= "" and arg_180_1.actors_[var_183_13.prefab_name] ~= nil then
						local var_183_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_13.prefab_name].transform, "story_v_out_413042", "413042044", "story_v_out_413042.awb")

						arg_180_1:RecordAudio("413042044", var_183_18)
						arg_180_1:RecordAudio("413042044", var_183_18)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_413042", "413042044", "story_v_out_413042.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_413042", "413042044", "story_v_out_413042.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_19 = math.max(var_183_12, arg_180_1.talkMaxDuration)

			if var_183_11 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_19 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_11) / var_183_19

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_11 + var_183_19 and arg_180_1.time_ < var_183_11 + var_183_19 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play413042045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 413042045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play413042046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10022"]) and arg_184_1.var_.actorSpriteComps10022 == nil then
				arg_184_1.var_.actorSpriteComps10022 = arg_184_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10022"]) then
				if arg_184_1.var_.actorSpriteComps10022 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10022"]) and arg_184_1.var_.actorSpriteComps10022 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10022 = nil
			end

			local var_187_2 = 0
			local var_187_3 = 1.1

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(413042045).content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 44 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 44)

				if (44 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 44)) > 0 and var_187_3 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_7 and arg_184_1.time_ < var_187_2 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play413042046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 413042046
		arg_188_1.duration_ = 2.83

		local var_188_0 = {
			zh = 2.833,
			ja = 2.466
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
				arg_188_0:Play413042047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10022 = arg_188_1.actors_["10022"].transform.localPosition
				arg_188_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10022", 0)

				for iter_191_0 = 0, arg_188_1.actors_["10022"].transform.childCount - 1 do
					local var_191_0 = arg_188_1.actors_["10022"].transform:GetChild(iter_191_0)

					if var_191_0.name == "" or not string.find(var_191_0.name, "split") then
						var_191_0.gameObject:SetActive(true)
					else
						var_191_0.gameObject:SetActive(false)
					end
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_188_1.time_ - 0) / var_191_1)
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_191_2 = "10093"

			if arg_188_1.actors_["10093"] == nil then
				local var_191_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_191_3) then
					local var_191_4 = Object.Instantiate(var_191_3, arg_188_1.canvasGo_.transform)

					var_191_4.transform:SetSiblingIndex(1)

					var_191_4.name = var_191_2
					var_191_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_188_1.actors_[var_191_2] = var_191_4

					if arg_188_1.isInRecall_ then
						for iter_191_1, iter_191_2 in ipairs((var_191_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_191_2.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_191_5 = arg_188_1.actors_["10093"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10093 = var_191_5.localPosition
				var_191_5.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10093", 3)

				for iter_191_3 = 0, var_191_5.childCount - 1 do
					local var_191_6 = var_191_5:GetChild(iter_191_3)

					if var_191_6.name == "split_3" or not string.find(var_191_6.name, "split") then
						var_191_6.gameObject:SetActive(true)
					else
						var_191_6.gameObject:SetActive(false)
					end
				end
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_5.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_188_1.time_ - 0) / var_191_7)
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_191_8 = arg_188_1.actors_["10022"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10022 == nil then
				arg_188_1.var_.actorSpriteComps10022 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_9 = 2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_9 and not isNil(var_191_8) then
				if arg_188_1.var_.actorSpriteComps10022 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								iter_191_5.color = Color.New(Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_9), Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_9), (Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_9)))
							else
								local var_191_10 = Mathf.Lerp(iter_191_5.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_9)

								iter_191_5.color = Color.New(var_191_10, var_191_10, var_191_10)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_9 and arg_188_1.time_ < 0 + var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10022 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_191_7 then
						iter_191_7.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10022 = nil
			end

			local var_191_11 = arg_188_1.actors_["10093"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.actorSpriteComps10093 == nil then
				arg_188_1.var_.actorSpriteComps10093 = var_191_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_12 = 2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_12 and not isNil(var_191_11) then
				if arg_188_1.var_.actorSpriteComps10093 then
					for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_191_9 then
							if arg_188_1.isInRecall_ then
								iter_191_9.color = Color.New(Mathf.Lerp(iter_191_9.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_12), Mathf.Lerp(iter_191_9.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_12), (Mathf.Lerp(iter_191_9.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_12)))
							else
								local var_191_13 = Mathf.Lerp(iter_191_9.color.r, 1, (arg_188_1.time_ - 0) / var_191_12)

								iter_191_9.color = Color.New(var_191_13, var_191_13, var_191_13)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_12 and arg_188_1.time_ < 0 + var_191_12 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.actorSpriteComps10093 then
				for iter_191_10, iter_191_11 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_191_11 then
						iter_191_11.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				local var_191_14 = arg_188_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_191_14 then
					arg_188_1.var_.alphaOldValue10093 = var_191_14.alpha
					arg_188_1.var_.characterEffect10093 = var_191_14
				end

				arg_188_1.var_.alphaOldValue10093 = 0
			end

			local var_191_15 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_15 then
				if arg_188_1.var_.characterEffect10093 then
					arg_188_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_188_1.var_.alphaOldValue10093, 1, (arg_188_1.time_ - 0) / var_191_15)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_15 and arg_188_1.time_ < 0 + var_191_15 + arg_191_0 and arg_188_1.var_.characterEffect10093 then
				arg_188_1.var_.characterEffect10093.alpha = 1
			end

			local var_191_16 = 0
			local var_191_17 = 0.275

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(413042046)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_21 = 11 <= 0 and var_191_17 or var_191_17 * (utf8.len(var_191_19) / 11)

				if (11 <= 0 and var_191_17 or var_191_17 * (utf8.len(var_191_19) / 11)) > 0 and var_191_17 < var_191_21 then
					arg_188_1.talkMaxDuration = var_191_21

					if var_191_21 + var_191_16 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_21 + var_191_16
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042046", "story_v_out_413042.awb") ~= 0 then
					local var_191_22 = manager.audio:GetVoiceLength("story_v_out_413042", "413042046", "story_v_out_413042.awb") / 1000

					if var_191_22 + var_191_16 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_16
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_413042", "413042046", "story_v_out_413042.awb")

						arg_188_1:RecordAudio("413042046", var_191_23)
						arg_188_1:RecordAudio("413042046", var_191_23)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_413042", "413042046", "story_v_out_413042.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_413042", "413042046", "story_v_out_413042.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_24 = math.max(var_191_17, arg_188_1.talkMaxDuration)

			if var_191_16 <= arg_188_1.time_ and arg_188_1.time_ < var_191_16 + var_191_24 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_16) / var_191_24

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_16 + var_191_24 and arg_188_1.time_ < var_191_16 + var_191_24 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play413042047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413042047
		arg_192_1.duration_ = 4.6

		local var_192_0 = {
			zh = 4.6,
			ja = 2
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
				arg_192_0:Play413042048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10093 = arg_192_1.actors_["10093"].transform.localPosition
				arg_192_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10093", 0)

				for iter_195_0 = 0, arg_192_1.actors_["10093"].transform.childCount - 1 do
					local var_195_0 = arg_192_1.actors_["10093"].transform:GetChild(iter_195_0)

					if var_195_0.name == "" or not string.find(var_195_0.name, "split") then
						var_195_0.gameObject:SetActive(true)
					else
						var_195_0.gameObject:SetActive(false)
					end
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_192_1.time_ - 0) / var_195_1)
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["10093"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_195_2 = arg_192_1.actors_["10093"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10093 == nil then
				arg_192_1.var_.actorSpriteComps10093 = var_195_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_3 = 2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.actorSpriteComps10093 then
					for iter_195_1, iter_195_2 in pairs(arg_192_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_195_2 then
							if arg_192_1.isInRecall_ then
								iter_195_2.color = Color.New(Mathf.Lerp(iter_195_2.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_3), Mathf.Lerp(iter_195_2.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_3), (Mathf.Lerp(iter_195_2.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_3)))
							else
								local var_195_4 = Mathf.Lerp(iter_195_2.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_3)

								iter_195_2.color = Color.New(var_195_4, var_195_4, var_195_4)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10093 then
				for iter_195_3, iter_195_4 in pairs(arg_192_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_195_4 then
						iter_195_4.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10093 = nil
			end

			if 0.433333333333333 < arg_192_1.time_ and arg_192_1.time_ <= 0.433333333333333 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_195_6 = 0
			local var_195_7 = 0.175

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_8 = arg_192_1:GetWordFromCfg(413042047)
				local var_195_9 = arg_192_1:FormatText(var_195_8.content)

				arg_192_1.text_.text = var_195_9

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 7 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 7)

				if (7 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 7)) > 0 and var_195_7 < var_195_11 then
					arg_192_1.talkMaxDuration = var_195_11

					if var_195_11 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_9
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042047", "story_v_out_413042.awb") ~= 0 then
					local var_195_12 = manager.audio:GetVoiceLength("story_v_out_413042", "413042047", "story_v_out_413042.awb") / 1000

					if var_195_12 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_6
					end

					if var_195_8.prefab_name ~= "" and arg_192_1.actors_[var_195_8.prefab_name] ~= nil then
						local var_195_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_8.prefab_name].transform, "story_v_out_413042", "413042047", "story_v_out_413042.awb")

						arg_192_1:RecordAudio("413042047", var_195_13)
						arg_192_1:RecordAudio("413042047", var_195_13)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413042", "413042047", "story_v_out_413042.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413042", "413042047", "story_v_out_413042.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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

		arg_192_1:InitPlayNodeList()
	end,
	Play413042048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413042048
		arg_196_1.duration_ = 4.7

		local var_196_0 = {
			zh = 2.133,
			ja = 4.7
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
				arg_196_0:Play413042049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10092 = arg_196_1.actors_["10092"].transform.localPosition
				arg_196_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10092", 3)

				for iter_199_0 = 0, arg_196_1.actors_["10092"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["10092"].transform:GetChild(iter_199_0)

					if var_199_0.name == "split_5" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_199_2 = arg_196_1.actors_["10092"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10092 == nil then
				arg_196_1.var_.actorSpriteComps10092 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10092 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								iter_199_2.color = Color.New(Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_2.color.r, 1, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_2.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10092 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_199_4 then
						iter_199_4.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10092 = nil
			end

			local var_199_5 = 0
			local var_199_6 = 0.225

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:GetWordFromCfg(413042048)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 9 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 9)

				if (9 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 9)) > 0 and var_199_6 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042048", "story_v_out_413042.awb") ~= 0 then
					local var_199_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042048", "story_v_out_413042.awb") / 1000

					if var_199_11 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_5
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_out_413042", "413042048", "story_v_out_413042.awb")

						arg_196_1:RecordAudio("413042048", var_199_12)
						arg_196_1:RecordAudio("413042048", var_199_12)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413042", "413042048", "story_v_out_413042.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413042", "413042048", "story_v_out_413042.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_13 and arg_196_1.time_ < var_199_5 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413042049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413042049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413042050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10092 = arg_200_1.actors_["10092"].transform.localPosition
				arg_200_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10092", 0)

				for iter_203_0 = 0, arg_200_1.actors_["10092"].transform.childCount - 1 do
					local var_203_0 = arg_200_1.actors_["10092"].transform:GetChild(iter_203_0)

					if var_203_0.name == "" or not string.find(var_203_0.name, "split") then
						var_203_0.gameObject:SetActive(true)
					else
						var_203_0.gameObject:SetActive(false)
					end
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_200_1.time_ - 0) / var_203_1)
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_203_2 = arg_200_1.actors_["10092"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10092 == nil then
				arg_200_1.var_.actorSpriteComps10092 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10092 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								iter_203_2.color = Color.New(Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_2.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_2.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10092 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_203_4 then
						iter_203_4.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10092 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 1.025

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(413042049).content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 41 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_7) / 41)

				if (41 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_7) / 41)) > 0 and var_203_6 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_10 and arg_200_1.time_ < var_203_5 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play413042050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413042050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413042051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1.15

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(413042050).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 46 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 46)

				if (46 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 46)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play413042051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413042051
		arg_208_1.duration_ = 4.64

		local var_208_0 = {
			zh = 3.908,
			ja = 4.641
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
				arg_208_0:Play413042052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_211_0 = 0.6

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 then
				local var_211_1, var_211_2 = math.modf((arg_208_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_211_2 * 0.13, var_211_2 * 0.13, var_211_2 * 0.13) + arg_208_1.var_.shakeOldPos
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 then
				manager.ui.mainCamera.transform.localPosition = arg_208_1.var_.shakeOldPos
			end

			local var_211_3 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_3 + 0.6 and arg_208_1.time_ < var_211_3 + 0.6 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_4 = 0.575
			local var_211_5 = 0.425

			if 0.575 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_6 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_6:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_3")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_7 = arg_208_1:GetWordFromCfg(413042051)
				local var_211_8 = arg_208_1:FormatText(var_211_7.content)

				arg_208_1.text_.text = var_211_8

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 17 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_8) / 17)

				if (17 <= 0 and var_211_5 or var_211_5 * (utf8.len(var_211_8) / 17)) > 0 and var_211_5 < var_211_10 then
					arg_208_1.talkMaxDuration = var_211_10
					var_211_4 = var_211_4 + 0.3

					if var_211_10 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_4
					end
				end

				arg_208_1.text_.text = var_211_8
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042051", "story_v_out_413042.awb") ~= 0 then
					local var_211_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042051", "story_v_out_413042.awb") / 1000

					if var_211_11 + var_211_4 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_4
					end

					if var_211_7.prefab_name ~= "" and arg_208_1.actors_[var_211_7.prefab_name] ~= nil then
						local var_211_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_7.prefab_name].transform, "story_v_out_413042", "413042051", "story_v_out_413042.awb")

						arg_208_1:RecordAudio("413042051", var_211_12)
						arg_208_1:RecordAudio("413042051", var_211_12)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413042", "413042051", "story_v_out_413042.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413042", "413042051", "story_v_out_413042.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = var_211_4 + 0.3
			local var_211_14 = math.max(var_211_5, arg_208_1.talkMaxDuration)

			if var_211_4 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_13 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_13) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_13 + var_211_14 and arg_208_1.time_ < var_211_13 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play413042052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 413042052
		arg_214_1.duration_ = 2

		local var_214_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_214_0:Play413042053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10097 = arg_214_1.actors_["10097"].transform.localPosition
				arg_214_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10097", 3)

				for iter_217_0 = 0, arg_214_1.actors_["10097"].transform.childCount - 1 do
					local var_217_0 = arg_214_1.actors_["10097"].transform:GetChild(iter_217_0)

					if var_217_0.name == "" or not string.find(var_217_0.name, "split") then
						var_217_0.gameObject:SetActive(true)
					else
						var_217_0.gameObject:SetActive(false)
					end
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_214_1.time_ - 0) / var_217_1)
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_217_2 = arg_214_1.actors_["10097"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10097 == nil then
				arg_214_1.var_.actorSpriteComps10097 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps10097 then
					for iter_217_1, iter_217_2 in pairs(arg_214_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_217_2 then
							if arg_214_1.isInRecall_ then
								iter_217_2.color = Color.New(Mathf.Lerp(iter_217_2.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_2.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_2.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_2.color.r, 1, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_2.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10097 then
				for iter_217_3, iter_217_4 in pairs(arg_214_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_217_4 then
						iter_217_4.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps10097 = nil
			end

			local var_217_5 = arg_214_1.actors_["10092"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_5) and arg_214_1.var_.actorSpriteComps10092 == nil then
				arg_214_1.var_.actorSpriteComps10092 = var_217_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_6 = 2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_6 and not isNil(var_217_5) then
				if arg_214_1.var_.actorSpriteComps10092 then
					for iter_217_5, iter_217_6 in pairs(arg_214_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_217_6 then
							if arg_214_1.isInRecall_ then
								iter_217_6.color = Color.New(Mathf.Lerp(iter_217_6.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_6), Mathf.Lerp(iter_217_6.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_6), (Mathf.Lerp(iter_217_6.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_6)))
							else
								local var_217_7 = Mathf.Lerp(iter_217_6.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_6)

								iter_217_6.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_6 and arg_214_1.time_ < 0 + var_217_6 + arg_217_0 and not isNil(var_217_5) and arg_214_1.var_.actorSpriteComps10092 then
				for iter_217_7, iter_217_8 in pairs(arg_214_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_217_8 then
						iter_217_8.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10092 = nil
			end

			local var_217_8 = 0
			local var_217_9 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:GetWordFromCfg(413042052)
				local var_217_11 = arg_214_1:FormatText(var_217_10.content)

				arg_214_1.text_.text = var_217_11

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 9 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 9)

				if (9 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 9)) > 0 and var_217_9 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_11
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042052", "story_v_out_413042.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_413042", "413042052", "story_v_out_413042.awb") / 1000

					if var_217_14 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_8
					end

					if var_217_10.prefab_name ~= "" and arg_214_1.actors_[var_217_10.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_10.prefab_name].transform, "story_v_out_413042", "413042052", "story_v_out_413042.awb")

						arg_214_1:RecordAudio("413042052", var_217_15)
						arg_214_1:RecordAudio("413042052", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_413042", "413042052", "story_v_out_413042.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_413042", "413042052", "story_v_out_413042.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_16 and arg_214_1.time_ < var_217_8 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play413042053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 413042053
		arg_218_1.duration_ = 5.27

		local var_218_0 = {
			zh = 3.666,
			ja = 5.266
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
				arg_218_0:Play413042054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10097 = arg_218_1.actors_["10097"].transform.localPosition
				arg_218_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10097", 0)

				for iter_221_0 = 0, arg_218_1.actors_["10097"].transform.childCount - 1 do
					local var_221_0 = arg_218_1.actors_["10097"].transform:GetChild(iter_221_0)

					if var_221_0.name == "" or not string.find(var_221_0.name, "split") then
						var_221_0.gameObject:SetActive(true)
					else
						var_221_0.gameObject:SetActive(false)
					end
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_218_1.time_ - 0) / var_221_1)
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_221_2 = arg_218_1.actors_["10093"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10093 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10093", 3)

				for iter_221_1 = 0, var_221_2.childCount - 1 do
					local var_221_3 = var_221_2:GetChild(iter_221_1)

					if var_221_3.name == "split_5" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_221_5 = arg_218_1.actors_["10097"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.actorSpriteComps10097 == nil then
				arg_218_1.var_.actorSpriteComps10097 = var_221_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_6 = 2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.actorSpriteComps10097 then
					for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_221_3 then
							if arg_218_1.isInRecall_ then
								iter_221_3.color = Color.New(Mathf.Lerp(iter_221_3.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_6), Mathf.Lerp(iter_221_3.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_6), (Mathf.Lerp(iter_221_3.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_6)))
							else
								local var_221_7 = Mathf.Lerp(iter_221_3.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_6)

								iter_221_3.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.actorSpriteComps10097 then
				for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_221_5 then
						iter_221_5.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps10097 = nil
			end

			local var_221_8 = arg_218_1.actors_["10093"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10093 == nil then
				arg_218_1.var_.actorSpriteComps10093 = var_221_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_9 = 2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_9 and not isNil(var_221_8) then
				if arg_218_1.var_.actorSpriteComps10093 then
					for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_221_7 then
							if arg_218_1.isInRecall_ then
								iter_221_7.color = Color.New(Mathf.Lerp(iter_221_7.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_9), Mathf.Lerp(iter_221_7.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_9), (Mathf.Lerp(iter_221_7.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_9)))
							else
								local var_221_10 = Mathf.Lerp(iter_221_7.color.r, 1, (arg_218_1.time_ - 0) / var_221_9)

								iter_221_7.color = Color.New(var_221_10, var_221_10, var_221_10)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_9 and arg_218_1.time_ < 0 + var_221_9 + arg_221_0 and not isNil(var_221_8) and arg_218_1.var_.actorSpriteComps10093 then
				for iter_221_8, iter_221_9 in pairs(arg_218_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_221_9 then
						iter_221_9.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps10093 = nil
			end

			local var_221_11 = 0
			local var_221_12 = 0.55

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_13 = arg_218_1:GetWordFromCfg(413042053)
				local var_221_14 = arg_218_1:FormatText(var_221_13.content)

				arg_218_1.text_.text = var_221_14

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_16 = 22 <= 0 and var_221_12 or var_221_12 * (utf8.len(var_221_14) / 22)

				if (22 <= 0 and var_221_12 or var_221_12 * (utf8.len(var_221_14) / 22)) > 0 and var_221_12 < var_221_16 then
					arg_218_1.talkMaxDuration = var_221_16

					if var_221_16 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_16 + var_221_11
					end
				end

				arg_218_1.text_.text = var_221_14
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042053", "story_v_out_413042.awb") ~= 0 then
					local var_221_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042053", "story_v_out_413042.awb") / 1000

					if var_221_17 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_17 + var_221_11
					end

					if var_221_13.prefab_name ~= "" and arg_218_1.actors_[var_221_13.prefab_name] ~= nil then
						local var_221_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_13.prefab_name].transform, "story_v_out_413042", "413042053", "story_v_out_413042.awb")

						arg_218_1:RecordAudio("413042053", var_221_18)
						arg_218_1:RecordAudio("413042053", var_221_18)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_413042", "413042053", "story_v_out_413042.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_413042", "413042053", "story_v_out_413042.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_19 = math.max(var_221_12, arg_218_1.talkMaxDuration)

			if var_221_11 <= arg_218_1.time_ and arg_218_1.time_ < var_221_11 + var_221_19 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_11) / var_221_19

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_11 + var_221_19 and arg_218_1.time_ < var_221_11 + var_221_19 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_218_1:InitPlayNodeList()
	end,
	Play413042054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 413042054
		arg_222_1.duration_ = 2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play413042055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10097 = arg_222_1.actors_["10097"].transform.localPosition
				arg_222_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10097", 3)

				for iter_225_0 = 0, arg_222_1.actors_["10097"].transform.childCount - 1 do
					local var_225_0 = arg_222_1.actors_["10097"].transform:GetChild(iter_225_0)

					if var_225_0.name == "split_2" or not string.find(var_225_0.name, "split") then
						var_225_0.gameObject:SetActive(true)
					else
						var_225_0.gameObject:SetActive(false)
					end
				end
			end

			local var_225_1 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 then
				arg_222_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_222_1.time_ - 0) / var_225_1)
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 then
				arg_222_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_225_2 = arg_222_1.actors_["10093"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10093 = var_225_2.localPosition
				var_225_2.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10093", 0)

				for iter_225_1 = 0, var_225_2.childCount - 1 do
					local var_225_3 = var_225_2:GetChild(iter_225_1)

					if var_225_3.name == "split_7" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_2.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10093, Vector3.New(-1500, -350, -180), (arg_222_1.time_ - 0) / var_225_4)
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_225_5 = arg_222_1.actors_["10097"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_5) and arg_222_1.var_.actorSpriteComps10097 == nil then
				arg_222_1.var_.actorSpriteComps10097 = var_225_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_6 = 2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_6 and not isNil(var_225_5) then
				if arg_222_1.var_.actorSpriteComps10097 then
					for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_225_3 then
							if arg_222_1.isInRecall_ then
								iter_225_3.color = Color.New(Mathf.Lerp(iter_225_3.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_6), Mathf.Lerp(iter_225_3.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_6), (Mathf.Lerp(iter_225_3.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_6)))
							else
								local var_225_7 = Mathf.Lerp(iter_225_3.color.r, 1, (arg_222_1.time_ - 0) / var_225_6)

								iter_225_3.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_6 and arg_222_1.time_ < 0 + var_225_6 + arg_225_0 and not isNil(var_225_5) and arg_222_1.var_.actorSpriteComps10097 then
				for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_225_5 then
						iter_225_5.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps10097 = nil
			end

			local var_225_8 = arg_222_1.actors_["10093"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10093 == nil then
				arg_222_1.var_.actorSpriteComps10093 = var_225_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_9 = 2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_9 and not isNil(var_225_8) then
				if arg_222_1.var_.actorSpriteComps10093 then
					for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_225_7 then
							if arg_222_1.isInRecall_ then
								iter_225_7.color = Color.New(Mathf.Lerp(iter_225_7.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_9), Mathf.Lerp(iter_225_7.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_9), (Mathf.Lerp(iter_225_7.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_9)))
							else
								local var_225_10 = Mathf.Lerp(iter_225_7.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_9)

								iter_225_7.color = Color.New(var_225_10, var_225_10, var_225_10)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_9 and arg_222_1.time_ < 0 + var_225_9 + arg_225_0 and not isNil(var_225_8) and arg_222_1.var_.actorSpriteComps10093 then
				for iter_225_8, iter_225_9 in pairs(arg_222_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_225_9 then
						iter_225_9.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps10093 = nil
			end

			local var_225_11 = 0
			local var_225_12 = 0.05

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_13 = arg_222_1:GetWordFromCfg(413042054)
				local var_225_14 = arg_222_1:FormatText(var_225_13.content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_16 = 2 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 2)

				if (2 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 2)) > 0 and var_225_12 < var_225_16 then
					arg_222_1.talkMaxDuration = var_225_16

					if var_225_16 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_11
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042054", "story_v_out_413042.awb") ~= 0 then
					local var_225_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042054", "story_v_out_413042.awb") / 1000

					if var_225_17 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_11
					end

					if var_225_13.prefab_name ~= "" and arg_222_1.actors_[var_225_13.prefab_name] ~= nil then
						local var_225_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_13.prefab_name].transform, "story_v_out_413042", "413042054", "story_v_out_413042.awb")

						arg_222_1:RecordAudio("413042054", var_225_18)
						arg_222_1:RecordAudio("413042054", var_225_18)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_413042", "413042054", "story_v_out_413042.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_413042", "413042054", "story_v_out_413042.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_19 = math.max(var_225_12, arg_222_1.talkMaxDuration)

			if var_225_11 <= arg_222_1.time_ and arg_222_1.time_ < var_225_11 + var_225_19 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_11) / var_225_19

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_11 + var_225_19 and arg_222_1.time_ < var_225_11 + var_225_19 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_222_1:InitPlayNodeList()
	end,
	Play413042055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 413042055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play413042056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10097 = arg_226_1.actors_["10097"].transform.localPosition
				arg_226_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10097", 0)

				for iter_229_0 = 0, arg_226_1.actors_["10097"].transform.childCount - 1 do
					local var_229_0 = arg_226_1.actors_["10097"].transform:GetChild(iter_229_0)

					if var_229_0.name == "" or not string.find(var_229_0.name, "split") then
						var_229_0.gameObject:SetActive(true)
					else
						var_229_0.gameObject:SetActive(false)
					end
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_226_1.time_ - 0) / var_229_1)
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_229_2 = arg_226_1.actors_["10097"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10097 == nil then
				arg_226_1.var_.actorSpriteComps10097 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps10097 then
					for iter_229_1, iter_229_2 in pairs(arg_226_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_229_2 then
							if arg_226_1.isInRecall_ then
								iter_229_2.color = Color.New(Mathf.Lerp(iter_229_2.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_2.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_2.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_2.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_2.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps10097 then
				for iter_229_3, iter_229_4 in pairs(arg_226_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_229_4 then
						iter_229_4.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps10097 = nil
			end

			local var_229_5 = 0
			local var_229_6 = 1.175

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_7 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(413042055).content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 47 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_7) / 47)

				if (47 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_7) / 47)) > 0 and var_229_6 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_10 and arg_226_1.time_ < var_229_5 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play413042056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 413042056
		arg_230_1.duration_ = 2.13

		local var_230_0 = {
			zh = 1.5,
			ja = 2.133
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
				arg_230_0:Play413042057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_233_0 = 0.6

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				local var_233_1, var_233_2 = math.modf((arg_230_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_233_2 * 0.13, var_233_2 * 0.13, var_233_2 * 0.13) + arg_230_1.var_.shakeOldPos
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				manager.ui.mainCamera.transform.localPosition = arg_230_1.var_.shakeOldPos
			end

			local var_233_3 = 0

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			if arg_230_1.time_ >= var_233_3 + 0.6 and arg_230_1.time_ < var_233_3 + 0.6 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_4 = 0.4
			local var_233_5 = 0.1

			if 0.4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_6 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_6:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_4")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_7 = arg_230_1:GetWordFromCfg(413042056)
				local var_233_8 = arg_230_1:FormatText(var_233_7.content)

				arg_230_1.text_.text = var_233_8

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_10 = 4 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_8) / 4)

				if (4 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_8) / 4)) > 0 and var_233_5 < var_233_10 then
					arg_230_1.talkMaxDuration = var_233_10
					var_233_4 = var_233_4 + 0.3

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_8
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042056", "story_v_out_413042.awb") ~= 0 then
					local var_233_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042056", "story_v_out_413042.awb") / 1000

					if var_233_11 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_4
					end

					if var_233_7.prefab_name ~= "" and arg_230_1.actors_[var_233_7.prefab_name] ~= nil then
						local var_233_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_7.prefab_name].transform, "story_v_out_413042", "413042056", "story_v_out_413042.awb")

						arg_230_1:RecordAudio("413042056", var_233_12)
						arg_230_1:RecordAudio("413042056", var_233_12)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_413042", "413042056", "story_v_out_413042.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_413042", "413042056", "story_v_out_413042.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = var_233_4 + 0.3
			local var_233_14 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_13 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_13) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_13 + var_233_14 and arg_230_1.time_ < var_233_13 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play413042057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413042057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413042058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 1.2

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(413042057).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 48 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 48)

				if (48 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 48)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413042058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413042058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413042059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.45

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(413042058).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 58 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 58)

				if (58 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 58)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413042059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413042059
		arg_244_1.duration_ = 7.17

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play413042060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_9000

			if arg_244_1.bgs_.SS1303 == nil then
				local var_247_0 = Object.Instantiate(arg_244_1.paintGo_)

				var_247_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1303")
				var_247_0.name = "SS1303"
				var_247_0.transform.parent = arg_244_1.stage_.transform
				var_247_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.bgs_.SS1303 = var_247_0
			end

			if 0.666666666666666 < arg_244_1.time_ and arg_244_1.time_ <= 0.666666666666666 + arg_247_0 then
				local var_247_1 = arg_244_1.bgs_.SS1303

				arg_244_1.bgs_.SS1303.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_247_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_247_2 = var_247_1:GetComponent("SpriteRenderer")

				if var_247_2 and var_247_2.sprite then
					local var_247_3 = 2 * (var_247_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_247_1.transform.localScale = Vector3.New(var_247_3 / var_247_2.sprite.bounds.size.y < var_247_3 * manager.ui.mainCameraCom_.aspect / var_247_2.sprite.bounds.size.x and var_247_3 * manager.ui.mainCameraCom_.aspect / var_247_2.sprite.bounds.size.x or var_247_3 / var_247_2.sprite.bounds.size.y, var_247_3 / var_247_2.sprite.bounds.size.y < var_247_3 * manager.ui.mainCameraCom_.aspect / var_247_2.sprite.bounds.size.x and var_247_3 * manager.ui.mainCameraCom_.aspect / var_247_2.sprite.bounds.size.x or var_247_3 / var_247_2.sprite.bounds.size.y, 0)
				end

				for iter_247_0, iter_247_1 in pairs(arg_244_1.bgs_) do
					if iter_247_0 ~= "SS1303" then
						iter_247_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_247_4 = 0

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_4 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_5 = 0.733333333333333

			if var_247_4 <= arg_244_1.time_ and arg_244_1.time_ < var_247_4 + var_247_5 then
				local var_247_6 = Color.New(1, 1, 1)

				var_247_6.a = Mathf.Lerp(0, 1, (arg_244_1.time_ - var_247_4) / var_247_5)
				arg_244_1.mask_.color = var_247_6
			end

			if arg_244_1.time_ >= var_247_4 + var_247_5 and arg_244_1.time_ < var_247_4 + var_247_5 + arg_247_0 then
				local var_247_7 = Color.New(1, 1, 1)

				var_247_7.a = 1
				arg_244_1.mask_.color = var_247_7
			end

			local var_247_8 = 0.733333333333333

			if 0.733333333333333 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_9 = 0.8

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_9 then
				local var_247_10 = Color.New(1, 1, 1)

				var_247_10.a = Mathf.Lerp(1, 0, (arg_244_1.time_ - var_247_8) / var_247_9)
				arg_244_1.mask_.color = var_247_10
			end

			if arg_244_1.time_ >= var_247_8 + var_247_9 and arg_244_1.time_ < var_247_8 + var_247_9 + arg_247_0 then
				local var_247_11 = Color.New(1, 1, 1)

				arg_244_1.mask_.enabled = false
				var_247_11.a = 0
				arg_244_1.mask_.color = var_247_11
			end

			local var_247_12 = manager.ui.mainCamera.transform

			if 1.06666666666667 < arg_244_1.time_ and arg_244_1.time_ <= 1.06666666666667 + arg_247_0 then
				arg_244_1.var_.shakeOldPos = var_247_12.localPosition
			end

			local var_247_13 = 0.6

			if 1.06666666666667 <= arg_244_1.time_ and arg_244_1.time_ < 1.06666666666667 + var_247_13 then
				local var_247_14, var_247_15 = math.modf((arg_244_1.time_ - 1.06666666666667) / 0.066)

				var_247_12.localPosition = Vector3.New(var_247_15 * 0.13, var_247_15 * 0.13, var_247_15 * 0.13) + arg_244_1.var_.shakeOldPos
			end

			if arg_244_1.time_ >= 1.06666666666667 + var_247_13 and arg_244_1.time_ < 1.06666666666667 + var_247_13 + arg_247_0 then
				var_247_12.localPosition = arg_244_1.var_.shakeOldPos
			end

			local var_247_16 = 1.33333333333333

			if 1.33333333333333 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.allBtn_.enabled = false
			end

			if arg_244_1.time_ >= var_247_16 + 0.333333333333333 and arg_244_1.time_ < var_247_16 + 0.333333333333333 + arg_247_0 then
				arg_244_1.allBtn_.enabled = true
			end

			local var_247_17 = arg_244_1.bgs_.SS1303.transform

			if 0.733333333333333 < arg_244_1.time_ and arg_244_1.time_ <= 0.733333333333333 + arg_247_0 then
				arg_244_1.var_.moveOldPosSS1303 = var_247_17.localPosition
			end

			local var_247_18 = 0.001

			if 0.733333333333333 <= arg_244_1.time_ and arg_244_1.time_ < 0.733333333333333 + var_247_18 then
				var_247_17.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPosSS1303, Vector3.New(0, 1, 10), (arg_244_1.time_ - 0.733333333333333) / var_247_18)
			end

			if arg_244_1.time_ >= 0.733333333333333 + var_247_18 and arg_244_1.time_ < 0.733333333333333 + var_247_18 + arg_247_0 then
				var_247_17.localPosition = Vector3.New(0, 1, 10)
			end

			local var_247_19 = arg_244_1.bgs_.SS1303.transform

			if 0.75 < arg_244_1.time_ and arg_244_1.time_ <= 0.75 + arg_247_0 then
				arg_244_1.var_.moveOldPosSS1303 = var_247_19.localPosition
			end

			local var_247_20 = 1.93333333333333

			if 0.75 <= arg_244_1.time_ and arg_244_1.time_ < 0.75 + var_247_20 then
				var_247_19.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPosSS1303, Vector3.New(0, 1, 8.6), (arg_244_1.time_ - 0.75) / var_247_20)
			end

			if arg_244_1.time_ >= 0.75 + var_247_20 and arg_244_1.time_ < 0.75 + var_247_20 + arg_247_0 then
				var_247_19.localPosition = Vector3.New(0, 1, 8.6)
			end

			if 0.733333333333333 < arg_244_1.time_ and arg_244_1.time_ <= 0.733333333333333 + arg_247_0 then
				local var_247_21 = arg_244_1.var_.effect破坏1

				if not arg_244_1.var_.effect破坏1 then
					var_247_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_247_21.name = "破坏1"
					arg_244_1.var_.effect破坏1 = var_247_21
				else
					var_247_21.transform:SetParent(var_247_9000)
				end

				var_247_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_247_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.3 < arg_244_1.time_ and arg_244_1.time_ <= 0.3 + arg_247_0 then
				arg_244_1:AudioAction("play", "effect", "se_story_130", "se_story_130_shot2", "")
			end

			if arg_244_1.frameCnt_ <= 1 then
				arg_244_1.dialog_:SetActive(false)
			end

			local var_247_24 = 2.16666666666667
			local var_247_25 = 1.275

			if 2.16666666666667 < arg_244_1.time_ and arg_244_1.time_ <= var_247_24 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_26 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_26:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_27 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(413042059).content)

				arg_244_1.text_.text = var_247_27

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_29 = 51 <= 0 and var_247_25 or var_247_25 * (utf8.len(var_247_27) / 51)

				if (51 <= 0 and var_247_25 or var_247_25 * (utf8.len(var_247_27) / 51)) > 0 and var_247_25 < var_247_29 then
					arg_244_1.talkMaxDuration = var_247_29
					var_247_24 = var_247_24 + 0.3

					if var_247_29 + var_247_24 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_29 + var_247_24
					end
				end

				arg_244_1.text_.text = var_247_27
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_30 = var_247_24 + 0.3
			local var_247_31 = math.max(var_247_25, arg_244_1.talkMaxDuration)

			if var_247_24 + 0.3 <= arg_244_1.time_ and arg_244_1.time_ < var_247_30 + var_247_31 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_30) / var_247_31

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_30 + var_247_31 and arg_244_1.time_ < var_247_30 + var_247_31 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93333333333333,
				className = "StoryMoveNode",
				startTime = 0.75,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play413042060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413042060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play413042061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.9

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

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(413042060).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 36 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 36)

				if (36 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 36)) > 0 and var_253_0 < var_253_3 then
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
	Play413042061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 413042061
		arg_254_1.duration_ = 4.77

		local var_254_0 = {
			zh = 3.8,
			ja = 4.766
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play413042062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.4

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:GetWordFromCfg(413042061)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 16)

				if (16 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 16)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042061", "story_v_out_413042.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042061", "story_v_out_413042.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_out_413042", "413042061", "story_v_out_413042.awb")

						arg_254_1:RecordAudio("413042061", var_257_6)
						arg_254_1:RecordAudio("413042061", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_413042", "413042061", "story_v_out_413042.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_413042", "413042061", "story_v_out_413042.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play413042062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413042062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play413042063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(413042062).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 40 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 40)

				if (40 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 40)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play413042063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413042063
		arg_262_1.duration_ = 5.8

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413042064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				if arg_262_1.var_.effect破坏1 then
					Object.Destroy(arg_262_1.var_.effect破坏1)

					arg_262_1.var_.effect破坏1 = nil
				end
			end

			local var_265_1 = manager.ui.mainCamera.transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_1.localPosition
			end

			local var_265_2 = 0.599676461021105

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 then
				local var_265_3, var_265_4 = math.modf((arg_262_1.time_ - 0) / 0.066)

				var_265_1.localPosition = Vector3.New(var_265_4 * 0.13, var_265_4 * 0.13, var_265_4 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 then
				var_265_1.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_5 = manager.ui.mainCamera.transform

			if 0.8 < arg_262_1.time_ and arg_262_1.time_ <= 0.8 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_5.localPosition
			end

			local var_265_6 = 0.2

			if 0.8 <= arg_262_1.time_ and arg_262_1.time_ < 0.8 + var_265_6 then
				local var_265_7, var_265_8 = math.modf((arg_262_1.time_ - 0.8) / 0.099)

				var_265_5.localPosition = Vector3.New(var_265_8 * 0.13, var_265_8 * 0.13, var_265_8 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= 0.8 + var_265_6 and arg_262_1.time_ < 0.8 + var_265_6 + arg_265_0 then
				var_265_5.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_9 = manager.ui.mainCamera.transform

			if 1.175 < arg_262_1.time_ and arg_262_1.time_ <= 1.175 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_9.localPosition
			end

			local var_265_10 = 0.5

			if 1.175 <= arg_262_1.time_ and arg_262_1.time_ < 1.175 + var_265_10 then
				local var_265_11, var_265_12 = math.modf((arg_262_1.time_ - 1.175) / 0.066)

				var_265_9.localPosition = Vector3.New(var_265_12 * 0.13, var_265_12 * 0.13, var_265_12 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= 1.175 + var_265_10 and arg_262_1.time_ < 1.175 + var_265_10 + arg_265_0 then
				var_265_9.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_13 = 0

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			if arg_262_1.time_ >= var_265_13 + 1.675 and arg_262_1.time_ < var_265_13 + 1.675 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_14 = 0.8
			local var_265_15 = 1.175

			if 0.8 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_16 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_16:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_17 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(413042063).content)

				arg_262_1.text_.text = var_265_17

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_19 = 47 <= 0 and var_265_15 or var_265_15 * (utf8.len(var_265_17) / 47)

				if (47 <= 0 and var_265_15 or var_265_15 * (utf8.len(var_265_17) / 47)) > 0 and var_265_15 < var_265_19 then
					arg_262_1.talkMaxDuration = var_265_19
					var_265_14 = var_265_14 + 0.3

					if var_265_19 + var_265_14 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_19 + var_265_14
					end
				end

				arg_262_1.text_.text = var_265_17
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = var_265_14 + 0.3
			local var_265_21 = math.max(var_265_15, arg_262_1.talkMaxDuration)

			if var_265_14 + 0.3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_20 + var_265_21 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_20) / var_265_21

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_20 + var_265_21 and arg_262_1.time_ < var_265_20 + var_265_21 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play413042064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413042064
		arg_268_1.duration_ = 3.6

		local var_268_0 = {
			zh = 3.6,
			ja = 2.566
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
				arg_268_0:Play413042065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.425

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(413042064)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 17 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 17)

				if (17 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 17)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042064", "story_v_out_413042.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042064", "story_v_out_413042.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_413042", "413042064", "story_v_out_413042.awb")

						arg_268_1:RecordAudio("413042064", var_271_6)
						arg_268_1:RecordAudio("413042064", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413042", "413042064", "story_v_out_413042.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413042", "413042064", "story_v_out_413042.awb")
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
	Play413042065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413042065
		arg_272_1.duration_ = 5.43

		local var_272_0 = {
			zh = 5.433,
			ja = 2.066
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
				arg_272_0:Play413042066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.275

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:GetWordFromCfg(413042065)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 11 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 11)

				if (11 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 11)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042065", "story_v_out_413042.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042065", "story_v_out_413042.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_413042", "413042065", "story_v_out_413042.awb")

						arg_272_1:RecordAudio("413042065", var_275_6)
						arg_272_1:RecordAudio("413042065", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413042", "413042065", "story_v_out_413042.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413042", "413042065", "story_v_out_413042.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play413042066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413042066
		arg_276_1.duration_ = 4.27

		local var_276_0 = {
			zh = 3.7,
			ja = 4.267
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
				arg_276_0:Play413042067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				local var_279_0 = arg_276_1.bgs_.F10f

				arg_276_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_279_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_1 = var_279_0:GetComponent("SpriteRenderer")

				if var_279_1 and var_279_1.sprite then
					local var_279_2 = 2 * (var_279_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_279_0.transform.localScale = Vector3.New(var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "F10f" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_3 = 0.834

			if 0.834 < arg_276_1.time_ and arg_276_1.time_ <= var_279_3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			if arg_276_1.time_ >= var_279_3 + 0.3 and arg_276_1.time_ < var_279_3 + 0.3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			local var_279_4 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_5 = 2

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_5 then
				local var_279_6 = Color.New(0, 0, 0)

				var_279_6.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_4) / var_279_5)
				arg_276_1.mask_.color = var_279_6
			end

			if arg_276_1.time_ >= var_279_4 + var_279_5 and arg_276_1.time_ < var_279_4 + var_279_5 + arg_279_0 then
				local var_279_7 = Color.New(0, 0, 0)

				arg_276_1.mask_.enabled = false
				var_279_7.a = 0
				arg_276_1.mask_.color = var_279_7
			end

			local var_279_8 = arg_276_1.actors_["10022"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10022 = var_279_8.localPosition
				var_279_8.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10022", 7)

				for iter_279_2 = 0, var_279_8.childCount - 1 do
					local var_279_9 = var_279_8:GetChild(iter_279_2)

					if var_279_9.name == "" or not string.find(var_279_9.name, "split") then
						var_279_9.gameObject:SetActive(true)
					else
						var_279_9.gameObject:SetActive(false)
					end
				end
			end

			local var_279_10 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_10 then
				var_279_8.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_276_1.time_ - 0) / var_279_10)
			end

			if arg_276_1.time_ >= 0 + var_279_10 and arg_276_1.time_ < 0 + var_279_10 + arg_279_0 then
				var_279_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_279_11 = arg_276_1.actors_["10092"].transform

			if 0.8 < arg_276_1.time_ and arg_276_1.time_ <= 0.8 + arg_279_0 then
				arg_276_1.var_.moveOldPos10092 = var_279_11.localPosition
				var_279_11.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10092", 3)

				for iter_279_3 = 0, var_279_11.childCount - 1 do
					local var_279_12 = var_279_11:GetChild(iter_279_3)

					if var_279_12.name == "split_2" or not string.find(var_279_12.name, "split") then
						var_279_12.gameObject:SetActive(true)
					else
						var_279_12.gameObject:SetActive(false)
					end
				end
			end

			local var_279_13 = 0.001

			if 0.8 <= arg_276_1.time_ and arg_276_1.time_ < 0.8 + var_279_13 then
				var_279_11.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_276_1.time_ - 0.8) / var_279_13)
			end

			if arg_276_1.time_ >= 0.8 + var_279_13 and arg_276_1.time_ < 0.8 + var_279_13 + arg_279_0 then
				var_279_11.localPosition = Vector3.New(0, -300, -295)
			end

			local var_279_14 = arg_276_1.actors_["10022"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_14) and arg_276_1.var_.actorSpriteComps10022 == nil then
				arg_276_1.var_.actorSpriteComps10022 = var_279_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_15 = 0.034

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_15 and not isNil(var_279_14) then
				if arg_276_1.var_.actorSpriteComps10022 then
					for iter_279_4, iter_279_5 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_279_5 then
							if arg_276_1.isInRecall_ then
								iter_279_5.color = Color.New(Mathf.Lerp(iter_279_5.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_15), Mathf.Lerp(iter_279_5.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_15), (Mathf.Lerp(iter_279_5.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_15)))
							else
								local var_279_16 = Mathf.Lerp(iter_279_5.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_15)

								iter_279_5.color = Color.New(var_279_16, var_279_16, var_279_16)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_15 and arg_276_1.time_ < 0 + var_279_15 + arg_279_0 and not isNil(var_279_14) and arg_276_1.var_.actorSpriteComps10022 then
				for iter_279_6, iter_279_7 in pairs(arg_276_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_279_7 then
						iter_279_7.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10022 = nil
			end

			local var_279_17 = arg_276_1.actors_["10092"]

			if 0.8 < arg_276_1.time_ and arg_276_1.time_ <= 0.8 + arg_279_0 and not isNil(var_279_17) and arg_276_1.var_.actorSpriteComps10092 == nil then
				arg_276_1.var_.actorSpriteComps10092 = var_279_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_18 = 0.2

			if 0.8 <= arg_276_1.time_ and arg_276_1.time_ < 0.8 + var_279_18 and not isNil(var_279_17) then
				if arg_276_1.var_.actorSpriteComps10092 then
					for iter_279_8, iter_279_9 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_279_9 then
							if arg_276_1.isInRecall_ then
								iter_279_9.color = Color.New(Mathf.Lerp(iter_279_9.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0.8) / var_279_18), Mathf.Lerp(iter_279_9.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0.8) / var_279_18), (Mathf.Lerp(iter_279_9.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0.8) / var_279_18)))
							else
								local var_279_19 = Mathf.Lerp(iter_279_9.color.r, 1, (arg_276_1.time_ - 0.8) / var_279_18)

								iter_279_9.color = Color.New(var_279_19, var_279_19, var_279_19)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0.8 + var_279_18 and arg_276_1.time_ < 0.8 + var_279_18 + arg_279_0 and not isNil(var_279_17) and arg_276_1.var_.actorSpriteComps10092 then
				for iter_279_10, iter_279_11 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_279_11 then
						iter_279_11.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps10092 = nil
			end

			local var_279_20 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_20 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = false

				arg_276_1:SetGaussion(false)
			end

			local var_279_21 = 1

			if var_279_20 <= arg_276_1.time_ and arg_276_1.time_ < var_279_20 + var_279_21 then
				local var_279_22 = Color.New(1, 1, 1)

				var_279_22.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_20) / var_279_21)
				arg_276_1.mask_.color = var_279_22
			end

			if arg_276_1.time_ >= var_279_20 + var_279_21 and arg_276_1.time_ < var_279_20 + var_279_21 + arg_279_0 then
				local var_279_23 = Color.New(1, 1, 1)

				arg_276_1.mask_.enabled = false
				var_279_23.a = 0
				arg_276_1.mask_.color = var_279_23
			end

			if 0.8 < arg_276_1.time_ and arg_276_1.time_ <= 0.8 + arg_279_0 then
				local var_279_24 = arg_276_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_279_24 then
					arg_276_1.var_.alphaOldValue10092 = var_279_24.alpha
					arg_276_1.var_.characterEffect10092 = var_279_24
				end

				arg_276_1.var_.alphaOldValue10092 = 0
			end

			local var_279_25 = 0.2

			if 0.8 <= arg_276_1.time_ and arg_276_1.time_ < 0.8 + var_279_25 then
				if arg_276_1.var_.characterEffect10092 then
					arg_276_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_276_1.var_.alphaOldValue10092, 1, (arg_276_1.time_ - 0.8) / var_279_25)
				end
			end

			if arg_276_1.time_ >= 0.8 + var_279_25 and arg_276_1.time_ < 0.8 + var_279_25 + arg_279_0 and arg_276_1.var_.characterEffect10092 then
				arg_276_1.var_.characterEffect10092.alpha = 1
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_26 = 0.834
			local var_279_27 = 0.375

			if 0.834 < arg_276_1.time_ and arg_276_1.time_ <= var_279_26 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_28 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_28:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_29 = arg_276_1:GetWordFromCfg(413042066)
				local var_279_30 = arg_276_1:FormatText(var_279_29.content)

				arg_276_1.text_.text = var_279_30

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_32 = 15 <= 0 and var_279_27 or var_279_27 * (utf8.len(var_279_30) / 15)

				if (15 <= 0 and var_279_27 or var_279_27 * (utf8.len(var_279_30) / 15)) > 0 and var_279_27 < var_279_32 then
					arg_276_1.talkMaxDuration = var_279_32
					var_279_26 = var_279_26 + 0.3

					if var_279_32 + var_279_26 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_32 + var_279_26
					end
				end

				arg_276_1.text_.text = var_279_30
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042066", "story_v_out_413042.awb") ~= 0 then
					local var_279_33 = manager.audio:GetVoiceLength("story_v_out_413042", "413042066", "story_v_out_413042.awb") / 1000

					if var_279_33 + var_279_26 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_33 + var_279_26
					end

					if var_279_29.prefab_name ~= "" and arg_276_1.actors_[var_279_29.prefab_name] ~= nil then
						local var_279_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_29.prefab_name].transform, "story_v_out_413042", "413042066", "story_v_out_413042.awb")

						arg_276_1:RecordAudio("413042066", var_279_34)
						arg_276_1:RecordAudio("413042066", var_279_34)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_413042", "413042066", "story_v_out_413042.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_413042", "413042066", "story_v_out_413042.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_35 = var_279_26 + 0.3
			local var_279_36 = math.max(var_279_27, arg_276_1.talkMaxDuration)

			if var_279_26 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_35 + var_279_36 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_35) / var_279_36

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_35 + var_279_36 and arg_276_1.time_ < var_279_35 + var_279_36 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play413042067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413042067
		arg_282_1.duration_ = 2.23

		local var_282_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play413042068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10022 = arg_282_1.actors_["10022"].transform.localPosition
				arg_282_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10022", 3)

				for iter_285_0 = 0, arg_282_1.actors_["10022"].transform.childCount - 1 do
					local var_285_0 = arg_282_1.actors_["10022"].transform:GetChild(iter_285_0)

					if var_285_0.name == "split_8" or not string.find(var_285_0.name, "split") then
						var_285_0.gameObject:SetActive(true)
					else
						var_285_0.gameObject:SetActive(false)
					end
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_282_1.time_ - 0) / var_285_1)
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_285_2 = arg_282_1.actors_["10092"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10092 = var_285_2.localPosition
				var_285_2.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10092", 7)

				for iter_285_1 = 0, var_285_2.childCount - 1 do
					local var_285_3 = var_285_2:GetChild(iter_285_1)

					if var_285_3.name == "split_1_1" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				var_285_2.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_282_1.time_ - 0) / var_285_4)
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				var_285_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_5 = arg_282_1.actors_["10022"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps10022 == nil then
				arg_282_1.var_.actorSpriteComps10022 = var_285_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_6 = 2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_6 and not isNil(var_285_5) then
				if arg_282_1.var_.actorSpriteComps10022 then
					for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_285_3 then
							if arg_282_1.isInRecall_ then
								iter_285_3.color = Color.New(Mathf.Lerp(iter_285_3.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_6), Mathf.Lerp(iter_285_3.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_6), (Mathf.Lerp(iter_285_3.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_6)))
							else
								local var_285_7 = Mathf.Lerp(iter_285_3.color.r, 1, (arg_282_1.time_ - 0) / var_285_6)

								iter_285_3.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_6 and arg_282_1.time_ < 0 + var_285_6 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps10022 then
				for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_285_5 then
						iter_285_5.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps10022 = nil
			end

			local var_285_8 = arg_282_1.actors_["10092"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10092 == nil then
				arg_282_1.var_.actorSpriteComps10092 = var_285_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_9 = 2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_9 and not isNil(var_285_8) then
				if arg_282_1.var_.actorSpriteComps10092 then
					for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_285_7 then
							if arg_282_1.isInRecall_ then
								iter_285_7.color = Color.New(Mathf.Lerp(iter_285_7.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_9), Mathf.Lerp(iter_285_7.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_9), (Mathf.Lerp(iter_285_7.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_9)))
							else
								local var_285_10 = Mathf.Lerp(iter_285_7.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_9)

								iter_285_7.color = Color.New(var_285_10, var_285_10, var_285_10)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_9 and arg_282_1.time_ < 0 + var_285_9 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10092 then
				for iter_285_8, iter_285_9 in pairs(arg_282_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_285_9 then
						iter_285_9.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps10092 = nil
			end

			local var_285_11 = 0
			local var_285_12 = 0.15

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_11 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_13 = arg_282_1:GetWordFromCfg(413042067)
				local var_285_14 = arg_282_1:FormatText(var_285_13.content)

				arg_282_1.text_.text = var_285_14

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_16 = 6 <= 0 and var_285_12 or var_285_12 * (utf8.len(var_285_14) / 6)

				if (6 <= 0 and var_285_12 or var_285_12 * (utf8.len(var_285_14) / 6)) > 0 and var_285_12 < var_285_16 then
					arg_282_1.talkMaxDuration = var_285_16

					if var_285_16 + var_285_11 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_16 + var_285_11
					end
				end

				arg_282_1.text_.text = var_285_14
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042067", "story_v_out_413042.awb") ~= 0 then
					local var_285_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042067", "story_v_out_413042.awb") / 1000

					if var_285_17 + var_285_11 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_17 + var_285_11
					end

					if var_285_13.prefab_name ~= "" and arg_282_1.actors_[var_285_13.prefab_name] ~= nil then
						local var_285_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_13.prefab_name].transform, "story_v_out_413042", "413042067", "story_v_out_413042.awb")

						arg_282_1:RecordAudio("413042067", var_285_18)
						arg_282_1:RecordAudio("413042067", var_285_18)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413042", "413042067", "story_v_out_413042.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413042", "413042067", "story_v_out_413042.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_19 = math.max(var_285_12, arg_282_1.talkMaxDuration)

			if var_285_11 <= arg_282_1.time_ and arg_282_1.time_ < var_285_11 + var_285_19 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_11) / var_285_19

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_11 + var_285_19 and arg_282_1.time_ < var_285_11 + var_285_19 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play413042068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413042068
		arg_286_1.duration_ = 4.2

		local var_286_0 = {
			zh = 3.6,
			ja = 4.2
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play413042069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10022 = arg_286_1.actors_["10022"].transform.localPosition
				arg_286_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10022", 0)

				for iter_289_0 = 0, arg_286_1.actors_["10022"].transform.childCount - 1 do
					local var_289_0 = arg_286_1.actors_["10022"].transform:GetChild(iter_289_0)

					if var_289_0.name == "" or not string.find(var_289_0.name, "split") then
						var_289_0.gameObject:SetActive(true)
					else
						var_289_0.gameObject:SetActive(false)
					end
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_286_1.time_ - 0) / var_289_1)
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_289_2 = arg_286_1.actors_["10092"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10092 = var_289_2.localPosition
				var_289_2.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10092", 3)

				for iter_289_1 = 0, var_289_2.childCount - 1 do
					local var_289_3 = var_289_2:GetChild(iter_289_1)

					if var_289_3.name == "" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				var_289_2.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_286_1.time_ - 0) / var_289_4)
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				var_289_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_289_5 = arg_286_1.actors_["10022"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_5) and arg_286_1.var_.actorSpriteComps10022 == nil then
				arg_286_1.var_.actorSpriteComps10022 = var_289_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_6 = 2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_6 and not isNil(var_289_5) then
				if arg_286_1.var_.actorSpriteComps10022 then
					for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_289_3 then
							if arg_286_1.isInRecall_ then
								iter_289_3.color = Color.New(Mathf.Lerp(iter_289_3.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_6), Mathf.Lerp(iter_289_3.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_6), (Mathf.Lerp(iter_289_3.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_6)))
							else
								local var_289_7 = Mathf.Lerp(iter_289_3.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_6)

								iter_289_3.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_6 and arg_286_1.time_ < 0 + var_289_6 + arg_289_0 and not isNil(var_289_5) and arg_286_1.var_.actorSpriteComps10022 then
				for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_289_5 then
						iter_289_5.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps10022 = nil
			end

			local var_289_8 = arg_286_1.actors_["10092"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10092 == nil then
				arg_286_1.var_.actorSpriteComps10092 = var_289_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_9 = 2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_9 and not isNil(var_289_8) then
				if arg_286_1.var_.actorSpriteComps10092 then
					for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_289_7 then
							if arg_286_1.isInRecall_ then
								iter_289_7.color = Color.New(Mathf.Lerp(iter_289_7.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_9), Mathf.Lerp(iter_289_7.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_9), (Mathf.Lerp(iter_289_7.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_9)))
							else
								local var_289_10 = Mathf.Lerp(iter_289_7.color.r, 1, (arg_286_1.time_ - 0) / var_289_9)

								iter_289_7.color = Color.New(var_289_10, var_289_10, var_289_10)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_9 and arg_286_1.time_ < 0 + var_289_9 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10092 then
				for iter_289_8, iter_289_9 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_289_9 then
						iter_289_9.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps10092 = nil
			end

			local var_289_11 = 0
			local var_289_12 = 0.375

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_11 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_13 = arg_286_1:GetWordFromCfg(413042068)
				local var_289_14 = arg_286_1:FormatText(var_289_13.content)

				arg_286_1.text_.text = var_289_14

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_16 = 15 <= 0 and var_289_12 or var_289_12 * (utf8.len(var_289_14) / 15)

				if (15 <= 0 and var_289_12 or var_289_12 * (utf8.len(var_289_14) / 15)) > 0 and var_289_12 < var_289_16 then
					arg_286_1.talkMaxDuration = var_289_16

					if var_289_16 + var_289_11 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_16 + var_289_11
					end
				end

				arg_286_1.text_.text = var_289_14
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042068", "story_v_out_413042.awb") ~= 0 then
					local var_289_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042068", "story_v_out_413042.awb") / 1000

					if var_289_17 + var_289_11 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_17 + var_289_11
					end

					if var_289_13.prefab_name ~= "" and arg_286_1.actors_[var_289_13.prefab_name] ~= nil then
						local var_289_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_13.prefab_name].transform, "story_v_out_413042", "413042068", "story_v_out_413042.awb")

						arg_286_1:RecordAudio("413042068", var_289_18)
						arg_286_1:RecordAudio("413042068", var_289_18)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413042", "413042068", "story_v_out_413042.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413042", "413042068", "story_v_out_413042.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_19 = math.max(var_289_12, arg_286_1.talkMaxDuration)

			if var_289_11 <= arg_286_1.time_ and arg_286_1.time_ < var_289_11 + var_289_19 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_11) / var_289_19

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_11 + var_289_19 and arg_286_1.time_ < var_289_11 + var_289_19 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play413042069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 413042069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play413042070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos10092 = arg_290_1.actors_["10092"].transform.localPosition
				arg_290_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10092", 7)

				for iter_293_0 = 0, arg_290_1.actors_["10092"].transform.childCount - 1 do
					local var_293_0 = arg_290_1.actors_["10092"].transform:GetChild(iter_293_0)

					if var_293_0.name == "" or not string.find(var_293_0.name, "split") then
						var_293_0.gameObject:SetActive(true)
					else
						var_293_0.gameObject:SetActive(false)
					end
				end
			end

			local var_293_1 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_1 then
				arg_290_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_290_1.time_ - 0) / var_293_1)
			end

			if arg_290_1.time_ >= 0 + var_293_1 and arg_290_1.time_ < 0 + var_293_1 + arg_293_0 then
				arg_290_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_293_2 = arg_290_1.actors_["10092"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps10092 == nil then
				arg_290_1.var_.actorSpriteComps10092 = var_293_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_3 = 2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 and not isNil(var_293_2) then
				if arg_290_1.var_.actorSpriteComps10092 then
					for iter_293_1, iter_293_2 in pairs(arg_290_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_293_2 then
							if arg_290_1.isInRecall_ then
								iter_293_2.color = Color.New(Mathf.Lerp(iter_293_2.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_3), Mathf.Lerp(iter_293_2.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_3), (Mathf.Lerp(iter_293_2.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_3)))
							else
								local var_293_4 = Mathf.Lerp(iter_293_2.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_3)

								iter_293_2.color = Color.New(var_293_4, var_293_4, var_293_4)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps10092 then
				for iter_293_3, iter_293_4 in pairs(arg_290_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_293_4 then
						iter_293_4.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps10092 = nil
			end

			local var_293_5 = manager.ui.mainCamera.transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.shakeOldPos = var_293_5.localPosition
			end

			local var_293_6 = 0.6

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_6 then
				local var_293_7, var_293_8 = math.modf((arg_290_1.time_ - 0) / 0.066)

				var_293_5.localPosition = Vector3.New(var_293_8 * 0.13, var_293_8 * 0.13, var_293_8 * 0.13) + arg_290_1.var_.shakeOldPos
			end

			if arg_290_1.time_ >= 0 + var_293_6 and arg_290_1.time_ < 0 + var_293_6 + arg_293_0 then
				var_293_5.localPosition = arg_290_1.var_.shakeOldPos
			end

			local var_293_9 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_9 + 0.6 and arg_290_1.time_ < var_293_9 + 0.6 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_10 = 0
			local var_293_11 = 1.15

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_12 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(413042069).content)

				arg_290_1.text_.text = var_293_12

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_14 = 46 <= 0 and var_293_11 or var_293_11 * (utf8.len(var_293_12) / 46)

				if (46 <= 0 and var_293_11 or var_293_11 * (utf8.len(var_293_12) / 46)) > 0 and var_293_11 < var_293_14 then
					arg_290_1.talkMaxDuration = var_293_14

					if var_293_14 + var_293_10 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_10
					end
				end

				arg_290_1.text_.text = var_293_12
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_15 = math.max(var_293_11, arg_290_1.talkMaxDuration)

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_15 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_10) / var_293_15

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_10 + var_293_15 and arg_290_1.time_ < var_293_10 + var_293_15 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play413042070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 413042070
		arg_294_1.duration_ = 3.57

		local var_294_0 = {
			zh = 3.26666666666667,
			ja = 3.56666666666667
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play413042071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10094 = arg_294_1.actors_["10094"].transform.localPosition
				arg_294_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("10094", 3)

				for iter_297_0 = 0, arg_294_1.actors_["10094"].transform.childCount - 1 do
					local var_297_0 = arg_294_1.actors_["10094"].transform:GetChild(iter_297_0)

					if var_297_0.name == "" or not string.find(var_297_0.name, "split") then
						var_297_0.gameObject:SetActive(true)
					else
						var_297_0.gameObject:SetActive(false)
					end
				end
			end

			local var_297_1 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_1 then
				arg_294_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_294_1.time_ - 0) / var_297_1)
			end

			if arg_294_1.time_ >= 0 + var_297_1 and arg_294_1.time_ < 0 + var_297_1 + arg_297_0 then
				arg_294_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_297_2 = arg_294_1.actors_["10094"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps10094 == nil then
				arg_294_1.var_.actorSpriteComps10094 = var_297_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_3 = 2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 and not isNil(var_297_2) then
				if arg_294_1.var_.actorSpriteComps10094 then
					for iter_297_1, iter_297_2 in pairs(arg_294_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_297_2 then
							if arg_294_1.isInRecall_ then
								iter_297_2.color = Color.New(Mathf.Lerp(iter_297_2.color.r, arg_294_1.hightColor1.r, (arg_294_1.time_ - 0) / var_297_3), Mathf.Lerp(iter_297_2.color.g, arg_294_1.hightColor1.g, (arg_294_1.time_ - 0) / var_297_3), (Mathf.Lerp(iter_297_2.color.b, arg_294_1.hightColor1.b, (arg_294_1.time_ - 0) / var_297_3)))
							else
								local var_297_4 = Mathf.Lerp(iter_297_2.color.r, 1, (arg_294_1.time_ - 0) / var_297_3)

								iter_297_2.color = Color.New(var_297_4, var_297_4, var_297_4)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps10094 then
				for iter_297_3, iter_297_4 in pairs(arg_294_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_297_4 then
						iter_297_4.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_294_1.var_.actorSpriteComps10094 = nil
			end

			if 0.378775801509619 < arg_294_1.time_ and arg_294_1.time_ <= 0.378775801509619 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				local var_297_6 = arg_294_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_297_6 then
					arg_294_1.var_.alphaOldValue10094 = var_297_6.alpha
					arg_294_1.var_.characterEffect10094 = var_297_6
				end

				arg_294_1.var_.alphaOldValue10094 = 0
			end

			local var_297_7 = 0.378775801509619

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				if arg_294_1.var_.characterEffect10094 then
					arg_294_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_294_1.var_.alphaOldValue10094, 1, (arg_294_1.time_ - 0) / var_297_7)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 and arg_294_1.var_.characterEffect10094 then
				arg_294_1.var_.characterEffect10094.alpha = 1
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_8 = 0.666666666666667
			local var_297_9 = 0.125

			if 0.666666666666667 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_10 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_10:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_11 = arg_294_1:GetWordFromCfg(413042070)
				local var_297_12 = arg_294_1:FormatText(var_297_11.content)

				arg_294_1.text_.text = var_297_12

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_14 = 5 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_12) / 5)

				if (5 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_12) / 5)) > 0 and var_297_9 < var_297_14 then
					arg_294_1.talkMaxDuration = var_297_14
					var_297_8 = var_297_8 + 0.3

					if var_297_14 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_12
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042070", "story_v_out_413042.awb") ~= 0 then
					local var_297_15 = manager.audio:GetVoiceLength("story_v_out_413042", "413042070", "story_v_out_413042.awb") / 1000

					if var_297_15 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_15 + var_297_8
					end

					if var_297_11.prefab_name ~= "" and arg_294_1.actors_[var_297_11.prefab_name] ~= nil then
						local var_297_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_11.prefab_name].transform, "story_v_out_413042", "413042070", "story_v_out_413042.awb")

						arg_294_1:RecordAudio("413042070", var_297_16)
						arg_294_1:RecordAudio("413042070", var_297_16)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_413042", "413042070", "story_v_out_413042.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_413042", "413042070", "story_v_out_413042.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_17 = var_297_8 + 0.3
			local var_297_18 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_17 + var_297_18 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_17) / var_297_18

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_17 + var_297_18 and arg_294_1.time_ < var_297_17 + var_297_18 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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

		arg_294_1:InitPlayNodeList()
	end,
	Play413042071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413042071
		arg_300_1.duration_ = 5.88

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play413042072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10094 = arg_300_1.actors_["10094"].transform.localPosition
				arg_300_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10094", 0)

				for iter_303_0 = 0, arg_300_1.actors_["10094"].transform.childCount - 1 do
					local var_303_0 = arg_300_1.actors_["10094"].transform:GetChild(iter_303_0)

					if var_303_0.name == "" or not string.find(var_303_0.name, "split") then
						var_303_0.gameObject:SetActive(true)
					else
						var_303_0.gameObject:SetActive(false)
					end
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_300_1.time_ - 0) / var_303_1)
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10094"].transform.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_303_2 = arg_300_1.actors_["10094"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10094 == nil then
				arg_300_1.var_.actorSpriteComps10094 = var_303_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_3 = 2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.actorSpriteComps10094 then
					for iter_303_1, iter_303_2 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_303_2 then
							if arg_300_1.isInRecall_ then
								iter_303_2.color = Color.New(Mathf.Lerp(iter_303_2.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_3), Mathf.Lerp(iter_303_2.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_3), (Mathf.Lerp(iter_303_2.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_3)))
							else
								local var_303_4 = Mathf.Lerp(iter_303_2.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_3)

								iter_303_2.color = Color.New(var_303_4, var_303_4, var_303_4)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10094 then
				for iter_303_3, iter_303_4 in pairs(arg_300_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_303_4 then
						iter_303_4.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10094 = nil
			end

			local var_303_5 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			if arg_300_1.time_ >= var_303_5 + 1 and arg_300_1.time_ < var_303_5 + 1 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			if 1.75755160301924 < arg_300_1.time_ and arg_300_1.time_ <= 1.75755160301924 + arg_303_0 then
				arg_300_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_303_7 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_8 = 0.666666666666667

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_8 then
				local var_303_9 = Color.New(1, 1, 1)

				var_303_9.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_7) / var_303_8)
				arg_300_1.mask_.color = var_303_9
			end

			if arg_300_1.time_ >= var_303_7 + var_303_8 and arg_300_1.time_ < var_303_7 + var_303_8 + arg_303_0 then
				local var_303_10 = Color.New(1, 1, 1)

				arg_300_1.mask_.enabled = false
				var_303_10.a = 0
				arg_300_1.mask_.color = var_303_10
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_11 = 0.878775801509619
			local var_303_12 = 1.5

			if 0.878775801509619 < arg_300_1.time_ and arg_300_1.time_ <= var_303_11 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_13 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_13:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_14 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(413042071).content)

				arg_300_1.text_.text = var_303_14

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_16 = 60 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 60)

				if (60 <= 0 and var_303_12 or var_303_12 * (utf8.len(var_303_14) / 60)) > 0 and var_303_12 < var_303_16 then
					arg_300_1.talkMaxDuration = var_303_16
					var_303_11 = var_303_11 + 0.3

					if var_303_16 + var_303_11 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_16 + var_303_11
					end
				end

				arg_300_1.text_.text = var_303_14
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_17 = var_303_11 + 0.3
			local var_303_18 = math.max(var_303_12, arg_300_1.talkMaxDuration)

			if var_303_11 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_17 + var_303_18 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_17) / var_303_18

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_17 + var_303_18 and arg_300_1.time_ < var_303_17 + var_303_18 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play413042072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 413042072
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play413042073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.8

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(413042072).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 32 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 32)

				if (32 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 32)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play413042073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 413042073
		arg_310_1.duration_ = 3.27

		local var_310_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play413042074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10092 = arg_310_1.actors_["10092"].transform.localPosition
				arg_310_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10092", 3)

				for iter_313_0 = 0, arg_310_1.actors_["10092"].transform.childCount - 1 do
					local var_313_0 = arg_310_1.actors_["10092"].transform:GetChild(iter_313_0)

					if var_313_0.name == "split_3" or not string.find(var_313_0.name, "split") then
						var_313_0.gameObject:SetActive(true)
					else
						var_313_0.gameObject:SetActive(false)
					end
				end
			end

			local var_313_1 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 then
				arg_310_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_310_1.time_ - 0) / var_313_1)
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 then
				arg_310_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_313_2 = arg_310_1.actors_["10092"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10092 == nil then
				arg_310_1.var_.actorSpriteComps10092 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps10092 then
					for iter_313_1, iter_313_2 in pairs(arg_310_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_313_2 then
							if arg_310_1.isInRecall_ then
								iter_313_2.color = Color.New(Mathf.Lerp(iter_313_2.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_2.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_2.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_2.color.r, 1, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_2.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps10092 then
				for iter_313_3, iter_313_4 in pairs(arg_310_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_313_4 then
						iter_313_4.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps10092 = nil
			end

			local var_313_5 = 0
			local var_313_6 = 0.25

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(413042073)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 10 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 10)

				if (10 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 10)) > 0 and var_313_6 < var_313_10 then
					arg_310_1.talkMaxDuration = var_313_10

					if var_313_10 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042073", "story_v_out_413042.awb") ~= 0 then
					local var_313_11 = manager.audio:GetVoiceLength("story_v_out_413042", "413042073", "story_v_out_413042.awb") / 1000

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_413042", "413042073", "story_v_out_413042.awb")

						arg_310_1:RecordAudio("413042073", var_313_12)
						arg_310_1:RecordAudio("413042073", var_313_12)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_413042", "413042073", "story_v_out_413042.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_413042", "413042073", "story_v_out_413042.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_13 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_13 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_13

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_13 and arg_310_1.time_ < var_313_5 + var_313_13 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play413042074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 413042074
		arg_314_1.duration_ = 6.47

		local var_314_0 = {
			zh = 2.066,
			ja = 6.466
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play413042075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10092 = arg_314_1.actors_["10092"].transform.localPosition
				arg_314_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10092", 0)

				for iter_317_0 = 0, arg_314_1.actors_["10092"].transform.childCount - 1 do
					local var_317_0 = arg_314_1.actors_["10092"].transform:GetChild(iter_317_0)

					if var_317_0.name == "" or not string.find(var_317_0.name, "split") then
						var_317_0.gameObject:SetActive(true)
					else
						var_317_0.gameObject:SetActive(false)
					end
				end
			end

			local var_317_1 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_1 then
				arg_314_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_314_1.time_ - 0) / var_317_1)
			end

			if arg_314_1.time_ >= 0 + var_317_1 and arg_314_1.time_ < 0 + var_317_1 + arg_317_0 then
				arg_314_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_317_2 = arg_314_1.actors_["10094"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10094 = var_317_2.localPosition
				var_317_2.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10094", 3)

				for iter_317_1 = 0, var_317_2.childCount - 1 do
					local var_317_3 = var_317_2:GetChild(iter_317_1)

					if var_317_3.name == "" or not string.find(var_317_3.name, "split") then
						var_317_3.gameObject:SetActive(true)
					else
						var_317_3.gameObject:SetActive(false)
					end
				end
			end

			local var_317_4 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				var_317_2.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_314_1.time_ - 0) / var_317_4)
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				var_317_2.localPosition = Vector3.New(0, -340, -414)
			end

			local var_317_5 = arg_314_1.actors_["10092"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_5) and arg_314_1.var_.actorSpriteComps10092 == nil then
				arg_314_1.var_.actorSpriteComps10092 = var_317_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_6 = 2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_6 and not isNil(var_317_5) then
				if arg_314_1.var_.actorSpriteComps10092 then
					for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_317_3 then
							if arg_314_1.isInRecall_ then
								iter_317_3.color = Color.New(Mathf.Lerp(iter_317_3.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_6), Mathf.Lerp(iter_317_3.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_6), (Mathf.Lerp(iter_317_3.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_6)))
							else
								local var_317_7 = Mathf.Lerp(iter_317_3.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_6)

								iter_317_3.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_6 and arg_314_1.time_ < 0 + var_317_6 + arg_317_0 and not isNil(var_317_5) and arg_314_1.var_.actorSpriteComps10092 then
				for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_317_5 then
						iter_317_5.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps10092 = nil
			end

			local var_317_8 = arg_314_1.actors_["10094"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10094 == nil then
				arg_314_1.var_.actorSpriteComps10094 = var_317_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_9 = 2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_9 and not isNil(var_317_8) then
				if arg_314_1.var_.actorSpriteComps10094 then
					for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_317_7 then
							if arg_314_1.isInRecall_ then
								iter_317_7.color = Color.New(Mathf.Lerp(iter_317_7.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_9), Mathf.Lerp(iter_317_7.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_9), (Mathf.Lerp(iter_317_7.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_9)))
							else
								local var_317_10 = Mathf.Lerp(iter_317_7.color.r, 1, (arg_314_1.time_ - 0) / var_317_9)

								iter_317_7.color = Color.New(var_317_10, var_317_10, var_317_10)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_9 and arg_314_1.time_ < 0 + var_317_9 + arg_317_0 and not isNil(var_317_8) and arg_314_1.var_.actorSpriteComps10094 then
				for iter_317_8, iter_317_9 in pairs(arg_314_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_317_9 then
						iter_317_9.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps10094 = nil
			end

			local var_317_11 = 0
			local var_317_12 = 0.25

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_11 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_13 = arg_314_1:GetWordFromCfg(413042074)
				local var_317_14 = arg_314_1:FormatText(var_317_13.content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_16 = 10 <= 0 and var_317_12 or var_317_12 * (utf8.len(var_317_14) / 10)

				if (10 <= 0 and var_317_12 or var_317_12 * (utf8.len(var_317_14) / 10)) > 0 and var_317_12 < var_317_16 then
					arg_314_1.talkMaxDuration = var_317_16

					if var_317_16 + var_317_11 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_16 + var_317_11
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042074", "story_v_out_413042.awb") ~= 0 then
					local var_317_17 = manager.audio:GetVoiceLength("story_v_out_413042", "413042074", "story_v_out_413042.awb") / 1000

					if var_317_17 + var_317_11 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_17 + var_317_11
					end

					if var_317_13.prefab_name ~= "" and arg_314_1.actors_[var_317_13.prefab_name] ~= nil then
						local var_317_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_13.prefab_name].transform, "story_v_out_413042", "413042074", "story_v_out_413042.awb")

						arg_314_1:RecordAudio("413042074", var_317_18)
						arg_314_1:RecordAudio("413042074", var_317_18)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_413042", "413042074", "story_v_out_413042.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_413042", "413042074", "story_v_out_413042.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_19 = math.max(var_317_12, arg_314_1.talkMaxDuration)

			if var_317_11 <= arg_314_1.time_ and arg_314_1.time_ < var_317_11 + var_317_19 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_11) / var_317_19

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_11 + var_317_19 and arg_314_1.time_ < var_317_11 + var_317_19 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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

		arg_314_1:InitPlayNodeList()
	end,
	Play413042075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 413042075
		arg_318_1.duration_ = 3.6

		local var_318_0 = {
			zh = 2.7,
			ja = 3.6
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
			arg_318_1.auto_ = false
		end

		function arg_318_1.playNext_(arg_320_0)
			arg_318_1.onStoryFinished_()
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.275

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:GetWordFromCfg(413042075)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 11 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 11)

				if (11 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 11)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413042", "413042075", "story_v_out_413042.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_out_413042", "413042075", "story_v_out_413042.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_out_413042", "413042075", "story_v_out_413042.awb")

						arg_318_1:RecordAudio("413042075", var_321_6)
						arg_318_1:RecordAudio("413042075", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_413042", "413042075", "story_v_out_413042.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_413042", "413042075", "story_v_out_413042.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10f",
		"TextureConfig/Background/SS1303"
	},
	voices = {
		"story_v_out_413042.awb"
	}
}
