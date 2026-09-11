return {
	Play926011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926011001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 3.933,
			ja = 4.833
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
				arg_1_0:Play926011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_4_0.name = "ST10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "10102"

			if arg_1_1.actors_["10102"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10102")

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

			local var_4_12 = arg_1_1.actors_["10102"]

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10102 == nil then
				arg_1_1.var_.actorSpriteComps10102 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10102 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.63333333333333) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.63333333333333) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.63333333333333) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.63333333333333) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_13 and arg_1_1.time_ < 1.63333333333333 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10102 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10102 = nil
			end

			local var_4_15 = arg_1_1.actors_["10102"].transform

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos10102 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10102", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_1_1.time_ - 1.63333333333333) / var_4_17)
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_17 and arg_1_1.time_ < 1.63333333333333 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			if 1.63333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.63333333333333 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10102"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10102 = var_4_18.alpha
					arg_1_1.var_.characterEffect10102 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10102 = 0
			end

			local var_4_19 = 0.2

			if 1.63333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.63333333333333 + var_4_19 then
				if arg_1_1.var_.characterEffect10102 then
					arg_1_1.var_.characterEffect10102.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10102, 1, (arg_1_1.time_ - 1.63333333333333) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.63333333333333 + var_4_19 and arg_1_1.time_ < 1.63333333333333 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10102 then
				arg_1_1.var_.characterEffect10102.alpha = 1
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			local var_4_27 = 2
			local var_4_28 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(926011001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)

				if (10 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 10)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011001", "story_v_out_926011.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_926011", "926011001", "story_v_out_926011.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_926011", "926011001", "story_v_out_926011.awb")

						arg_1_1:RecordAudio("926011001", var_4_35)
						arg_1_1:RecordAudio("926011001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926011", "926011001", "story_v_out_926011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926011", "926011001", "story_v_out_926011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926011002
		arg_9_1.duration_ = 8.3

		local var_9_0 = {
			zh = 5.9,
			ja = 8.3
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
				arg_9_0:Play926011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.775

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(926011002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 31)

				if (31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 31)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011002", "story_v_out_926011.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011002", "story_v_out_926011.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_926011", "926011002", "story_v_out_926011.awb")

						arg_9_1:RecordAudio("926011002", var_12_6)
						arg_9_1:RecordAudio("926011002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926011", "926011002", "story_v_out_926011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926011", "926011002", "story_v_out_926011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play926011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play926011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10102"]) and arg_13_1.var_.actorSpriteComps10102 == nil then
				arg_13_1.var_.actorSpriteComps10102 = arg_13_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10102"]) then
				if arg_13_1.var_.actorSpriteComps10102 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10102"]) and arg_13_1.var_.actorSpriteComps10102 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10102 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_4 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(926011003).content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 18 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 18)

				if (18 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 18)) > 0 and var_16_3 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_7 and arg_13_1.time_ < var_16_2 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926011004
		arg_17_1.duration_ = 4.1

		local var_17_0 = {
			zh = 4.1,
			ja = 3.966
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
				arg_17_0:Play926011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10102"]) and arg_17_1.var_.actorSpriteComps10102 == nil then
				arg_17_1.var_.actorSpriteComps10102 = arg_17_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10102"]) then
				if arg_17_1.var_.actorSpriteComps10102 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10102"]) and arg_17_1.var_.actorSpriteComps10102 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10102 = nil
			end

			local var_20_2 = arg_17_1.actors_["10102"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10102 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10102", 3)

				for iter_20_4 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_4)

					if var_20_3.name == "split_4" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_20_5 = 0
			local var_20_6 = 0.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(926011004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 20 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 20)

				if (20 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 20)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011004", "story_v_out_926011.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011004", "story_v_out_926011.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_926011", "926011004", "story_v_out_926011.awb")

						arg_17_1:RecordAudio("926011004", var_20_12)
						arg_17_1:RecordAudio("926011004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926011", "926011004", "story_v_out_926011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926011", "926011004", "story_v_out_926011.awb")
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

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10102"]) and arg_21_1.var_.actorSpriteComps10102 == nil then
				arg_21_1.var_.actorSpriteComps10102 = arg_21_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10102"]) then
				if arg_21_1.var_.actorSpriteComps10102 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10102"]) and arg_21_1.var_.actorSpriteComps10102 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10102 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.975

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(926011005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 39 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 39)

				if (39 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 39)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play926011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10102 = arg_25_1.actors_["10102"].transform.localPosition
				arg_25_1.actors_["10102"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10102", 7)

				for iter_28_0 = 0, arg_25_1.actors_["10102"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10102"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10102"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10102, Vector3.New(0, -2000, 0), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10102"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.125 < arg_25_1.time_ and arg_25_1.time_ <= 0.125 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_cloth01", "")
			end

			local var_28_3 = 0
			local var_28_4 = 1.125

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(926011006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 45 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 45)

				if (45 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 45)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926011007
		arg_29_1.duration_ = 9.7

		local var_29_0 = {
			zh = 9.7,
			ja = 9.5
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
				arg_29_0:Play926011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10102"]) and arg_29_1.var_.actorSpriteComps10102 == nil then
				arg_29_1.var_.actorSpriteComps10102 = arg_29_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10102"]) then
				if arg_29_1.var_.actorSpriteComps10102 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 1, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10102"]) and arg_29_1.var_.actorSpriteComps10102 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10102 = nil
			end

			local var_32_2 = arg_29_1.actors_["10102"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10102", 3)

				for iter_32_4 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_4)

					if var_32_3.name == "split_4" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_32_5 = 0
			local var_32_6 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(926011007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 29 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 29)

				if (29 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 29)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011007", "story_v_out_926011.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011007", "story_v_out_926011.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_926011", "926011007", "story_v_out_926011.awb")

						arg_29_1:RecordAudio("926011007", var_32_12)
						arg_29_1:RecordAudio("926011007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926011", "926011007", "story_v_out_926011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926011", "926011007", "story_v_out_926011.awb")
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
				actorName = "10102",
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
	Play926011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10102"]) and arg_33_1.var_.actorSpriteComps10102 == nil then
				arg_33_1.var_.actorSpriteComps10102 = arg_33_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10102"]) then
				if arg_33_1.var_.actorSpriteComps10102 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10102"]) and arg_33_1.var_.actorSpriteComps10102 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10102 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.925

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(926011008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 37 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 37)

				if (37 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 37)) > 0 and var_36_3 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_7 and arg_33_1.time_ < var_36_2 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play926011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(926011009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 13 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 13)

				if (13 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 13)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play926011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926011010
		arg_41_1.duration_ = 10.3

		local var_41_0 = {
			zh = 6.5,
			ja = 10.3
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
				arg_41_0:Play926011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10102"]) and arg_41_1.var_.actorSpriteComps10102 == nil then
				arg_41_1.var_.actorSpriteComps10102 = arg_41_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10102"]) then
				if arg_41_1.var_.actorSpriteComps10102 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10102"]) and arg_41_1.var_.actorSpriteComps10102 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10102 = nil
			end

			local var_44_2 = arg_41_1.actors_["10102"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10102 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10102", 3)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_44_5 = 0
			local var_44_6 = 0.85

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(926011010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 34 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 34)

				if (34 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 34)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011010", "story_v_out_926011.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011010", "story_v_out_926011.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_926011", "926011010", "story_v_out_926011.awb")

						arg_41_1:RecordAudio("926011010", var_44_12)
						arg_41_1:RecordAudio("926011010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926011", "926011010", "story_v_out_926011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926011", "926011010", "story_v_out_926011.awb")
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
				actorName = "10102",
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
	Play926011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926011011
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"

			SetActive(arg_45_1.choicesGo_, true)

			for iter_46_0, iter_46_1 in ipairs(arg_45_1.choices_) do
				SetActive(iter_46_1.go, iter_46_0 <= 1)
			end

			arg_45_1.choices_[1].txt.text = arg_45_1:FormatText(StoryChoiceCfg[1303].name)
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926011012(arg_45_1)
			end

			arg_45_1:RecordChoiceLog(926011011, 1303)
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10102"]) and arg_45_1.var_.actorSpriteComps10102 == nil then
				arg_45_1.var_.actorSpriteComps10102 = arg_45_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10102"]) then
				if arg_45_1.var_.actorSpriteComps10102 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10102"]) and arg_45_1.var_.actorSpriteComps10102 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10102 = nil
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play926011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926011012
		arg_49_1.duration_ = 2.2

		local var_49_0 = {
			zh = 2.2,
			ja = 1.833
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
				arg_49_0:Play926011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10102"]) and arg_49_1.var_.actorSpriteComps10102 == nil then
				arg_49_1.var_.actorSpriteComps10102 = arg_49_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10102"]) then
				if arg_49_1.var_.actorSpriteComps10102 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10102"]) and arg_49_1.var_.actorSpriteComps10102 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10102 = nil
			end

			local var_52_2 = arg_49_1.actors_["10102"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10102 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10102", 3)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "split_4" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_52_5 = 0
			local var_52_6 = 0.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(926011012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 6 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 6)

				if (6 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 6)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011012", "story_v_out_926011.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011012", "story_v_out_926011.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_926011", "926011012", "story_v_out_926011.awb")

						arg_49_1:RecordAudio("926011012", var_52_12)
						arg_49_1:RecordAudio("926011012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926011", "926011012", "story_v_out_926011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926011", "926011012", "story_v_out_926011.awb")
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

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10102"]) and arg_53_1.var_.actorSpriteComps10102 == nil then
				arg_53_1.var_.actorSpriteComps10102 = arg_53_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10102"]) then
				if arg_53_1.var_.actorSpriteComps10102 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10102"]) and arg_53_1.var_.actorSpriteComps10102 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10102 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.8

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(926011013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 32 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 32)

				if (32 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 32)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(926011014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 34)

				if (34 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 34)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926011015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			zh = 4.466,
			ja = 5.833
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
				arg_61_0:Play926011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10102"]) and arg_61_1.var_.actorSpriteComps10102 == nil then
				arg_61_1.var_.actorSpriteComps10102 = arg_61_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10102"]) then
				if arg_61_1.var_.actorSpriteComps10102 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10102"]) and arg_61_1.var_.actorSpriteComps10102 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10102 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(926011015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 20 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 20)

				if (20 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 20)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011015", "story_v_out_926011.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011015", "story_v_out_926011.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_926011", "926011015", "story_v_out_926011.awb")

						arg_61_1:RecordAudio("926011015", var_64_9)
						arg_61_1:RecordAudio("926011015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926011", "926011015", "story_v_out_926011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926011", "926011015", "story_v_out_926011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play926011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10102"]) and arg_65_1.var_.actorSpriteComps10102 == nil then
				arg_65_1.var_.actorSpriteComps10102 = arg_65_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10102"]) then
				if arg_65_1.var_.actorSpriteComps10102 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10102"]) and arg_65_1.var_.actorSpriteComps10102 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10102 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 0.875

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_4 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(926011016).content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 35 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 35)

				if (35 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 35)) > 0 and var_68_3 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_7 and arg_65_1.time_ < var_68_2 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play926011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926011017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play926011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(926011017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 27 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 27)

				if (27 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 27)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926011018
		arg_73_1.duration_ = 2.7

		local var_73_0 = {
			zh = 1.9,
			ja = 2.7
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
				arg_73_0:Play926011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10102"]) and arg_73_1.var_.actorSpriteComps10102 == nil then
				arg_73_1.var_.actorSpriteComps10102 = arg_73_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10102"]) then
				if arg_73_1.var_.actorSpriteComps10102 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10102"]) and arg_73_1.var_.actorSpriteComps10102 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10102 = nil
			end

			local var_76_2 = arg_73_1.actors_["10102"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10102 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10102", 3)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "split_6" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_76_5 = 0
			local var_76_6 = 0.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(926011018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 6 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 6)

				if (6 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 6)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011018", "story_v_out_926011.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011018", "story_v_out_926011.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_926011", "926011018", "story_v_out_926011.awb")

						arg_73_1:RecordAudio("926011018", var_76_12)
						arg_73_1:RecordAudio("926011018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926011", "926011018", "story_v_out_926011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926011", "926011018", "story_v_out_926011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_13 and arg_73_1.time_ < var_76_5 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926011019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play926011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10102"]) and arg_77_1.var_.actorSpriteComps10102 == nil then
				arg_77_1.var_.actorSpriteComps10102 = arg_77_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10102"]) then
				if arg_77_1.var_.actorSpriteComps10102 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10102"]) and arg_77_1.var_.actorSpriteComps10102 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10102 = nil
			end

			local var_80_2 = 0
			local var_80_3 = 0.85

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(926011019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 34 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 34)

				if (34 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 34)) > 0 and var_80_3 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_7 and arg_77_1.time_ < var_80_2 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play926011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926011020
		arg_81_1.duration_ = 8.83

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.ST12a == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12a")
				var_84_0.name = "ST12a"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.ST12a = var_84_0
			end

			if 1.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= 1.999999999999 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.ST12a

				arg_81_1.bgs_.ST12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "ST12a" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 1.999999999999

			if 1.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			if arg_81_1.time_ >= var_84_4 + 0.3 and arg_81_1.time_ < var_84_4 + 0.3 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_5 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_6 = 2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 then
				local var_84_7 = Color.New(0, 0, 0)

				var_84_7.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_5) / var_84_6)
				arg_81_1.mask_.color = var_84_7
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 then
				local var_84_8 = Color.New(0, 0, 0)

				var_84_8.a = 1
				arg_81_1.mask_.color = var_84_8
			end

			local var_84_9 = 1.999999999999

			if 1.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_10 = 2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 then
				local var_84_11 = Color.New(0, 0, 0)

				var_84_11.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_9) / var_84_10)
				arg_81_1.mask_.color = var_84_11
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 then
				local var_84_12 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_12.a = 0
				arg_81_1.mask_.color = var_84_12
			end

			local var_84_13 = arg_81_1.actors_["10102"].transform

			if 1.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= 1.999999999999 + arg_84_0 then
				arg_81_1.var_.moveOldPos10102 = var_84_13.localPosition
				var_84_13.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10102", 7)

				for iter_84_2 = 0, var_84_13.childCount - 1 do
					local var_84_14 = var_84_13:GetChild(iter_84_2)

					if var_84_14.name == "" or not string.find(var_84_14.name, "split") then
						var_84_14.gameObject:SetActive(true)
					else
						var_84_14.gameObject:SetActive(false)
					end
				end
			end

			local var_84_15 = 0.001

			if 1.999999999999 <= arg_81_1.time_ and arg_81_1.time_ < 1.999999999999 + var_84_15 then
				var_84_13.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10102, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 1.999999999999) / var_84_15)
			end

			if arg_81_1.time_ >= 1.999999999999 + var_84_15 and arg_81_1.time_ < 1.999999999999 + var_84_15 + arg_84_0 then
				var_84_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.50066666666667 < arg_81_1.time_ and arg_81_1.time_ <= 1.50066666666667 + arg_84_0 then
				arg_81_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_84_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_19 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_19

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_19
						arg_81_1.bgmTxt2_.text = var_84_19
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 0.500666666666667 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_84_22 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_22 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_22

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_22
						arg_81_1.bgmTxt2_.text = var_84_22
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_81_1.time_ and arg_81_1.time_ <= 0.3 + arg_84_0 then
				arg_81_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_24 = 3.83333333333333
			local var_84_25 = 0.425

			if 3.83333333333333 < arg_81_1.time_ and arg_81_1.time_ <= var_84_24 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_26 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_26:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_81_1.dialogCg_.alpha = arg_87_0
				end))
				var_84_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_27 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(926011020).content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_29 = 17 <= 0 and var_84_25 or var_84_25 * (utf8.len(var_84_27) / 17)

				if (17 <= 0 and var_84_25 or var_84_25 * (utf8.len(var_84_27) / 17)) > 0 and var_84_25 < var_84_29 then
					arg_81_1.talkMaxDuration = var_84_29
					var_84_24 = var_84_24 + 0.3

					if var_84_29 + var_84_24 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_24
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_30 = var_84_24 + 0.3
			local var_84_31 = math.max(var_84_25, arg_81_1.talkMaxDuration)

			if var_84_24 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_30) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_30 + var_84_31 and arg_81_1.time_ < var_84_30 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play926011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926011021
		arg_89_1.duration_ = 2.5

		local var_89_0 = {
			zh = 2.366,
			ja = 2.5
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
				arg_89_0:Play926011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(926011021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 8)

				if (8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 8)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011021", "story_v_out_926011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011021", "story_v_out_926011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_926011", "926011021", "story_v_out_926011.awb")

						arg_89_1:RecordAudio("926011021", var_92_6)
						arg_89_1:RecordAudio("926011021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926011", "926011021", "story_v_out_926011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926011", "926011021", "story_v_out_926011.awb")
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
	Play926011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926011022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play926011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.5

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(926011022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 60 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 60)

				if (60 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 60)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play926011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926011023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(926011023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 12)

				if (12 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 12)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play926011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926011024
		arg_101_1.duration_ = 7.37

		local var_101_0 = {
			zh = 5.7,
			ja = 7.366
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
				arg_101_0:Play926011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["1047"] == nil then
				local var_104_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_104_0) then
					local var_104_1 = Object.Instantiate(var_104_0, arg_101_1.canvasGo_.transform)

					var_104_1.transform:SetSiblingIndex(1)

					var_104_1.name = "1047"
					var_104_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_["1047"] = var_104_1

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs((var_104_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_2 = arg_101_1.actors_["1047"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1047 == nil then
				arg_101_1.var_.actorSpriteComps1047 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1047 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_3.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_3.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1047 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1047 = nil
			end

			local var_104_5 = arg_101_1.actors_["1047"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1047 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1047", 3)

				for iter_104_6 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_6)

					if var_104_6.name == "" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_104_8 = 0
			local var_104_9 = 0.55

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(926011024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 22 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 22)

				if (22 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 22)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011024", "story_v_out_926011.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011024", "story_v_out_926011.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_926011", "926011024", "story_v_out_926011.awb")

						arg_101_1:RecordAudio("926011024", var_104_15)
						arg_101_1:RecordAudio("926011024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926011", "926011024", "story_v_out_926011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926011", "926011024", "story_v_out_926011.awb")
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
				actorName = "1047",
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
	Play926011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926011025
		arg_105_1.duration_ = 1

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"

			SetActive(arg_105_1.choicesGo_, true)

			for iter_106_0, iter_106_1 in ipairs(arg_105_1.choices_) do
				SetActive(iter_106_1.go, iter_106_0 <= 2)
			end

			arg_105_1.choices_[1].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1304].name)
			arg_105_1.choices_[2].txt.text = arg_105_1:FormatText(StoryChoiceCfg[1305].name)
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926011026(arg_105_1)
			end

			if arg_107_0 == 2 then
				arg_105_0:Play926011026(arg_105_1)
			end

			arg_105_1:RecordChoiceLog(926011025, 1304, 1305)
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1047"]) and arg_105_1.var_.actorSpriteComps1047 == nil then
				arg_105_1.var_.actorSpriteComps1047 = arg_105_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1047"]) then
				if arg_105_1.var_.actorSpriteComps1047 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1047"]) and arg_105_1.var_.actorSpriteComps1047 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926011026
		arg_109_1.duration_ = 5.77

		local var_109_0 = {
			zh = 3.166,
			ja = 5.766
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
				arg_109_0:Play926011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1047"]) and arg_109_1.var_.actorSpriteComps1047 == nil then
				arg_109_1.var_.actorSpriteComps1047 = arg_109_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1047"]) then
				if arg_109_1.var_.actorSpriteComps1047 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 1, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1047"]) and arg_109_1.var_.actorSpriteComps1047 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1047 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 0.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(926011026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 14 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 14)

				if (14 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 14)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011026", "story_v_out_926011.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011026", "story_v_out_926011.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_926011", "926011026", "story_v_out_926011.awb")

						arg_109_1:RecordAudio("926011026", var_112_9)
						arg_109_1:RecordAudio("926011026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926011", "926011026", "story_v_out_926011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926011", "926011026", "story_v_out_926011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926011027
		arg_113_1.duration_ = 13

		local var_113_0 = {
			zh = 9.866,
			ja = 13
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
				arg_113_0:Play926011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(926011027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 50 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 50)

				if (50 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 50)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011027", "story_v_out_926011.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011027", "story_v_out_926011.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_926011", "926011027", "story_v_out_926011.awb")

						arg_113_1:RecordAudio("926011027", var_116_6)
						arg_113_1:RecordAudio("926011027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926011", "926011027", "story_v_out_926011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926011", "926011027", "story_v_out_926011.awb")
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
	Play926011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926011028
		arg_117_1.duration_ = 12.43

		local var_117_0 = {
			zh = 8.266,
			ja = 12.433
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
				arg_117_0:Play926011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1047 = arg_117_1.actors_["1047"].transform.localPosition
				arg_117_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1047", 3)

				for iter_120_0 = 0, arg_117_1.actors_["1047"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1047"].transform:GetChild(iter_120_0)

					if var_120_0.name == "split_1" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_120_2 = 0
			local var_120_3 = 0.925

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(926011028)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 37 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 37)

				if (37 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 37)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011028", "story_v_out_926011.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011028", "story_v_out_926011.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_926011", "926011028", "story_v_out_926011.awb")

						arg_117_1:RecordAudio("926011028", var_120_9)
						arg_117_1:RecordAudio("926011028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926011", "926011028", "story_v_out_926011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926011", "926011028", "story_v_out_926011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926011029
		arg_121_1.duration_ = 2.93

		local var_121_0 = {
			zh = 2.1,
			ja = 2.933
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
				arg_121_0:Play926011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10102"]) and arg_121_1.var_.actorSpriteComps10102 == nil then
				arg_121_1.var_.actorSpriteComps10102 = arg_121_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10102"]) then
				if arg_121_1.var_.actorSpriteComps10102 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 1, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10102"]) and arg_121_1.var_.actorSpriteComps10102 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10102 = nil
			end

			local var_124_2 = arg_121_1.actors_["1047"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps1047 == nil then
				arg_121_1.var_.actorSpriteComps1047 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps1047 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								iter_124_5.color = Color.New(Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_5.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_5.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps1047 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_124_7 then
						iter_124_7.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1047 = nil
			end

			local var_124_5 = arg_121_1.actors_["1047"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1047 = var_124_5.localPosition
				var_124_5.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1047", 7)

				for iter_124_8 = 0, var_124_5.childCount - 1 do
					local var_124_6 = var_124_5:GetChild(iter_124_8)

					if var_124_6.name == "" or not string.find(var_124_6.name, "split") then
						var_124_6.gameObject:SetActive(true)
					else
						var_124_6.gameObject:SetActive(false)
					end
				end
			end

			local var_124_7 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_121_1.time_ - 0) / var_124_7)
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_8 = arg_121_1.actors_["10102"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10102 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10102", 3)

				for iter_124_9 = 0, var_124_8.childCount - 1 do
					local var_124_9 = var_124_8:GetChild(iter_124_9)

					if var_124_9.name == "" or not string.find(var_124_9.name, "split") then
						var_124_9.gameObject:SetActive(true)
					else
						var_124_9.gameObject:SetActive(false)
					end
				end
			end

			local var_124_10 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_10 then
				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10102, Vector3.New(-69, -354.2, -425.9), (arg_121_1.time_ - 0) / var_124_10)
			end

			if arg_121_1.time_ >= 0 + var_124_10 and arg_121_1.time_ < 0 + var_124_10 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(-69, -354.2, -425.9)
			end

			local var_124_11 = 0
			local var_124_12 = 0.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:GetWordFromCfg(926011029)
				local var_124_14 = arg_121_1:FormatText(var_124_13.content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 7 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 7)

				if (7 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_14) / 7)) > 0 and var_124_12 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011029", "story_v_out_926011.awb") ~= 0 then
					local var_124_17 = manager.audio:GetVoiceLength("story_v_out_926011", "926011029", "story_v_out_926011.awb") / 1000

					if var_124_17 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_11
					end

					if var_124_13.prefab_name ~= "" and arg_121_1.actors_[var_124_13.prefab_name] ~= nil then
						local var_124_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_13.prefab_name].transform, "story_v_out_926011", "926011029", "story_v_out_926011.awb")

						arg_121_1:RecordAudio("926011029", var_124_18)
						arg_121_1:RecordAudio("926011029", var_124_18)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_926011", "926011029", "story_v_out_926011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_926011", "926011029", "story_v_out_926011.awb")
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10102",
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
	Play926011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926011030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10102"]) and arg_125_1.var_.actorSpriteComps10102 == nil then
				arg_125_1.var_.actorSpriteComps10102 = arg_125_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10102"]) then
				if arg_125_1.var_.actorSpriteComps10102 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10102:ToTable()) do
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

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10102"]) and arg_125_1.var_.actorSpriteComps10102 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10102 = nil
			end

			local var_128_2 = 0
			local var_128_3 = 0.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_4 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(926011030).content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 8 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 8)

				if (8 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 8)) > 0 and var_128_3 < var_128_6 then
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
	Play926011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926011031
		arg_129_1.duration_ = 19.57

		local var_129_0 = {
			zh = 9.966,
			ja = 19.566
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
				arg_129_0:Play926011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1047"]) and arg_129_1.var_.actorSpriteComps1047 == nil then
				arg_129_1.var_.actorSpriteComps1047 = arg_129_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1047"]) then
				if arg_129_1.var_.actorSpriteComps1047 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1047"]) and arg_129_1.var_.actorSpriteComps1047 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps1047 = nil
			end

			local var_132_2 = arg_129_1.actors_["10102"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10102 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10102", 7)

				for iter_132_4 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_4)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10102, Vector3.New(0, -2000, 0), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_5 = arg_129_1.actors_["1047"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1047 = var_132_5.localPosition
				var_132_5.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1047", 3)

				for iter_132_5 = 0, var_132_5.childCount - 1 do
					local var_132_6 = var_132_5:GetChild(iter_132_5)

					if var_132_6.name == "split_2" or not string.find(var_132_6.name, "split") then
						var_132_6.gameObject:SetActive(true)
					else
						var_132_6.gameObject:SetActive(false)
					end
				end
			end

			local var_132_7 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				var_132_5.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_129_1.time_ - 0) / var_132_7)
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				var_132_5.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_132_8 = 0
			local var_132_9 = 1.275

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_10 = arg_129_1:GetWordFromCfg(926011031)
				local var_132_11 = arg_129_1:FormatText(var_132_10.content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 51 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 51)

				if (51 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 51)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011031", "story_v_out_926011.awb") ~= 0 then
					local var_132_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011031", "story_v_out_926011.awb") / 1000

					if var_132_14 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_14 + var_132_8
					end

					if var_132_10.prefab_name ~= "" and arg_129_1.actors_[var_132_10.prefab_name] ~= nil then
						local var_132_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_10.prefab_name].transform, "story_v_out_926011", "926011031", "story_v_out_926011.awb")

						arg_129_1:RecordAudio("926011031", var_132_15)
						arg_129_1:RecordAudio("926011031", var_132_15)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926011", "926011031", "story_v_out_926011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926011", "926011031", "story_v_out_926011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_16 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_16 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_8) / var_132_16

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_8 + var_132_16 and arg_129_1.time_ < var_132_8 + var_132_16 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926011032
		arg_133_1.duration_ = 7.1

		local var_133_0 = {
			zh = 5.766,
			ja = 7.1
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
				arg_133_0:Play926011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(926011032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)

				if (26 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 26)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011032", "story_v_out_926011.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011032", "story_v_out_926011.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_926011", "926011032", "story_v_out_926011.awb")

						arg_133_1:RecordAudio("926011032", var_136_6)
						arg_133_1:RecordAudio("926011032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926011", "926011032", "story_v_out_926011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926011", "926011032", "story_v_out_926011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play926011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926011033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play926011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1047"]) and arg_137_1.var_.actorSpriteComps1047 == nil then
				arg_137_1.var_.actorSpriteComps1047 = arg_137_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1047"]) then
				if arg_137_1.var_.actorSpriteComps1047 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1047"]) and arg_137_1.var_.actorSpriteComps1047 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps1047 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(926011033).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 20 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 20)

				if (20 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 20)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play926011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926011034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.75

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(926011034).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 30)

				if (30 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 30)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play926011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926011035
		arg_145_1.duration_ = 4.27

		local var_145_0 = {
			zh = 3.566,
			ja = 4.266
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play926011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1047"]) and arg_145_1.var_.actorSpriteComps1047 == nil then
				arg_145_1.var_.actorSpriteComps1047 = arg_145_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1047"]) then
				if arg_145_1.var_.actorSpriteComps1047 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 1, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1047"]) and arg_145_1.var_.actorSpriteComps1047 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1047 = nil
			end

			local var_148_2 = arg_145_1.actors_["1047"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1047 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1047", 3)

				for iter_148_4 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_4)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_145_1.time_ - 0) / var_148_4)
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_148_5 = 0
			local var_148_6 = 0.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:GetWordFromCfg(926011035)
				local var_148_8 = arg_145_1:FormatText(var_148_7.content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 18 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 18)

				if (18 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_8) / 18)) > 0 and var_148_6 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011035", "story_v_out_926011.awb") ~= 0 then
					local var_148_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011035", "story_v_out_926011.awb") / 1000

					if var_148_11 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_5
					end

					if var_148_7.prefab_name ~= "" and arg_145_1.actors_[var_148_7.prefab_name] ~= nil then
						local var_148_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_7.prefab_name].transform, "story_v_out_926011", "926011035", "story_v_out_926011.awb")

						arg_145_1:RecordAudio("926011035", var_148_12)
						arg_145_1:RecordAudio("926011035", var_148_12)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926011", "926011035", "story_v_out_926011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926011", "926011035", "story_v_out_926011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_13 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_13 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_13

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_13 and arg_145_1.time_ < var_148_5 + var_148_13 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play926011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926011036
		arg_149_1.duration_ = 1

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"

			SetActive(arg_149_1.choicesGo_, true)

			for iter_150_0, iter_150_1 in ipairs(arg_149_1.choices_) do
				SetActive(iter_150_1.go, iter_150_0 <= 1)
			end

			arg_149_1.choices_[1].txt.text = arg_149_1:FormatText(StoryChoiceCfg[1306].name)
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926011037(arg_149_1)
			end

			arg_149_1:RecordChoiceLog(926011036, 1306)
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1047"]) and arg_149_1.var_.actorSpriteComps1047 == nil then
				arg_149_1.var_.actorSpriteComps1047 = arg_149_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1047"]) then
				if arg_149_1.var_.actorSpriteComps1047 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1047"]) and arg_149_1.var_.actorSpriteComps1047 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926011037
		arg_153_1.duration_ = 7.37

		local var_153_0 = {
			zh = 4.533,
			ja = 7.366
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
				arg_153_0:Play926011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1047"]) and arg_153_1.var_.actorSpriteComps1047 == nil then
				arg_153_1.var_.actorSpriteComps1047 = arg_153_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1047"]) then
				if arg_153_1.var_.actorSpriteComps1047 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1047"]) and arg_153_1.var_.actorSpriteComps1047 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1047 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.575

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(926011037)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 23 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 23)

				if (23 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 23)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011037", "story_v_out_926011.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011037", "story_v_out_926011.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_926011", "926011037", "story_v_out_926011.awb")

						arg_153_1:RecordAudio("926011037", var_156_9)
						arg_153_1:RecordAudio("926011037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926011", "926011037", "story_v_out_926011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926011", "926011037", "story_v_out_926011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play926011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926011038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1047"]) and arg_157_1.var_.actorSpriteComps1047 == nil then
				arg_157_1.var_.actorSpriteComps1047 = arg_157_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1047"]) then
				if arg_157_1.var_.actorSpriteComps1047 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1047"]) and arg_157_1.var_.actorSpriteComps1047 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps1047 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_4 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(926011038).content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 17 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 17)

				if (17 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_4) / 17)) > 0 and var_160_3 < var_160_6 then
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
	Play926011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926011039
		arg_161_1.duration_ = 13.3

		local var_161_0 = {
			zh = 9.733,
			ja = 13.3
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
				arg_161_0:Play926011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1047"]) and arg_161_1.var_.actorSpriteComps1047 == nil then
				arg_161_1.var_.actorSpriteComps1047 = arg_161_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1047"]) then
				if arg_161_1.var_.actorSpriteComps1047 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 1, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1047"]) and arg_161_1.var_.actorSpriteComps1047 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1047 = nil
			end

			local var_164_2 = 0
			local var_164_3 = 1.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_4 = arg_161_1:GetWordFromCfg(926011039)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 47 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 47)

				if (47 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 47)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011039", "story_v_out_926011.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011039", "story_v_out_926011.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_out_926011", "926011039", "story_v_out_926011.awb")

						arg_161_1:RecordAudio("926011039", var_164_9)
						arg_161_1:RecordAudio("926011039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_926011", "926011039", "story_v_out_926011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_926011", "926011039", "story_v_out_926011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play926011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926011040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play926011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1047"]) and arg_165_1.var_.actorSpriteComps1047 == nil then
				arg_165_1.var_.actorSpriteComps1047 = arg_165_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1047"]) then
				if arg_165_1.var_.actorSpriteComps1047 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1047"]) and arg_165_1.var_.actorSpriteComps1047 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1047 = nil
			end

			local var_168_2 = 0
			local var_168_3 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_4 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(926011040).content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 22 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 22)

				if (22 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 22)) > 0 and var_168_3 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_7 and arg_165_1.time_ < var_168_2 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play926011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926011041
		arg_169_1.duration_ = 9.8

		local var_169_0 = {
			zh = 5.533,
			ja = 9.8
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
				arg_169_0:Play926011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1047"]) and arg_169_1.var_.actorSpriteComps1047 == nil then
				arg_169_1.var_.actorSpriteComps1047 = arg_169_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1047"]) then
				if arg_169_1.var_.actorSpriteComps1047 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								iter_172_1.color = Color.New(Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_0), Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_0), (Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_0)))
							else
								local var_172_1 = Mathf.Lerp(iter_172_1.color.r, 1, (arg_169_1.time_ - 0) / var_172_0)

								iter_172_1.color = Color.New(var_172_1, var_172_1, var_172_1)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1047"]) and arg_169_1.var_.actorSpriteComps1047 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_172_3 then
						iter_172_3.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps1047 = nil
			end

			local var_172_2 = 0
			local var_172_3 = 0.6

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(926011041)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 24 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 24)

				if (24 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 24)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011041", "story_v_out_926011.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011041", "story_v_out_926011.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_926011", "926011041", "story_v_out_926011.awb")

						arg_169_1:RecordAudio("926011041", var_172_9)
						arg_169_1:RecordAudio("926011041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_926011", "926011041", "story_v_out_926011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_926011", "926011041", "story_v_out_926011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926011042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play926011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1047"]) and arg_173_1.var_.actorSpriteComps1047 == nil then
				arg_173_1.var_.actorSpriteComps1047 = arg_173_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1047"]) then
				if arg_173_1.var_.actorSpriteComps1047 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1047"]) and arg_173_1.var_.actorSpriteComps1047 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps1047 = nil
			end

			local var_176_2 = arg_173_1.actors_["1047"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047 = var_176_2.localPosition
				var_176_2.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1047", 7)

				for iter_176_4 = 0, var_176_2.childCount - 1 do
					local var_176_3 = var_176_2:GetChild(iter_176_4)

					if var_176_3.name == "" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				var_176_2.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_173_1.time_ - 0) / var_176_4)
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				var_176_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_176_5 = 0
			local var_176_6 = 0.8

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(926011042).content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 32 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 32)

				if (32 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 32)) > 0 and var_176_6 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_10 and arg_173_1.time_ < var_176_5 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926011043
		arg_177_1.duration_ = 14.9

		local var_177_0 = {
			zh = 10.133,
			ja = 14.9
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
				arg_177_0:Play926011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1047"]) and arg_177_1.var_.actorSpriteComps1047 == nil then
				arg_177_1.var_.actorSpriteComps1047 = arg_177_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1047"]) then
				if arg_177_1.var_.actorSpriteComps1047 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1047"]) and arg_177_1.var_.actorSpriteComps1047 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1047 = nil
			end

			local var_180_2 = arg_177_1.actors_["1047"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047 = var_180_2.localPosition
				var_180_2.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1047", 3)

				for iter_180_4 = 0, var_180_2.childCount - 1 do
					local var_180_3 = var_180_2:GetChild(iter_180_4)

					if var_180_3.name == "split_6" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_177_1.time_ - 0) / var_180_4)
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_180_5 = 0
			local var_180_6 = 1.25

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(926011043)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 50 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 50)

				if (50 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 50)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011043", "story_v_out_926011.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011043", "story_v_out_926011.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_926011", "926011043", "story_v_out_926011.awb")

						arg_177_1:RecordAudio("926011043", var_180_12)
						arg_177_1:RecordAudio("926011043", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926011", "926011043", "story_v_out_926011.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926011", "926011043", "story_v_out_926011.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926011044
		arg_181_1.duration_ = 13.4

		local var_181_0 = {
			zh = 12.266,
			ja = 13.4
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
				arg_181_0:Play926011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.35

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(926011044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 54 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 54)

				if (54 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 54)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011044", "story_v_out_926011.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011044", "story_v_out_926011.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_926011", "926011044", "story_v_out_926011.awb")

						arg_181_1:RecordAudio("926011044", var_184_6)
						arg_181_1:RecordAudio("926011044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926011", "926011044", "story_v_out_926011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926011", "926011044", "story_v_out_926011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926011045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1047"]) and arg_185_1.var_.actorSpriteComps1047 == nil then
				arg_185_1.var_.actorSpriteComps1047 = arg_185_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1047"]) then
				if arg_185_1.var_.actorSpriteComps1047 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1047"]) and arg_185_1.var_.actorSpriteComps1047 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1047 = nil
			end

			local var_188_2 = 0
			local var_188_3 = 0.075

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(926011045).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 3 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 3)

				if (3 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 3)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926011046
		arg_189_1.duration_ = 10.37

		local var_189_0 = {
			zh = 6.2,
			ja = 10.366
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
				arg_189_0:Play926011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1047"]) and arg_189_1.var_.actorSpriteComps1047 == nil then
				arg_189_1.var_.actorSpriteComps1047 = arg_189_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1047"]) then
				if arg_189_1.var_.actorSpriteComps1047 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1047"]) and arg_189_1.var_.actorSpriteComps1047 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1047 = nil
			end

			local var_192_2 = 0
			local var_192_3 = 0.75

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(926011046)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 30 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 30)

				if (30 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 30)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011046", "story_v_out_926011.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011046", "story_v_out_926011.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_out_926011", "926011046", "story_v_out_926011.awb")

						arg_189_1:RecordAudio("926011046", var_192_9)
						arg_189_1:RecordAudio("926011046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_926011", "926011046", "story_v_out_926011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_926011", "926011046", "story_v_out_926011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play926011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926011047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play926011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1047"]) and arg_193_1.var_.actorSpriteComps1047 == nil then
				arg_193_1.var_.actorSpriteComps1047 = arg_193_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1047"]) then
				if arg_193_1.var_.actorSpriteComps1047 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1047"]) and arg_193_1.var_.actorSpriteComps1047 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1047 = nil
			end

			local var_196_2 = arg_193_1.actors_["1047"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1047 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1047", 7)

				for iter_196_4 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_4)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_5 = 0
			local var_196_6 = 1.125

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(926011047).content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 45 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_7) / 45)

				if (45 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_7) / 45)) > 0 and var_196_6 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_10 and arg_193_1.time_ < var_196_5 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926011048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play926011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(926011048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 23 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 23)

				if (23 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 23)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play926011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926011049
		arg_201_1.duration_ = 7.37

		local var_201_0 = {
			zh = 5.066,
			ja = 7.366
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
				arg_201_0:Play926011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1047"]) and arg_201_1.var_.actorSpriteComps1047 == nil then
				arg_201_1.var_.actorSpriteComps1047 = arg_201_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1047"]) then
				if arg_201_1.var_.actorSpriteComps1047 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1047"]) and arg_201_1.var_.actorSpriteComps1047 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps1047 = nil
			end

			local var_204_2 = arg_201_1.actors_["1047"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1047 = var_204_2.localPosition
				var_204_2.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1047", 2)

				for iter_204_4 = 0, var_204_2.childCount - 1 do
					local var_204_3 = var_204_2:GetChild(iter_204_4)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_201_1.time_ - 0) / var_204_4)
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_204_5 = 0
			local var_204_6 = 0.45

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(926011049)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 18 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 18)

				if (18 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 18)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011049", "story_v_out_926011.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011049", "story_v_out_926011.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_926011", "926011049", "story_v_out_926011.awb")

						arg_201_1:RecordAudio("926011049", var_204_12)
						arg_201_1:RecordAudio("926011049", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926011", "926011049", "story_v_out_926011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926011", "926011049", "story_v_out_926011.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_13 and arg_201_1.time_ < var_204_5 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play926011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926011050
		arg_205_1.duration_ = 4.5

		local var_205_0 = {
			zh = 4.5,
			ja = 4.433
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
				arg_205_0:Play926011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10102"]) and arg_205_1.var_.actorSpriteComps10102 == nil then
				arg_205_1.var_.actorSpriteComps10102 = arg_205_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10102"]) then
				if arg_205_1.var_.actorSpriteComps10102 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 1, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10102"]) and arg_205_1.var_.actorSpriteComps10102 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10102 = nil
			end

			local var_208_2 = arg_205_1.actors_["1047"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1047 == nil then
				arg_205_1.var_.actorSpriteComps1047 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1047 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								iter_208_5.color = Color.New(Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_5.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_5.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1047 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_208_7 then
						iter_208_7.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1047 = nil
			end

			local var_208_5 = arg_205_1.actors_["10102"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10102 = var_208_5.localPosition
				var_208_5.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10102", 4)

				for iter_208_8 = 0, var_208_5.childCount - 1 do
					local var_208_6 = var_208_5:GetChild(iter_208_8)

					if var_208_6.name == "" or not string.find(var_208_6.name, "split") then
						var_208_6.gameObject:SetActive(true)
					else
						var_208_6.gameObject:SetActive(false)
					end
				end
			end

			local var_208_7 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				var_208_5.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10102, Vector3.New(369, -354.2, -425.9), (arg_205_1.time_ - 0) / var_208_7)
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				var_208_5.localPosition = Vector3.New(369, -354.2, -425.9)
			end

			local var_208_8 = 0
			local var_208_9 = 0.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(926011050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 15 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 15)

				if (15 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 15)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011050", "story_v_out_926011.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011050", "story_v_out_926011.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_926011", "926011050", "story_v_out_926011.awb")

						arg_205_1:RecordAudio("926011050", var_208_15)
						arg_205_1:RecordAudio("926011050", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926011", "926011050", "story_v_out_926011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926011", "926011050", "story_v_out_926011.awb")
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
				actorName = "10102",
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
	Play926011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926011051
		arg_209_1.duration_ = 14.7

		local var_209_0 = {
			zh = 12.4,
			ja = 14.7
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play926011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1047"]) and arg_209_1.var_.actorSpriteComps1047 == nil then
				arg_209_1.var_.actorSpriteComps1047 = arg_209_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1047"]) then
				if arg_209_1.var_.actorSpriteComps1047 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 1, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1047"]) and arg_209_1.var_.actorSpriteComps1047 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1047 = nil
			end

			local var_212_2 = arg_209_1.actors_["10102"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10102 == nil then
				arg_209_1.var_.actorSpriteComps10102 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps10102 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								iter_212_5.color = Color.New(Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_5.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_5.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10102 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_212_7 then
						iter_212_7.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10102 = nil
			end

			local var_212_5 = 0
			local var_212_6 = 1.725

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_7 = arg_209_1:GetWordFromCfg(926011051)
				local var_212_8 = arg_209_1:FormatText(var_212_7.content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 69 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 69)

				if (69 <= 0 and var_212_6 or var_212_6 * (utf8.len(var_212_8) / 69)) > 0 and var_212_6 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_5
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011051", "story_v_out_926011.awb") ~= 0 then
					local var_212_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011051", "story_v_out_926011.awb") / 1000

					if var_212_11 + var_212_5 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_5
					end

					if var_212_7.prefab_name ~= "" and arg_209_1.actors_[var_212_7.prefab_name] ~= nil then
						local var_212_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_7.prefab_name].transform, "story_v_out_926011", "926011051", "story_v_out_926011.awb")

						arg_209_1:RecordAudio("926011051", var_212_12)
						arg_209_1:RecordAudio("926011051", var_212_12)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_926011", "926011051", "story_v_out_926011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_926011", "926011051", "story_v_out_926011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_13 = math.max(var_212_6, arg_209_1.talkMaxDuration)

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_13 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_5) / var_212_13

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_5 + var_212_13 and arg_209_1.time_ < var_212_5 + var_212_13 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play926011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926011052
		arg_213_1.duration_ = 1

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"

			SetActive(arg_213_1.choicesGo_, true)

			for iter_214_0, iter_214_1 in ipairs(arg_213_1.choices_) do
				SetActive(iter_214_1.go, iter_214_0 <= 2)
			end

			arg_213_1.choices_[1].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1307].name)
			arg_213_1.choices_[2].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1308].name)
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play926011053(arg_213_1)
			end

			if arg_215_0 == 2 then
				arg_213_0:Play926011053(arg_213_1)
			end

			arg_213_1:RecordChoiceLog(926011052, 1307, 1308)
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1047"]) and arg_213_1.var_.actorSpriteComps1047 == nil then
				arg_213_1.var_.actorSpriteComps1047 = arg_213_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1047"]) then
				if arg_213_1.var_.actorSpriteComps1047 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1047"]) and arg_213_1.var_.actorSpriteComps1047 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps1047 = nil
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play926011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926011053
		arg_217_1.duration_ = 8.33

		local var_217_0 = {
			zh = 6.4,
			ja = 8.333
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
				arg_217_0:Play926011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1047"]) and arg_217_1.var_.actorSpriteComps1047 == nil then
				arg_217_1.var_.actorSpriteComps1047 = arg_217_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1047"]) then
				if arg_217_1.var_.actorSpriteComps1047 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 1, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1047"]) and arg_217_1.var_.actorSpriteComps1047 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps1047 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.75

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(926011053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 30 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 30)

				if (30 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 30)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011053", "story_v_out_926011.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011053", "story_v_out_926011.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_926011", "926011053", "story_v_out_926011.awb")

						arg_217_1:RecordAudio("926011053", var_220_9)
						arg_217_1:RecordAudio("926011053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926011", "926011053", "story_v_out_926011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926011", "926011053", "story_v_out_926011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play926011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926011054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play926011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1047"]) and arg_221_1.var_.actorSpriteComps1047 == nil then
				arg_221_1.var_.actorSpriteComps1047 = arg_221_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1047"]) then
				if arg_221_1.var_.actorSpriteComps1047 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1047"]) and arg_221_1.var_.actorSpriteComps1047 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps1047 = nil
			end

			local var_224_2 = 0
			local var_224_3 = 0.175

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_4 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(926011054).content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 7 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 7)

				if (7 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 7)) > 0 and var_224_3 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_7 and arg_221_1.time_ < var_224_2 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926011055
		arg_225_1.duration_ = 4.37

		local var_225_0 = {
			zh = 3.333,
			ja = 4.366
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play926011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10102"]) and arg_225_1.var_.actorSpriteComps10102 == nil then
				arg_225_1.var_.actorSpriteComps10102 = arg_225_1.actors_["10102"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10102"]) then
				if arg_225_1.var_.actorSpriteComps10102 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 1, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10102"]) and arg_225_1.var_.actorSpriteComps10102 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10102 = nil
			end

			local var_228_2 = 0
			local var_228_3 = 0.3

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(926011055)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 12 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 12)

				if (12 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 12)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011055", "story_v_out_926011.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011055", "story_v_out_926011.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_926011", "926011055", "story_v_out_926011.awb")

						arg_225_1:RecordAudio("926011055", var_228_9)
						arg_225_1:RecordAudio("926011055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926011", "926011055", "story_v_out_926011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926011", "926011055", "story_v_out_926011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play926011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926011056
		arg_229_1.duration_ = 12

		local var_229_0 = {
			zh = 8.533,
			ja = 12
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play926011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1047"]) and arg_229_1.var_.actorSpriteComps1047 == nil then
				arg_229_1.var_.actorSpriteComps1047 = arg_229_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1047"]) then
				if arg_229_1.var_.actorSpriteComps1047 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 1, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1047"]) and arg_229_1.var_.actorSpriteComps1047 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1047 = nil
			end

			local var_232_2 = arg_229_1.actors_["10102"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps10102 == nil then
				arg_229_1.var_.actorSpriteComps10102 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps10102 then
					for iter_232_4, iter_232_5 in pairs(arg_229_1.var_.actorSpriteComps10102:ToTable()) do
						if iter_232_5 then
							if arg_229_1.isInRecall_ then
								iter_232_5.color = Color.New(Mathf.Lerp(iter_232_5.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_3), Mathf.Lerp(iter_232_5.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_3), (Mathf.Lerp(iter_232_5.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_3)))
							else
								local var_232_4 = Mathf.Lerp(iter_232_5.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_3)

								iter_232_5.color = Color.New(var_232_4, var_232_4, var_232_4)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps10102 then
				for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10102:ToTable()) do
					if iter_232_7 then
						iter_232_7.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10102 = nil
			end

			local var_232_5 = arg_229_1.actors_["1047"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047 = var_232_5.localPosition
				var_232_5.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1047", 2)

				for iter_232_8 = 0, var_232_5.childCount - 1 do
					local var_232_6 = var_232_5:GetChild(iter_232_8)

					if var_232_6.name == "split_2" or not string.find(var_232_6.name, "split") then
						var_232_6.gameObject:SetActive(true)
					else
						var_232_6.gameObject:SetActive(false)
					end
				end
			end

			local var_232_7 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				var_232_5.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047, Vector3.New(-489.8, -360, -319.3), (arg_229_1.time_ - 0) / var_232_7)
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				var_232_5.localPosition = Vector3.New(-489.8, -360, -319.3)
			end

			local var_232_8 = 0
			local var_232_9 = 0.9

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(926011056)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 36 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 36)

				if (36 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 36)) > 0 and var_232_9 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011056", "story_v_out_926011.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011056", "story_v_out_926011.awb") / 1000

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_out_926011", "926011056", "story_v_out_926011.awb")

						arg_229_1:RecordAudio("926011056", var_232_15)
						arg_229_1:RecordAudio("926011056", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_926011", "926011056", "story_v_out_926011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_926011", "926011056", "story_v_out_926011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_16 and arg_229_1.time_ < var_232_8 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play926011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926011057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play926011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1047"]) and arg_233_1.var_.actorSpriteComps1047 == nil then
				arg_233_1.var_.actorSpriteComps1047 = arg_233_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1047"]) then
				if arg_233_1.var_.actorSpriteComps1047 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1047"]) and arg_233_1.var_.actorSpriteComps1047 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps1047 = nil
			end

			local var_236_2 = arg_233_1.actors_["1047"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047 = var_236_2.localPosition
				var_236_2.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1047", 7)

				for iter_236_4 = 0, var_236_2.childCount - 1 do
					local var_236_3 = var_236_2:GetChild(iter_236_4)

					if var_236_3.name == "" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_2.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_233_1.time_ - 0) / var_236_4)
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_236_5 = arg_233_1.actors_["10102"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10102 = var_236_5.localPosition
				var_236_5.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10102", 7)

				for iter_236_5 = 0, var_236_5.childCount - 1 do
					local var_236_6 = var_236_5:GetChild(iter_236_5)

					if var_236_6.name == "" or not string.find(var_236_6.name, "split") then
						var_236_6.gameObject:SetActive(true)
					else
						var_236_6.gameObject:SetActive(false)
					end
				end
			end

			local var_236_7 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				var_236_5.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10102, Vector3.New(0, -2000, 0), (arg_233_1.time_ - 0) / var_236_7)
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				var_236_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_236_8 = 0
			local var_236_9 = 0.95

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(926011057).content)

				arg_233_1.text_.text = var_236_10

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_12 = 38 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_10) / 38)

				if (38 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_10) / 38)) > 0 and var_236_9 < var_236_12 then
					arg_233_1.talkMaxDuration = var_236_12

					if var_236_12 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_10
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_13 and arg_233_1.time_ < var_236_8 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play926011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926011058
		arg_237_1.duration_ = 4.87

		local var_237_0 = {
			zh = 4.866,
			ja = 4.7
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
				arg_237_0:Play926011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1047"]) and arg_237_1.var_.actorSpriteComps1047 == nil then
				arg_237_1.var_.actorSpriteComps1047 = arg_237_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1047"]) then
				if arg_237_1.var_.actorSpriteComps1047 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 1, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1047"]) and arg_237_1.var_.actorSpriteComps1047 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps1047 = nil
			end

			local var_240_2 = arg_237_1.actors_["1047"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1047 = var_240_2.localPosition
				var_240_2.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1047", 3)

				for iter_240_4 = 0, var_240_2.childCount - 1 do
					local var_240_3 = var_240_2:GetChild(iter_240_4)

					if var_240_3.name == "" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_2.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_237_1.time_ - 0) / var_240_4)
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_240_5 = 0
			local var_240_6 = 0.6

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_5 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_7 = arg_237_1:GetWordFromCfg(926011058)
				local var_240_8 = arg_237_1:FormatText(var_240_7.content)

				arg_237_1.text_.text = var_240_8

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 24 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 24)

				if (24 <= 0 and var_240_6 or var_240_6 * (utf8.len(var_240_8) / 24)) > 0 and var_240_6 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_5
					end
				end

				arg_237_1.text_.text = var_240_8
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011058", "story_v_out_926011.awb") ~= 0 then
					local var_240_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011058", "story_v_out_926011.awb") / 1000

					if var_240_11 + var_240_5 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_5
					end

					if var_240_7.prefab_name ~= "" and arg_237_1.actors_[var_240_7.prefab_name] ~= nil then
						local var_240_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_7.prefab_name].transform, "story_v_out_926011", "926011058", "story_v_out_926011.awb")

						arg_237_1:RecordAudio("926011058", var_240_12)
						arg_237_1:RecordAudio("926011058", var_240_12)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_926011", "926011058", "story_v_out_926011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_926011", "926011058", "story_v_out_926011.awb")
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
				actorName = "1047",
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
	Play926011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926011059
		arg_241_1.duration_ = 10.63

		local var_241_0 = {
			zh = 7.066,
			ja = 10.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play926011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(926011059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 32 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 32)

				if (32 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 32)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011059", "story_v_out_926011.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011059", "story_v_out_926011.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_926011", "926011059", "story_v_out_926011.awb")

						arg_241_1:RecordAudio("926011059", var_244_6)
						arg_241_1:RecordAudio("926011059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926011", "926011059", "story_v_out_926011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926011", "926011059", "story_v_out_926011.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play926011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926011060
		arg_245_1.duration_ = 8.25

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play926011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if arg_245_1.bgs_.STblack == nil then
				local var_248_0 = Object.Instantiate(arg_245_1.paintGo_)

				var_248_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_248_0.name = "STblack"
				var_248_0.transform.parent = arg_245_1.stage_.transform
				var_248_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.bgs_.STblack = var_248_0
			end

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 then
				local var_248_1 = arg_245_1.bgs_.STblack

				arg_245_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_2 = var_248_1:GetComponent("SpriteRenderer")

				if var_248_2 and var_248_2.sprite then
					local var_248_3 = 2 * (var_248_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_1.transform.localScale = Vector3.New(var_248_3 / var_248_2.sprite.bounds.size.y < var_248_3 * manager.ui.mainCameraCom_.aspect / var_248_2.sprite.bounds.size.x and var_248_3 * manager.ui.mainCameraCom_.aspect / var_248_2.sprite.bounds.size.x or var_248_3 / var_248_2.sprite.bounds.size.y, var_248_3 / var_248_2.sprite.bounds.size.y < var_248_3 * manager.ui.mainCameraCom_.aspect / var_248_2.sprite.bounds.size.x and var_248_3 * manager.ui.mainCameraCom_.aspect / var_248_2.sprite.bounds.size.x or var_248_3 / var_248_2.sprite.bounds.size.y, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "STblack" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_4 = 1.3

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_4 + 0.3 and arg_245_1.time_ < var_248_4 + 0.3 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_5 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_6 = 1.3

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_6 then
				local var_248_7 = Color.New(0, 0, 0)

				var_248_7.a = Mathf.Lerp(0, 1, (arg_245_1.time_ - var_248_5) / var_248_6)
				arg_245_1.mask_.color = var_248_7
			end

			if arg_245_1.time_ >= var_248_5 + var_248_6 and arg_245_1.time_ < var_248_5 + var_248_6 + arg_248_0 then
				local var_248_8 = Color.New(0, 0, 0)

				var_248_8.a = 1
				arg_245_1.mask_.color = var_248_8
			end

			local var_248_9 = 1.3

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_10 = 2

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_10 then
				local var_248_11 = Color.New(0, 0, 0)

				var_248_11.a = Mathf.Lerp(1, 0, (arg_245_1.time_ - var_248_9) / var_248_10)
				arg_245_1.mask_.color = var_248_11
			end

			if arg_245_1.time_ >= var_248_9 + var_248_10 and arg_245_1.time_ < var_248_9 + var_248_10 + arg_248_0 then
				local var_248_12 = Color.New(0, 0, 0)

				arg_245_1.mask_.enabled = false
				var_248_12.a = 0
				arg_245_1.mask_.color = var_248_12
			end

			local var_248_13 = arg_245_1.actors_["1047"]

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.actorSpriteComps1047 == nil then
				arg_245_1.var_.actorSpriteComps1047 = var_248_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_14 = 0.2

			if 1.3 <= arg_245_1.time_ and arg_245_1.time_ < 1.3 + var_248_14 and not isNil(var_248_13) then
				if arg_245_1.var_.actorSpriteComps1047 then
					for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_248_3 then
							if arg_245_1.isInRecall_ then
								iter_248_3.color = Color.New(Mathf.Lerp(iter_248_3.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 1.3) / var_248_14), Mathf.Lerp(iter_248_3.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 1.3) / var_248_14), (Mathf.Lerp(iter_248_3.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 1.3) / var_248_14)))
							else
								local var_248_15 = Mathf.Lerp(iter_248_3.color.r, 0.5, (arg_245_1.time_ - 1.3) / var_248_14)

								iter_248_3.color = Color.New(var_248_15, var_248_15, var_248_15)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 1.3 + var_248_14 and arg_245_1.time_ < 1.3 + var_248_14 + arg_248_0 and not isNil(var_248_13) and arg_245_1.var_.actorSpriteComps1047 then
				for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_248_5 then
						iter_248_5.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1047 = nil
			end

			local var_248_16 = arg_245_1.actors_["1047"].transform

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 then
				arg_245_1.var_.moveOldPos1047 = var_248_16.localPosition
				var_248_16.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1047", 7)

				for iter_248_6 = 0, var_248_16.childCount - 1 do
					local var_248_17 = var_248_16:GetChild(iter_248_6)

					if var_248_17.name == "" or not string.find(var_248_17.name, "split") then
						var_248_17.gameObject:SetActive(true)
					else
						var_248_17.gameObject:SetActive(false)
					end
				end
			end

			local var_248_18 = 0.001

			if 1.3 <= arg_245_1.time_ and arg_245_1.time_ < 1.3 + var_248_18 then
				var_248_16.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_245_1.time_ - 1.3) / var_248_18)
			end

			if arg_245_1.time_ >= 1.3 + var_248_18 and arg_245_1.time_ < 1.3 + var_248_18 + arg_248_0 then
				var_248_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_248_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_245_1.bgmTxt_.text ~= var_248_21 and arg_245_1.bgmTxt_.text ~= "" then
						if arg_245_1.bgmTxt2_.text ~= "" then
							arg_245_1.bgmTxt_.text = arg_245_1.bgmTxt2_.text
						end

						arg_245_1.bgmTxt2_.text = var_248_21

						arg_245_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_245_1.bgmTxt_.text = var_248_21
						arg_245_1.bgmTxt2_.text = var_248_21
					end

					if arg_245_1.bgmTimer then
						arg_245_1.bgmTimer:Stop()

						arg_245_1.bgmTimer = nil
					end

					if arg_245_1.settingData.show_music_name == 1 then
						arg_245_1.musicController:SetSelectedState("show")
						arg_245_1.musicAnimator_:Play("open", 0, 0)

						if arg_245_1.settingData.music_time ~= 0 then
							arg_245_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_245_1.settingData.music_time), function()
								if arg_245_1 == nil or isNil(arg_245_1.bgmTxt_) then
									return
								end

								arg_245_1.musicController:SetSelectedState("hide")
								arg_245_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.334 < arg_245_1.time_ and arg_245_1.time_ <= 1.334 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_143", "se_story_143_hungry01", "")
			end

			if 0.166666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 0.166666666666667 + arg_248_0 then
				arg_245_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 0.966666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 0.966666666666667 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_25 = 3.25
			local var_248_26 = 0.05

			if 3.25 < arg_245_1.time_ and arg_245_1.time_ <= var_248_25 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_27 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_27:setOnUpdate(LuaHelper.FloatAction(function(arg_250_0)
					arg_245_1.dialogCg_.alpha = arg_250_0
				end))
				var_248_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_28 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(926011060).content)

				arg_245_1.text_.text = var_248_28

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_30 = 2 <= 0 and var_248_26 or var_248_26 * (utf8.len(var_248_28) / 2)

				if (2 <= 0 and var_248_26 or var_248_26 * (utf8.len(var_248_28) / 2)) > 0 and var_248_26 < var_248_30 then
					arg_245_1.talkMaxDuration = var_248_30
					var_248_25 = var_248_25 + 0.3

					if var_248_30 + var_248_25 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_25
					end
				end

				arg_245_1.text_.text = var_248_28
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_31 = var_248_25 + 0.3
			local var_248_32 = math.max(var_248_26, arg_245_1.talkMaxDuration)

			if var_248_25 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_31 + var_248_32 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_31) / var_248_32

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_31 + var_248_32 and arg_245_1.time_ < var_248_31 + var_248_32 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play926011061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 926011061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play926011062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_143", "se_story_143_hungry02", "")
			end

			local var_255_1 = 0
			local var_255_2 = 0.1

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(926011061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 4 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 4)

				if (4 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 4)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play926011062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 926011062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play926011063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.15

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(926011062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 6 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 6)

				if (6 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 6)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play926011063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 926011063
		arg_260_1.duration_ = 8.43

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play926011064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_9000

			if arg_260_1.bgs_.I22f == nil then
				local var_263_0 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I22f")
				var_263_0.name = "I22f"
				var_263_0.transform.parent = arg_260_1.stage_.transform
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_.I22f = var_263_0
			end

			if 1.43333333333333 < arg_260_1.time_ and arg_260_1.time_ <= 1.43333333333333 + arg_263_0 then
				local var_263_1 = arg_260_1.bgs_.I22f

				arg_260_1.bgs_.I22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_2 = var_263_1:GetComponent("SpriteRenderer")

				if var_263_2 and var_263_2.sprite then
					local var_263_3 = 2 * (var_263_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_1.transform.localScale = Vector3.New(var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "I22f" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_4 = 1.43333333333333

			if 1.43333333333333 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			if arg_260_1.time_ >= var_263_4 + 0.3 and arg_260_1.time_ < var_263_4 + 0.3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_5 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_6 = 1.43333333333333

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_6 then
				local var_263_7 = Color.New(0, 0, 0)

				var_263_7.a = Mathf.Lerp(0, 1, (arg_260_1.time_ - var_263_5) / var_263_6)
				arg_260_1.mask_.color = var_263_7
			end

			if arg_260_1.time_ >= var_263_5 + var_263_6 and arg_260_1.time_ < var_263_5 + var_263_6 + arg_263_0 then
				local var_263_8 = Color.New(0, 0, 0)

				var_263_8.a = 1
				arg_260_1.mask_.color = var_263_8
			end

			local var_263_9 = 1.43333333333333

			if 1.43333333333333 < arg_260_1.time_ and arg_260_1.time_ <= var_263_9 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_10 = 1.23333333333333

			if var_263_9 <= arg_260_1.time_ and arg_260_1.time_ < var_263_9 + var_263_10 then
				local var_263_11 = Color.New(1, 1, 1)

				var_263_11.a = Mathf.Lerp(1, 0, (arg_260_1.time_ - var_263_9) / var_263_10)
				arg_260_1.mask_.color = var_263_11
			end

			if arg_260_1.time_ >= var_263_9 + var_263_10 and arg_260_1.time_ < var_263_9 + var_263_10 + arg_263_0 then
				local var_263_12 = Color.New(1, 1, 1)

				arg_260_1.mask_.enabled = false
				var_263_12.a = 0
				arg_260_1.mask_.color = var_263_12
			end

			if 1.96666666666667 < arg_260_1.time_ and arg_260_1.time_ <= 1.96666666666667 + arg_263_0 then
				local var_263_13 = arg_260_1.var_.effect333

				if not arg_260_1.var_.effect333 then
					var_263_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_263_13.name = "333"
					arg_260_1.var_.effect333 = var_263_13
				else
					var_263_13.transform:SetParent(var_263_9000)
				end

				var_263_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_263_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_263_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_263_16 = var_263_13.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_263_2, iter_263_3 in ipairs((var_263_16:ToTable())) do
					iter_263_3.transform.localScale = Vector3.New(iter_263_3.transform.localScale.x / var_263_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_263_16 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_263_3.transform.localScale.y / var_263_15, iter_263_3.transform.localScale.z)
				end
			end

			if 1.33333333333333 < arg_260_1.time_ and arg_260_1.time_ <= 1.33333333333333 + arg_263_0 then
				arg_260_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_20 = 3.43333333333333
			local var_263_21 = 1.35

			if 3.43333333333333 < arg_260_1.time_ and arg_260_1.time_ <= var_263_20 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_22 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_22:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_23 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(926011063).content)

				arg_260_1.text_.text = var_263_23

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_25 = 54 <= 0 and var_263_21 or var_263_21 * (utf8.len(var_263_23) / 54)

				if (54 <= 0 and var_263_21 or var_263_21 * (utf8.len(var_263_23) / 54)) > 0 and var_263_21 < var_263_25 then
					arg_260_1.talkMaxDuration = var_263_25
					var_263_20 = var_263_20 + 0.3

					if var_263_25 + var_263_20 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_25 + var_263_20
					end
				end

				arg_260_1.text_.text = var_263_23
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_26 = var_263_20 + 0.3
			local var_263_27 = math.max(var_263_21, arg_260_1.talkMaxDuration)

			if var_263_20 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_26 + var_263_27 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_26) / var_263_27

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_26 + var_263_27 and arg_260_1.time_ < var_263_26 + var_263_27 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play926011064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 926011064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play926011065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.35

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(926011064).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 14 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 14)

				if (14 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 14)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play926011065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 926011065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play926011066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(926011065).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)

				if (11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play926011066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 926011066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play926011067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.05

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(926011066).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 42 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 42)

				if (42 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 42)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play926011067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 926011067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play926011068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(926011067).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)

				if (20 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 20)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play926011068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 926011068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play926011069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.55

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(926011068).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 22 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 22)

				if (22 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 22)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play926011069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 926011069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play926011070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_143", "se_story_143_hungry01", "")
			end

			local var_289_1 = 0
			local var_289_2 = 1.225

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(926011069).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 49 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 49)

				if (49 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 49)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play926011070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 926011070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play926011071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.85

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(926011070).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 34 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 34)

				if (34 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 34)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play926011071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 926011071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play926011072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.825

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(926011071).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 33 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 33)

				if (33 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 33)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play926011072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 926011072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play926011073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.35

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(926011072).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 14 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 14)

				if (14 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 14)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play926011073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 926011073
		arg_302_1.duration_ = 6

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play926011074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				local var_305_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_0 then
					var_305_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_0.radialBlurScale = 0.687
					var_305_0.radialBlurGradient = 1
					var_305_0.radialBlurIntensity = 1

					if nil then
						var_305_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_305_1 = 1

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_1 then
				local var_305_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_2 then
					var_305_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_2.radialBlurScale = Mathf.Lerp(0.687, 0, (arg_302_1.time_ - 0) / var_305_1)
					var_305_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_302_1.time_ - 0) / var_305_1)
					var_305_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_302_1.time_ - 0) / var_305_1)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_1 and arg_302_1.time_ < 0 + var_305_1 + arg_305_0 then
				local var_305_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_3 then
					var_305_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_305_3.radialBlurScale = 0
					var_305_3.radialBlurGradient = 1
					var_305_3.radialBlurIntensity = 1
				end
			end

			local var_305_4

			if 1.7 < arg_302_1.time_ and arg_302_1.time_ <= 1.7 + arg_305_0 then
				local var_305_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_5 then
					var_305_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_5.radialBlurScale = 0
					var_305_5.radialBlurGradient = 1
					var_305_5.radialBlurIntensity = 1

					if var_305_4 then
						var_305_5.radialBlurTarget = var_305_4.transform
					end
				end
			end

			local var_305_6 = 0.8

			if 1.7 <= arg_302_1.time_ and arg_302_1.time_ < 1.7 + var_305_6 then
				local var_305_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_7 then
					var_305_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_7.radialBlurScale = Mathf.Lerp(0, 0, (arg_302_1.time_ - 1.7) / var_305_6)
					var_305_7.radialBlurGradient = Mathf.Lerp(1, 1, (arg_302_1.time_ - 1.7) / var_305_6)
					var_305_7.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_302_1.time_ - 1.7) / var_305_6)
				end
			end

			if arg_302_1.time_ >= 1.7 + var_305_6 and arg_302_1.time_ < 1.7 + var_305_6 + arg_305_0 then
				local var_305_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_305_8 then
					var_305_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_305_8.radialBlurScale = 0
					var_305_8.radialBlurGradient = 1
					var_305_8.radialBlurIntensity = 1
				end
			end

			local var_305_9 = 0

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			if arg_302_1.time_ >= var_305_9 + 2.1 and arg_302_1.time_ < var_305_9 + 2.1 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_10 = "128404"

			if arg_302_1.actors_["128404"] == nil then
				local var_305_11 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_305_11) then
					local var_305_12 = Object.Instantiate(var_305_11, arg_302_1.canvasGo_.transform)

					var_305_12.transform:SetSiblingIndex(1)

					var_305_12.name = var_305_10
					var_305_12.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_302_1.actors_[var_305_10] = var_305_12

					if arg_302_1.isInRecall_ then
						for iter_305_0, iter_305_1 in ipairs((var_305_12:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_305_1.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_305_13 = arg_302_1.actors_["128404"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos128404 = var_305_13.localPosition
				var_305_13.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("128404", 7)

				for iter_305_2 = 0, var_305_13.childCount - 1 do
					local var_305_14 = var_305_13:GetChild(iter_305_2)

					if var_305_14.name == "split_4" or not string.find(var_305_14.name, "split") then
						var_305_14.gameObject:SetActive(true)
					else
						var_305_14.gameObject:SetActive(false)
					end
				end
			end

			local var_305_15 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_15 then
				var_305_13.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_302_1.time_ - 0) / var_305_15)
			end

			if arg_302_1.time_ >= 0 + var_305_15 and arg_302_1.time_ < 0 + var_305_15 + arg_305_0 then
				var_305_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_16 = 1
			local var_305_17 = 0.95

			if 1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_18 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_18:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_19 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(926011073).content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 38 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_19) / 38)

				if (38 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_19) / 38)) > 0 and var_305_17 < var_305_21 then
					arg_302_1.talkMaxDuration = var_305_21
					var_305_16 = var_305_16 + 0.3

					if var_305_21 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_21 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_22 = var_305_16 + 0.3
			local var_305_23 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 + 0.3 <= arg_302_1.time_ and arg_302_1.time_ < var_305_22 + var_305_23 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_22) / var_305_23

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_22 + var_305_23 and arg_302_1.time_ < var_305_22 + var_305_23 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play926011074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 926011074
		arg_308_1.duration_ = 2.33

		local var_308_0 = {
			zh = 1.881526200798,
			ja = 2.33333333333333
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
				arg_308_0:Play926011075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_9000

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["128404"]) and arg_308_1.var_.actorSpriteComps128404 == nil then
				arg_308_1.var_.actorSpriteComps128404 = arg_308_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["128404"]) then
				if arg_308_1.var_.actorSpriteComps128404 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["128404"]) and arg_308_1.var_.actorSpriteComps128404 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps128404 = nil
			end

			local var_311_2 = arg_308_1.actors_["128404"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos128404 = var_311_2.localPosition
				var_311_2.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("128404", 3)

				for iter_311_4 = 0, var_311_2.childCount - 1 do
					local var_311_3 = var_311_2:GetChild(iter_311_4)

					if var_311_3.name == "split_5" or not string.find(var_311_3.name, "split") then
						var_311_3.gameObject:SetActive(true)
					else
						var_311_3.gameObject:SetActive(false)
					end
				end
			end

			local var_311_4 = 0.233333333333333

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_2.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos128404, Vector3.New(-31.8, -406.9, -1238), (arg_308_1.time_ - 0) / var_311_4)
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_2.localPosition = Vector3.New(-31.8, -406.9, -1238)
			end

			local var_311_5

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				local var_311_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_6 then
					var_311_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_6.radialBlurScale = 0.687
					var_311_6.radialBlurGradient = 1
					var_311_6.radialBlurIntensity = 1

					if var_311_5 then
						var_311_6.radialBlurTarget = var_311_5.transform
					end
				end
			end

			local var_311_7 = 1

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				local var_311_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_8 then
					var_311_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_8.radialBlurScale = Mathf.Lerp(0.687, 0, (arg_308_1.time_ - 0) / var_311_7)
					var_311_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_308_1.time_ - 0) / var_311_7)
					var_311_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_308_1.time_ - 0) / var_311_7)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				local var_311_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_9 then
					var_311_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_311_9.radialBlurScale = 0
					var_311_9.radialBlurGradient = 1
					var_311_9.radialBlurIntensity = 1
				end
			end

			local var_311_10

			if 1.08152620079927 < arg_308_1.time_ and arg_308_1.time_ <= 1.08152620079927 + arg_311_0 then
				local var_311_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_11 then
					var_311_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_11.radialBlurScale = 0
					var_311_11.radialBlurGradient = 1
					var_311_11.radialBlurIntensity = 1

					if var_311_10 then
						var_311_11.radialBlurTarget = var_311_10.transform
					end
				end
			end

			local var_311_12 = 0.8

			if 1.08152620079927 <= arg_308_1.time_ and arg_308_1.time_ < 1.08152620079927 + var_311_12 then
				local var_311_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_13 then
					var_311_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_13.radialBlurScale = Mathf.Lerp(0, 0, (arg_308_1.time_ - 1.08152620079927) / var_311_12)
					var_311_13.radialBlurGradient = Mathf.Lerp(1, 1, (arg_308_1.time_ - 1.08152620079927) / var_311_12)
					var_311_13.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_308_1.time_ - 1.08152620079927) / var_311_12)
				end
			end

			if arg_308_1.time_ >= 1.08152620079927 + var_311_12 and arg_308_1.time_ < 1.08152620079927 + var_311_12 + arg_311_0 then
				local var_311_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_311_14 then
					var_311_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_311_14.radialBlurScale = 0
					var_311_14.radialBlurGradient = 1
					var_311_14.radialBlurIntensity = 1
				end
			end

			local var_311_15 = 0

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			if arg_308_1.time_ >= var_311_15 + 0.8 and arg_308_1.time_ < var_311_15 + 0.8 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			if 0.0666666666666667 < arg_308_1.time_ and arg_308_1.time_ <= 0.0666666666666667 + arg_311_0 then
				local var_311_16 = arg_308_1.var_.effect1234

				if not arg_308_1.var_.effect1234 then
					var_311_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_311_16.name = "1234"
					arg_308_1.var_.effect1234 = var_311_16
				else
					var_311_16.transform:SetParent(var_311_9000)
				end

				var_311_16.transform.localPosition = Vector3.New(0, 0, -1.05)
				var_311_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_311_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_311_19 = var_311_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_311_5, iter_311_6 in ipairs((var_311_19:ToTable())) do
					iter_311_6.transform.localScale = Vector3.New(iter_311_6.transform.localScale.x / var_311_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_311_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_311_6.transform.localScale.y / var_311_18, iter_311_6.transform.localScale.z)
				end
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:AudioAction("play", "effect", "se_story_143", "se_story_143_foley_cloth02", "")
			end

			local var_311_22 = 0.433333333333333
			local var_311_23 = 0.1

			if 0.433333333333333 < arg_308_1.time_ and arg_308_1.time_ <= var_311_22 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_24 = arg_308_1:GetWordFromCfg(926011074)
				local var_311_25 = arg_308_1:FormatText(var_311_24.content)

				arg_308_1.text_.text = var_311_25

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_27 = 4 <= 0 and var_311_23 or var_311_23 * (utf8.len(var_311_25) / 4)

				if (4 <= 0 and var_311_23 or var_311_23 * (utf8.len(var_311_25) / 4)) > 0 and var_311_23 < var_311_27 then
					arg_308_1.talkMaxDuration = var_311_27

					if var_311_27 + var_311_22 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_27 + var_311_22
					end
				end

				arg_308_1.text_.text = var_311_25
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011074", "story_v_out_926011.awb") ~= 0 then
					local var_311_28 = manager.audio:GetVoiceLength("story_v_out_926011", "926011074", "story_v_out_926011.awb") / 1000

					if var_311_28 + var_311_22 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_28 + var_311_22
					end

					if var_311_24.prefab_name ~= "" and arg_308_1.actors_[var_311_24.prefab_name] ~= nil then
						local var_311_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_24.prefab_name].transform, "story_v_out_926011", "926011074", "story_v_out_926011.awb")

						arg_308_1:RecordAudio("926011074", var_311_29)
						arg_308_1:RecordAudio("926011074", var_311_29)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_926011", "926011074", "story_v_out_926011.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_926011", "926011074", "story_v_out_926011.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_30 = math.max(var_311_23, arg_308_1.talkMaxDuration)

			if var_311_22 <= arg_308_1.time_ and arg_308_1.time_ < var_311_22 + var_311_30 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_22) / var_311_30

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_22 + var_311_30 and arg_308_1.time_ < var_311_22 + var_311_30 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.233333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.469,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -500, 6000),
					endPos = Vector3.New(-31.8, -406.9, -1238),
					easeType = LeanTweenType.easeInOutBack
				}
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play926011075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 926011075
		arg_312_1.duration_ = 7.53

		local var_312_0 = {
			zh = 7.233,
			ja = 7.533
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
				arg_312_0:Play926011076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 1.76666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 1.76666666666667 + arg_315_0 then
				local var_315_0 = arg_312_1.bgs_.I22f

				arg_312_1.bgs_.I22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_315_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_315_1 = var_315_0:GetComponent("SpriteRenderer")

				if var_315_1 and var_315_1.sprite then
					local var_315_2 = 2 * (var_315_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_315_0.transform.localScale = Vector3.New(var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, var_315_2 / var_315_1.sprite.bounds.size.y < var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x and var_315_2 * manager.ui.mainCameraCom_.aspect / var_315_1.sprite.bounds.size.x or var_315_2 / var_315_1.sprite.bounds.size.y, 0)
				end

				for iter_315_0, iter_315_1 in pairs(arg_312_1.bgs_) do
					if iter_315_0 ~= "I22f" then
						iter_315_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_315_3 = 1.76666666666667

			if 1.76666666666667 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			if arg_312_1.time_ >= var_315_3 + 0.3 and arg_312_1.time_ < var_315_3 + 0.3 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end

			local var_315_4 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_5 = 1.76666666666667

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_5 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_4) / var_315_5)
				arg_312_1.mask_.color = var_315_6
			end

			if arg_312_1.time_ >= var_315_4 + var_315_5 and arg_312_1.time_ < var_315_4 + var_315_5 + arg_315_0 then
				local var_315_7 = Color.New(0, 0, 0)

				var_315_7.a = 1
				arg_312_1.mask_.color = var_315_7
			end

			local var_315_8 = 1.76666666666667

			if 1.76666666666667 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_9 = 1.83333333333333

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_9 then
				local var_315_10 = Color.New(0, 0, 0)

				var_315_10.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_8) / var_315_9)
				arg_312_1.mask_.color = var_315_10
			end

			if arg_312_1.time_ >= var_315_8 + var_315_9 and arg_312_1.time_ < var_315_8 + var_315_9 + arg_315_0 then
				local var_315_11 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_11.a = 0
				arg_312_1.mask_.color = var_315_11
			end

			local var_315_12 = arg_312_1.actors_["128404"].transform

			if 3.16666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 3.16666666666667 + arg_315_0 then
				arg_312_1.var_.moveOldPos128404 = var_315_12.localPosition
				var_315_12.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("128404", 3)

				for iter_315_2 = 0, var_315_12.childCount - 1 do
					local var_315_13 = var_315_12:GetChild(iter_315_2)

					if var_315_13.name == "split_4" or not string.find(var_315_13.name, "split") then
						var_315_13.gameObject:SetActive(true)
					else
						var_315_13.gameObject:SetActive(false)
					end
				end
			end

			local var_315_14 = 0.001

			if 3.16666666666667 <= arg_312_1.time_ and arg_312_1.time_ < 3.16666666666667 + var_315_14 then
				var_315_12.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_312_1.time_ - 3.16666666666667) / var_315_14)
			end

			if arg_312_1.time_ >= 3.16666666666667 + var_315_14 and arg_312_1.time_ < 3.16666666666667 + var_315_14 + arg_315_0 then
				var_315_12.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 3.16666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 3.16666666666667 + arg_315_0 then
				local var_315_15 = arg_312_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_315_15 then
					arg_312_1.var_.alphaOldValue128404 = var_315_15.alpha
					arg_312_1.var_.characterEffect128404 = var_315_15
				end

				arg_312_1.var_.alphaOldValue128404 = 0
			end

			local var_315_16 = 0.2

			if 3.16666666666667 <= arg_312_1.time_ and arg_312_1.time_ < 3.16666666666667 + var_315_16 then
				if arg_312_1.var_.characterEffect128404 then
					arg_312_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_312_1.var_.alphaOldValue128404, 1, (arg_312_1.time_ - 3.16666666666667) / var_315_16)
				end
			end

			if arg_312_1.time_ >= 3.16666666666667 + var_315_16 and arg_312_1.time_ < 3.16666666666667 + var_315_16 + arg_315_0 and arg_312_1.var_.characterEffect128404 then
				arg_312_1.var_.characterEffect128404.alpha = 1
			end

			local var_315_17 = arg_312_1.actors_["128404"].transform

			if 1.75 < arg_312_1.time_ and arg_312_1.time_ <= 1.75 + arg_315_0 then
				arg_312_1.var_.moveOldPos128404 = var_315_17.localPosition
				var_315_17.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("128404", 7)

				for iter_315_3 = 0, var_315_17.childCount - 1 do
					local var_315_18 = var_315_17:GetChild(iter_315_3)

					if var_315_18.name == "split_4" or not string.find(var_315_18.name, "split") then
						var_315_18.gameObject:SetActive(true)
					else
						var_315_18.gameObject:SetActive(false)
					end
				end
			end

			local var_315_19 = 0.001

			if 1.75 <= arg_312_1.time_ and arg_312_1.time_ < 1.75 + var_315_19 then
				var_315_17.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_312_1.time_ - 1.75) / var_315_19)
			end

			if arg_312_1.time_ >= 1.75 + var_315_19 and arg_312_1.time_ < 1.75 + var_315_19 + arg_315_0 then
				var_315_17.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.76666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 1.76666666666667 + arg_315_0 then
				if arg_312_1.var_.effect1234 then
					Object.Destroy(arg_312_1.var_.effect1234)

					arg_312_1.var_.effect1234 = nil
				end
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_315_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_312_1.bgmTxt_.text ~= var_315_23 and arg_312_1.bgmTxt_.text ~= "" then
						if arg_312_1.bgmTxt2_.text ~= "" then
							arg_312_1.bgmTxt_.text = arg_312_1.bgmTxt2_.text
						end

						arg_312_1.bgmTxt2_.text = var_315_23

						arg_312_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_312_1.bgmTxt_.text = var_315_23
						arg_312_1.bgmTxt2_.text = var_315_23
					end

					if arg_312_1.bgmTimer then
						arg_312_1.bgmTimer:Stop()

						arg_312_1.bgmTimer = nil
					end

					if arg_312_1.settingData.show_music_name == 1 then
						arg_312_1.musicController:SetSelectedState("show")
						arg_312_1.musicAnimator_:Play("open", 0, 0)

						if arg_312_1.settingData.music_time ~= 0 then
							arg_312_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_312_1.settingData.music_time), function()
								if arg_312_1 == nil or isNil(arg_312_1.bgmTxt_) then
									return
								end

								arg_312_1.musicController:SetSelectedState("hide")
								arg_312_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_312_1.time_ and arg_312_1.time_ <= 0.6 + arg_315_0 then
				arg_312_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_315_26 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_312_1.bgmTxt_.text ~= var_315_26 and arg_312_1.bgmTxt_.text ~= "" then
						if arg_312_1.bgmTxt2_.text ~= "" then
							arg_312_1.bgmTxt_.text = arg_312_1.bgmTxt2_.text
						end

						arg_312_1.bgmTxt2_.text = var_315_26

						arg_312_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_312_1.bgmTxt_.text = var_315_26
						arg_312_1.bgmTxt2_.text = var_315_26
					end

					if arg_312_1.bgmTimer then
						arg_312_1.bgmTimer:Stop()

						arg_312_1.bgmTimer = nil
					end

					if arg_312_1.settingData.show_music_name == 1 then
						arg_312_1.musicController:SetSelectedState("show")
						arg_312_1.musicAnimator_:Play("open", 0, 0)

						if arg_312_1.settingData.music_time ~= 0 then
							arg_312_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_312_1.settingData.music_time), function()
								if arg_312_1 == nil or isNil(arg_312_1.bgmTxt_) then
									return
								end

								arg_312_1.musicController:SetSelectedState("hide")
								arg_312_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_27 = 3.6
			local var_315_28 = 0.375

			if 3.6 < arg_312_1.time_ and arg_312_1.time_ <= var_315_27 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_29 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_29:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_312_1.dialogCg_.alpha = arg_318_0
				end))
				var_315_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_30 = arg_312_1:GetWordFromCfg(926011075)
				local var_315_31 = arg_312_1:FormatText(var_315_30.content)

				arg_312_1.text_.text = var_315_31

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_33 = 15 <= 0 and var_315_28 or var_315_28 * (utf8.len(var_315_31) / 15)

				if (15 <= 0 and var_315_28 or var_315_28 * (utf8.len(var_315_31) / 15)) > 0 and var_315_28 < var_315_33 then
					arg_312_1.talkMaxDuration = var_315_33
					var_315_27 = var_315_27 + 0.3

					if var_315_33 + var_315_27 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_33 + var_315_27
					end
				end

				arg_312_1.text_.text = var_315_31
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011075", "story_v_out_926011.awb") ~= 0 then
					local var_315_34 = manager.audio:GetVoiceLength("story_v_out_926011", "926011075", "story_v_out_926011.awb") / 1000

					if var_315_34 + var_315_27 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_34 + var_315_27
					end

					if var_315_30.prefab_name ~= "" and arg_312_1.actors_[var_315_30.prefab_name] ~= nil then
						local var_315_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_30.prefab_name].transform, "story_v_out_926011", "926011075", "story_v_out_926011.awb")

						arg_312_1:RecordAudio("926011075", var_315_35)
						arg_312_1:RecordAudio("926011075", var_315_35)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_926011", "926011075", "story_v_out_926011.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_926011", "926011075", "story_v_out_926011.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_36 = var_315_27 + 0.3
			local var_315_37 = math.max(var_315_28, arg_312_1.talkMaxDuration)

			if var_315_27 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_36 + var_315_37 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_36) / var_315_37

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_36 + var_315_37 and arg_312_1.time_ < var_315_36 + var_315_37 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.75,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play926011076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 926011076
		arg_320_1.duration_ = 6.07

		local var_320_0 = {
			zh = 5.366,
			ja = 6.066
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play926011077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.775

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_1 = arg_320_1:GetWordFromCfg(926011076)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 31 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 31)

				if (31 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 31)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011076", "story_v_out_926011.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011076", "story_v_out_926011.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_926011", "926011076", "story_v_out_926011.awb")

						arg_320_1:RecordAudio("926011076", var_323_6)
						arg_320_1:RecordAudio("926011076", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_926011", "926011076", "story_v_out_926011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_926011", "926011076", "story_v_out_926011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play926011077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 926011077
		arg_324_1.duration_ = 6.57

		local var_324_0 = {
			zh = 4.666,
			ja = 6.566
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play926011078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos128404 = arg_324_1.actors_["128404"].transform.localPosition
				arg_324_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("128404", 3)

				for iter_327_0 = 0, arg_324_1.actors_["128404"].transform.childCount - 1 do
					local var_327_0 = arg_324_1.actors_["128404"].transform:GetChild(iter_327_0)

					if var_327_0.name == "" or not string.find(var_327_0.name, "split") then
						var_327_0.gameObject:SetActive(true)
					else
						var_327_0.gameObject:SetActive(false)
					end
				end
			end

			local var_327_1 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_1 then
				arg_324_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_324_1.time_ - 0) / var_327_1)
			end

			if arg_324_1.time_ >= 0 + var_327_1 and arg_324_1.time_ < 0 + var_327_1 + arg_327_0 then
				arg_324_1.actors_["128404"].transform.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_327_2 = 0
			local var_327_3 = 0.625

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_2 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_4 = arg_324_1:GetWordFromCfg(926011077)
				local var_327_5 = arg_324_1:FormatText(var_327_4.content)

				arg_324_1.text_.text = var_327_5

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_7 = 25 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 25)

				if (25 <= 0 and var_327_3 or var_327_3 * (utf8.len(var_327_5) / 25)) > 0 and var_327_3 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_2
					end
				end

				arg_324_1.text_.text = var_327_5
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011077", "story_v_out_926011.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011077", "story_v_out_926011.awb") / 1000

					if var_327_8 + var_327_2 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_2
					end

					if var_327_4.prefab_name ~= "" and arg_324_1.actors_[var_327_4.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_4.prefab_name].transform, "story_v_out_926011", "926011077", "story_v_out_926011.awb")

						arg_324_1:RecordAudio("926011077", var_327_9)
						arg_324_1:RecordAudio("926011077", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_926011", "926011077", "story_v_out_926011.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_926011", "926011077", "story_v_out_926011.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_3, arg_324_1.talkMaxDuration)

			if var_327_2 <= arg_324_1.time_ and arg_324_1.time_ < var_327_2 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_2) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_2 + var_327_10 and arg_324_1.time_ < var_327_2 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play926011078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 926011078
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play926011079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["128404"]) and arg_328_1.var_.actorSpriteComps128404 == nil then
				arg_328_1.var_.actorSpriteComps128404 = arg_328_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["128404"]) then
				if arg_328_1.var_.actorSpriteComps128404 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["128404"]) and arg_328_1.var_.actorSpriteComps128404 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps128404 = nil
			end

			local var_331_2 = 0
			local var_331_3 = 0.225

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_4 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(926011078).content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_6 = 9 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_4) / 9)

				if (9 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_4) / 9)) > 0 and var_331_3 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_7 and arg_328_1.time_ < var_331_2 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play926011079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 926011079
		arg_332_1.duration_ = 7.1

		local var_332_0 = {
			zh = 5.3,
			ja = 7.1
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play926011080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["128404"]) and arg_332_1.var_.actorSpriteComps128404 == nil then
				arg_332_1.var_.actorSpriteComps128404 = arg_332_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_0 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["128404"]) then
				if arg_332_1.var_.actorSpriteComps128404 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								iter_335_1.color = Color.New(Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor1.r, (arg_332_1.time_ - 0) / var_335_0), Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor1.g, (arg_332_1.time_ - 0) / var_335_0), (Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor1.b, (arg_332_1.time_ - 0) / var_335_0)))
							else
								local var_335_1 = Mathf.Lerp(iter_335_1.color.r, 1, (arg_332_1.time_ - 0) / var_335_0)

								iter_335_1.color = Color.New(var_335_1, var_335_1, var_335_1)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["128404"]) and arg_332_1.var_.actorSpriteComps128404 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_335_3 then
						iter_335_3.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_332_1.var_.actorSpriteComps128404 = nil
			end

			local var_335_2 = 0
			local var_335_3 = 0.75

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_4 = arg_332_1:GetWordFromCfg(926011079)
				local var_335_5 = arg_332_1:FormatText(var_335_4.content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 30 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 30)

				if (30 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 30)) > 0 and var_335_3 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_2
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011079", "story_v_out_926011.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011079", "story_v_out_926011.awb") / 1000

					if var_335_8 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_2
					end

					if var_335_4.prefab_name ~= "" and arg_332_1.actors_[var_335_4.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_4.prefab_name].transform, "story_v_out_926011", "926011079", "story_v_out_926011.awb")

						arg_332_1:RecordAudio("926011079", var_335_9)
						arg_332_1:RecordAudio("926011079", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_926011", "926011079", "story_v_out_926011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_926011", "926011079", "story_v_out_926011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_3, arg_332_1.talkMaxDuration)

			if var_335_2 <= arg_332_1.time_ and arg_332_1.time_ < var_335_2 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_2) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_2 + var_335_10 and arg_332_1.time_ < var_335_2 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play926011080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 926011080
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play926011081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["128404"]) and arg_336_1.var_.actorSpriteComps128404 == nil then
				arg_336_1.var_.actorSpriteComps128404 = arg_336_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_0 = 0.2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["128404"]) then
				if arg_336_1.var_.actorSpriteComps128404 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								iter_339_1.color = Color.New(Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_0), Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_0), (Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_0)))
							else
								local var_339_1 = Mathf.Lerp(iter_339_1.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_0)

								iter_339_1.color = Color.New(var_339_1, var_339_1, var_339_1)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["128404"]) and arg_336_1.var_.actorSpriteComps128404 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_339_3 then
						iter_339_3.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps128404 = nil
			end

			local var_339_2 = 0
			local var_339_3 = 0.375

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_4 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(926011080).content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_6 = 15 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_4) / 15)

				if (15 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_4) / 15)) > 0 and var_339_3 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_7 and arg_336_1.time_ < var_339_2 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play926011081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 926011081
		arg_340_1.duration_ = 7.67

		local var_340_0 = {
			zh = 3.666,
			ja = 7.666
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play926011082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["128404"]) and arg_340_1.var_.actorSpriteComps128404 == nil then
				arg_340_1.var_.actorSpriteComps128404 = arg_340_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_0 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["128404"]) then
				if arg_340_1.var_.actorSpriteComps128404 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								iter_343_1.color = Color.New(Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_0), Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_0), (Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_0)))
							else
								local var_343_1 = Mathf.Lerp(iter_343_1.color.r, 1, (arg_340_1.time_ - 0) / var_343_0)

								iter_343_1.color = Color.New(var_343_1, var_343_1, var_343_1)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["128404"]) and arg_340_1.var_.actorSpriteComps128404 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_343_3 then
						iter_343_3.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps128404 = nil
			end

			local var_343_2 = 0
			local var_343_3 = 0.475

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_4 = arg_340_1:GetWordFromCfg(926011081)
				local var_343_5 = arg_340_1:FormatText(var_343_4.content)

				arg_340_1.text_.text = var_343_5

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 19 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 19)

				if (19 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 19)) > 0 and var_343_3 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_5
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011081", "story_v_out_926011.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011081", "story_v_out_926011.awb") / 1000

					if var_343_8 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_2
					end

					if var_343_4.prefab_name ~= "" and arg_340_1.actors_[var_343_4.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_4.prefab_name].transform, "story_v_out_926011", "926011081", "story_v_out_926011.awb")

						arg_340_1:RecordAudio("926011081", var_343_9)
						arg_340_1:RecordAudio("926011081", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_926011", "926011081", "story_v_out_926011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_926011", "926011081", "story_v_out_926011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_10 and arg_340_1.time_ < var_343_2 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play926011082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 926011082
		arg_344_1.duration_ = 6.83

		local var_344_0 = {
			zh = 3.433,
			ja = 6.833
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play926011083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.45

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(926011082)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 18 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 18)

				if (18 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 18)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011082", "story_v_out_926011.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011082", "story_v_out_926011.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_out_926011", "926011082", "story_v_out_926011.awb")

						arg_344_1:RecordAudio("926011082", var_347_6)
						arg_344_1:RecordAudio("926011082", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_926011", "926011082", "story_v_out_926011.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_926011", "926011082", "story_v_out_926011.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play926011083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 926011083
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play926011084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["128404"]) and arg_348_1.var_.actorSpriteComps128404 == nil then
				arg_348_1.var_.actorSpriteComps128404 = arg_348_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["128404"]) then
				if arg_348_1.var_.actorSpriteComps128404 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor2.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor2.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor2.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 0.5, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["128404"]) and arg_348_1.var_.actorSpriteComps128404 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_348_1.var_.actorSpriteComps128404 = nil
			end

			local var_351_2 = 0
			local var_351_3 = 0.35

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_4 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(926011083).content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_6 = 14 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_4) / 14)

				if (14 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_4) / 14)) > 0 and var_351_3 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_2
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_3, arg_348_1.talkMaxDuration)

			if var_351_2 <= arg_348_1.time_ and arg_348_1.time_ < var_351_2 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_2) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_2 + var_351_7 and arg_348_1.time_ < var_351_2 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play926011084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 926011084
		arg_352_1.duration_ = 5.93

		local var_352_0 = {
			zh = 4.3,
			ja = 5.933
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play926011085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["128404"]) and arg_352_1.var_.actorSpriteComps128404 == nil then
				arg_352_1.var_.actorSpriteComps128404 = arg_352_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["128404"]) then
				if arg_352_1.var_.actorSpriteComps128404 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 1, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["128404"]) and arg_352_1.var_.actorSpriteComps128404 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps128404 = nil
			end

			local var_355_2 = arg_352_1.actors_["128404"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos128404 = var_355_2.localPosition
				var_355_2.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("128404", 3)

				for iter_355_4 = 0, var_355_2.childCount - 1 do
					local var_355_3 = var_355_2:GetChild(iter_355_4)

					if var_355_3.name == "" or not string.find(var_355_3.name, "split") then
						var_355_3.gameObject:SetActive(true)
					else
						var_355_3.gameObject:SetActive(false)
					end
				end
			end

			local var_355_4 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				var_355_2.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_352_1.time_ - 0) / var_355_4)
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				var_355_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_355_5 = 0
			local var_355_6 = 0.55

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_7 = arg_352_1:GetWordFromCfg(926011084)
				local var_355_8 = arg_352_1:FormatText(var_355_7.content)

				arg_352_1.text_.text = var_355_8

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_10 = 22 <= 0 and var_355_6 or var_355_6 * (utf8.len(var_355_8) / 22)

				if (22 <= 0 and var_355_6 or var_355_6 * (utf8.len(var_355_8) / 22)) > 0 and var_355_6 < var_355_10 then
					arg_352_1.talkMaxDuration = var_355_10

					if var_355_10 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_5
					end
				end

				arg_352_1.text_.text = var_355_8
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011084", "story_v_out_926011.awb") ~= 0 then
					local var_355_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011084", "story_v_out_926011.awb") / 1000

					if var_355_11 + var_355_5 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_5
					end

					if var_355_7.prefab_name ~= "" and arg_352_1.actors_[var_355_7.prefab_name] ~= nil then
						local var_355_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_7.prefab_name].transform, "story_v_out_926011", "926011084", "story_v_out_926011.awb")

						arg_352_1:RecordAudio("926011084", var_355_12)
						arg_352_1:RecordAudio("926011084", var_355_12)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_926011", "926011084", "story_v_out_926011.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_926011", "926011084", "story_v_out_926011.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_13 = math.max(var_355_6, arg_352_1.talkMaxDuration)

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_13 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_5) / var_355_13

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_5 + var_355_13 and arg_352_1.time_ < var_355_5 + var_355_13 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play926011085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 926011085
		arg_356_1.duration_ = 7.57

		local var_356_0 = {
			zh = 4.6,
			ja = 7.566
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play926011086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.675

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_1 = arg_356_1:GetWordFromCfg(926011085)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 27 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 27)

				if (27 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 27)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011085", "story_v_out_926011.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011085", "story_v_out_926011.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_926011", "926011085", "story_v_out_926011.awb")

						arg_356_1:RecordAudio("926011085", var_359_6)
						arg_356_1:RecordAudio("926011085", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_926011", "926011085", "story_v_out_926011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_926011", "926011085", "story_v_out_926011.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play926011086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 926011086
		arg_360_1.duration_ = 6.2

		local var_360_0 = {
			zh = 3.733,
			ja = 6.2
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play926011087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.475

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:GetWordFromCfg(926011086)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 19)

				if (19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 19)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011086", "story_v_out_926011.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011086", "story_v_out_926011.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_926011", "926011086", "story_v_out_926011.awb")

						arg_360_1:RecordAudio("926011086", var_363_6)
						arg_360_1:RecordAudio("926011086", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_926011", "926011086", "story_v_out_926011.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_926011", "926011086", "story_v_out_926011.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play926011087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 926011087
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play926011088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["128404"]) and arg_364_1.var_.actorSpriteComps128404 == nil then
				arg_364_1.var_.actorSpriteComps128404 = arg_364_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_0 = 0.2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["128404"]) then
				if arg_364_1.var_.actorSpriteComps128404 then
					for iter_367_0, iter_367_1 in pairs(arg_364_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_367_1 then
							if arg_364_1.isInRecall_ then
								iter_367_1.color = Color.New(Mathf.Lerp(iter_367_1.color.r, arg_364_1.hightColor2.r, (arg_364_1.time_ - 0) / var_367_0), Mathf.Lerp(iter_367_1.color.g, arg_364_1.hightColor2.g, (arg_364_1.time_ - 0) / var_367_0), (Mathf.Lerp(iter_367_1.color.b, arg_364_1.hightColor2.b, (arg_364_1.time_ - 0) / var_367_0)))
							else
								local var_367_1 = Mathf.Lerp(iter_367_1.color.r, 0.5, (arg_364_1.time_ - 0) / var_367_0)

								iter_367_1.color = Color.New(var_367_1, var_367_1, var_367_1)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["128404"]) and arg_364_1.var_.actorSpriteComps128404 then
				for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_367_3 then
						iter_367_3.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_364_1.var_.actorSpriteComps128404 = nil
			end

			local var_367_2 = 0
			local var_367_3 = 0.525

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_4 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(926011087).content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 21 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_4) / 21)

				if (21 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_4) / 21)) > 0 and var_367_3 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_7 and arg_364_1.time_ < var_367_2 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play926011088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 926011088
		arg_368_1.duration_ = 6.13

		local var_368_0 = {
			zh = 3.2,
			ja = 6.133
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play926011089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["128404"]) and arg_368_1.var_.actorSpriteComps128404 == nil then
				arg_368_1.var_.actorSpriteComps128404 = arg_368_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_0 = 0.2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["128404"]) then
				if arg_368_1.var_.actorSpriteComps128404 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								iter_371_1.color = Color.New(Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor1.r, (arg_368_1.time_ - 0) / var_371_0), Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor1.g, (arg_368_1.time_ - 0) / var_371_0), (Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor1.b, (arg_368_1.time_ - 0) / var_371_0)))
							else
								local var_371_1 = Mathf.Lerp(iter_371_1.color.r, 1, (arg_368_1.time_ - 0) / var_371_0)

								iter_371_1.color = Color.New(var_371_1, var_371_1, var_371_1)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["128404"]) and arg_368_1.var_.actorSpriteComps128404 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_371_3 then
						iter_371_3.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_368_1.var_.actorSpriteComps128404 = nil
			end

			local var_371_2 = arg_368_1.actors_["128404"].transform

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos128404 = var_371_2.localPosition
				var_371_2.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("128404", 3)

				for iter_371_4 = 0, var_371_2.childCount - 1 do
					local var_371_3 = var_371_2:GetChild(iter_371_4)

					if var_371_3.name == "split_4" or not string.find(var_371_3.name, "split") then
						var_371_3.gameObject:SetActive(true)
					else
						var_371_3.gameObject:SetActive(false)
					end
				end
			end

			local var_371_4 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				var_371_2.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_368_1.time_ - 0) / var_371_4)
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				var_371_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_371_5 = 0
			local var_371_6 = 0.325

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_7 = arg_368_1:GetWordFromCfg(926011088)
				local var_371_8 = arg_368_1:FormatText(var_371_7.content)

				arg_368_1.text_.text = var_371_8

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_10 = 13 <= 0 and var_371_6 or var_371_6 * (utf8.len(var_371_8) / 13)

				if (13 <= 0 and var_371_6 or var_371_6 * (utf8.len(var_371_8) / 13)) > 0 and var_371_6 < var_371_10 then
					arg_368_1.talkMaxDuration = var_371_10

					if var_371_10 + var_371_5 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_5
					end
				end

				arg_368_1.text_.text = var_371_8
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011088", "story_v_out_926011.awb") ~= 0 then
					local var_371_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011088", "story_v_out_926011.awb") / 1000

					if var_371_11 + var_371_5 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_11 + var_371_5
					end

					if var_371_7.prefab_name ~= "" and arg_368_1.actors_[var_371_7.prefab_name] ~= nil then
						local var_371_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_7.prefab_name].transform, "story_v_out_926011", "926011088", "story_v_out_926011.awb")

						arg_368_1:RecordAudio("926011088", var_371_12)
						arg_368_1:RecordAudio("926011088", var_371_12)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_926011", "926011088", "story_v_out_926011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_926011", "926011088", "story_v_out_926011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_13 = math.max(var_371_6, arg_368_1.talkMaxDuration)

			if var_371_5 <= arg_368_1.time_ and arg_368_1.time_ < var_371_5 + var_371_13 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_5) / var_371_13

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_5 + var_371_13 and arg_368_1.time_ < var_371_5 + var_371_13 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play926011089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 926011089
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play926011090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["128404"]) and arg_372_1.var_.actorSpriteComps128404 == nil then
				arg_372_1.var_.actorSpriteComps128404 = arg_372_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_0 = 0.2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["128404"]) then
				if arg_372_1.var_.actorSpriteComps128404 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								iter_375_1.color = Color.New(Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor2.r, (arg_372_1.time_ - 0) / var_375_0), Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor2.g, (arg_372_1.time_ - 0) / var_375_0), (Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor2.b, (arg_372_1.time_ - 0) / var_375_0)))
							else
								local var_375_1 = Mathf.Lerp(iter_375_1.color.r, 0.5, (arg_372_1.time_ - 0) / var_375_0)

								iter_375_1.color = Color.New(var_375_1, var_375_1, var_375_1)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["128404"]) and arg_372_1.var_.actorSpriteComps128404 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_375_3 then
						iter_375_3.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_372_1.var_.actorSpriteComps128404 = nil
			end

			local var_375_2 = 0
			local var_375_3 = 0.45

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_2 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_4 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(926011089).content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 18 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_4) / 18)

				if (18 <= 0 and var_375_3 or var_375_3 * (utf8.len(var_375_4) / 18)) > 0 and var_375_3 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_2 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_2
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_3, arg_372_1.talkMaxDuration)

			if var_375_2 <= arg_372_1.time_ and arg_372_1.time_ < var_375_2 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_2) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_2 + var_375_7 and arg_372_1.time_ < var_375_2 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play926011090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 926011090
		arg_376_1.duration_ = 9.77

		local var_376_0 = {
			zh = 8.1,
			ja = 9.766
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
				arg_376_0:Play926011091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["128404"]) and arg_376_1.var_.actorSpriteComps128404 == nil then
				arg_376_1.var_.actorSpriteComps128404 = arg_376_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_0 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["128404"]) then
				if arg_376_1.var_.actorSpriteComps128404 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["128404"]) and arg_376_1.var_.actorSpriteComps128404 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_379_3 then
						iter_379_3.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_376_1.var_.actorSpriteComps128404 = nil
			end

			local var_379_2 = 0
			local var_379_3 = 1

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(926011090)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 40 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 40)

				if (40 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 40)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011090", "story_v_out_926011.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011090", "story_v_out_926011.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_out_926011", "926011090", "story_v_out_926011.awb")

						arg_376_1:RecordAudio("926011090", var_379_9)
						arg_376_1:RecordAudio("926011090", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_926011", "926011090", "story_v_out_926011.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_926011", "926011090", "story_v_out_926011.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play926011091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 926011091
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play926011092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["128404"]) and arg_380_1.var_.actorSpriteComps128404 == nil then
				arg_380_1.var_.actorSpriteComps128404 = arg_380_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_0 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["128404"]) then
				if arg_380_1.var_.actorSpriteComps128404 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								iter_383_1.color = Color.New(Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor2.r, (arg_380_1.time_ - 0) / var_383_0), Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor2.g, (arg_380_1.time_ - 0) / var_383_0), (Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor2.b, (arg_380_1.time_ - 0) / var_383_0)))
							else
								local var_383_1 = Mathf.Lerp(iter_383_1.color.r, 0.5, (arg_380_1.time_ - 0) / var_383_0)

								iter_383_1.color = Color.New(var_383_1, var_383_1, var_383_1)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["128404"]) and arg_380_1.var_.actorSpriteComps128404 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_383_3 then
						iter_383_3.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_380_1.var_.actorSpriteComps128404 = nil
			end

			local var_383_2 = 0
			local var_383_3 = 0.95

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_4 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(926011091).content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 38 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_4) / 38)

				if (38 <= 0 and var_383_3 or var_383_3 * (utf8.len(var_383_4) / 38)) > 0 and var_383_3 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_2 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_2
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_3, arg_380_1.talkMaxDuration)

			if var_383_2 <= arg_380_1.time_ and arg_380_1.time_ < var_383_2 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_2) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_2 + var_383_7 and arg_380_1.time_ < var_383_2 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play926011092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 926011092
		arg_384_1.duration_ = 1.3

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play926011093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["128404"]) and arg_384_1.var_.actorSpriteComps128404 == nil then
				arg_384_1.var_.actorSpriteComps128404 = arg_384_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["128404"]) then
				if arg_384_1.var_.actorSpriteComps128404 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								iter_387_1.color = Color.New(Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, (arg_384_1.time_ - 0) / var_387_0), Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, (arg_384_1.time_ - 0) / var_387_0), (Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, (arg_384_1.time_ - 0) / var_387_0)))
							else
								local var_387_1 = Mathf.Lerp(iter_387_1.color.r, 1, (arg_384_1.time_ - 0) / var_387_0)

								iter_387_1.color = Color.New(var_387_1, var_387_1, var_387_1)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["128404"]) and arg_384_1.var_.actorSpriteComps128404 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_387_3 then
						iter_387_3.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_384_1.var_.actorSpriteComps128404 = nil
			end

			local var_387_2 = 0
			local var_387_3 = 0.0329999998211861

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:GetWordFromCfg(926011092)
				local var_387_5 = arg_384_1:FormatText(var_387_4.content)

				arg_384_1.text_.text = var_387_5

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_7 = 1 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 1)

				if (1 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 1)) > 0 and var_387_3 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_5
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011092", "story_v_out_926011.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011092", "story_v_out_926011.awb") / 1000

					if var_387_8 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_2
					end

					if var_387_4.prefab_name ~= "" and arg_384_1.actors_[var_387_4.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_4.prefab_name].transform, "story_v_out_926011", "926011092", "story_v_out_926011.awb")

						arg_384_1:RecordAudio("926011092", var_387_9)
						arg_384_1:RecordAudio("926011092", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_926011", "926011092", "story_v_out_926011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_926011", "926011092", "story_v_out_926011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_10 and arg_384_1.time_ < var_387_2 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play926011093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 926011093
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play926011094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["128404"]) and arg_388_1.var_.actorSpriteComps128404 == nil then
				arg_388_1.var_.actorSpriteComps128404 = arg_388_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["128404"]) then
				if arg_388_1.var_.actorSpriteComps128404 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								iter_391_1.color = Color.New(Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_0), Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_0), (Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_0)))
							else
								local var_391_1 = Mathf.Lerp(iter_391_1.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_0)

								iter_391_1.color = Color.New(var_391_1, var_391_1, var_391_1)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["128404"]) and arg_388_1.var_.actorSpriteComps128404 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps128404 = nil
			end

			local var_391_2 = 0
			local var_391_3 = 0.825

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_2 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_4 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(926011093).content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_6 = 33 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_4) / 33)

				if (33 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_4) / 33)) > 0 and var_391_3 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_2
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_3, arg_388_1.talkMaxDuration)

			if var_391_2 <= arg_388_1.time_ and arg_388_1.time_ < var_391_2 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_2) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_2 + var_391_7 and arg_388_1.time_ < var_391_2 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play926011094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 926011094
		arg_392_1.duration_ = 7.17

		local var_392_0 = {
			zh = 3.6,
			ja = 7.166
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play926011095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["128404"]) and arg_392_1.var_.actorSpriteComps128404 == nil then
				arg_392_1.var_.actorSpriteComps128404 = arg_392_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["128404"]) then
				if arg_392_1.var_.actorSpriteComps128404 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								iter_395_1.color = Color.New(Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor1.r, (arg_392_1.time_ - 0) / var_395_0), Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor1.g, (arg_392_1.time_ - 0) / var_395_0), (Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor1.b, (arg_392_1.time_ - 0) / var_395_0)))
							else
								local var_395_1 = Mathf.Lerp(iter_395_1.color.r, 1, (arg_392_1.time_ - 0) / var_395_0)

								iter_395_1.color = Color.New(var_395_1, var_395_1, var_395_1)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["128404"]) and arg_392_1.var_.actorSpriteComps128404 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_392_1.var_.actorSpriteComps128404 = nil
			end

			local var_395_2 = arg_392_1.actors_["128404"].transform

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos128404 = var_395_2.localPosition
				var_395_2.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("128404", 3)

				for iter_395_4 = 0, var_395_2.childCount - 1 do
					local var_395_3 = var_395_2:GetChild(iter_395_4)

					if var_395_3.name == "" or not string.find(var_395_3.name, "split") then
						var_395_3.gameObject:SetActive(true)
					else
						var_395_3.gameObject:SetActive(false)
					end
				end
			end

			local var_395_4 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				var_395_2.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_392_1.time_ - 0) / var_395_4)
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				var_395_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_395_5 = 0
			local var_395_6 = 0.45

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_7 = arg_392_1:GetWordFromCfg(926011094)
				local var_395_8 = arg_392_1:FormatText(var_395_7.content)

				arg_392_1.text_.text = var_395_8

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_10 = 18 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 18)

				if (18 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 18)) > 0 and var_395_6 < var_395_10 then
					arg_392_1.talkMaxDuration = var_395_10

					if var_395_10 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_5
					end
				end

				arg_392_1.text_.text = var_395_8
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011094", "story_v_out_926011.awb") ~= 0 then
					local var_395_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011094", "story_v_out_926011.awb") / 1000

					if var_395_11 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_5
					end

					if var_395_7.prefab_name ~= "" and arg_392_1.actors_[var_395_7.prefab_name] ~= nil then
						local var_395_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_7.prefab_name].transform, "story_v_out_926011", "926011094", "story_v_out_926011.awb")

						arg_392_1:RecordAudio("926011094", var_395_12)
						arg_392_1:RecordAudio("926011094", var_395_12)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_926011", "926011094", "story_v_out_926011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_926011", "926011094", "story_v_out_926011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_13 = math.max(var_395_6, arg_392_1.talkMaxDuration)

			if var_395_5 <= arg_392_1.time_ and arg_392_1.time_ < var_395_5 + var_395_13 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_5) / var_395_13

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_5 + var_395_13 and arg_392_1.time_ < var_395_5 + var_395_13 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play926011095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 926011095
		arg_396_1.duration_ = 1

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"

			SetActive(arg_396_1.choicesGo_, true)

			for iter_397_0, iter_397_1 in ipairs(arg_396_1.choices_) do
				SetActive(iter_397_1.go, iter_397_0 <= 1)
			end

			arg_396_1.choices_[1].txt.text = arg_396_1:FormatText(StoryChoiceCfg[1309].name)
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play926011096(arg_396_1)
			end

			arg_396_1:RecordChoiceLog(926011095, 1309)
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["128404"]) and arg_396_1.var_.actorSpriteComps128404 == nil then
				arg_396_1.var_.actorSpriteComps128404 = arg_396_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_0 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["128404"]) then
				if arg_396_1.var_.actorSpriteComps128404 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								iter_399_1.color = Color.New(Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor2.r, (arg_396_1.time_ - 0) / var_399_0), Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor2.g, (arg_396_1.time_ - 0) / var_399_0), (Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor2.b, (arg_396_1.time_ - 0) / var_399_0)))
							else
								local var_399_1 = Mathf.Lerp(iter_399_1.color.r, 0.5, (arg_396_1.time_ - 0) / var_399_0)

								iter_399_1.color = Color.New(var_399_1, var_399_1, var_399_1)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["128404"]) and arg_396_1.var_.actorSpriteComps128404 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_399_3 then
						iter_399_3.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_396_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play926011096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 926011096
		arg_400_1.duration_ = 6.8

		local var_400_0 = {
			zh = 5.8,
			ja = 6.8
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play926011097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["128404"]) and arg_400_1.var_.actorSpriteComps128404 == nil then
				arg_400_1.var_.actorSpriteComps128404 = arg_400_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_0 = 0.2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["128404"]) then
				if arg_400_1.var_.actorSpriteComps128404 then
					for iter_403_0, iter_403_1 in pairs(arg_400_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_403_1 then
							if arg_400_1.isInRecall_ then
								iter_403_1.color = Color.New(Mathf.Lerp(iter_403_1.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_0), Mathf.Lerp(iter_403_1.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_0), (Mathf.Lerp(iter_403_1.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_0)))
							else
								local var_403_1 = Mathf.Lerp(iter_403_1.color.r, 1, (arg_400_1.time_ - 0) / var_403_0)

								iter_403_1.color = Color.New(var_403_1, var_403_1, var_403_1)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["128404"]) and arg_400_1.var_.actorSpriteComps128404 then
				for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_403_3 then
						iter_403_3.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps128404 = nil
			end

			local var_403_2 = arg_400_1.actors_["128404"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos128404 = var_403_2.localPosition
				var_403_2.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("128404", 3)

				for iter_403_4 = 0, var_403_2.childCount - 1 do
					local var_403_3 = var_403_2:GetChild(iter_403_4)

					if var_403_3.name == "split_5" or not string.find(var_403_3.name, "split") then
						var_403_3.gameObject:SetActive(true)
					else
						var_403_3.gameObject:SetActive(false)
					end
				end
			end

			local var_403_4 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				var_403_2.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_400_1.time_ - 0) / var_403_4)
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				var_403_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_403_5 = 0
			local var_403_6 = 0.575

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_7 = arg_400_1:GetWordFromCfg(926011096)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_10 = 23 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 23)

				if (23 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 23)) > 0 and var_403_6 < var_403_10 then
					arg_400_1.talkMaxDuration = var_403_10

					if var_403_10 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_5
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011096", "story_v_out_926011.awb") ~= 0 then
					local var_403_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011096", "story_v_out_926011.awb") / 1000

					if var_403_11 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_5
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_926011", "926011096", "story_v_out_926011.awb")

						arg_400_1:RecordAudio("926011096", var_403_12)
						arg_400_1:RecordAudio("926011096", var_403_12)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_926011", "926011096", "story_v_out_926011.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_926011", "926011096", "story_v_out_926011.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_13 = math.max(var_403_6, arg_400_1.talkMaxDuration)

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_13 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_5) / var_403_13

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_5 + var_403_13 and arg_400_1.time_ < var_403_5 + var_403_13 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play926011097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 926011097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play926011098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["128404"]) and arg_404_1.var_.actorSpriteComps128404 == nil then
				arg_404_1.var_.actorSpriteComps128404 = arg_404_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_0 = 0.2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["128404"]) then
				if arg_404_1.var_.actorSpriteComps128404 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_407_1 then
							if arg_404_1.isInRecall_ then
								iter_407_1.color = Color.New(Mathf.Lerp(iter_407_1.color.r, arg_404_1.hightColor2.r, (arg_404_1.time_ - 0) / var_407_0), Mathf.Lerp(iter_407_1.color.g, arg_404_1.hightColor2.g, (arg_404_1.time_ - 0) / var_407_0), (Mathf.Lerp(iter_407_1.color.b, arg_404_1.hightColor2.b, (arg_404_1.time_ - 0) / var_407_0)))
							else
								local var_407_1 = Mathf.Lerp(iter_407_1.color.r, 0.5, (arg_404_1.time_ - 0) / var_407_0)

								iter_407_1.color = Color.New(var_407_1, var_407_1, var_407_1)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["128404"]) and arg_404_1.var_.actorSpriteComps128404 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_407_3 then
						iter_407_3.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_404_1.var_.actorSpriteComps128404 = nil
			end

			local var_407_2 = 0
			local var_407_3 = 0.4

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_4 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(926011097).content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_6 = 16 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_4) / 16)

				if (16 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_4) / 16)) > 0 and var_407_3 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_7 and arg_404_1.time_ < var_407_2 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play926011098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 926011098
		arg_408_1.duration_ = 6.03

		local var_408_0 = {
			zh = 3.866,
			ja = 6.033
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play926011099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["128404"]) and arg_408_1.var_.actorSpriteComps128404 == nil then
				arg_408_1.var_.actorSpriteComps128404 = arg_408_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_0 = 0.2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["128404"]) then
				if arg_408_1.var_.actorSpriteComps128404 then
					for iter_411_0, iter_411_1 in pairs(arg_408_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_411_1 then
							if arg_408_1.isInRecall_ then
								iter_411_1.color = Color.New(Mathf.Lerp(iter_411_1.color.r, arg_408_1.hightColor1.r, (arg_408_1.time_ - 0) / var_411_0), Mathf.Lerp(iter_411_1.color.g, arg_408_1.hightColor1.g, (arg_408_1.time_ - 0) / var_411_0), (Mathf.Lerp(iter_411_1.color.b, arg_408_1.hightColor1.b, (arg_408_1.time_ - 0) / var_411_0)))
							else
								local var_411_1 = Mathf.Lerp(iter_411_1.color.r, 1, (arg_408_1.time_ - 0) / var_411_0)

								iter_411_1.color = Color.New(var_411_1, var_411_1, var_411_1)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["128404"]) and arg_408_1.var_.actorSpriteComps128404 then
				for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_411_3 then
						iter_411_3.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_408_1.var_.actorSpriteComps128404 = nil
			end

			local var_411_2 = arg_408_1.actors_["128404"].transform

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos128404 = var_411_2.localPosition
				var_411_2.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("128404", 3)

				for iter_411_4 = 0, var_411_2.childCount - 1 do
					local var_411_3 = var_411_2:GetChild(iter_411_4)

					if var_411_3.name == "split_4" or not string.find(var_411_3.name, "split") then
						var_411_3.gameObject:SetActive(true)
					else
						var_411_3.gameObject:SetActive(false)
					end
				end
			end

			local var_411_4 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				var_411_2.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_408_1.time_ - 0) / var_411_4)
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				var_411_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_411_5 = 0
			local var_411_6 = 0.525

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_7 = arg_408_1:GetWordFromCfg(926011098)
				local var_411_8 = arg_408_1:FormatText(var_411_7.content)

				arg_408_1.text_.text = var_411_8

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_10 = 21 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 21)

				if (21 <= 0 and var_411_6 or var_411_6 * (utf8.len(var_411_8) / 21)) > 0 and var_411_6 < var_411_10 then
					arg_408_1.talkMaxDuration = var_411_10

					if var_411_10 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_5
					end
				end

				arg_408_1.text_.text = var_411_8
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011098", "story_v_out_926011.awb") ~= 0 then
					local var_411_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011098", "story_v_out_926011.awb") / 1000

					if var_411_11 + var_411_5 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_11 + var_411_5
					end

					if var_411_7.prefab_name ~= "" and arg_408_1.actors_[var_411_7.prefab_name] ~= nil then
						local var_411_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_7.prefab_name].transform, "story_v_out_926011", "926011098", "story_v_out_926011.awb")

						arg_408_1:RecordAudio("926011098", var_411_12)
						arg_408_1:RecordAudio("926011098", var_411_12)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_926011", "926011098", "story_v_out_926011.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_926011", "926011098", "story_v_out_926011.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_13 = math.max(var_411_6, arg_408_1.talkMaxDuration)

			if var_411_5 <= arg_408_1.time_ and arg_408_1.time_ < var_411_5 + var_411_13 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_5) / var_411_13

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_5 + var_411_13 and arg_408_1.time_ < var_411_5 + var_411_13 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play926011099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 926011099
		arg_412_1.duration_ = 1

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"

			SetActive(arg_412_1.choicesGo_, true)

			for iter_413_0, iter_413_1 in ipairs(arg_412_1.choices_) do
				SetActive(iter_413_1.go, iter_413_0 <= 2)
			end

			arg_412_1.choices_[1].txt.text = arg_412_1:FormatText(StoryChoiceCfg[1310].name)
			arg_412_1.choices_[2].txt.text = arg_412_1:FormatText(StoryChoiceCfg[1311].name)
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play926011100(arg_412_1)
			end

			if arg_414_0 == 2 then
				arg_412_0:Play926011100(arg_412_1)
			end

			arg_412_1:RecordChoiceLog(926011099, 1310, 1311)
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["128404"]) and arg_412_1.var_.actorSpriteComps128404 == nil then
				arg_412_1.var_.actorSpriteComps128404 = arg_412_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_0 = 0.2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["128404"]) then
				if arg_412_1.var_.actorSpriteComps128404 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								iter_415_1.color = Color.New(Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_0), Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_0), (Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_0)))
							else
								local var_415_1 = Mathf.Lerp(iter_415_1.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_0)

								iter_415_1.color = Color.New(var_415_1, var_415_1, var_415_1)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["128404"]) and arg_412_1.var_.actorSpriteComps128404 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_415_3 then
						iter_415_3.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play926011100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 926011100
		arg_416_1.duration_ = 10.57

		local var_416_0 = {
			zh = 6.5,
			ja = 10.566
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play926011101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["128404"]) and arg_416_1.var_.actorSpriteComps128404 == nil then
				arg_416_1.var_.actorSpriteComps128404 = arg_416_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["128404"]) then
				if arg_416_1.var_.actorSpriteComps128404 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								iter_419_1.color = Color.New(Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor1.r, (arg_416_1.time_ - 0) / var_419_0), Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor1.g, (arg_416_1.time_ - 0) / var_419_0), (Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor1.b, (arg_416_1.time_ - 0) / var_419_0)))
							else
								local var_419_1 = Mathf.Lerp(iter_419_1.color.r, 1, (arg_416_1.time_ - 0) / var_419_0)

								iter_419_1.color = Color.New(var_419_1, var_419_1, var_419_1)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["128404"]) and arg_416_1.var_.actorSpriteComps128404 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps128404 = nil
			end

			local var_419_2 = arg_416_1.actors_["128404"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos128404 = var_419_2.localPosition
				var_419_2.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("128404", 3)

				for iter_419_4 = 0, var_419_2.childCount - 1 do
					local var_419_3 = var_419_2:GetChild(iter_419_4)

					if var_419_3.name == "" or not string.find(var_419_3.name, "split") then
						var_419_3.gameObject:SetActive(true)
					else
						var_419_3.gameObject:SetActive(false)
					end
				end
			end

			local var_419_4 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				var_419_2.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_416_1.time_ - 0) / var_419_4)
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				var_419_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_419_5 = 0
			local var_419_6 = 0.9

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_5 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_7 = arg_416_1:GetWordFromCfg(926011100)
				local var_419_8 = arg_416_1:FormatText(var_419_7.content)

				arg_416_1.text_.text = var_419_8

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_10 = 36 <= 0 and var_419_6 or var_419_6 * (utf8.len(var_419_8) / 36)

				if (36 <= 0 and var_419_6 or var_419_6 * (utf8.len(var_419_8) / 36)) > 0 and var_419_6 < var_419_10 then
					arg_416_1.talkMaxDuration = var_419_10

					if var_419_10 + var_419_5 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_10 + var_419_5
					end
				end

				arg_416_1.text_.text = var_419_8
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011100", "story_v_out_926011.awb") ~= 0 then
					local var_419_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011100", "story_v_out_926011.awb") / 1000

					if var_419_11 + var_419_5 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_11 + var_419_5
					end

					if var_419_7.prefab_name ~= "" and arg_416_1.actors_[var_419_7.prefab_name] ~= nil then
						local var_419_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_7.prefab_name].transform, "story_v_out_926011", "926011100", "story_v_out_926011.awb")

						arg_416_1:RecordAudio("926011100", var_419_12)
						arg_416_1:RecordAudio("926011100", var_419_12)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_926011", "926011100", "story_v_out_926011.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_926011", "926011100", "story_v_out_926011.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_13 = math.max(var_419_6, arg_416_1.talkMaxDuration)

			if var_419_5 <= arg_416_1.time_ and arg_416_1.time_ < var_419_5 + var_419_13 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_5) / var_419_13

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_5 + var_419_13 and arg_416_1.time_ < var_419_5 + var_419_13 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play926011101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 926011101
		arg_420_1.duration_ = 6.4

		local var_420_0 = {
			zh = 3.733,
			ja = 6.4
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play926011102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.425

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:GetWordFromCfg(926011101)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 17 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 17)

				if (17 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 17)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011101", "story_v_out_926011.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011101", "story_v_out_926011.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_926011", "926011101", "story_v_out_926011.awb")

						arg_420_1:RecordAudio("926011101", var_423_6)
						arg_420_1:RecordAudio("926011101", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_926011", "926011101", "story_v_out_926011.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_926011", "926011101", "story_v_out_926011.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play926011102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 926011102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play926011103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["128404"]) and arg_424_1.var_.actorSpriteComps128404 == nil then
				arg_424_1.var_.actorSpriteComps128404 = arg_424_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_0 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["128404"]) then
				if arg_424_1.var_.actorSpriteComps128404 then
					for iter_427_0, iter_427_1 in pairs(arg_424_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_427_1 then
							if arg_424_1.isInRecall_ then
								iter_427_1.color = Color.New(Mathf.Lerp(iter_427_1.color.r, arg_424_1.hightColor2.r, (arg_424_1.time_ - 0) / var_427_0), Mathf.Lerp(iter_427_1.color.g, arg_424_1.hightColor2.g, (arg_424_1.time_ - 0) / var_427_0), (Mathf.Lerp(iter_427_1.color.b, arg_424_1.hightColor2.b, (arg_424_1.time_ - 0) / var_427_0)))
							else
								local var_427_1 = Mathf.Lerp(iter_427_1.color.r, 0.5, (arg_424_1.time_ - 0) / var_427_0)

								iter_427_1.color = Color.New(var_427_1, var_427_1, var_427_1)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["128404"]) and arg_424_1.var_.actorSpriteComps128404 then
				for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_427_3 then
						iter_427_3.color = arg_424_1.isInRecall_ and (arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_424_1.var_.actorSpriteComps128404 = nil
			end

			local var_427_2 = 0
			local var_427_3 = 0.35

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_4 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(926011102).content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_6 = 14 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_4) / 14)

				if (14 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_4) / 14)) > 0 and var_427_3 < var_427_6 then
					arg_424_1.talkMaxDuration = var_427_6

					if var_427_6 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_7 and arg_424_1.time_ < var_427_2 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play926011103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 926011103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play926011104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 1.225

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(926011103).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 49 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 49)

				if (49 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 49)) > 0 and var_431_0 < var_431_3 then
					arg_428_1.talkMaxDuration = var_431_3

					if var_431_3 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_3 + 0
					end
				end

				arg_428_1.text_.text = var_431_1
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_4 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_4

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play926011104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 926011104
		arg_432_1.duration_ = 8.87

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play926011105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if arg_432_1.bgs_.I22g == nil then
				local var_435_0 = Object.Instantiate(arg_432_1.paintGo_)

				var_435_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I22g")
				var_435_0.name = "I22g"
				var_435_0.transform.parent = arg_432_1.stage_.transform
				var_435_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.bgs_.I22g = var_435_0
			end

			if 1.97711200127378 < arg_432_1.time_ and arg_432_1.time_ <= 1.97711200127378 + arg_435_0 then
				local var_435_1 = arg_432_1.bgs_.I22g

				arg_432_1.bgs_.I22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_435_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_435_2 = var_435_1:GetComponent("SpriteRenderer")

				if var_435_2 and var_435_2.sprite then
					local var_435_3 = 2 * (var_435_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_435_1.transform.localScale = Vector3.New(var_435_3 / var_435_2.sprite.bounds.size.y < var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x and var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x or var_435_3 / var_435_2.sprite.bounds.size.y, var_435_3 / var_435_2.sprite.bounds.size.y < var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x and var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x or var_435_3 / var_435_2.sprite.bounds.size.y, 0)
				end

				for iter_435_0, iter_435_1 in pairs(arg_432_1.bgs_) do
					if iter_435_0 ~= "I22g" then
						iter_435_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_435_4 = 1.97711200127378

			if 1.97711200127378 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			if arg_432_1.time_ >= var_435_4 + 0.3 and arg_432_1.time_ < var_435_4 + 0.3 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end

			local var_435_5 = 0

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_6 = 2

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_6 then
				local var_435_7 = Color.New(0, 0, 0)

				var_435_7.a = Mathf.Lerp(0, 1, (arg_432_1.time_ - var_435_5) / var_435_6)
				arg_432_1.mask_.color = var_435_7
			end

			if arg_432_1.time_ >= var_435_5 + var_435_6 and arg_432_1.time_ < var_435_5 + var_435_6 + arg_435_0 then
				local var_435_8 = Color.New(0, 0, 0)

				var_435_8.a = 1
				arg_432_1.mask_.color = var_435_8
			end

			local var_435_9 = 2

			if 2 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_10 = 2

			if var_435_9 <= arg_432_1.time_ and arg_432_1.time_ < var_435_9 + var_435_10 then
				local var_435_11 = Color.New(0, 0, 0)

				var_435_11.a = Mathf.Lerp(1, 0, (arg_432_1.time_ - var_435_9) / var_435_10)
				arg_432_1.mask_.color = var_435_11
			end

			if arg_432_1.time_ >= var_435_9 + var_435_10 and arg_432_1.time_ < var_435_9 + var_435_10 + arg_435_0 then
				local var_435_12 = Color.New(0, 0, 0)

				arg_432_1.mask_.enabled = false
				var_435_12.a = 0
				arg_432_1.mask_.color = var_435_12
			end

			local var_435_13 = arg_432_1.actors_["128404"].transform

			if 2 < arg_432_1.time_ and arg_432_1.time_ <= 2 + arg_435_0 then
				arg_432_1.var_.moveOldPos128404 = var_435_13.localPosition
				var_435_13.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("128404", 7)

				for iter_435_2 = 0, var_435_13.childCount - 1 do
					local var_435_14 = var_435_13:GetChild(iter_435_2)

					if var_435_14.name == "" or not string.find(var_435_14.name, "split") then
						var_435_14.gameObject:SetActive(true)
					else
						var_435_14.gameObject:SetActive(false)
					end
				end
			end

			local var_435_15 = 0.001

			if 2 <= arg_432_1.time_ and arg_432_1.time_ < 2 + var_435_15 then
				var_435_13.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_432_1.time_ - 2) / var_435_15)
			end

			if arg_432_1.time_ >= 2 + var_435_15 and arg_432_1.time_ < 2 + var_435_15 + arg_435_0 then
				var_435_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_432_1.frameCnt_ <= 1 then
				arg_432_1.dialog_:SetActive(false)
			end

			local var_435_16 = 3.86666666666667
			local var_435_17 = 0.275

			if 3.86666666666667 < arg_432_1.time_ and arg_432_1.time_ <= var_435_16 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_18 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_18:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_19 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(926011104).content)

				arg_432_1.text_.text = var_435_19

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_21 = 11 <= 0 and var_435_17 or var_435_17 * (utf8.len(var_435_19) / 11)

				if (11 <= 0 and var_435_17 or var_435_17 * (utf8.len(var_435_19) / 11)) > 0 and var_435_17 < var_435_21 then
					arg_432_1.talkMaxDuration = var_435_21
					var_435_16 = var_435_16 + 0.3

					if var_435_21 + var_435_16 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_21 + var_435_16
					end
				end

				arg_432_1.text_.text = var_435_19
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_22 = var_435_16 + 0.3
			local var_435_23 = math.max(var_435_17, arg_432_1.talkMaxDuration)

			if var_435_16 + 0.3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_22 + var_435_23 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_22) / var_435_23

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_22 + var_435_23 and arg_432_1.time_ < var_435_22 + var_435_23 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play926011105 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 926011105
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play926011106(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.325

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(926011105).content)

				arg_438_1.text_.text = var_441_1

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_3 = 13 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 13)

				if (13 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 13)) > 0 and var_441_0 < var_441_3 then
					arg_438_1.talkMaxDuration = var_441_3

					if var_441_3 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_3 + 0
					end
				end

				arg_438_1.text_.text = var_441_1
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_4 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_4

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play926011106 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 926011106
		arg_442_1.duration_ = 2.13

		local var_442_0 = {
			zh = 1.666,
			ja = 2.133
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play926011107(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if arg_442_1.actors_["106103"] == nil then
				local var_445_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_445_0) then
					local var_445_1 = Object.Instantiate(var_445_0, arg_442_1.canvasGo_.transform)

					var_445_1.transform:SetSiblingIndex(1)

					var_445_1.name = "106103"
					var_445_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_442_1.actors_["106103"] = var_445_1

					if arg_442_1.isInRecall_ then
						for iter_445_0, iter_445_1 in ipairs((var_445_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_445_1.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_445_2 = arg_442_1.actors_["106103"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.actorSpriteComps106103 == nil then
				arg_442_1.var_.actorSpriteComps106103 = var_445_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_3 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_3 and not isNil(var_445_2) then
				if arg_442_1.var_.actorSpriteComps106103 then
					for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_445_3 then
							if arg_442_1.isInRecall_ then
								iter_445_3.color = Color.New(Mathf.Lerp(iter_445_3.color.r, arg_442_1.hightColor1.r, (arg_442_1.time_ - 0) / var_445_3), Mathf.Lerp(iter_445_3.color.g, arg_442_1.hightColor1.g, (arg_442_1.time_ - 0) / var_445_3), (Mathf.Lerp(iter_445_3.color.b, arg_442_1.hightColor1.b, (arg_442_1.time_ - 0) / var_445_3)))
							else
								local var_445_4 = Mathf.Lerp(iter_445_3.color.r, 1, (arg_442_1.time_ - 0) / var_445_3)

								iter_445_3.color = Color.New(var_445_4, var_445_4, var_445_4)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_3 and arg_442_1.time_ < 0 + var_445_3 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.actorSpriteComps106103 then
				for iter_445_4, iter_445_5 in pairs(arg_442_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_445_5 then
						iter_445_5.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_442_1.var_.actorSpriteComps106103 = nil
			end

			local var_445_5 = arg_442_1.actors_["106103"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos106103 = var_445_5.localPosition
				var_445_5.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("106103", 3)

				for iter_445_6 = 0, var_445_5.childCount - 1 do
					local var_445_6 = var_445_5:GetChild(iter_445_6)

					if var_445_6.name == "split_1" or not string.find(var_445_6.name, "split") then
						var_445_6.gameObject:SetActive(true)
					else
						var_445_6.gameObject:SetActive(false)
					end
				end
			end

			local var_445_7 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				var_445_5.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_442_1.time_ - 0) / var_445_7)
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				var_445_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_445_8 = 0
			local var_445_9 = 0.2

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_10 = arg_442_1:GetWordFromCfg(926011106)
				local var_445_11 = arg_442_1:FormatText(var_445_10.content)

				arg_442_1.text_.text = var_445_11

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 8 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 8)

				if (8 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 8)) > 0 and var_445_9 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_11
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011106", "story_v_out_926011.awb") ~= 0 then
					local var_445_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011106", "story_v_out_926011.awb") / 1000

					if var_445_14 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_14 + var_445_8
					end

					if var_445_10.prefab_name ~= "" and arg_442_1.actors_[var_445_10.prefab_name] ~= nil then
						local var_445_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_10.prefab_name].transform, "story_v_out_926011", "926011106", "story_v_out_926011.awb")

						arg_442_1:RecordAudio("926011106", var_445_15)
						arg_442_1:RecordAudio("926011106", var_445_15)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_926011", "926011106", "story_v_out_926011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_926011", "926011106", "story_v_out_926011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_16 and arg_442_1.time_ < var_445_8 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play926011107 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 926011107
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play926011108(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["106103"]) and arg_446_1.var_.actorSpriteComps106103 == nil then
				arg_446_1.var_.actorSpriteComps106103 = arg_446_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_0 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["106103"]) then
				if arg_446_1.var_.actorSpriteComps106103 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								iter_449_1.color = Color.New(Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor2.r, (arg_446_1.time_ - 0) / var_449_0), Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor2.g, (arg_446_1.time_ - 0) / var_449_0), (Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor2.b, (arg_446_1.time_ - 0) / var_449_0)))
							else
								local var_449_1 = Mathf.Lerp(iter_449_1.color.r, 0.5, (arg_446_1.time_ - 0) / var_449_0)

								iter_449_1.color = Color.New(var_449_1, var_449_1, var_449_1)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["106103"]) and arg_446_1.var_.actorSpriteComps106103 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_449_3 then
						iter_449_3.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_446_1.var_.actorSpriteComps106103 = nil
			end

			local var_449_2 = 0
			local var_449_3 = 0.075

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_4 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(926011107).content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_6 = 3 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_4) / 3)

				if (3 <= 0 and var_449_3 or var_449_3 * (utf8.len(var_449_4) / 3)) > 0 and var_449_3 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_2
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_3, arg_446_1.talkMaxDuration)

			if var_449_2 <= arg_446_1.time_ and arg_446_1.time_ < var_449_2 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_2) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_2 + var_449_7 and arg_446_1.time_ < var_449_2 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play926011108 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 926011108
		arg_450_1.duration_ = 1.8

		local var_450_0 = {
			zh = 1,
			ja = 1.8
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play926011109(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["106103"]) and arg_450_1.var_.actorSpriteComps106103 == nil then
				arg_450_1.var_.actorSpriteComps106103 = arg_450_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["106103"]) then
				if arg_450_1.var_.actorSpriteComps106103 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor1.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor1.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor1.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 1, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["106103"]) and arg_450_1.var_.actorSpriteComps106103 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_450_1.var_.actorSpriteComps106103 = nil
			end

			local var_453_2 = 0
			local var_453_3 = 0.075

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_4 = arg_450_1:GetWordFromCfg(926011108)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_7 = 3 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 3)

				if (3 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 3)) > 0 and var_453_3 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_2
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011108", "story_v_out_926011.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011108", "story_v_out_926011.awb") / 1000

					if var_453_8 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_2
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_out_926011", "926011108", "story_v_out_926011.awb")

						arg_450_1:RecordAudio("926011108", var_453_9)
						arg_450_1:RecordAudio("926011108", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_926011", "926011108", "story_v_out_926011.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_926011", "926011108", "story_v_out_926011.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_3, arg_450_1.talkMaxDuration)

			if var_453_2 <= arg_450_1.time_ and arg_450_1.time_ < var_453_2 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_2) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_2 + var_453_10 and arg_450_1.time_ < var_453_2 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play926011109 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 926011109
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play926011110(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["106103"]) and arg_454_1.var_.actorSpriteComps106103 == nil then
				arg_454_1.var_.actorSpriteComps106103 = arg_454_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_0 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["106103"]) then
				if arg_454_1.var_.actorSpriteComps106103 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								iter_457_1.color = Color.New(Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor2.r, (arg_454_1.time_ - 0) / var_457_0), Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor2.g, (arg_454_1.time_ - 0) / var_457_0), (Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor2.b, (arg_454_1.time_ - 0) / var_457_0)))
							else
								local var_457_1 = Mathf.Lerp(iter_457_1.color.r, 0.5, (arg_454_1.time_ - 0) / var_457_0)

								iter_457_1.color = Color.New(var_457_1, var_457_1, var_457_1)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["106103"]) and arg_454_1.var_.actorSpriteComps106103 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_457_3 then
						iter_457_3.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_454_1.var_.actorSpriteComps106103 = nil
			end

			local var_457_2 = 0
			local var_457_3 = 0.45

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_4 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(926011109).content)

				arg_454_1.text_.text = var_457_4

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_6 = 18 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_4) / 18)

				if (18 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_4) / 18)) > 0 and var_457_3 < var_457_6 then
					arg_454_1.talkMaxDuration = var_457_6

					if var_457_6 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_4
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_7 and arg_454_1.time_ < var_457_2 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play926011110 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 926011110
		arg_458_1.duration_ = 9.93

		local var_458_0 = {
			zh = 8.8,
			ja = 9.933
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play926011111(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["106103"]) and arg_458_1.var_.actorSpriteComps106103 == nil then
				arg_458_1.var_.actorSpriteComps106103 = arg_458_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_461_0 = 0.2

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["106103"]) then
				if arg_458_1.var_.actorSpriteComps106103 then
					for iter_461_0, iter_461_1 in pairs(arg_458_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_461_1 then
							if arg_458_1.isInRecall_ then
								iter_461_1.color = Color.New(Mathf.Lerp(iter_461_1.color.r, arg_458_1.hightColor1.r, (arg_458_1.time_ - 0) / var_461_0), Mathf.Lerp(iter_461_1.color.g, arg_458_1.hightColor1.g, (arg_458_1.time_ - 0) / var_461_0), (Mathf.Lerp(iter_461_1.color.b, arg_458_1.hightColor1.b, (arg_458_1.time_ - 0) / var_461_0)))
							else
								local var_461_1 = Mathf.Lerp(iter_461_1.color.r, 1, (arg_458_1.time_ - 0) / var_461_0)

								iter_461_1.color = Color.New(var_461_1, var_461_1, var_461_1)
							end
						end
					end
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["106103"]) and arg_458_1.var_.actorSpriteComps106103 then
				for iter_461_2, iter_461_3 in pairs(arg_458_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_461_3 then
						iter_461_3.color = arg_458_1.isInRecall_ and (arg_458_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_458_1.var_.actorSpriteComps106103 = nil
			end

			local var_461_2 = arg_458_1.actors_["106103"].transform

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.var_.moveOldPos106103 = var_461_2.localPosition
				var_461_2.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("106103", 3)

				for iter_461_4 = 0, var_461_2.childCount - 1 do
					local var_461_3 = var_461_2:GetChild(iter_461_4)

					if var_461_3.name == "split_4" or not string.find(var_461_3.name, "split") then
						var_461_3.gameObject:SetActive(true)
					else
						var_461_3.gameObject:SetActive(false)
					end
				end
			end

			local var_461_4 = 0.001

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				var_461_2.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_458_1.time_ - 0) / var_461_4)
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				var_461_2.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_461_5 = 0
			local var_461_6 = 0.9

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_7 = arg_458_1:GetWordFromCfg(926011110)
				local var_461_8 = arg_458_1:FormatText(var_461_7.content)

				arg_458_1.text_.text = var_461_8

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_10 = 36 <= 0 and var_461_6 or var_461_6 * (utf8.len(var_461_8) / 36)

				if (36 <= 0 and var_461_6 or var_461_6 * (utf8.len(var_461_8) / 36)) > 0 and var_461_6 < var_461_10 then
					arg_458_1.talkMaxDuration = var_461_10

					if var_461_10 + var_461_5 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_5
					end
				end

				arg_458_1.text_.text = var_461_8
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011110", "story_v_out_926011.awb") ~= 0 then
					local var_461_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011110", "story_v_out_926011.awb") / 1000

					if var_461_11 + var_461_5 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_11 + var_461_5
					end

					if var_461_7.prefab_name ~= "" and arg_458_1.actors_[var_461_7.prefab_name] ~= nil then
						local var_461_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_7.prefab_name].transform, "story_v_out_926011", "926011110", "story_v_out_926011.awb")

						arg_458_1:RecordAudio("926011110", var_461_12)
						arg_458_1:RecordAudio("926011110", var_461_12)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_926011", "926011110", "story_v_out_926011.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_926011", "926011110", "story_v_out_926011.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_13 = math.max(var_461_6, arg_458_1.talkMaxDuration)

			if var_461_5 <= arg_458_1.time_ and arg_458_1.time_ < var_461_5 + var_461_13 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_5) / var_461_13

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_5 + var_461_13 and arg_458_1.time_ < var_461_5 + var_461_13 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play926011111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 926011111
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play926011112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["106103"]) and arg_462_1.var_.actorSpriteComps106103 == nil then
				arg_462_1.var_.actorSpriteComps106103 = arg_462_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_465_0 = 0.2

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["106103"]) then
				if arg_462_1.var_.actorSpriteComps106103 then
					for iter_465_0, iter_465_1 in pairs(arg_462_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_465_1 then
							if arg_462_1.isInRecall_ then
								iter_465_1.color = Color.New(Mathf.Lerp(iter_465_1.color.r, arg_462_1.hightColor2.r, (arg_462_1.time_ - 0) / var_465_0), Mathf.Lerp(iter_465_1.color.g, arg_462_1.hightColor2.g, (arg_462_1.time_ - 0) / var_465_0), (Mathf.Lerp(iter_465_1.color.b, arg_462_1.hightColor2.b, (arg_462_1.time_ - 0) / var_465_0)))
							else
								local var_465_1 = Mathf.Lerp(iter_465_1.color.r, 0.5, (arg_462_1.time_ - 0) / var_465_0)

								iter_465_1.color = Color.New(var_465_1, var_465_1, var_465_1)
							end
						end
					end
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["106103"]) and arg_462_1.var_.actorSpriteComps106103 then
				for iter_465_2, iter_465_3 in pairs(arg_462_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_465_3 then
						iter_465_3.color = arg_462_1.isInRecall_ and (arg_462_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_462_1.var_.actorSpriteComps106103 = nil
			end

			local var_465_2 = 0
			local var_465_3 = 0.45

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_4 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(926011111).content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_6 = 18 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_4) / 18)

				if (18 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_4) / 18)) > 0 and var_465_3 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_7 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_7 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_7

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_7 and arg_462_1.time_ < var_465_2 + var_465_7 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play926011112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 926011112
		arg_466_1.duration_ = 8.23

		local var_466_0 = {
			zh = 4.633,
			ja = 8.233
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play926011113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["106103"]) and arg_466_1.var_.actorSpriteComps106103 == nil then
				arg_466_1.var_.actorSpriteComps106103 = arg_466_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_469_0 = 0.2

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["106103"]) then
				if arg_466_1.var_.actorSpriteComps106103 then
					for iter_469_0, iter_469_1 in pairs(arg_466_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_469_1 then
							if arg_466_1.isInRecall_ then
								iter_469_1.color = Color.New(Mathf.Lerp(iter_469_1.color.r, arg_466_1.hightColor1.r, (arg_466_1.time_ - 0) / var_469_0), Mathf.Lerp(iter_469_1.color.g, arg_466_1.hightColor1.g, (arg_466_1.time_ - 0) / var_469_0), (Mathf.Lerp(iter_469_1.color.b, arg_466_1.hightColor1.b, (arg_466_1.time_ - 0) / var_469_0)))
							else
								local var_469_1 = Mathf.Lerp(iter_469_1.color.r, 1, (arg_466_1.time_ - 0) / var_469_0)

								iter_469_1.color = Color.New(var_469_1, var_469_1, var_469_1)
							end
						end
					end
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["106103"]) and arg_466_1.var_.actorSpriteComps106103 then
				for iter_469_2, iter_469_3 in pairs(arg_466_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_469_3 then
						iter_469_3.color = arg_466_1.isInRecall_ and (arg_466_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_466_1.var_.actorSpriteComps106103 = nil
			end

			local var_469_2 = arg_466_1.actors_["106103"].transform

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.var_.moveOldPos106103 = var_469_2.localPosition
				var_469_2.localScale = Vector3.New(1, 1, 1)

				arg_466_1:CheckSpriteTmpPos("106103", 3)

				for iter_469_4 = 0, var_469_2.childCount - 1 do
					local var_469_3 = var_469_2:GetChild(iter_469_4)

					if var_469_3.name == "split_3" or not string.find(var_469_3.name, "split") then
						var_469_3.gameObject:SetActive(true)
					else
						var_469_3.gameObject:SetActive(false)
					end
				end
			end

			local var_469_4 = 0.001

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_4 then
				var_469_2.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_466_1.time_ - 0) / var_469_4)
			end

			if arg_466_1.time_ >= 0 + var_469_4 and arg_466_1.time_ < 0 + var_469_4 + arg_469_0 then
				var_469_2.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_469_5 = 0
			local var_469_6 = 0.475

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_5 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_7 = arg_466_1:GetWordFromCfg(926011112)
				local var_469_8 = arg_466_1:FormatText(var_469_7.content)

				arg_466_1.text_.text = var_469_8

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_10 = 19 <= 0 and var_469_6 or var_469_6 * (utf8.len(var_469_8) / 19)

				if (19 <= 0 and var_469_6 or var_469_6 * (utf8.len(var_469_8) / 19)) > 0 and var_469_6 < var_469_10 then
					arg_466_1.talkMaxDuration = var_469_10

					if var_469_10 + var_469_5 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_10 + var_469_5
					end
				end

				arg_466_1.text_.text = var_469_8
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011112", "story_v_out_926011.awb") ~= 0 then
					local var_469_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011112", "story_v_out_926011.awb") / 1000

					if var_469_11 + var_469_5 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_11 + var_469_5
					end

					if var_469_7.prefab_name ~= "" and arg_466_1.actors_[var_469_7.prefab_name] ~= nil then
						local var_469_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_7.prefab_name].transform, "story_v_out_926011", "926011112", "story_v_out_926011.awb")

						arg_466_1:RecordAudio("926011112", var_469_12)
						arg_466_1:RecordAudio("926011112", var_469_12)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_926011", "926011112", "story_v_out_926011.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_926011", "926011112", "story_v_out_926011.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_13 = math.max(var_469_6, arg_466_1.talkMaxDuration)

			if var_469_5 <= arg_466_1.time_ and arg_466_1.time_ < var_469_5 + var_469_13 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_5) / var_469_13

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_5 + var_469_13 and arg_466_1.time_ < var_469_5 + var_469_13 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play926011113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 926011113
		arg_470_1.duration_ = 8.8

		local var_470_0 = {
			zh = 6.3,
			ja = 8.8
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play926011114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.775

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:GetWordFromCfg(926011113)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 31 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 31)

				if (31 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 31)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011113", "story_v_out_926011.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011113", "story_v_out_926011.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_926011", "926011113", "story_v_out_926011.awb")

						arg_470_1:RecordAudio("926011113", var_473_6)
						arg_470_1:RecordAudio("926011113", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_926011", "926011113", "story_v_out_926011.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_926011", "926011113", "story_v_out_926011.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play926011114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 926011114
		arg_474_1.duration_ = 7.93

		local var_474_0 = {
			zh = 7.733,
			ja = 7.933
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play926011115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos106103 = arg_474_1.actors_["106103"].transform.localPosition
				arg_474_1.actors_["106103"].transform.localScale = Vector3.New(1, 1, 1)

				arg_474_1:CheckSpriteTmpPos("106103", 3)

				for iter_477_0 = 0, arg_474_1.actors_["106103"].transform.childCount - 1 do
					local var_477_0 = arg_474_1.actors_["106103"].transform:GetChild(iter_477_0)

					if var_477_0.name == "split_1" or not string.find(var_477_0.name, "split") then
						var_477_0.gameObject:SetActive(true)
					else
						var_477_0.gameObject:SetActive(false)
					end
				end
			end

			local var_477_1 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_1 then
				arg_474_1.actors_["106103"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_474_1.time_ - 0) / var_477_1)
			end

			if arg_474_1.time_ >= 0 + var_477_1 and arg_474_1.time_ < 0 + var_477_1 + arg_477_0 then
				arg_474_1.actors_["106103"].transform.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_477_2 = 0
			local var_477_3 = 0.95

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_2 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_4 = arg_474_1:GetWordFromCfg(926011114)
				local var_477_5 = arg_474_1:FormatText(var_477_4.content)

				arg_474_1.text_.text = var_477_5

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_7 = 38 <= 0 and var_477_3 or var_477_3 * (utf8.len(var_477_5) / 38)

				if (38 <= 0 and var_477_3 or var_477_3 * (utf8.len(var_477_5) / 38)) > 0 and var_477_3 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_2 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_2
					end
				end

				arg_474_1.text_.text = var_477_5
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011114", "story_v_out_926011.awb") ~= 0 then
					local var_477_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011114", "story_v_out_926011.awb") / 1000

					if var_477_8 + var_477_2 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_8 + var_477_2
					end

					if var_477_4.prefab_name ~= "" and arg_474_1.actors_[var_477_4.prefab_name] ~= nil then
						local var_477_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_4.prefab_name].transform, "story_v_out_926011", "926011114", "story_v_out_926011.awb")

						arg_474_1:RecordAudio("926011114", var_477_9)
						arg_474_1:RecordAudio("926011114", var_477_9)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_926011", "926011114", "story_v_out_926011.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_926011", "926011114", "story_v_out_926011.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_3, arg_474_1.talkMaxDuration)

			if var_477_2 <= arg_474_1.time_ and arg_474_1.time_ < var_477_2 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_2) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_2 + var_477_10 and arg_474_1.time_ < var_477_2 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play926011115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 926011115
		arg_478_1.duration_ = 4.73

		local var_478_0 = {
			zh = 2.933,
			ja = 4.733
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play926011116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["128404"]) and arg_478_1.var_.actorSpriteComps128404 == nil then
				arg_478_1.var_.actorSpriteComps128404 = arg_478_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_0 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["128404"]) then
				if arg_478_1.var_.actorSpriteComps128404 then
					for iter_481_0, iter_481_1 in pairs(arg_478_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_481_1 then
							if arg_478_1.isInRecall_ then
								iter_481_1.color = Color.New(Mathf.Lerp(iter_481_1.color.r, arg_478_1.hightColor1.r, (arg_478_1.time_ - 0) / var_481_0), Mathf.Lerp(iter_481_1.color.g, arg_478_1.hightColor1.g, (arg_478_1.time_ - 0) / var_481_0), (Mathf.Lerp(iter_481_1.color.b, arg_478_1.hightColor1.b, (arg_478_1.time_ - 0) / var_481_0)))
							else
								local var_481_1 = Mathf.Lerp(iter_481_1.color.r, 1, (arg_478_1.time_ - 0) / var_481_0)

								iter_481_1.color = Color.New(var_481_1, var_481_1, var_481_1)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["128404"]) and arg_478_1.var_.actorSpriteComps128404 then
				for iter_481_2, iter_481_3 in pairs(arg_478_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_481_3 then
						iter_481_3.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_478_1.var_.actorSpriteComps128404 = nil
			end

			local var_481_2 = arg_478_1.actors_["106103"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps106103 == nil then
				arg_478_1.var_.actorSpriteComps106103 = var_481_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_481_3 = 0.2

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_3 and not isNil(var_481_2) then
				if arg_478_1.var_.actorSpriteComps106103 then
					for iter_481_4, iter_481_5 in pairs(arg_478_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_481_5 then
							if arg_478_1.isInRecall_ then
								iter_481_5.color = Color.New(Mathf.Lerp(iter_481_5.color.r, arg_478_1.hightColor2.r, (arg_478_1.time_ - 0) / var_481_3), Mathf.Lerp(iter_481_5.color.g, arg_478_1.hightColor2.g, (arg_478_1.time_ - 0) / var_481_3), (Mathf.Lerp(iter_481_5.color.b, arg_478_1.hightColor2.b, (arg_478_1.time_ - 0) / var_481_3)))
							else
								local var_481_4 = Mathf.Lerp(iter_481_5.color.r, 0.5, (arg_478_1.time_ - 0) / var_481_3)

								iter_481_5.color = Color.New(var_481_4, var_481_4, var_481_4)
							end
						end
					end
				end
			end

			if arg_478_1.time_ >= 0 + var_481_3 and arg_478_1.time_ < 0 + var_481_3 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.actorSpriteComps106103 then
				for iter_481_6, iter_481_7 in pairs(arg_478_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_481_7 then
						iter_481_7.color = arg_478_1.isInRecall_ and (arg_478_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_478_1.var_.actorSpriteComps106103 = nil
			end

			local var_481_5 = 0
			local var_481_6 = 0.45

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_5 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_7 = arg_478_1:GetWordFromCfg(926011115)
				local var_481_8 = arg_478_1:FormatText(var_481_7.content)

				arg_478_1.text_.text = var_481_8

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_10 = 18 <= 0 and var_481_6 or var_481_6 * (utf8.len(var_481_8) / 18)

				if (18 <= 0 and var_481_6 or var_481_6 * (utf8.len(var_481_8) / 18)) > 0 and var_481_6 < var_481_10 then
					arg_478_1.talkMaxDuration = var_481_10

					if var_481_10 + var_481_5 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_10 + var_481_5
					end
				end

				arg_478_1.text_.text = var_481_8
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011115", "story_v_out_926011.awb") ~= 0 then
					local var_481_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011115", "story_v_out_926011.awb") / 1000

					if var_481_11 + var_481_5 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_11 + var_481_5
					end

					if var_481_7.prefab_name ~= "" and arg_478_1.actors_[var_481_7.prefab_name] ~= nil then
						local var_481_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_7.prefab_name].transform, "story_v_out_926011", "926011115", "story_v_out_926011.awb")

						arg_478_1:RecordAudio("926011115", var_481_12)
						arg_478_1:RecordAudio("926011115", var_481_12)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_926011", "926011115", "story_v_out_926011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_926011", "926011115", "story_v_out_926011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_13 = math.max(var_481_6, arg_478_1.talkMaxDuration)

			if var_481_5 <= arg_478_1.time_ and arg_478_1.time_ < var_481_5 + var_481_13 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_5) / var_481_13

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_5 + var_481_13 and arg_478_1.time_ < var_481_5 + var_481_13 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play926011116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 926011116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play926011117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["128404"]) and arg_482_1.var_.actorSpriteComps128404 == nil then
				arg_482_1.var_.actorSpriteComps128404 = arg_482_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_0 = 0.2

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["128404"]) then
				if arg_482_1.var_.actorSpriteComps128404 then
					for iter_485_0, iter_485_1 in pairs(arg_482_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_485_1 then
							if arg_482_1.isInRecall_ then
								iter_485_1.color = Color.New(Mathf.Lerp(iter_485_1.color.r, arg_482_1.hightColor2.r, (arg_482_1.time_ - 0) / var_485_0), Mathf.Lerp(iter_485_1.color.g, arg_482_1.hightColor2.g, (arg_482_1.time_ - 0) / var_485_0), (Mathf.Lerp(iter_485_1.color.b, arg_482_1.hightColor2.b, (arg_482_1.time_ - 0) / var_485_0)))
							else
								local var_485_1 = Mathf.Lerp(iter_485_1.color.r, 0.5, (arg_482_1.time_ - 0) / var_485_0)

								iter_485_1.color = Color.New(var_485_1, var_485_1, var_485_1)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["128404"]) and arg_482_1.var_.actorSpriteComps128404 then
				for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_485_3 then
						iter_485_3.color = arg_482_1.isInRecall_ and (arg_482_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_482_1.var_.actorSpriteComps128404 = nil
			end

			local var_485_2 = arg_482_1.actors_["106103"].transform

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.moveOldPos106103 = var_485_2.localPosition
				var_485_2.localScale = Vector3.New(1, 1, 1)

				arg_482_1:CheckSpriteTmpPos("106103", 7)

				for iter_485_4 = 0, var_485_2.childCount - 1 do
					local var_485_3 = var_485_2:GetChild(iter_485_4)

					if var_485_3.name == "" or not string.find(var_485_3.name, "split") then
						var_485_3.gameObject:SetActive(true)
					else
						var_485_3.gameObject:SetActive(false)
					end
				end
			end

			local var_485_4 = 0.001

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_4 then
				var_485_2.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_482_1.time_ - 0) / var_485_4)
			end

			if arg_482_1.time_ >= 0 + var_485_4 and arg_482_1.time_ < 0 + var_485_4 + arg_485_0 then
				var_485_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_485_5 = 0
			local var_485_6 = 1.225

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_5 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_7 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(926011116).content)

				arg_482_1.text_.text = var_485_7

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_9 = 49 <= 0 and var_485_6 or var_485_6 * (utf8.len(var_485_7) / 49)

				if (49 <= 0 and var_485_6 or var_485_6 * (utf8.len(var_485_7) / 49)) > 0 and var_485_6 < var_485_9 then
					arg_482_1.talkMaxDuration = var_485_9

					if var_485_9 + var_485_5 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_9 + var_485_5
					end
				end

				arg_482_1.text_.text = var_485_7
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_6, arg_482_1.talkMaxDuration)

			if var_485_5 <= arg_482_1.time_ and arg_482_1.time_ < var_485_5 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_5) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_5 + var_485_10 and arg_482_1.time_ < var_485_5 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play926011117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 926011117
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play926011118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos106103 = arg_486_1.actors_["106103"].transform.localPosition
				arg_486_1.actors_["106103"].transform.localScale = Vector3.New(1, 1, 1)

				arg_486_1:CheckSpriteTmpPos("106103", 7)

				for iter_489_0 = 0, arg_486_1.actors_["106103"].transform.childCount - 1 do
					local var_489_0 = arg_486_1.actors_["106103"].transform:GetChild(iter_489_0)

					if var_489_0.name == "" or not string.find(var_489_0.name, "split") then
						var_489_0.gameObject:SetActive(true)
					else
						var_489_0.gameObject:SetActive(false)
					end
				end
			end

			local var_489_1 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_1 then
				arg_486_1.actors_["106103"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_486_1.time_ - 0) / var_489_1)
			end

			if arg_486_1.time_ >= 0 + var_489_1 and arg_486_1.time_ < 0 + var_489_1 + arg_489_0 then
				arg_486_1.actors_["106103"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_489_2 = 0
			local var_489_3 = 0.55

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_2 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_4 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(926011117).content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_6 = 22 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_4) / 22)

				if (22 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_4) / 22)) > 0 and var_489_3 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_2
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_3, arg_486_1.talkMaxDuration)

			if var_489_2 <= arg_486_1.time_ and arg_486_1.time_ < var_489_2 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_2) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_2 + var_489_7 and arg_486_1.time_ < var_489_2 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play926011118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 926011118
		arg_490_1.duration_ = 4.17

		local var_490_0 = {
			zh = 3.1,
			ja = 4.166
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play926011119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["128404"]) and arg_490_1.var_.actorSpriteComps128404 == nil then
				arg_490_1.var_.actorSpriteComps128404 = arg_490_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_0 = 0.2

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["128404"]) then
				if arg_490_1.var_.actorSpriteComps128404 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								iter_493_1.color = Color.New(Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, (arg_490_1.time_ - 0) / var_493_0), Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, (arg_490_1.time_ - 0) / var_493_0), (Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, (arg_490_1.time_ - 0) / var_493_0)))
							else
								local var_493_1 = Mathf.Lerp(iter_493_1.color.r, 1, (arg_490_1.time_ - 0) / var_493_0)

								iter_493_1.color = Color.New(var_493_1, var_493_1, var_493_1)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["128404"]) and arg_490_1.var_.actorSpriteComps128404 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_493_3 then
						iter_493_3.color = arg_490_1.isInRecall_ and (arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_490_1.var_.actorSpriteComps128404 = nil
			end

			local var_493_2 = arg_490_1.actors_["128404"].transform

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos128404 = var_493_2.localPosition
				var_493_2.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("128404", 3)

				for iter_493_4 = 0, var_493_2.childCount - 1 do
					local var_493_3 = var_493_2:GetChild(iter_493_4)

					if var_493_3.name == "" or not string.find(var_493_3.name, "split") then
						var_493_3.gameObject:SetActive(true)
					else
						var_493_3.gameObject:SetActive(false)
					end
				end
			end

			local var_493_4 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 then
				var_493_2.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_490_1.time_ - 0) / var_493_4)
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 then
				var_493_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_493_5 = 0
			local var_493_6 = 0.35

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_5 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_7 = arg_490_1:GetWordFromCfg(926011118)
				local var_493_8 = arg_490_1:FormatText(var_493_7.content)

				arg_490_1.text_.text = var_493_8

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_10 = 14 <= 0 and var_493_6 or var_493_6 * (utf8.len(var_493_8) / 14)

				if (14 <= 0 and var_493_6 or var_493_6 * (utf8.len(var_493_8) / 14)) > 0 and var_493_6 < var_493_10 then
					arg_490_1.talkMaxDuration = var_493_10

					if var_493_10 + var_493_5 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_10 + var_493_5
					end
				end

				arg_490_1.text_.text = var_493_8
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011118", "story_v_out_926011.awb") ~= 0 then
					local var_493_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011118", "story_v_out_926011.awb") / 1000

					if var_493_11 + var_493_5 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_11 + var_493_5
					end

					if var_493_7.prefab_name ~= "" and arg_490_1.actors_[var_493_7.prefab_name] ~= nil then
						local var_493_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_7.prefab_name].transform, "story_v_out_926011", "926011118", "story_v_out_926011.awb")

						arg_490_1:RecordAudio("926011118", var_493_12)
						arg_490_1:RecordAudio("926011118", var_493_12)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_926011", "926011118", "story_v_out_926011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_926011", "926011118", "story_v_out_926011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_13 = math.max(var_493_6, arg_490_1.talkMaxDuration)

			if var_493_5 <= arg_490_1.time_ and arg_490_1.time_ < var_493_5 + var_493_13 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_5) / var_493_13

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_5 + var_493_13 and arg_490_1.time_ < var_493_5 + var_493_13 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play926011119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 926011119
		arg_494_1.duration_ = 5.7

		local var_494_0 = {
			zh = 4.2,
			ja = 5.7
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play926011120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0.575

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_1 = arg_494_1:GetWordFromCfg(926011119)
				local var_497_2 = arg_494_1:FormatText(var_497_1.content)

				arg_494_1.text_.text = var_497_2

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_4 = 23 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 23)

				if (23 <= 0 and var_497_0 or var_497_0 * (utf8.len(var_497_2) / 23)) > 0 and var_497_0 < var_497_4 then
					arg_494_1.talkMaxDuration = var_497_4

					if var_497_4 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_4 + 0
					end
				end

				arg_494_1.text_.text = var_497_2
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011119", "story_v_out_926011.awb") ~= 0 then
					local var_497_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011119", "story_v_out_926011.awb") / 1000

					if var_497_5 + 0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + 0
					end

					if var_497_1.prefab_name ~= "" and arg_494_1.actors_[var_497_1.prefab_name] ~= nil then
						local var_497_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_1.prefab_name].transform, "story_v_out_926011", "926011119", "story_v_out_926011.awb")

						arg_494_1:RecordAudio("926011119", var_497_6)
						arg_494_1:RecordAudio("926011119", var_497_6)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_926011", "926011119", "story_v_out_926011.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_926011", "926011119", "story_v_out_926011.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_7 = math.max(var_497_0, arg_494_1.talkMaxDuration)

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_7 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - 0) / var_497_7

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= 0 + var_497_7 and arg_494_1.time_ < 0 + var_497_7 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play926011120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 926011120
		arg_498_1.duration_ = 4.33

		local var_498_0 = {
			zh = 3.666,
			ja = 4.333
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play926011121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["106103"]) and arg_498_1.var_.actorSpriteComps106103 == nil then
				arg_498_1.var_.actorSpriteComps106103 = arg_498_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_0 = 0.2

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["106103"]) then
				if arg_498_1.var_.actorSpriteComps106103 then
					for iter_501_0, iter_501_1 in pairs(arg_498_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_501_1 then
							if arg_498_1.isInRecall_ then
								iter_501_1.color = Color.New(Mathf.Lerp(iter_501_1.color.r, arg_498_1.hightColor1.r, (arg_498_1.time_ - 0) / var_501_0), Mathf.Lerp(iter_501_1.color.g, arg_498_1.hightColor1.g, (arg_498_1.time_ - 0) / var_501_0), (Mathf.Lerp(iter_501_1.color.b, arg_498_1.hightColor1.b, (arg_498_1.time_ - 0) / var_501_0)))
							else
								local var_501_1 = Mathf.Lerp(iter_501_1.color.r, 1, (arg_498_1.time_ - 0) / var_501_0)

								iter_501_1.color = Color.New(var_501_1, var_501_1, var_501_1)
							end
						end
					end
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["106103"]) and arg_498_1.var_.actorSpriteComps106103 then
				for iter_501_2, iter_501_3 in pairs(arg_498_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_501_3 then
						iter_501_3.color = arg_498_1.isInRecall_ and (arg_498_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_498_1.var_.actorSpriteComps106103 = nil
			end

			local var_501_2 = arg_498_1.actors_["128404"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_2) and arg_498_1.var_.actorSpriteComps128404 == nil then
				arg_498_1.var_.actorSpriteComps128404 = var_501_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_501_3 = 0.2

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_3 and not isNil(var_501_2) then
				if arg_498_1.var_.actorSpriteComps128404 then
					for iter_501_4, iter_501_5 in pairs(arg_498_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_501_5 then
							if arg_498_1.isInRecall_ then
								iter_501_5.color = Color.New(Mathf.Lerp(iter_501_5.color.r, arg_498_1.hightColor2.r, (arg_498_1.time_ - 0) / var_501_3), Mathf.Lerp(iter_501_5.color.g, arg_498_1.hightColor2.g, (arg_498_1.time_ - 0) / var_501_3), (Mathf.Lerp(iter_501_5.color.b, arg_498_1.hightColor2.b, (arg_498_1.time_ - 0) / var_501_3)))
							else
								local var_501_4 = Mathf.Lerp(iter_501_5.color.r, 0.5, (arg_498_1.time_ - 0) / var_501_3)

								iter_501_5.color = Color.New(var_501_4, var_501_4, var_501_4)
							end
						end
					end
				end
			end

			if arg_498_1.time_ >= 0 + var_501_3 and arg_498_1.time_ < 0 + var_501_3 + arg_501_0 and not isNil(var_501_2) and arg_498_1.var_.actorSpriteComps128404 then
				for iter_501_6, iter_501_7 in pairs(arg_498_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_501_7 then
						iter_501_7.color = arg_498_1.isInRecall_ and (arg_498_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_498_1.var_.actorSpriteComps128404 = nil
			end

			local var_501_5 = arg_498_1.actors_["128404"].transform

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos128404 = var_501_5.localPosition
				var_501_5.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("128404", 7)

				for iter_501_8 = 0, var_501_5.childCount - 1 do
					local var_501_6 = var_501_5:GetChild(iter_501_8)

					if var_501_6.name == "" or not string.find(var_501_6.name, "split") then
						var_501_6.gameObject:SetActive(true)
					else
						var_501_6.gameObject:SetActive(false)
					end
				end
			end

			local var_501_7 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_7 then
				var_501_5.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_498_1.time_ - 0) / var_501_7)
			end

			if arg_498_1.time_ >= 0 + var_501_7 and arg_498_1.time_ < 0 + var_501_7 + arg_501_0 then
				var_501_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_501_8 = arg_498_1.actors_["106103"].transform

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.var_.moveOldPos106103 = var_501_8.localPosition
				var_501_8.localScale = Vector3.New(1, 1, 1)

				arg_498_1:CheckSpriteTmpPos("106103", 3)

				for iter_501_9 = 0, var_501_8.childCount - 1 do
					local var_501_9 = var_501_8:GetChild(iter_501_9)

					if var_501_9.name == "split_4" or not string.find(var_501_9.name, "split") then
						var_501_9.gameObject:SetActive(true)
					else
						var_501_9.gameObject:SetActive(false)
					end
				end
			end

			local var_501_10 = 0.001

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_10 then
				var_501_8.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_498_1.time_ - 0) / var_501_10)
			end

			if arg_498_1.time_ >= 0 + var_501_10 and arg_498_1.time_ < 0 + var_501_10 + arg_501_0 then
				var_501_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_501_11 = 0
			local var_501_12 = 0.375

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_11 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_13 = arg_498_1:GetWordFromCfg(926011120)
				local var_501_14 = arg_498_1:FormatText(var_501_13.content)

				arg_498_1.text_.text = var_501_14

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_16 = 15 <= 0 and var_501_12 or var_501_12 * (utf8.len(var_501_14) / 15)

				if (15 <= 0 and var_501_12 or var_501_12 * (utf8.len(var_501_14) / 15)) > 0 and var_501_12 < var_501_16 then
					arg_498_1.talkMaxDuration = var_501_16

					if var_501_16 + var_501_11 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_16 + var_501_11
					end
				end

				arg_498_1.text_.text = var_501_14
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011120", "story_v_out_926011.awb") ~= 0 then
					local var_501_17 = manager.audio:GetVoiceLength("story_v_out_926011", "926011120", "story_v_out_926011.awb") / 1000

					if var_501_17 + var_501_11 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_17 + var_501_11
					end

					if var_501_13.prefab_name ~= "" and arg_498_1.actors_[var_501_13.prefab_name] ~= nil then
						local var_501_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_13.prefab_name].transform, "story_v_out_926011", "926011120", "story_v_out_926011.awb")

						arg_498_1:RecordAudio("926011120", var_501_18)
						arg_498_1:RecordAudio("926011120", var_501_18)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_926011", "926011120", "story_v_out_926011.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_926011", "926011120", "story_v_out_926011.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_19 = math.max(var_501_12, arg_498_1.talkMaxDuration)

			if var_501_11 <= arg_498_1.time_ and arg_498_1.time_ < var_501_11 + var_501_19 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_11) / var_501_19

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_11 + var_501_19 and arg_498_1.time_ < var_501_11 + var_501_19 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play926011121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 926011121
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play926011122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["106103"]) and arg_502_1.var_.actorSpriteComps106103 == nil then
				arg_502_1.var_.actorSpriteComps106103 = arg_502_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_505_0 = 0.2

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["106103"]) then
				if arg_502_1.var_.actorSpriteComps106103 then
					for iter_505_0, iter_505_1 in pairs(arg_502_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_505_1 then
							if arg_502_1.isInRecall_ then
								iter_505_1.color = Color.New(Mathf.Lerp(iter_505_1.color.r, arg_502_1.hightColor2.r, (arg_502_1.time_ - 0) / var_505_0), Mathf.Lerp(iter_505_1.color.g, arg_502_1.hightColor2.g, (arg_502_1.time_ - 0) / var_505_0), (Mathf.Lerp(iter_505_1.color.b, arg_502_1.hightColor2.b, (arg_502_1.time_ - 0) / var_505_0)))
							else
								local var_505_1 = Mathf.Lerp(iter_505_1.color.r, 0.5, (arg_502_1.time_ - 0) / var_505_0)

								iter_505_1.color = Color.New(var_505_1, var_505_1, var_505_1)
							end
						end
					end
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["106103"]) and arg_502_1.var_.actorSpriteComps106103 then
				for iter_505_2, iter_505_3 in pairs(arg_502_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_505_3 then
						iter_505_3.color = arg_502_1.isInRecall_ and (arg_502_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_502_1.var_.actorSpriteComps106103 = nil
			end

			local var_505_2 = arg_502_1.actors_["106103"].transform

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.var_.moveOldPos106103 = var_505_2.localPosition
				var_505_2.localScale = Vector3.New(1, 1, 1)

				arg_502_1:CheckSpriteTmpPos("106103", 7)

				for iter_505_4 = 0, var_505_2.childCount - 1 do
					local var_505_3 = var_505_2:GetChild(iter_505_4)

					if var_505_3.name == "" or not string.find(var_505_3.name, "split") then
						var_505_3.gameObject:SetActive(true)
					else
						var_505_3.gameObject:SetActive(false)
					end
				end
			end

			local var_505_4 = 0.001

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_4 then
				var_505_2.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_502_1.time_ - 0) / var_505_4)
			end

			if arg_502_1.time_ >= 0 + var_505_4 and arg_502_1.time_ < 0 + var_505_4 + arg_505_0 then
				var_505_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_502_1.time_ and arg_502_1.time_ <= 0.2 + arg_505_0 then
				arg_502_1:AudioAction("play", "effect", "se_story_143", "se_story_143_wave", "")
			end

			local var_505_6 = 0
			local var_505_7 = 1.025

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_6 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_8 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(926011121).content)

				arg_502_1.text_.text = var_505_8

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_10 = 41 <= 0 and var_505_7 or var_505_7 * (utf8.len(var_505_8) / 41)

				if (41 <= 0 and var_505_7 or var_505_7 * (utf8.len(var_505_8) / 41)) > 0 and var_505_7 < var_505_10 then
					arg_502_1.talkMaxDuration = var_505_10

					if var_505_10 + var_505_6 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_6
					end
				end

				arg_502_1.text_.text = var_505_8
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_11 = math.max(var_505_7, arg_502_1.talkMaxDuration)

			if var_505_6 <= arg_502_1.time_ and arg_502_1.time_ < var_505_6 + var_505_11 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_6) / var_505_11

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_6 + var_505_11 and arg_502_1.time_ < var_505_6 + var_505_11 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play926011122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 926011122
		arg_506_1.duration_ = 16.53

		local var_506_0 = {
			zh = 11.233,
			ja = 16.533
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play926011123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["106103"]) and arg_506_1.var_.actorSpriteComps106103 == nil then
				arg_506_1.var_.actorSpriteComps106103 = arg_506_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_509_0 = 0.2

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["106103"]) then
				if arg_506_1.var_.actorSpriteComps106103 then
					for iter_509_0, iter_509_1 in pairs(arg_506_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_509_1 then
							if arg_506_1.isInRecall_ then
								iter_509_1.color = Color.New(Mathf.Lerp(iter_509_1.color.r, arg_506_1.hightColor1.r, (arg_506_1.time_ - 0) / var_509_0), Mathf.Lerp(iter_509_1.color.g, arg_506_1.hightColor1.g, (arg_506_1.time_ - 0) / var_509_0), (Mathf.Lerp(iter_509_1.color.b, arg_506_1.hightColor1.b, (arg_506_1.time_ - 0) / var_509_0)))
							else
								local var_509_1 = Mathf.Lerp(iter_509_1.color.r, 1, (arg_506_1.time_ - 0) / var_509_0)

								iter_509_1.color = Color.New(var_509_1, var_509_1, var_509_1)
							end
						end
					end
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["106103"]) and arg_506_1.var_.actorSpriteComps106103 then
				for iter_509_2, iter_509_3 in pairs(arg_506_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_509_3 then
						iter_509_3.color = arg_506_1.isInRecall_ and (arg_506_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_506_1.var_.actorSpriteComps106103 = nil
			end

			local var_509_2 = arg_506_1.actors_["106103"].transform

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos106103 = var_509_2.localPosition
				var_509_2.localScale = Vector3.New(1, 1, 1)

				arg_506_1:CheckSpriteTmpPos("106103", 3)

				for iter_509_4 = 0, var_509_2.childCount - 1 do
					local var_509_3 = var_509_2:GetChild(iter_509_4)

					if var_509_3.name == "split_3" or not string.find(var_509_3.name, "split") then
						var_509_3.gameObject:SetActive(true)
					else
						var_509_3.gameObject:SetActive(false)
					end
				end
			end

			local var_509_4 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				var_509_2.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_506_1.time_ - 0) / var_509_4)
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				var_509_2.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_509_5 = 0
			local var_509_6 = 1.3

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_5 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_7 = arg_506_1:GetWordFromCfg(926011122)
				local var_509_8 = arg_506_1:FormatText(var_509_7.content)

				arg_506_1.text_.text = var_509_8

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_10 = 52 <= 0 and var_509_6 or var_509_6 * (utf8.len(var_509_8) / 52)

				if (52 <= 0 and var_509_6 or var_509_6 * (utf8.len(var_509_8) / 52)) > 0 and var_509_6 < var_509_10 then
					arg_506_1.talkMaxDuration = var_509_10

					if var_509_10 + var_509_5 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_10 + var_509_5
					end
				end

				arg_506_1.text_.text = var_509_8
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011122", "story_v_out_926011.awb") ~= 0 then
					local var_509_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011122", "story_v_out_926011.awb") / 1000

					if var_509_11 + var_509_5 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_11 + var_509_5
					end

					if var_509_7.prefab_name ~= "" and arg_506_1.actors_[var_509_7.prefab_name] ~= nil then
						local var_509_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_7.prefab_name].transform, "story_v_out_926011", "926011122", "story_v_out_926011.awb")

						arg_506_1:RecordAudio("926011122", var_509_12)
						arg_506_1:RecordAudio("926011122", var_509_12)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_926011", "926011122", "story_v_out_926011.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_926011", "926011122", "story_v_out_926011.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_13 = math.max(var_509_6, arg_506_1.talkMaxDuration)

			if var_509_5 <= arg_506_1.time_ and arg_506_1.time_ < var_509_5 + var_509_13 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_5) / var_509_13

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_5 + var_509_13 and arg_506_1.time_ < var_509_5 + var_509_13 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play926011123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 926011123
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play926011124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["106103"]) and arg_510_1.var_.actorSpriteComps106103 == nil then
				arg_510_1.var_.actorSpriteComps106103 = arg_510_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_513_0 = 0.2

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["106103"]) then
				if arg_510_1.var_.actorSpriteComps106103 then
					for iter_513_0, iter_513_1 in pairs(arg_510_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_513_1 then
							if arg_510_1.isInRecall_ then
								iter_513_1.color = Color.New(Mathf.Lerp(iter_513_1.color.r, arg_510_1.hightColor2.r, (arg_510_1.time_ - 0) / var_513_0), Mathf.Lerp(iter_513_1.color.g, arg_510_1.hightColor2.g, (arg_510_1.time_ - 0) / var_513_0), (Mathf.Lerp(iter_513_1.color.b, arg_510_1.hightColor2.b, (arg_510_1.time_ - 0) / var_513_0)))
							else
								local var_513_1 = Mathf.Lerp(iter_513_1.color.r, 0.5, (arg_510_1.time_ - 0) / var_513_0)

								iter_513_1.color = Color.New(var_513_1, var_513_1, var_513_1)
							end
						end
					end
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["106103"]) and arg_510_1.var_.actorSpriteComps106103 then
				for iter_513_2, iter_513_3 in pairs(arg_510_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_513_3 then
						iter_513_3.color = arg_510_1.isInRecall_ and (arg_510_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_510_1.var_.actorSpriteComps106103 = nil
			end

			local var_513_2 = 0
			local var_513_3 = 0.425

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_2 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_4 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(926011123).content)

				arg_510_1.text_.text = var_513_4

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_6 = 17 <= 0 and var_513_3 or var_513_3 * (utf8.len(var_513_4) / 17)

				if (17 <= 0 and var_513_3 or var_513_3 * (utf8.len(var_513_4) / 17)) > 0 and var_513_3 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_2 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_2
					end
				end

				arg_510_1.text_.text = var_513_4
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_3, arg_510_1.talkMaxDuration)

			if var_513_2 <= arg_510_1.time_ and arg_510_1.time_ < var_513_2 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_2) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_2 + var_513_7 and arg_510_1.time_ < var_513_2 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play926011124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 926011124
		arg_514_1.duration_ = 9.97

		local var_514_0 = {
			zh = 9.966,
			ja = 7.4
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play926011125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["106103"]) and arg_514_1.var_.actorSpriteComps106103 == nil then
				arg_514_1.var_.actorSpriteComps106103 = arg_514_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_517_0 = 0.2

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["106103"]) then
				if arg_514_1.var_.actorSpriteComps106103 then
					for iter_517_0, iter_517_1 in pairs(arg_514_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_517_1 then
							if arg_514_1.isInRecall_ then
								iter_517_1.color = Color.New(Mathf.Lerp(iter_517_1.color.r, arg_514_1.hightColor1.r, (arg_514_1.time_ - 0) / var_517_0), Mathf.Lerp(iter_517_1.color.g, arg_514_1.hightColor1.g, (arg_514_1.time_ - 0) / var_517_0), (Mathf.Lerp(iter_517_1.color.b, arg_514_1.hightColor1.b, (arg_514_1.time_ - 0) / var_517_0)))
							else
								local var_517_1 = Mathf.Lerp(iter_517_1.color.r, 1, (arg_514_1.time_ - 0) / var_517_0)

								iter_517_1.color = Color.New(var_517_1, var_517_1, var_517_1)
							end
						end
					end
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["106103"]) and arg_514_1.var_.actorSpriteComps106103 then
				for iter_517_2, iter_517_3 in pairs(arg_514_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_517_3 then
						iter_517_3.color = arg_514_1.isInRecall_ and (arg_514_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_514_1.var_.actorSpriteComps106103 = nil
			end

			local var_517_2 = 0
			local var_517_3 = 0.95

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_4 = arg_514_1:GetWordFromCfg(926011124)
				local var_517_5 = arg_514_1:FormatText(var_517_4.content)

				arg_514_1.text_.text = var_517_5

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_7 = 38 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 38)

				if (38 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 38)) > 0 and var_517_3 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_2
					end
				end

				arg_514_1.text_.text = var_517_5
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011124", "story_v_out_926011.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011124", "story_v_out_926011.awb") / 1000

					if var_517_8 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_2
					end

					if var_517_4.prefab_name ~= "" and arg_514_1.actors_[var_517_4.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_4.prefab_name].transform, "story_v_out_926011", "926011124", "story_v_out_926011.awb")

						arg_514_1:RecordAudio("926011124", var_517_9)
						arg_514_1:RecordAudio("926011124", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_926011", "926011124", "story_v_out_926011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_926011", "926011124", "story_v_out_926011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_3, arg_514_1.talkMaxDuration)

			if var_517_2 <= arg_514_1.time_ and arg_514_1.time_ < var_517_2 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_2) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_2 + var_517_10 and arg_514_1.time_ < var_517_2 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play926011125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 926011125
		arg_518_1.duration_ = 8.97

		local var_518_0 = {
			zh = 7.066,
			ja = 8.966
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play926011126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["128404"]) and arg_518_1.var_.actorSpriteComps128404 == nil then
				arg_518_1.var_.actorSpriteComps128404 = arg_518_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_0 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["128404"]) then
				if arg_518_1.var_.actorSpriteComps128404 then
					for iter_521_0, iter_521_1 in pairs(arg_518_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_521_1 then
							if arg_518_1.isInRecall_ then
								iter_521_1.color = Color.New(Mathf.Lerp(iter_521_1.color.r, arg_518_1.hightColor1.r, (arg_518_1.time_ - 0) / var_521_0), Mathf.Lerp(iter_521_1.color.g, arg_518_1.hightColor1.g, (arg_518_1.time_ - 0) / var_521_0), (Mathf.Lerp(iter_521_1.color.b, arg_518_1.hightColor1.b, (arg_518_1.time_ - 0) / var_521_0)))
							else
								local var_521_1 = Mathf.Lerp(iter_521_1.color.r, 1, (arg_518_1.time_ - 0) / var_521_0)

								iter_521_1.color = Color.New(var_521_1, var_521_1, var_521_1)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["128404"]) and arg_518_1.var_.actorSpriteComps128404 then
				for iter_521_2, iter_521_3 in pairs(arg_518_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_521_3 then
						iter_521_3.color = arg_518_1.isInRecall_ and (arg_518_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_518_1.var_.actorSpriteComps128404 = nil
			end

			local var_521_2 = arg_518_1.actors_["106103"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.actorSpriteComps106103 == nil then
				arg_518_1.var_.actorSpriteComps106103 = var_521_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_3 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.actorSpriteComps106103 then
					for iter_521_4, iter_521_5 in pairs(arg_518_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_521_5 then
							if arg_518_1.isInRecall_ then
								iter_521_5.color = Color.New(Mathf.Lerp(iter_521_5.color.r, arg_518_1.hightColor2.r, (arg_518_1.time_ - 0) / var_521_3), Mathf.Lerp(iter_521_5.color.g, arg_518_1.hightColor2.g, (arg_518_1.time_ - 0) / var_521_3), (Mathf.Lerp(iter_521_5.color.b, arg_518_1.hightColor2.b, (arg_518_1.time_ - 0) / var_521_3)))
							else
								local var_521_4 = Mathf.Lerp(iter_521_5.color.r, 0.5, (arg_518_1.time_ - 0) / var_521_3)

								iter_521_5.color = Color.New(var_521_4, var_521_4, var_521_4)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.actorSpriteComps106103 then
				for iter_521_6, iter_521_7 in pairs(arg_518_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_521_7 then
						iter_521_7.color = arg_518_1.isInRecall_ and (arg_518_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_518_1.var_.actorSpriteComps106103 = nil
			end

			local var_521_5 = arg_518_1.actors_["128404"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos128404 = var_521_5.localPosition
				var_521_5.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("128404", 4)

				for iter_521_8 = 0, var_521_5.childCount - 1 do
					local var_521_6 = var_521_5:GetChild(iter_521_8)

					if var_521_6.name == "" or not string.find(var_521_6.name, "split") then
						var_521_6.gameObject:SetActive(true)
					else
						var_521_6.gameObject:SetActive(false)
					end
				end
			end

			local var_521_7 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_7 then
				var_521_5.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_518_1.time_ - 0) / var_521_7)
			end

			if arg_518_1.time_ >= 0 + var_521_7 and arg_518_1.time_ < 0 + var_521_7 + arg_521_0 then
				var_521_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_521_8 = arg_518_1.actors_["106103"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos106103 = var_521_8.localPosition
				var_521_8.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("106103", 2)

				for iter_521_9 = 0, var_521_8.childCount - 1 do
					local var_521_9 = var_521_8:GetChild(iter_521_9)

					if var_521_9.name == "" or not string.find(var_521_9.name, "split") then
						var_521_9.gameObject:SetActive(true)
					else
						var_521_9.gameObject:SetActive(false)
					end
				end
			end

			local var_521_10 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_10 then
				var_521_8.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_518_1.time_ - 0) / var_521_10)
			end

			if arg_518_1.time_ >= 0 + var_521_10 and arg_518_1.time_ < 0 + var_521_10 + arg_521_0 then
				var_521_8.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_521_11 = 0
			local var_521_12 = 0.725

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_11 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_13 = arg_518_1:GetWordFromCfg(926011125)
				local var_521_14 = arg_518_1:FormatText(var_521_13.content)

				arg_518_1.text_.text = var_521_14

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_16 = 29 <= 0 and var_521_12 or var_521_12 * (utf8.len(var_521_14) / 29)

				if (29 <= 0 and var_521_12 or var_521_12 * (utf8.len(var_521_14) / 29)) > 0 and var_521_12 < var_521_16 then
					arg_518_1.talkMaxDuration = var_521_16

					if var_521_16 + var_521_11 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_16 + var_521_11
					end
				end

				arg_518_1.text_.text = var_521_14
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011125", "story_v_out_926011.awb") ~= 0 then
					local var_521_17 = manager.audio:GetVoiceLength("story_v_out_926011", "926011125", "story_v_out_926011.awb") / 1000

					if var_521_17 + var_521_11 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_17 + var_521_11
					end

					if var_521_13.prefab_name ~= "" and arg_518_1.actors_[var_521_13.prefab_name] ~= nil then
						local var_521_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_13.prefab_name].transform, "story_v_out_926011", "926011125", "story_v_out_926011.awb")

						arg_518_1:RecordAudio("926011125", var_521_18)
						arg_518_1:RecordAudio("926011125", var_521_18)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_926011", "926011125", "story_v_out_926011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_926011", "926011125", "story_v_out_926011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_19 = math.max(var_521_12, arg_518_1.talkMaxDuration)

			if var_521_11 <= arg_518_1.time_ and arg_518_1.time_ < var_521_11 + var_521_19 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_11) / var_521_19

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_11 + var_521_19 and arg_518_1.time_ < var_521_11 + var_521_19 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play926011126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 926011126
		arg_522_1.duration_ = 6.1

		local var_522_0 = {
			zh = 3.766,
			ja = 6.1
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play926011127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["128404"]) and arg_522_1.var_.actorSpriteComps128404 == nil then
				arg_522_1.var_.actorSpriteComps128404 = arg_522_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_0 = 0.2

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["128404"]) then
				if arg_522_1.var_.actorSpriteComps128404 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								iter_525_1.color = Color.New(Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, (arg_522_1.time_ - 0) / var_525_0), Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, (arg_522_1.time_ - 0) / var_525_0), (Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, (arg_522_1.time_ - 0) / var_525_0)))
							else
								local var_525_1 = Mathf.Lerp(iter_525_1.color.r, 0.5, (arg_522_1.time_ - 0) / var_525_0)

								iter_525_1.color = Color.New(var_525_1, var_525_1, var_525_1)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["128404"]) and arg_522_1.var_.actorSpriteComps128404 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_525_3 then
						iter_525_3.color = arg_522_1.isInRecall_ and (arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_522_1.var_.actorSpriteComps128404 = nil
			end

			local var_525_2 = 0
			local var_525_3 = 0.375

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_4 = arg_522_1:GetWordFromCfg(926011126)
				local var_525_5 = arg_522_1:FormatText(var_525_4.content)

				arg_522_1.text_.text = var_525_5

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_7 = 15 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 15)

				if (15 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_5) / 15)) > 0 and var_525_3 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_2
					end
				end

				arg_522_1.text_.text = var_525_5
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011126", "story_v_out_926011.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_out_926011", "926011126", "story_v_out_926011.awb") / 1000

					if var_525_8 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_2
					end

					if var_525_4.prefab_name ~= "" and arg_522_1.actors_[var_525_4.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_4.prefab_name].transform, "story_v_out_926011", "926011126", "story_v_out_926011.awb")

						arg_522_1:RecordAudio("926011126", var_525_9)
						arg_522_1:RecordAudio("926011126", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_926011", "926011126", "story_v_out_926011.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_926011", "926011126", "story_v_out_926011.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_3, arg_522_1.talkMaxDuration)

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_2) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_2 + var_525_10 and arg_522_1.time_ < var_525_2 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play926011127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 926011127
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play926011128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos106103 = arg_526_1.actors_["106103"].transform.localPosition
				arg_526_1.actors_["106103"].transform.localScale = Vector3.New(1, 1, 1)

				arg_526_1:CheckSpriteTmpPos("106103", 7)

				for iter_529_0 = 0, arg_526_1.actors_["106103"].transform.childCount - 1 do
					local var_529_0 = arg_526_1.actors_["106103"].transform:GetChild(iter_529_0)

					if var_529_0.name == "" or not string.find(var_529_0.name, "split") then
						var_529_0.gameObject:SetActive(true)
					else
						var_529_0.gameObject:SetActive(false)
					end
				end
			end

			local var_529_1 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_1 then
				arg_526_1.actors_["106103"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_526_1.time_ - 0) / var_529_1)
			end

			if arg_526_1.time_ >= 0 + var_529_1 and arg_526_1.time_ < 0 + var_529_1 + arg_529_0 then
				arg_526_1.actors_["106103"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_529_2 = arg_526_1.actors_["128404"].transform

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos128404 = var_529_2.localPosition
				var_529_2.localScale = Vector3.New(1, 1, 1)

				arg_526_1:CheckSpriteTmpPos("128404", 7)

				for iter_529_1 = 0, var_529_2.childCount - 1 do
					local var_529_3 = var_529_2:GetChild(iter_529_1)

					if var_529_3.name == "" or not string.find(var_529_3.name, "split") then
						var_529_3.gameObject:SetActive(true)
					else
						var_529_3.gameObject:SetActive(false)
					end
				end
			end

			local var_529_4 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 then
				var_529_2.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_526_1.time_ - 0) / var_529_4)
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 then
				var_529_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_529_5 = 0
			local var_529_6 = 0.9

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_5 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_7 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(926011127).content)

				arg_526_1.text_.text = var_529_7

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_9 = 36 <= 0 and var_529_6 or var_529_6 * (utf8.len(var_529_7) / 36)

				if (36 <= 0 and var_529_6 or var_529_6 * (utf8.len(var_529_7) / 36)) > 0 and var_529_6 < var_529_9 then
					arg_526_1.talkMaxDuration = var_529_9

					if var_529_9 + var_529_5 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_9 + var_529_5
					end
				end

				arg_526_1.text_.text = var_529_7
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_10 = math.max(var_529_6, arg_526_1.talkMaxDuration)

			if var_529_5 <= arg_526_1.time_ and arg_526_1.time_ < var_529_5 + var_529_10 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_5) / var_529_10

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_5 + var_529_10 and arg_526_1.time_ < var_529_5 + var_529_10 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play926011128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 926011128
		arg_530_1.duration_ = 5.27

		local var_530_0 = {
			zh = 4.4,
			ja = 5.266
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play926011129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["128404"]) and arg_530_1.var_.actorSpriteComps128404 == nil then
				arg_530_1.var_.actorSpriteComps128404 = arg_530_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_0 = 0.2

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["128404"]) then
				if arg_530_1.var_.actorSpriteComps128404 then
					for iter_533_0, iter_533_1 in pairs(arg_530_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_533_1 then
							if arg_530_1.isInRecall_ then
								iter_533_1.color = Color.New(Mathf.Lerp(iter_533_1.color.r, arg_530_1.hightColor1.r, (arg_530_1.time_ - 0) / var_533_0), Mathf.Lerp(iter_533_1.color.g, arg_530_1.hightColor1.g, (arg_530_1.time_ - 0) / var_533_0), (Mathf.Lerp(iter_533_1.color.b, arg_530_1.hightColor1.b, (arg_530_1.time_ - 0) / var_533_0)))
							else
								local var_533_1 = Mathf.Lerp(iter_533_1.color.r, 1, (arg_530_1.time_ - 0) / var_533_0)

								iter_533_1.color = Color.New(var_533_1, var_533_1, var_533_1)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["128404"]) and arg_530_1.var_.actorSpriteComps128404 then
				for iter_533_2, iter_533_3 in pairs(arg_530_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_533_3 then
						iter_533_3.color = arg_530_1.isInRecall_ and (arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_530_1.var_.actorSpriteComps128404 = nil
			end

			local var_533_2 = arg_530_1.actors_["128404"].transform

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.var_.moveOldPos128404 = var_533_2.localPosition
				var_533_2.localScale = Vector3.New(1, 1, 1)

				arg_530_1:CheckSpriteTmpPos("128404", 3)

				for iter_533_4 = 0, var_533_2.childCount - 1 do
					local var_533_3 = var_533_2:GetChild(iter_533_4)

					if var_533_3.name == "" or not string.find(var_533_3.name, "split") then
						var_533_3.gameObject:SetActive(true)
					else
						var_533_3.gameObject:SetActive(false)
					end
				end
			end

			local var_533_4 = 0.001

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_4 then
				var_533_2.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_530_1.time_ - 0) / var_533_4)
			end

			if arg_530_1.time_ >= 0 + var_533_4 and arg_530_1.time_ < 0 + var_533_4 + arg_533_0 then
				var_533_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_533_5 = 0
			local var_533_6 = 0.475

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_5 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_7 = arg_530_1:GetWordFromCfg(926011128)
				local var_533_8 = arg_530_1:FormatText(var_533_7.content)

				arg_530_1.text_.text = var_533_8

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_10 = 19 <= 0 and var_533_6 or var_533_6 * (utf8.len(var_533_8) / 19)

				if (19 <= 0 and var_533_6 or var_533_6 * (utf8.len(var_533_8) / 19)) > 0 and var_533_6 < var_533_10 then
					arg_530_1.talkMaxDuration = var_533_10

					if var_533_10 + var_533_5 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_10 + var_533_5
					end
				end

				arg_530_1.text_.text = var_533_8
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011128", "story_v_out_926011.awb") ~= 0 then
					local var_533_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011128", "story_v_out_926011.awb") / 1000

					if var_533_11 + var_533_5 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_11 + var_533_5
					end

					if var_533_7.prefab_name ~= "" and arg_530_1.actors_[var_533_7.prefab_name] ~= nil then
						local var_533_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_7.prefab_name].transform, "story_v_out_926011", "926011128", "story_v_out_926011.awb")

						arg_530_1:RecordAudio("926011128", var_533_12)
						arg_530_1:RecordAudio("926011128", var_533_12)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_926011", "926011128", "story_v_out_926011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_926011", "926011128", "story_v_out_926011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_13 = math.max(var_533_6, arg_530_1.talkMaxDuration)

			if var_533_5 <= arg_530_1.time_ and arg_530_1.time_ < var_533_5 + var_533_13 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_5) / var_533_13

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_5 + var_533_13 and arg_530_1.time_ < var_533_5 + var_533_13 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_530_1:InitPlayNodeList()
	end,
	Play926011129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 926011129
		arg_534_1.duration_ = 15.5

		local var_534_0 = {
			zh = 10.733,
			ja = 15.5
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play926011130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if arg_534_1.actors_["104701"] == nil then
				local var_537_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_537_0) then
					local var_537_1 = Object.Instantiate(var_537_0, arg_534_1.canvasGo_.transform)

					var_537_1.transform:SetSiblingIndex(1)

					var_537_1.name = "104701"
					var_537_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_534_1.actors_["104701"] = var_537_1

					if arg_534_1.isInRecall_ then
						for iter_537_0, iter_537_1 in ipairs((var_537_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_537_1.color = arg_534_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_537_2 = arg_534_1.actors_["104701"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.actorSpriteComps104701 == nil then
				arg_534_1.var_.actorSpriteComps104701 = var_537_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_3 = 0.2

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_3 and not isNil(var_537_2) then
				if arg_534_1.var_.actorSpriteComps104701 then
					for iter_537_2, iter_537_3 in pairs(arg_534_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_537_3 then
							if arg_534_1.isInRecall_ then
								iter_537_3.color = Color.New(Mathf.Lerp(iter_537_3.color.r, arg_534_1.hightColor1.r, (arg_534_1.time_ - 0) / var_537_3), Mathf.Lerp(iter_537_3.color.g, arg_534_1.hightColor1.g, (arg_534_1.time_ - 0) / var_537_3), (Mathf.Lerp(iter_537_3.color.b, arg_534_1.hightColor1.b, (arg_534_1.time_ - 0) / var_537_3)))
							else
								local var_537_4 = Mathf.Lerp(iter_537_3.color.r, 1, (arg_534_1.time_ - 0) / var_537_3)

								iter_537_3.color = Color.New(var_537_4, var_537_4, var_537_4)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= 0 + var_537_3 and arg_534_1.time_ < 0 + var_537_3 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.actorSpriteComps104701 then
				for iter_537_4, iter_537_5 in pairs(arg_534_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_537_5 then
						iter_537_5.color = arg_534_1.isInRecall_ and (arg_534_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_534_1.var_.actorSpriteComps104701 = nil
			end

			local var_537_5 = arg_534_1.actors_["128404"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_5) and arg_534_1.var_.actorSpriteComps128404 == nil then
				arg_534_1.var_.actorSpriteComps128404 = var_537_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_6 = 0.2

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_6 and not isNil(var_537_5) then
				if arg_534_1.var_.actorSpriteComps128404 then
					for iter_537_6, iter_537_7 in pairs(arg_534_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_537_7 then
							if arg_534_1.isInRecall_ then
								iter_537_7.color = Color.New(Mathf.Lerp(iter_537_7.color.r, arg_534_1.hightColor2.r, (arg_534_1.time_ - 0) / var_537_6), Mathf.Lerp(iter_537_7.color.g, arg_534_1.hightColor2.g, (arg_534_1.time_ - 0) / var_537_6), (Mathf.Lerp(iter_537_7.color.b, arg_534_1.hightColor2.b, (arg_534_1.time_ - 0) / var_537_6)))
							else
								local var_537_7 = Mathf.Lerp(iter_537_7.color.r, 0.5, (arg_534_1.time_ - 0) / var_537_6)

								iter_537_7.color = Color.New(var_537_7, var_537_7, var_537_7)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= 0 + var_537_6 and arg_534_1.time_ < 0 + var_537_6 + arg_537_0 and not isNil(var_537_5) and arg_534_1.var_.actorSpriteComps128404 then
				for iter_537_8, iter_537_9 in pairs(arg_534_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_537_9 then
						iter_537_9.color = arg_534_1.isInRecall_ and (arg_534_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_534_1.var_.actorSpriteComps128404 = nil
			end

			local var_537_8 = arg_534_1.actors_["104701"].transform

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos104701 = var_537_8.localPosition
				var_537_8.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("104701", 5)

				for iter_537_10 = 0, var_537_8.childCount - 1 do
					local var_537_9 = var_537_8:GetChild(iter_537_10)

					if var_537_9.name == "" or not string.find(var_537_9.name, "split") then
						var_537_9.gameObject:SetActive(true)
					else
						var_537_9.gameObject:SetActive(false)
					end
				end
			end

			local var_537_10 = 0.366666666666667

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_10 then
				var_537_8.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos104701, Vector3.New(815.7, -469, 638.2), (arg_534_1.time_ - 0) / var_537_10)
			end

			if arg_534_1.time_ >= 0 + var_537_10 and arg_534_1.time_ < 0 + var_537_10 + arg_537_0 then
				var_537_8.localPosition = Vector3.New(815.7, -469, 638.2)
			end

			local var_537_11 = arg_534_1.actors_["128404"].transform

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos128404 = var_537_11.localPosition
				var_537_11.localScale = Vector3.New(1, 1, 1)

				arg_534_1:CheckSpriteTmpPos("128404", 3)

				for iter_537_11 = 0, var_537_11.childCount - 1 do
					local var_537_12 = var_537_11:GetChild(iter_537_11)

					if var_537_12.name == "" or not string.find(var_537_12.name, "split") then
						var_537_12.gameObject:SetActive(true)
					else
						var_537_12.gameObject:SetActive(false)
					end
				end
			end

			local var_537_13 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_13 then
				var_537_11.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_534_1.time_ - 0) / var_537_13)
			end

			if arg_534_1.time_ >= 0 + var_537_13 and arg_534_1.time_ < 0 + var_537_13 + arg_537_0 then
				var_537_11.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_537_14 = 0

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_14 + arg_537_0 then
				arg_534_1.allBtn_.enabled = false
			end

			if arg_534_1.time_ >= var_537_14 + 0.833333333333333 and arg_534_1.time_ < var_537_14 + 0.833333333333333 + arg_537_0 then
				arg_534_1.allBtn_.enabled = true
			end

			if arg_534_1.frameCnt_ <= 1 then
				arg_534_1.dialog_:SetActive(false)
			end

			local var_537_15 = 0.6
			local var_537_16 = 1.075

			if 0.6 < arg_534_1.time_ and arg_534_1.time_ <= var_537_15 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0

				arg_534_1.dialog_:SetActive(true)

				arg_534_1.dialogCg_.alpha = 0

				local var_537_17 = LeanTween.value(arg_534_1.dialog_, 0, 1, 0.3)

				var_537_17:setOnUpdate(LuaHelper.FloatAction(function(arg_538_0)
					arg_534_1.dialogCg_.alpha = arg_538_0
				end))
				var_537_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_534_1.dialog_)
					var_537_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_534_1.duration_ = arg_534_1.duration_ + 0.3

				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_18 = arg_534_1:GetWordFromCfg(926011129)
				local var_537_19 = arg_534_1:FormatText(var_537_18.content)

				arg_534_1.text_.text = var_537_19

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_21 = 43 <= 0 and var_537_16 or var_537_16 * (utf8.len(var_537_19) / 43)

				if (43 <= 0 and var_537_16 or var_537_16 * (utf8.len(var_537_19) / 43)) > 0 and var_537_16 < var_537_21 then
					arg_534_1.talkMaxDuration = var_537_21
					var_537_15 = var_537_15 + 0.3

					if var_537_21 + var_537_15 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_21 + var_537_15
					end
				end

				arg_534_1.text_.text = var_537_19
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011129", "story_v_out_926011.awb") ~= 0 then
					local var_537_22 = manager.audio:GetVoiceLength("story_v_out_926011", "926011129", "story_v_out_926011.awb") / 1000

					if var_537_22 + var_537_15 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_22 + var_537_15
					end

					if var_537_18.prefab_name ~= "" and arg_534_1.actors_[var_537_18.prefab_name] ~= nil then
						local var_537_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_18.prefab_name].transform, "story_v_out_926011", "926011129", "story_v_out_926011.awb")

						arg_534_1:RecordAudio("926011129", var_537_23)
						arg_534_1:RecordAudio("926011129", var_537_23)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_926011", "926011129", "story_v_out_926011.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_926011", "926011129", "story_v_out_926011.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_24 = var_537_15 + 0.3
			local var_537_25 = math.max(var_537_16, arg_534_1.talkMaxDuration)

			if var_537_15 + 0.3 <= arg_534_1.time_ and arg_534_1.time_ < var_537_24 + var_537_25 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_24) / var_537_25

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_24 + var_537_25 and arg_534_1.time_ < var_537_24 + var_537_25 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.366666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.034,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(970.4, -525.3, 1159.8),
					endPos = Vector3.New(815.7, -469, 638.2),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play926011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 926011130
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play926011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(arg_540_1.actors_["104701"]) and arg_540_1.var_.actorSpriteComps104701 == nil then
				arg_540_1.var_.actorSpriteComps104701 = arg_540_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_0 = 0.2

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 and not isNil(arg_540_1.actors_["104701"]) then
				if arg_540_1.var_.actorSpriteComps104701 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								iter_543_1.color = Color.New(Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor2.r, (arg_540_1.time_ - 0) / var_543_0), Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor2.g, (arg_540_1.time_ - 0) / var_543_0), (Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor2.b, (arg_540_1.time_ - 0) / var_543_0)))
							else
								local var_543_1 = Mathf.Lerp(iter_543_1.color.r, 0.5, (arg_540_1.time_ - 0) / var_543_0)

								iter_543_1.color = Color.New(var_543_1, var_543_1, var_543_1)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 and not isNil(arg_540_1.actors_["104701"]) and arg_540_1.var_.actorSpriteComps104701 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_543_3 then
						iter_543_3.color = arg_540_1.isInRecall_ and (arg_540_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_540_1.var_.actorSpriteComps104701 = nil
			end

			local var_543_2 = 0
			local var_543_3 = 0.425

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_2 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_4 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(926011130).content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_6 = 17 <= 0 and var_543_3 or var_543_3 * (utf8.len(var_543_4) / 17)

				if (17 <= 0 and var_543_3 or var_543_3 * (utf8.len(var_543_4) / 17)) > 0 and var_543_3 < var_543_6 then
					arg_540_1.talkMaxDuration = var_543_6

					if var_543_6 + var_543_2 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_6 + var_543_2
					end
				end

				arg_540_1.text_.text = var_543_4
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_3, arg_540_1.talkMaxDuration)

			if var_543_2 <= arg_540_1.time_ and arg_540_1.time_ < var_543_2 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_2) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_2 + var_543_7 and arg_540_1.time_ < var_543_2 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play926011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 926011131
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play926011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos104701 = arg_544_1.actors_["104701"].transform.localPosition
				arg_544_1.actors_["104701"].transform.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("104701", 7)

				for iter_547_0 = 0, arg_544_1.actors_["104701"].transform.childCount - 1 do
					local var_547_0 = arg_544_1.actors_["104701"].transform:GetChild(iter_547_0)

					if var_547_0.name == "" or not string.find(var_547_0.name, "split") then
						var_547_0.gameObject:SetActive(true)
					else
						var_547_0.gameObject:SetActive(false)
					end
				end
			end

			local var_547_1 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_1 then
				arg_544_1.actors_["104701"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_544_1.time_ - 0) / var_547_1)
			end

			if arg_544_1.time_ >= 0 + var_547_1 and arg_544_1.time_ < 0 + var_547_1 + arg_547_0 then
				arg_544_1.actors_["104701"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_544_1.time_ and arg_544_1.time_ <= 0.166666666666667 + arg_547_0 then
				arg_544_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_547_3 = arg_544_1.actors_["128404"].transform

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos128404 = var_547_3.localPosition
				var_547_3.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("128404", 7)

				for iter_547_1 = 0, var_547_3.childCount - 1 do
					local var_547_4 = var_547_3:GetChild(iter_547_1)

					if var_547_4.name == "" or not string.find(var_547_4.name, "split") then
						var_547_4.gameObject:SetActive(true)
					else
						var_547_4.gameObject:SetActive(false)
					end
				end
			end

			local var_547_5 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_5 then
				var_547_3.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_544_1.time_ - 0) / var_547_5)
			end

			if arg_544_1.time_ >= 0 + var_547_5 and arg_544_1.time_ < 0 + var_547_5 + arg_547_0 then
				var_547_3.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_547_6 = 0
			local var_547_7 = 1.125

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_6 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_8 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(926011131).content)

				arg_544_1.text_.text = var_547_8

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_10 = 45 <= 0 and var_547_7 or var_547_7 * (utf8.len(var_547_8) / 45)

				if (45 <= 0 and var_547_7 or var_547_7 * (utf8.len(var_547_8) / 45)) > 0 and var_547_7 < var_547_10 then
					arg_544_1.talkMaxDuration = var_547_10

					if var_547_10 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_10 + var_547_6
					end
				end

				arg_544_1.text_.text = var_547_8
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_11 = math.max(var_547_7, arg_544_1.talkMaxDuration)

			if var_547_6 <= arg_544_1.time_ and arg_544_1.time_ < var_547_6 + var_547_11 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_6) / var_547_11

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_6 + var_547_11 and arg_544_1.time_ < var_547_6 + var_547_11 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play926011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 926011132
		arg_548_1.duration_ = 8.51

		local var_548_0 = {
			zh = 5.540999999999,
			ja = 8.507999999999
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play926011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["104701"]) and arg_548_1.var_.actorSpriteComps104701 == nil then
				arg_548_1.var_.actorSpriteComps104701 = arg_548_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_0 = 0.2

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["104701"]) then
				if arg_548_1.var_.actorSpriteComps104701 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								iter_551_1.color = Color.New(Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor1.r, (arg_548_1.time_ - 0) / var_551_0), Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor1.g, (arg_548_1.time_ - 0) / var_551_0), (Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor1.b, (arg_548_1.time_ - 0) / var_551_0)))
							else
								local var_551_1 = Mathf.Lerp(iter_551_1.color.r, 1, (arg_548_1.time_ - 0) / var_551_0)

								iter_551_1.color = Color.New(var_551_1, var_551_1, var_551_1)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["104701"]) and arg_548_1.var_.actorSpriteComps104701 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_551_3 then
						iter_551_3.color = arg_548_1.isInRecall_ and (arg_548_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_548_1.var_.actorSpriteComps104701 = nil
			end

			local var_551_2 = arg_548_1.actors_["104701"].transform

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.var_.moveOldPos104701 = var_551_2.localPosition
				var_551_2.localScale = Vector3.New(1, 1, 1)

				arg_548_1:CheckSpriteTmpPos("104701", 3)

				for iter_551_4 = 0, var_551_2.childCount - 1 do
					local var_551_3 = var_551_2:GetChild(iter_551_4)

					if var_551_3.name == "split_4" or not string.find(var_551_3.name, "split") then
						var_551_3.gameObject:SetActive(true)
					else
						var_551_3.gameObject:SetActive(false)
					end
				end
			end

			local var_551_4 = 0.001

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				var_551_2.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_548_1.time_ - 0) / var_551_4)
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				var_551_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				local var_551_5 = arg_548_1.actors_["104701"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_551_5 then
					arg_548_1.var_.alphaOldValue104701 = var_551_5.alpha
					arg_548_1.var_.characterEffect104701 = var_551_5
				end

				arg_548_1.var_.alphaOldValue104701 = 0
			end

			local var_551_6 = 0.2

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_6 then
				if arg_548_1.var_.characterEffect104701 then
					arg_548_1.var_.characterEffect104701.alpha = Mathf.Lerp(arg_548_1.var_.alphaOldValue104701, 1, (arg_548_1.time_ - 0) / var_551_6)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_6 and arg_548_1.time_ < 0 + var_551_6 + arg_551_0 and arg_548_1.var_.characterEffect104701 then
				arg_548_1.var_.characterEffect104701.alpha = 1
			end

			local var_551_7 = 0

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_7 + arg_551_0 then
				arg_548_1.allBtn_.enabled = false
			end

			if arg_548_1.time_ >= var_551_7 + 0.666666666666667 and arg_548_1.time_ < var_551_7 + 0.666666666666667 + arg_551_0 then
				arg_548_1.allBtn_.enabled = true
			end

			if arg_548_1.frameCnt_ <= 1 then
				arg_548_1.dialog_:SetActive(false)
			end

			local var_551_8 = 0.474999999999
			local var_551_9 = 0.525

			if 0.474999999999 < arg_548_1.time_ and arg_548_1.time_ <= var_551_8 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0

				arg_548_1.dialog_:SetActive(true)

				arg_548_1.dialogCg_.alpha = 0

				local var_551_10 = LeanTween.value(arg_548_1.dialog_, 0, 1, 0.3)

				var_551_10:setOnUpdate(LuaHelper.FloatAction(function(arg_552_0)
					arg_548_1.dialogCg_.alpha = arg_552_0
				end))
				var_551_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_548_1.dialog_)
					var_551_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_548_1.duration_ = arg_548_1.duration_ + 0.3

				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_11 = arg_548_1:GetWordFromCfg(926011132)
				local var_551_12 = arg_548_1:FormatText(var_551_11.content)

				arg_548_1.text_.text = var_551_12

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_14 = 21 <= 0 and var_551_9 or var_551_9 * (utf8.len(var_551_12) / 21)

				if (21 <= 0 and var_551_9 or var_551_9 * (utf8.len(var_551_12) / 21)) > 0 and var_551_9 < var_551_14 then
					arg_548_1.talkMaxDuration = var_551_14
					var_551_8 = var_551_8 + 0.3

					if var_551_14 + var_551_8 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_14 + var_551_8
					end
				end

				arg_548_1.text_.text = var_551_12
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011132", "story_v_out_926011.awb") ~= 0 then
					local var_551_15 = manager.audio:GetVoiceLength("story_v_out_926011", "926011132", "story_v_out_926011.awb") / 1000

					if var_551_15 + var_551_8 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_15 + var_551_8
					end

					if var_551_11.prefab_name ~= "" and arg_548_1.actors_[var_551_11.prefab_name] ~= nil then
						local var_551_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_11.prefab_name].transform, "story_v_out_926011", "926011132", "story_v_out_926011.awb")

						arg_548_1:RecordAudio("926011132", var_551_16)
						arg_548_1:RecordAudio("926011132", var_551_16)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_926011", "926011132", "story_v_out_926011.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_926011", "926011132", "story_v_out_926011.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_17 = var_551_8 + 0.3
			local var_551_18 = math.max(var_551_9, arg_548_1.talkMaxDuration)

			if var_551_8 + 0.3 <= arg_548_1.time_ and arg_548_1.time_ < var_551_17 + var_551_18 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_17) / var_551_18

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_17 + var_551_18 and arg_548_1.time_ < var_551_17 + var_551_18 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play926011133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 926011133
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play926011134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(arg_554_1.actors_["104701"]) and arg_554_1.var_.actorSpriteComps104701 == nil then
				arg_554_1.var_.actorSpriteComps104701 = arg_554_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_557_0 = 0.2

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 and not isNil(arg_554_1.actors_["104701"]) then
				if arg_554_1.var_.actorSpriteComps104701 then
					for iter_557_0, iter_557_1 in pairs(arg_554_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_557_1 then
							if arg_554_1.isInRecall_ then
								iter_557_1.color = Color.New(Mathf.Lerp(iter_557_1.color.r, arg_554_1.hightColor2.r, (arg_554_1.time_ - 0) / var_557_0), Mathf.Lerp(iter_557_1.color.g, arg_554_1.hightColor2.g, (arg_554_1.time_ - 0) / var_557_0), (Mathf.Lerp(iter_557_1.color.b, arg_554_1.hightColor2.b, (arg_554_1.time_ - 0) / var_557_0)))
							else
								local var_557_1 = Mathf.Lerp(iter_557_1.color.r, 0.5, (arg_554_1.time_ - 0) / var_557_0)

								iter_557_1.color = Color.New(var_557_1, var_557_1, var_557_1)
							end
						end
					end
				end
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 and not isNil(arg_554_1.actors_["104701"]) and arg_554_1.var_.actorSpriteComps104701 then
				for iter_557_2, iter_557_3 in pairs(arg_554_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_557_3 then
						iter_557_3.color = arg_554_1.isInRecall_ and (arg_554_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_554_1.var_.actorSpriteComps104701 = nil
			end

			local var_557_2 = 0
			local var_557_3 = 0.775

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_2 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, true)
				arg_554_1.iconController_:SetSelectedState("hero")

				arg_554_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_554_1.callingController_:SetSelectedState("normal")

				arg_554_1.keyicon_.color = Color.New(1, 1, 1)
				arg_554_1.icon_.color = Color.New(1, 1, 1)

				local var_557_4 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(926011133).content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_6 = 31 <= 0 and var_557_3 or var_557_3 * (utf8.len(var_557_4) / 31)

				if (31 <= 0 and var_557_3 or var_557_3 * (utf8.len(var_557_4) / 31)) > 0 and var_557_3 < var_557_6 then
					arg_554_1.talkMaxDuration = var_557_6

					if var_557_6 + var_557_2 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_6 + var_557_2
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_3, arg_554_1.talkMaxDuration)

			if var_557_2 <= arg_554_1.time_ and arg_554_1.time_ < var_557_2 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_2) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_2 + var_557_7 and arg_554_1.time_ < var_557_2 + var_557_7 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play926011134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 926011134
		arg_558_1.duration_ = 13.33

		local var_558_0 = {
			zh = 10.9,
			ja = 13.333
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play926011135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["104701"]) and arg_558_1.var_.actorSpriteComps104701 == nil then
				arg_558_1.var_.actorSpriteComps104701 = arg_558_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_561_0 = 0.2

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["104701"]) then
				if arg_558_1.var_.actorSpriteComps104701 then
					for iter_561_0, iter_561_1 in pairs(arg_558_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_561_1 then
							if arg_558_1.isInRecall_ then
								iter_561_1.color = Color.New(Mathf.Lerp(iter_561_1.color.r, arg_558_1.hightColor1.r, (arg_558_1.time_ - 0) / var_561_0), Mathf.Lerp(iter_561_1.color.g, arg_558_1.hightColor1.g, (arg_558_1.time_ - 0) / var_561_0), (Mathf.Lerp(iter_561_1.color.b, arg_558_1.hightColor1.b, (arg_558_1.time_ - 0) / var_561_0)))
							else
								local var_561_1 = Mathf.Lerp(iter_561_1.color.r, 1, (arg_558_1.time_ - 0) / var_561_0)

								iter_561_1.color = Color.New(var_561_1, var_561_1, var_561_1)
							end
						end
					end
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["104701"]) and arg_558_1.var_.actorSpriteComps104701 then
				for iter_561_2, iter_561_3 in pairs(arg_558_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_561_3 then
						iter_561_3.color = arg_558_1.isInRecall_ and (arg_558_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_558_1.var_.actorSpriteComps104701 = nil
			end

			local var_561_2 = arg_558_1.actors_["104701"].transform

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos104701 = var_561_2.localPosition
				var_561_2.localScale = Vector3.New(1, 1, 1)

				arg_558_1:CheckSpriteTmpPos("104701", 3)

				for iter_561_4 = 0, var_561_2.childCount - 1 do
					local var_561_3 = var_561_2:GetChild(iter_561_4)

					if var_561_3.name == "" or not string.find(var_561_3.name, "split") then
						var_561_3.gameObject:SetActive(true)
					else
						var_561_3.gameObject:SetActive(false)
					end
				end
			end

			local var_561_4 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				var_561_2.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_558_1.time_ - 0) / var_561_4)
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				var_561_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_561_5 = 0
			local var_561_6 = 1.05

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_5 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_7 = arg_558_1:GetWordFromCfg(926011134)
				local var_561_8 = arg_558_1:FormatText(var_561_7.content)

				arg_558_1.text_.text = var_561_8

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_10 = 42 <= 0 and var_561_6 or var_561_6 * (utf8.len(var_561_8) / 42)

				if (42 <= 0 and var_561_6 or var_561_6 * (utf8.len(var_561_8) / 42)) > 0 and var_561_6 < var_561_10 then
					arg_558_1.talkMaxDuration = var_561_10

					if var_561_10 + var_561_5 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_10 + var_561_5
					end
				end

				arg_558_1.text_.text = var_561_8
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011134", "story_v_out_926011.awb") ~= 0 then
					local var_561_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011134", "story_v_out_926011.awb") / 1000

					if var_561_11 + var_561_5 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_11 + var_561_5
					end

					if var_561_7.prefab_name ~= "" and arg_558_1.actors_[var_561_7.prefab_name] ~= nil then
						local var_561_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_7.prefab_name].transform, "story_v_out_926011", "926011134", "story_v_out_926011.awb")

						arg_558_1:RecordAudio("926011134", var_561_12)
						arg_558_1:RecordAudio("926011134", var_561_12)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_926011", "926011134", "story_v_out_926011.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_926011", "926011134", "story_v_out_926011.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_13 = math.max(var_561_6, arg_558_1.talkMaxDuration)

			if var_561_5 <= arg_558_1.time_ and arg_558_1.time_ < var_561_5 + var_561_13 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_5) / var_561_13

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_5 + var_561_13 and arg_558_1.time_ < var_561_5 + var_561_13 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play926011135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 926011135
		arg_562_1.duration_ = 3.7

		local var_562_0 = {
			zh = 2.9,
			ja = 3.7
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play926011136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(arg_562_1.actors_["128404"]) and arg_562_1.var_.actorSpriteComps128404 == nil then
				arg_562_1.var_.actorSpriteComps128404 = arg_562_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_565_0 = 0.2

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 and not isNil(arg_562_1.actors_["128404"]) then
				if arg_562_1.var_.actorSpriteComps128404 then
					for iter_565_0, iter_565_1 in pairs(arg_562_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_565_1 then
							if arg_562_1.isInRecall_ then
								iter_565_1.color = Color.New(Mathf.Lerp(iter_565_1.color.r, arg_562_1.hightColor1.r, (arg_562_1.time_ - 0) / var_565_0), Mathf.Lerp(iter_565_1.color.g, arg_562_1.hightColor1.g, (arg_562_1.time_ - 0) / var_565_0), (Mathf.Lerp(iter_565_1.color.b, arg_562_1.hightColor1.b, (arg_562_1.time_ - 0) / var_565_0)))
							else
								local var_565_1 = Mathf.Lerp(iter_565_1.color.r, 1, (arg_562_1.time_ - 0) / var_565_0)

								iter_565_1.color = Color.New(var_565_1, var_565_1, var_565_1)
							end
						end
					end
				end
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 and not isNil(arg_562_1.actors_["128404"]) and arg_562_1.var_.actorSpriteComps128404 then
				for iter_565_2, iter_565_3 in pairs(arg_562_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_565_3 then
						iter_565_3.color = arg_562_1.isInRecall_ and (arg_562_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_562_1.var_.actorSpriteComps128404 = nil
			end

			local var_565_2 = arg_562_1.actors_["104701"]

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(var_565_2) and arg_562_1.var_.actorSpriteComps104701 == nil then
				arg_562_1.var_.actorSpriteComps104701 = var_565_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_565_3 = 0.2

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_3 and not isNil(var_565_2) then
				if arg_562_1.var_.actorSpriteComps104701 then
					for iter_565_4, iter_565_5 in pairs(arg_562_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_565_5 then
							if arg_562_1.isInRecall_ then
								iter_565_5.color = Color.New(Mathf.Lerp(iter_565_5.color.r, arg_562_1.hightColor2.r, (arg_562_1.time_ - 0) / var_565_3), Mathf.Lerp(iter_565_5.color.g, arg_562_1.hightColor2.g, (arg_562_1.time_ - 0) / var_565_3), (Mathf.Lerp(iter_565_5.color.b, arg_562_1.hightColor2.b, (arg_562_1.time_ - 0) / var_565_3)))
							else
								local var_565_4 = Mathf.Lerp(iter_565_5.color.r, 0.5, (arg_562_1.time_ - 0) / var_565_3)

								iter_565_5.color = Color.New(var_565_4, var_565_4, var_565_4)
							end
						end
					end
				end
			end

			if arg_562_1.time_ >= 0 + var_565_3 and arg_562_1.time_ < 0 + var_565_3 + arg_565_0 and not isNil(var_565_2) and arg_562_1.var_.actorSpriteComps104701 then
				for iter_565_6, iter_565_7 in pairs(arg_562_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_565_7 then
						iter_565_7.color = arg_562_1.isInRecall_ and (arg_562_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_562_1.var_.actorSpriteComps104701 = nil
			end

			local var_565_5 = 0
			local var_565_6 = 0.325

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_5 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_7 = arg_562_1:GetWordFromCfg(926011135)
				local var_565_8 = arg_562_1:FormatText(var_565_7.content)

				arg_562_1.text_.text = var_565_8

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_10 = 13 <= 0 and var_565_6 or var_565_6 * (utf8.len(var_565_8) / 13)

				if (13 <= 0 and var_565_6 or var_565_6 * (utf8.len(var_565_8) / 13)) > 0 and var_565_6 < var_565_10 then
					arg_562_1.talkMaxDuration = var_565_10

					if var_565_10 + var_565_5 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_10 + var_565_5
					end
				end

				arg_562_1.text_.text = var_565_8
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011135", "story_v_out_926011.awb") ~= 0 then
					local var_565_11 = manager.audio:GetVoiceLength("story_v_out_926011", "926011135", "story_v_out_926011.awb") / 1000

					if var_565_11 + var_565_5 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_11 + var_565_5
					end

					if var_565_7.prefab_name ~= "" and arg_562_1.actors_[var_565_7.prefab_name] ~= nil then
						local var_565_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_7.prefab_name].transform, "story_v_out_926011", "926011135", "story_v_out_926011.awb")

						arg_562_1:RecordAudio("926011135", var_565_12)
						arg_562_1:RecordAudio("926011135", var_565_12)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_926011", "926011135", "story_v_out_926011.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_926011", "926011135", "story_v_out_926011.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_13 = math.max(var_565_6, arg_562_1.talkMaxDuration)

			if var_565_5 <= arg_562_1.time_ and arg_562_1.time_ < var_565_5 + var_565_13 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_5) / var_565_13

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_5 + var_565_13 and arg_562_1.time_ < var_565_5 + var_565_13 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play926011136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 926011136
		arg_566_1.duration_ = 6.2

		local var_566_0 = {
			zh = 5.633,
			ja = 6.2
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play926011137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["104701"]) and arg_566_1.var_.actorSpriteComps104701 == nil then
				arg_566_1.var_.actorSpriteComps104701 = arg_566_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_0 = 0.2

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["104701"]) then
				if arg_566_1.var_.actorSpriteComps104701 then
					for iter_569_0, iter_569_1 in pairs(arg_566_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_569_1 then
							if arg_566_1.isInRecall_ then
								iter_569_1.color = Color.New(Mathf.Lerp(iter_569_1.color.r, arg_566_1.hightColor1.r, (arg_566_1.time_ - 0) / var_569_0), Mathf.Lerp(iter_569_1.color.g, arg_566_1.hightColor1.g, (arg_566_1.time_ - 0) / var_569_0), (Mathf.Lerp(iter_569_1.color.b, arg_566_1.hightColor1.b, (arg_566_1.time_ - 0) / var_569_0)))
							else
								local var_569_1 = Mathf.Lerp(iter_569_1.color.r, 1, (arg_566_1.time_ - 0) / var_569_0)

								iter_569_1.color = Color.New(var_569_1, var_569_1, var_569_1)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["104701"]) and arg_566_1.var_.actorSpriteComps104701 then
				for iter_569_2, iter_569_3 in pairs(arg_566_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_569_3 then
						iter_569_3.color = arg_566_1.isInRecall_ and (arg_566_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_566_1.var_.actorSpriteComps104701 = nil
			end

			local var_569_2 = arg_566_1.actors_["128404"]

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(var_569_2) and arg_566_1.var_.actorSpriteComps128404 == nil then
				arg_566_1.var_.actorSpriteComps128404 = var_569_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_3 = 0.2

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_3 and not isNil(var_569_2) then
				if arg_566_1.var_.actorSpriteComps128404 then
					for iter_569_4, iter_569_5 in pairs(arg_566_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_569_5 then
							if arg_566_1.isInRecall_ then
								iter_569_5.color = Color.New(Mathf.Lerp(iter_569_5.color.r, arg_566_1.hightColor2.r, (arg_566_1.time_ - 0) / var_569_3), Mathf.Lerp(iter_569_5.color.g, arg_566_1.hightColor2.g, (arg_566_1.time_ - 0) / var_569_3), (Mathf.Lerp(iter_569_5.color.b, arg_566_1.hightColor2.b, (arg_566_1.time_ - 0) / var_569_3)))
							else
								local var_569_4 = Mathf.Lerp(iter_569_5.color.r, 0.5, (arg_566_1.time_ - 0) / var_569_3)

								iter_569_5.color = Color.New(var_569_4, var_569_4, var_569_4)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= 0 + var_569_3 and arg_566_1.time_ < 0 + var_569_3 + arg_569_0 and not isNil(var_569_2) and arg_566_1.var_.actorSpriteComps128404 then
				for iter_569_6, iter_569_7 in pairs(arg_566_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_569_7 then
						iter_569_7.color = arg_566_1.isInRecall_ and (arg_566_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_566_1.var_.actorSpriteComps128404 = nil
			end

			local var_569_5 = arg_566_1.actors_["104701"].transform

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.var_.moveOldPos104701 = var_569_5.localPosition
				var_569_5.localScale = Vector3.New(1, 1, 1)

				arg_566_1:CheckSpriteTmpPos("104701", 3)

				for iter_569_8 = 0, var_569_5.childCount - 1 do
					local var_569_6 = var_569_5:GetChild(iter_569_8)

					if var_569_6.name == "" or not string.find(var_569_6.name, "split") then
						var_569_6.gameObject:SetActive(true)
					else
						var_569_6.gameObject:SetActive(false)
					end
				end
			end

			local var_569_7 = 0.001

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_7 then
				var_569_5.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_566_1.time_ - 0) / var_569_7)
			end

			if arg_566_1.time_ >= 0 + var_569_7 and arg_566_1.time_ < 0 + var_569_7 + arg_569_0 then
				var_569_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_569_8 = 0
			local var_569_9 = 0.575

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_8 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_10 = arg_566_1:GetWordFromCfg(926011136)
				local var_569_11 = arg_566_1:FormatText(var_569_10.content)

				arg_566_1.text_.text = var_569_11

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_13 = 23 <= 0 and var_569_9 or var_569_9 * (utf8.len(var_569_11) / 23)

				if (23 <= 0 and var_569_9 or var_569_9 * (utf8.len(var_569_11) / 23)) > 0 and var_569_9 < var_569_13 then
					arg_566_1.talkMaxDuration = var_569_13

					if var_569_13 + var_569_8 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_13 + var_569_8
					end
				end

				arg_566_1.text_.text = var_569_11
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011136", "story_v_out_926011.awb") ~= 0 then
					local var_569_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011136", "story_v_out_926011.awb") / 1000

					if var_569_14 + var_569_8 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_14 + var_569_8
					end

					if var_569_10.prefab_name ~= "" and arg_566_1.actors_[var_569_10.prefab_name] ~= nil then
						local var_569_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_10.prefab_name].transform, "story_v_out_926011", "926011136", "story_v_out_926011.awb")

						arg_566_1:RecordAudio("926011136", var_569_15)
						arg_566_1:RecordAudio("926011136", var_569_15)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_926011", "926011136", "story_v_out_926011.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_926011", "926011136", "story_v_out_926011.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_16 = math.max(var_569_9, arg_566_1.talkMaxDuration)

			if var_569_8 <= arg_566_1.time_ and arg_566_1.time_ < var_569_8 + var_569_16 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_8) / var_569_16

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_8 + var_569_16 and arg_566_1.time_ < var_569_8 + var_569_16 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play926011137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 926011137
		arg_570_1.duration_ = 2.4

		local var_570_0 = {
			zh = 2.233,
			ja = 2.4
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play926011138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0.25

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_1 = arg_570_1:GetWordFromCfg(926011137)
				local var_573_2 = arg_570_1:FormatText(var_573_1.content)

				arg_570_1.text_.text = var_573_2

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_4 = 10 <= 0 and var_573_0 or var_573_0 * (utf8.len(var_573_2) / 10)

				if (10 <= 0 and var_573_0 or var_573_0 * (utf8.len(var_573_2) / 10)) > 0 and var_573_0 < var_573_4 then
					arg_570_1.talkMaxDuration = var_573_4

					if var_573_4 + 0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_4 + 0
					end
				end

				arg_570_1.text_.text = var_573_2
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011137", "story_v_out_926011.awb") ~= 0 then
					local var_573_5 = manager.audio:GetVoiceLength("story_v_out_926011", "926011137", "story_v_out_926011.awb") / 1000

					if var_573_5 + 0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_5 + 0
					end

					if var_573_1.prefab_name ~= "" and arg_570_1.actors_[var_573_1.prefab_name] ~= nil then
						local var_573_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_1.prefab_name].transform, "story_v_out_926011", "926011137", "story_v_out_926011.awb")

						arg_570_1:RecordAudio("926011137", var_573_6)
						arg_570_1:RecordAudio("926011137", var_573_6)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_926011", "926011137", "story_v_out_926011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_926011", "926011137", "story_v_out_926011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_7 = math.max(var_573_0, arg_570_1.talkMaxDuration)

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_7 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - 0) / var_573_7

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= 0 + var_573_7 and arg_570_1.time_ < 0 + var_573_7 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play926011138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 926011138
		arg_574_1.duration_ = 1

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"

			SetActive(arg_574_1.choicesGo_, true)

			for iter_575_0, iter_575_1 in ipairs(arg_574_1.choices_) do
				SetActive(iter_575_1.go, iter_575_0 <= 2)
			end

			arg_574_1.choices_[1].txt.text = arg_574_1:FormatText(StoryChoiceCfg[1312].name)
			arg_574_1.choices_[2].txt.text = arg_574_1:FormatText(StoryChoiceCfg[1313].name)
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play926011139(arg_574_1)
			end

			if arg_576_0 == 2 then
				arg_574_0:Play926011139(arg_574_1)
			end

			arg_574_1:RecordChoiceLog(926011138, 1312, 1313)
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["104701"]) and arg_574_1.var_.actorSpriteComps104701 == nil then
				arg_574_1.var_.actorSpriteComps104701 = arg_574_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_577_0 = 0.2

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["104701"]) then
				if arg_574_1.var_.actorSpriteComps104701 then
					for iter_577_0, iter_577_1 in pairs(arg_574_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_577_1 then
							if arg_574_1.isInRecall_ then
								iter_577_1.color = Color.New(Mathf.Lerp(iter_577_1.color.r, arg_574_1.hightColor2.r, (arg_574_1.time_ - 0) / var_577_0), Mathf.Lerp(iter_577_1.color.g, arg_574_1.hightColor2.g, (arg_574_1.time_ - 0) / var_577_0), (Mathf.Lerp(iter_577_1.color.b, arg_574_1.hightColor2.b, (arg_574_1.time_ - 0) / var_577_0)))
							else
								local var_577_1 = Mathf.Lerp(iter_577_1.color.r, 0.5, (arg_574_1.time_ - 0) / var_577_0)

								iter_577_1.color = Color.New(var_577_1, var_577_1, var_577_1)
							end
						end
					end
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["104701"]) and arg_574_1.var_.actorSpriteComps104701 then
				for iter_577_2, iter_577_3 in pairs(arg_574_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_577_3 then
						iter_577_3.color = arg_574_1.isInRecall_ and (arg_574_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_574_1.var_.actorSpriteComps104701 = nil
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play926011139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 926011139
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play926011140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0.65

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_1 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(926011139).content)

				arg_578_1.text_.text = var_581_1

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_3 = 26 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_1) / 26)

				if (26 <= 0 and var_581_0 or var_581_0 * (utf8.len(var_581_1) / 26)) > 0 and var_581_0 < var_581_3 then
					arg_578_1.talkMaxDuration = var_581_3

					if var_581_3 + 0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_3 + 0
					end
				end

				arg_578_1.text_.text = var_581_1
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_4 = math.max(var_581_0, arg_578_1.talkMaxDuration)

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_4 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - 0) / var_581_4

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= 0 + var_581_4 and arg_578_1.time_ < 0 + var_581_4 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play926011140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 926011140
		arg_582_1.duration_ = 3.03

		local var_582_0 = {
			zh = 2.533,
			ja = 3.033
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play926011141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["106103"]) and arg_582_1.var_.actorSpriteComps106103 == nil then
				arg_582_1.var_.actorSpriteComps106103 = arg_582_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_585_0 = 0.2

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["106103"]) then
				if arg_582_1.var_.actorSpriteComps106103 then
					for iter_585_0, iter_585_1 in pairs(arg_582_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_585_1 then
							if arg_582_1.isInRecall_ then
								iter_585_1.color = Color.New(Mathf.Lerp(iter_585_1.color.r, arg_582_1.hightColor1.r, (arg_582_1.time_ - 0) / var_585_0), Mathf.Lerp(iter_585_1.color.g, arg_582_1.hightColor1.g, (arg_582_1.time_ - 0) / var_585_0), (Mathf.Lerp(iter_585_1.color.b, arg_582_1.hightColor1.b, (arg_582_1.time_ - 0) / var_585_0)))
							else
								local var_585_1 = Mathf.Lerp(iter_585_1.color.r, 1, (arg_582_1.time_ - 0) / var_585_0)

								iter_585_1.color = Color.New(var_585_1, var_585_1, var_585_1)
							end
						end
					end
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["106103"]) and arg_582_1.var_.actorSpriteComps106103 then
				for iter_585_2, iter_585_3 in pairs(arg_582_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_585_3 then
						iter_585_3.color = arg_582_1.isInRecall_ and (arg_582_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_582_1.var_.actorSpriteComps106103 = nil
			end

			local var_585_2 = arg_582_1.actors_["104701"].transform

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos104701 = var_585_2.localPosition
				var_585_2.localScale = Vector3.New(1, 1, 1)

				arg_582_1:CheckSpriteTmpPos("104701", 7)

				for iter_585_4 = 0, var_585_2.childCount - 1 do
					local var_585_3 = var_585_2:GetChild(iter_585_4)

					if var_585_3.name == "" or not string.find(var_585_3.name, "split") then
						var_585_3.gameObject:SetActive(true)
					else
						var_585_3.gameObject:SetActive(false)
					end
				end
			end

			local var_585_4 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_4 then
				var_585_2.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_582_1.time_ - 0) / var_585_4)
			end

			if arg_582_1.time_ >= 0 + var_585_4 and arg_582_1.time_ < 0 + var_585_4 + arg_585_0 then
				var_585_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_585_5 = arg_582_1.actors_["106103"].transform

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos106103 = var_585_5.localPosition
				var_585_5.localScale = Vector3.New(1, 1, 1)

				arg_582_1:CheckSpriteTmpPos("106103", 3)

				for iter_585_5 = 0, var_585_5.childCount - 1 do
					local var_585_6 = var_585_5:GetChild(iter_585_5)

					if var_585_6.name == "split_5" or not string.find(var_585_6.name, "split") then
						var_585_6.gameObject:SetActive(true)
					else
						var_585_6.gameObject:SetActive(false)
					end
				end
			end

			local var_585_7 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_7 then
				var_585_5.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_582_1.time_ - 0) / var_585_7)
			end

			if arg_582_1.time_ >= 0 + var_585_7 and arg_582_1.time_ < 0 + var_585_7 + arg_585_0 then
				var_585_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_585_8 = 0
			local var_585_9 = 0.275

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_8 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_10 = arg_582_1:GetWordFromCfg(926011140)
				local var_585_11 = arg_582_1:FormatText(var_585_10.content)

				arg_582_1.text_.text = var_585_11

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_13 = 11 <= 0 and var_585_9 or var_585_9 * (utf8.len(var_585_11) / 11)

				if (11 <= 0 and var_585_9 or var_585_9 * (utf8.len(var_585_11) / 11)) > 0 and var_585_9 < var_585_13 then
					arg_582_1.talkMaxDuration = var_585_13

					if var_585_13 + var_585_8 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_13 + var_585_8
					end
				end

				arg_582_1.text_.text = var_585_11
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011140", "story_v_out_926011.awb") ~= 0 then
					local var_585_14 = manager.audio:GetVoiceLength("story_v_out_926011", "926011140", "story_v_out_926011.awb") / 1000

					if var_585_14 + var_585_8 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_14 + var_585_8
					end

					if var_585_10.prefab_name ~= "" and arg_582_1.actors_[var_585_10.prefab_name] ~= nil then
						local var_585_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_10.prefab_name].transform, "story_v_out_926011", "926011140", "story_v_out_926011.awb")

						arg_582_1:RecordAudio("926011140", var_585_15)
						arg_582_1:RecordAudio("926011140", var_585_15)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_926011", "926011140", "story_v_out_926011.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_926011", "926011140", "story_v_out_926011.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_16 = math.max(var_585_9, arg_582_1.talkMaxDuration)

			if var_585_8 <= arg_582_1.time_ and arg_582_1.time_ < var_585_8 + var_585_16 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_8) / var_585_16

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_8 + var_585_16 and arg_582_1.time_ < var_585_8 + var_585_16 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play926011141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 926011141
		arg_586_1.duration_ = 4.8

		local var_586_0 = {
			zh = 3.966,
			ja = 4.8
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
			arg_586_1.auto_ = false
		end

		function arg_586_1.playNext_(arg_588_0)
			arg_586_1.onStoryFinished_()
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos106103 = arg_586_1.actors_["106103"].transform.localPosition
				arg_586_1.actors_["106103"].transform.localScale = Vector3.New(1, 1, 1)

				arg_586_1:CheckSpriteTmpPos("106103", 3)

				for iter_589_0 = 0, arg_586_1.actors_["106103"].transform.childCount - 1 do
					local var_589_0 = arg_586_1.actors_["106103"].transform:GetChild(iter_589_0)

					if var_589_0.name == "split_3" or not string.find(var_589_0.name, "split") then
						var_589_0.gameObject:SetActive(true)
					else
						var_589_0.gameObject:SetActive(false)
					end
				end
			end

			local var_589_1 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_1 then
				arg_586_1.actors_["106103"].transform.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_586_1.time_ - 0) / var_589_1)
			end

			if arg_586_1.time_ >= 0 + var_589_1 and arg_586_1.time_ < 0 + var_589_1 + arg_589_0 then
				arg_586_1.actors_["106103"].transform.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			if 0.034 < arg_586_1.time_ and arg_586_1.time_ <= 0.034 + arg_589_0 then
				arg_586_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_organic", "")
			end

			local var_589_3 = 0
			local var_589_4 = 0.525

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_3 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_5 = arg_586_1:GetWordFromCfg(926011141)
				local var_589_6 = arg_586_1:FormatText(var_589_5.content)

				arg_586_1.text_.text = var_589_6

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_8 = 21 <= 0 and var_589_4 or var_589_4 * (utf8.len(var_589_6) / 21)

				if (21 <= 0 and var_589_4 or var_589_4 * (utf8.len(var_589_6) / 21)) > 0 and var_589_4 < var_589_8 then
					arg_586_1.talkMaxDuration = var_589_8

					if var_589_8 + var_589_3 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_8 + var_589_3
					end
				end

				arg_586_1.text_.text = var_589_6
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926011", "926011141", "story_v_out_926011.awb") ~= 0 then
					local var_589_9 = manager.audio:GetVoiceLength("story_v_out_926011", "926011141", "story_v_out_926011.awb") / 1000

					if var_589_9 + var_589_3 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_9 + var_589_3
					end

					if var_589_5.prefab_name ~= "" and arg_586_1.actors_[var_589_5.prefab_name] ~= nil then
						local var_589_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_5.prefab_name].transform, "story_v_out_926011", "926011141", "story_v_out_926011.awb")

						arg_586_1:RecordAudio("926011141", var_589_10)
						arg_586_1:RecordAudio("926011141", var_589_10)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_926011", "926011141", "story_v_out_926011.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_926011", "926011141", "story_v_out_926011.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_11 = math.max(var_589_4, arg_586_1.talkMaxDuration)

			if var_589_3 <= arg_586_1.time_ and arg_586_1.time_ < var_589_3 + var_589_11 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_3) / var_589_11

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_3 + var_589_11 and arg_586_1.time_ < var_589_3 + var_589_11 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I22f",
		"TextureConfig/Background/I22g"
	},
	voices = {
		"story_v_out_926011.awb"
	}
}
