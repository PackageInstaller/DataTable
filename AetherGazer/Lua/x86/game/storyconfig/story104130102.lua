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
			local var_4_0 = "ST0602"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST0602

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0602" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.266666666666667

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.366666666666667
			local var_4_31 = 0.833333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 0.375

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[998].name)

				arg_1_1.leftNameTxt_.text = var_4_39

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

				local var_4_40 = arg_1_1:GetWordFromCfg(413012001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 15
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012001", "story_v_out_413012.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_413012", "413012001", "story_v_out_413012.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_413012", "413012001", "story_v_out_413012.awb")

						arg_1_1:RecordAudio("413012001", var_4_46)
						arg_1_1:RecordAudio("413012001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413012", "413012001", "story_v_out_413012.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413012", "413012001", "story_v_out_413012.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
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
			local var_12_0 = "10022"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["10022"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10022 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10022", 3)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_6" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(0, -315, -320)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10022, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_12_11 = arg_9_1.actors_["10022"]
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10022 == nil then
				arg_9_1.var_.actorSpriteComps10022 = var_12_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_13 = 2

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 and not isNil(var_12_11) then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13

				if arg_9_1.var_.actorSpriteComps10022 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_12_4 then
							if arg_9_1.isInRecall_ then
								local var_12_15 = Mathf.Lerp(iter_12_4.color.r, arg_9_1.hightColor1.r, var_12_14)
								local var_12_16 = Mathf.Lerp(iter_12_4.color.g, arg_9_1.hightColor1.g, var_12_14)
								local var_12_17 = Mathf.Lerp(iter_12_4.color.b, arg_9_1.hightColor1.b, var_12_14)

								iter_12_4.color = Color.New(var_12_15, var_12_16, var_12_17)
							else
								local var_12_18 = Mathf.Lerp(iter_12_4.color.r, 1, var_12_14)

								iter_12_4.color = Color.New(var_12_18, var_12_18, var_12_18)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 and not isNil(var_12_11) and arg_9_1.var_.actorSpriteComps10022 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_12_6 then
						if arg_9_1.isInRecall_ then
							iter_12_6.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10022 = nil
			end

			local var_12_19 = arg_9_1.actors_["10022"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				local var_12_21 = var_12_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_21 then
					arg_9_1.var_.alphaOldValue10022 = var_12_21.alpha
					arg_9_1.var_.characterEffect10022 = var_12_21
				end

				arg_9_1.var_.alphaOldValue10022 = 0
			end

			local var_12_22 = 0.3

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_20) / var_12_22
				local var_12_24 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10022, 1, var_12_23)

				if arg_9_1.var_.characterEffect10022 then
					arg_9_1.var_.characterEffect10022.alpha = var_12_24
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_22 and arg_9_1.time_ < var_12_20 + var_12_22 + arg_12_0 and arg_9_1.var_.characterEffect10022 then
				arg_9_1.var_.characterEffect10022.alpha = 1
			end

			local var_12_25 = 0
			local var_12_26 = 0.7

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_27 = arg_9_1:FormatText(StoryNameCfg[614].name)

				arg_9_1.leftNameTxt_.text = var_12_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_28 = arg_9_1:GetWordFromCfg(413012002)
				local var_12_29 = arg_9_1:FormatText(var_12_28.content)

				arg_9_1.text_.text = var_12_29

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_30 = 28
				local var_12_31 = utf8.len(var_12_29)
				local var_12_32 = var_12_30 <= 0 and var_12_26 or var_12_26 * (var_12_31 / var_12_30)

				if var_12_32 > 0 and var_12_26 < var_12_32 then
					arg_9_1.talkMaxDuration = var_12_32

					if var_12_32 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_32 + var_12_25
					end
				end

				arg_9_1.text_.text = var_12_29
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012002", "story_v_out_413012.awb") ~= 0 then
					local var_12_33 = manager.audio:GetVoiceLength("story_v_out_413012", "413012002", "story_v_out_413012.awb") / 1000

					if var_12_33 + var_12_25 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_25
					end

					if var_12_28.prefab_name ~= "" and arg_9_1.actors_[var_12_28.prefab_name] ~= nil then
						local var_12_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_28.prefab_name].transform, "story_v_out_413012", "413012002", "story_v_out_413012.awb")

						arg_9_1:RecordAudio("413012002", var_12_34)
						arg_9_1:RecordAudio("413012002", var_12_34)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413012", "413012002", "story_v_out_413012.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413012", "413012002", "story_v_out_413012.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_35 = math.max(var_12_26, arg_9_1.talkMaxDuration)

			if var_12_25 <= arg_9_1.time_ and arg_9_1.time_ < var_12_25 + var_12_35 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_25) / var_12_35

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_25 + var_12_35 and arg_9_1.time_ < var_12_25 + var_12_35 + arg_12_0 then
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
			local var_16_0 = arg_13_1.actors_["10022"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 0.5, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.175

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[998].name)

				arg_13_1.leftNameTxt_.text = var_16_10

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

				local var_16_11 = arg_13_1:GetWordFromCfg(413012003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 7
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012003", "story_v_out_413012.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012003", "story_v_out_413012.awb") / 1000

					if var_16_16 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_8
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_413012", "413012003", "story_v_out_413012.awb")

						arg_13_1:RecordAudio("413012003", var_16_17)
						arg_13_1:RecordAudio("413012003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413012", "413012003", "story_v_out_413012.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413012", "413012003", "story_v_out_413012.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_18 and arg_13_1.time_ < var_16_8 + var_16_18 + arg_16_0 then
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
			local var_20_0 = arg_17_1.actors_["10022"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.925

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[614].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(413012004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 37
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_9 or var_20_9 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_9 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012004", "story_v_out_413012.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012004", "story_v_out_413012.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_413012", "413012004", "story_v_out_413012.awb")

						arg_17_1:RecordAudio("413012004", var_20_17)
						arg_17_1:RecordAudio("413012004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413012", "413012004", "story_v_out_413012.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413012", "413012004", "story_v_out_413012.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_18 and arg_17_1.time_ < var_20_8 + var_20_18 + arg_20_0 then
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
			local var_24_0 = arg_21_1.actors_["10022"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 == nil then
				arg_21_1.var_.actorSpriteComps10022 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10022 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10022 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10022 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.875

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[998].name)

				arg_21_1.leftNameTxt_.text = var_24_10

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

				local var_24_11 = arg_21_1:GetWordFromCfg(413012005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 35
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012005", "story_v_out_413012.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012005", "story_v_out_413012.awb") / 1000

					if var_24_16 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_8
					end

					if var_24_11.prefab_name ~= "" and arg_21_1.actors_[var_24_11.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_11.prefab_name].transform, "story_v_out_413012", "413012005", "story_v_out_413012.awb")

						arg_21_1:RecordAudio("413012005", var_24_17)
						arg_21_1:RecordAudio("413012005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413012", "413012005", "story_v_out_413012.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413012", "413012005", "story_v_out_413012.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_18 and arg_21_1.time_ < var_24_8 + var_24_18 + arg_24_0 then
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
			local var_28_0 = arg_25_1.actors_["10022"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_2" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -315, -320)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_7 = arg_25_1.actors_["10022"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 1

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[614].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(413012006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 40
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012006", "story_v_out_413012.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_413012", "413012006", "story_v_out_413012.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_413012", "413012006", "story_v_out_413012.awb")

						arg_25_1:RecordAudio("413012006", var_28_24)
						arg_25_1:RecordAudio("413012006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413012", "413012006", "story_v_out_413012.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413012", "413012006", "story_v_out_413012.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
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
			local var_32_0 = arg_29_1.actors_["10022"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.725

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[998].name)

				arg_29_1.leftNameTxt_.text = var_32_10

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

				local var_32_11 = arg_29_1:GetWordFromCfg(413012007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 29
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_9 or var_32_9 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_9 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012007", "story_v_out_413012.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012007", "story_v_out_413012.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_413012", "413012007", "story_v_out_413012.awb")

						arg_29_1:RecordAudio("413012007", var_32_17)
						arg_29_1:RecordAudio("413012007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413012", "413012007", "story_v_out_413012.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413012", "413012007", "story_v_out_413012.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_18 and arg_29_1.time_ < var_32_8 + var_32_18 + arg_32_0 then
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
			local var_36_0 = 0
			local var_36_1 = 0.225

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[998].name)

				arg_33_1.leftNameTxt_.text = var_36_2

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

				local var_36_3 = arg_33_1:GetWordFromCfg(413012008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 9
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012008", "story_v_out_413012.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012008", "story_v_out_413012.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_413012", "413012008", "story_v_out_413012.awb")

						arg_33_1:RecordAudio("413012008", var_36_9)
						arg_33_1:RecordAudio("413012008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413012", "413012008", "story_v_out_413012.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413012", "413012008", "story_v_out_413012.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
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
			local var_40_0 = arg_37_1.actors_["10022"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 0)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-1500, -350, -180)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_40_7 = "10092"

			if arg_37_1.actors_[var_40_7] == nil then
				local var_40_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_40_8) then
					local var_40_9 = Object.Instantiate(var_40_8, arg_37_1.canvasGo_.transform)

					var_40_9.transform:SetSiblingIndex(1)

					var_40_9.name = var_40_7
					var_40_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_7] = var_40_9

					local var_40_10 = var_40_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_1, iter_40_2 in ipairs(var_40_10) do
							iter_40_2.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_11 = arg_37_1.actors_["10092"].transform
			local var_40_12 = 0

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.var_.moveOldPos10092 = var_40_11.localPosition
				var_40_11.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10092", 3)

				local var_40_13 = var_40_11.childCount

				for iter_40_3 = 0, var_40_13 - 1 do
					local var_40_14 = var_40_11:GetChild(iter_40_3)

					if var_40_14.name == "" or not string.find(var_40_14.name, "split") then
						var_40_14.gameObject:SetActive(true)
					else
						var_40_14.gameObject:SetActive(false)
					end
				end
			end

			local var_40_15 = 0.001

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_15 then
				local var_40_16 = (arg_37_1.time_ - var_40_12) / var_40_15
				local var_40_17 = Vector3.New(0, -300, -295)

				var_40_11.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10092, var_40_17, var_40_16)
			end

			if arg_37_1.time_ >= var_40_12 + var_40_15 and arg_37_1.time_ < var_40_12 + var_40_15 + arg_40_0 then
				var_40_11.localPosition = Vector3.New(0, -300, -295)
			end

			local var_40_18 = arg_37_1.actors_["10022"]
			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_20 = 2

			if var_40_19 <= arg_37_1.time_ and arg_37_1.time_ < var_40_19 + var_40_20 and not isNil(var_40_18) then
				local var_40_21 = (arg_37_1.time_ - var_40_19) / var_40_20

				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_22 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, var_40_21)
								local var_40_23 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, var_40_21)
								local var_40_24 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, var_40_21)

								iter_40_5.color = Color.New(var_40_22, var_40_23, var_40_24)
							else
								local var_40_25 = Mathf.Lerp(iter_40_5.color.r, 0.5, var_40_21)

								iter_40_5.color = Color.New(var_40_25, var_40_25, var_40_25)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_19 + var_40_20 and arg_37_1.time_ < var_40_19 + var_40_20 + arg_40_0 and not isNil(var_40_18) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_26 = arg_37_1.actors_["10092"]
			local var_40_27 = 0

			if var_40_27 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 and not isNil(var_40_26) and arg_37_1.var_.actorSpriteComps10092 == nil then
				arg_37_1.var_.actorSpriteComps10092 = var_40_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_28 = 2

			if var_40_27 <= arg_37_1.time_ and arg_37_1.time_ < var_40_27 + var_40_28 and not isNil(var_40_26) then
				local var_40_29 = (arg_37_1.time_ - var_40_27) / var_40_28

				if arg_37_1.var_.actorSpriteComps10092 then
					for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_40_9 then
							if arg_37_1.isInRecall_ then
								local var_40_30 = Mathf.Lerp(iter_40_9.color.r, arg_37_1.hightColor1.r, var_40_29)
								local var_40_31 = Mathf.Lerp(iter_40_9.color.g, arg_37_1.hightColor1.g, var_40_29)
								local var_40_32 = Mathf.Lerp(iter_40_9.color.b, arg_37_1.hightColor1.b, var_40_29)

								iter_40_9.color = Color.New(var_40_30, var_40_31, var_40_32)
							else
								local var_40_33 = Mathf.Lerp(iter_40_9.color.r, 1, var_40_29)

								iter_40_9.color = Color.New(var_40_33, var_40_33, var_40_33)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_27 + var_40_28 and arg_37_1.time_ < var_40_27 + var_40_28 + arg_40_0 and not isNil(var_40_26) and arg_37_1.var_.actorSpriteComps10092 then
				for iter_40_10, iter_40_11 in pairs(arg_37_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_40_11 then
						if arg_37_1.isInRecall_ then
							iter_40_11.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10092 = nil
			end

			local var_40_34 = arg_37_1.actors_["10092"]
			local var_40_35 = 0

			if var_40_35 < arg_37_1.time_ and arg_37_1.time_ <= var_40_35 + arg_40_0 then
				local var_40_36 = var_40_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_36 then
					arg_37_1.var_.alphaOldValue10092 = var_40_36.alpha
					arg_37_1.var_.characterEffect10092 = var_40_36
				end

				arg_37_1.var_.alphaOldValue10092 = 0
			end

			local var_40_37 = 0.2

			if var_40_35 <= arg_37_1.time_ and arg_37_1.time_ < var_40_35 + var_40_37 then
				local var_40_38 = (arg_37_1.time_ - var_40_35) / var_40_37
				local var_40_39 = Mathf.Lerp(arg_37_1.var_.alphaOldValue10092, 1, var_40_38)

				if arg_37_1.var_.characterEffect10092 then
					arg_37_1.var_.characterEffect10092.alpha = var_40_39
				end
			end

			if arg_37_1.time_ >= var_40_35 + var_40_37 and arg_37_1.time_ < var_40_35 + var_40_37 + arg_40_0 and arg_37_1.var_.characterEffect10092 then
				arg_37_1.var_.characterEffect10092.alpha = 1
			end

			local var_40_40 = arg_37_1.actors_["10092"]
			local var_40_41 = 0

			if var_40_41 < arg_37_1.time_ and arg_37_1.time_ <= var_40_41 + arg_40_0 then
				local var_40_42 = var_40_40:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_42 then
					arg_37_1.var_.alphaOldValue10092 = var_40_42.alpha
					arg_37_1.var_.characterEffect10092 = var_40_42
				end

				arg_37_1.var_.alphaOldValue10092 = 0
			end

			local var_40_43 = 0.3

			if var_40_41 <= arg_37_1.time_ and arg_37_1.time_ < var_40_41 + var_40_43 then
				local var_40_44 = (arg_37_1.time_ - var_40_41) / var_40_43
				local var_40_45 = Mathf.Lerp(arg_37_1.var_.alphaOldValue10092, 1, var_40_44)

				if arg_37_1.var_.characterEffect10092 then
					arg_37_1.var_.characterEffect10092.alpha = var_40_45
				end
			end

			if arg_37_1.time_ >= var_40_41 + var_40_43 and arg_37_1.time_ < var_40_41 + var_40_43 + arg_40_0 and arg_37_1.var_.characterEffect10092 then
				arg_37_1.var_.characterEffect10092.alpha = 1
			end

			local var_40_46 = 0
			local var_40_47 = 0.875

			if var_40_46 < arg_37_1.time_ and arg_37_1.time_ <= var_40_46 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_48 = arg_37_1:FormatText(StoryNameCfg[996].name)

				arg_37_1.leftNameTxt_.text = var_40_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_49 = arg_37_1:GetWordFromCfg(413012009)
				local var_40_50 = arg_37_1:FormatText(var_40_49.content)

				arg_37_1.text_.text = var_40_50

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_51 = 35
				local var_40_52 = utf8.len(var_40_50)
				local var_40_53 = var_40_51 <= 0 and var_40_47 or var_40_47 * (var_40_52 / var_40_51)

				if var_40_53 > 0 and var_40_47 < var_40_53 then
					arg_37_1.talkMaxDuration = var_40_53

					if var_40_53 + var_40_46 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_53 + var_40_46
					end
				end

				arg_37_1.text_.text = var_40_50
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012009", "story_v_out_413012.awb") ~= 0 then
					local var_40_54 = manager.audio:GetVoiceLength("story_v_out_413012", "413012009", "story_v_out_413012.awb") / 1000

					if var_40_54 + var_40_46 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_54 + var_40_46
					end

					if var_40_49.prefab_name ~= "" and arg_37_1.actors_[var_40_49.prefab_name] ~= nil then
						local var_40_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_49.prefab_name].transform, "story_v_out_413012", "413012009", "story_v_out_413012.awb")

						arg_37_1:RecordAudio("413012009", var_40_55)
						arg_37_1:RecordAudio("413012009", var_40_55)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413012", "413012009", "story_v_out_413012.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413012", "413012009", "story_v_out_413012.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_56 = math.max(var_40_47, arg_37_1.talkMaxDuration)

			if var_40_46 <= arg_37_1.time_ and arg_37_1.time_ < var_40_46 + var_40_56 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_46) / var_40_56

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_46 + var_40_56 and arg_37_1.time_ < var_40_46 + var_40_56 + arg_40_0 then
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
			local var_44_0 = arg_41_1.actors_["10092"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092", 7)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(0, -2000, -180)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_44_7 = arg_41_1.actors_["10092"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10092 == nil then
				arg_41_1.var_.actorSpriteComps10092 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 2

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10092 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 0.5, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10092 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10092 = nil
			end

			local var_44_15 = 0
			local var_44_16 = 1.075

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_17 = arg_41_1:GetWordFromCfg(413012010)
				local var_44_18 = arg_41_1:FormatText(var_44_17.content)

				arg_41_1.text_.text = var_44_18

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 43
				local var_44_20 = utf8.len(var_44_18)
				local var_44_21 = var_44_19 <= 0 and var_44_16 or var_44_16 * (var_44_20 / var_44_19)

				if var_44_21 > 0 and var_44_16 < var_44_21 then
					arg_41_1.talkMaxDuration = var_44_21

					if var_44_21 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_21 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_18
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_22 and arg_41_1.time_ < var_44_15 + var_44_22 + arg_44_0 then
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
			local var_48_0 = arg_45_1.actors_["10022"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10022 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10022", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_6" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-390, -315, -320)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10022, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_48_7 = arg_45_1.actors_["10092"].transform
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.var_.moveOldPos10092 = var_48_7.localPosition
				var_48_7.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10092", 4)

				local var_48_9 = var_48_7.childCount

				for iter_48_1 = 0, var_48_9 - 1 do
					local var_48_10 = var_48_7:GetChild(iter_48_1)

					if var_48_10.name == "" or not string.find(var_48_10.name, "split") then
						var_48_10.gameObject:SetActive(true)
					else
						var_48_10.gameObject:SetActive(false)
					end
				end
			end

			local var_48_11 = 0.001

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_8) / var_48_11
				local var_48_13 = Vector3.New(390, -300, -295)

				var_48_7.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10092, var_48_13, var_48_12)
			end

			if arg_45_1.time_ >= var_48_8 + var_48_11 and arg_45_1.time_ < var_48_8 + var_48_11 + arg_48_0 then
				var_48_7.localPosition = Vector3.New(390, -300, -295)
			end

			local var_48_14 = arg_45_1.actors_["10022"]
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_16 = 2

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 and not isNil(var_48_14) then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16

				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								local var_48_18 = Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, var_48_17)
								local var_48_19 = Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, var_48_17)
								local var_48_20 = Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, var_48_17)

								iter_48_3.color = Color.New(var_48_18, var_48_19, var_48_20)
							else
								local var_48_21 = Mathf.Lerp(iter_48_3.color.r, 1, var_48_17)

								iter_48_3.color = Color.New(var_48_21, var_48_21, var_48_21)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_22 = arg_45_1.actors_["10092"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps10092 == nil then
				arg_45_1.var_.actorSpriteComps10092 = var_48_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_24 = 2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.actorSpriteComps10092 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_26 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_25)
								local var_48_27 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_25)
								local var_48_28 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_25)

								iter_48_7.color = Color.New(var_48_26, var_48_27, var_48_28)
							else
								local var_48_29 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_25)

								iter_48_7.color = Color.New(var_48_29, var_48_29, var_48_29)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps10092 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10092 = nil
			end

			local var_48_30 = arg_45_1.actors_["10022"]
			local var_48_31 = 0

			if var_48_31 < arg_45_1.time_ and arg_45_1.time_ <= var_48_31 + arg_48_0 then
				local var_48_32 = var_48_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_32 then
					arg_45_1.var_.alphaOldValue10022 = var_48_32.alpha
					arg_45_1.var_.characterEffect10022 = var_48_32
				end

				arg_45_1.var_.alphaOldValue10022 = 0
			end

			local var_48_33 = 0.2

			if var_48_31 <= arg_45_1.time_ and arg_45_1.time_ < var_48_31 + var_48_33 then
				local var_48_34 = (arg_45_1.time_ - var_48_31) / var_48_33
				local var_48_35 = Mathf.Lerp(arg_45_1.var_.alphaOldValue10022, 1, var_48_34)

				if arg_45_1.var_.characterEffect10022 then
					arg_45_1.var_.characterEffect10022.alpha = var_48_35
				end
			end

			if arg_45_1.time_ >= var_48_31 + var_48_33 and arg_45_1.time_ < var_48_31 + var_48_33 + arg_48_0 and arg_45_1.var_.characterEffect10022 then
				arg_45_1.var_.characterEffect10022.alpha = 1
			end

			local var_48_36 = 0
			local var_48_37 = 0.475

			if var_48_36 < arg_45_1.time_ and arg_45_1.time_ <= var_48_36 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_38 = arg_45_1:FormatText(StoryNameCfg[614].name)

				arg_45_1.leftNameTxt_.text = var_48_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_39 = arg_45_1:GetWordFromCfg(413012011)
				local var_48_40 = arg_45_1:FormatText(var_48_39.content)

				arg_45_1.text_.text = var_48_40

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_41 = 19
				local var_48_42 = utf8.len(var_48_40)
				local var_48_43 = var_48_41 <= 0 and var_48_37 or var_48_37 * (var_48_42 / var_48_41)

				if var_48_43 > 0 and var_48_37 < var_48_43 then
					arg_45_1.talkMaxDuration = var_48_43

					if var_48_43 + var_48_36 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_43 + var_48_36
					end
				end

				arg_45_1.text_.text = var_48_40
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012011", "story_v_out_413012.awb") ~= 0 then
					local var_48_44 = manager.audio:GetVoiceLength("story_v_out_413012", "413012011", "story_v_out_413012.awb") / 1000

					if var_48_44 + var_48_36 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_44 + var_48_36
					end

					if var_48_39.prefab_name ~= "" and arg_45_1.actors_[var_48_39.prefab_name] ~= nil then
						local var_48_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_39.prefab_name].transform, "story_v_out_413012", "413012011", "story_v_out_413012.awb")

						arg_45_1:RecordAudio("413012011", var_48_45)
						arg_45_1:RecordAudio("413012011", var_48_45)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413012", "413012011", "story_v_out_413012.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413012", "413012011", "story_v_out_413012.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_46 = math.max(var_48_37, arg_45_1.talkMaxDuration)

			if var_48_36 <= arg_45_1.time_ and arg_45_1.time_ < var_48_36 + var_48_46 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_36) / var_48_46

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_36 + var_48_46 and arg_45_1.time_ < var_48_36 + var_48_46 + arg_48_0 then
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
			local var_52_0 = arg_49_1.actors_["10092"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10092 == nil then
				arg_49_1.var_.actorSpriteComps10092 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10092 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10092 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10092 = nil
			end

			local var_52_8 = arg_49_1.actors_["10022"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_16 = 0
			local var_52_17 = 0.775

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_18 = arg_49_1:FormatText(StoryNameCfg[996].name)

				arg_49_1.leftNameTxt_.text = var_52_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(413012012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 31
				local var_52_22 = utf8.len(var_52_20)
				local var_52_23 = var_52_21 <= 0 and var_52_17 or var_52_17 * (var_52_22 / var_52_21)

				if var_52_23 > 0 and var_52_17 < var_52_23 then
					arg_49_1.talkMaxDuration = var_52_23

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012012", "story_v_out_413012.awb") ~= 0 then
					local var_52_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012012", "story_v_out_413012.awb") / 1000

					if var_52_24 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_413012", "413012012", "story_v_out_413012.awb")

						arg_49_1:RecordAudio("413012012", var_52_25)
						arg_49_1:RecordAudio("413012012", var_52_25)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413012", "413012012", "story_v_out_413012.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413012", "413012012", "story_v_out_413012.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_26 and arg_49_1.time_ < var_52_16 + var_52_26 + arg_52_0 then
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
			local var_56_0 = arg_53_1.actors_["10092"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
			end

			local var_56_8 = arg_53_1.actors_["10022"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10022 == nil then
				arg_53_1.var_.actorSpriteComps10022 = var_56_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_10 = 2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.actorSpriteComps10022 then
					for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_56_5 then
							if arg_53_1.isInRecall_ then
								local var_56_12 = Mathf.Lerp(iter_56_5.color.r, arg_53_1.hightColor1.r, var_56_11)
								local var_56_13 = Mathf.Lerp(iter_56_5.color.g, arg_53_1.hightColor1.g, var_56_11)
								local var_56_14 = Mathf.Lerp(iter_56_5.color.b, arg_53_1.hightColor1.b, var_56_11)

								iter_56_5.color = Color.New(var_56_12, var_56_13, var_56_14)
							else
								local var_56_15 = Mathf.Lerp(iter_56_5.color.r, 1, var_56_11)

								iter_56_5.color = Color.New(var_56_15, var_56_15, var_56_15)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_7 then
						if arg_53_1.isInRecall_ then
							iter_56_7.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_16 = 0
			local var_56_17 = 0.275

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_18 = arg_53_1:FormatText(StoryNameCfg[614].name)

				arg_53_1.leftNameTxt_.text = var_56_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_19 = arg_53_1:GetWordFromCfg(413012013)
				local var_56_20 = arg_53_1:FormatText(var_56_19.content)

				arg_53_1.text_.text = var_56_20

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 11
				local var_56_22 = utf8.len(var_56_20)
				local var_56_23 = var_56_21 <= 0 and var_56_17 or var_56_17 * (var_56_22 / var_56_21)

				if var_56_23 > 0 and var_56_17 < var_56_23 then
					arg_53_1.talkMaxDuration = var_56_23

					if var_56_23 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_20
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012013", "story_v_out_413012.awb") ~= 0 then
					local var_56_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012013", "story_v_out_413012.awb") / 1000

					if var_56_24 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_24 + var_56_16
					end

					if var_56_19.prefab_name ~= "" and arg_53_1.actors_[var_56_19.prefab_name] ~= nil then
						local var_56_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_19.prefab_name].transform, "story_v_out_413012", "413012013", "story_v_out_413012.awb")

						arg_53_1:RecordAudio("413012013", var_56_25)
						arg_53_1:RecordAudio("413012013", var_56_25)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413012", "413012013", "story_v_out_413012.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413012", "413012013", "story_v_out_413012.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_26 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_26 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_26

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_26 and arg_53_1.time_ < var_56_16 + var_56_26 + arg_56_0 then
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
			local var_60_0 = arg_57_1.actors_["10092"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092 == nil then
				arg_57_1.var_.actorSpriteComps10092 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10092 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10092 = nil
			end

			local var_60_8 = arg_57_1.actors_["10022"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.7

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[996].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(413012014)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 28
				local var_60_22 = utf8.len(var_60_20)
				local var_60_23 = var_60_21 <= 0 and var_60_17 or var_60_17 * (var_60_22 / var_60_21)

				if var_60_23 > 0 and var_60_17 < var_60_23 then
					arg_57_1.talkMaxDuration = var_60_23

					if var_60_23 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012014", "story_v_out_413012.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012014", "story_v_out_413012.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_413012", "413012014", "story_v_out_413012.awb")

						arg_57_1:RecordAudio("413012014", var_60_25)
						arg_57_1:RecordAudio("413012014", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413012", "413012014", "story_v_out_413012.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413012", "413012014", "story_v_out_413012.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_26 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_26 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_26

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_26 and arg_57_1.time_ < var_60_16 + var_60_26 + arg_60_0 then
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
			local var_64_0 = arg_61_1.actors_["10092"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092 == nil then
				arg_61_1.var_.actorSpriteComps10092 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10092 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10092 = nil
			end

			local var_64_8 = arg_61_1.actors_["10022"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10022 == nil then
				arg_61_1.var_.actorSpriteComps10022 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10022 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 1, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10022 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10022 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.975

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[614].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(413012015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 39
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012015", "story_v_out_413012.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012015", "story_v_out_413012.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_413012", "413012015", "story_v_out_413012.awb")

						arg_61_1:RecordAudio("413012015", var_64_25)
						arg_61_1:RecordAudio("413012015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413012", "413012015", "story_v_out_413012.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413012", "413012015", "story_v_out_413012.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
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
			local var_68_0 = arg_65_1.actors_["10092"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10092 == nil then
				arg_65_1.var_.actorSpriteComps10092 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10092 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10092 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10092 = nil
			end

			local var_68_8 = arg_65_1.actors_["10022"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10022 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 0.5, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.4

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[996].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(413012016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 16
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012016", "story_v_out_413012.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012016", "story_v_out_413012.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_413012", "413012016", "story_v_out_413012.awb")

						arg_65_1:RecordAudio("413012016", var_68_25)
						arg_65_1:RecordAudio("413012016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413012", "413012016", "story_v_out_413012.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413012", "413012016", "story_v_out_413012.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
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
			local var_72_0 = 0
			local var_72_1 = 0.6

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[996].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(413012017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 24
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012017", "story_v_out_413012.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012017", "story_v_out_413012.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_413012", "413012017", "story_v_out_413012.awb")

						arg_69_1:RecordAudio("413012017", var_72_9)
						arg_69_1:RecordAudio("413012017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413012", "413012017", "story_v_out_413012.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413012", "413012017", "story_v_out_413012.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
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
			local var_76_0 = arg_73_1.actors_["10022"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10022 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10022", 2)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_6" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(-390, -315, -320)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10022, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_76_7 = arg_73_1.actors_["10092"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10092 == nil then
				arg_73_1.var_.actorSpriteComps10092 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10092 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor2.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor2.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor2.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 0.5, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10092 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10092 = nil
			end

			local var_76_15 = arg_73_1.actors_["10022"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								local var_76_19 = Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor1.r, var_76_18)
								local var_76_20 = Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor1.g, var_76_18)
								local var_76_21 = Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor1.b, var_76_18)

								iter_76_6.color = Color.New(var_76_19, var_76_20, var_76_21)
							else
								local var_76_22 = Mathf.Lerp(iter_76_6.color.r, 1, var_76_18)

								iter_76_6.color = Color.New(var_76_22, var_76_22, var_76_22)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_8 then
						if arg_73_1.isInRecall_ then
							iter_76_8.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_23 = 0
			local var_76_24 = 0.175

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[614].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(413012018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 7
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_24 or var_76_24 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_24 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_23
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012018", "story_v_out_413012.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012018", "story_v_out_413012.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_413012", "413012018", "story_v_out_413012.awb")

						arg_73_1:RecordAudio("413012018", var_76_32)
						arg_73_1:RecordAudio("413012018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413012", "413012018", "story_v_out_413012.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413012", "413012018", "story_v_out_413012.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = math.max(var_76_24, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_33 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_33

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_33 and arg_73_1.time_ < var_76_23 + var_76_33 + arg_76_0 then
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
			local var_80_0 = arg_77_1.actors_["10092"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_8 = arg_77_1.actors_["10022"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_16 = 0
			local var_80_17 = 0.45

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_18 = arg_77_1:FormatText(StoryNameCfg[996].name)

				arg_77_1.leftNameTxt_.text = var_80_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_19 = arg_77_1:GetWordFromCfg(413012019)
				local var_80_20 = arg_77_1:FormatText(var_80_19.content)

				arg_77_1.text_.text = var_80_20

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_21 = 18
				local var_80_22 = utf8.len(var_80_20)
				local var_80_23 = var_80_21 <= 0 and var_80_17 or var_80_17 * (var_80_22 / var_80_21)

				if var_80_23 > 0 and var_80_17 < var_80_23 then
					arg_77_1.talkMaxDuration = var_80_23

					if var_80_23 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_16
					end
				end

				arg_77_1.text_.text = var_80_20
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012019", "story_v_out_413012.awb") ~= 0 then
					local var_80_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012019", "story_v_out_413012.awb") / 1000

					if var_80_24 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_16
					end

					if var_80_19.prefab_name ~= "" and arg_77_1.actors_[var_80_19.prefab_name] ~= nil then
						local var_80_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_19.prefab_name].transform, "story_v_out_413012", "413012019", "story_v_out_413012.awb")

						arg_77_1:RecordAudio("413012019", var_80_25)
						arg_77_1:RecordAudio("413012019", var_80_25)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413012", "413012019", "story_v_out_413012.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413012", "413012019", "story_v_out_413012.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_26 = math.max(var_80_17, arg_77_1.talkMaxDuration)

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_26 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_16) / var_80_26

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_16 + var_80_26 and arg_77_1.time_ < var_80_16 + var_80_26 + arg_80_0 then
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
			local var_84_0 = 0
			local var_84_1 = 0.6

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[996].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(413012020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 24
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012020", "story_v_out_413012.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012020", "story_v_out_413012.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_413012", "413012020", "story_v_out_413012.awb")

						arg_81_1:RecordAudio("413012020", var_84_9)
						arg_81_1:RecordAudio("413012020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413012", "413012020", "story_v_out_413012.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413012", "413012020", "story_v_out_413012.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
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
			local var_88_0 = arg_85_1.actors_["10092"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			local var_88_8 = arg_85_1.actors_["10022"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 1, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.625

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[614].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(413012021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 25
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_17 or var_88_17 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_17 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012021", "story_v_out_413012.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012021", "story_v_out_413012.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_413012", "413012021", "story_v_out_413012.awb")

						arg_85_1:RecordAudio("413012021", var_88_25)
						arg_85_1:RecordAudio("413012021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413012", "413012021", "story_v_out_413012.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413012", "413012021", "story_v_out_413012.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_16) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_16 + var_88_26 and arg_85_1.time_ < var_88_16 + var_88_26 + arg_88_0 then
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
			local var_92_0 = 0
			local var_92_1 = 1.025

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[614].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(413012022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 41
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012022", "story_v_out_413012.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012022", "story_v_out_413012.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_413012", "413012022", "story_v_out_413012.awb")

						arg_89_1:RecordAudio("413012022", var_92_9)
						arg_89_1:RecordAudio("413012022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413012", "413012022", "story_v_out_413012.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413012", "413012022", "story_v_out_413012.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
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
			local var_96_0 = arg_93_1.actors_["10092"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 4)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_5" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(390, -300, -295)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_96_7 = arg_93_1.actors_["10092"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 1, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_15 = arg_93_1.actors_["10022"]
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_17 = 2

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 and not isNil(var_96_15) then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17

				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_5, iter_96_6 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_6 then
							if arg_93_1.isInRecall_ then
								local var_96_19 = Mathf.Lerp(iter_96_6.color.r, arg_93_1.hightColor2.r, var_96_18)
								local var_96_20 = Mathf.Lerp(iter_96_6.color.g, arg_93_1.hightColor2.g, var_96_18)
								local var_96_21 = Mathf.Lerp(iter_96_6.color.b, arg_93_1.hightColor2.b, var_96_18)

								iter_96_6.color = Color.New(var_96_19, var_96_20, var_96_21)
							else
								local var_96_22 = Mathf.Lerp(iter_96_6.color.r, 0.5, var_96_18)

								iter_96_6.color = Color.New(var_96_22, var_96_22, var_96_22)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_7, iter_96_8 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_8 then
						if arg_93_1.isInRecall_ then
							iter_96_8.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_23 = 0
			local var_96_24 = 0.35

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_25 = arg_93_1:FormatText(StoryNameCfg[996].name)

				arg_93_1.leftNameTxt_.text = var_96_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_26 = arg_93_1:GetWordFromCfg(413012023)
				local var_96_27 = arg_93_1:FormatText(var_96_26.content)

				arg_93_1.text_.text = var_96_27

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_28 = 14
				local var_96_29 = utf8.len(var_96_27)
				local var_96_30 = var_96_28 <= 0 and var_96_24 or var_96_24 * (var_96_29 / var_96_28)

				if var_96_30 > 0 and var_96_24 < var_96_30 then
					arg_93_1.talkMaxDuration = var_96_30

					if var_96_30 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_30 + var_96_23
					end
				end

				arg_93_1.text_.text = var_96_27
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012023", "story_v_out_413012.awb") ~= 0 then
					local var_96_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012023", "story_v_out_413012.awb") / 1000

					if var_96_31 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_31 + var_96_23
					end

					if var_96_26.prefab_name ~= "" and arg_93_1.actors_[var_96_26.prefab_name] ~= nil then
						local var_96_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_26.prefab_name].transform, "story_v_out_413012", "413012023", "story_v_out_413012.awb")

						arg_93_1:RecordAudio("413012023", var_96_32)
						arg_93_1:RecordAudio("413012023", var_96_32)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413012", "413012023", "story_v_out_413012.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413012", "413012023", "story_v_out_413012.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_33 = math.max(var_96_24, arg_93_1.talkMaxDuration)

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_33 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_23) / var_96_33

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_23 + var_96_33 and arg_93_1.time_ < var_96_23 + var_96_33 + arg_96_0 then
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
			local var_100_0 = arg_97_1.actors_["10092"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10092 == nil then
				arg_97_1.var_.actorSpriteComps10092 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10092 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10092 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10092 = nil
			end

			local var_100_8 = arg_97_1.actors_["10022"]
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10022 == nil then
				arg_97_1.var_.actorSpriteComps10022 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_10 = 2

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_10 and not isNil(var_100_8) then
				local var_100_11 = (arg_97_1.time_ - var_100_9) / var_100_10

				if arg_97_1.var_.actorSpriteComps10022 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								local var_100_12 = Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, var_100_11)
								local var_100_13 = Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, var_100_11)
								local var_100_14 = Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, var_100_11)

								iter_100_5.color = Color.New(var_100_12, var_100_13, var_100_14)
							else
								local var_100_15 = Mathf.Lerp(iter_100_5.color.r, 1, var_100_11)

								iter_100_5.color = Color.New(var_100_15, var_100_15, var_100_15)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_9 + var_100_10 and arg_97_1.time_ < var_100_9 + var_100_10 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10022 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_100_7 then
						if arg_97_1.isInRecall_ then
							iter_100_7.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10022 = nil
			end

			local var_100_16 = 0
			local var_100_17 = 0.75

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_18 = arg_97_1:FormatText(StoryNameCfg[614].name)

				arg_97_1.leftNameTxt_.text = var_100_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_19 = arg_97_1:GetWordFromCfg(413012024)
				local var_100_20 = arg_97_1:FormatText(var_100_19.content)

				arg_97_1.text_.text = var_100_20

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_21 = 30
				local var_100_22 = utf8.len(var_100_20)
				local var_100_23 = var_100_21 <= 0 and var_100_17 or var_100_17 * (var_100_22 / var_100_21)

				if var_100_23 > 0 and var_100_17 < var_100_23 then
					arg_97_1.talkMaxDuration = var_100_23

					if var_100_23 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_16
					end
				end

				arg_97_1.text_.text = var_100_20
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012024", "story_v_out_413012.awb") ~= 0 then
					local var_100_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012024", "story_v_out_413012.awb") / 1000

					if var_100_24 + var_100_16 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_24 + var_100_16
					end

					if var_100_19.prefab_name ~= "" and arg_97_1.actors_[var_100_19.prefab_name] ~= nil then
						local var_100_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_19.prefab_name].transform, "story_v_out_413012", "413012024", "story_v_out_413012.awb")

						arg_97_1:RecordAudio("413012024", var_100_25)
						arg_97_1:RecordAudio("413012024", var_100_25)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413012", "413012024", "story_v_out_413012.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413012", "413012024", "story_v_out_413012.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_26 = math.max(var_100_17, arg_97_1.talkMaxDuration)

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_26 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_16) / var_100_26

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_16 + var_100_26 and arg_97_1.time_ < var_100_16 + var_100_26 + arg_100_0 then
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
			local var_104_0 = arg_101_1.actors_["10092"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10092 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10092", 4)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(390, -300, -295)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10092, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_104_7 = arg_101_1.actors_["10092"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10092 == nil then
				arg_101_1.var_.actorSpriteComps10092 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10092 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 1, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10092 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10092 = nil
			end

			local var_104_15 = arg_101_1.actors_["10022"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps10022 == nil then
				arg_101_1.var_.actorSpriteComps10022 = var_104_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_17 = 2

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.actorSpriteComps10022 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								local var_104_19 = Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor2.r, var_104_18)
								local var_104_20 = Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor2.g, var_104_18)
								local var_104_21 = Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor2.b, var_104_18)

								iter_104_6.color = Color.New(var_104_19, var_104_20, var_104_21)
							else
								local var_104_22 = Mathf.Lerp(iter_104_6.color.r, 0.5, var_104_18)

								iter_104_6.color = Color.New(var_104_22, var_104_22, var_104_22)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps10022 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_104_8 then
						if arg_101_1.isInRecall_ then
							iter_104_8.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10022 = nil
			end

			local var_104_23 = 0
			local var_104_24 = 0.375

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[996].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(413012025)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 15
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012025", "story_v_out_413012.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012025", "story_v_out_413012.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_413012", "413012025", "story_v_out_413012.awb")

						arg_101_1:RecordAudio("413012025", var_104_32)
						arg_101_1:RecordAudio("413012025", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413012", "413012025", "story_v_out_413012.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413012", "413012025", "story_v_out_413012.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
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
			local var_108_0 = 0
			local var_108_1 = 0.925

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[996].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:GetWordFromCfg(413012026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 37
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012026", "story_v_out_413012.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012026", "story_v_out_413012.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_413012", "413012026", "story_v_out_413012.awb")

						arg_105_1:RecordAudio("413012026", var_108_9)
						arg_105_1:RecordAudio("413012026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413012", "413012026", "story_v_out_413012.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413012", "413012026", "story_v_out_413012.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
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
			local var_112_0 = arg_109_1.actors_["10022"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 2)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_6" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(-390, -315, -320)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_112_7 = arg_109_1.actors_["10092"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10092 == nil then
				arg_109_1.var_.actorSpriteComps10092 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10092 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor2.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor2.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor2.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 0.5, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10092 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10092 = nil
			end

			local var_112_15 = arg_109_1.actors_["10022"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps10022 == nil then
				arg_109_1.var_.actorSpriteComps10022 = var_112_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_17 = 2

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.actorSpriteComps10022 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								local var_112_19 = Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor1.r, var_112_18)
								local var_112_20 = Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor1.g, var_112_18)
								local var_112_21 = Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor1.b, var_112_18)

								iter_112_6.color = Color.New(var_112_19, var_112_20, var_112_21)
							else
								local var_112_22 = Mathf.Lerp(iter_112_6.color.r, 1, var_112_18)

								iter_112_6.color = Color.New(var_112_22, var_112_22, var_112_22)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps10022 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_112_8 then
						if arg_109_1.isInRecall_ then
							iter_112_8.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10022 = nil
			end

			local var_112_23 = 0
			local var_112_24 = 0.875

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[614].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(413012027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 35
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012027", "story_v_out_413012.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012027", "story_v_out_413012.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_413012", "413012027", "story_v_out_413012.awb")

						arg_109_1:RecordAudio("413012027", var_112_32)
						arg_109_1:RecordAudio("413012027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413012", "413012027", "story_v_out_413012.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413012", "413012027", "story_v_out_413012.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
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
			local var_116_0 = 0
			local var_116_1 = 0.8

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[614].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(413012028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 32
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012028", "story_v_out_413012.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012028", "story_v_out_413012.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_413012", "413012028", "story_v_out_413012.awb")

						arg_113_1:RecordAudio("413012028", var_116_9)
						arg_113_1:RecordAudio("413012028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413012", "413012028", "story_v_out_413012.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413012", "413012028", "story_v_out_413012.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
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
			local var_120_0 = arg_117_1.actors_["10092"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10092 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10092", 4)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_5" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(390, -300, -295)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10092, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_120_7 = arg_117_1.actors_["10092"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10092 == nil then
				arg_117_1.var_.actorSpriteComps10092 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps10092 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10092 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10092 = nil
			end

			local var_120_15 = arg_117_1.actors_["10022"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_17 = 2

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								local var_120_19 = Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, var_120_18)
								local var_120_20 = Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, var_120_18)
								local var_120_21 = Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, var_120_18)

								iter_120_6.color = Color.New(var_120_19, var_120_20, var_120_21)
							else
								local var_120_22 = Mathf.Lerp(iter_120_6.color.r, 0.5, var_120_18)

								iter_120_6.color = Color.New(var_120_22, var_120_22, var_120_22)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_8 then
						if arg_117_1.isInRecall_ then
							iter_120_8.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			local var_120_23 = 0
			local var_120_24 = 0.4

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[996].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(413012029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 16
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012029", "story_v_out_413012.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012029", "story_v_out_413012.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_413012", "413012029", "story_v_out_413012.awb")

						arg_117_1:RecordAudio("413012029", var_120_32)
						arg_117_1:RecordAudio("413012029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413012", "413012029", "story_v_out_413012.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413012", "413012029", "story_v_out_413012.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
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
			local var_124_0 = arg_121_1.actors_["10092"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10092 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10092", 0)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(-1500, -350, -180)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10092, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_124_7 = arg_121_1.actors_["10022"].transform
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.var_.moveOldPos10022 = var_124_7.localPosition
				var_124_7.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10022", 0)

				local var_124_9 = var_124_7.childCount

				for iter_124_1 = 0, var_124_9 - 1 do
					local var_124_10 = var_124_7:GetChild(iter_124_1)

					if var_124_10.name == "" or not string.find(var_124_10.name, "split") then
						var_124_10.gameObject:SetActive(true)
					else
						var_124_10.gameObject:SetActive(false)
					end
				end
			end

			local var_124_11 = 0.001

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_11 then
				local var_124_12 = (arg_121_1.time_ - var_124_8) / var_124_11
				local var_124_13 = Vector3.New(-1500, -350, -180)

				var_124_7.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10022, var_124_13, var_124_12)
			end

			if arg_121_1.time_ >= var_124_8 + var_124_11 and arg_121_1.time_ < var_124_8 + var_124_11 + arg_124_0 then
				var_124_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_124_14 = "10093"

			if arg_121_1.actors_[var_124_14] == nil then
				local var_124_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_124_15) then
					local var_124_16 = Object.Instantiate(var_124_15, arg_121_1.canvasGo_.transform)

					var_124_16.transform:SetSiblingIndex(1)

					var_124_16.name = var_124_14
					var_124_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_121_1.actors_[var_124_14] = var_124_16

					local var_124_17 = var_124_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_121_1.isInRecall_ then
						for iter_124_2, iter_124_3 in ipairs(var_124_17) do
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_124_18 = arg_121_1.actors_["10093"].transform
			local var_124_19 = 0

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 then
				arg_121_1.var_.moveOldPos10093 = var_124_18.localPosition
				var_124_18.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10093", 3)

				local var_124_20 = var_124_18.childCount

				for iter_124_4 = 0, var_124_20 - 1 do
					local var_124_21 = var_124_18:GetChild(iter_124_4)

					if var_124_21.name == "split_3" or not string.find(var_124_21.name, "split") then
						var_124_21.gameObject:SetActive(true)
					else
						var_124_21.gameObject:SetActive(false)
					end
				end
			end

			local var_124_22 = 0.001

			if var_124_19 <= arg_121_1.time_ and arg_121_1.time_ < var_124_19 + var_124_22 then
				local var_124_23 = (arg_121_1.time_ - var_124_19) / var_124_22
				local var_124_24 = Vector3.New(0, -345, -245)

				var_124_18.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10093, var_124_24, var_124_23)
			end

			if arg_121_1.time_ >= var_124_19 + var_124_22 and arg_121_1.time_ < var_124_19 + var_124_22 + arg_124_0 then
				var_124_18.localPosition = Vector3.New(0, -345, -245)
			end

			local var_124_25 = arg_121_1.actors_["10092"]
			local var_124_26 = 0

			if var_124_26 < arg_121_1.time_ and arg_121_1.time_ <= var_124_26 + arg_124_0 and not isNil(var_124_25) and arg_121_1.var_.actorSpriteComps10092 == nil then
				arg_121_1.var_.actorSpriteComps10092 = var_124_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_27 = 2

			if var_124_26 <= arg_121_1.time_ and arg_121_1.time_ < var_124_26 + var_124_27 and not isNil(var_124_25) then
				local var_124_28 = (arg_121_1.time_ - var_124_26) / var_124_27

				if arg_121_1.var_.actorSpriteComps10092 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								local var_124_29 = Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, var_124_28)
								local var_124_30 = Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, var_124_28)
								local var_124_31 = Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, var_124_28)

								iter_124_6.color = Color.New(var_124_29, var_124_30, var_124_31)
							else
								local var_124_32 = Mathf.Lerp(iter_124_6.color.r, 0.5, var_124_28)

								iter_124_6.color = Color.New(var_124_32, var_124_32, var_124_32)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_26 + var_124_27 and arg_121_1.time_ < var_124_26 + var_124_27 + arg_124_0 and not isNil(var_124_25) and arg_121_1.var_.actorSpriteComps10092 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_124_8 then
						if arg_121_1.isInRecall_ then
							iter_124_8.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10092 = nil
			end

			local var_124_33 = arg_121_1.actors_["10022"]
			local var_124_34 = 0

			if var_124_34 < arg_121_1.time_ and arg_121_1.time_ <= var_124_34 + arg_124_0 and not isNil(var_124_33) and arg_121_1.var_.actorSpriteComps10022 == nil then
				arg_121_1.var_.actorSpriteComps10022 = var_124_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_35 = 2

			if var_124_34 <= arg_121_1.time_ and arg_121_1.time_ < var_124_34 + var_124_35 and not isNil(var_124_33) then
				local var_124_36 = (arg_121_1.time_ - var_124_34) / var_124_35

				if arg_121_1.var_.actorSpriteComps10022 then
					for iter_124_9, iter_124_10 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_124_10 then
							if arg_121_1.isInRecall_ then
								local var_124_37 = Mathf.Lerp(iter_124_10.color.r, arg_121_1.hightColor2.r, var_124_36)
								local var_124_38 = Mathf.Lerp(iter_124_10.color.g, arg_121_1.hightColor2.g, var_124_36)
								local var_124_39 = Mathf.Lerp(iter_124_10.color.b, arg_121_1.hightColor2.b, var_124_36)

								iter_124_10.color = Color.New(var_124_37, var_124_38, var_124_39)
							else
								local var_124_40 = Mathf.Lerp(iter_124_10.color.r, 0.5, var_124_36)

								iter_124_10.color = Color.New(var_124_40, var_124_40, var_124_40)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_34 + var_124_35 and arg_121_1.time_ < var_124_34 + var_124_35 + arg_124_0 and not isNil(var_124_33) and arg_121_1.var_.actorSpriteComps10022 then
				for iter_124_11, iter_124_12 in pairs(arg_121_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_124_12 then
						if arg_121_1.isInRecall_ then
							iter_124_12.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10022 = nil
			end

			local var_124_41 = arg_121_1.actors_["10093"]
			local var_124_42 = 0

			if var_124_42 < arg_121_1.time_ and arg_121_1.time_ <= var_124_42 + arg_124_0 and not isNil(var_124_41) and arg_121_1.var_.actorSpriteComps10093 == nil then
				arg_121_1.var_.actorSpriteComps10093 = var_124_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_43 = 2

			if var_124_42 <= arg_121_1.time_ and arg_121_1.time_ < var_124_42 + var_124_43 and not isNil(var_124_41) then
				local var_124_44 = (arg_121_1.time_ - var_124_42) / var_124_43

				if arg_121_1.var_.actorSpriteComps10093 then
					for iter_124_13, iter_124_14 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_124_14 then
							if arg_121_1.isInRecall_ then
								local var_124_45 = Mathf.Lerp(iter_124_14.color.r, arg_121_1.hightColor1.r, var_124_44)
								local var_124_46 = Mathf.Lerp(iter_124_14.color.g, arg_121_1.hightColor1.g, var_124_44)
								local var_124_47 = Mathf.Lerp(iter_124_14.color.b, arg_121_1.hightColor1.b, var_124_44)

								iter_124_14.color = Color.New(var_124_45, var_124_46, var_124_47)
							else
								local var_124_48 = Mathf.Lerp(iter_124_14.color.r, 1, var_124_44)

								iter_124_14.color = Color.New(var_124_48, var_124_48, var_124_48)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_42 + var_124_43 and arg_121_1.time_ < var_124_42 + var_124_43 + arg_124_0 and not isNil(var_124_41) and arg_121_1.var_.actorSpriteComps10093 then
				for iter_124_15, iter_124_16 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_124_16 then
						if arg_121_1.isInRecall_ then
							iter_124_16.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10093 = nil
			end

			local var_124_49 = arg_121_1.actors_["10093"]
			local var_124_50 = 0

			if var_124_50 < arg_121_1.time_ and arg_121_1.time_ <= var_124_50 + arg_124_0 then
				local var_124_51 = var_124_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_51 then
					arg_121_1.var_.alphaOldValue10093 = var_124_51.alpha
					arg_121_1.var_.characterEffect10093 = var_124_51
				end

				arg_121_1.var_.alphaOldValue10093 = 0
			end

			local var_124_52 = 0.3

			if var_124_50 <= arg_121_1.time_ and arg_121_1.time_ < var_124_50 + var_124_52 then
				local var_124_53 = (arg_121_1.time_ - var_124_50) / var_124_52
				local var_124_54 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10093, 1, var_124_53)

				if arg_121_1.var_.characterEffect10093 then
					arg_121_1.var_.characterEffect10093.alpha = var_124_54
				end
			end

			if arg_121_1.time_ >= var_124_50 + var_124_52 and arg_121_1.time_ < var_124_50 + var_124_52 + arg_124_0 and arg_121_1.var_.characterEffect10093 then
				arg_121_1.var_.characterEffect10093.alpha = 1
			end

			local var_124_55 = 0
			local var_124_56 = 0.525

			if var_124_55 < arg_121_1.time_ and arg_121_1.time_ <= var_124_55 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_57 = arg_121_1:FormatText(StoryNameCfg[28].name)

				arg_121_1.leftNameTxt_.text = var_124_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_58 = arg_121_1:GetWordFromCfg(413012030)
				local var_124_59 = arg_121_1:FormatText(var_124_58.content)

				arg_121_1.text_.text = var_124_59

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_60 = 21
				local var_124_61 = utf8.len(var_124_59)
				local var_124_62 = var_124_60 <= 0 and var_124_56 or var_124_56 * (var_124_61 / var_124_60)

				if var_124_62 > 0 and var_124_56 < var_124_62 then
					arg_121_1.talkMaxDuration = var_124_62

					if var_124_62 + var_124_55 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_62 + var_124_55
					end
				end

				arg_121_1.text_.text = var_124_59
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012030", "story_v_out_413012.awb") ~= 0 then
					local var_124_63 = manager.audio:GetVoiceLength("story_v_out_413012", "413012030", "story_v_out_413012.awb") / 1000

					if var_124_63 + var_124_55 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_63 + var_124_55
					end

					if var_124_58.prefab_name ~= "" and arg_121_1.actors_[var_124_58.prefab_name] ~= nil then
						local var_124_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_58.prefab_name].transform, "story_v_out_413012", "413012030", "story_v_out_413012.awb")

						arg_121_1:RecordAudio("413012030", var_124_64)
						arg_121_1:RecordAudio("413012030", var_124_64)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413012", "413012030", "story_v_out_413012.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413012", "413012030", "story_v_out_413012.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_65 = math.max(var_124_56, arg_121_1.talkMaxDuration)

			if var_124_55 <= arg_121_1.time_ and arg_121_1.time_ < var_124_55 + var_124_65 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_55) / var_124_65

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_55 + var_124_65 and arg_121_1.time_ < var_124_55 + var_124_65 + arg_124_0 then
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
			local var_128_0 = arg_125_1.actors_["10092"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10092 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10092", 3)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -300, -295)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10092, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_128_7 = arg_125_1.actors_["10093"].transform
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.var_.moveOldPos10093 = var_128_7.localPosition
				var_128_7.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10093", 0)

				local var_128_9 = var_128_7.childCount

				for iter_128_1 = 0, var_128_9 - 1 do
					local var_128_10 = var_128_7:GetChild(iter_128_1)

					if var_128_10.name == "" or not string.find(var_128_10.name, "split") then
						var_128_10.gameObject:SetActive(true)
					else
						var_128_10.gameObject:SetActive(false)
					end
				end
			end

			local var_128_11 = 0.001

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_11 then
				local var_128_12 = (arg_125_1.time_ - var_128_8) / var_128_11
				local var_128_13 = Vector3.New(0, -5000, 0)

				var_128_7.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10093, var_128_13, var_128_12)
			end

			if arg_125_1.time_ >= var_128_8 + var_128_11 and arg_125_1.time_ < var_128_8 + var_128_11 + arg_128_0 then
				var_128_7.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_128_14 = arg_125_1.actors_["10092"]
			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.actorSpriteComps10092 == nil then
				arg_125_1.var_.actorSpriteComps10092 = var_128_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_16 = 2

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_16 and not isNil(var_128_14) then
				local var_128_17 = (arg_125_1.time_ - var_128_15) / var_128_16

				if arg_125_1.var_.actorSpriteComps10092 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								local var_128_18 = Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor1.r, var_128_17)
								local var_128_19 = Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor1.g, var_128_17)
								local var_128_20 = Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor1.b, var_128_17)

								iter_128_3.color = Color.New(var_128_18, var_128_19, var_128_20)
							else
								local var_128_21 = Mathf.Lerp(iter_128_3.color.r, 1, var_128_17)

								iter_128_3.color = Color.New(var_128_21, var_128_21, var_128_21)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_15 + var_128_16 and arg_125_1.time_ < var_128_15 + var_128_16 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.actorSpriteComps10092 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_128_5 then
						if arg_125_1.isInRecall_ then
							iter_128_5.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10092 = nil
			end

			local var_128_22 = arg_125_1.actors_["10093"]
			local var_128_23 = 0

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 and not isNil(var_128_22) and arg_125_1.var_.actorSpriteComps10093 == nil then
				arg_125_1.var_.actorSpriteComps10093 = var_128_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_24 = 2

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 and not isNil(var_128_22) then
				local var_128_25 = (arg_125_1.time_ - var_128_23) / var_128_24

				if arg_125_1.var_.actorSpriteComps10093 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								local var_128_26 = Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, var_128_25)
								local var_128_27 = Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, var_128_25)
								local var_128_28 = Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, var_128_25)

								iter_128_7.color = Color.New(var_128_26, var_128_27, var_128_28)
							else
								local var_128_29 = Mathf.Lerp(iter_128_7.color.r, 0.5, var_128_25)

								iter_128_7.color = Color.New(var_128_29, var_128_29, var_128_29)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 and not isNil(var_128_22) and arg_125_1.var_.actorSpriteComps10093 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_128_9 then
						if arg_125_1.isInRecall_ then
							iter_128_9.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10093 = nil
			end

			local var_128_30 = 0
			local var_128_31 = 0.3

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[996].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(413012031)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 12
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012031", "story_v_out_413012.awb") ~= 0 then
					local var_128_38 = manager.audio:GetVoiceLength("story_v_out_413012", "413012031", "story_v_out_413012.awb") / 1000

					if var_128_38 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_38 + var_128_30
					end

					if var_128_33.prefab_name ~= "" and arg_125_1.actors_[var_128_33.prefab_name] ~= nil then
						local var_128_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_33.prefab_name].transform, "story_v_out_413012", "413012031", "story_v_out_413012.awb")

						arg_125_1:RecordAudio("413012031", var_128_39)
						arg_125_1:RecordAudio("413012031", var_128_39)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413012", "413012031", "story_v_out_413012.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413012", "413012031", "story_v_out_413012.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_40 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_40 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_40

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_40 and arg_125_1.time_ < var_128_30 + var_128_40 + arg_128_0 then
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
			local var_132_0 = arg_129_1.actors_["10093"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10093 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10093", 3)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -345, -245)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10093, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_132_7 = arg_129_1.actors_["10092"].transform
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.var_.moveOldPos10092 = var_132_7.localPosition
				var_132_7.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10092", 0)

				local var_132_9 = var_132_7.childCount

				for iter_132_1 = 0, var_132_9 - 1 do
					local var_132_10 = var_132_7:GetChild(iter_132_1)

					if var_132_10.name == "" or not string.find(var_132_10.name, "split") then
						var_132_10.gameObject:SetActive(true)
					else
						var_132_10.gameObject:SetActive(false)
					end
				end
			end

			local var_132_11 = 0.001

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_11 then
				local var_132_12 = (arg_129_1.time_ - var_132_8) / var_132_11
				local var_132_13 = Vector3.New(-5000, -345, -245)

				var_132_7.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10092, var_132_13, var_132_12)
			end

			if arg_129_1.time_ >= var_132_8 + var_132_11 and arg_129_1.time_ < var_132_8 + var_132_11 + arg_132_0 then
				var_132_7.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_132_14 = arg_129_1.actors_["10093"]
			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.actorSpriteComps10093 == nil then
				arg_129_1.var_.actorSpriteComps10093 = var_132_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_16 = 2

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_16 and not isNil(var_132_14) then
				local var_132_17 = (arg_129_1.time_ - var_132_15) / var_132_16

				if arg_129_1.var_.actorSpriteComps10093 then
					for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_132_3 then
							if arg_129_1.isInRecall_ then
								local var_132_18 = Mathf.Lerp(iter_132_3.color.r, arg_129_1.hightColor1.r, var_132_17)
								local var_132_19 = Mathf.Lerp(iter_132_3.color.g, arg_129_1.hightColor1.g, var_132_17)
								local var_132_20 = Mathf.Lerp(iter_132_3.color.b, arg_129_1.hightColor1.b, var_132_17)

								iter_132_3.color = Color.New(var_132_18, var_132_19, var_132_20)
							else
								local var_132_21 = Mathf.Lerp(iter_132_3.color.r, 1, var_132_17)

								iter_132_3.color = Color.New(var_132_21, var_132_21, var_132_21)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_15 + var_132_16 and arg_129_1.time_ < var_132_15 + var_132_16 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.actorSpriteComps10093 then
				for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_132_5 then
						if arg_129_1.isInRecall_ then
							iter_132_5.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10093 = nil
			end

			local var_132_22 = arg_129_1.actors_["10092"]
			local var_132_23 = 0

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.actorSpriteComps10092 == nil then
				arg_129_1.var_.actorSpriteComps10092 = var_132_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_24 = 2

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_24 and not isNil(var_132_22) then
				local var_132_25 = (arg_129_1.time_ - var_132_23) / var_132_24

				if arg_129_1.var_.actorSpriteComps10092 then
					for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_132_7 then
							if arg_129_1.isInRecall_ then
								local var_132_26 = Mathf.Lerp(iter_132_7.color.r, arg_129_1.hightColor2.r, var_132_25)
								local var_132_27 = Mathf.Lerp(iter_132_7.color.g, arg_129_1.hightColor2.g, var_132_25)
								local var_132_28 = Mathf.Lerp(iter_132_7.color.b, arg_129_1.hightColor2.b, var_132_25)

								iter_132_7.color = Color.New(var_132_26, var_132_27, var_132_28)
							else
								local var_132_29 = Mathf.Lerp(iter_132_7.color.r, 0.5, var_132_25)

								iter_132_7.color = Color.New(var_132_29, var_132_29, var_132_29)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_23 + var_132_24 and arg_129_1.time_ < var_132_23 + var_132_24 + arg_132_0 and not isNil(var_132_22) and arg_129_1.var_.actorSpriteComps10092 then
				for iter_132_8, iter_132_9 in pairs(arg_129_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_132_9 then
						if arg_129_1.isInRecall_ then
							iter_132_9.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10092 = nil
			end

			local var_132_30 = 0
			local var_132_31 = 0.4

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_32 = arg_129_1:FormatText(StoryNameCfg[28].name)

				arg_129_1.leftNameTxt_.text = var_132_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_33 = arg_129_1:GetWordFromCfg(413012032)
				local var_132_34 = arg_129_1:FormatText(var_132_33.content)

				arg_129_1.text_.text = var_132_34

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_35 = 16
				local var_132_36 = utf8.len(var_132_34)
				local var_132_37 = var_132_35 <= 0 and var_132_31 or var_132_31 * (var_132_36 / var_132_35)

				if var_132_37 > 0 and var_132_31 < var_132_37 then
					arg_129_1.talkMaxDuration = var_132_37

					if var_132_37 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_37 + var_132_30
					end
				end

				arg_129_1.text_.text = var_132_34
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012032", "story_v_out_413012.awb") ~= 0 then
					local var_132_38 = manager.audio:GetVoiceLength("story_v_out_413012", "413012032", "story_v_out_413012.awb") / 1000

					if var_132_38 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_38 + var_132_30
					end

					if var_132_33.prefab_name ~= "" and arg_129_1.actors_[var_132_33.prefab_name] ~= nil then
						local var_132_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_33.prefab_name].transform, "story_v_out_413012", "413012032", "story_v_out_413012.awb")

						arg_129_1:RecordAudio("413012032", var_132_39)
						arg_129_1:RecordAudio("413012032", var_132_39)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413012", "413012032", "story_v_out_413012.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413012", "413012032", "story_v_out_413012.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_40 = math.max(var_132_31, arg_129_1.talkMaxDuration)

			if var_132_30 <= arg_129_1.time_ and arg_129_1.time_ < var_132_30 + var_132_40 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_30) / var_132_40

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_30 + var_132_40 and arg_129_1.time_ < var_132_30 + var_132_40 + arg_132_0 then
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
			local var_136_0 = "F10g"

			if arg_133_1.bgs_[var_136_0] == nil then
				local var_136_1 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_136_0)
				var_136_1.name = var_136_0
				var_136_1.transform.parent = arg_133_1.stage_.transform
				var_136_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_[var_136_0] = var_136_1
			end

			local var_136_2 = 1.98333333333333

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				local var_136_3 = manager.ui.mainCamera.transform.localPosition
				local var_136_4 = Vector3.New(0, 0, 10) + Vector3.New(var_136_3.x, var_136_3.y, 0)
				local var_136_5 = arg_133_1.bgs_.F10g

				var_136_5.transform.localPosition = var_136_4
				var_136_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_6 = var_136_5:GetComponent("SpriteRenderer")

				if var_136_6 and var_136_6.sprite then
					local var_136_7 = (var_136_5.transform.localPosition - var_136_3).z
					local var_136_8 = manager.ui.mainCameraCom_
					local var_136_9 = 2 * var_136_7 * Mathf.Tan(var_136_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_10 = var_136_9 * var_136_8.aspect
					local var_136_11 = var_136_6.sprite.bounds.size.x
					local var_136_12 = var_136_6.sprite.bounds.size.y
					local var_136_13 = var_136_10 / var_136_11
					local var_136_14 = var_136_9 / var_136_12
					local var_136_15 = var_136_14 < var_136_13 and var_136_13 or var_136_14

					var_136_5.transform.localScale = Vector3.New(var_136_15, var_136_15, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "F10g" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_16 = 4

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			local var_136_17 = 0.3

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_19 = 2

			if var_136_18 <= arg_133_1.time_ and arg_133_1.time_ < var_136_18 + var_136_19 then
				local var_136_20 = (arg_133_1.time_ - var_136_18) / var_136_19
				local var_136_21 = Color.New(0, 0, 0)

				var_136_21.a = Mathf.Lerp(0, 1, var_136_20)
				arg_133_1.mask_.color = var_136_21
			end

			if arg_133_1.time_ >= var_136_18 + var_136_19 and arg_133_1.time_ < var_136_18 + var_136_19 + arg_136_0 then
				local var_136_22 = Color.New(0, 0, 0)

				var_136_22.a = 1
				arg_133_1.mask_.color = var_136_22
			end

			local var_136_23 = 2

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_24 = 2

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_24 then
				local var_136_25 = (arg_133_1.time_ - var_136_23) / var_136_24
				local var_136_26 = Color.New(0, 0, 0)

				var_136_26.a = Mathf.Lerp(1, 0, var_136_25)
				arg_133_1.mask_.color = var_136_26
			end

			if arg_133_1.time_ >= var_136_23 + var_136_24 and arg_133_1.time_ < var_136_23 + var_136_24 + arg_136_0 then
				local var_136_27 = Color.New(0, 0, 0)
				local var_136_28 = 0

				arg_133_1.mask_.enabled = false
				var_136_27.a = var_136_28
				arg_133_1.mask_.color = var_136_27
			end

			local var_136_29 = arg_133_1.actors_["10093"].transform
			local var_136_30 = 1.966

			if var_136_30 < arg_133_1.time_ and arg_133_1.time_ <= var_136_30 + arg_136_0 then
				arg_133_1.var_.moveOldPos10093 = var_136_29.localPosition
				var_136_29.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10093", 7)

				local var_136_31 = var_136_29.childCount

				for iter_136_2 = 0, var_136_31 - 1 do
					local var_136_32 = var_136_29:GetChild(iter_136_2)

					if var_136_32.name == "" or not string.find(var_136_32.name, "split") then
						var_136_32.gameObject:SetActive(true)
					else
						var_136_32.gameObject:SetActive(false)
					end
				end
			end

			local var_136_33 = 0.001

			if var_136_30 <= arg_133_1.time_ and arg_133_1.time_ < var_136_30 + var_136_33 then
				local var_136_34 = (arg_133_1.time_ - var_136_30) / var_136_33
				local var_136_35 = Vector3.New(0, -2000, -180)

				var_136_29.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10093, var_136_35, var_136_34)
			end

			if arg_133_1.time_ >= var_136_30 + var_136_33 and arg_133_1.time_ < var_136_30 + var_136_33 + arg_136_0 then
				var_136_29.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_136_36 = arg_133_1.bgs_.F10g.transform
			local var_136_37 = 2

			if var_136_37 < arg_133_1.time_ and arg_133_1.time_ <= var_136_37 + arg_136_0 then
				arg_133_1.var_.moveOldPosF10g = var_136_36.localPosition
			end

			local var_136_38 = 2

			if var_136_37 <= arg_133_1.time_ and arg_133_1.time_ < var_136_37 + var_136_38 then
				local var_136_39 = (arg_133_1.time_ - var_136_37) / var_136_38
				local var_136_40 = Vector3.New(0, 1, 9.5)

				var_136_36.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosF10g, var_136_40, var_136_39)
			end

			if arg_133_1.time_ >= var_136_37 + var_136_38 and arg_133_1.time_ < var_136_37 + var_136_38 + arg_136_0 then
				var_136_36.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_41 = 4
			local var_136_42 = 1

			if var_136_41 < arg_133_1.time_ and arg_133_1.time_ <= var_136_41 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_43 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_43:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_44 = arg_133_1:GetWordFromCfg(413012033)
				local var_136_45 = arg_133_1:FormatText(var_136_44.content)

				arg_133_1.text_.text = var_136_45

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_46 = 40
				local var_136_47 = utf8.len(var_136_45)
				local var_136_48 = var_136_46 <= 0 and var_136_42 or var_136_42 * (var_136_47 / var_136_46)

				if var_136_48 > 0 and var_136_42 < var_136_48 then
					arg_133_1.talkMaxDuration = var_136_48
					var_136_41 = var_136_41 + 0.3

					if var_136_48 + var_136_41 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_48 + var_136_41
					end
				end

				arg_133_1.text_.text = var_136_45
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_49 = var_136_41 + 0.3
			local var_136_50 = math.max(var_136_42, arg_133_1.talkMaxDuration)

			if var_136_49 <= arg_133_1.time_ and arg_133_1.time_ < var_136_49 + var_136_50 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_49) / var_136_50

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_49 + var_136_50 and arg_133_1.time_ < var_136_49 + var_136_50 + arg_136_0 then
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
			local var_142_0 = arg_139_1.actors_["10022"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10022 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10022", 2)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "split_8" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(-390, -315, -320)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10022, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_142_7 = arg_139_1.actors_["10022"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 2

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 1, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			local var_142_15 = arg_139_1.actors_["10022"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				local var_142_17 = var_142_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_142_17 then
					arg_139_1.var_.alphaOldValue10022 = var_142_17.alpha
					arg_139_1.var_.characterEffect10022 = var_142_17
				end

				arg_139_1.var_.alphaOldValue10022 = 0
			end

			local var_142_18 = 0.2

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_18 then
				local var_142_19 = (arg_139_1.time_ - var_142_16) / var_142_18
				local var_142_20 = Mathf.Lerp(arg_139_1.var_.alphaOldValue10022, 1, var_142_19)

				if arg_139_1.var_.characterEffect10022 then
					arg_139_1.var_.characterEffect10022.alpha = var_142_20
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_18 and arg_139_1.time_ < var_142_16 + var_142_18 + arg_142_0 and arg_139_1.var_.characterEffect10022 then
				arg_139_1.var_.characterEffect10022.alpha = 1
			end

			local var_142_21 = 0
			local var_142_22 = 0.75

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_23 = arg_139_1:FormatText(StoryNameCfg[614].name)

				arg_139_1.leftNameTxt_.text = var_142_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_24 = arg_139_1:GetWordFromCfg(413012034)
				local var_142_25 = arg_139_1:FormatText(var_142_24.content)

				arg_139_1.text_.text = var_142_25

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_26 = 30
				local var_142_27 = utf8.len(var_142_25)
				local var_142_28 = var_142_26 <= 0 and var_142_22 or var_142_22 * (var_142_27 / var_142_26)

				if var_142_28 > 0 and var_142_22 < var_142_28 then
					arg_139_1.talkMaxDuration = var_142_28

					if var_142_28 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_21
					end
				end

				arg_139_1.text_.text = var_142_25
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012034", "story_v_out_413012.awb") ~= 0 then
					local var_142_29 = manager.audio:GetVoiceLength("story_v_out_413012", "413012034", "story_v_out_413012.awb") / 1000

					if var_142_29 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_29 + var_142_21
					end

					if var_142_24.prefab_name ~= "" and arg_139_1.actors_[var_142_24.prefab_name] ~= nil then
						local var_142_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_24.prefab_name].transform, "story_v_out_413012", "413012034", "story_v_out_413012.awb")

						arg_139_1:RecordAudio("413012034", var_142_30)
						arg_139_1:RecordAudio("413012034", var_142_30)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413012", "413012034", "story_v_out_413012.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413012", "413012034", "story_v_out_413012.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_31 = math.max(var_142_22, arg_139_1.talkMaxDuration)

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_31 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_21) / var_142_31

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_21 + var_142_31 and arg_139_1.time_ < var_142_21 + var_142_31 + arg_142_0 then
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
			local var_146_0 = arg_143_1.actors_["10092"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10092 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10092", 4)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_8" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(390, -300, -295)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10092, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_146_7 = arg_143_1.actors_["10092"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps10092 == nil then
				arg_143_1.var_.actorSpriteComps10092 = var_146_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 2

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.actorSpriteComps10092 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								local var_146_11 = Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, var_146_10)
								local var_146_12 = Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, var_146_10)
								local var_146_13 = Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, var_146_10)

								iter_146_2.color = Color.New(var_146_11, var_146_12, var_146_13)
							else
								local var_146_14 = Mathf.Lerp(iter_146_2.color.r, 1, var_146_10)

								iter_146_2.color = Color.New(var_146_14, var_146_14, var_146_14)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps10092 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_146_4 then
						if arg_143_1.isInRecall_ then
							iter_146_4.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10092 = nil
			end

			local var_146_15 = arg_143_1.actors_["10022"]
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.actorSpriteComps10022 == nil then
				arg_143_1.var_.actorSpriteComps10022 = var_146_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_17 = 2

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 and not isNil(var_146_15) then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17

				if arg_143_1.var_.actorSpriteComps10022 then
					for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_146_6 then
							if arg_143_1.isInRecall_ then
								local var_146_19 = Mathf.Lerp(iter_146_6.color.r, arg_143_1.hightColor2.r, var_146_18)
								local var_146_20 = Mathf.Lerp(iter_146_6.color.g, arg_143_1.hightColor2.g, var_146_18)
								local var_146_21 = Mathf.Lerp(iter_146_6.color.b, arg_143_1.hightColor2.b, var_146_18)

								iter_146_6.color = Color.New(var_146_19, var_146_20, var_146_21)
							else
								local var_146_22 = Mathf.Lerp(iter_146_6.color.r, 0.5, var_146_18)

								iter_146_6.color = Color.New(var_146_22, var_146_22, var_146_22)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.actorSpriteComps10022 then
				for iter_146_7, iter_146_8 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_146_8 then
						if arg_143_1.isInRecall_ then
							iter_146_8.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10022 = nil
			end

			local var_146_23 = 0
			local var_146_24 = 0.95

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_25 = arg_143_1:FormatText(StoryNameCfg[996].name)

				arg_143_1.leftNameTxt_.text = var_146_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_26 = arg_143_1:GetWordFromCfg(413012035)
				local var_146_27 = arg_143_1:FormatText(var_146_26.content)

				arg_143_1.text_.text = var_146_27

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_28 = 38
				local var_146_29 = utf8.len(var_146_27)
				local var_146_30 = var_146_28 <= 0 and var_146_24 or var_146_24 * (var_146_29 / var_146_28)

				if var_146_30 > 0 and var_146_24 < var_146_30 then
					arg_143_1.talkMaxDuration = var_146_30

					if var_146_30 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_30 + var_146_23
					end
				end

				arg_143_1.text_.text = var_146_27
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012035", "story_v_out_413012.awb") ~= 0 then
					local var_146_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012035", "story_v_out_413012.awb") / 1000

					if var_146_31 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_31 + var_146_23
					end

					if var_146_26.prefab_name ~= "" and arg_143_1.actors_[var_146_26.prefab_name] ~= nil then
						local var_146_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_26.prefab_name].transform, "story_v_out_413012", "413012035", "story_v_out_413012.awb")

						arg_143_1:RecordAudio("413012035", var_146_32)
						arg_143_1:RecordAudio("413012035", var_146_32)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413012", "413012035", "story_v_out_413012.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413012", "413012035", "story_v_out_413012.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_33 = math.max(var_146_24, arg_143_1.talkMaxDuration)

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_33 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_23) / var_146_33

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_23 + var_146_33 and arg_143_1.time_ < var_146_23 + var_146_33 + arg_146_0 then
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
			local var_150_0 = 0
			local var_150_1 = 0.75

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[996].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(413012036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 30
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012036", "story_v_out_413012.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012036", "story_v_out_413012.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_413012", "413012036", "story_v_out_413012.awb")

						arg_147_1:RecordAudio("413012036", var_150_9)
						arg_147_1:RecordAudio("413012036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413012", "413012036", "story_v_out_413012.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413012", "413012036", "story_v_out_413012.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
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
			local var_154_0 = arg_151_1.actors_["10092"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10092 == nil then
				arg_151_1.var_.actorSpriteComps10092 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10092 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10092 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10092 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.85

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[998].name)

				arg_151_1.leftNameTxt_.text = var_154_10

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

				local var_154_11 = arg_151_1:GetWordFromCfg(413012037)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 34
				local var_154_14 = utf8.len(var_154_12)
				local var_154_15 = var_154_13 <= 0 and var_154_9 or var_154_9 * (var_154_14 / var_154_13)

				if var_154_15 > 0 and var_154_9 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_12
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012037", "story_v_out_413012.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012037", "story_v_out_413012.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_413012", "413012037", "story_v_out_413012.awb")

						arg_151_1:RecordAudio("413012037", var_154_17)
						arg_151_1:RecordAudio("413012037", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413012", "413012037", "story_v_out_413012.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413012", "413012037", "story_v_out_413012.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_18 and arg_151_1.time_ < var_154_8 + var_154_18 + arg_154_0 then
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
			local var_158_0 = arg_155_1.actors_["10022"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 1, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_8 = 0
			local var_158_9 = 0.525

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_10 = arg_155_1:FormatText(StoryNameCfg[614].name)

				arg_155_1.leftNameTxt_.text = var_158_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_11 = arg_155_1:GetWordFromCfg(413012038)
				local var_158_12 = arg_155_1:FormatText(var_158_11.content)

				arg_155_1.text_.text = var_158_12

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 21
				local var_158_14 = utf8.len(var_158_12)
				local var_158_15 = var_158_13 <= 0 and var_158_9 or var_158_9 * (var_158_14 / var_158_13)

				if var_158_15 > 0 and var_158_9 < var_158_15 then
					arg_155_1.talkMaxDuration = var_158_15

					if var_158_15 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_15 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_12
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012038", "story_v_out_413012.awb") ~= 0 then
					local var_158_16 = manager.audio:GetVoiceLength("story_v_out_413012", "413012038", "story_v_out_413012.awb") / 1000

					if var_158_16 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_8
					end

					if var_158_11.prefab_name ~= "" and arg_155_1.actors_[var_158_11.prefab_name] ~= nil then
						local var_158_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_11.prefab_name].transform, "story_v_out_413012", "413012038", "story_v_out_413012.awb")

						arg_155_1:RecordAudio("413012038", var_158_17)
						arg_155_1:RecordAudio("413012038", var_158_17)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413012", "413012038", "story_v_out_413012.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413012", "413012038", "story_v_out_413012.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_18 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_18 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_18

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_18 and arg_155_1.time_ < var_158_8 + var_158_18 + arg_158_0 then
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
			local var_162_0 = arg_159_1.actors_["10092"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10092 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10092", 4)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "split_1_1" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(390, -300, -295)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10092, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_162_7 = arg_159_1.actors_["10092"]
			local var_162_8 = 0

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10092 == nil then
				arg_159_1.var_.actorSpriteComps10092 = var_162_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_9 = 2

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_9 and not isNil(var_162_7) then
				local var_162_10 = (arg_159_1.time_ - var_162_8) / var_162_9

				if arg_159_1.var_.actorSpriteComps10092 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								local var_162_11 = Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, var_162_10)
								local var_162_12 = Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, var_162_10)
								local var_162_13 = Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, var_162_10)

								iter_162_2.color = Color.New(var_162_11, var_162_12, var_162_13)
							else
								local var_162_14 = Mathf.Lerp(iter_162_2.color.r, 1, var_162_10)

								iter_162_2.color = Color.New(var_162_14, var_162_14, var_162_14)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_8 + var_162_9 and arg_159_1.time_ < var_162_8 + var_162_9 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10092 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_162_4 then
						if arg_159_1.isInRecall_ then
							iter_162_4.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10092 = nil
			end

			local var_162_15 = arg_159_1.actors_["10022"]
			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_17 = 2

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 and not isNil(var_162_15) then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17

				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								local var_162_19 = Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, var_162_18)
								local var_162_20 = Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, var_162_18)
								local var_162_21 = Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, var_162_18)

								iter_162_6.color = Color.New(var_162_19, var_162_20, var_162_21)
							else
								local var_162_22 = Mathf.Lerp(iter_162_6.color.r, 0.5, var_162_18)

								iter_162_6.color = Color.New(var_162_22, var_162_22, var_162_22)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_8 then
						if arg_159_1.isInRecall_ then
							iter_162_8.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_23 = 0
			local var_162_24 = 1

			if var_162_23 < arg_159_1.time_ and arg_159_1.time_ <= var_162_23 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_25 = arg_159_1:FormatText(StoryNameCfg[996].name)

				arg_159_1.leftNameTxt_.text = var_162_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_26 = arg_159_1:GetWordFromCfg(413012039)
				local var_162_27 = arg_159_1:FormatText(var_162_26.content)

				arg_159_1.text_.text = var_162_27

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_28 = 40
				local var_162_29 = utf8.len(var_162_27)
				local var_162_30 = var_162_28 <= 0 and var_162_24 or var_162_24 * (var_162_29 / var_162_28)

				if var_162_30 > 0 and var_162_24 < var_162_30 then
					arg_159_1.talkMaxDuration = var_162_30

					if var_162_30 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_30 + var_162_23
					end
				end

				arg_159_1.text_.text = var_162_27
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012039", "story_v_out_413012.awb") ~= 0 then
					local var_162_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012039", "story_v_out_413012.awb") / 1000

					if var_162_31 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_31 + var_162_23
					end

					if var_162_26.prefab_name ~= "" and arg_159_1.actors_[var_162_26.prefab_name] ~= nil then
						local var_162_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_26.prefab_name].transform, "story_v_out_413012", "413012039", "story_v_out_413012.awb")

						arg_159_1:RecordAudio("413012039", var_162_32)
						arg_159_1:RecordAudio("413012039", var_162_32)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413012", "413012039", "story_v_out_413012.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413012", "413012039", "story_v_out_413012.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_33 = math.max(var_162_24, arg_159_1.talkMaxDuration)

			if var_162_23 <= arg_159_1.time_ and arg_159_1.time_ < var_162_23 + var_162_33 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_23) / var_162_33

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_23 + var_162_33 and arg_159_1.time_ < var_162_23 + var_162_33 + arg_162_0 then
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
			local var_166_0 = arg_163_1.actors_["10022"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 2)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_8" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(-390, -315, -320)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_166_7 = arg_163_1.actors_["10022"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_15 = arg_163_1.actors_["10092"]
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps10092 == nil then
				arg_163_1.var_.actorSpriteComps10092 = var_166_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_17 = 2

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 and not isNil(var_166_15) then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17

				if arg_163_1.var_.actorSpriteComps10092 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								local var_166_19 = Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor2.r, var_166_18)
								local var_166_20 = Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor2.g, var_166_18)
								local var_166_21 = Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor2.b, var_166_18)

								iter_166_6.color = Color.New(var_166_19, var_166_20, var_166_21)
							else
								local var_166_22 = Mathf.Lerp(iter_166_6.color.r, 0.5, var_166_18)

								iter_166_6.color = Color.New(var_166_22, var_166_22, var_166_22)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps10092 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_166_8 then
						if arg_163_1.isInRecall_ then
							iter_166_8.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10092 = nil
			end

			local var_166_23 = 0
			local var_166_24 = 0.4

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_25 = arg_163_1:FormatText(StoryNameCfg[614].name)

				arg_163_1.leftNameTxt_.text = var_166_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_26 = arg_163_1:GetWordFromCfg(413012040)
				local var_166_27 = arg_163_1:FormatText(var_166_26.content)

				arg_163_1.text_.text = var_166_27

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_28 = 16
				local var_166_29 = utf8.len(var_166_27)
				local var_166_30 = var_166_28 <= 0 and var_166_24 or var_166_24 * (var_166_29 / var_166_28)

				if var_166_30 > 0 and var_166_24 < var_166_30 then
					arg_163_1.talkMaxDuration = var_166_30

					if var_166_30 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_30 + var_166_23
					end
				end

				arg_163_1.text_.text = var_166_27
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012040", "story_v_out_413012.awb") ~= 0 then
					local var_166_31 = manager.audio:GetVoiceLength("story_v_out_413012", "413012040", "story_v_out_413012.awb") / 1000

					if var_166_31 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_23
					end

					if var_166_26.prefab_name ~= "" and arg_163_1.actors_[var_166_26.prefab_name] ~= nil then
						local var_166_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_26.prefab_name].transform, "story_v_out_413012", "413012040", "story_v_out_413012.awb")

						arg_163_1:RecordAudio("413012040", var_166_32)
						arg_163_1:RecordAudio("413012040", var_166_32)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413012", "413012040", "story_v_out_413012.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413012", "413012040", "story_v_out_413012.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_33 = math.max(var_166_24, arg_163_1.talkMaxDuration)

			if var_166_23 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_33 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_23) / var_166_33

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_23 + var_166_33 and arg_163_1.time_ < var_166_23 + var_166_33 + arg_166_0 then
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
			local var_170_0 = arg_167_1.actors_["10092"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 1, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_8 = arg_167_1.actors_["10022"]
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_10 = 2

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_10 and not isNil(var_170_8) then
				local var_170_11 = (arg_167_1.time_ - var_170_9) / var_170_10

				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_170_5 then
							if arg_167_1.isInRecall_ then
								local var_170_12 = Mathf.Lerp(iter_170_5.color.r, arg_167_1.hightColor2.r, var_170_11)
								local var_170_13 = Mathf.Lerp(iter_170_5.color.g, arg_167_1.hightColor2.g, var_170_11)
								local var_170_14 = Mathf.Lerp(iter_170_5.color.b, arg_167_1.hightColor2.b, var_170_11)

								iter_170_5.color = Color.New(var_170_12, var_170_13, var_170_14)
							else
								local var_170_15 = Mathf.Lerp(iter_170_5.color.r, 0.5, var_170_11)

								iter_170_5.color = Color.New(var_170_15, var_170_15, var_170_15)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_9 + var_170_10 and arg_167_1.time_ < var_170_9 + var_170_10 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_7 then
						if arg_167_1.isInRecall_ then
							iter_170_7.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_16 = 0
			local var_170_17 = 0.325

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_18 = arg_167_1:FormatText(StoryNameCfg[996].name)

				arg_167_1.leftNameTxt_.text = var_170_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_19 = arg_167_1:GetWordFromCfg(413012041)
				local var_170_20 = arg_167_1:FormatText(var_170_19.content)

				arg_167_1.text_.text = var_170_20

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_21 = 13
				local var_170_22 = utf8.len(var_170_20)
				local var_170_23 = var_170_21 <= 0 and var_170_17 or var_170_17 * (var_170_22 / var_170_21)

				if var_170_23 > 0 and var_170_17 < var_170_23 then
					arg_167_1.talkMaxDuration = var_170_23

					if var_170_23 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_23 + var_170_16
					end
				end

				arg_167_1.text_.text = var_170_20
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012041", "story_v_out_413012.awb") ~= 0 then
					local var_170_24 = manager.audio:GetVoiceLength("story_v_out_413012", "413012041", "story_v_out_413012.awb") / 1000

					if var_170_24 + var_170_16 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_24 + var_170_16
					end

					if var_170_19.prefab_name ~= "" and arg_167_1.actors_[var_170_19.prefab_name] ~= nil then
						local var_170_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_19.prefab_name].transform, "story_v_out_413012", "413012041", "story_v_out_413012.awb")

						arg_167_1:RecordAudio("413012041", var_170_25)
						arg_167_1:RecordAudio("413012041", var_170_25)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413012", "413012041", "story_v_out_413012.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413012", "413012041", "story_v_out_413012.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_26 = math.max(var_170_17, arg_167_1.talkMaxDuration)

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_26 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_16) / var_170_26

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_16 + var_170_26 and arg_167_1.time_ < var_170_16 + var_170_26 + arg_170_0 then
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
			local var_174_0 = "SS1301"

			if arg_171_1.bgs_[var_174_0] == nil then
				local var_174_1 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_0)
				var_174_1.name = var_174_0
				var_174_1.transform.parent = arg_171_1.stage_.transform
				var_174_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_0] = var_174_1
			end

			local var_174_2 = 1.98333333333333

			if var_174_2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				local var_174_3 = manager.ui.mainCamera.transform.localPosition
				local var_174_4 = Vector3.New(0, 0, 10) + Vector3.New(var_174_3.x, var_174_3.y, 0)
				local var_174_5 = arg_171_1.bgs_.SS1301

				var_174_5.transform.localPosition = var_174_4
				var_174_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_6 = var_174_5:GetComponent("SpriteRenderer")

				if var_174_6 and var_174_6.sprite then
					local var_174_7 = (var_174_5.transform.localPosition - var_174_3).z
					local var_174_8 = manager.ui.mainCameraCom_
					local var_174_9 = 2 * var_174_7 * Mathf.Tan(var_174_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_10 = var_174_9 * var_174_8.aspect
					local var_174_11 = var_174_6.sprite.bounds.size.x
					local var_174_12 = var_174_6.sprite.bounds.size.y
					local var_174_13 = var_174_10 / var_174_11
					local var_174_14 = var_174_9 / var_174_12
					local var_174_15 = var_174_14 < var_174_13 and var_174_13 or var_174_14

					var_174_5.transform.localScale = Vector3.New(var_174_15, var_174_15, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "SS1301" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_16 = 4

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_17 = 0.3

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_18 = 0

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_19 = 2

			if var_174_18 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				local var_174_20 = (arg_171_1.time_ - var_174_18) / var_174_19
				local var_174_21 = Color.New(0, 0, 0)

				var_174_21.a = Mathf.Lerp(0, 1, var_174_20)
				arg_171_1.mask_.color = var_174_21
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				local var_174_22 = Color.New(0, 0, 0)

				var_174_22.a = 1
				arg_171_1.mask_.color = var_174_22
			end

			local var_174_23 = 2

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_24 = 2

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24
				local var_174_26 = Color.New(0, 0, 0)

				var_174_26.a = Mathf.Lerp(1, 0, var_174_25)
				arg_171_1.mask_.color = var_174_26
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 then
				local var_174_27 = Color.New(0, 0, 0)
				local var_174_28 = 0

				arg_171_1.mask_.enabled = false
				var_174_27.a = var_174_28
				arg_171_1.mask_.color = var_174_27
			end

			local var_174_29 = arg_171_1.actors_["10092"].transform
			local var_174_30 = 1.966

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = var_174_29.localPosition
				var_174_29.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 0)

				local var_174_31 = var_174_29.childCount

				for iter_174_2 = 0, var_174_31 - 1 do
					local var_174_32 = var_174_29:GetChild(iter_174_2)

					if var_174_32.name == "" or not string.find(var_174_32.name, "split") then
						var_174_32.gameObject:SetActive(true)
					else
						var_174_32.gameObject:SetActive(false)
					end
				end
			end

			local var_174_33 = 0.001

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_33 then
				local var_174_34 = (arg_171_1.time_ - var_174_30) / var_174_33
				local var_174_35 = Vector3.New(-1500, -350, -180)

				var_174_29.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, var_174_35, var_174_34)
			end

			if arg_171_1.time_ >= var_174_30 + var_174_33 and arg_171_1.time_ < var_174_30 + var_174_33 + arg_174_0 then
				var_174_29.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_174_36 = arg_171_1.actors_["10022"].transform
			local var_174_37 = 1.966

			if var_174_37 < arg_171_1.time_ and arg_171_1.time_ <= var_174_37 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = var_174_36.localPosition
				var_174_36.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 0)

				local var_174_38 = var_174_36.childCount

				for iter_174_3 = 0, var_174_38 - 1 do
					local var_174_39 = var_174_36:GetChild(iter_174_3)

					if var_174_39.name == "" or not string.find(var_174_39.name, "split") then
						var_174_39.gameObject:SetActive(true)
					else
						var_174_39.gameObject:SetActive(false)
					end
				end
			end

			local var_174_40 = 0.001

			if var_174_37 <= arg_171_1.time_ and arg_171_1.time_ < var_174_37 + var_174_40 then
				local var_174_41 = (arg_171_1.time_ - var_174_37) / var_174_40
				local var_174_42 = Vector3.New(-1500, -350, -180)

				var_174_36.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, var_174_42, var_174_41)
			end

			if arg_171_1.time_ >= var_174_37 + var_174_40 and arg_171_1.time_ < var_174_37 + var_174_40 + arg_174_0 then
				var_174_36.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_174_43 = arg_171_1.actors_["10092"]
			local var_174_44 = 1.966

			if var_174_44 < arg_171_1.time_ and arg_171_1.time_ <= var_174_44 + arg_174_0 and not isNil(var_174_43) and arg_171_1.var_.actorSpriteComps10092 == nil then
				arg_171_1.var_.actorSpriteComps10092 = var_174_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_45 = 0.034

			if var_174_44 <= arg_171_1.time_ and arg_171_1.time_ < var_174_44 + var_174_45 and not isNil(var_174_43) then
				local var_174_46 = (arg_171_1.time_ - var_174_44) / var_174_45

				if arg_171_1.var_.actorSpriteComps10092 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								local var_174_47 = Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor2.r, var_174_46)
								local var_174_48 = Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor2.g, var_174_46)
								local var_174_49 = Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor2.b, var_174_46)

								iter_174_5.color = Color.New(var_174_47, var_174_48, var_174_49)
							else
								local var_174_50 = Mathf.Lerp(iter_174_5.color.r, 0.5, var_174_46)

								iter_174_5.color = Color.New(var_174_50, var_174_50, var_174_50)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_44 + var_174_45 and arg_171_1.time_ < var_174_44 + var_174_45 + arg_174_0 and not isNil(var_174_43) and arg_171_1.var_.actorSpriteComps10092 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10092 = nil
			end

			local var_174_51 = arg_171_1.actors_["10022"]
			local var_174_52 = 1.966

			if var_174_52 < arg_171_1.time_ and arg_171_1.time_ <= var_174_52 + arg_174_0 and not isNil(var_174_51) and arg_171_1.var_.actorSpriteComps10022 == nil then
				arg_171_1.var_.actorSpriteComps10022 = var_174_51:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_53 = 0.034

			if var_174_52 <= arg_171_1.time_ and arg_171_1.time_ < var_174_52 + var_174_53 and not isNil(var_174_51) then
				local var_174_54 = (arg_171_1.time_ - var_174_52) / var_174_53

				if arg_171_1.var_.actorSpriteComps10022 then
					for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_174_9 then
							if arg_171_1.isInRecall_ then
								local var_174_55 = Mathf.Lerp(iter_174_9.color.r, arg_171_1.hightColor2.r, var_174_54)
								local var_174_56 = Mathf.Lerp(iter_174_9.color.g, arg_171_1.hightColor2.g, var_174_54)
								local var_174_57 = Mathf.Lerp(iter_174_9.color.b, arg_171_1.hightColor2.b, var_174_54)

								iter_174_9.color = Color.New(var_174_55, var_174_56, var_174_57)
							else
								local var_174_58 = Mathf.Lerp(iter_174_9.color.r, 0.5, var_174_54)

								iter_174_9.color = Color.New(var_174_58, var_174_58, var_174_58)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_52 + var_174_53 and arg_171_1.time_ < var_174_52 + var_174_53 + arg_174_0 and not isNil(var_174_51) and arg_171_1.var_.actorSpriteComps10022 then
				for iter_174_10, iter_174_11 in pairs(arg_171_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_174_11 then
						if arg_171_1.isInRecall_ then
							iter_174_11.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10022 = nil
			end

			local var_174_59 = arg_171_1.bgs_.SS1301.transform
			local var_174_60 = 2

			if var_174_60 < arg_171_1.time_ and arg_171_1.time_ <= var_174_60 + arg_174_0 then
				arg_171_1.var_.moveOldPosSS1301 = var_174_59.localPosition
			end

			local var_174_61 = 0.1

			if var_174_60 <= arg_171_1.time_ and arg_171_1.time_ < var_174_60 + var_174_61 then
				local var_174_62 = (arg_171_1.time_ - var_174_60) / var_174_61
				local var_174_63 = Vector3.New(0, 1, 10)

				var_174_59.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosSS1301, var_174_63, var_174_62)
			end

			if arg_171_1.time_ >= var_174_60 + var_174_61 and arg_171_1.time_ < var_174_60 + var_174_61 + arg_174_0 then
				var_174_59.localPosition = Vector3.New(0, 1, 10)
			end

			local var_174_64 = arg_171_1.bgs_.SS1301.transform
			local var_174_65 = 2.1

			if var_174_65 < arg_171_1.time_ and arg_171_1.time_ <= var_174_65 + arg_174_0 then
				arg_171_1.var_.moveOldPosSS1301 = var_174_64.localPosition
			end

			local var_174_66 = 3

			if var_174_65 <= arg_171_1.time_ and arg_171_1.time_ < var_174_65 + var_174_66 then
				local var_174_67 = (arg_171_1.time_ - var_174_65) / var_174_66
				local var_174_68 = Vector3.New(0, 1, 9.5)

				var_174_64.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPosSS1301, var_174_68, var_174_67)
			end

			if arg_171_1.time_ >= var_174_65 + var_174_66 and arg_171_1.time_ < var_174_65 + var_174_66 + arg_174_0 then
				var_174_64.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_174_69 = 4

			if var_174_69 < arg_171_1.time_ and arg_171_1.time_ <= var_174_69 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_70 = 1.1

			if arg_171_1.time_ >= var_174_69 + var_174_70 and arg_171_1.time_ < var_174_69 + var_174_70 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_71 = 4.76666666666667
			local var_174_72 = 0.675

			if var_174_71 < arg_171_1.time_ and arg_171_1.time_ <= var_174_71 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_73 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_73:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_74 = arg_171_1:GetWordFromCfg(413012042)
				local var_174_75 = arg_171_1:FormatText(var_174_74.content)

				arg_171_1.text_.text = var_174_75

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_76 = 27
				local var_174_77 = utf8.len(var_174_75)
				local var_174_78 = var_174_76 <= 0 and var_174_72 or var_174_72 * (var_174_77 / var_174_76)

				if var_174_78 > 0 and var_174_72 < var_174_78 then
					arg_171_1.talkMaxDuration = var_174_78
					var_174_71 = var_174_71 + 0.3

					if var_174_78 + var_174_71 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_78 + var_174_71
					end
				end

				arg_171_1.text_.text = var_174_75
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_79 = var_174_71 + 0.3
			local var_174_80 = math.max(var_174_72, arg_171_1.talkMaxDuration)

			if var_174_79 <= arg_171_1.time_ and arg_171_1.time_ < var_174_79 + var_174_80 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_79) / var_174_80

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_79 + var_174_80 and arg_171_1.time_ < var_174_79 + var_174_80 + arg_174_0 then
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
			local var_180_0 = 0
			local var_180_1 = 0.775

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(413012043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 31
				local var_180_5 = utf8.len(var_180_3)
				local var_180_6 = var_180_4 <= 0 and var_180_1 or var_180_1 * (var_180_5 / var_180_4)

				if var_180_6 > 0 and var_180_1 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_7 and arg_177_1.time_ < var_180_0 + var_180_7 + arg_180_0 then
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
			local var_184_0 = 0
			local var_184_1 = 1.375

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(413012044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 55
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
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
			local var_188_0 = 0
			local var_188_1 = 1.075

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(413012045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 43
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
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
			local var_192_0 = 0
			local var_192_1 = 0.225

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[28].name)

				arg_189_1.leftNameTxt_.text = var_192_2

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

				local var_192_3 = arg_189_1:GetWordFromCfg(413012046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 9
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012046", "story_v_out_413012.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012046", "story_v_out_413012.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_413012", "413012046", "story_v_out_413012.awb")

						arg_189_1:RecordAudio("413012046", var_192_9)
						arg_189_1:RecordAudio("413012046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413012", "413012046", "story_v_out_413012.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413012", "413012046", "story_v_out_413012.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
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
			local var_196_0 = 0
			local var_196_1 = 0.5

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[996].name)

				arg_193_1.leftNameTxt_.text = var_196_2

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

				local var_196_3 = arg_193_1:GetWordFromCfg(413012047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 20
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012047", "story_v_out_413012.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012047", "story_v_out_413012.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_413012", "413012047", "story_v_out_413012.awb")

						arg_193_1:RecordAudio("413012047", var_196_9)
						arg_193_1:RecordAudio("413012047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413012", "413012047", "story_v_out_413012.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413012", "413012047", "story_v_out_413012.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
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
			local var_200_0 = 0
			local var_200_1 = 0.325

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[996].name)

				arg_197_1.leftNameTxt_.text = var_200_2

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

				local var_200_3 = arg_197_1:GetWordFromCfg(413012048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 13
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012048", "story_v_out_413012.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_413012", "413012048", "story_v_out_413012.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_413012", "413012048", "story_v_out_413012.awb")

						arg_197_1:RecordAudio("413012048", var_200_9)
						arg_197_1:RecordAudio("413012048", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413012", "413012048", "story_v_out_413012.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413012", "413012048", "story_v_out_413012.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
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
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_1 = 1

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_1 then
				local var_204_2 = (arg_201_1.time_ - var_204_0) / var_204_1
				local var_204_3 = Color.New(1, 1, 1)

				var_204_3.a = Mathf.Lerp(1, 0, var_204_2)
				arg_201_1.mask_.color = var_204_3
			end

			if arg_201_1.time_ >= var_204_0 + var_204_1 and arg_201_1.time_ < var_204_0 + var_204_1 + arg_204_0 then
				local var_204_4 = Color.New(1, 1, 1)
				local var_204_5 = 0

				arg_201_1.mask_.enabled = false
				var_204_4.a = var_204_5
				arg_201_1.mask_.color = var_204_4
			end

			local var_204_6 = arg_201_1.bgs_.SS1301.transform
			local var_204_7 = 0

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1.var_.moveOldPosSS1301 = var_204_6.localPosition
			end

			local var_204_8 = 0.001

			if var_204_7 <= arg_201_1.time_ and arg_201_1.time_ < var_204_7 + var_204_8 then
				local var_204_9 = (arg_201_1.time_ - var_204_7) / var_204_8
				local var_204_10 = Vector3.New(0, 1, 9)

				var_204_6.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPosSS1301, var_204_10, var_204_9)
			end

			if arg_201_1.time_ >= var_204_7 + var_204_8 and arg_201_1.time_ < var_204_7 + var_204_8 + arg_204_0 then
				var_204_6.localPosition = Vector3.New(0, 1, 9)
			end

			local var_204_11 = arg_201_1.bgs_.SS1301.transform
			local var_204_12 = 0.0166666666666666

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 then
				arg_201_1.var_.moveOldPosSS1301 = var_204_11.localPosition
			end

			local var_204_13 = 6

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_13 then
				local var_204_14 = (arg_201_1.time_ - var_204_12) / var_204_13
				local var_204_15 = Vector3.New(0, 1, 10)

				var_204_11.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPosSS1301, var_204_15, var_204_14)
			end

			if arg_201_1.time_ >= var_204_12 + var_204_13 and arg_201_1.time_ < var_204_12 + var_204_13 + arg_204_0 then
				var_204_11.localPosition = Vector3.New(0, 1, 10)
			end

			local var_204_16 = 0.999999999999

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_17 = 5.01666666666767

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_18 = 2.16666666666667
			local var_204_19 = 0.175

			if var_204_18 < arg_201_1.time_ and arg_201_1.time_ <= var_204_18 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_20 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_20:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_21 = arg_201_1:FormatText(StoryNameCfg[996].name)

				arg_201_1.leftNameTxt_.text = var_204_21

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

				local var_204_22 = arg_201_1:GetWordFromCfg(413012049)
				local var_204_23 = arg_201_1:FormatText(var_204_22.content)

				arg_201_1.text_.text = var_204_23

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_24 = 7
				local var_204_25 = utf8.len(var_204_23)
				local var_204_26 = var_204_24 <= 0 and var_204_19 or var_204_19 * (var_204_25 / var_204_24)

				if var_204_26 > 0 and var_204_19 < var_204_26 then
					arg_201_1.talkMaxDuration = var_204_26
					var_204_18 = var_204_18 + 0.3

					if var_204_26 + var_204_18 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_26 + var_204_18
					end
				end

				arg_201_1.text_.text = var_204_23
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413012", "413012049", "story_v_out_413012.awb") ~= 0 then
					local var_204_27 = manager.audio:GetVoiceLength("story_v_out_413012", "413012049", "story_v_out_413012.awb") / 1000

					if var_204_27 + var_204_18 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_27 + var_204_18
					end

					if var_204_22.prefab_name ~= "" and arg_201_1.actors_[var_204_22.prefab_name] ~= nil then
						local var_204_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_22.prefab_name].transform, "story_v_out_413012", "413012049", "story_v_out_413012.awb")

						arg_201_1:RecordAudio("413012049", var_204_28)
						arg_201_1:RecordAudio("413012049", var_204_28)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413012", "413012049", "story_v_out_413012.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413012", "413012049", "story_v_out_413012.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_29 = var_204_18 + 0.3
			local var_204_30 = math.max(var_204_19, arg_201_1.talkMaxDuration)

			if var_204_29 <= arg_201_1.time_ and arg_201_1.time_ < var_204_29 + var_204_30 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_29) / var_204_30

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_29 + var_204_30 and arg_201_1.time_ < var_204_29 + var_204_30 + arg_204_0 then
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
