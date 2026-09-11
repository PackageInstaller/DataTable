return {
	Play413012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413012001
		arg_1_1.duration_ = 7.13

		local var_1_0 = {
			zh = 4.866,
			ja = 7.133
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
				arg_1_0:Play413012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0602 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0602")
				var_4_0.name = "ST0602"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0602 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0602

				arg_1_1.bgs_.ST0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0602" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

				local var_4_14 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(413012001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 15)

				if (15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 15)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012001", "story_v_out_413012.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_413012", "413012001", "story_v_out_413012.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_413012", "413012001", "story_v_out_413012.awb")

						arg_1_1:RecordAudio("413012001", var_4_23)
						arg_1_1:RecordAudio("413012001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413012", "413012001", "story_v_out_413012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413012", "413012001", "story_v_out_413012.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413012002
		arg_9_1.duration_ = 11.23

		local var_9_0 = {
			zh = 5.633,
			ja = 11.233
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
				arg_9_0:Play413012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10022"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10022"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10022"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10022"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_6" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -315, -320)
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
								iter_12_4.color = Color.New(Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_6), Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_6), (Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_6)))
							else
								local var_12_7 = Mathf.Lerp(iter_12_4.color.r, 1, (arg_9_1.time_ - 0) / var_12_6)

								iter_12_4.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_8 = arg_9_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10022 = var_12_8.alpha
					arg_9_1.var_.characterEffect10022 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10022 = 0
			end

			local var_12_9 = 0.3

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				if arg_9_1.var_.characterEffect10022 then
					arg_9_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10022, 1, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10022 then
				arg_9_1.var_.characterEffect10022.alpha = 1
			end

			local var_12_10 = 0
			local var_12_11 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(413012002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 28 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 28)

				if (28 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 28)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012002", "story_v_out_413012.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012002", "story_v_out_413012.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_413012", "413012002", "story_v_out_413012.awb")

						arg_9_1:RecordAudio("413012002", var_12_17)
						arg_9_1:RecordAudio("413012002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413012", "413012002", "story_v_out_413012.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413012", "413012002", "story_v_out_413012.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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
	Play413012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413012003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10022"]) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = arg_13_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10022"]) then
				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10022"]) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_4 = arg_13_1:GetWordFromCfg(413012003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 7 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 7)

				if (7 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 7)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012003", "story_v_out_413012.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012003", "story_v_out_413012.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_413012", "413012003", "story_v_out_413012.awb")

						arg_13_1:RecordAudio("413012003", var_16_9)
						arg_13_1:RecordAudio("413012003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413012", "413012003", "story_v_out_413012.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413012", "413012003", "story_v_out_413012.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413012004
		arg_17_1.duration_ = 10.5

		local var_17_0 = {
			zh = 7.533,
			ja = 10.5
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
				arg_17_0:Play413012005(arg_17_1)
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

			local var_20_2 = 0
			local var_20_3 = 0.925

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
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

				local var_20_4 = arg_17_1:GetWordFromCfg(413012004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 37 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 37)

				if (37 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 37)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012004", "story_v_out_413012.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012004", "story_v_out_413012.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_413012", "413012004", "story_v_out_413012.awb")

						arg_17_1:RecordAudio("413012004", var_20_9)
						arg_17_1:RecordAudio("413012004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413012", "413012004", "story_v_out_413012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413012", "413012004", "story_v_out_413012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413012005
		arg_21_1.duration_ = 8.43

		local var_21_0 = {
			zh = 5.7,
			ja = 8.433
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
				arg_21_0:Play413012006(arg_21_1)
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

			local var_24_2 = 0
			local var_24_3 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(413012005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 35 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 35)

				if (35 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 35)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012005", "story_v_out_413012.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012005", "story_v_out_413012.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_413012", "413012005", "story_v_out_413012.awb")

						arg_21_1:RecordAudio("413012005", var_24_9)
						arg_21_1:RecordAudio("413012005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413012", "413012005", "story_v_out_413012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413012", "413012005", "story_v_out_413012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413012006
		arg_25_1.duration_ = 13.8

		local var_25_0 = {
			zh = 6.866,
			ja = 13.8
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
				arg_25_0:Play413012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = arg_25_1.actors_["10022"].transform.localPosition
				arg_25_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10022"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10022"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_2" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_2 = arg_25_1.actors_["10022"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(413012006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 40 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 40)

				if (40 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 40)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012006", "story_v_out_413012.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012006", "story_v_out_413012.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_413012", "413012006", "story_v_out_413012.awb")

						arg_25_1:RecordAudio("413012006", var_28_12)
						arg_25_1:RecordAudio("413012006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413012", "413012006", "story_v_out_413012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413012", "413012006", "story_v_out_413012.awb")
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

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413012007
		arg_29_1.duration_ = 10.93

		local var_29_0 = {
			zh = 5.233,
			ja = 10.933
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
				arg_29_0:Play413012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10022"]) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = arg_29_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10022"]) then
				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10022"]) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:GetWordFromCfg(413012007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 29 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 29)

				if (29 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 29)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012007", "story_v_out_413012.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012007", "story_v_out_413012.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_413012", "413012007", "story_v_out_413012.awb")

						arg_29_1:RecordAudio("413012007", var_32_9)
						arg_29_1:RecordAudio("413012007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413012", "413012007", "story_v_out_413012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413012", "413012007", "story_v_out_413012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413012008
		arg_33_1.duration_ = 1.57

		local var_33_0 = {
			zh = 1.566,
			ja = 1.166
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
				arg_33_0:Play413012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.225

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(413012008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)

				if (9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012008", "story_v_out_413012.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012008", "story_v_out_413012.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_413012", "413012008", "story_v_out_413012.awb")

						arg_33_1:RecordAudio("413012008", var_36_6)
						arg_33_1:RecordAudio("413012008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413012", "413012008", "story_v_out_413012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413012", "413012008", "story_v_out_413012.awb")
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
	Play413012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413012009
		arg_37_1.duration_ = 11.9

		local var_37_0 = {
			zh = 7.3,
			ja = 11.9
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
				arg_37_0:Play413012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = arg_37_1.actors_["10022"].transform.localPosition
				arg_37_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 0)

				for iter_40_0 = 0, arg_37_1.actors_["10022"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10022"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_40_2 = "10092"

			if arg_37_1.actors_["10092"] == nil then
				local var_40_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_40_3) then
					local var_40_4 = Object.Instantiate(var_40_3, arg_37_1.canvasGo_.transform)

					var_40_4.transform:SetSiblingIndex(1)

					var_40_4.name = var_40_2
					var_40_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_2] = var_40_4

					if arg_37_1.isInRecall_ then
						for iter_40_1, iter_40_2 in ipairs((var_40_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_2.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_5 = arg_37_1.actors_["10092"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092", 3)

				for iter_40_3 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_3)

					if var_40_6.name == "" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_40_8 = arg_37_1.actors_["10022"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_9), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_9), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_9)))
							else
								local var_40_10 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_9)

								iter_40_5.color = Color.New(var_40_10, var_40_10, var_40_10)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_11 = arg_37_1.actors_["10092"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.actorSpriteComps10092 == nil then
				arg_37_1.var_.actorSpriteComps10092 = var_40_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_12 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_12 and not isNil(var_40_11) then
				if arg_37_1.var_.actorSpriteComps10092 then
					for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_40_9 then
							if arg_37_1.isInRecall_ then
								iter_40_9.color = Color.New(Mathf.Lerp(iter_40_9.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_12), Mathf.Lerp(iter_40_9.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_12), (Mathf.Lerp(iter_40_9.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_12)))
							else
								local var_40_13 = Mathf.Lerp(iter_40_9.color.r, 1, (arg_37_1.time_ - 0) / var_40_12)

								iter_40_9.color = Color.New(var_40_13, var_40_13, var_40_13)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_12 and arg_37_1.time_ < 0 + var_40_12 + arg_40_0 and not isNil(var_40_11) and arg_37_1.var_.actorSpriteComps10092 then
				for iter_40_10, iter_40_11 in pairs(arg_37_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_40_11 then
						iter_40_11.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_14 = arg_37_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_14 then
					arg_37_1.var_.alphaOldValue10092 = var_40_14.alpha
					arg_37_1.var_.characterEffect10092 = var_40_14
				end

				arg_37_1.var_.alphaOldValue10092 = 0
			end

			local var_40_15 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_15 then
				if arg_37_1.var_.characterEffect10092 then
					arg_37_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue10092, 1, (arg_37_1.time_ - 0) / var_40_15)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_15 and arg_37_1.time_ < 0 + var_40_15 + arg_40_0 and arg_37_1.var_.characterEffect10092 then
				arg_37_1.var_.characterEffect10092.alpha = 1
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_16 = arg_37_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_16 then
					arg_37_1.var_.alphaOldValue10092 = var_40_16.alpha
					arg_37_1.var_.characterEffect10092 = var_40_16
				end

				arg_37_1.var_.alphaOldValue10092 = 0
			end

			local var_40_17 = 0.3

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_17 then
				if arg_37_1.var_.characterEffect10092 then
					arg_37_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue10092, 1, (arg_37_1.time_ - 0) / var_40_17)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_17 and arg_37_1.time_ < 0 + var_40_17 + arg_40_0 and arg_37_1.var_.characterEffect10092 then
				arg_37_1.var_.characterEffect10092.alpha = 1
			end

			local var_40_18 = 0
			local var_40_19 = 0.875

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
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

				local var_40_20 = arg_37_1:GetWordFromCfg(413012009)
				local var_40_21 = arg_37_1:FormatText(var_40_20.content)

				arg_37_1.text_.text = var_40_21

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_23 = 35 <= 0 and var_40_19 or var_40_19 * (utf8.len(var_40_21) / 35)

				if (35 <= 0 and var_40_19 or var_40_19 * (utf8.len(var_40_21) / 35)) > 0 and var_40_19 < var_40_23 then
					arg_37_1.talkMaxDuration = var_40_23

					if var_40_23 + var_40_18 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_18
					end
				end

				arg_37_1.text_.text = var_40_21
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012009", "story_v_out_413012.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012009", "story_v_out_413012.awb") / 1000

					if var_40_24 + var_40_18 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_18
					end

					if var_40_20.prefab_name ~= "" and arg_37_1.actors_[var_40_20.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_20.prefab_name].transform, "story_v_out_413012", "413012009", "story_v_out_413012.awb")

						arg_37_1:RecordAudio("413012009", var_40_25)
						arg_37_1:RecordAudio("413012009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413012", "413012009", "story_v_out_413012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413012", "413012009", "story_v_out_413012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_26 = math.max(var_40_19, arg_37_1.talkMaxDuration)

			if var_40_18 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_26 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_26

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_26 and arg_37_1.time_ < var_40_18 + var_40_26 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play413012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413012010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play413012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092 = arg_41_1.actors_["10092"].transform.localPosition
				arg_41_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092", 7)

				for iter_44_0 = 0, arg_41_1.actors_["10092"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10092"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_44_2 = arg_41_1.actors_["10092"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10092 == nil then
				arg_41_1.var_.actorSpriteComps10092 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10092 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10092 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10092 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 1.075

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(413012010).content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 43 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_7) / 43)

				if (43 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_7) / 43)) > 0 and var_44_6 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_10 and arg_41_1.time_ < var_44_5 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play413012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413012011
		arg_45_1.duration_ = 4.07

		local var_45_0 = {
			zh = 3.333,
			ja = 4.066
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
				arg_45_0:Play413012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10022 = arg_45_1.actors_["10022"].transform.localPosition
				arg_45_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10022", 2)

				for iter_48_0 = 0, arg_45_1.actors_["10022"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10022"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_6" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_48_2 = arg_45_1.actors_["10092"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092", 4)

				for iter_48_1 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_1)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(390, -300, -295)
			end

			local var_48_5 = arg_45_1.actors_["10022"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_6 and not isNil(var_48_5) then
				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								iter_48_3.color = Color.New(Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_6), Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_6), (Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_6)))
							else
								local var_48_7 = Mathf.Lerp(iter_48_3.color.r, 1, (arg_45_1.time_ - 0) / var_48_6)

								iter_48_3.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_6 and arg_45_1.time_ < 0 + var_48_6 + arg_48_0 and not isNil(var_48_5) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_5 then
						iter_48_5.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_8 = arg_45_1.actors_["10092"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10092 == nil then
				arg_45_1.var_.actorSpriteComps10092 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_9 and not isNil(var_48_8) then
				if arg_45_1.var_.actorSpriteComps10092 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_9 and arg_45_1.time_ < 0 + var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10092 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_48_9 then
						iter_48_9.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_11 = arg_45_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_11 then
					arg_45_1.var_.alphaOldValue10022 = var_48_11.alpha
					arg_45_1.var_.characterEffect10022 = var_48_11
				end

				arg_45_1.var_.alphaOldValue10022 = 0
			end

			local var_48_12 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_12 then
				if arg_45_1.var_.characterEffect10022 then
					arg_45_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_45_1.var_.alphaOldValue10022, 1, (arg_45_1.time_ - 0) / var_48_12)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_12 and arg_45_1.time_ < 0 + var_48_12 + arg_48_0 and arg_45_1.var_.characterEffect10022 then
				arg_45_1.var_.characterEffect10022.alpha = 1
			end

			local var_48_13 = 0
			local var_48_14 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
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

				local var_48_15 = arg_45_1:GetWordFromCfg(413012011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_18 = 19 <= 0 and var_48_14 or var_48_14 * (utf8.len(var_48_16) / 19)

				if (19 <= 0 and var_48_14 or var_48_14 * (utf8.len(var_48_16) / 19)) > 0 and var_48_14 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18

					if var_48_18 + var_48_13 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_13
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012011", "story_v_out_413012.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_413012", "413012011", "story_v_out_413012.awb") / 1000

					if var_48_19 + var_48_13 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_13
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_413012", "413012011", "story_v_out_413012.awb")

						arg_45_1:RecordAudio("413012011", var_48_20)
						arg_45_1:RecordAudio("413012011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413012", "413012011", "story_v_out_413012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413012", "413012011", "story_v_out_413012.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = math.max(var_48_14, arg_45_1.talkMaxDuration)

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_21 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_13) / var_48_21

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_13 + var_48_21 and arg_45_1.time_ < var_48_13 + var_48_21 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play413012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413012012
		arg_49_1.duration_ = 8.47

		local var_49_0 = {
			zh = 6.666,
			ja = 8.466
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
				arg_49_0:Play413012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 == nil then
				arg_49_1.var_.actorSpriteComps10092 = arg_49_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10092"]) then
				if arg_49_1.var_.actorSpriteComps10092 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10092"]) and arg_49_1.var_.actorSpriteComps10092 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10092 = nil
			end

			local var_52_2 = arg_49_1.actors_["10022"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(413012012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 31 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 31)

				if (31 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 31)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012012", "story_v_out_413012.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012012", "story_v_out_413012.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_413012", "413012012", "story_v_out_413012.awb")

						arg_49_1:RecordAudio("413012012", var_52_12)
						arg_49_1:RecordAudio("413012012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413012", "413012012", "story_v_out_413012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413012", "413012012", "story_v_out_413012.awb")
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
	Play413012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413012013
		arg_53_1.duration_ = 3

		local var_53_0 = {
			zh = 2.466,
			ja = 3
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
				arg_53_0:Play413012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10092"]) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = arg_53_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10092"]) then
				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10092"]) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
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
								iter_56_5.color = Color.New(Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_5.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_5.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_7 then
						iter_56_7.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(413012013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 11 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 11)

				if (11 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 11)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012013", "story_v_out_413012.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012013", "story_v_out_413012.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_413012", "413012013", "story_v_out_413012.awb")

						arg_53_1:RecordAudio("413012013", var_56_12)
						arg_53_1:RecordAudio("413012013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413012", "413012013", "story_v_out_413012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413012", "413012013", "story_v_out_413012.awb")
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
	Play413012014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413012014
		arg_57_1.duration_ = 11.5

		local var_57_0 = {
			zh = 5.433,
			ja = 11.5
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
				arg_57_0:Play413012015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 == nil then
				arg_57_1.var_.actorSpriteComps10092 = arg_57_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10092"]) then
				if arg_57_1.var_.actorSpriteComps10092 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10092"]) and arg_57_1.var_.actorSpriteComps10092 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10092 = nil
			end

			local var_60_2 = arg_57_1.actors_["10022"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								iter_60_5.color = Color.New(Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_5.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_5.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.7

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

				local var_60_7 = arg_57_1:GetWordFromCfg(413012014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 28 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 28)

				if (28 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 28)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012014", "story_v_out_413012.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012014", "story_v_out_413012.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_413012", "413012014", "story_v_out_413012.awb")

						arg_57_1:RecordAudio("413012014", var_60_12)
						arg_57_1:RecordAudio("413012014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413012", "413012014", "story_v_out_413012.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413012", "413012014", "story_v_out_413012.awb")
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413012015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413012015
		arg_61_1.duration_ = 10.8

		local var_61_0 = {
			zh = 6.966,
			ja = 10.8
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
				arg_61_0:Play413012016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10092"]) and arg_61_1.var_.actorSpriteComps10092 == nil then
				arg_61_1.var_.actorSpriteComps10092 = arg_61_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10092"]) then
				if arg_61_1.var_.actorSpriteComps10092 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10092"]) and arg_61_1.var_.actorSpriteComps10092 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10092 = nil
			end

			local var_64_2 = arg_61_1.actors_["10022"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10022 == nil then
				arg_61_1.var_.actorSpriteComps10022 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10022 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10022 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10022 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.975

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

				local var_64_7 = arg_61_1:GetWordFromCfg(413012015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 39 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 39)

				if (39 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 39)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012015", "story_v_out_413012.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012015", "story_v_out_413012.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_413012", "413012015", "story_v_out_413012.awb")

						arg_61_1:RecordAudio("413012015", var_64_12)
						arg_61_1:RecordAudio("413012015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413012", "413012015", "story_v_out_413012.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413012", "413012015", "story_v_out_413012.awb")
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
	Play413012016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413012016
		arg_65_1.duration_ = 7.8

		local var_65_0 = {
			zh = 3.2,
			ja = 7.8
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
				arg_65_0:Play413012017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10092"]) and arg_65_1.var_.actorSpriteComps10092 == nil then
				arg_65_1.var_.actorSpriteComps10092 = arg_65_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10092"]) then
				if arg_65_1.var_.actorSpriteComps10092 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10092"]) and arg_65_1.var_.actorSpriteComps10092 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10092 = nil
			end

			local var_68_2 = arg_65_1.actors_["10022"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10022 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(413012016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 16 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 16)

				if (16 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 16)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012016", "story_v_out_413012.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012016", "story_v_out_413012.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_413012", "413012016", "story_v_out_413012.awb")

						arg_65_1:RecordAudio("413012016", var_68_12)
						arg_65_1:RecordAudio("413012016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413012", "413012016", "story_v_out_413012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413012", "413012016", "story_v_out_413012.awb")
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
	Play413012017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413012017
		arg_69_1.duration_ = 8.47

		local var_69_0 = {
			zh = 5.633,
			ja = 8.466
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
				arg_69_0:Play413012018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.6

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
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

				local var_72_1 = arg_69_1:GetWordFromCfg(413012017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 24 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 24)

				if (24 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 24)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012017", "story_v_out_413012.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012017", "story_v_out_413012.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_413012", "413012017", "story_v_out_413012.awb")

						arg_69_1:RecordAudio("413012017", var_72_6)
						arg_69_1:RecordAudio("413012017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413012", "413012017", "story_v_out_413012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413012", "413012017", "story_v_out_413012.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play413012018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413012018
		arg_73_1.duration_ = 2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play413012019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10022 = arg_73_1.actors_["10022"].transform.localPosition
				arg_73_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10022", 2)

				for iter_76_0 = 0, arg_73_1.actors_["10022"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10022"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_6" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_76_2 = arg_73_1.actors_["10092"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10092 == nil then
				arg_73_1.var_.actorSpriteComps10092 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10092 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10092 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10092 = nil
			end

			local var_76_5 = arg_73_1.actors_["10022"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_8 then
						iter_76_8.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(413012018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 7 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 7)

				if (7 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 7)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012018", "story_v_out_413012.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012018", "story_v_out_413012.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_413012", "413012018", "story_v_out_413012.awb")

						arg_73_1:RecordAudio("413012018", var_76_15)
						arg_73_1:RecordAudio("413012018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413012", "413012018", "story_v_out_413012.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413012", "413012018", "story_v_out_413012.awb")
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
				actorName = "10022",
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
	Play413012019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413012019
		arg_77_1.duration_ = 7.2

		local var_77_0 = {
			zh = 4.266,
			ja = 7.2
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
				arg_77_0:Play413012020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10092"]) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = arg_77_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10092"]) then
				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10092"]) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_2 = arg_77_1.actors_["10022"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.45

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413012019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 18 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 18)

				if (18 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 18)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012019", "story_v_out_413012.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012019", "story_v_out_413012.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413012", "413012019", "story_v_out_413012.awb")

						arg_77_1:RecordAudio("413012019", var_80_12)
						arg_77_1:RecordAudio("413012019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413012", "413012019", "story_v_out_413012.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413012", "413012019", "story_v_out_413012.awb")
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
	Play413012020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413012020
		arg_81_1.duration_ = 7

		local var_81_0 = {
			zh = 4.9,
			ja = 7
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
				arg_81_0:Play413012021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
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

				local var_84_1 = arg_81_1:GetWordFromCfg(413012020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 24 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 24)

				if (24 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 24)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012020", "story_v_out_413012.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012020", "story_v_out_413012.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_413012", "413012020", "story_v_out_413012.awb")

						arg_81_1:RecordAudio("413012020", var_84_6)
						arg_81_1:RecordAudio("413012020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413012", "413012020", "story_v_out_413012.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413012", "413012020", "story_v_out_413012.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413012021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413012021
		arg_85_1.duration_ = 5.3

		local var_85_0 = {
			zh = 5.3,
			ja = 5
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
				arg_85_0:Play413012022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10092"]) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = arg_85_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10092"]) then
				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10092"]) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			local var_88_2 = arg_85_1.actors_["10022"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(413012021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 25 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 25)

				if (25 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 25)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012021", "story_v_out_413012.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012021", "story_v_out_413012.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_413012", "413012021", "story_v_out_413012.awb")

						arg_85_1:RecordAudio("413012021", var_88_12)
						arg_85_1:RecordAudio("413012021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413012", "413012021", "story_v_out_413012.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413012", "413012021", "story_v_out_413012.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413012022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413012022
		arg_89_1.duration_ = 9.53

		local var_89_0 = {
			zh = 8.6,
			ja = 9.533
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
				arg_89_0:Play413012023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.025

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413012022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 41 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 41)

				if (41 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 41)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012022", "story_v_out_413012.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012022", "story_v_out_413012.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413012", "413012022", "story_v_out_413012.awb")

						arg_89_1:RecordAudio("413012022", var_92_6)
						arg_89_1:RecordAudio("413012022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413012", "413012022", "story_v_out_413012.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413012", "413012022", "story_v_out_413012.awb")
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
	Play413012023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413012023
		arg_93_1.duration_ = 5.83

		local var_93_0 = {
			zh = 2.7,
			ja = 5.833
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
				arg_93_0:Play413012024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = arg_93_1.actors_["10092"].transform.localPosition
				arg_93_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 4)

				for iter_96_0 = 0, arg_93_1.actors_["10092"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10092"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_5" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_96_2 = arg_93_1.actors_["10092"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_5 = arg_93_1.actors_["10022"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_5, iter_96_6 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_6 then
							if arg_93_1.isInRecall_ then
								iter_96_6.color = Color.New(Mathf.Lerp(iter_96_6.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_6.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_6.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_6.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_6.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_7, iter_96_8 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_8 then
						iter_96_8.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(413012023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 14 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 14)

				if (14 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 14)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012023", "story_v_out_413012.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012023", "story_v_out_413012.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_413012", "413012023", "story_v_out_413012.awb")

						arg_93_1:RecordAudio("413012023", var_96_15)
						arg_93_1:RecordAudio("413012023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413012", "413012023", "story_v_out_413012.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413012", "413012023", "story_v_out_413012.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
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
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play413012024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413012024
		arg_97_1.duration_ = 6.8

		local var_97_0 = {
			zh = 6.1,
			ja = 6.8
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
				arg_97_0:Play413012025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10092"]) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = arg_97_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10092"]) then
				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10092"]) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_2 = arg_97_1.actors_["10022"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10022 == nil then
				arg_97_1.var_.actorSpriteComps10022 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10022 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10022 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10022 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(413012024)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 30 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 30)

				if (30 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 30)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012024", "story_v_out_413012.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012024", "story_v_out_413012.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_413012", "413012024", "story_v_out_413012.awb")

						arg_97_1:RecordAudio("413012024", var_100_12)
						arg_97_1:RecordAudio("413012024", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413012", "413012024", "story_v_out_413012.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413012", "413012024", "story_v_out_413012.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413012025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413012025
		arg_101_1.duration_ = 5.83

		local var_101_0 = {
			zh = 3.4,
			ja = 5.833
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
				arg_101_0:Play413012026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10092 = arg_101_1.actors_["10092"].transform.localPosition
				arg_101_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10092", 4)

				for iter_104_0 = 0, arg_101_1.actors_["10092"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10092"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_104_2 = arg_101_1.actors_["10092"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10092 == nil then
				arg_101_1.var_.actorSpriteComps10092 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10092 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10092 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10092 = nil
			end

			local var_104_5 = arg_101_1.actors_["10022"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10022 == nil then
				arg_101_1.var_.actorSpriteComps10022 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps10022 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								iter_104_6.color = Color.New(Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_6.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_6.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10022 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_104_8 then
						iter_104_8.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10022 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
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

				local var_104_10 = arg_101_1:GetWordFromCfg(413012025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 15 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 15)

				if (15 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 15)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012025", "story_v_out_413012.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012025", "story_v_out_413012.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_413012", "413012025", "story_v_out_413012.awb")

						arg_101_1:RecordAudio("413012025", var_104_15)
						arg_101_1:RecordAudio("413012025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413012", "413012025", "story_v_out_413012.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413012", "413012025", "story_v_out_413012.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413012026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413012026
		arg_105_1.duration_ = 15.1

		local var_105_0 = {
			zh = 5.9,
			ja = 15.1
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
				arg_105_0:Play413012027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.925

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(413012026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 37)

				if (37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 37)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012026", "story_v_out_413012.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012026", "story_v_out_413012.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_413012", "413012026", "story_v_out_413012.awb")

						arg_105_1:RecordAudio("413012026", var_108_6)
						arg_105_1:RecordAudio("413012026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413012", "413012026", "story_v_out_413012.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413012", "413012026", "story_v_out_413012.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play413012027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413012027
		arg_109_1.duration_ = 7.37

		local var_109_0 = {
			zh = 7.366,
			ja = 5.633
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
				arg_109_0:Play413012028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = arg_109_1.actors_["10022"].transform.localPosition
				arg_109_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 2)

				for iter_112_0 = 0, arg_109_1.actors_["10022"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10022"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_6" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_112_2 = arg_109_1.actors_["10092"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10092 == nil then
				arg_109_1.var_.actorSpriteComps10092 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps10092 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								iter_112_2.color = Color.New(Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_2.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_2.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps10092 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_112_4 then
						iter_112_4.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10092 = nil
			end

			local var_112_5 = arg_109_1.actors_["10022"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10022 == nil then
				arg_109_1.var_.actorSpriteComps10022 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps10022 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								iter_112_6.color = Color.New(Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_6.color.r, 1, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_6.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps10022 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_112_8 then
						iter_112_8.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10022 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.875

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(413012027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 35 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 35)

				if (35 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 35)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012027", "story_v_out_413012.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012027", "story_v_out_413012.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_413012", "413012027", "story_v_out_413012.awb")

						arg_109_1:RecordAudio("413012027", var_112_15)
						arg_109_1:RecordAudio("413012027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413012", "413012027", "story_v_out_413012.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413012", "413012027", "story_v_out_413012.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
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
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413012028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413012028
		arg_113_1.duration_ = 8.53

		local var_113_0 = {
			zh = 8.533,
			ja = 6.066
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
				arg_113_0:Play413012029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.8

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(413012028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 32 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 32)

				if (32 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 32)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012028", "story_v_out_413012.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012028", "story_v_out_413012.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_413012", "413012028", "story_v_out_413012.awb")

						arg_113_1:RecordAudio("413012028", var_116_6)
						arg_113_1:RecordAudio("413012028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413012", "413012028", "story_v_out_413012.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413012", "413012028", "story_v_out_413012.awb")
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
	Play413012029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413012029
		arg_117_1.duration_ = 6.47

		local var_117_0 = {
			zh = 4.5,
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
				arg_117_0:Play413012030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10092 = arg_117_1.actors_["10092"].transform.localPosition
				arg_117_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10092", 4)

				for iter_120_0 = 0, arg_117_1.actors_["10092"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10092"].transform:GetChild(iter_120_0)

					if var_120_0.name == "split_5" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_120_2 = arg_117_1.actors_["10092"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10092 == nil then
				arg_117_1.var_.actorSpriteComps10092 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10092 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10092 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10092 = nil
			end

			local var_120_5 = arg_117_1.actors_["10022"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								iter_120_6.color = Color.New(Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_6.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_6.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_8 then
						iter_120_8.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			local var_120_8 = 0
			local var_120_9 = 0.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(413012029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 16 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 16)

				if (16 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 16)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012029", "story_v_out_413012.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012029", "story_v_out_413012.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_413012", "413012029", "story_v_out_413012.awb")

						arg_117_1:RecordAudio("413012029", var_120_15)
						arg_117_1:RecordAudio("413012029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413012", "413012029", "story_v_out_413012.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413012", "413012029", "story_v_out_413012.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413012030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413012030
		arg_121_1.duration_ = 4.7

		local var_121_0 = {
			zh = 4.166,
			ja = 4.7
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
				arg_121_0:Play413012031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092 = arg_121_1.actors_["10092"].transform.localPosition
				arg_121_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092", 0)

				for iter_124_0 = 0, arg_121_1.actors_["10092"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10092"].transform:GetChild(iter_124_0)

					if var_124_0.name == "" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10092"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_124_2 = arg_121_1.actors_["10022"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10022 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10022", 0)

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
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_124_5 = "10093"

			if arg_121_1.actors_["10093"] == nil then
				local var_124_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_124_6) then
					local var_124_7 = Object.Instantiate(var_124_6, arg_121_1.canvasGo_.transform)

					var_124_7.transform:SetSiblingIndex(1)

					var_124_7.name = var_124_5
					var_124_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_121_1.actors_[var_124_5] = var_124_7

					if arg_121_1.isInRecall_ then
						for iter_124_2, iter_124_3 in ipairs((var_124_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_124_8 = arg_121_1.actors_["10093"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10093 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10093", 3)

				for iter_124_4 = 0, var_124_8.childCount - 1 do
					local var_124_9 = var_124_8:GetChild(iter_124_4)

					if var_124_9.name == "split_3" or not string.find(var_124_9.name, "split") then
						var_124_9.gameObject:SetActive(true)
					else
						var_124_9.gameObject:SetActive(false)
					end
				end
			end

			local var_124_10 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_10 then
				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_121_1.time_ - 0) / var_124_10)
			end

			if arg_121_1.time_ >= 0 + var_124_10 and arg_121_1.time_ < 0 + var_124_10 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, -345, -245)
			end

			local var_124_11 = arg_121_1.actors_["10092"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.actorSpriteComps10092 == nil then
				arg_121_1.var_.actorSpriteComps10092 = var_124_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_12 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_12 and not isNil(var_124_11) then
				if arg_121_1.var_.actorSpriteComps10092 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								iter_124_6.color = Color.New(Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_12), Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_12), (Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_12)))
							else
								local var_124_13 = Mathf.Lerp(iter_124_6.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_12)

								iter_124_6.color = Color.New(var_124_13, var_124_13, var_124_13)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_12 and arg_121_1.time_ < 0 + var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.actorSpriteComps10092 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_124_8 then
						iter_124_8.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10092 = nil
			end

			local var_124_14 = arg_121_1.actors_["10022"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.actorSpriteComps10022 == nil then
				arg_121_1.var_.actorSpriteComps10022 = var_124_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_15 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_15 and not isNil(var_124_14) then
				if arg_121_1.var_.actorSpriteComps10022 then
					for iter_124_9, iter_124_10 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_124_10 then
							if arg_121_1.isInRecall_ then
								iter_124_10.color = Color.New(Mathf.Lerp(iter_124_10.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_15), Mathf.Lerp(iter_124_10.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_15), (Mathf.Lerp(iter_124_10.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_15)))
							else
								local var_124_16 = Mathf.Lerp(iter_124_10.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_15)

								iter_124_10.color = Color.New(var_124_16, var_124_16, var_124_16)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_15 and arg_121_1.time_ < 0 + var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.actorSpriteComps10022 then
				for iter_124_11, iter_124_12 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_124_12 then
						iter_124_12.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10022 = nil
			end

			local var_124_17 = arg_121_1.actors_["10093"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_17) and arg_121_1.var_.actorSpriteComps10093 == nil then
				arg_121_1.var_.actorSpriteComps10093 = var_124_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_18 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_18 and not isNil(var_124_17) then
				if arg_121_1.var_.actorSpriteComps10093 then
					for iter_124_13, iter_124_14 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_124_14 then
							if arg_121_1.isInRecall_ then
								iter_124_14.color = Color.New(Mathf.Lerp(iter_124_14.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_18), Mathf.Lerp(iter_124_14.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_18), (Mathf.Lerp(iter_124_14.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_18)))
							else
								local var_124_19 = Mathf.Lerp(iter_124_14.color.r, 1, (arg_121_1.time_ - 0) / var_124_18)

								iter_124_14.color = Color.New(var_124_19, var_124_19, var_124_19)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_18 and arg_121_1.time_ < 0 + var_124_18 + arg_124_0 and not isNil(var_124_17) and arg_121_1.var_.actorSpriteComps10093 then
				for iter_124_15, iter_124_16 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_124_16 then
						iter_124_16.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				local var_124_20 = arg_121_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_20 then
					arg_121_1.var_.alphaOldValue10093 = var_124_20.alpha
					arg_121_1.var_.characterEffect10093 = var_124_20
				end

				arg_121_1.var_.alphaOldValue10093 = 0
			end

			local var_124_21 = 0.3

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_21 then
				if arg_121_1.var_.characterEffect10093 then
					arg_121_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_121_1.var_.alphaOldValue10093, 1, (arg_121_1.time_ - 0) / var_124_21)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_21 and arg_121_1.time_ < 0 + var_124_21 + arg_124_0 and arg_121_1.var_.characterEffect10093 then
				arg_121_1.var_.characterEffect10093.alpha = 1
			end

			local var_124_22 = 0
			local var_124_23 = 0.525

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_22 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(413012030)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_27 = 21 <= 0 and var_124_23 or var_124_23 * (utf8.len(var_124_25) / 21)

				if (21 <= 0 and var_124_23 or var_124_23 * (utf8.len(var_124_25) / 21)) > 0 and var_124_23 < var_124_27 then
					arg_121_1.talkMaxDuration = var_124_27

					if var_124_27 + var_124_22 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_27 + var_124_22
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012030", "story_v_out_413012.awb") ~= 0 then
					local var_124_28 = manager.audio:GetVoiceLength("story_v_out_413012", "413012030", "story_v_out_413012.awb") / 1000

					if var_124_28 + var_124_22 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_22
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_413012", "413012030", "story_v_out_413012.awb")

						arg_121_1:RecordAudio("413012030", var_124_29)
						arg_121_1:RecordAudio("413012030", var_124_29)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413012", "413012030", "story_v_out_413012.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413012", "413012030", "story_v_out_413012.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_30 = math.max(var_124_23, arg_121_1.talkMaxDuration)

			if var_124_22 <= arg_121_1.time_ and arg_121_1.time_ < var_124_22 + var_124_30 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_22) / var_124_30

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_22 + var_124_30 and arg_121_1.time_ < var_124_22 + var_124_30 + arg_124_0 then
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

		arg_121_1:InitPlayNodeList()
	end,
	Play413012031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413012031
		arg_125_1.duration_ = 3.63

		local var_125_0 = {
			zh = 2.4,
			ja = 3.633
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413012032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10092 = arg_125_1.actors_["10092"].transform.localPosition
				arg_125_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10092", 3)

				for iter_128_0 = 0, arg_125_1.actors_["10092"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["10092"].transform:GetChild(iter_128_0)

					if var_128_0.name == "" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_128_2 = arg_125_1.actors_["10093"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10093 = var_128_2.localPosition
				var_128_2.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10093", 0)

				for iter_128_1 = 0, var_128_2.childCount - 1 do
					local var_128_3 = var_128_2:GetChild(iter_128_1)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10093, Vector3.New(0, -5000, 0), (arg_125_1.time_ - 0) / var_128_4)
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_128_5 = arg_125_1.actors_["10092"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10092 == nil then
				arg_125_1.var_.actorSpriteComps10092 = var_128_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_6 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.actorSpriteComps10092 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								iter_128_3.color = Color.New(Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_6), Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_6), (Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_6)))
							else
								local var_128_7 = Mathf.Lerp(iter_128_3.color.r, 1, (arg_125_1.time_ - 0) / var_128_6)

								iter_128_3.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10092 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_128_5 then
						iter_128_5.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps10092 = nil
			end

			local var_128_8 = arg_125_1.actors_["10093"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10093 == nil then
				arg_125_1.var_.actorSpriteComps10093 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.actorSpriteComps10093 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								iter_128_7.color = Color.New(Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_9), Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_9), (Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_9)))
							else
								local var_128_10 = Mathf.Lerp(iter_128_7.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_9)

								iter_128_7.color = Color.New(var_128_10, var_128_10, var_128_10)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10093 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_128_9 then
						iter_128_9.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10093 = nil
			end

			local var_128_11 = 0
			local var_128_12 = 0.3

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:GetWordFromCfg(413012031)
				local var_128_14 = arg_125_1:FormatText(var_128_13.content)

				arg_125_1.text_.text = var_128_14

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 12 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 12)

				if (12 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 12)) > 0 and var_128_12 < var_128_16 then
					arg_125_1.talkMaxDuration = var_128_16

					if var_128_16 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_14
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012031", "story_v_out_413012.awb") ~= 0 then
					local var_128_17 = manager.audio:GetVoiceLength("story_v_out_413012", "413012031", "story_v_out_413012.awb") / 1000

					if var_128_17 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_11
					end

					if var_128_13.prefab_name ~= "" and arg_125_1.actors_[var_128_13.prefab_name] ~= nil then
						local var_128_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_13.prefab_name].transform, "story_v_out_413012", "413012031", "story_v_out_413012.awb")

						arg_125_1:RecordAudio("413012031", var_128_18)
						arg_125_1:RecordAudio("413012031", var_128_18)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413012", "413012031", "story_v_out_413012.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413012", "413012031", "story_v_out_413012.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_19 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_19 and arg_125_1.time_ < var_128_11 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play413012032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413012032
		arg_129_1.duration_ = 6.53

		local var_129_0 = {
			zh = 3.9,
			ja = 6.533
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
				arg_129_0:Play413012033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10093 = arg_129_1.actors_["10093"].transform.localPosition
				arg_129_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10093", 3)

				for iter_132_0 = 0, arg_129_1.actors_["10093"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10093"].transform:GetChild(iter_132_0)

					if var_132_0.name == "" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_132_2 = arg_129_1.actors_["10092"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10092 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10092", 0)

				for iter_132_1 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_1)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10092, Vector3.New(-5000, -345, -245), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_132_5 = arg_129_1.actors_["10093"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10093 == nil then
				arg_129_1.var_.actorSpriteComps10093 = var_132_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.actorSpriteComps10093 then
					for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_132_3 then
							if arg_129_1.isInRecall_ then
								iter_132_3.color = Color.New(Mathf.Lerp(iter_132_3.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_6), Mathf.Lerp(iter_132_3.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_6), (Mathf.Lerp(iter_132_3.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_6)))
							else
								local var_132_7 = Mathf.Lerp(iter_132_3.color.r, 1, (arg_129_1.time_ - 0) / var_132_6)

								iter_132_3.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10093 then
				for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_132_5 then
						iter_132_5.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10093 = nil
			end

			local var_132_8 = arg_129_1.actors_["10092"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10092 == nil then
				arg_129_1.var_.actorSpriteComps10092 = var_132_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_9 and not isNil(var_132_8) then
				if arg_129_1.var_.actorSpriteComps10092 then
					for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_132_7 then
							if arg_129_1.isInRecall_ then
								iter_132_7.color = Color.New(Mathf.Lerp(iter_132_7.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_9), Mathf.Lerp(iter_132_7.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_9), (Mathf.Lerp(iter_132_7.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_9)))
							else
								local var_132_10 = Mathf.Lerp(iter_132_7.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_9)

								iter_132_7.color = Color.New(var_132_10, var_132_10, var_132_10)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_9 and arg_129_1.time_ < 0 + var_132_9 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10092 then
				for iter_132_8, iter_132_9 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_132_9 then
						iter_132_9.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps10092 = nil
			end

			local var_132_11 = 0
			local var_132_12 = 0.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_13 = arg_129_1:GetWordFromCfg(413012032)
				local var_132_14 = arg_129_1:FormatText(var_132_13.content)

				arg_129_1.text_.text = var_132_14

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 16 <= 0 and var_132_12 or var_132_12 * (utf8.len(var_132_14) / 16)

				if (16 <= 0 and var_132_12 or var_132_12 * (utf8.len(var_132_14) / 16)) > 0 and var_132_12 < var_132_16 then
					arg_129_1.talkMaxDuration = var_132_16

					if var_132_16 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_14
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012032", "story_v_out_413012.awb") ~= 0 then
					local var_132_17 = manager.audio:GetVoiceLength("story_v_out_413012", "413012032", "story_v_out_413012.awb") / 1000

					if var_132_17 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_11
					end

					if var_132_13.prefab_name ~= "" and arg_129_1.actors_[var_132_13.prefab_name] ~= nil then
						local var_132_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_13.prefab_name].transform, "story_v_out_413012", "413012032", "story_v_out_413012.awb")

						arg_129_1:RecordAudio("413012032", var_132_18)
						arg_129_1:RecordAudio("413012032", var_132_18)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413012", "413012032", "story_v_out_413012.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413012", "413012032", "story_v_out_413012.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_19 and arg_129_1.time_ < var_132_11 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play413012033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413012033
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413012034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.bgs_.F10g == nil then
				local var_136_0 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_136_0.name = "F10g"
				var_136_0.transform.parent = arg_133_1.stage_.transform
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_.F10g = var_136_0
			end

			if 1.98333333333333 < arg_133_1.time_ and arg_133_1.time_ <= 1.98333333333333 + arg_136_0 then
				local var_136_1 = arg_133_1.bgs_.F10g

				arg_133_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_2 = var_136_1:GetComponent("SpriteRenderer")

				if var_136_2 and var_136_2.sprite then
					local var_136_3 = 2 * (var_136_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_1.transform.localScale = Vector3.New(var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "F10g" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_4 = 4

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_4 + 0.3 and arg_133_1.time_ < var_136_4 + 0.3 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_5 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_6 = 2

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 then
				local var_136_7 = Color.New(0, 0, 0)

				var_136_7.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_5) / var_136_6)
				arg_133_1.mask_.color = var_136_7
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 then
				local var_136_8 = Color.New(0, 0, 0)

				var_136_8.a = 1
				arg_133_1.mask_.color = var_136_8
			end

			local var_136_9 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_10 = 2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 then
				local var_136_11 = Color.New(0, 0, 0)

				var_136_11.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_9) / var_136_10)
				arg_133_1.mask_.color = var_136_11
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 then
				local var_136_12 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_12.a = 0
				arg_133_1.mask_.color = var_136_12
			end

			local var_136_13 = arg_133_1.actors_["10093"].transform

			if 1.966 < arg_133_1.time_ and arg_133_1.time_ <= 1.966 + arg_136_0 then
				arg_133_1.var_.moveOldPos10093 = var_136_13.localPosition
				var_136_13.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10093", 7)

				for iter_136_2 = 0, var_136_13.childCount - 1 do
					local var_136_14 = var_136_13:GetChild(iter_136_2)

					if var_136_14.name == "" or not string.find(var_136_14.name, "split") then
						var_136_14.gameObject:SetActive(true)
					else
						var_136_14.gameObject:SetActive(false)
					end
				end
			end

			local var_136_15 = 0.001

			if 1.966 <= arg_133_1.time_ and arg_133_1.time_ < 1.966 + var_136_15 then
				var_136_13.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_133_1.time_ - 1.966) / var_136_15)
			end

			if arg_133_1.time_ >= 1.966 + var_136_15 and arg_133_1.time_ < 1.966 + var_136_15 + arg_136_0 then
				var_136_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_136_16 = arg_133_1.bgs_.F10g.transform

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= 2 + arg_136_0 then
				arg_133_1.var_.moveOldPosF10g = var_136_16.localPosition
			end

			local var_136_17 = 2

			if 2 <= arg_133_1.time_ and arg_133_1.time_ < 2 + var_136_17 then
				var_136_16.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosF10g, Vector3.New(0, 1, 9.5), (arg_133_1.time_ - 2) / var_136_17)
			end

			if arg_133_1.time_ >= 2 + var_136_17 and arg_133_1.time_ < 2 + var_136_17 + arg_136_0 then
				var_136_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_18 = 4
			local var_136_19 = 1

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_20 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_20:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_21 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(413012033).content)

				arg_133_1.text_.text = var_136_21

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_23 = 40 <= 0 and var_136_19 or var_136_19 * (utf8.len(var_136_21) / 40)

				if (40 <= 0 and var_136_19 or var_136_19 * (utf8.len(var_136_21) / 40)) > 0 and var_136_19 < var_136_23 then
					arg_133_1.talkMaxDuration = var_136_23
					var_136_18 = var_136_18 + 0.3

					if var_136_23 + var_136_18 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_18
					end
				end

				arg_133_1.text_.text = var_136_21
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_24 = var_136_18 + 0.3
			local var_136_25 = math.max(var_136_19, arg_133_1.talkMaxDuration)

			if var_136_18 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_24 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_24) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_24 + var_136_25 and arg_133_1.time_ < var_136_24 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "F10g",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play413012034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413012034
		arg_139_1.duration_ = 7.33

		local var_139_0 = {
			zh = 7.066,
			ja = 7.333
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
				arg_139_0:Play413012035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10022 = arg_139_1.actors_["10022"].transform.localPosition
				arg_139_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10022", 2)

				for iter_142_0 = 0, arg_139_1.actors_["10022"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10022"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_8" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_142_2 = arg_139_1.actors_["10022"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_5 = arg_139_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_5 then
					arg_139_1.var_.alphaOldValue10022 = var_142_5.alpha
					arg_139_1.var_.characterEffect10022 = var_142_5
				end

				arg_139_1.var_.alphaOldValue10022 = 0
			end

			local var_142_6 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 then
				if arg_139_1.var_.characterEffect10022 then
					arg_139_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_139_1.var_.alphaOldValue10022, 1, (arg_139_1.time_ - 0) / var_142_6)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and arg_139_1.var_.characterEffect10022 then
				arg_139_1.var_.characterEffect10022.alpha = 1
			end

			local var_142_7 = 0
			local var_142_8 = 0.75

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_9 = arg_139_1:GetWordFromCfg(413012034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 30 <= 0 and var_142_8 or var_142_8 * (utf8.len(var_142_10) / 30)

				if (30 <= 0 and var_142_8 or var_142_8 * (utf8.len(var_142_10) / 30)) > 0 and var_142_8 < var_142_12 then
					arg_139_1.talkMaxDuration = var_142_12

					if var_142_12 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_7
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012034", "story_v_out_413012.awb") ~= 0 then
					local var_142_13 = manager.audio:GetVoiceLength("story_v_out_413012", "413012034", "story_v_out_413012.awb") / 1000

					if var_142_13 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_7
					end

					if var_142_9.prefab_name ~= "" and arg_139_1.actors_[var_142_9.prefab_name] ~= nil then
						local var_142_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_9.prefab_name].transform, "story_v_out_413012", "413012034", "story_v_out_413012.awb")

						arg_139_1:RecordAudio("413012034", var_142_14)
						arg_139_1:RecordAudio("413012034", var_142_14)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413012", "413012034", "story_v_out_413012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413012", "413012034", "story_v_out_413012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_8, arg_139_1.talkMaxDuration)

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_7) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_7 + var_142_15 and arg_139_1.time_ < var_142_7 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
	Play413012035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413012035
		arg_143_1.duration_ = 10

		local var_143_0 = {
			zh = 7.933,
			ja = 10
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
				arg_143_0:Play413012036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10092 = arg_143_1.actors_["10092"].transform.localPosition
				arg_143_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10092", 4)

				for iter_146_0 = 0, arg_143_1.actors_["10092"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10092"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_8" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_146_2 = arg_143_1.actors_["10092"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps10092 == nil then
				arg_143_1.var_.actorSpriteComps10092 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps10092 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps10092 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps10092 = nil
			end

			local var_146_5 = arg_143_1.actors_["10022"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10022 == nil then
				arg_143_1.var_.actorSpriteComps10022 = var_146_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_6 = 2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.actorSpriteComps10022 then
					for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_146_6 then
							if arg_143_1.isInRecall_ then
								iter_146_6.color = Color.New(Mathf.Lerp(iter_146_6.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_6), Mathf.Lerp(iter_146_6.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_6), (Mathf.Lerp(iter_146_6.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_6)))
							else
								local var_146_7 = Mathf.Lerp(iter_146_6.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_6)

								iter_146_6.color = Color.New(var_146_7, var_146_7, var_146_7)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.actorSpriteComps10022 then
				for iter_146_7, iter_146_8 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_146_8 then
						iter_146_8.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps10022 = nil
			end

			local var_146_8 = 0
			local var_146_9 = 0.95

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(413012035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 38 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 38)

				if (38 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 38)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012035", "story_v_out_413012.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012035", "story_v_out_413012.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_413012", "413012035", "story_v_out_413012.awb")

						arg_143_1:RecordAudio("413012035", var_146_15)
						arg_143_1:RecordAudio("413012035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413012", "413012035", "story_v_out_413012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413012", "413012035", "story_v_out_413012.awb")
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
				actorName = "10092",
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
	Play413012036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413012036
		arg_147_1.duration_ = 10.07

		local var_147_0 = {
			zh = 5.9,
			ja = 10.066
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
				arg_147_0:Play413012037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.75

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
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

				local var_150_1 = arg_147_1:GetWordFromCfg(413012036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 30)

				if (30 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 30)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012036", "story_v_out_413012.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012036", "story_v_out_413012.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_413012", "413012036", "story_v_out_413012.awb")

						arg_147_1:RecordAudio("413012036", var_150_6)
						arg_147_1:RecordAudio("413012036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413012", "413012036", "story_v_out_413012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413012", "413012036", "story_v_out_413012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413012037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413012037
		arg_151_1.duration_ = 6.9

		local var_151_0 = {
			zh = 6.9,
			ja = 6.233
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
				arg_151_0:Play413012038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10092"]) and arg_151_1.var_.actorSpriteComps10092 == nil then
				arg_151_1.var_.actorSpriteComps10092 = arg_151_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10092"]) then
				if arg_151_1.var_.actorSpriteComps10092 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10092"]) and arg_151_1.var_.actorSpriteComps10092 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10092 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.85

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_151_1.callingController_:SetSelectedState("calling")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:GetWordFromCfg(413012037)
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

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012037", "story_v_out_413012.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012037", "story_v_out_413012.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_413012", "413012037", "story_v_out_413012.awb")

						arg_151_1:RecordAudio("413012037", var_154_9)
						arg_151_1:RecordAudio("413012037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413012", "413012037", "story_v_out_413012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413012", "413012037", "story_v_out_413012.awb")
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

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413012038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413012038
		arg_155_1.duration_ = 5.87

		local var_155_0 = {
			zh = 4.266,
			ja = 5.866
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
				arg_155_0:Play413012039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10022"]) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = arg_155_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10022"]) then
				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10022"]) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_2 = 0
			local var_158_3 = 0.525

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(413012038)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 21 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 21)

				if (21 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 21)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012038", "story_v_out_413012.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012038", "story_v_out_413012.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_413012", "413012038", "story_v_out_413012.awb")

						arg_155_1:RecordAudio("413012038", var_158_9)
						arg_155_1:RecordAudio("413012038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413012", "413012038", "story_v_out_413012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413012", "413012038", "story_v_out_413012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play413012039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413012039
		arg_159_1.duration_ = 8.8

		local var_159_0 = {
			zh = 8.366,
			ja = 8.8
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
				arg_159_0:Play413012040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10092 = arg_159_1.actors_["10092"].transform.localPosition
				arg_159_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10092", 4)

				for iter_162_0 = 0, arg_159_1.actors_["10092"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["10092"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_1_1" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_162_2 = arg_159_1.actors_["10092"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10092 == nil then
				arg_159_1.var_.actorSpriteComps10092 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps10092 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								iter_162_2.color = Color.New(Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_2.color.r, 1, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_2.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps10092 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10092 = nil
			end

			local var_162_5 = arg_159_1.actors_["10022"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_6 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								iter_162_6.color = Color.New(Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_6), Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_6), (Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_6)))
							else
								local var_162_7 = Mathf.Lerp(iter_162_6.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_6)

								iter_162_6.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_8 then
						iter_162_8.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
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

				local var_162_10 = arg_159_1:GetWordFromCfg(413012039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 40 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 40)

				if (40 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 40)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012039", "story_v_out_413012.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012039", "story_v_out_413012.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_413012", "413012039", "story_v_out_413012.awb")

						arg_159_1:RecordAudio("413012039", var_162_15)
						arg_159_1:RecordAudio("413012039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413012", "413012039", "story_v_out_413012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413012", "413012039", "story_v_out_413012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play413012040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413012040
		arg_163_1.duration_ = 3.17

		local var_163_0 = {
			zh = 3,
			ja = 3.166
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
				arg_163_0:Play413012041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = arg_163_1.actors_["10022"].transform.localPosition
				arg_163_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 2)

				for iter_166_0 = 0, arg_163_1.actors_["10022"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10022"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_8" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_166_2 = arg_163_1.actors_["10022"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_5 = arg_163_1.actors_["10092"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10092 == nil then
				arg_163_1.var_.actorSpriteComps10092 = var_166_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.actorSpriteComps10092 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								iter_166_6.color = Color.New(Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_6), Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_6), (Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_6)))
							else
								local var_166_7 = Mathf.Lerp(iter_166_6.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_6)

								iter_166_6.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps10092 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_166_8 then
						iter_166_8.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10092 = nil
			end

			local var_166_8 = 0
			local var_166_9 = 0.4

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(413012040)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 16 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 16)

				if (16 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 16)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012040", "story_v_out_413012.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_413012", "413012040", "story_v_out_413012.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_413012", "413012040", "story_v_out_413012.awb")

						arg_163_1:RecordAudio("413012040", var_166_15)
						arg_163_1:RecordAudio("413012040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413012", "413012040", "story_v_out_413012.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413012", "413012040", "story_v_out_413012.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play413012041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413012041
		arg_167_1.duration_ = 4.83

		local var_167_0 = {
			zh = 2.966,
			ja = 4.833
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
				arg_167_0:Play413012042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10092"]) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = arg_167_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10092"]) then
				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10092"]) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_2 = arg_167_1.actors_["10022"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_7 then
						iter_170_7.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 0.325

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
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

				local var_170_7 = arg_167_1:GetWordFromCfg(413012041)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 13 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 13)

				if (13 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 13)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012041", "story_v_out_413012.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_413012", "413012041", "story_v_out_413012.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_413012", "413012041", "story_v_out_413012.awb")

						arg_167_1:RecordAudio("413012041", var_170_12)
						arg_167_1:RecordAudio("413012041", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413012", "413012041", "story_v_out_413012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413012", "413012041", "story_v_out_413012.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play413012042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413012042
		arg_171_1.duration_ = 9.77

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play413012043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.bgs_.SS1301 == nil then
				local var_174_0 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1301")
				var_174_0.name = "SS1301"
				var_174_0.transform.parent = arg_171_1.stage_.transform
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_.SS1301 = var_174_0
			end

			if 1.98333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 1.98333333333333 + arg_174_0 then
				local var_174_1 = arg_171_1.bgs_.SS1301

				arg_171_1.bgs_.SS1301.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_2 = var_174_1:GetComponent("SpriteRenderer")

				if var_174_2 and var_174_2.sprite then
					local var_174_3 = 2 * (var_174_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_1.transform.localScale = Vector3.New(var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "SS1301" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_4 = 4

			if 4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_4 + 0.3 and arg_171_1.time_ < var_174_4 + 0.3 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_5 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_6 = 2

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_6 then
				local var_174_7 = Color.New(0, 0, 0)

				var_174_7.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_5) / var_174_6)
				arg_171_1.mask_.color = var_174_7
			end

			if arg_171_1.time_ >= var_174_5 + var_174_6 and arg_171_1.time_ < var_174_5 + var_174_6 + arg_174_0 then
				local var_174_8 = Color.New(0, 0, 0)

				var_174_8.a = 1
				arg_171_1.mask_.color = var_174_8
			end

			local var_174_9 = 2

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_10 = 2

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_10 then
				local var_174_11 = Color.New(0, 0, 0)

				var_174_11.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_9) / var_174_10)
				arg_171_1.mask_.color = var_174_11
			end

			if arg_171_1.time_ >= var_174_9 + var_174_10 and arg_171_1.time_ < var_174_9 + var_174_10 + arg_174_0 then
				local var_174_12 = Color.New(0, 0, 0)

				arg_171_1.mask_.enabled = false
				var_174_12.a = 0
				arg_171_1.mask_.color = var_174_12
			end

			local var_174_13 = arg_171_1.actors_["10092"].transform

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = var_174_13.localPosition
				var_174_13.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 0)

				for iter_174_2 = 0, var_174_13.childCount - 1 do
					local var_174_14 = var_174_13:GetChild(iter_174_2)

					if var_174_14.name == "" or not string.find(var_174_14.name, "split") then
						var_174_14.gameObject:SetActive(true)
					else
						var_174_14.gameObject:SetActive(false)
					end
				end
			end

			local var_174_15 = 0.001

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_15 then
				var_174_13.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_171_1.time_ - 1.966) / var_174_15)
			end

			if arg_171_1.time_ >= 1.966 + var_174_15 and arg_171_1.time_ < 1.966 + var_174_15 + arg_174_0 then
				var_174_13.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_174_16 = arg_171_1.actors_["10022"].transform

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = var_174_16.localPosition
				var_174_16.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 0)

				for iter_174_3 = 0, var_174_16.childCount - 1 do
					local var_174_17 = var_174_16:GetChild(iter_174_3)

					if var_174_17.name == "" or not string.find(var_174_17.name, "split") then
						var_174_17.gameObject:SetActive(true)
					else
						var_174_17.gameObject:SetActive(false)
					end
				end
			end

			local var_174_18 = 0.001

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_18 then
				var_174_16.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_171_1.time_ - 1.966) / var_174_18)
			end

			if arg_171_1.time_ >= 1.966 + var_174_18 and arg_171_1.time_ < 1.966 + var_174_18 + arg_174_0 then
				var_174_16.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_174_19 = arg_171_1.actors_["10092"]

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 and not isNil(var_174_19) and arg_171_1.var_.actorSpriteComps10092 == nil then
				arg_171_1.var_.actorSpriteComps10092 = var_174_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_20 = 0.034

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_20 and not isNil(var_174_19) then
				if arg_171_1.var_.actorSpriteComps10092 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								iter_174_5.color = Color.New(Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 1.966) / var_174_20), Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 1.966) / var_174_20), (Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 1.966) / var_174_20)))
							else
								local var_174_21 = Mathf.Lerp(iter_174_5.color.r, 0.5, (arg_171_1.time_ - 1.966) / var_174_20)

								iter_174_5.color = Color.New(var_174_21, var_174_21, var_174_21)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 1.966 + var_174_20 and arg_171_1.time_ < 1.966 + var_174_20 + arg_174_0 and not isNil(var_174_19) and arg_171_1.var_.actorSpriteComps10092 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_174_7 then
						iter_174_7.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10092 = nil
			end

			local var_174_22 = arg_171_1.actors_["10022"]

			if 1.966 < arg_171_1.time_ and arg_171_1.time_ <= 1.966 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10022 == nil then
				arg_171_1.var_.actorSpriteComps10022 = var_174_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_23 = 0.034

			if 1.966 <= arg_171_1.time_ and arg_171_1.time_ < 1.966 + var_174_23 and not isNil(var_174_22) then
				if arg_171_1.var_.actorSpriteComps10022 then
					for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_174_9 then
							if arg_171_1.isInRecall_ then
								iter_174_9.color = Color.New(Mathf.Lerp(iter_174_9.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 1.966) / var_174_23), Mathf.Lerp(iter_174_9.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 1.966) / var_174_23), (Mathf.Lerp(iter_174_9.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 1.966) / var_174_23)))
							else
								local var_174_24 = Mathf.Lerp(iter_174_9.color.r, 0.5, (arg_171_1.time_ - 1.966) / var_174_23)

								iter_174_9.color = Color.New(var_174_24, var_174_24, var_174_24)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 1.966 + var_174_23 and arg_171_1.time_ < 1.966 + var_174_23 + arg_174_0 and not isNil(var_174_22) and arg_171_1.var_.actorSpriteComps10022 then
				for iter_174_10, iter_174_11 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_174_11 then
						iter_174_11.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10022 = nil
			end

			local var_174_25 = arg_171_1.bgs_.SS1301.transform

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				arg_171_1.var_.moveOldPosSS1301 = var_174_25.localPosition
			end

			local var_174_26 = 0.1

			if 2 <= arg_171_1.time_ and arg_171_1.time_ < 2 + var_174_26 then
				var_174_25.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosSS1301, Vector3.New(0, 1, 10), (arg_171_1.time_ - 2) / var_174_26)
			end

			if arg_171_1.time_ >= 2 + var_174_26 and arg_171_1.time_ < 2 + var_174_26 + arg_174_0 then
				var_174_25.localPosition = Vector3.New(0, 1, 10)
			end

			local var_174_27 = arg_171_1.bgs_.SS1301.transform

			if 2.1 < arg_171_1.time_ and arg_171_1.time_ <= 2.1 + arg_174_0 then
				arg_171_1.var_.moveOldPosSS1301 = var_174_27.localPosition
			end

			local var_174_28 = 3

			if 2.1 <= arg_171_1.time_ and arg_171_1.time_ < 2.1 + var_174_28 then
				var_174_27.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosSS1301, Vector3.New(0, 1, 9.5), (arg_171_1.time_ - 2.1) / var_174_28)
			end

			if arg_171_1.time_ >= 2.1 + var_174_28 and arg_171_1.time_ < 2.1 + var_174_28 + arg_174_0 then
				var_174_27.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_174_29 = 4

			if 4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_29 + 1.1 and arg_171_1.time_ < var_174_29 + 1.1 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_30 = 4.76666666666667
			local var_174_31 = 0.675

			if 4.76666666666667 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_32 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_32:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_33 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(413012042).content)

				arg_171_1.text_.text = var_174_33

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_35 = 27 <= 0 and var_174_31 or var_174_31 * (utf8.len(var_174_33) / 27)

				if (27 <= 0 and var_174_31 or var_174_31 * (utf8.len(var_174_33) / 27)) > 0 and var_174_31 < var_174_35 then
					arg_171_1.talkMaxDuration = var_174_35
					var_174_30 = var_174_30 + 0.3

					if var_174_35 + var_174_30 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_35 + var_174_30
					end
				end

				arg_171_1.text_.text = var_174_33
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_36 = var_174_30 + 0.3
			local var_174_37 = math.max(var_174_31, arg_171_1.talkMaxDuration)

			if var_174_30 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_36 + var_174_37 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_36) / var_174_37

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_36 + var_174_37 and arg_171_1.time_ < var_174_36 + var_174_37 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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
				actorName = "SS1301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413012043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413012043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play413012044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.775

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(413012043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 31)

				if (31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 31)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play413012044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413012044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play413012045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.375

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(413012044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 55 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 55)

				if (55 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 55)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413012045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413012045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play413012046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.075

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

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(413012045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 43 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 43)

				if (43 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 43)) > 0 and var_188_0 < var_188_3 then
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
	Play413012046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413012046
		arg_189_1.duration_ = 2.27

		local var_189_0 = {
			zh = 1.766,
			ja = 2.266
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
				arg_189_0:Play413012047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(413012046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 9 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 9)

				if (9 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 9)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012046", "story_v_out_413012.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012046", "story_v_out_413012.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_413012", "413012046", "story_v_out_413012.awb")

						arg_189_1:RecordAudio("413012046", var_192_6)
						arg_189_1:RecordAudio("413012046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413012", "413012046", "story_v_out_413012.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413012", "413012046", "story_v_out_413012.awb")
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
	Play413012047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413012047
		arg_193_1.duration_ = 6.2

		local var_193_0 = {
			zh = 4.533,
			ja = 6.2
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
				arg_193_0:Play413012048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.5

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(413012047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 20 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 20)

				if (20 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 20)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012047", "story_v_out_413012.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012047", "story_v_out_413012.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_413012", "413012047", "story_v_out_413012.awb")

						arg_193_1:RecordAudio("413012047", var_196_6)
						arg_193_1:RecordAudio("413012047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413012", "413012047", "story_v_out_413012.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413012", "413012047", "story_v_out_413012.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play413012048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413012048
		arg_197_1.duration_ = 3.93

		local var_197_0 = {
			zh = 2.866,
			ja = 3.933
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
				arg_197_0:Play413012049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(413012048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 13 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 13)

				if (13 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 13)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012048", "story_v_out_413012.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_413012", "413012048", "story_v_out_413012.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_413012", "413012048", "story_v_out_413012.awb")

						arg_197_1:RecordAudio("413012048", var_200_6)
						arg_197_1:RecordAudio("413012048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413012", "413012048", "story_v_out_413012.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413012", "413012048", "story_v_out_413012.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play413012049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413012049
		arg_201_1.duration_ = 7.02

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
			arg_201_1.auto_ = false
		end

		function arg_201_1.playNext_(arg_203_0)
			arg_201_1.onStoryFinished_()
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_0 = 1

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				local var_204_1 = Color.New(1, 1, 1)

				var_204_1.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.mask_.color = var_204_1
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				local var_204_2 = Color.New(1, 1, 1)

				arg_201_1.mask_.enabled = false
				var_204_2.a = 0
				arg_201_1.mask_.color = var_204_2
			end

			local var_204_3 = arg_201_1.bgs_.SS1301.transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPosSS1301 = var_204_3.localPosition
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_3.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPosSS1301, Vector3.New(0, 1, 9), (arg_201_1.time_ - 0) / var_204_4)
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_3.localPosition = Vector3.New(0, 1, 9)
			end

			local var_204_5 = arg_201_1.bgs_.SS1301.transform

			if 0.0166666666666666 < arg_201_1.time_ and arg_201_1.time_ <= 0.0166666666666666 + arg_204_0 then
				arg_201_1.var_.moveOldPosSS1301 = var_204_5.localPosition
			end

			local var_204_6 = 6

			if 0.0166666666666666 <= arg_201_1.time_ and arg_201_1.time_ < 0.0166666666666666 + var_204_6 then
				var_204_5.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPosSS1301, Vector3.New(0, 1, 10), (arg_201_1.time_ - 0.0166666666666666) / var_204_6)
			end

			if arg_201_1.time_ >= 0.0166666666666666 + var_204_6 and arg_201_1.time_ < 0.0166666666666666 + var_204_6 + arg_204_0 then
				var_204_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_204_7 = 0.999999999999

			if 0.999999999999 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			if arg_201_1.time_ >= var_204_7 + 5.01666666666767 and arg_201_1.time_ < var_204_7 + 5.01666666666767 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_8 = 2.16666666666667
			local var_204_9 = 0.175

			if 2.16666666666667 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_10 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_10:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_11 = arg_201_1:GetWordFromCfg(413012049)
				local var_204_12 = arg_201_1:FormatText(var_204_11.content)

				arg_201_1.text_.text = var_204_12

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_14 = 7 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_12) / 7)

				if (7 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_12) / 7)) > 0 and var_204_9 < var_204_14 then
					arg_201_1.talkMaxDuration = var_204_14
					var_204_8 = var_204_8 + 0.3

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_12
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012049", "story_v_out_413012.awb") ~= 0 then
					local var_204_15 = manager.audio:GetVoiceLength("story_v_out_413012", "413012049", "story_v_out_413012.awb") / 1000

					if var_204_15 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_8
					end

					if var_204_11.prefab_name ~= "" and arg_201_1.actors_[var_204_11.prefab_name] ~= nil then
						local var_204_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_11.prefab_name].transform, "story_v_out_413012", "413012049", "story_v_out_413012.awb")

						arg_201_1:RecordAudio("413012049", var_204_16)
						arg_201_1:RecordAudio("413012049", var_204_16)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413012", "413012049", "story_v_out_413012.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413012", "413012049", "story_v_out_413012.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_17 = var_204_8 + 0.3
			local var_204_18 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_18 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_17) / var_204_18

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_17 + var_204_18 and arg_201_1.time_ < var_204_17 + var_204_18 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0602",
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1301"
	},
	voices = {
		"story_v_out_413012.awb"
	}
}
