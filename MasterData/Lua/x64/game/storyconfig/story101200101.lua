return {
	Play120011001 = function(arg_1_0, arg_1_1)
		arg_1_1.marker = "Mark1"
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120011001
		arg_1_1.duration_ = 178.38

		local var_1_0 = {
			zh = 166.099999999999,
			ja = 178.375
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
			arg_1_1.marker = ""

			if arg_3_0 == 1 then
				arg_1_0:Play120011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0101 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0101")
				var_4_0.name = "XH0101"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0101 = var_4_0
			end

			if 141.5 < arg_1_1.time_ and arg_1_1.time_ <= 141.5 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0101

				arg_1_1.bgs_.XH0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 138

			if 138 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 3.5

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = 1
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = 141.5

			if 141.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_9 = 4.5

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_8) / var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_11.a = 0
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = arg_1_1.bgs_.XH0101.transform

			if 141.5 < arg_1_1.time_ and arg_1_1.time_ <= 141.5 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0101 = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 141.5 <= arg_1_1.time_ and arg_1_1.time_ < 141.5 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0101, Vector3.New(0, 0.5, 2), (arg_1_1.time_ - 141.5) / var_4_13)
			end

			if arg_1_1.time_ >= 141.5 + var_4_13 and arg_1_1.time_ < 141.5 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, 0.5, 2)
			end

			local var_4_14 = arg_1_1.bgs_.XH0101.transform

			if 141.534 < arg_1_1.time_ and arg_1_1.time_ <= 141.534 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0101 = var_4_14.localPosition
			end

			local var_4_15 = 5

			if 141.534 <= arg_1_1.time_ and arg_1_1.time_ < 141.534 + var_4_15 then
				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0101, Vector3.New(-0.5, 0.5, 2), (arg_1_1.time_ - 141.534) / var_4_15)
			end

			if arg_1_1.time_ >= 141.534 + var_4_15 and arg_1_1.time_ < 141.534 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(-0.5, 0.5, 2)
			end

			local var_4_16 = 145.409

			if 145.409 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_16 + 1.12500000000001 and arg_1_1.time_ < var_4_16 + 1.12500000000001 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
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

			if 143.4 < arg_1_1.time_ and arg_1_1.time_ <= 143.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

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

			local var_4_23 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)

				arg_1_1.marker = "PlayCantSkipVideo"

				manager.video:Play("SofdecAsset/story/101200101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_23 + 141.490000000224

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					arg_1_1.state_ = arg_8_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_24 = 141.5

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.marker = ""
			end

			local var_4_25 = 141.5

			if 141.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_26 = 0.199999999999989

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				-- block empty
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 145.409
			local var_4_28 = 1.125

			if 145.409 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(120011001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 45 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 45)

				if (45 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 45)) > 0 and var_4_28 < var_4_33 then
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

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011001", "story_v_out_120011.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_120011", "120011001", "story_v_out_120011.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_120011", "120011001", "story_v_out_120011.awb")

						arg_1_1:RecordAudio("120011001", var_4_35)
						arg_1_1:RecordAudio("120011001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120011", "120011001", "story_v_out_120011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120011", "120011001", "story_v_out_120011.awb")
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
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 141.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 141.534,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120011002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 120011002
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play120011003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.5

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(120011002).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 60 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 60)

				if (60 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 60)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play120011003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 120011003
		arg_15_1.duration_ = 3.47

		local var_15_0 = {
			zh = 3.466,
			ja = 3.233
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
				arg_15_0:Play120011004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.325

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(120011003)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 13 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 13)

				if (13 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 13)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011003", "story_v_out_120011.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011003", "story_v_out_120011.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_120011", "120011003", "story_v_out_120011.awb")

						arg_15_1:RecordAudio("120011003", var_18_6)
						arg_15_1:RecordAudio("120011003", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_120011", "120011003", "story_v_out_120011.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_120011", "120011003", "story_v_out_120011.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play120011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 120011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play120011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.4

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(120011004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)

				if (16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play120011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 120011005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play120011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.35

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(120011005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 50 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 50)

				if (50 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 50)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play120011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 120011006
		arg_27_1.duration_ = 7.03

		local var_27_0 = {
			zh = 5.266,
			ja = 7.033
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
				arg_27_0:Play120011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.625

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:GetWordFromCfg(120011006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 25 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 25)

				if (25 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 25)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011006", "story_v_out_120011.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011006", "story_v_out_120011.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_120011", "120011006", "story_v_out_120011.awb")

						arg_27_1:RecordAudio("120011006", var_30_6)
						arg_27_1:RecordAudio("120011006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_120011", "120011006", "story_v_out_120011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_120011", "120011006", "story_v_out_120011.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play120011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 120011007
		arg_31_1.duration_ = 4.73

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play120011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.5

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(120011007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 20 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 20)

				if (20 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 20)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011007", "story_v_out_120011.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011007", "story_v_out_120011.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_120011", "120011007", "story_v_out_120011.awb")

						arg_31_1:RecordAudio("120011007", var_34_6)
						arg_31_1:RecordAudio("120011007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_120011", "120011007", "story_v_out_120011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_120011", "120011007", "story_v_out_120011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play120011008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 120011008
		arg_35_1.duration_ = 3.63

		local var_35_0 = {
			zh = 3.2,
			ja = 3.633
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
				arg_35_0:Play120011009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.425

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(120011008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 17)

				if (17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 17)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011008", "story_v_out_120011.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011008", "story_v_out_120011.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_120011", "120011008", "story_v_out_120011.awb")

						arg_35_1:RecordAudio("120011008", var_38_6)
						arg_35_1:RecordAudio("120011008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_120011", "120011008", "story_v_out_120011.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_120011", "120011008", "story_v_out_120011.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play120011009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 120011009
		arg_39_1.duration_ = 12

		local var_39_0 = {
			zh = 12,
			ja = 10.233
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
				arg_39_0:Play120011010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.125

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(120011009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 45 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 45)

				if (45 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 45)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011009", "story_v_out_120011.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011009", "story_v_out_120011.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_120011", "120011009", "story_v_out_120011.awb")

						arg_39_1:RecordAudio("120011009", var_42_6)
						arg_39_1:RecordAudio("120011009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_120011", "120011009", "story_v_out_120011.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_120011", "120011009", "story_v_out_120011.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play120011010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 120011010
		arg_43_1.duration_ = 7

		local var_43_0 = {
			zh = 7,
			ja = 6.4
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
				arg_43_0:Play120011011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.5

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(120011010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 20 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 20)

				if (20 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 20)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011010", "story_v_out_120011.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011010", "story_v_out_120011.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_120011", "120011010", "story_v_out_120011.awb")

						arg_43_1:RecordAudio("120011010", var_46_6)
						arg_43_1:RecordAudio("120011010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_120011", "120011010", "story_v_out_120011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_120011", "120011010", "story_v_out_120011.awb")
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
	Play120011011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 120011011
		arg_47_1.duration_ = 12.43

		local var_47_0 = {
			zh = 9.666,
			ja = 12.433
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
				arg_47_0:Play120011012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(120011011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 49 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 49)

				if (49 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 49)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011011", "story_v_out_120011.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011011", "story_v_out_120011.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_120011", "120011011", "story_v_out_120011.awb")

						arg_47_1:RecordAudio("120011011", var_50_6)
						arg_47_1:RecordAudio("120011011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_120011", "120011011", "story_v_out_120011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_120011", "120011011", "story_v_out_120011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play120011012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 120011012
		arg_51_1.duration_ = 9.8

		local var_51_0 = {
			zh = 9.266,
			ja = 9.8
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
				arg_51_0:Play120011013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_0 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				local var_54_1 = Color.New(0, 0, 0)

				var_54_1.a = Mathf.Lerp(0, 1, (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.mask_.color = var_54_1
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				local var_54_2 = Color.New(0, 0, 0)

				var_54_2.a = 1
				arg_51_1.mask_.color = var_54_2
			end

			local var_54_3 = 2

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_4 = 2

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_4 then
				local var_54_5 = Color.New(0, 0, 0)

				var_54_5.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_3) / var_54_4)
				arg_51_1.mask_.color = var_54_5
			end

			if arg_51_1.time_ >= var_54_3 + var_54_4 and arg_51_1.time_ < var_54_3 + var_54_4 + arg_54_0 then
				local var_54_6 = Color.New(0, 0, 0)

				arg_51_1.mask_.enabled = false
				var_54_6.a = 0
				arg_51_1.mask_.color = var_54_6
			end

			local var_54_7 = arg_51_1.bgs_.XH0101.transform

			if 1.98333333333333 < arg_51_1.time_ and arg_51_1.time_ <= 1.98333333333333 + arg_54_0 then
				arg_51_1.var_.moveOldPosXH0101 = var_54_7.localPosition
			end

			local var_54_8 = 0.001

			if 1.98333333333333 <= arg_51_1.time_ and arg_51_1.time_ < 1.98333333333333 + var_54_8 then
				var_54_7.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPosXH0101, Vector3.New(0, 1, 10), (arg_51_1.time_ - 1.98333333333333) / var_54_8)
			end

			if arg_51_1.time_ >= 1.98333333333333 + var_54_8 and arg_51_1.time_ < 1.98333333333333 + var_54_8 + arg_54_0 then
				var_54_7.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_9 = 4
			local var_54_10 = 0.5

			if 4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_11 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_11:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_12 = arg_51_1:GetWordFromCfg(120011012)
				local var_54_13 = arg_51_1:FormatText(var_54_12.content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 20 <= 0 and var_54_10 or var_54_10 * (utf8.len(var_54_13) / 20)

				if (20 <= 0 and var_54_10 or var_54_10 * (utf8.len(var_54_13) / 20)) > 0 and var_54_10 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15
					var_54_9 = var_54_9 + 0.3

					if var_54_15 + var_54_9 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_9
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011012", "story_v_out_120011.awb") ~= 0 then
					local var_54_16 = manager.audio:GetVoiceLength("story_v_out_120011", "120011012", "story_v_out_120011.awb") / 1000

					if var_54_16 + var_54_9 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_9
					end

					if var_54_12.prefab_name ~= "" and arg_51_1.actors_[var_54_12.prefab_name] ~= nil then
						local var_54_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_12.prefab_name].transform, "story_v_out_120011", "120011012", "story_v_out_120011.awb")

						arg_51_1:RecordAudio("120011012", var_54_17)
						arg_51_1:RecordAudio("120011012", var_54_17)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_120011", "120011012", "story_v_out_120011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_120011", "120011012", "story_v_out_120011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = var_54_9 + 0.3
			local var_54_19 = math.max(var_54_10, arg_51_1.talkMaxDuration)

			if var_54_9 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_18 + var_54_19 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_18) / var_54_19

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_18 + var_54_19 and arg_51_1.time_ < var_54_18 + var_54_19 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play120011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120011013
		arg_57_1.duration_ = 7.63

		local var_57_0 = {
			zh = 7.4,
			ja = 7.633
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
				arg_57_0:Play120011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.95

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(120011013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 38 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 38)

				if (38 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 38)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011013", "story_v_out_120011.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011013", "story_v_out_120011.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_120011", "120011013", "story_v_out_120011.awb")

						arg_57_1:RecordAudio("120011013", var_60_6)
						arg_57_1:RecordAudio("120011013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120011", "120011013", "story_v_out_120011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120011", "120011013", "story_v_out_120011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play120011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120011014
		arg_61_1.duration_ = 6.37

		local var_61_0 = {
			zh = 4.866,
			ja = 6.366
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
				arg_61_0:Play120011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(120011014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 20)

				if (20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 20)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011014", "story_v_out_120011.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011014", "story_v_out_120011.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_120011", "120011014", "story_v_out_120011.awb")

						arg_61_1:RecordAudio("120011014", var_64_6)
						arg_61_1:RecordAudio("120011014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_120011", "120011014", "story_v_out_120011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_120011", "120011014", "story_v_out_120011.awb")
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
	Play120011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120011015
		arg_65_1.duration_ = 4.07

		local var_65_0 = {
			zh = 1.466,
			ja = 4.066
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
				arg_65_0:Play120011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(120011015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 5 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 5)

				if (5 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 5)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011015", "story_v_out_120011.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011015", "story_v_out_120011.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_120011", "120011015", "story_v_out_120011.awb")

						arg_65_1:RecordAudio("120011015", var_68_6)
						arg_65_1:RecordAudio("120011015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120011", "120011015", "story_v_out_120011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120011", "120011015", "story_v_out_120011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play120011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120011016
		arg_69_1.duration_ = 12.73

		local var_69_0 = {
			zh = 12.733,
			ja = 9.366
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
				arg_69_0:Play120011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.225

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(120011016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 49 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 49)

				if (49 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 49)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011016", "story_v_out_120011.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011016", "story_v_out_120011.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_120011", "120011016", "story_v_out_120011.awb")

						arg_69_1:RecordAudio("120011016", var_72_6)
						arg_69_1:RecordAudio("120011016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120011", "120011016", "story_v_out_120011.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120011", "120011016", "story_v_out_120011.awb")
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
	Play120011017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120011017
		arg_73_1.duration_ = 11.83

		local var_73_0 = {
			zh = 11.666,
			ja = 11.833
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
				arg_73_0:Play120011018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(120011017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 50 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 50)

				if (50 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 50)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011017", "story_v_out_120011.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011017", "story_v_out_120011.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_120011", "120011017", "story_v_out_120011.awb")

						arg_73_1:RecordAudio("120011017", var_76_6)
						arg_73_1:RecordAudio("120011017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_120011", "120011017", "story_v_out_120011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_120011", "120011017", "story_v_out_120011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play120011018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120011018
		arg_77_1.duration_ = 4.77

		local var_77_0 = {
			zh = 1.566,
			ja = 4.766
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
				arg_77_0:Play120011019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(120011018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 5 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 5)

				if (5 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 5)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011018", "story_v_out_120011.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011018", "story_v_out_120011.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_120011", "120011018", "story_v_out_120011.awb")

						arg_77_1:RecordAudio("120011018", var_80_6)
						arg_77_1:RecordAudio("120011018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_120011", "120011018", "story_v_out_120011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_120011", "120011018", "story_v_out_120011.awb")
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
	Play120011019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120011019
		arg_81_1.duration_ = 13.53

		local var_81_0 = {
			zh = 8.466,
			ja = 13.533
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
				arg_81_0:Play120011020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.85

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(120011019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 34 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 34)

				if (34 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 34)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011019", "story_v_out_120011.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011019", "story_v_out_120011.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_120011", "120011019", "story_v_out_120011.awb")

						arg_81_1:RecordAudio("120011019", var_84_6)
						arg_81_1:RecordAudio("120011019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120011", "120011019", "story_v_out_120011.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120011", "120011019", "story_v_out_120011.awb")
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
	Play120011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120011020
		arg_85_1.duration_ = 3.5

		local var_85_0 = {
			zh = 3.3,
			ja = 3.5
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
				arg_85_0:Play120011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(120011020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 16)

				if (16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 16)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011020", "story_v_out_120011.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011020", "story_v_out_120011.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_120011", "120011020", "story_v_out_120011.awb")

						arg_85_1:RecordAudio("120011020", var_88_6)
						arg_85_1:RecordAudio("120011020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120011", "120011020", "story_v_out_120011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120011", "120011020", "story_v_out_120011.awb")
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
	Play120011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120011021
		arg_89_1.duration_ = 13.27

		local var_89_0 = {
			zh = 13.266,
			ja = 12.733
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
				arg_89_0:Play120011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(120011021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 58 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 58)

				if (58 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 58)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011021", "story_v_out_120011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011021", "story_v_out_120011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_120011", "120011021", "story_v_out_120011.awb")

						arg_89_1:RecordAudio("120011021", var_92_6)
						arg_89_1:RecordAudio("120011021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_120011", "120011021", "story_v_out_120011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_120011", "120011021", "story_v_out_120011.awb")
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
	Play120011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120011022
		arg_93_1.duration_ = 9.8

		local var_93_0 = {
			zh = 6.3,
			ja = 9.8
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
				arg_93_0:Play120011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.575

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(120011022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 23 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 23)

				if (23 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 23)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011022", "story_v_out_120011.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011022", "story_v_out_120011.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_120011", "120011022", "story_v_out_120011.awb")

						arg_93_1:RecordAudio("120011022", var_96_6)
						arg_93_1:RecordAudio("120011022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120011", "120011022", "story_v_out_120011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120011", "120011022", "story_v_out_120011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120011023
		arg_97_1.duration_ = 4

		local var_97_0 = {
			zh = 3.966,
			ja = 4
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
				arg_97_0:Play120011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(120011023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 11 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 11)

				if (11 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 11)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011023", "story_v_out_120011.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011023", "story_v_out_120011.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_120011", "120011023", "story_v_out_120011.awb")

						arg_97_1:RecordAudio("120011023", var_100_6)
						arg_97_1:RecordAudio("120011023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_120011", "120011023", "story_v_out_120011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_120011", "120011023", "story_v_out_120011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120011024
		arg_101_1.duration_ = 4.7

		local var_101_0 = {
			zh = 3.133,
			ja = 4.7
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
				arg_101_0:Play120011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.35

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(120011024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 14 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 14)

				if (14 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 14)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011024", "story_v_out_120011.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011024", "story_v_out_120011.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_120011", "120011024", "story_v_out_120011.awb")

						arg_101_1:RecordAudio("120011024", var_104_6)
						arg_101_1:RecordAudio("120011024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_120011", "120011024", "story_v_out_120011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_120011", "120011024", "story_v_out_120011.awb")
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
	Play120011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120011025
		arg_105_1.duration_ = 1.27

		local var_105_0 = {
			zh = 1.266,
			ja = 0.999999999999
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
				arg_105_0:Play120011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.05

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(120011025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 2 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 2)

				if (2 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 2)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011025", "story_v_out_120011.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011025", "story_v_out_120011.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_120011", "120011025", "story_v_out_120011.awb")

						arg_105_1:RecordAudio("120011025", var_108_6)
						arg_105_1:RecordAudio("120011025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120011", "120011025", "story_v_out_120011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120011", "120011025", "story_v_out_120011.awb")
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
	Play120011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120011026
		arg_109_1.duration_ = 4.73

		local var_109_0 = {
			zh = 4.133,
			ja = 4.733
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
				arg_109_0:Play120011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.575

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(120011026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 23 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 23)

				if (23 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 23)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011026", "story_v_out_120011.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011026", "story_v_out_120011.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_120011", "120011026", "story_v_out_120011.awb")

						arg_109_1:RecordAudio("120011026", var_112_6)
						arg_109_1:RecordAudio("120011026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_120011", "120011026", "story_v_out_120011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_120011", "120011026", "story_v_out_120011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play120011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120011027
		arg_113_1.duration_ = 8.6

		local var_113_0 = {
			zh = 6.1,
			ja = 8.6
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
				arg_113_0:Play120011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(120011027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 21 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 21)

				if (21 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 21)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011027", "story_v_out_120011.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011027", "story_v_out_120011.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_120011", "120011027", "story_v_out_120011.awb")

						arg_113_1:RecordAudio("120011027", var_116_6)
						arg_113_1:RecordAudio("120011027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120011", "120011027", "story_v_out_120011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120011", "120011027", "story_v_out_120011.awb")
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
	Play120011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120011028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play120011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(120011028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)

				if (23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120011029
		arg_121_1.duration_ = 6.9

		local var_121_0 = {
			zh = 6.9,
			ja = 5.2
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
				arg_121_0:Play120011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.675

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(120011029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 27 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 27)

				if (27 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 27)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011029", "story_v_out_120011.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011029", "story_v_out_120011.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_120011", "120011029", "story_v_out_120011.awb")

						arg_121_1:RecordAudio("120011029", var_124_6)
						arg_121_1:RecordAudio("120011029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120011", "120011029", "story_v_out_120011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120011", "120011029", "story_v_out_120011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120011030
		arg_125_1.duration_ = 5.1

		local var_125_0 = {
			zh = 1.666,
			ja = 5.1
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
				arg_125_0:Play120011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.225

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(120011030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 9 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 9)

				if (9 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 9)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011030", "story_v_out_120011.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011030", "story_v_out_120011.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_120011", "120011030", "story_v_out_120011.awb")

						arg_125_1:RecordAudio("120011030", var_128_6)
						arg_125_1:RecordAudio("120011030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120011", "120011030", "story_v_out_120011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120011", "120011030", "story_v_out_120011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120011031
		arg_129_1.duration_ = 6

		local var_129_0 = {
			zh = 4.033,
			ja = 6
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
				arg_129_0:Play120011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(120011031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)

				if (21 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 21)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011031", "story_v_out_120011.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011031", "story_v_out_120011.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_120011", "120011031", "story_v_out_120011.awb")

						arg_129_1:RecordAudio("120011031", var_132_6)
						arg_129_1:RecordAudio("120011031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120011", "120011031", "story_v_out_120011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120011", "120011031", "story_v_out_120011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120011032
		arg_133_1.duration_ = 8.47

		local var_133_0 = {
			zh = 6.433,
			ja = 8.466
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
				arg_133_0:Play120011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.7

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(120011032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 28 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 28)

				if (28 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 28)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011032", "story_v_out_120011.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011032", "story_v_out_120011.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_120011", "120011032", "story_v_out_120011.awb")

						arg_133_1:RecordAudio("120011032", var_136_6)
						arg_133_1:RecordAudio("120011032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120011", "120011032", "story_v_out_120011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120011", "120011032", "story_v_out_120011.awb")
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
	Play120011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120011033
		arg_137_1.duration_ = 2.4

		local var_137_0 = {
			zh = 1.033,
			ja = 2.4
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play120011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(120011033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 3 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 3)

				if (3 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 3)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011033", "story_v_out_120011.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011033", "story_v_out_120011.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_120011", "120011033", "story_v_out_120011.awb")

						arg_137_1:RecordAudio("120011033", var_140_6)
						arg_137_1:RecordAudio("120011033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120011", "120011033", "story_v_out_120011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120011", "120011033", "story_v_out_120011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play120011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120011034
		arg_141_1.duration_ = 10.83

		local var_141_0 = {
			zh = 7.066,
			ja = 10.833
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play120011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.325

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(120011034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 13 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 13)

				if (13 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 13)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011034", "story_v_out_120011.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011034", "story_v_out_120011.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_120011", "120011034", "story_v_out_120011.awb")

						arg_141_1:RecordAudio("120011034", var_144_6)
						arg_141_1:RecordAudio("120011034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120011", "120011034", "story_v_out_120011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120011", "120011034", "story_v_out_120011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play120011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120011035
		arg_145_1.duration_ = 3.6

		local var_145_0 = {
			zh = 2.4,
			ja = 3.6
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
				arg_145_0:Play120011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(120011035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)

				if (12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011035", "story_v_out_120011.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011035", "story_v_out_120011.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_120011", "120011035", "story_v_out_120011.awb")

						arg_145_1:RecordAudio("120011035", var_148_6)
						arg_145_1:RecordAudio("120011035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120011", "120011035", "story_v_out_120011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120011", "120011035", "story_v_out_120011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play120011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120011036
		arg_149_1.duration_ = 7.03

		local var_149_0 = {
			zh = 7.033,
			ja = 5.166
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play120011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(120011036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 31 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 31)

				if (31 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 31)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011036", "story_v_out_120011.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011036", "story_v_out_120011.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_120011", "120011036", "story_v_out_120011.awb")

						arg_149_1:RecordAudio("120011036", var_152_6)
						arg_149_1:RecordAudio("120011036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120011", "120011036", "story_v_out_120011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120011", "120011036", "story_v_out_120011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120011037
		arg_153_1.duration_ = 10.3

		local var_153_0 = {
			zh = 6.133,
			ja = 10.3
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
				arg_153_0:Play120011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.75

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(120011037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 30 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 30)

				if (30 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 30)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011037", "story_v_out_120011.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011037", "story_v_out_120011.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_120011", "120011037", "story_v_out_120011.awb")

						arg_153_1:RecordAudio("120011037", var_156_6)
						arg_153_1:RecordAudio("120011037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120011", "120011037", "story_v_out_120011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120011", "120011037", "story_v_out_120011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120011038
		arg_157_1.duration_ = 11.2

		local var_157_0 = {
			zh = 9.366,
			ja = 11.2
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
				arg_157_0:Play120011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.9

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(120011038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)

				if (36 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 36)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011038", "story_v_out_120011.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011038", "story_v_out_120011.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_120011", "120011038", "story_v_out_120011.awb")

						arg_157_1:RecordAudio("120011038", var_160_6)
						arg_157_1:RecordAudio("120011038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120011", "120011038", "story_v_out_120011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120011", "120011038", "story_v_out_120011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120011039
		arg_161_1.duration_ = 14.5

		local var_161_0 = {
			zh = 5.466,
			ja = 14.5
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
				arg_161_0:Play120011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.575

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(120011039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 23 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 23)

				if (23 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 23)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011039", "story_v_out_120011.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011039", "story_v_out_120011.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_120011", "120011039", "story_v_out_120011.awb")

						arg_161_1:RecordAudio("120011039", var_164_6)
						arg_161_1:RecordAudio("120011039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120011", "120011039", "story_v_out_120011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120011", "120011039", "story_v_out_120011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120011040
		arg_165_1.duration_ = 8.47

		local var_165_0 = {
			zh = 8.466,
			ja = 6.6
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
				arg_165_0:Play120011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(120011040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 36)

				if (36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 36)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011040", "story_v_out_120011.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011040", "story_v_out_120011.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_120011", "120011040", "story_v_out_120011.awb")

						arg_165_1:RecordAudio("120011040", var_168_6)
						arg_165_1:RecordAudio("120011040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_120011", "120011040", "story_v_out_120011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_120011", "120011040", "story_v_out_120011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120011041
		arg_169_1.duration_ = 9.6

		local var_169_0 = {
			zh = 9.6,
			ja = 7.9
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
				arg_169_0:Play120011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.075

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(120011041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 43 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 43)

				if (43 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 43)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011041", "story_v_out_120011.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011041", "story_v_out_120011.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_120011", "120011041", "story_v_out_120011.awb")

						arg_169_1:RecordAudio("120011041", var_172_6)
						arg_169_1:RecordAudio("120011041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120011", "120011041", "story_v_out_120011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120011", "120011041", "story_v_out_120011.awb")
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
	Play120011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120011042
		arg_173_1.duration_ = 7.43

		local var_173_0 = {
			zh = 6.3,
			ja = 7.433
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
				arg_173_0:Play120011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(120011042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 25 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 25)

				if (25 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 25)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011042", "story_v_out_120011.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011042", "story_v_out_120011.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_120011", "120011042", "story_v_out_120011.awb")

						arg_173_1:RecordAudio("120011042", var_176_6)
						arg_173_1:RecordAudio("120011042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120011", "120011042", "story_v_out_120011.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120011", "120011042", "story_v_out_120011.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play120011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120011043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play120011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.75

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

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(120011043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 29 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 29)

				if (29 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 29)) > 0 and var_180_0 < var_180_3 then
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
	Play120011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120011044
		arg_181_1.duration_ = 9

		local var_181_0 = {
			zh = 8.866,
			ja = 9
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
				arg_181_0:Play120011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.275

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:GetWordFromCfg(120011044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 11 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 11)

				if (11 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 11)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011044", "story_v_out_120011.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011044", "story_v_out_120011.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_120011", "120011044", "story_v_out_120011.awb")

						arg_181_1:RecordAudio("120011044", var_184_6)
						arg_181_1:RecordAudio("120011044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120011", "120011044", "story_v_out_120011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120011", "120011044", "story_v_out_120011.awb")
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
	Play120011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120011045
		arg_185_1.duration_ = 3.53

		local var_185_0 = {
			zh = 3.3,
			ja = 3.533
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
				arg_185_0:Play120011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.225

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(120011045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 9)

				if (9 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 9)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011045", "story_v_out_120011.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011045", "story_v_out_120011.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_120011", "120011045", "story_v_out_120011.awb")

						arg_185_1:RecordAudio("120011045", var_188_6)
						arg_185_1:RecordAudio("120011045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120011", "120011045", "story_v_out_120011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120011", "120011045", "story_v_out_120011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120011046
		arg_189_1.duration_ = 7.7

		local var_189_0 = {
			zh = 4.9,
			ja = 7.7
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
				arg_189_0:Play120011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.45

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(120011046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)

				if (18 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 18)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011046", "story_v_out_120011.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011046", "story_v_out_120011.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_120011", "120011046", "story_v_out_120011.awb")

						arg_189_1:RecordAudio("120011046", var_192_6)
						arg_189_1:RecordAudio("120011046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120011", "120011046", "story_v_out_120011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120011", "120011046", "story_v_out_120011.awb")
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
	Play120011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120011047
		arg_193_1.duration_ = 12.17

		local var_193_0 = {
			zh = 8.7,
			ja = 12.166
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
				arg_193_0:Play120011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.9

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(120011047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 36)

				if (36 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 36)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011047", "story_v_out_120011.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011047", "story_v_out_120011.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_120011", "120011047", "story_v_out_120011.awb")

						arg_193_1:RecordAudio("120011047", var_196_6)
						arg_193_1:RecordAudio("120011047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_120011", "120011047", "story_v_out_120011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_120011", "120011047", "story_v_out_120011.awb")
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
	Play120011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120011048
		arg_197_1.duration_ = 7.87

		local var_197_0 = {
			zh = 5.866,
			ja = 7.866
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
				arg_197_0:Play120011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.55

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(120011048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 22)

				if (22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 22)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011048", "story_v_out_120011.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011048", "story_v_out_120011.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_120011", "120011048", "story_v_out_120011.awb")

						arg_197_1:RecordAudio("120011048", var_200_6)
						arg_197_1:RecordAudio("120011048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120011", "120011048", "story_v_out_120011.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120011", "120011048", "story_v_out_120011.awb")
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
	Play120011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120011049
		arg_201_1.duration_ = 6.9

		local var_201_0 = {
			zh = 5.3,
			ja = 6.9
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
				arg_201_0:Play120011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(120011049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 21 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 21)

				if (21 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 21)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011049", "story_v_out_120011.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011049", "story_v_out_120011.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_120011", "120011049", "story_v_out_120011.awb")

						arg_201_1:RecordAudio("120011049", var_204_6)
						arg_201_1:RecordAudio("120011049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120011", "120011049", "story_v_out_120011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120011", "120011049", "story_v_out_120011.awb")
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
	Play120011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120011050
		arg_205_1.duration_ = 3.03

		local var_205_0 = {
			zh = 1.6,
			ja = 3.033
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
				arg_205_0:Play120011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.2

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(120011050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 8 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 8)

				if (8 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 8)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011050", "story_v_out_120011.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011050", "story_v_out_120011.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_120011", "120011050", "story_v_out_120011.awb")

						arg_205_1:RecordAudio("120011050", var_208_6)
						arg_205_1:RecordAudio("120011050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_120011", "120011050", "story_v_out_120011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_120011", "120011050", "story_v_out_120011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play120011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120011051
		arg_209_1.duration_ = 1.97

		local var_209_0 = {
			zh = 1.266,
			ja = 1.966
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
				arg_209_0:Play120011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(120011051)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 4 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 4)

				if (4 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 4)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011051", "story_v_out_120011.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011051", "story_v_out_120011.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_120011", "120011051", "story_v_out_120011.awb")

						arg_209_1:RecordAudio("120011051", var_212_6)
						arg_209_1:RecordAudio("120011051", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120011", "120011051", "story_v_out_120011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120011", "120011051", "story_v_out_120011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120011052
		arg_213_1.duration_ = 3.67

		local var_213_0 = {
			zh = 3.666,
			ja = 1.8
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play120011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.3

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(120011052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 12 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 12)

				if (12 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 12)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011052", "story_v_out_120011.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011052", "story_v_out_120011.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_120011", "120011052", "story_v_out_120011.awb")

						arg_213_1:RecordAudio("120011052", var_216_6)
						arg_213_1:RecordAudio("120011052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_120011", "120011052", "story_v_out_120011.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_120011", "120011052", "story_v_out_120011.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120011053
		arg_217_1.duration_ = 10.1

		local var_217_0 = {
			zh = 10.1,
			ja = 8.366
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
				arg_217_0:Play120011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.95

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(120011053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 38 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 38)

				if (38 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 38)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011053", "story_v_out_120011.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011053", "story_v_out_120011.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_120011", "120011053", "story_v_out_120011.awb")

						arg_217_1:RecordAudio("120011053", var_220_6)
						arg_217_1:RecordAudio("120011053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_120011", "120011053", "story_v_out_120011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_120011", "120011053", "story_v_out_120011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play120011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120011054
		arg_221_1.duration_ = 5.1

		local var_221_0 = {
			zh = 1.633,
			ja = 5.1
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
				arg_221_0:Play120011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.2

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(120011054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 8 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 8)

				if (8 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 8)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011054", "story_v_out_120011.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011054", "story_v_out_120011.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_120011", "120011054", "story_v_out_120011.awb")

						arg_221_1:RecordAudio("120011054", var_224_6)
						arg_221_1:RecordAudio("120011054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_120011", "120011054", "story_v_out_120011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_120011", "120011054", "story_v_out_120011.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play120011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120011055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play120011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.2

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(120011055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 48 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 48)

				if (48 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 48)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play120011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120011056
		arg_229_1.duration_ = 1.93

		local var_229_0 = {
			zh = 1.6,
			ja = 1.933
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
				arg_229_0:Play120011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.175

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(120011056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 7 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 7)

				if (7 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 7)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011056", "story_v_out_120011.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011056", "story_v_out_120011.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_120011", "120011056", "story_v_out_120011.awb")

						arg_229_1:RecordAudio("120011056", var_232_6)
						arg_229_1:RecordAudio("120011056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120011", "120011056", "story_v_out_120011.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120011", "120011056", "story_v_out_120011.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play120011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120011057
		arg_233_1.duration_ = 6.97

		local var_233_0 = {
			zh = 3.9,
			ja = 6.966
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play120011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.375

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(120011057)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 15)

				if (15 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 15)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011057", "story_v_out_120011.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011057", "story_v_out_120011.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_120011", "120011057", "story_v_out_120011.awb")

						arg_233_1:RecordAudio("120011057", var_236_6)
						arg_233_1:RecordAudio("120011057", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_120011", "120011057", "story_v_out_120011.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_120011", "120011057", "story_v_out_120011.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play120011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 120011058
		arg_237_1.duration_ = 4.97

		local var_237_0 = {
			zh = 4.966,
			ja = 3.733
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
				arg_237_0:Play120011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(120011058)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 16 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 16)

				if (16 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 16)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011058", "story_v_out_120011.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011058", "story_v_out_120011.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_120011", "120011058", "story_v_out_120011.awb")

						arg_237_1:RecordAudio("120011058", var_240_6)
						arg_237_1:RecordAudio("120011058", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_120011", "120011058", "story_v_out_120011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_120011", "120011058", "story_v_out_120011.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play120011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120011059
		arg_241_1.duration_ = 7.5

		local var_241_0 = {
			zh = 5.966,
			ja = 7.5
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
				arg_241_0:Play120011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(120011059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 21 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 21)

				if (21 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 21)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011059", "story_v_out_120011.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011059", "story_v_out_120011.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_120011", "120011059", "story_v_out_120011.awb")

						arg_241_1:RecordAudio("120011059", var_244_6)
						arg_241_1:RecordAudio("120011059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_120011", "120011059", "story_v_out_120011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_120011", "120011059", "story_v_out_120011.awb")
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
	Play120011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120011060
		arg_245_1.duration_ = 1.3

		local var_245_0 = {
			zh = 1.3,
			ja = 1.1
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play120011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(120011060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 3 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 3)

				if (3 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 3)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011060", "story_v_out_120011.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011060", "story_v_out_120011.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_120011", "120011060", "story_v_out_120011.awb")

						arg_245_1:RecordAudio("120011060", var_248_6)
						arg_245_1:RecordAudio("120011060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120011", "120011060", "story_v_out_120011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120011", "120011060", "story_v_out_120011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play120011061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120011061
		arg_249_1.duration_ = 4.47

		local var_249_0 = {
			zh = 1.8,
			ja = 4.466
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
				arg_249_0:Play120011062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.15

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(120011061)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 6 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 6)

				if (6 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 6)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011061", "story_v_out_120011.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011061", "story_v_out_120011.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_120011", "120011061", "story_v_out_120011.awb")

						arg_249_1:RecordAudio("120011061", var_252_6)
						arg_249_1:RecordAudio("120011061", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120011", "120011061", "story_v_out_120011.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120011", "120011061", "story_v_out_120011.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120011062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120011062
		arg_253_1.duration_ = 1.1

		local var_253_0 = {
			zh = 1.066,
			ja = 1.1
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
				arg_253_0:Play120011063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.05

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(120011062)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 2 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 2)

				if (2 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 2)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011062", "story_v_out_120011.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011062", "story_v_out_120011.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_120011", "120011062", "story_v_out_120011.awb")

						arg_253_1:RecordAudio("120011062", var_256_6)
						arg_253_1:RecordAudio("120011062", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_120011", "120011062", "story_v_out_120011.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_120011", "120011062", "story_v_out_120011.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play120011063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120011063
		arg_257_1.duration_ = 5.13

		local var_257_0 = {
			zh = 5.133,
			ja = 2.266
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
				arg_257_0:Play120011064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(120011063)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 18)

				if (18 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 18)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011063", "story_v_out_120011.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011063", "story_v_out_120011.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_120011", "120011063", "story_v_out_120011.awb")

						arg_257_1:RecordAudio("120011063", var_260_6)
						arg_257_1:RecordAudio("120011063", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120011", "120011063", "story_v_out_120011.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120011", "120011063", "story_v_out_120011.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120011064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120011064
		arg_261_1.duration_ = 9

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play120011065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.bgs_.ST45 == nil then
				local var_264_0 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST45")
				var_264_0.name = "ST45"
				var_264_0.transform.parent = arg_261_1.stage_.transform
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_.ST45 = var_264_0
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				local var_264_1 = arg_261_1.bgs_.ST45

				arg_261_1.bgs_.ST45.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_2 = var_264_1:GetComponent("SpriteRenderer")

				if var_264_2 and var_264_2.sprite then
					local var_264_3 = 2 * (var_264_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_1.transform.localScale = Vector3.New(var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "ST45" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_4 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_5 = 2

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_5 then
				local var_264_6 = Color.New(0, 0, 0)

				var_264_6.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_4) / var_264_5)
				arg_261_1.mask_.color = var_264_6
			end

			if arg_261_1.time_ >= var_264_4 + var_264_5 and arg_261_1.time_ < var_264_4 + var_264_5 + arg_264_0 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = 1
				arg_261_1.mask_.color = var_264_7
			end

			local var_264_8 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_9 = 2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 then
				local var_264_10 = Color.New(0, 0, 0)

				var_264_10.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_8) / var_264_9)
				arg_261_1.mask_.color = var_264_10
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				local var_264_11 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_11.a = 0
				arg_261_1.mask_.color = var_264_11
			end

			local var_264_12 = arg_261_1.bgs_.ST45.transform

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				arg_261_1.var_.moveOldPosST45 = var_264_12.localPosition
			end

			local var_264_13 = 0.001

			if 2 <= arg_261_1.time_ and arg_261_1.time_ < 2 + var_264_13 then
				var_264_12.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosST45, Vector3.New(0, 1, 9.5), (arg_261_1.time_ - 2) / var_264_13)
			end

			if arg_261_1.time_ >= 2 + var_264_13 and arg_261_1.time_ < 2 + var_264_13 + arg_264_0 then
				var_264_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_264_14 = arg_261_1.bgs_.ST45.transform

			if 2.01666666666667 < arg_261_1.time_ and arg_261_1.time_ <= 2.01666666666667 + arg_264_0 then
				arg_261_1.var_.moveOldPosST45 = var_264_14.localPosition
			end

			local var_264_15 = 3.5

			if 2.01666666666667 <= arg_261_1.time_ and arg_261_1.time_ < 2.01666666666667 + var_264_15 then
				var_264_14.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosST45, Vector3.New(0, 1, 10), (arg_261_1.time_ - 2.01666666666667) / var_264_15)
			end

			if arg_261_1.time_ >= 2.01666666666667 + var_264_15 and arg_261_1.time_ < 2.01666666666667 + var_264_15 + arg_264_0 then
				var_264_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_264_16 = 3.9

			if 3.9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_16 + 1.61666666666667 and arg_261_1.time_ < var_264_16 + 1.61666666666667 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_17 = 3.999999999999
			local var_264_18 = 0.6

			if 3.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_19 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_19:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_20 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(120011064).content)

				arg_261_1.text_.text = var_264_20

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_22 = 24 <= 0 and var_264_18 or var_264_18 * (utf8.len(var_264_20) / 24)

				if (24 <= 0 and var_264_18 or var_264_18 * (utf8.len(var_264_20) / 24)) > 0 and var_264_18 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22
					var_264_17 = var_264_17 + 0.3

					if var_264_22 + var_264_17 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_17
					end
				end

				arg_261_1.text_.text = var_264_20
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_23 = var_264_17 + 0.3
			local var_264_24 = math.max(var_264_18, arg_261_1.talkMaxDuration)

			if var_264_17 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_24 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_23) / var_264_24

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_23 + var_264_24 and arg_261_1.time_ < var_264_23 + var_264_24 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST45",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST45",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play120011065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 120011065
		arg_267_1.duration_ = 3.97

		local var_267_0 = {
			zh = 3.133,
			ja = 3.966
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
				arg_267_0:Play120011066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.275

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(120011065)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 11 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 11)

				if (11 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 11)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011065", "story_v_out_120011.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011065", "story_v_out_120011.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_120011", "120011065", "story_v_out_120011.awb")

						arg_267_1:RecordAudio("120011065", var_270_6)
						arg_267_1:RecordAudio("120011065", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_120011", "120011065", "story_v_out_120011.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_120011", "120011065", "story_v_out_120011.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play120011066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 120011066
		arg_271_1.duration_ = 8.48

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play120011067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.bgs_.STblack == nil then
				local var_274_0 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_274_0.name = "STblack"
				var_274_0.transform.parent = arg_271_1.stage_.transform
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_.STblack = var_274_0
			end

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= 2 + arg_274_0 then
				local var_274_1 = arg_271_1.bgs_.STblack

				arg_271_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_2 = var_274_1:GetComponent("SpriteRenderer")

				if var_274_2 and var_274_2.sprite then
					local var_274_3 = 2 * (var_274_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_1.transform.localScale = Vector3.New(var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "STblack" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_4 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_5 = 2

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_5 then
				local var_274_6 = Color.New(0, 0, 0)

				var_274_6.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_4) / var_274_5)
				arg_271_1.mask_.color = var_274_6
			end

			if arg_271_1.time_ >= var_274_4 + var_274_5 and arg_271_1.time_ < var_274_4 + var_274_5 + arg_274_0 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = 1
				arg_271_1.mask_.color = var_274_7
			end

			local var_274_8 = 2

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_9 = 2

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 then
				local var_274_10 = Color.New(0, 0, 0)

				var_274_10.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_8) / var_274_9)
				arg_271_1.mask_.color = var_274_10
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 then
				local var_274_11 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_11.a = 0
				arg_271_1.mask_.color = var_274_11
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_274_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_271_1.bgmTxt_.text ~= var_274_14 and arg_271_1.bgmTxt_.text ~= "" then
						if arg_271_1.bgmTxt2_.text ~= "" then
							arg_271_1.bgmTxt_.text = arg_271_1.bgmTxt2_.text
						end

						arg_271_1.bgmTxt2_.text = var_274_14

						arg_271_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_271_1.bgmTxt_.text = var_274_14
						arg_271_1.bgmTxt2_.text = var_274_14
					end

					if arg_271_1.bgmTimer then
						arg_271_1.bgmTimer:Stop()

						arg_271_1.bgmTimer = nil
					end

					if arg_271_1.settingData.show_music_name == 1 then
						arg_271_1.musicController:SetSelectedState("show")
						arg_271_1.musicAnimator_:Play("open", 0, 0)

						if arg_271_1.settingData.music_time ~= 0 then
							arg_271_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_271_1.settingData.music_time), function()
								if arg_271_1 == nil or isNil(arg_271_1.bgmTxt_) then
									return
								end

								arg_271_1.musicController:SetSelectedState("hide")
								arg_271_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_15 = 3.475
			local var_274_16 = 0.525

			if 3.475 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_17 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_17:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_271_1.dialogCg_.alpha = arg_276_0
				end))
				var_274_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(120011066).content)

				arg_271_1.text_.text = var_274_18

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 21 <= 0 and var_274_16 or var_274_16 * (utf8.len(var_274_18) / 21)

				if (21 <= 0 and var_274_16 or var_274_16 * (utf8.len(var_274_18) / 21)) > 0 and var_274_16 < var_274_20 then
					arg_271_1.talkMaxDuration = var_274_20
					var_274_15 = var_274_15 + 0.3

					if var_274_20 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_18
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_21 = var_274_15 + 0.3
			local var_274_22 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_22 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_21) / var_274_22

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_21 + var_274_22 and arg_271_1.time_ < var_274_21 + var_274_22 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play120011067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 120011067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play120011068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 1.375

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(120011067).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 55 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 55)

				if (55 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 55)) > 0 and var_281_0 < var_281_3 then
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
	Play120011068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 120011068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play120011069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.475

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(120011068).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 19 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 19)

				if (19 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 19)) > 0 and var_285_0 < var_285_3 then
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
	Play120011069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 120011069
		arg_286_1.duration_ = 0.33

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"

			SetActive(arg_286_1.choicesGo_, true)

			for iter_287_0, iter_287_1 in ipairs(arg_286_1.choices_) do
				SetActive(iter_287_1.go, iter_287_0 <= 2)
			end

			arg_286_1.choices_[1].txt.text = arg_286_1:FormatText(StoryChoiceCfg[362].name)
			arg_286_1.choices_[2].txt.text = arg_286_1:FormatText(StoryChoiceCfg[363].name)
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play120011070(arg_286_1)
			end

			if arg_288_0 == 2 then
				arg_286_0:Play120011072(arg_286_1)
			end

			arg_286_1:RecordChoiceLog(120011069, 362, 363)
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= 0 + 0.333333333333333 and arg_286_1.time_ < 0 + 0.333333333333333 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play120011070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 120011070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play120011071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.675

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(120011070).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 27 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 27)

				if (27 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 27)) > 0 and var_293_0 < var_293_3 then
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
	Play120011071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 120011071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play120011074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.5

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(120011071).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 20 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 20)

				if (20 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 20)) > 0 and var_297_0 < var_297_3 then
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
	Play120011074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 120011074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play120011075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 1.025

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(120011074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 41 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 41)

				if (41 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 41)) > 0 and var_301_0 < var_301_3 then
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
	Play120011075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 120011075
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play120011076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_305_1 = 0
			local var_305_2 = 0.1

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_3 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(120011075).content)

				arg_302_1.text_.text = var_305_3

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 4 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_3) / 4)

				if (4 <= 0 and var_305_2 or var_305_2 * (utf8.len(var_305_3) / 4)) > 0 and var_305_2 < var_305_5 then
					arg_302_1.talkMaxDuration = var_305_5

					if var_305_5 + var_305_1 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + var_305_1
					end
				end

				arg_302_1.text_.text = var_305_3
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_6 = math.max(var_305_2, arg_302_1.talkMaxDuration)

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_6 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_1) / var_305_6

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_1 + var_305_6 and arg_302_1.time_ < var_305_1 + var_305_6 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play120011076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 120011076
		arg_306_1.duration_ = 1

		local var_306_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play120011077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.075

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:GetWordFromCfg(120011076)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 3 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 3)

				if (3 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 3)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011076", "story_v_out_120011.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011076", "story_v_out_120011.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_120011", "120011076", "story_v_out_120011.awb")

						arg_306_1:RecordAudio("120011076", var_309_6)
						arg_306_1:RecordAudio("120011076", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_120011", "120011076", "story_v_out_120011.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_120011", "120011076", "story_v_out_120011.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play120011077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 120011077
		arg_310_1.duration_ = 7

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play120011078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if arg_310_1.bgs_.ST31 == nil then
				local var_313_0 = Object.Instantiate(arg_310_1.paintGo_)

				var_313_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_313_0.name = "ST31"
				var_313_0.transform.parent = arg_310_1.stage_.transform
				var_313_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_.ST31 = var_313_0
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				local var_313_1 = arg_310_1.bgs_.ST31

				arg_310_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_313_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_2 = var_313_1:GetComponent("SpriteRenderer")

				if var_313_2 and var_313_2.sprite then
					local var_313_3 = 2 * (var_313_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_313_1.transform.localScale = Vector3.New(var_313_3 / var_313_2.sprite.bounds.size.y < var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x and var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x or var_313_3 / var_313_2.sprite.bounds.size.y, var_313_3 / var_313_2.sprite.bounds.size.y < var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x and var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x or var_313_3 / var_313_2.sprite.bounds.size.y, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "ST31" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_4 = 0

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_5 = 2

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_5 then
				local var_313_6 = Color.New(0, 0, 0)

				var_313_6.a = Mathf.Lerp(1, 0, (arg_310_1.time_ - var_313_4) / var_313_5)
				arg_310_1.mask_.color = var_313_6
			end

			if arg_310_1.time_ >= var_313_4 + var_313_5 and arg_310_1.time_ < var_313_4 + var_313_5 + arg_313_0 then
				local var_313_7 = Color.New(0, 0, 0)

				arg_310_1.mask_.enabled = false
				var_313_7.a = 0
				arg_310_1.mask_.color = var_313_7
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_crowd_loop", "")
			end

			local var_313_9 = "ST31_blur"

			if arg_310_1.bgs_.ST31_blur == nil then
				local var_313_10 = Object.Instantiate(arg_310_1.blurPaintGo_)

				var_313_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_313_9)
				var_313_10.name = var_313_9
				var_313_10.transform.parent = arg_310_1.stage_.transform
				var_313_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_[var_313_9] = var_313_10
			end

			local var_313_11 = 0
			local var_313_12 = arg_310_1.bgs_[var_313_9]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_11 + arg_313_0 then
				var_313_12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_313_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_13 = var_313_12:GetComponent("SpriteRenderer")

				if var_313_13 and var_313_13.sprite then
					local var_313_14 = 2 * (var_313_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_313_12.transform.localScale = Vector3.New(var_313_14 / var_313_13.sprite.bounds.size.y < var_313_14 * manager.ui.mainCameraCom_.aspect / var_313_13.sprite.bounds.size.x and var_313_14 * manager.ui.mainCameraCom_.aspect / var_313_13.sprite.bounds.size.x or var_313_14 / var_313_13.sprite.bounds.size.y, var_313_14 / var_313_13.sprite.bounds.size.y < var_313_14 * manager.ui.mainCameraCom_.aspect / var_313_13.sprite.bounds.size.x and var_313_14 * manager.ui.mainCameraCom_.aspect / var_313_13.sprite.bounds.size.x or var_313_14 / var_313_13.sprite.bounds.size.y, 0)
				end
			end

			local var_313_15 = 2

			if var_313_11 <= arg_310_1.time_ and arg_310_1.time_ < var_313_11 + var_313_15 then
				local var_313_16 = Color.New(1, 1, 1)

				var_313_16.a = Mathf.Lerp(0, 1, (arg_310_1.time_ - var_313_11) / var_313_15)

				var_313_12:GetComponent("SpriteRenderer").material:SetColor("_Color", var_313_16)
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_313_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_19 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_19

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_19
						arg_310_1.bgmTxt2_.text = var_313_19
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.517975796759129 < arg_310_1.time_ and arg_310_1.time_ <= 0.517975796759129 + arg_313_0 then
				arg_310_1:AudioAction("play", "music", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_313_22 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

				if "" ~= "" then
					if arg_310_1.bgmTxt_.text ~= var_313_22 and arg_310_1.bgmTxt_.text ~= "" then
						if arg_310_1.bgmTxt2_.text ~= "" then
							arg_310_1.bgmTxt_.text = arg_310_1.bgmTxt2_.text
						end

						arg_310_1.bgmTxt2_.text = var_313_22

						arg_310_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_310_1.bgmTxt_.text = var_313_22
						arg_310_1.bgmTxt2_.text = var_313_22
					end

					if arg_310_1.bgmTimer then
						arg_310_1.bgmTimer:Stop()

						arg_310_1.bgmTimer = nil
					end

					if arg_310_1.settingData.show_music_name == 1 then
						arg_310_1.musicController:SetSelectedState("show")
						arg_310_1.musicAnimator_:Play("open", 0, 0)

						if arg_310_1.settingData.music_time ~= 0 then
							arg_310_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_310_1.settingData.music_time), function()
								if arg_310_1 == nil or isNil(arg_310_1.bgmTxt_) then
									return
								end

								arg_310_1.musicController:SetSelectedState("hide")
								arg_310_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_23 = 2
			local var_313_24 = 1.075

			if 2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_23 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_25 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_25:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_310_1.dialogCg_.alpha = arg_316_0
				end))
				var_313_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_26 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(120011077).content)

				arg_310_1.text_.text = var_313_26

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_28 = 43 <= 0 and var_313_24 or var_313_24 * (utf8.len(var_313_26) / 43)

				if (43 <= 0 and var_313_24 or var_313_24 * (utf8.len(var_313_26) / 43)) > 0 and var_313_24 < var_313_28 then
					arg_310_1.talkMaxDuration = var_313_28
					var_313_23 = var_313_23 + 0.3

					if var_313_28 + var_313_23 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_28 + var_313_23
					end
				end

				arg_310_1.text_.text = var_313_26
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_29 = var_313_23 + 0.3
			local var_313_30 = math.max(var_313_24, arg_310_1.talkMaxDuration)

			if var_313_23 + 0.3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_29 + var_313_30 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_29) / var_313_30

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_29 + var_313_30 and arg_310_1.time_ < var_313_29 + var_313_30 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play120011078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 120011078
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play120011079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.55

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(120011078).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 61 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 61)

				if (61 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 61)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play120011079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 120011079
		arg_322_1.duration_ = 3.5

		local var_322_0 = {
			zh = 3,
			ja = 3.5
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play120011080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if arg_322_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_325_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_322_1.stage_.transform)

				var_325_0.name = "1084ui_story"
				var_325_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.actors_["1084ui_story"] = var_325_0

				local var_325_1 = var_325_0:GetComponentInChildren(typeof(CharacterEffect))

				var_325_1.enabled = true

				local var_325_2 = GameObjectTools.GetOrAddComponent(var_325_0, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(false)
				end

				arg_322_1:ShowWeapon(var_325_1.transform, false)

				arg_322_1.var_["1084ui_story" .. "Animator"] = var_325_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_322_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_322_1.var_["1084ui_story" .. "LipSync"] = var_325_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_325_3 = arg_322_1.actors_["1084ui_story"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1084ui_story = var_325_3.localPosition
			end

			local var_325_4 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				var_325_3.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_322_1.time_ - 0) / var_325_4)
				var_325_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_3.position).x, (manager.ui.mainCamera.transform.position - var_325_3.position).y, (manager.ui.mainCamera.transform.position - var_325_3.position).z)
				var_325_3.localEulerAngles.z = 0
				var_325_3.localEulerAngles.x = 0
				var_325_3.localEulerAngles = var_325_3.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				var_325_3.localPosition = Vector3.New(0, -0.97, -6)
				var_325_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_3.position).x, (manager.ui.mainCamera.transform.position - var_325_3.position).y, (manager.ui.mainCamera.transform.position - var_325_3.position).z)
				var_325_3.localEulerAngles.z = 0
				var_325_3.localEulerAngles.x = 0
				var_325_3.localEulerAngles = var_325_3.localEulerAngles
			end

			local var_325_5 = arg_322_1.actors_["1084ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_5) and arg_322_1.var_.characterEffect1084ui_story == nil then
				arg_322_1.var_.characterEffect1084ui_story = var_325_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_6 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_6 and not isNil(var_325_5) then
				if arg_322_1.var_.characterEffect1084ui_story and not isNil(var_325_5) then
					arg_322_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_6 and arg_322_1.time_ < 0 + var_325_6 + arg_325_0 and not isNil(var_325_5) and arg_322_1.var_.characterEffect1084ui_story then
				arg_322_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_325_8 = "ST31_blur"

			if arg_322_1.bgs_.ST31_blur == nil then
				local var_325_9 = Object.Instantiate(arg_322_1.blurPaintGo_)

				var_325_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_325_8)
				var_325_9.name = var_325_8
				var_325_9.transform.parent = arg_322_1.stage_.transform
				var_325_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.bgs_[var_325_8] = var_325_9
			end

			local var_325_10 = 0
			local var_325_11 = arg_322_1.bgs_[var_325_8]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_10 + arg_325_0 then
				var_325_11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_325_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_12 = var_325_11:GetComponent("SpriteRenderer")

				if var_325_12 and var_325_12.sprite then
					local var_325_13 = 2 * (var_325_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_325_11.transform.localScale = Vector3.New(var_325_13 / var_325_12.sprite.bounds.size.y < var_325_13 * manager.ui.mainCameraCom_.aspect / var_325_12.sprite.bounds.size.x and var_325_13 * manager.ui.mainCameraCom_.aspect / var_325_12.sprite.bounds.size.x or var_325_13 / var_325_12.sprite.bounds.size.y, var_325_13 / var_325_12.sprite.bounds.size.y < var_325_13 * manager.ui.mainCameraCom_.aspect / var_325_12.sprite.bounds.size.x and var_325_13 * manager.ui.mainCameraCom_.aspect / var_325_12.sprite.bounds.size.x or var_325_13 / var_325_12.sprite.bounds.size.y, 0)
				end
			end

			local var_325_14 = 2

			if var_325_10 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_14 then
				local var_325_15 = Color.New(1, 1, 1)

				var_325_15.a = Mathf.Lerp(1, 0, (arg_322_1.time_ - var_325_10) / var_325_14)

				var_325_11:GetComponent("SpriteRenderer").material:SetColor("_Color", var_325_15)
			end

			local var_325_16 = 0
			local var_325_17 = 0.325

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_18 = arg_322_1:GetWordFromCfg(120011079)
				local var_325_19 = arg_322_1:FormatText(var_325_18.content)

				arg_322_1.text_.text = var_325_19

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_21 = 13 <= 0 and var_325_17 or var_325_17 * (utf8.len(var_325_19) / 13)

				if (13 <= 0 and var_325_17 or var_325_17 * (utf8.len(var_325_19) / 13)) > 0 and var_325_17 < var_325_21 then
					arg_322_1.talkMaxDuration = var_325_21

					if var_325_21 + var_325_16 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_21 + var_325_16
					end
				end

				arg_322_1.text_.text = var_325_19
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011079", "story_v_out_120011.awb") ~= 0 then
					local var_325_22 = manager.audio:GetVoiceLength("story_v_out_120011", "120011079", "story_v_out_120011.awb") / 1000

					if var_325_22 + var_325_16 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_22 + var_325_16
					end

					if var_325_18.prefab_name ~= "" and arg_322_1.actors_[var_325_18.prefab_name] ~= nil then
						local var_325_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_18.prefab_name].transform, "story_v_out_120011", "120011079", "story_v_out_120011.awb")

						arg_322_1:RecordAudio("120011079", var_325_23)
						arg_322_1:RecordAudio("120011079", var_325_23)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_120011", "120011079", "story_v_out_120011.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_120011", "120011079", "story_v_out_120011.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_24 = math.max(var_325_17, arg_322_1.talkMaxDuration)

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_24 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_16) / var_325_24

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_16 + var_325_24 and arg_322_1.time_ < var_325_16 + var_325_24 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play120011080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 120011080
		arg_326_1.duration_ = 8.45

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play120011081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_0 = 2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				local var_329_1 = Color.New(0, 0, 0)

				var_329_1.a = Mathf.Lerp(0, 1, (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.mask_.color = var_329_1
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				local var_329_2 = Color.New(0, 0, 0)

				var_329_2.a = 1
				arg_326_1.mask_.color = var_329_2
			end

			local var_329_3 = 2

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_4 = 2

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_4 then
				local var_329_5 = Color.New(0, 0, 0)

				var_329_5.a = Mathf.Lerp(1, 0, (arg_326_1.time_ - var_329_3) / var_329_4)
				arg_326_1.mask_.color = var_329_5
			end

			if arg_326_1.time_ >= var_329_3 + var_329_4 and arg_326_1.time_ < var_329_3 + var_329_4 + arg_329_0 then
				local var_329_6 = Color.New(0, 0, 0)

				arg_326_1.mask_.enabled = false
				var_329_6.a = 0
				arg_326_1.mask_.color = var_329_6
			end

			local var_329_7 = arg_326_1.actors_["1084ui_story"].transform

			if 2 < arg_326_1.time_ and arg_326_1.time_ <= 2 + arg_329_0 then
				arg_326_1.var_.moveOldPos1084ui_story = var_329_7.localPosition
			end

			local var_329_8 = 0.001

			if 2 <= arg_326_1.time_ and arg_326_1.time_ < 2 + var_329_8 then
				var_329_7.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 2) / var_329_8)
				var_329_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_7.position).x, (manager.ui.mainCamera.transform.position - var_329_7.position).y, (manager.ui.mainCamera.transform.position - var_329_7.position).z)
				var_329_7.localEulerAngles.z = 0
				var_329_7.localEulerAngles.x = 0
				var_329_7.localEulerAngles = var_329_7.localEulerAngles
			end

			if arg_326_1.time_ >= 2 + var_329_8 and arg_326_1.time_ < 2 + var_329_8 + arg_329_0 then
				var_329_7.localPosition = Vector3.New(0, 100, 0)
				var_329_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_7.position).x, (manager.ui.mainCamera.transform.position - var_329_7.position).y, (manager.ui.mainCamera.transform.position - var_329_7.position).z)
				var_329_7.localEulerAngles.z = 0
				var_329_7.localEulerAngles.x = 0
				var_329_7.localEulerAngles = var_329_7.localEulerAngles
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_9 = 3.45
			local var_329_10 = 1.45

			if 3.45 < arg_326_1.time_ and arg_326_1.time_ <= var_329_9 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_11 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_11:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_12 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(120011080).content)

				arg_326_1.text_.text = var_329_12

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_14 = 42 <= 0 and var_329_10 or var_329_10 * (utf8.len(var_329_12) / 42)

				if (42 <= 0 and var_329_10 or var_329_10 * (utf8.len(var_329_12) / 42)) > 0 and var_329_10 < var_329_14 then
					arg_326_1.talkMaxDuration = var_329_14
					var_329_9 = var_329_9 + 0.3

					if var_329_14 + var_329_9 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_14 + var_329_9
					end
				end

				arg_326_1.text_.text = var_329_12
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_15 = var_329_9 + 0.3
			local var_329_16 = math.max(var_329_10, arg_326_1.talkMaxDuration)

			if var_329_9 + 0.3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_15 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_15) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_15 + var_329_16 and arg_326_1.time_ < var_329_15 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play120011081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 120011081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play120011082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.375

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(120011081).content)

				arg_332_1.text_.text = var_335_1

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_3 = 15 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 15)

				if (15 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_1) / 15)) > 0 and var_335_0 < var_335_3 then
					arg_332_1.talkMaxDuration = var_335_3

					if var_335_3 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_3 + 0
					end
				end

				arg_332_1.text_.text = var_335_1
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_4 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_4

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play120011082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 120011082
		arg_336_1.duration_ = 3.03

		local var_336_0 = {
			zh = 3.033,
			ja = 2.6
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
				arg_336_0:Play120011083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1084ui_story = arg_336_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).z)
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles = arg_336_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_336_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).z)
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles = arg_336_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_339_1 = arg_336_1.actors_["1084ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1084ui_story == nil then
				arg_336_1.var_.characterEffect1084ui_story = var_339_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_2 and not isNil(var_339_1) then
				if arg_336_1.var_.characterEffect1084ui_story and not isNil(var_339_1) then
					arg_336_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_2 and arg_336_1.time_ < 0 + var_339_2 + arg_339_0 and not isNil(var_339_1) and arg_336_1.var_.characterEffect1084ui_story then
				arg_336_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_339_4 = 0
			local var_339_5 = 0.275

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_6 = arg_336_1:GetWordFromCfg(120011082)
				local var_339_7 = arg_336_1:FormatText(var_339_6.content)

				arg_336_1.text_.text = var_339_7

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_9 = 11 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 11)

				if (11 <= 0 and var_339_5 or var_339_5 * (utf8.len(var_339_7) / 11)) > 0 and var_339_5 < var_339_9 then
					arg_336_1.talkMaxDuration = var_339_9

					if var_339_9 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_9 + var_339_4
					end
				end

				arg_336_1.text_.text = var_339_7
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011082", "story_v_out_120011.awb") ~= 0 then
					local var_339_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011082", "story_v_out_120011.awb") / 1000

					if var_339_10 + var_339_4 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_10 + var_339_4
					end

					if var_339_6.prefab_name ~= "" and arg_336_1.actors_[var_339_6.prefab_name] ~= nil then
						local var_339_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_6.prefab_name].transform, "story_v_out_120011", "120011082", "story_v_out_120011.awb")

						arg_336_1:RecordAudio("120011082", var_339_11)
						arg_336_1:RecordAudio("120011082", var_339_11)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_120011", "120011082", "story_v_out_120011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_120011", "120011082", "story_v_out_120011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_5, arg_336_1.talkMaxDuration)

			if var_339_4 <= arg_336_1.time_ and arg_336_1.time_ < var_339_4 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_4) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_4 + var_339_12 and arg_336_1.time_ < var_339_4 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play120011083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 120011083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play120011084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1084ui_story = arg_340_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).z)
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles = arg_340_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1084ui_story"].transform.position).z)
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1084ui_story"].transform.localEulerAngles = arg_340_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_343_1 = 0
			local var_343_2 = 1.625

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(120011083).content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 65 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 65)

				if (65 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_3) / 65)) > 0 and var_343_2 < var_343_5 then
					arg_340_1.talkMaxDuration = var_343_5

					if var_343_5 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_6 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_6 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_6

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_6 and arg_340_1.time_ < var_343_1 + var_343_6 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play120011084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 120011084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play120011085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.975

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_1 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(120011084).content)

				arg_344_1.text_.text = var_347_1

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_3 = 39 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 39)

				if (39 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_1) / 39)) > 0 and var_347_0 < var_347_3 then
					arg_344_1.talkMaxDuration = var_347_3

					if var_347_3 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_3 + 0
					end
				end

				arg_344_1.text_.text = var_347_1
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_4 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_4

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play120011085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 120011085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play120011086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.325

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(120011085).content)

				arg_348_1.text_.text = var_351_1

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_3 = 13 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 13)

				if (13 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 13)) > 0 and var_351_0 < var_351_3 then
					arg_348_1.talkMaxDuration = var_351_3

					if var_351_3 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_3 + 0
					end
				end

				arg_348_1.text_.text = var_351_1
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_4 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_4

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play120011086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 120011086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play120011087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.225

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(120011086).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 9 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 9)

				if (9 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 9)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play120011087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 120011087
		arg_356_1.duration_ = 7.2

		local var_356_0 = {
			zh = 4,
			ja = 7.2
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
				arg_356_0:Play120011088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.425

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:GetWordFromCfg(120011087)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 17 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 17)

				if (17 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 17)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011087", "story_v_out_120011.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011087", "story_v_out_120011.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_120011", "120011087", "story_v_out_120011.awb")

						arg_356_1:RecordAudio("120011087", var_359_6)
						arg_356_1:RecordAudio("120011087", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_120011", "120011087", "story_v_out_120011.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_120011", "120011087", "story_v_out_120011.awb")
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
	Play120011088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 120011088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play120011089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.475

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(120011088).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 19)

				if (19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 19)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play120011089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 120011089
		arg_364_1.duration_ = 4.03

		local var_364_0 = {
			zh = 3.633,
			ja = 4.033
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play120011090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1084ui_story = arg_364_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).z)
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles = arg_364_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_364_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1084ui_story"].transform.position).z)
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1084ui_story"].transform.localEulerAngles = arg_364_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_367_1 = arg_364_1.actors_["1084ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_1) and arg_364_1.var_.characterEffect1084ui_story == nil then
				arg_364_1.var_.characterEffect1084ui_story = var_367_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_2 and not isNil(var_367_1) then
				if arg_364_1.var_.characterEffect1084ui_story and not isNil(var_367_1) then
					arg_364_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_2 and arg_364_1.time_ < 0 + var_367_2 + arg_367_0 and not isNil(var_367_1) and arg_364_1.var_.characterEffect1084ui_story then
				arg_364_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_367_4 = 0
			local var_367_5 = 0.45

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_6 = arg_364_1:GetWordFromCfg(120011089)
				local var_367_7 = arg_364_1:FormatText(var_367_6.content)

				arg_364_1.text_.text = var_367_7

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_9 = 18 <= 0 and var_367_5 or var_367_5 * (utf8.len(var_367_7) / 18)

				if (18 <= 0 and var_367_5 or var_367_5 * (utf8.len(var_367_7) / 18)) > 0 and var_367_5 < var_367_9 then
					arg_364_1.talkMaxDuration = var_367_9

					if var_367_9 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_9 + var_367_4
					end
				end

				arg_364_1.text_.text = var_367_7
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011089", "story_v_out_120011.awb") ~= 0 then
					local var_367_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011089", "story_v_out_120011.awb") / 1000

					if var_367_10 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_10 + var_367_4
					end

					if var_367_6.prefab_name ~= "" and arg_364_1.actors_[var_367_6.prefab_name] ~= nil then
						local var_367_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_6.prefab_name].transform, "story_v_out_120011", "120011089", "story_v_out_120011.awb")

						arg_364_1:RecordAudio("120011089", var_367_11)
						arg_364_1:RecordAudio("120011089", var_367_11)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_120011", "120011089", "story_v_out_120011.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_120011", "120011089", "story_v_out_120011.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_12 = math.max(var_367_5, arg_364_1.talkMaxDuration)

			if var_367_4 <= arg_364_1.time_ and arg_364_1.time_ < var_367_4 + var_367_12 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_4) / var_367_12

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_4 + var_367_12 and arg_364_1.time_ < var_367_4 + var_367_12 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play120011090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 120011090
		arg_368_1.duration_ = 7.2

		local var_368_0 = {
			zh = 5.833,
			ja = 7.2
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
				arg_368_0:Play120011091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1084ui_story = arg_368_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).z)
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles = arg_368_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_368_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1084ui_story"].transform.position).z)
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1084ui_story"].transform.localEulerAngles = arg_368_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_371_1 = 0
			local var_371_2 = 0.575

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
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

				local var_371_3 = arg_368_1:GetWordFromCfg(120011090)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_4) / 23)

				if (23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_4) / 23)) > 0 and var_371_2 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011090", "story_v_out_120011.awb") ~= 0 then
					local var_371_7 = manager.audio:GetVoiceLength("story_v_out_120011", "120011090", "story_v_out_120011.awb") / 1000

					if var_371_7 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_1
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_120011", "120011090", "story_v_out_120011.awb")

						arg_368_1:RecordAudio("120011090", var_371_8)
						arg_368_1:RecordAudio("120011090", var_371_8)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_120011", "120011090", "story_v_out_120011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_120011", "120011090", "story_v_out_120011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_9 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_9 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_9

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_9 and arg_368_1.time_ < var_371_1 + var_371_9 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play120011091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 120011091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play120011092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1084ui_story"]) and arg_372_1.var_.characterEffect1084ui_story == nil then
				arg_372_1.var_.characterEffect1084ui_story = arg_372_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1084ui_story"]) then
				if arg_372_1.var_.characterEffect1084ui_story and not isNil(arg_372_1.actors_["1084ui_story"]) then
					arg_372_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1084ui_story"]) and arg_372_1.var_.characterEffect1084ui_story then
				arg_372_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.775

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
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

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(120011091).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 31 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 31)

				if (31 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 31)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play120011092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 120011092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play120011093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1084ui_story = arg_376_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).z)
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles = arg_376_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_376_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1084ui_story"].transform.position).z)
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1084ui_story"].transform.localEulerAngles = arg_376_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_379_1 = 0
			local var_379_2 = 1.425

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(120011092).content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 57 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 57)

				if (57 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 57)) > 0 and var_379_2 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_6 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_6 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_6

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_6 and arg_376_1.time_ < var_379_1 + var_379_6 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play120011093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 120011093
		arg_380_1.duration_ = 6.9

		local var_380_0 = {
			zh = 5.366,
			ja = 6.9
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
				arg_380_0:Play120011094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1084ui_story = arg_380_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).z)
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles = arg_380_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_380_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1084ui_story"].transform.position).z)
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1084ui_story"].transform.localEulerAngles = arg_380_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_383_1 = arg_380_1.actors_["1084ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1084ui_story == nil then
				arg_380_1.var_.characterEffect1084ui_story = var_383_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_2 and not isNil(var_383_1) then
				if arg_380_1.var_.characterEffect1084ui_story and not isNil(var_383_1) then
					arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_2 and arg_380_1.time_ < 0 + var_383_2 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1084ui_story then
				arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_383_4 = 0
			local var_383_5 = 0.65

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_6 = arg_380_1:GetWordFromCfg(120011093)
				local var_383_7 = arg_380_1:FormatText(var_383_6.content)

				arg_380_1.text_.text = var_383_7

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_9 = 26 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 26)

				if (26 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 26)) > 0 and var_383_5 < var_383_9 then
					arg_380_1.talkMaxDuration = var_383_9

					if var_383_9 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_7
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011093", "story_v_out_120011.awb") ~= 0 then
					local var_383_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011093", "story_v_out_120011.awb") / 1000

					if var_383_10 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_4
					end

					if var_383_6.prefab_name ~= "" and arg_380_1.actors_[var_383_6.prefab_name] ~= nil then
						local var_383_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_6.prefab_name].transform, "story_v_out_120011", "120011093", "story_v_out_120011.awb")

						arg_380_1:RecordAudio("120011093", var_383_11)
						arg_380_1:RecordAudio("120011093", var_383_11)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_120011", "120011093", "story_v_out_120011.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_120011", "120011093", "story_v_out_120011.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_12 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_12 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_12

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_12 and arg_380_1.time_ < var_383_4 + var_383_12 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play120011094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 120011094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play120011095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1084ui_story"]) and arg_384_1.var_.characterEffect1084ui_story == nil then
				arg_384_1.var_.characterEffect1084ui_story = arg_384_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1084ui_story"]) then
				if arg_384_1.var_.characterEffect1084ui_story and not isNil(arg_384_1.actors_["1084ui_story"]) then
					arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_0)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1084ui_story"]) and arg_384_1.var_.characterEffect1084ui_story then
				arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_387_1 = 0
			local var_387_2 = 0.8

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(120011094).content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 32 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 32)

				if (32 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 32)) > 0 and var_387_2 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_6 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_6 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_6

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_6 and arg_384_1.time_ < var_387_1 + var_387_6 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play120011095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 120011095
		arg_388_1.duration_ = 10.23

		local var_388_0 = {
			zh = 10.233,
			ja = 9.7
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play120011096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1084ui_story"]) and arg_388_1.var_.characterEffect1084ui_story == nil then
				arg_388_1.var_.characterEffect1084ui_story = arg_388_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1084ui_story"]) then
				if arg_388_1.var_.characterEffect1084ui_story and not isNil(arg_388_1.actors_["1084ui_story"]) then
					arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1084ui_story"]) and arg_388_1.var_.characterEffect1084ui_story then
				arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_391_2 = 0
			local var_391_3 = 1.05

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_2 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_4 = arg_388_1:GetWordFromCfg(120011095)
				local var_391_5 = arg_388_1:FormatText(var_391_4.content)

				arg_388_1.text_.text = var_391_5

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_7 = 42 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_5) / 42)

				if (42 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_5) / 42)) > 0 and var_391_3 < var_391_7 then
					arg_388_1.talkMaxDuration = var_391_7

					if var_391_7 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_2
					end
				end

				arg_388_1.text_.text = var_391_5
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011095", "story_v_out_120011.awb") ~= 0 then
					local var_391_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011095", "story_v_out_120011.awb") / 1000

					if var_391_8 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_8 + var_391_2
					end

					if var_391_4.prefab_name ~= "" and arg_388_1.actors_[var_391_4.prefab_name] ~= nil then
						local var_391_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_4.prefab_name].transform, "story_v_out_120011", "120011095", "story_v_out_120011.awb")

						arg_388_1:RecordAudio("120011095", var_391_9)
						arg_388_1:RecordAudio("120011095", var_391_9)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_120011", "120011095", "story_v_out_120011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_120011", "120011095", "story_v_out_120011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_3, arg_388_1.talkMaxDuration)

			if var_391_2 <= arg_388_1.time_ and arg_388_1.time_ < var_391_2 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_2) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_2 + var_391_10 and arg_388_1.time_ < var_391_2 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play120011096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 120011096
		arg_392_1.duration_ = 10.57

		local var_392_0 = {
			zh = 7,
			ja = 10.566
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
				arg_392_0:Play120011097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1084ui_story = arg_392_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).z)
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles = arg_392_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_392_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1084ui_story"].transform.position).z)
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1084ui_story"].transform.localEulerAngles = arg_392_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action467")
			end

			local var_395_1 = 0
			local var_395_2 = 0.7

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
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

				local var_395_3 = arg_392_1:GetWordFromCfg(120011096)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_6 = 28 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 28)

				if (28 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 28)) > 0 and var_395_2 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011096", "story_v_out_120011.awb") ~= 0 then
					local var_395_7 = manager.audio:GetVoiceLength("story_v_out_120011", "120011096", "story_v_out_120011.awb") / 1000

					if var_395_7 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_1
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_120011", "120011096", "story_v_out_120011.awb")

						arg_392_1:RecordAudio("120011096", var_395_8)
						arg_392_1:RecordAudio("120011096", var_395_8)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_120011", "120011096", "story_v_out_120011.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_120011", "120011096", "story_v_out_120011.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_9 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_9 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_9

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_9 and arg_392_1.time_ < var_395_1 + var_395_9 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play120011097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 120011097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play120011098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1084ui_story"]) and arg_396_1.var_.characterEffect1084ui_story == nil then
				arg_396_1.var_.characterEffect1084ui_story = arg_396_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1084ui_story"]) then
				if arg_396_1.var_.characterEffect1084ui_story and not isNil(arg_396_1.actors_["1084ui_story"]) then
					arg_396_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1084ui_story"]) and arg_396_1.var_.characterEffect1084ui_story then
				arg_396_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_399_1 = 0
			local var_399_2 = 0.5

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(120011097).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 20 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 20)

				if (20 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 20)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play120011098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 120011098
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play120011099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.925

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(120011098).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 37 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 37)

				if (37 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 37)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play120011099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 120011099
		arg_404_1.duration_ = 9.73

		local var_404_0 = {
			zh = 3.7,
			ja = 9.733
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play120011100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1084ui_story = arg_404_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).z)
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles = arg_404_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_404_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1084ui_story"].transform.position).z)
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1084ui_story"].transform.localEulerAngles = arg_404_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1084ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1084ui_story == nil then
				arg_404_1.var_.characterEffect1084ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1084ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1084ui_story then
				arg_404_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action472")
			end

			local var_407_4 = 0
			local var_407_5 = 0.4

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(120011099)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 16 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 16)

				if (16 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 16)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011099", "story_v_out_120011.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011099", "story_v_out_120011.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_out_120011", "120011099", "story_v_out_120011.awb")

						arg_404_1:RecordAudio("120011099", var_407_11)
						arg_404_1:RecordAudio("120011099", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_120011", "120011099", "story_v_out_120011.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_120011", "120011099", "story_v_out_120011.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_12 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_12 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_12

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_12 and arg_404_1.time_ < var_407_4 + var_407_12 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play120011100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 120011100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play120011101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1084ui_story"]) and arg_408_1.var_.characterEffect1084ui_story == nil then
				arg_408_1.var_.characterEffect1084ui_story = arg_408_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1084ui_story"]) then
				if arg_408_1.var_.characterEffect1084ui_story and not isNil(arg_408_1.actors_["1084ui_story"]) then
					arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1084ui_story"]) and arg_408_1.var_.characterEffect1084ui_story then
				arg_408_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_411_1 = 0
			local var_411_2 = 0.25

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(120011100).content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 10 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 10)

				if (10 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 10)) > 0 and var_411_2 < var_411_5 then
					arg_408_1.talkMaxDuration = var_411_5

					if var_411_5 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_6 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_6 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_6

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_6 and arg_408_1.time_ < var_411_1 + var_411_6 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play120011101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 120011101
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play120011102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1084ui_story = arg_412_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).z)
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles = arg_412_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_412_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1084ui_story"].transform.position).z)
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1084ui_story"].transform.localEulerAngles = arg_412_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_415_1 = 0
			local var_415_2 = 0.875

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_3 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(120011101).content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 35 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_3) / 35)

				if (35 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_3) / 35)) > 0 and var_415_2 < var_415_5 then
					arg_412_1.talkMaxDuration = var_415_5

					if var_415_5 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + var_415_1
					end
				end

				arg_412_1.text_.text = var_415_3
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_6 = math.max(var_415_2, arg_412_1.talkMaxDuration)

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_6 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_1) / var_415_6

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_1 + var_415_6 and arg_412_1.time_ < var_415_1 + var_415_6 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play120011102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 120011102
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play120011103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 1.1

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(120011102).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 44 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 44)

				if (44 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 44)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play120011103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 120011103
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play120011104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if arg_420_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_423_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_420_1.stage_.transform)

				var_423_0.name = "1071ui_story"
				var_423_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.actors_["1071ui_story"] = var_423_0

				local var_423_1 = var_423_0:GetComponentInChildren(typeof(CharacterEffect))

				var_423_1.enabled = true

				local var_423_2 = GameObjectTools.GetOrAddComponent(var_423_0, typeof(DynamicBoneHelper))

				if var_423_2 then
					var_423_2:EnableDynamicBone(false)
				end

				arg_420_1:ShowWeapon(var_423_1.transform, false)

				arg_420_1.var_["1071ui_story" .. "Animator"] = var_423_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_420_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_420_1.var_["1071ui_story" .. "LipSync"] = var_423_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_423_3 = 0
			local var_423_4 = 0.75

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_3 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_5 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(120011103).content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 30 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 30)

				if (30 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 30)) > 0 and var_423_4 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_3
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_8 = math.max(var_423_4, arg_420_1.talkMaxDuration)

			if var_423_3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_3 + var_423_8 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_3) / var_423_8

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_3 + var_423_8 and arg_420_1.time_ < var_423_3 + var_423_8 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play120011104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 120011104
		arg_424_1.duration_ = 2.73

		local var_424_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play120011105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1084ui_story = arg_424_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).z)
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles = arg_424_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_424_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1084ui_story"].transform.position).z)
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1084ui_story"].transform.localEulerAngles = arg_424_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1071ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1071ui_story = var_427_1.localPosition
			end

			local var_427_2 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 then
				var_427_1.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_424_1.time_ - 0) / var_427_2)
				var_427_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_1.position).x, (manager.ui.mainCamera.transform.position - var_427_1.position).y, (manager.ui.mainCamera.transform.position - var_427_1.position).z)
				var_427_1.localEulerAngles.z = 0
				var_427_1.localEulerAngles.x = 0
				var_427_1.localEulerAngles = var_427_1.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 then
				var_427_1.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_427_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_1.position).x, (manager.ui.mainCamera.transform.position - var_427_1.position).y, (manager.ui.mainCamera.transform.position - var_427_1.position).z)
				var_427_1.localEulerAngles.z = 0
				var_427_1.localEulerAngles.x = 0
				var_427_1.localEulerAngles = var_427_1.localEulerAngles
			end

			local var_427_3 = arg_424_1.actors_["1084ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_3) and arg_424_1.var_.characterEffect1084ui_story == nil then
				arg_424_1.var_.characterEffect1084ui_story = var_427_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_4 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 and not isNil(var_427_3) then
				if arg_424_1.var_.characterEffect1084ui_story and not isNil(var_427_3) then
					arg_424_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 and not isNil(var_427_3) and arg_424_1.var_.characterEffect1084ui_story then
				arg_424_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_427_6 = arg_424_1.actors_["1071ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1071ui_story == nil then
				arg_424_1.var_.characterEffect1071ui_story = var_427_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_7 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 and not isNil(var_427_6) then
				if arg_424_1.var_.characterEffect1071ui_story and not isNil(var_427_6) then
					arg_424_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_7)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 and not isNil(var_427_6) and arg_424_1.var_.characterEffect1071ui_story then
				arg_424_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_427_8 = 0
			local var_427_9 = 0.225

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_10 = arg_424_1:GetWordFromCfg(120011104)
				local var_427_11 = arg_424_1:FormatText(var_427_10.content)

				arg_424_1.text_.text = var_427_11

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_13 = 9 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 9)

				if (9 <= 0 and var_427_9 or var_427_9 * (utf8.len(var_427_11) / 9)) > 0 and var_427_9 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_8
					end
				end

				arg_424_1.text_.text = var_427_11
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011104", "story_v_out_120011.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_120011", "120011104", "story_v_out_120011.awb") / 1000

					if var_427_14 + var_427_8 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_8
					end

					if var_427_10.prefab_name ~= "" and arg_424_1.actors_[var_427_10.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_10.prefab_name].transform, "story_v_out_120011", "120011104", "story_v_out_120011.awb")

						arg_424_1:RecordAudio("120011104", var_427_15)
						arg_424_1:RecordAudio("120011104", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_120011", "120011104", "story_v_out_120011.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_120011", "120011104", "story_v_out_120011.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_9, arg_424_1.talkMaxDuration)

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_8) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_8 + var_427_16 and arg_424_1.time_ < var_427_8 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play120011105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 120011105
		arg_428_1.duration_ = 7.1

		local var_428_0 = {
			zh = 4.766,
			ja = 7.1
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play120011106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1084ui_story"]) and arg_428_1.var_.characterEffect1084ui_story == nil then
				arg_428_1.var_.characterEffect1084ui_story = arg_428_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1084ui_story"]) then
				if arg_428_1.var_.characterEffect1084ui_story and not isNil(arg_428_1.actors_["1084ui_story"]) then
					arg_428_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_0)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1084ui_story"]) and arg_428_1.var_.characterEffect1084ui_story then
				arg_428_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_431_1 = arg_428_1.actors_["1071ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1071ui_story == nil then
				arg_428_1.var_.characterEffect1071ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.2

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect1071ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1071ui_story then
				arg_428_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_431_4 = 0
			local var_431_5 = 0.625

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:GetWordFromCfg(120011105)
				local var_431_7 = arg_428_1:FormatText(var_431_6.content)

				arg_428_1.text_.text = var_431_7

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_9 = 25 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 25)

				if (25 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 25)) > 0 and var_431_5 < var_431_9 then
					arg_428_1.talkMaxDuration = var_431_9

					if var_431_9 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_9 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_7
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011105", "story_v_out_120011.awb") ~= 0 then
					local var_431_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011105", "story_v_out_120011.awb") / 1000

					if var_431_10 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_4
					end

					if var_431_6.prefab_name ~= "" and arg_428_1.actors_[var_431_6.prefab_name] ~= nil then
						local var_431_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_6.prefab_name].transform, "story_v_out_120011", "120011105", "story_v_out_120011.awb")

						arg_428_1:RecordAudio("120011105", var_431_11)
						arg_428_1:RecordAudio("120011105", var_431_11)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_120011", "120011105", "story_v_out_120011.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_120011", "120011105", "story_v_out_120011.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_12 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_12 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_12

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_12 and arg_428_1.time_ < var_431_4 + var_431_12 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play120011106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 120011106
		arg_432_1.duration_ = 3.77

		local var_432_0 = {
			zh = 3.766,
			ja = 3.4
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play120011107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos1071ui_story = arg_432_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_435_0 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 then
				arg_432_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_432_1.time_ - 0) / var_435_0)
				arg_432_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).z)
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles = arg_432_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 then
				arg_432_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_432_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_432_1.actors_["1071ui_story"].transform.position).z)
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_432_1.actors_["1071ui_story"].transform.localEulerAngles = arg_432_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_435_1 = 0
			local var_435_2 = 0.45

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:GetWordFromCfg(120011106)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_6 = 18 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_4) / 18)

				if (18 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_4) / 18)) > 0 and var_435_2 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011106", "story_v_out_120011.awb") ~= 0 then
					local var_435_7 = manager.audio:GetVoiceLength("story_v_out_120011", "120011106", "story_v_out_120011.awb") / 1000

					if var_435_7 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_1
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_out_120011", "120011106", "story_v_out_120011.awb")

						arg_432_1:RecordAudio("120011106", var_435_8)
						arg_432_1:RecordAudio("120011106", var_435_8)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_120011", "120011106", "story_v_out_120011.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_120011", "120011106", "story_v_out_120011.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_9 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_9 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_9

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_9 and arg_432_1.time_ < var_435_1 + var_435_9 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play120011107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 120011107
		arg_436_1.duration_ = 4.07

		local var_436_0 = {
			zh = 2.533,
			ja = 4.066
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play120011108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1084ui_story"]) and arg_436_1.var_.characterEffect1084ui_story == nil then
				arg_436_1.var_.characterEffect1084ui_story = arg_436_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1084ui_story"]) then
				if arg_436_1.var_.characterEffect1084ui_story and not isNil(arg_436_1.actors_["1084ui_story"]) then
					arg_436_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1084ui_story"]) and arg_436_1.var_.characterEffect1084ui_story then
				arg_436_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_439_2 = arg_436_1.actors_["1071ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.characterEffect1071ui_story == nil then
				arg_436_1.var_.characterEffect1071ui_story = var_439_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_3 = 0.2

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_3 and not isNil(var_439_2) then
				if arg_436_1.var_.characterEffect1071ui_story and not isNil(var_439_2) then
					arg_436_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_3)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_3 and arg_436_1.time_ < 0 + var_439_3 + arg_439_0 and not isNil(var_439_2) and arg_436_1.var_.characterEffect1071ui_story then
				arg_436_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_439_4 = 0
			local var_439_5 = 0.25

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(120011107)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 10 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 10)

				if (10 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 10)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011107", "story_v_out_120011.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011107", "story_v_out_120011.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_out_120011", "120011107", "story_v_out_120011.awb")

						arg_436_1:RecordAudio("120011107", var_439_11)
						arg_436_1:RecordAudio("120011107", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_120011", "120011107", "story_v_out_120011.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_120011", "120011107", "story_v_out_120011.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play120011108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 120011108
		arg_440_1.duration_ = 1.6

		local var_440_0 = {
			zh = 1.6,
			ja = 1.4
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play120011109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1071ui_story = arg_440_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).z)
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles = arg_440_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_440_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1071ui_story"].transform.position).z)
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1071ui_story"].transform.localEulerAngles = arg_440_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["1071ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1071ui_story == nil then
				arg_440_1.var_.characterEffect1071ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect1071ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect1071ui_story then
				arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_443_4 = arg_440_1.actors_["1084ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1084ui_story == nil then
				arg_440_1.var_.characterEffect1084ui_story = var_443_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_5 = 0.2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_5 and not isNil(var_443_4) then
				if arg_440_1.var_.characterEffect1084ui_story and not isNil(var_443_4) then
					arg_440_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_5)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_5 and arg_440_1.time_ < 0 + var_443_5 + arg_443_0 and not isNil(var_443_4) and arg_440_1.var_.characterEffect1084ui_story then
				arg_440_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_443_6 = 0
			local var_443_7 = 0.05

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_8 = arg_440_1:GetWordFromCfg(120011108)
				local var_443_9 = arg_440_1:FormatText(var_443_8.content)

				arg_440_1.text_.text = var_443_9

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 2 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 2)

				if (2 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 2)) > 0 and var_443_7 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_9
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011108", "story_v_out_120011.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_out_120011", "120011108", "story_v_out_120011.awb") / 1000

					if var_443_12 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_6
					end

					if var_443_8.prefab_name ~= "" and arg_440_1.actors_[var_443_8.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_8.prefab_name].transform, "story_v_out_120011", "120011108", "story_v_out_120011.awb")

						arg_440_1:RecordAudio("120011108", var_443_13)
						arg_440_1:RecordAudio("120011108", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_120011", "120011108", "story_v_out_120011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_120011", "120011108", "story_v_out_120011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play120011109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 120011109
		arg_444_1.duration_ = 9.9

		local var_444_0 = {
			zh = 7.9,
			ja = 9.9
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play120011110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos1071ui_story = arg_444_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_447_0 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 then
				arg_444_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_444_1.time_ - 0) / var_447_0)
				arg_444_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).z)
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles = arg_444_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 then
				arg_444_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_444_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["1071ui_story"].transform.position).z)
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["1071ui_story"].transform.localEulerAngles = arg_444_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_447_1 = 0
			local var_447_2 = 0.975

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(120011109)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 39 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 39)

				if (39 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 39)) > 0 and var_447_2 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011109", "story_v_out_120011.awb") ~= 0 then
					local var_447_7 = manager.audio:GetVoiceLength("story_v_out_120011", "120011109", "story_v_out_120011.awb") / 1000

					if var_447_7 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_1
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_out_120011", "120011109", "story_v_out_120011.awb")

						arg_444_1:RecordAudio("120011109", var_447_8)
						arg_444_1:RecordAudio("120011109", var_447_8)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_120011", "120011109", "story_v_out_120011.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_120011", "120011109", "story_v_out_120011.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_9 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_9 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_9

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_9 and arg_444_1.time_ < var_447_1 + var_447_9 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play120011110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 120011110
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play120011111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1071ui_story"]) and arg_448_1.var_.characterEffect1071ui_story == nil then
				arg_448_1.var_.characterEffect1071ui_story = arg_448_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1071ui_story"]) then
				if arg_448_1.var_.characterEffect1071ui_story and not isNil(arg_448_1.actors_["1071ui_story"]) then
					arg_448_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1071ui_story"]) and arg_448_1.var_.characterEffect1071ui_story then
				arg_448_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_451_1 = 0
			local var_451_2 = 0.325

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(120011110).content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 13 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 13)

				if (13 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 13)) > 0 and var_451_2 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_1 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_1
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_6 = math.max(var_451_2, arg_448_1.talkMaxDuration)

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_6 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_1) / var_451_6

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_1 + var_451_6 and arg_448_1.time_ < var_451_1 + var_451_6 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play120011111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 120011111
		arg_452_1.duration_ = 6.63

		local var_452_0 = {
			zh = 6.633,
			ja = 5.766
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play120011112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["1071ui_story"]) and arg_452_1.var_.characterEffect1071ui_story == nil then
				arg_452_1.var_.characterEffect1071ui_story = arg_452_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["1071ui_story"]) then
				if arg_452_1.var_.characterEffect1071ui_story and not isNil(arg_452_1.actors_["1071ui_story"]) then
					arg_452_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["1071ui_story"]) and arg_452_1.var_.characterEffect1071ui_story then
				arg_452_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_455_2 = 0
			local var_455_3 = 0.6

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_2 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_4 = arg_452_1:GetWordFromCfg(120011111)
				local var_455_5 = arg_452_1:FormatText(var_455_4.content)

				arg_452_1.text_.text = var_455_5

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_7 = 24 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_5) / 24)

				if (24 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_5) / 24)) > 0 and var_455_3 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_2 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_2
					end
				end

				arg_452_1.text_.text = var_455_5
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011111", "story_v_out_120011.awb") ~= 0 then
					local var_455_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011111", "story_v_out_120011.awb") / 1000

					if var_455_8 + var_455_2 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_2
					end

					if var_455_4.prefab_name ~= "" and arg_452_1.actors_[var_455_4.prefab_name] ~= nil then
						local var_455_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_4.prefab_name].transform, "story_v_out_120011", "120011111", "story_v_out_120011.awb")

						arg_452_1:RecordAudio("120011111", var_455_9)
						arg_452_1:RecordAudio("120011111", var_455_9)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_120011", "120011111", "story_v_out_120011.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_120011", "120011111", "story_v_out_120011.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_3, arg_452_1.talkMaxDuration)

			if var_455_2 <= arg_452_1.time_ and arg_452_1.time_ < var_455_2 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_2) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_2 + var_455_10 and arg_452_1.time_ < var_455_2 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play120011112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 120011112
		arg_456_1.duration_ = 13

		local var_456_0 = {
			zh = 8.233,
			ja = 13
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play120011113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 1.125

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[376].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:GetWordFromCfg(120011112)
				local var_459_2 = arg_456_1:FormatText(var_459_1.content)

				arg_456_1.text_.text = var_459_2

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 45 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 45)

				if (45 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 45)) > 0 and var_459_0 < var_459_4 then
					arg_456_1.talkMaxDuration = var_459_4

					if var_459_4 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_4 + 0
					end
				end

				arg_456_1.text_.text = var_459_2
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011112", "story_v_out_120011.awb") ~= 0 then
					local var_459_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011112", "story_v_out_120011.awb") / 1000

					if var_459_5 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + 0
					end

					if var_459_1.prefab_name ~= "" and arg_456_1.actors_[var_459_1.prefab_name] ~= nil then
						local var_459_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_1.prefab_name].transform, "story_v_out_120011", "120011112", "story_v_out_120011.awb")

						arg_456_1:RecordAudio("120011112", var_459_6)
						arg_456_1:RecordAudio("120011112", var_459_6)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_120011", "120011112", "story_v_out_120011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_120011", "120011112", "story_v_out_120011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play120011113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 120011113
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play120011114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1084ui_story = arg_460_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).z)
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles = arg_460_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_460_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1084ui_story"].transform.position).z)
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1084ui_story"].transform.localEulerAngles = arg_460_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_463_1 = arg_460_1.actors_["1071ui_story"].transform

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1071ui_story = var_463_1.localPosition
			end

			local var_463_2 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 then
				var_463_1.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_460_1.time_ - 0) / var_463_2)
				var_463_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_463_1.position).x, (manager.ui.mainCamera.transform.position - var_463_1.position).y, (manager.ui.mainCamera.transform.position - var_463_1.position).z)
				var_463_1.localEulerAngles.z = 0
				var_463_1.localEulerAngles.x = 0
				var_463_1.localEulerAngles = var_463_1.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 then
				var_463_1.localPosition = Vector3.New(0, 100, 0)
				var_463_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_463_1.position).x, (manager.ui.mainCamera.transform.position - var_463_1.position).y, (manager.ui.mainCamera.transform.position - var_463_1.position).z)
				var_463_1.localEulerAngles.z = 0
				var_463_1.localEulerAngles.x = 0
				var_463_1.localEulerAngles = var_463_1.localEulerAngles
			end

			local var_463_3 = 0
			local var_463_4 = 0.4

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_3 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_5 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(120011113).content)

				arg_460_1.text_.text = var_463_5

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_7 = 16 <= 0 and var_463_4 or var_463_4 * (utf8.len(var_463_5) / 16)

				if (16 <= 0 and var_463_4 or var_463_4 * (utf8.len(var_463_5) / 16)) > 0 and var_463_4 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_3 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_3
					end
				end

				arg_460_1.text_.text = var_463_5
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_8 = math.max(var_463_4, arg_460_1.talkMaxDuration)

			if var_463_3 <= arg_460_1.time_ and arg_460_1.time_ < var_463_3 + var_463_8 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_3) / var_463_8

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_3 + var_463_8 and arg_460_1.time_ < var_463_3 + var_463_8 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play120011114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 120011114
		arg_464_1.duration_ = 4.8

		local var_464_0 = {
			zh = 4.133,
			ja = 4.8
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play120011115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1084ui_story = arg_464_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_467_0 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 then
				arg_464_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_464_1.time_ - 0) / var_467_0)
				arg_464_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).z)
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles = arg_464_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 then
				arg_464_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_464_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).z)
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles = arg_464_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_467_1 = arg_464_1.actors_["1084ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1084ui_story == nil then
				arg_464_1.var_.characterEffect1084ui_story = var_467_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_2 and not isNil(var_467_1) then
				if arg_464_1.var_.characterEffect1084ui_story and not isNil(var_467_1) then
					arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_2 and arg_464_1.time_ < 0 + var_467_2 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1084ui_story then
				arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_467_4 = 0
			local var_467_5 = 0.45

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_6 = arg_464_1:GetWordFromCfg(120011114)
				local var_467_7 = arg_464_1:FormatText(var_467_6.content)

				arg_464_1.text_.text = var_467_7

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_9 = 18 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 18)

				if (18 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 18)) > 0 and var_467_5 < var_467_9 then
					arg_464_1.talkMaxDuration = var_467_9

					if var_467_9 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_9 + var_467_4
					end
				end

				arg_464_1.text_.text = var_467_7
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011114", "story_v_out_120011.awb") ~= 0 then
					local var_467_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011114", "story_v_out_120011.awb") / 1000

					if var_467_10 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_4
					end

					if var_467_6.prefab_name ~= "" and arg_464_1.actors_[var_467_6.prefab_name] ~= nil then
						local var_467_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_6.prefab_name].transform, "story_v_out_120011", "120011114", "story_v_out_120011.awb")

						arg_464_1:RecordAudio("120011114", var_467_11)
						arg_464_1:RecordAudio("120011114", var_467_11)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_120011", "120011114", "story_v_out_120011.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_120011", "120011114", "story_v_out_120011.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_12 = math.max(var_467_5, arg_464_1.talkMaxDuration)

			if var_467_4 <= arg_464_1.time_ and arg_464_1.time_ < var_467_4 + var_467_12 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_4) / var_467_12

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_4 + var_467_12 and arg_464_1.time_ < var_467_4 + var_467_12 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play120011115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 120011115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play120011116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1084ui_story"]) and arg_468_1.var_.characterEffect1084ui_story == nil then
				arg_468_1.var_.characterEffect1084ui_story = arg_468_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.2

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1084ui_story"]) then
				if arg_468_1.var_.characterEffect1084ui_story and not isNil(arg_468_1.actors_["1084ui_story"]) then
					arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_0)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1084ui_story"]) and arg_468_1.var_.characterEffect1084ui_story then
				arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_471_1 = 0
			local var_471_2 = 0.675

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_3 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(120011115).content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 27 <= 0 and var_471_2 or var_471_2 * (utf8.len(var_471_3) / 27)

				if (27 <= 0 and var_471_2 or var_471_2 * (utf8.len(var_471_3) / 27)) > 0 and var_471_2 < var_471_5 then
					arg_468_1.talkMaxDuration = var_471_5

					if var_471_5 + var_471_1 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + var_471_1
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_6 = math.max(var_471_2, arg_468_1.talkMaxDuration)

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_6 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_1) / var_471_6

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_1 + var_471_6 and arg_468_1.time_ < var_471_1 + var_471_6 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play120011116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 120011116
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play120011117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos1084ui_story = arg_472_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_475_0 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_472_1.time_ - 0) / var_475_0)
				arg_472_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).z)
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles = arg_472_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_472_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1084ui_story"].transform.position).z)
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1084ui_story"].transform.localEulerAngles = arg_472_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_475_1 = 0
			local var_475_2 = 0.5

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(120011116).content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 20 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 20)

				if (20 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 20)) > 0 and var_475_2 < var_475_5 then
					arg_472_1.talkMaxDuration = var_475_5

					if var_475_5 + var_475_1 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + var_475_1
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_6 = math.max(var_475_2, arg_472_1.talkMaxDuration)

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_6 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_1) / var_475_6

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_1 + var_475_6 and arg_472_1.time_ < var_475_1 + var_475_6 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play120011117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 120011117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play120011118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.5

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(120011117).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 20 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 20)

				if (20 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 20)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play120011118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 120011118
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play120011119(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.1

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(120011118).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 4 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 4)

				if (4 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 4)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play120011119 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 120011119
		arg_484_1.duration_ = 7.6

		local var_484_0 = {
			zh = 6.333,
			ja = 7.6
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play120011120(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.var_.moveOldPos1084ui_story = arg_484_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_487_0 = 0.001

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 then
				arg_484_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_484_1.time_ - 0) / var_487_0)
				arg_484_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).z)
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles = arg_484_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 then
				arg_484_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_484_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1084ui_story"].transform.position).z)
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1084ui_story"].transform.localEulerAngles = arg_484_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_487_1 = arg_484_1.actors_["1084ui_story"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_1) and arg_484_1.var_.characterEffect1084ui_story == nil then
				arg_484_1.var_.characterEffect1084ui_story = var_487_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_2 and not isNil(var_487_1) then
				if arg_484_1.var_.characterEffect1084ui_story and not isNil(var_487_1) then
					arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= 0 + var_487_2 and arg_484_1.time_ < 0 + var_487_2 + arg_487_0 and not isNil(var_487_1) and arg_484_1.var_.characterEffect1084ui_story then
				arg_484_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_487_4 = 0
			local var_487_5 = 0.65

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_4 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_6 = arg_484_1:GetWordFromCfg(120011119)
				local var_487_7 = arg_484_1:FormatText(var_487_6.content)

				arg_484_1.text_.text = var_487_7

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_9 = 26 <= 0 and var_487_5 or var_487_5 * (utf8.len(var_487_7) / 26)

				if (26 <= 0 and var_487_5 or var_487_5 * (utf8.len(var_487_7) / 26)) > 0 and var_487_5 < var_487_9 then
					arg_484_1.talkMaxDuration = var_487_9

					if var_487_9 + var_487_4 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_9 + var_487_4
					end
				end

				arg_484_1.text_.text = var_487_7
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011119", "story_v_out_120011.awb") ~= 0 then
					local var_487_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011119", "story_v_out_120011.awb") / 1000

					if var_487_10 + var_487_4 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_10 + var_487_4
					end

					if var_487_6.prefab_name ~= "" and arg_484_1.actors_[var_487_6.prefab_name] ~= nil then
						local var_487_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_6.prefab_name].transform, "story_v_out_120011", "120011119", "story_v_out_120011.awb")

						arg_484_1:RecordAudio("120011119", var_487_11)
						arg_484_1:RecordAudio("120011119", var_487_11)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_120011", "120011119", "story_v_out_120011.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_120011", "120011119", "story_v_out_120011.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_12 = math.max(var_487_5, arg_484_1.talkMaxDuration)

			if var_487_4 <= arg_484_1.time_ and arg_484_1.time_ < var_487_4 + var_487_12 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_4) / var_487_12

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_4 + var_487_12 and arg_484_1.time_ < var_487_4 + var_487_12 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_484_1:InitPlayNodeList()
	end,
	Play120011120 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 120011120
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play120011121(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos1084ui_story = arg_488_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_491_0 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				arg_488_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).z)
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles = arg_488_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				arg_488_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_488_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1084ui_story"].transform.position).z)
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1084ui_story"].transform.localEulerAngles = arg_488_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_491_1 = 0
			local var_491_2 = 1.15

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_3 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(120011120).content)

				arg_488_1.text_.text = var_491_3

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 46 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 46)

				if (46 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_3) / 46)) > 0 and var_491_2 < var_491_5 then
					arg_488_1.talkMaxDuration = var_491_5

					if var_491_5 + var_491_1 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + var_491_1
					end
				end

				arg_488_1.text_.text = var_491_3
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_6 = math.max(var_491_2, arg_488_1.talkMaxDuration)

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_6 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_1) / var_491_6

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_1 + var_491_6 and arg_488_1.time_ < var_491_1 + var_491_6 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play120011121 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 120011121
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play120011122(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0.85

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_1 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(120011121).content)

				arg_492_1.text_.text = var_495_1

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_3 = 34 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_1) / 34)

				if (34 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_1) / 34)) > 0 and var_495_0 < var_495_3 then
					arg_492_1.talkMaxDuration = var_495_3

					if var_495_3 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_3 + 0
					end
				end

				arg_492_1.text_.text = var_495_1
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_4 = math.max(var_495_0, arg_492_1.talkMaxDuration)

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_4 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - 0) / var_495_4

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= 0 + var_495_4 and arg_492_1.time_ < 0 + var_495_4 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play120011122 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 120011122
		arg_496_1.duration_ = 9

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play120011123(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if arg_496_1.bgs_.XH0102a == nil then
				local var_499_0 = Object.Instantiate(arg_496_1.paintGo_)

				var_499_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0102a")
				var_499_0.name = "XH0102a"
				var_499_0.transform.parent = arg_496_1.stage_.transform
				var_499_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.bgs_.XH0102a = var_499_0
			end

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= 2 + arg_499_0 then
				local var_499_1 = arg_496_1.bgs_.XH0102a

				arg_496_1.bgs_.XH0102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_499_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_499_2 = var_499_1:GetComponent("SpriteRenderer")

				if var_499_2 and var_499_2.sprite then
					local var_499_3 = 2 * (var_499_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_499_1.transform.localScale = Vector3.New(var_499_3 / var_499_2.sprite.bounds.size.y < var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x and var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x or var_499_3 / var_499_2.sprite.bounds.size.y, var_499_3 / var_499_2.sprite.bounds.size.y < var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x and var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x or var_499_3 / var_499_2.sprite.bounds.size.y, 0)
				end

				for iter_499_0, iter_499_1 in pairs(arg_496_1.bgs_) do
					if iter_499_0 ~= "XH0102a" then
						iter_499_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_499_4 = 0

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_4 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_5 = 2

			if var_499_4 <= arg_496_1.time_ and arg_496_1.time_ < var_499_4 + var_499_5 then
				local var_499_6 = Color.New(0, 0, 0)

				var_499_6.a = Mathf.Lerp(0, 1, (arg_496_1.time_ - var_499_4) / var_499_5)
				arg_496_1.mask_.color = var_499_6
			end

			if arg_496_1.time_ >= var_499_4 + var_499_5 and arg_496_1.time_ < var_499_4 + var_499_5 + arg_499_0 then
				local var_499_7 = Color.New(0, 0, 0)

				var_499_7.a = 1
				arg_496_1.mask_.color = var_499_7
			end

			local var_499_8 = 2

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= var_499_8 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_9 = 2

			if var_499_8 <= arg_496_1.time_ and arg_496_1.time_ < var_499_8 + var_499_9 then
				local var_499_10 = Color.New(0, 0, 0)

				var_499_10.a = Mathf.Lerp(1, 0, (arg_496_1.time_ - var_499_8) / var_499_9)
				arg_496_1.mask_.color = var_499_10
			end

			if arg_496_1.time_ >= var_499_8 + var_499_9 and arg_496_1.time_ < var_499_8 + var_499_9 + arg_499_0 then
				local var_499_11 = Color.New(0, 0, 0)

				arg_496_1.mask_.enabled = false
				var_499_11.a = 0
				arg_496_1.mask_.color = var_499_11
			end

			local var_499_12 = arg_496_1.bgs_.XH0102a.transform

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= 2 + arg_499_0 then
				arg_496_1.var_.moveOldPosXH0102a = var_499_12.localPosition
			end

			local var_499_13 = 0.001

			if 2 <= arg_496_1.time_ and arg_496_1.time_ < 2 + var_499_13 then
				var_499_12.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPosXH0102a, Vector3.New(0, 1, 4), (arg_496_1.time_ - 2) / var_499_13)
			end

			if arg_496_1.time_ >= 2 + var_499_13 and arg_496_1.time_ < 2 + var_499_13 + arg_499_0 then
				var_499_12.localPosition = Vector3.New(0, 1, 4)
			end

			local var_499_14 = arg_496_1.bgs_.XH0102a.transform

			if 2.01666666666667 < arg_496_1.time_ and arg_496_1.time_ <= 2.01666666666667 + arg_499_0 then
				arg_496_1.var_.moveOldPosXH0102a = var_499_14.localPosition
			end

			local var_499_15 = 2.5

			if 2.01666666666667 <= arg_496_1.time_ and arg_496_1.time_ < 2.01666666666667 + var_499_15 then
				var_499_14.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPosXH0102a, Vector3.New(0, 0.5, 4.5), (arg_496_1.time_ - 2.01666666666667) / var_499_15)
			end

			if arg_496_1.time_ >= 2.01666666666667 + var_499_15 and arg_496_1.time_ < 2.01666666666667 + var_499_15 + arg_499_0 then
				var_499_14.localPosition = Vector3.New(0, 0.5, 4.5)
			end

			local var_499_16 = 4

			if 4 < arg_496_1.time_ and arg_496_1.time_ <= var_499_16 + arg_499_0 then
				arg_496_1.allBtn_.enabled = false
			end

			if arg_496_1.time_ >= var_499_16 + 1 and arg_496_1.time_ < var_499_16 + 1 + arg_499_0 then
				arg_496_1.allBtn_.enabled = true
			end

			if arg_496_1.frameCnt_ <= 1 then
				arg_496_1.dialog_:SetActive(false)
			end

			local var_499_17 = 4
			local var_499_18 = 1.3

			if 4 < arg_496_1.time_ and arg_496_1.time_ <= var_499_17 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0

				arg_496_1.dialog_:SetActive(true)

				arg_496_1.dialogCg_.alpha = 0

				local var_499_19 = LeanTween.value(arg_496_1.dialog_, 0, 1, 0.3)

				var_499_19:setOnUpdate(LuaHelper.FloatAction(function(arg_500_0)
					arg_496_1.dialogCg_.alpha = arg_500_0
				end))
				var_499_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_496_1.dialog_)
					var_499_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_496_1.duration_ = arg_496_1.duration_ + 0.3

				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_20 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(120011122).content)

				arg_496_1.text_.text = var_499_20

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_22 = 52 <= 0 and var_499_18 or var_499_18 * (utf8.len(var_499_20) / 52)

				if (52 <= 0 and var_499_18 or var_499_18 * (utf8.len(var_499_20) / 52)) > 0 and var_499_18 < var_499_22 then
					arg_496_1.talkMaxDuration = var_499_22
					var_499_17 = var_499_17 + 0.3

					if var_499_22 + var_499_17 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_22 + var_499_17
					end
				end

				arg_496_1.text_.text = var_499_20
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_23 = var_499_17 + 0.3
			local var_499_24 = math.max(var_499_18, arg_496_1.talkMaxDuration)

			if var_499_17 + 0.3 <= arg_496_1.time_ and arg_496_1.time_ < var_499_23 + var_499_24 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_23) / var_499_24

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_23 + var_499_24 and arg_496_1.time_ < var_499_23 + var_499_24 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0102a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0102a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play120011123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 120011123
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play120011124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 1.175

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(120011123).content)

				arg_502_1.text_.text = var_505_1

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_3 = 47 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 47)

				if (47 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 47)) > 0 and var_505_0 < var_505_3 then
					arg_502_1.talkMaxDuration = var_505_3

					if var_505_3 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_3 + 0
					end
				end

				arg_502_1.text_.text = var_505_1
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_4 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_4 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_4

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_4 and arg_502_1.time_ < 0 + var_505_4 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play120011124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 120011124
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play120011125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.85

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(120011124).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 34 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 34)

				if (34 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 34)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play120011125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 120011125
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play120011126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.875

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(120011125).content)

				arg_510_1.text_.text = var_513_1

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_3 = 35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)

				if (35 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_1) / 35)) > 0 and var_513_0 < var_513_3 then
					arg_510_1.talkMaxDuration = var_513_3

					if var_513_3 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_3 + 0
					end
				end

				arg_510_1.text_.text = var_513_1
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_4 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_4 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_4

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_4 and arg_510_1.time_ < 0 + var_513_4 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play120011126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 120011126
		arg_514_1.duration_ = 7.53

		local var_514_0 = {
			zh = 7.533,
			ja = 5.1
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
				arg_514_0:Play120011127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.875

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_1 = arg_514_1:GetWordFromCfg(120011126)
				local var_517_2 = arg_514_1:FormatText(var_517_1.content)

				arg_514_1.text_.text = var_517_2

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_4 = 35 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 35)

				if (35 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 35)) > 0 and var_517_0 < var_517_4 then
					arg_514_1.talkMaxDuration = var_517_4

					if var_517_4 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_4 + 0
					end
				end

				arg_514_1.text_.text = var_517_2
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011126", "story_v_out_120011.awb") ~= 0 then
					local var_517_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011126", "story_v_out_120011.awb") / 1000

					if var_517_5 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + 0
					end

					if var_517_1.prefab_name ~= "" and arg_514_1.actors_[var_517_1.prefab_name] ~= nil then
						local var_517_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_1.prefab_name].transform, "story_v_out_120011", "120011126", "story_v_out_120011.awb")

						arg_514_1:RecordAudio("120011126", var_517_6)
						arg_514_1:RecordAudio("120011126", var_517_6)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_120011", "120011126", "story_v_out_120011.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_120011", "120011126", "story_v_out_120011.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_7 = math.max(var_517_0, arg_514_1.talkMaxDuration)

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_7 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - 0) / var_517_7

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= 0 + var_517_7 and arg_514_1.time_ < 0 + var_517_7 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play120011127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 120011127
		arg_518_1.duration_ = 11.37

		local var_518_0 = {
			zh = 10.066,
			ja = 11.366
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
				arg_518_0:Play120011128(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 1.075

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_1 = arg_518_1:GetWordFromCfg(120011127)
				local var_521_2 = arg_518_1:FormatText(var_521_1.content)

				arg_518_1.text_.text = var_521_2

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_4 = 43 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 43)

				if (43 <= 0 and var_521_0 or var_521_0 * (utf8.len(var_521_2) / 43)) > 0 and var_521_0 < var_521_4 then
					arg_518_1.talkMaxDuration = var_521_4

					if var_521_4 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_4 + 0
					end
				end

				arg_518_1.text_.text = var_521_2
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011127", "story_v_out_120011.awb") ~= 0 then
					local var_521_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011127", "story_v_out_120011.awb") / 1000

					if var_521_5 + 0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + 0
					end

					if var_521_1.prefab_name ~= "" and arg_518_1.actors_[var_521_1.prefab_name] ~= nil then
						local var_521_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_1.prefab_name].transform, "story_v_out_120011", "120011127", "story_v_out_120011.awb")

						arg_518_1:RecordAudio("120011127", var_521_6)
						arg_518_1:RecordAudio("120011127", var_521_6)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_120011", "120011127", "story_v_out_120011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_120011", "120011127", "story_v_out_120011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_7 = math.max(var_521_0, arg_518_1.talkMaxDuration)

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_7 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - 0) / var_521_7

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= 0 + var_521_7 and arg_518_1.time_ < 0 + var_521_7 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play120011128 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 120011128
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play120011129(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 1.175

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_1 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(120011128).content)

				arg_522_1.text_.text = var_525_1

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_3 = 48 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_1) / 48)

				if (48 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_1) / 48)) > 0 and var_525_0 < var_525_3 then
					arg_522_1.talkMaxDuration = var_525_3

					if var_525_3 + 0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_3 + 0
					end
				end

				arg_522_1.text_.text = var_525_1
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_4 = math.max(var_525_0, arg_522_1.talkMaxDuration)

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_4 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - 0) / var_525_4

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= 0 + var_525_4 and arg_522_1.time_ < 0 + var_525_4 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play120011129 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 120011129
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play120011130(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0.8

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_1 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(120011129).content)

				arg_526_1.text_.text = var_529_1

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_3 = 32 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 32)

				if (32 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 32)) > 0 and var_529_0 < var_529_3 then
					arg_526_1.talkMaxDuration = var_529_3

					if var_529_3 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_3 + 0
					end
				end

				arg_526_1.text_.text = var_529_1
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_4 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_4

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play120011130 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 120011130
		arg_530_1.duration_ = 6.83

		local var_530_0 = {
			zh = 4.966,
			ja = 6.833
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
				arg_530_0:Play120011131(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.325

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_1 = arg_530_1:GetWordFromCfg(120011130)
				local var_533_2 = arg_530_1:FormatText(var_533_1.content)

				arg_530_1.text_.text = var_533_2

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_4 = 13 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 13)

				if (13 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 13)) > 0 and var_533_0 < var_533_4 then
					arg_530_1.talkMaxDuration = var_533_4

					if var_533_4 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_4 + 0
					end
				end

				arg_530_1.text_.text = var_533_2
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011130", "story_v_out_120011.awb") ~= 0 then
					local var_533_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011130", "story_v_out_120011.awb") / 1000

					if var_533_5 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + 0
					end

					if var_533_1.prefab_name ~= "" and arg_530_1.actors_[var_533_1.prefab_name] ~= nil then
						local var_533_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_1.prefab_name].transform, "story_v_out_120011", "120011130", "story_v_out_120011.awb")

						arg_530_1:RecordAudio("120011130", var_533_6)
						arg_530_1:RecordAudio("120011130", var_533_6)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_120011", "120011130", "story_v_out_120011.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_120011", "120011130", "story_v_out_120011.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_7 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_7 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_7

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_7 and arg_530_1.time_ < 0 + var_533_7 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play120011131 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 120011131
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play120011132(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0.4

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_1 = arg_534_1:FormatText(arg_534_1:GetWordFromCfg(120011131).content)

				arg_534_1.text_.text = var_537_1

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_3 = 16 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_1) / 16)

				if (16 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_1) / 16)) > 0 and var_537_0 < var_537_3 then
					arg_534_1.talkMaxDuration = var_537_3

					if var_537_3 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_3 + 0
					end
				end

				arg_534_1.text_.text = var_537_1
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_4 = math.max(var_537_0, arg_534_1.talkMaxDuration)

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_4 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - 0) / var_537_4

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= 0 + var_537_4 and arg_534_1.time_ < 0 + var_537_4 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play120011132 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 120011132
		arg_538_1.duration_ = 9

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play120011133(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 2 < arg_538_1.time_ and arg_538_1.time_ <= 2 + arg_541_0 then
				local var_541_0 = arg_538_1.bgs_.ST31

				arg_538_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_541_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_1 = var_541_0:GetComponent("SpriteRenderer")

				if var_541_1 and var_541_1.sprite then
					local var_541_2 = 2 * (var_541_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_541_0.transform.localScale = Vector3.New(var_541_2 / var_541_1.sprite.bounds.size.y < var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x and var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x or var_541_2 / var_541_1.sprite.bounds.size.y, var_541_2 / var_541_1.sprite.bounds.size.y < var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x and var_541_2 * manager.ui.mainCameraCom_.aspect / var_541_1.sprite.bounds.size.x or var_541_2 / var_541_1.sprite.bounds.size.y, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "ST31" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_541_3 = 0

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_3 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_4 = 2

			if var_541_3 <= arg_538_1.time_ and arg_538_1.time_ < var_541_3 + var_541_4 then
				local var_541_5 = Color.New(0, 0, 0)

				var_541_5.a = Mathf.Lerp(0, 1, (arg_538_1.time_ - var_541_3) / var_541_4)
				arg_538_1.mask_.color = var_541_5
			end

			if arg_538_1.time_ >= var_541_3 + var_541_4 and arg_538_1.time_ < var_541_3 + var_541_4 + arg_541_0 then
				local var_541_6 = Color.New(0, 0, 0)

				var_541_6.a = 1
				arg_538_1.mask_.color = var_541_6
			end

			local var_541_7 = 2

			if 2 < arg_538_1.time_ and arg_538_1.time_ <= var_541_7 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_8 = 2

			if var_541_7 <= arg_538_1.time_ and arg_538_1.time_ < var_541_7 + var_541_8 then
				local var_541_9 = Color.New(0, 0, 0)

				var_541_9.a = Mathf.Lerp(1, 0, (arg_538_1.time_ - var_541_7) / var_541_8)
				arg_538_1.mask_.color = var_541_9
			end

			if arg_538_1.time_ >= var_541_7 + var_541_8 and arg_538_1.time_ < var_541_7 + var_541_8 + arg_541_0 then
				local var_541_10 = Color.New(0, 0, 0)

				arg_538_1.mask_.enabled = false
				var_541_10.a = 0
				arg_538_1.mask_.color = var_541_10
			end

			if arg_538_1.frameCnt_ <= 1 then
				arg_538_1.dialog_:SetActive(false)
			end

			local var_541_11 = 4
			local var_541_12 = 0.625

			if 4 < arg_538_1.time_ and arg_538_1.time_ <= var_541_11 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				arg_538_1.dialog_:SetActive(true)

				arg_538_1.dialogCg_.alpha = 0

				local var_541_13 = LeanTween.value(arg_538_1.dialog_, 0, 1, 0.3)

				var_541_13:setOnUpdate(LuaHelper.FloatAction(function(arg_542_0)
					arg_538_1.dialogCg_.alpha = arg_542_0
				end))
				var_541_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_538_1.dialog_)
					var_541_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_538_1.duration_ = arg_538_1.duration_ + 0.3

				SetActive(arg_538_1.leftNameGo_, false)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_14 = arg_538_1:FormatText(arg_538_1:GetWordFromCfg(120011132).content)

				arg_538_1.text_.text = var_541_14

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_16 = 25 <= 0 and var_541_12 or var_541_12 * (utf8.len(var_541_14) / 25)

				if (25 <= 0 and var_541_12 or var_541_12 * (utf8.len(var_541_14) / 25)) > 0 and var_541_12 < var_541_16 then
					arg_538_1.talkMaxDuration = var_541_16
					var_541_11 = var_541_11 + 0.3

					if var_541_16 + var_541_11 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_16 + var_541_11
					end
				end

				arg_538_1.text_.text = var_541_14
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_17 = var_541_11 + 0.3
			local var_541_18 = math.max(var_541_12, arg_538_1.talkMaxDuration)

			if var_541_11 + 0.3 <= arg_538_1.time_ and arg_538_1.time_ < var_541_17 + var_541_18 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_17) / var_541_18

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_17 + var_541_18 and arg_538_1.time_ < var_541_17 + var_541_18 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play120011133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 120011133
		arg_544_1.duration_ = 8.37

		local var_544_0 = {
			zh = 8.1,
			ja = 8.366
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play120011134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1084ui_story = arg_544_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_547_0 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 then
				arg_544_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_544_1.time_ - 0) / var_547_0)
				arg_544_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).z)
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles = arg_544_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 then
				arg_544_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_544_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["1084ui_story"].transform.position).z)
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["1084ui_story"].transform.localEulerAngles = arg_544_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_547_1 = arg_544_1.actors_["1084ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_1) and arg_544_1.var_.characterEffect1084ui_story == nil then
				arg_544_1.var_.characterEffect1084ui_story = var_547_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.2

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_2 and not isNil(var_547_1) then
				if arg_544_1.var_.characterEffect1084ui_story and not isNil(var_547_1) then
					arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_2 and arg_544_1.time_ < 0 + var_547_2 + arg_547_0 and not isNil(var_547_1) and arg_544_1.var_.characterEffect1084ui_story then
				arg_544_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_547_4 = 0
			local var_547_5 = 0.9

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_6 = arg_544_1:GetWordFromCfg(120011133)
				local var_547_7 = arg_544_1:FormatText(var_547_6.content)

				arg_544_1.text_.text = var_547_7

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_9 = 36 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 36)

				if (36 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 36)) > 0 and var_547_5 < var_547_9 then
					arg_544_1.talkMaxDuration = var_547_9

					if var_547_9 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_9 + var_547_4
					end
				end

				arg_544_1.text_.text = var_547_7
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011133", "story_v_out_120011.awb") ~= 0 then
					local var_547_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011133", "story_v_out_120011.awb") / 1000

					if var_547_10 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_10 + var_547_4
					end

					if var_547_6.prefab_name ~= "" and arg_544_1.actors_[var_547_6.prefab_name] ~= nil then
						local var_547_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_6.prefab_name].transform, "story_v_out_120011", "120011133", "story_v_out_120011.awb")

						arg_544_1:RecordAudio("120011133", var_547_11)
						arg_544_1:RecordAudio("120011133", var_547_11)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_120011", "120011133", "story_v_out_120011.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_120011", "120011133", "story_v_out_120011.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_12 = math.max(var_547_5, arg_544_1.talkMaxDuration)

			if var_547_4 <= arg_544_1.time_ and arg_544_1.time_ < var_547_4 + var_547_12 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_4) / var_547_12

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_4 + var_547_12 and arg_544_1.time_ < var_547_4 + var_547_12 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play120011134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 120011134
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play120011135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) and arg_548_1.var_.characterEffect1084ui_story == nil then
				arg_548_1.var_.characterEffect1084ui_story = arg_548_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_0 = 0.2

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) then
				if arg_548_1.var_.characterEffect1084ui_story and not isNil(arg_548_1.actors_["1084ui_story"]) then
					arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_548_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_548_1.time_ - 0) / var_551_0)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["1084ui_story"]) and arg_548_1.var_.characterEffect1084ui_story then
				arg_548_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_548_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_551_1 = 0
			local var_551_2 = 0.6

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_3 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(120011134).content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 24 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 24)

				if (24 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 24)) > 0 and var_551_2 < var_551_5 then
					arg_548_1.talkMaxDuration = var_551_5

					if var_551_5 + var_551_1 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + var_551_1
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_6 = math.max(var_551_2, arg_548_1.talkMaxDuration)

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_6 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_1) / var_551_6

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_1 + var_551_6 and arg_548_1.time_ < var_551_1 + var_551_6 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play120011135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 120011135
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play120011136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.925

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(120011135).content)

				arg_552_1.text_.text = var_555_1

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_3 = 37 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 37)

				if (37 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_1) / 37)) > 0 and var_555_0 < var_555_3 then
					arg_552_1.talkMaxDuration = var_555_3

					if var_555_3 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_3 + 0
					end
				end

				arg_552_1.text_.text = var_555_1
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_4 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_4 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_4

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_4 and arg_552_1.time_ < 0 + var_555_4 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play120011136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 120011136
		arg_556_1.duration_ = 5.43

		local var_556_0 = {
			zh = 5.433,
			ja = 4.4
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play120011137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.var_.moveOldPos1084ui_story = arg_556_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_559_0 = 0.001

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 then
				arg_556_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_556_1.time_ - 0) / var_559_0)
				arg_556_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).z)
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles = arg_556_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 then
				arg_556_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_556_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_556_1.actors_["1084ui_story"].transform.position).z)
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_556_1.actors_["1084ui_story"].transform.localEulerAngles = arg_556_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_559_1 = arg_556_1.actors_["1084ui_story"]

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(var_559_1) and arg_556_1.var_.characterEffect1084ui_story == nil then
				arg_556_1.var_.characterEffect1084ui_story = var_559_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_2 = 0.2

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_2 and not isNil(var_559_1) then
				if arg_556_1.var_.characterEffect1084ui_story and not isNil(var_559_1) then
					arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= 0 + var_559_2 and arg_556_1.time_ < 0 + var_559_2 + arg_559_0 and not isNil(var_559_1) and arg_556_1.var_.characterEffect1084ui_story then
				arg_556_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action457")
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_559_4 = 0
			local var_559_5 = 0.425

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_4 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_6 = arg_556_1:GetWordFromCfg(120011136)
				local var_559_7 = arg_556_1:FormatText(var_559_6.content)

				arg_556_1.text_.text = var_559_7

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_9 = 17 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 17)

				if (17 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 17)) > 0 and var_559_5 < var_559_9 then
					arg_556_1.talkMaxDuration = var_559_9

					if var_559_9 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_9 + var_559_4
					end
				end

				arg_556_1.text_.text = var_559_7
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011136", "story_v_out_120011.awb") ~= 0 then
					local var_559_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011136", "story_v_out_120011.awb") / 1000

					if var_559_10 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_10 + var_559_4
					end

					if var_559_6.prefab_name ~= "" and arg_556_1.actors_[var_559_6.prefab_name] ~= nil then
						local var_559_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_6.prefab_name].transform, "story_v_out_120011", "120011136", "story_v_out_120011.awb")

						arg_556_1:RecordAudio("120011136", var_559_11)
						arg_556_1:RecordAudio("120011136", var_559_11)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_120011", "120011136", "story_v_out_120011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_120011", "120011136", "story_v_out_120011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_12 = math.max(var_559_5, arg_556_1.talkMaxDuration)

			if var_559_4 <= arg_556_1.time_ and arg_556_1.time_ < var_559_4 + var_559_12 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_4) / var_559_12

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_4 + var_559_12 and arg_556_1.time_ < var_559_4 + var_559_12 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play120011137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 120011137
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play120011138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) and arg_560_1.var_.characterEffect1084ui_story == nil then
				arg_560_1.var_.characterEffect1084ui_story = arg_560_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_0 = 0.2

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) then
				if arg_560_1.var_.characterEffect1084ui_story and not isNil(arg_560_1.actors_["1084ui_story"]) then
					arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_560_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_560_1.time_ - 0) / var_563_0)
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["1084ui_story"]) and arg_560_1.var_.characterEffect1084ui_story then
				arg_560_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_560_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_563_1 = 0
			local var_563_2 = 0.175

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(120011137).content)

				arg_560_1.text_.text = var_563_3

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 7 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 7)

				if (7 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 7)) > 0 and var_563_2 < var_563_5 then
					arg_560_1.talkMaxDuration = var_563_5

					if var_563_5 + var_563_1 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + var_563_1
					end
				end

				arg_560_1.text_.text = var_563_3
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_6 = math.max(var_563_2, arg_560_1.talkMaxDuration)

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_6 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_1) / var_563_6

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_1 + var_563_6 and arg_560_1.time_ < var_563_1 + var_563_6 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play120011138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 120011138
		arg_564_1.duration_ = 2.63

		local var_564_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play120011139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(arg_564_1.actors_["1084ui_story"]) and arg_564_1.var_.characterEffect1084ui_story == nil then
				arg_564_1.var_.characterEffect1084ui_story = arg_564_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_0 = 0.2

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 and not isNil(arg_564_1.actors_["1084ui_story"]) then
				if arg_564_1.var_.characterEffect1084ui_story and not isNil(arg_564_1.actors_["1084ui_story"]) then
					arg_564_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 and not isNil(arg_564_1.actors_["1084ui_story"]) and arg_564_1.var_.characterEffect1084ui_story then
				arg_564_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_567_2 = 0
			local var_567_3 = 0.2

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_2 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_4 = arg_564_1:GetWordFromCfg(120011138)
				local var_567_5 = arg_564_1:FormatText(var_567_4.content)

				arg_564_1.text_.text = var_567_5

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_7 = 8 <= 0 and var_567_3 or var_567_3 * (utf8.len(var_567_5) / 8)

				if (8 <= 0 and var_567_3 or var_567_3 * (utf8.len(var_567_5) / 8)) > 0 and var_567_3 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_2 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_2
					end
				end

				arg_564_1.text_.text = var_567_5
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011138", "story_v_out_120011.awb") ~= 0 then
					local var_567_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011138", "story_v_out_120011.awb") / 1000

					if var_567_8 + var_567_2 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_8 + var_567_2
					end

					if var_567_4.prefab_name ~= "" and arg_564_1.actors_[var_567_4.prefab_name] ~= nil then
						local var_567_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_4.prefab_name].transform, "story_v_out_120011", "120011138", "story_v_out_120011.awb")

						arg_564_1:RecordAudio("120011138", var_567_9)
						arg_564_1:RecordAudio("120011138", var_567_9)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_120011", "120011138", "story_v_out_120011.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_120011", "120011138", "story_v_out_120011.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_10 = math.max(var_567_3, arg_564_1.talkMaxDuration)

			if var_567_2 <= arg_564_1.time_ and arg_564_1.time_ < var_567_2 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_2) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_2 + var_567_10 and arg_564_1.time_ < var_567_2 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play120011139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 120011139
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play120011140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.var_.moveOldPos1084ui_story = arg_568_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_571_0 = 0.001

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 then
				arg_568_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_568_1.time_ - 0) / var_571_0)
				arg_568_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).z)
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles = arg_568_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 then
				arg_568_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_568_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).z)
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles = arg_568_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_571_1 = 0
			local var_571_2 = 0.725

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_3 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(120011139).content)

				arg_568_1.text_.text = var_571_3

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_5 = 29 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 29)

				if (29 <= 0 and var_571_2 or var_571_2 * (utf8.len(var_571_3) / 29)) > 0 and var_571_2 < var_571_5 then
					arg_568_1.talkMaxDuration = var_571_5

					if var_571_5 + var_571_1 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_5 + var_571_1
					end
				end

				arg_568_1.text_.text = var_571_3
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_6 = math.max(var_571_2, arg_568_1.talkMaxDuration)

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_6 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_1) / var_571_6

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_1 + var_571_6 and arg_568_1.time_ < var_571_1 + var_571_6 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_568_1:InitPlayNodeList()
	end,
	Play120011140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 120011140
		arg_572_1.duration_ = 3.9

		local var_572_0 = {
			zh = 3.9,
			ja = 2.633
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play120011141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.var_.moveOldPos1084ui_story = arg_572_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_575_0 = 0.001

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 then
				arg_572_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_572_1.time_ - 0) / var_575_0)
				arg_572_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).z)
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles = arg_572_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 then
				arg_572_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_572_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["1084ui_story"].transform.position).z)
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["1084ui_story"].transform.localEulerAngles = arg_572_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_575_1 = arg_572_1.actors_["1084ui_story"]

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect1084ui_story == nil then
				arg_572_1.var_.characterEffect1084ui_story = var_575_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_2 = 0.2

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_2 and not isNil(var_575_1) then
				if arg_572_1.var_.characterEffect1084ui_story and not isNil(var_575_1) then
					arg_572_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= 0 + var_575_2 and arg_572_1.time_ < 0 + var_575_2 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect1084ui_story then
				arg_572_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_575_4 = 0
			local var_575_5 = 0.375

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_4 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_6 = arg_572_1:GetWordFromCfg(120011140)
				local var_575_7 = arg_572_1:FormatText(var_575_6.content)

				arg_572_1.text_.text = var_575_7

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_9 = 15 <= 0 and var_575_5 or var_575_5 * (utf8.len(var_575_7) / 15)

				if (15 <= 0 and var_575_5 or var_575_5 * (utf8.len(var_575_7) / 15)) > 0 and var_575_5 < var_575_9 then
					arg_572_1.talkMaxDuration = var_575_9

					if var_575_9 + var_575_4 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_9 + var_575_4
					end
				end

				arg_572_1.text_.text = var_575_7
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011140", "story_v_out_120011.awb") ~= 0 then
					local var_575_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011140", "story_v_out_120011.awb") / 1000

					if var_575_10 + var_575_4 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_10 + var_575_4
					end

					if var_575_6.prefab_name ~= "" and arg_572_1.actors_[var_575_6.prefab_name] ~= nil then
						local var_575_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_6.prefab_name].transform, "story_v_out_120011", "120011140", "story_v_out_120011.awb")

						arg_572_1:RecordAudio("120011140", var_575_11)
						arg_572_1:RecordAudio("120011140", var_575_11)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_120011", "120011140", "story_v_out_120011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_120011", "120011140", "story_v_out_120011.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_12 = math.max(var_575_5, arg_572_1.talkMaxDuration)

			if var_575_4 <= arg_572_1.time_ and arg_572_1.time_ < var_575_4 + var_575_12 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_4) / var_575_12

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_4 + var_575_12 and arg_572_1.time_ < var_575_4 + var_575_12 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play120011141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 120011141
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play120011142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 and not isNil(arg_576_1.actors_["1084ui_story"]) and arg_576_1.var_.characterEffect1084ui_story == nil then
				arg_576_1.var_.characterEffect1084ui_story = arg_576_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_579_0 = 0.2

			if 0 <= arg_576_1.time_ and arg_576_1.time_ < 0 + var_579_0 and not isNil(arg_576_1.actors_["1084ui_story"]) then
				if arg_576_1.var_.characterEffect1084ui_story and not isNil(arg_576_1.actors_["1084ui_story"]) then
					arg_576_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_576_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_576_1.time_ - 0) / var_579_0)
				end
			end

			if arg_576_1.time_ >= 0 + var_579_0 and arg_576_1.time_ < 0 + var_579_0 + arg_579_0 and not isNil(arg_576_1.actors_["1084ui_story"]) and arg_576_1.var_.characterEffect1084ui_story then
				arg_576_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_576_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_579_1 = 0
			local var_579_2 = 1.075

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, true)
				arg_576_1.iconController_:SetSelectedState("hero")

				arg_576_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_576_1.callingController_:SetSelectedState("normal")

				arg_576_1.keyicon_.color = Color.New(1, 1, 1)
				arg_576_1.icon_.color = Color.New(1, 1, 1)

				local var_579_3 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(120011141).content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 43 <= 0 and var_579_2 or var_579_2 * (utf8.len(var_579_3) / 43)

				if (43 <= 0 and var_579_2 or var_579_2 * (utf8.len(var_579_3) / 43)) > 0 and var_579_2 < var_579_5 then
					arg_576_1.talkMaxDuration = var_579_5

					if var_579_5 + var_579_1 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + var_579_1
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_6 = math.max(var_579_2, arg_576_1.talkMaxDuration)

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_6 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_1) / var_579_6

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_1 + var_579_6 and arg_576_1.time_ < var_579_1 + var_579_6 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play120011142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 120011142
		arg_580_1.duration_ = 3.97

		local var_580_0 = {
			zh = 1.233,
			ja = 3.966
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play120011143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1.var_.moveOldPos1084ui_story = arg_580_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_583_0 = 0.001

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 then
				arg_580_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_580_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_580_1.time_ - 0) / var_583_0)
				arg_580_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).z)
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles = arg_580_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 then
				arg_580_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_580_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_580_1.actors_["1084ui_story"].transform.position).z)
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_580_1.actors_["1084ui_story"].transform.localEulerAngles = arg_580_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_583_1 = 0
			local var_583_2 = 0.125

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_1 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[377].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, true)
				arg_580_1.iconController_:SetSelectedState("hero")

				arg_580_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_580_1.callingController_:SetSelectedState("normal")

				arg_580_1.keyicon_.color = Color.New(1, 1, 1)
				arg_580_1.icon_.color = Color.New(1, 1, 1)

				local var_583_3 = arg_580_1:GetWordFromCfg(120011142)
				local var_583_4 = arg_580_1:FormatText(var_583_3.content)

				arg_580_1.text_.text = var_583_4

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_6 = 5 <= 0 and var_583_2 or var_583_2 * (utf8.len(var_583_4) / 5)

				if (5 <= 0 and var_583_2 or var_583_2 * (utf8.len(var_583_4) / 5)) > 0 and var_583_2 < var_583_6 then
					arg_580_1.talkMaxDuration = var_583_6

					if var_583_6 + var_583_1 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_6 + var_583_1
					end
				end

				arg_580_1.text_.text = var_583_4
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011142", "story_v_out_120011.awb") ~= 0 then
					local var_583_7 = manager.audio:GetVoiceLength("story_v_out_120011", "120011142", "story_v_out_120011.awb") / 1000

					if var_583_7 + var_583_1 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_7 + var_583_1
					end

					if var_583_3.prefab_name ~= "" and arg_580_1.actors_[var_583_3.prefab_name] ~= nil then
						local var_583_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_3.prefab_name].transform, "story_v_out_120011", "120011142", "story_v_out_120011.awb")

						arg_580_1:RecordAudio("120011142", var_583_8)
						arg_580_1:RecordAudio("120011142", var_583_8)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_120011", "120011142", "story_v_out_120011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_120011", "120011142", "story_v_out_120011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_9 = math.max(var_583_2, arg_580_1.talkMaxDuration)

			if var_583_1 <= arg_580_1.time_ and arg_580_1.time_ < var_583_1 + var_583_9 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_1) / var_583_9

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_1 + var_583_9 and arg_580_1.time_ < var_583_1 + var_583_9 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_580_1:InitPlayNodeList()
	end,
	Play120011143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 120011143
		arg_584_1.duration_ = 5

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play120011144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 0.95

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, false)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:FormatText(arg_584_1:GetWordFromCfg(120011143).content)

				arg_584_1.text_.text = var_587_1

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_3 = 38 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_1) / 38)

				if (38 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_1) / 38)) > 0 and var_587_0 < var_587_3 then
					arg_584_1.talkMaxDuration = var_587_3

					if var_587_3 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_3 + 0
					end
				end

				arg_584_1.text_.text = var_587_1
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)
				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_4 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_4 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_4

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_4 and arg_584_1.time_ < 0 + var_587_4 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play120011144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 120011144
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play120011145(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0.525

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_1 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(120011144).content)

				arg_588_1.text_.text = var_591_1

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_3 = 21 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 21)

				if (21 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 21)) > 0 and var_591_0 < var_591_3 then
					arg_588_1.talkMaxDuration = var_591_3

					if var_591_3 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_3 + 0
					end
				end

				arg_588_1.text_.text = var_591_1
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_4 = math.max(var_591_0, arg_588_1.talkMaxDuration)

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_4 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - 0) / var_591_4

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= 0 + var_591_4 and arg_588_1.time_ < 0 + var_591_4 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play120011145 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 120011145
		arg_592_1.duration_ = 3.33

		local var_592_0 = {
			zh = 1.999999999999,
			ja = 3.333
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play120011146(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if arg_592_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_595_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_592_1.stage_.transform)

				var_595_0.name = "1069ui_story"
				var_595_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_592_1.actors_["1069ui_story"] = var_595_0

				local var_595_1 = var_595_0:GetComponentInChildren(typeof(CharacterEffect))

				var_595_1.enabled = true

				local var_595_2 = GameObjectTools.GetOrAddComponent(var_595_0, typeof(DynamicBoneHelper))

				if var_595_2 then
					var_595_2:EnableDynamicBone(false)
				end

				arg_592_1:ShowWeapon(var_595_1.transform, false)

				arg_592_1.var_["1069ui_story" .. "Animator"] = var_595_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_592_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_592_1.var_["1069ui_story" .. "LipSync"] = var_595_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_595_3 = arg_592_1.actors_["1069ui_story"].transform

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.var_.moveOldPos1069ui_story = var_595_3.localPosition
			end

			local var_595_4 = 0.001

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_4 then
				var_595_3.localPosition = Vector3.Lerp(arg_592_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_592_1.time_ - 0) / var_595_4)
				var_595_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_3.position).x, (manager.ui.mainCamera.transform.position - var_595_3.position).y, (manager.ui.mainCamera.transform.position - var_595_3.position).z)
				var_595_3.localEulerAngles.z = 0
				var_595_3.localEulerAngles.x = 0
				var_595_3.localEulerAngles = var_595_3.localEulerAngles
			end

			if arg_592_1.time_ >= 0 + var_595_4 and arg_592_1.time_ < 0 + var_595_4 + arg_595_0 then
				var_595_3.localPosition = Vector3.New(0, -1, -6)
				var_595_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_595_3.position).x, (manager.ui.mainCamera.transform.position - var_595_3.position).y, (manager.ui.mainCamera.transform.position - var_595_3.position).z)
				var_595_3.localEulerAngles.z = 0
				var_595_3.localEulerAngles.x = 0
				var_595_3.localEulerAngles = var_595_3.localEulerAngles
			end

			local var_595_5 = arg_592_1.actors_["1069ui_story"]

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(var_595_5) and arg_592_1.var_.characterEffect1069ui_story == nil then
				arg_592_1.var_.characterEffect1069ui_story = var_595_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_6 = 0.2

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_6 and not isNil(var_595_5) then
				if arg_592_1.var_.characterEffect1069ui_story and not isNil(var_595_5) then
					arg_592_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= 0 + var_595_6 and arg_592_1.time_ < 0 + var_595_6 + arg_595_0 and not isNil(var_595_5) and arg_592_1.var_.characterEffect1069ui_story then
				arg_592_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_595_8 = 0
			local var_595_9 = 0.25

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_8 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[377].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_10 = arg_592_1:GetWordFromCfg(120011145)
				local var_595_11 = arg_592_1:FormatText(var_595_10.content)

				arg_592_1.text_.text = var_595_11

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_13 = 10 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 10)

				if (10 <= 0 and var_595_9 or var_595_9 * (utf8.len(var_595_11) / 10)) > 0 and var_595_9 < var_595_13 then
					arg_592_1.talkMaxDuration = var_595_13

					if var_595_13 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_13 + var_595_8
					end
				end

				arg_592_1.text_.text = var_595_11
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011145", "story_v_out_120011.awb") ~= 0 then
					local var_595_14 = manager.audio:GetVoiceLength("story_v_out_120011", "120011145", "story_v_out_120011.awb") / 1000

					if var_595_14 + var_595_8 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_14 + var_595_8
					end

					if var_595_10.prefab_name ~= "" and arg_592_1.actors_[var_595_10.prefab_name] ~= nil then
						local var_595_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_10.prefab_name].transform, "story_v_out_120011", "120011145", "story_v_out_120011.awb")

						arg_592_1:RecordAudio("120011145", var_595_15)
						arg_592_1:RecordAudio("120011145", var_595_15)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_120011", "120011145", "story_v_out_120011.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_120011", "120011145", "story_v_out_120011.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_16 = math.max(var_595_9, arg_592_1.talkMaxDuration)

			if var_595_8 <= arg_592_1.time_ and arg_592_1.time_ < var_595_8 + var_595_16 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_8) / var_595_16

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_8 + var_595_16 and arg_592_1.time_ < var_595_8 + var_595_16 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_592_1:InitPlayNodeList()
	end,
	Play120011146 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 120011146
		arg_596_1.duration_ = 2.03

		local var_596_0 = {
			zh = 1.333,
			ja = 2.033
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play120011147(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0.125

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[377].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_1 = arg_596_1:GetWordFromCfg(120011146)
				local var_599_2 = arg_596_1:FormatText(var_599_1.content)

				arg_596_1.text_.text = var_599_2

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_4 = 5 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_2) / 5)

				if (5 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_2) / 5)) > 0 and var_599_0 < var_599_4 then
					arg_596_1.talkMaxDuration = var_599_4

					if var_599_4 + 0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_4 + 0
					end
				end

				arg_596_1.text_.text = var_599_2
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011146", "story_v_out_120011.awb") ~= 0 then
					local var_599_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011146", "story_v_out_120011.awb") / 1000

					if var_599_5 + 0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_5 + 0
					end

					if var_599_1.prefab_name ~= "" and arg_596_1.actors_[var_599_1.prefab_name] ~= nil then
						local var_599_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_1.prefab_name].transform, "story_v_out_120011", "120011146", "story_v_out_120011.awb")

						arg_596_1:RecordAudio("120011146", var_599_6)
						arg_596_1:RecordAudio("120011146", var_599_6)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_120011", "120011146", "story_v_out_120011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_120011", "120011146", "story_v_out_120011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_7 = math.max(var_599_0, arg_596_1.talkMaxDuration)

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_7 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - 0) / var_599_7

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= 0 + var_599_7 and arg_596_1.time_ < 0 + var_599_7 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play120011147 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 120011147
		arg_600_1.duration_ = 0.2

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"

			SetActive(arg_600_1.choicesGo_, true)

			for iter_601_0, iter_601_1 in ipairs(arg_600_1.choices_) do
				SetActive(iter_601_1.go, iter_601_0 <= 2)
			end

			arg_600_1.choices_[1].txt.text = arg_600_1:FormatText(StoryChoiceCfg[364].name)
			arg_600_1.choices_[2].txt.text = arg_600_1:FormatText(StoryChoiceCfg[365].name)
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play120011148(arg_600_1)
			end

			if arg_602_0 == 2 then
				arg_600_0:Play120011148(arg_600_1)
			end

			arg_600_1:RecordChoiceLog(120011147, 364, 365)
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1069ui_story"]) and arg_600_1.var_.characterEffect1069ui_story == nil then
				arg_600_1.var_.characterEffect1069ui_story = arg_600_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.2

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1069ui_story"]) then
				if arg_600_1.var_.characterEffect1069ui_story and not isNil(arg_600_1.actors_["1069ui_story"]) then
					arg_600_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_600_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_600_1.time_ - 0) / var_603_0)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1069ui_story"]) and arg_600_1.var_.characterEffect1069ui_story then
				arg_600_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_600_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play120011148 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 120011148
		arg_604_1.duration_ = 4.43

		local var_604_0 = {
			zh = 3.766,
			ja = 4.433
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play120011149(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1069ui_story"]) and arg_604_1.var_.characterEffect1069ui_story == nil then
				arg_604_1.var_.characterEffect1069ui_story = arg_604_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_0 = 0.2

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1069ui_story"]) then
				if arg_604_1.var_.characterEffect1069ui_story and not isNil(arg_604_1.actors_["1069ui_story"]) then
					arg_604_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1069ui_story"]) and arg_604_1.var_.characterEffect1069ui_story then
				arg_604_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_607_2 = "1069ui_story"

			if arg_604_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_607_3 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_604_1.stage_.transform)

				var_607_3.name = var_607_2
				var_607_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_604_1.actors_[var_607_2] = var_607_3

				local var_607_4 = var_607_3:GetComponentInChildren(typeof(CharacterEffect))

				var_607_4.enabled = true

				local var_607_5 = GameObjectTools.GetOrAddComponent(var_607_3, typeof(DynamicBoneHelper))

				if var_607_5 then
					var_607_5:EnableDynamicBone(false)
				end

				arg_604_1:ShowWeapon(var_607_4.transform, false)

				arg_604_1.var_[var_607_2 .. "Animator"] = var_607_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_604_1.var_[var_607_2 .. "Animator"].applyRootMotion = true
				arg_604_1.var_[var_607_2 .. "LipSync"] = var_607_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_607_6 = 0
			local var_607_7 = 0.4

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_6 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_8 = arg_604_1:GetWordFromCfg(120011148)
				local var_607_9 = arg_604_1:FormatText(var_607_8.content)

				arg_604_1.text_.text = var_607_9

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_11 = 16 <= 0 and var_607_7 or var_607_7 * (utf8.len(var_607_9) / 16)

				if (16 <= 0 and var_607_7 or var_607_7 * (utf8.len(var_607_9) / 16)) > 0 and var_607_7 < var_607_11 then
					arg_604_1.talkMaxDuration = var_607_11

					if var_607_11 + var_607_6 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_11 + var_607_6
					end
				end

				arg_604_1.text_.text = var_607_9
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011148", "story_v_out_120011.awb") ~= 0 then
					local var_607_12 = manager.audio:GetVoiceLength("story_v_out_120011", "120011148", "story_v_out_120011.awb") / 1000

					if var_607_12 + var_607_6 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_12 + var_607_6
					end

					if var_607_8.prefab_name ~= "" and arg_604_1.actors_[var_607_8.prefab_name] ~= nil then
						local var_607_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_8.prefab_name].transform, "story_v_out_120011", "120011148", "story_v_out_120011.awb")

						arg_604_1:RecordAudio("120011148", var_607_13)
						arg_604_1:RecordAudio("120011148", var_607_13)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_120011", "120011148", "story_v_out_120011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_120011", "120011148", "story_v_out_120011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_14 = math.max(var_607_7, arg_604_1.talkMaxDuration)

			if var_607_6 <= arg_604_1.time_ and arg_604_1.time_ < var_607_6 + var_607_14 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_6) / var_607_14

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_6 + var_607_14 and arg_604_1.time_ < var_607_6 + var_607_14 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play120011149 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 120011149
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play120011150(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1069ui_story = arg_608_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_611_0 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 then
				arg_608_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_608_1.time_ - 0) / var_611_0)
				arg_608_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).z)
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles = arg_608_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 then
				arg_608_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_608_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["1069ui_story"].transform.position).z)
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["1069ui_story"].transform.localEulerAngles = arg_608_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_611_1 = 0
			local var_611_2 = 1.05

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_3 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(120011149).content)

				arg_608_1.text_.text = var_611_3

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_5 = 42 <= 0 and var_611_2 or var_611_2 * (utf8.len(var_611_3) / 42)

				if (42 <= 0 and var_611_2 or var_611_2 * (utf8.len(var_611_3) / 42)) > 0 and var_611_2 < var_611_5 then
					arg_608_1.talkMaxDuration = var_611_5

					if var_611_5 + var_611_1 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_5 + var_611_1
					end
				end

				arg_608_1.text_.text = var_611_3
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_6 = math.max(var_611_2, arg_608_1.talkMaxDuration)

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_6 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_1) / var_611_6

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_1 + var_611_6 and arg_608_1.time_ < var_611_1 + var_611_6 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play120011150 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 120011150
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play120011151(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.725

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, false)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_1 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(120011150).content)

				arg_612_1.text_.text = var_615_1

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_3 = 29 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 29)

				if (29 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 29)) > 0 and var_615_0 < var_615_3 then
					arg_612_1.talkMaxDuration = var_615_3

					if var_615_3 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_3 + 0
					end
				end

				arg_612_1.text_.text = var_615_1
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_4 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_4 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_4

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_4 and arg_612_1.time_ < 0 + var_615_4 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play120011151 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 120011151
		arg_616_1.duration_ = 10.4

		local var_616_0 = {
			zh = 6.1,
			ja = 10.4
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play120011152(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.var_.moveOldPos1084ui_story = arg_616_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_619_0 = 0.001

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_0 then
				arg_616_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_616_1.time_ - 0) / var_619_0)
				arg_616_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).z)
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles = arg_616_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_616_1.time_ >= 0 + var_619_0 and arg_616_1.time_ < 0 + var_619_0 + arg_619_0 then
				arg_616_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_616_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).z)
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles = arg_616_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_619_1 = arg_616_1.actors_["1069ui_story"].transform

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.var_.moveOldPos1069ui_story = var_619_1.localPosition
			end

			local var_619_2 = 0.001

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_2 then
				var_619_1.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_616_1.time_ - 0) / var_619_2)
				var_619_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_619_1.position).x, (manager.ui.mainCamera.transform.position - var_619_1.position).y, (manager.ui.mainCamera.transform.position - var_619_1.position).z)
				var_619_1.localEulerAngles.z = 0
				var_619_1.localEulerAngles.x = 0
				var_619_1.localEulerAngles = var_619_1.localEulerAngles
			end

			if arg_616_1.time_ >= 0 + var_619_2 and arg_616_1.time_ < 0 + var_619_2 + arg_619_0 then
				var_619_1.localPosition = Vector3.New(0.7, -1, -6)
				var_619_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_619_1.position).x, (manager.ui.mainCamera.transform.position - var_619_1.position).y, (manager.ui.mainCamera.transform.position - var_619_1.position).z)
				var_619_1.localEulerAngles.z = 0
				var_619_1.localEulerAngles.x = 0
				var_619_1.localEulerAngles = var_619_1.localEulerAngles
			end

			local var_619_3 = arg_616_1.actors_["1084ui_story"]

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(var_619_3) and arg_616_1.var_.characterEffect1084ui_story == nil then
				arg_616_1.var_.characterEffect1084ui_story = var_619_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_4 = 0.2

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_4 and not isNil(var_619_3) then
				if arg_616_1.var_.characterEffect1084ui_story and not isNil(var_619_3) then
					arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_616_1.time_ >= 0 + var_619_4 and arg_616_1.time_ < 0 + var_619_4 + arg_619_0 and not isNil(var_619_3) and arg_616_1.var_.characterEffect1084ui_story then
				arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_619_6 = arg_616_1.actors_["1069ui_story"]

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(var_619_6) and arg_616_1.var_.characterEffect1069ui_story == nil then
				arg_616_1.var_.characterEffect1069ui_story = var_619_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_7 = 0.034

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_7 and not isNil(var_619_6) then
				if arg_616_1.var_.characterEffect1069ui_story and not isNil(var_619_6) then
					arg_616_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_616_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_616_1.time_ - 0) / var_619_7)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_7 and arg_616_1.time_ < 0 + var_619_7 + arg_619_0 and not isNil(var_619_6) and arg_616_1.var_.characterEffect1069ui_story then
				arg_616_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_616_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_619_8 = 0
			local var_619_9 = 0.55

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_8 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_10 = arg_616_1:GetWordFromCfg(120011151)
				local var_619_11 = arg_616_1:FormatText(var_619_10.content)

				arg_616_1.text_.text = var_619_11

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_13 = 22 <= 0 and var_619_9 or var_619_9 * (utf8.len(var_619_11) / 22)

				if (22 <= 0 and var_619_9 or var_619_9 * (utf8.len(var_619_11) / 22)) > 0 and var_619_9 < var_619_13 then
					arg_616_1.talkMaxDuration = var_619_13

					if var_619_13 + var_619_8 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_13 + var_619_8
					end
				end

				arg_616_1.text_.text = var_619_11
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011151", "story_v_out_120011.awb") ~= 0 then
					local var_619_14 = manager.audio:GetVoiceLength("story_v_out_120011", "120011151", "story_v_out_120011.awb") / 1000

					if var_619_14 + var_619_8 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_14 + var_619_8
					end

					if var_619_10.prefab_name ~= "" and arg_616_1.actors_[var_619_10.prefab_name] ~= nil then
						local var_619_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_10.prefab_name].transform, "story_v_out_120011", "120011151", "story_v_out_120011.awb")

						arg_616_1:RecordAudio("120011151", var_619_15)
						arg_616_1:RecordAudio("120011151", var_619_15)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_120011", "120011151", "story_v_out_120011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_120011", "120011151", "story_v_out_120011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_16 = math.max(var_619_9, arg_616_1.talkMaxDuration)

			if var_619_8 <= arg_616_1.time_ and arg_616_1.time_ < var_619_8 + var_619_16 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_8) / var_619_16

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_8 + var_619_16 and arg_616_1.time_ < var_619_8 + var_619_16 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_616_1:InitPlayNodeList()
	end,
	Play120011152 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 120011152
		arg_620_1.duration_ = 3.8

		local var_620_0 = {
			zh = 2,
			ja = 3.8
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play120011153(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(arg_620_1.actors_["1084ui_story"]) and arg_620_1.var_.characterEffect1084ui_story == nil then
				arg_620_1.var_.characterEffect1084ui_story = arg_620_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_0 = 0.2

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_0 and not isNil(arg_620_1.actors_["1084ui_story"]) then
				if arg_620_1.var_.characterEffect1084ui_story and not isNil(arg_620_1.actors_["1084ui_story"]) then
					arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_620_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_620_1.time_ - 0) / var_623_0)
				end
			end

			if arg_620_1.time_ >= 0 + var_623_0 and arg_620_1.time_ < 0 + var_623_0 + arg_623_0 and not isNil(arg_620_1.actors_["1084ui_story"]) and arg_620_1.var_.characterEffect1084ui_story then
				arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_620_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_623_1 = arg_620_1.actors_["1069ui_story"]

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(var_623_1) and arg_620_1.var_.characterEffect1069ui_story == nil then
				arg_620_1.var_.characterEffect1069ui_story = var_623_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_2 = 0.2

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_2 and not isNil(var_623_1) then
				if arg_620_1.var_.characterEffect1069ui_story and not isNil(var_623_1) then
					arg_620_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= 0 + var_623_2 and arg_620_1.time_ < 0 + var_623_2 + arg_623_0 and not isNil(var_623_1) and arg_620_1.var_.characterEffect1069ui_story then
				arg_620_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_623_4 = 0
			local var_623_5 = 0.275

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_4 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_6 = arg_620_1:GetWordFromCfg(120011152)
				local var_623_7 = arg_620_1:FormatText(var_623_6.content)

				arg_620_1.text_.text = var_623_7

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_9 = 11 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 11)

				if (11 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 11)) > 0 and var_623_5 < var_623_9 then
					arg_620_1.talkMaxDuration = var_623_9

					if var_623_9 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_9 + var_623_4
					end
				end

				arg_620_1.text_.text = var_623_7
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011152", "story_v_out_120011.awb") ~= 0 then
					local var_623_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011152", "story_v_out_120011.awb") / 1000

					if var_623_10 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_10 + var_623_4
					end

					if var_623_6.prefab_name ~= "" and arg_620_1.actors_[var_623_6.prefab_name] ~= nil then
						local var_623_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_6.prefab_name].transform, "story_v_out_120011", "120011152", "story_v_out_120011.awb")

						arg_620_1:RecordAudio("120011152", var_623_11)
						arg_620_1:RecordAudio("120011152", var_623_11)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_120011", "120011152", "story_v_out_120011.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_120011", "120011152", "story_v_out_120011.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_12 = math.max(var_623_5, arg_620_1.talkMaxDuration)

			if var_623_4 <= arg_620_1.time_ and arg_620_1.time_ < var_623_4 + var_623_12 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_4) / var_623_12

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_4 + var_623_12 and arg_620_1.time_ < var_623_4 + var_623_12 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play120011153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 120011153
		arg_624_1.duration_ = 7.4

		local var_624_0 = {
			zh = 7.4,
			ja = 4
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play120011154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_627_0 = 0
			local var_627_1 = 0.95

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_2 = arg_624_1:GetWordFromCfg(120011153)
				local var_627_3 = arg_624_1:FormatText(var_627_2.content)

				arg_624_1.text_.text = var_627_3

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 38 <= 0 and var_627_1 or var_627_1 * (utf8.len(var_627_3) / 38)

				if (38 <= 0 and var_627_1 or var_627_1 * (utf8.len(var_627_3) / 38)) > 0 and var_627_1 < var_627_5 then
					arg_624_1.talkMaxDuration = var_627_5

					if var_627_5 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_5 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_3
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011153", "story_v_out_120011.awb") ~= 0 then
					local var_627_6 = manager.audio:GetVoiceLength("story_v_out_120011", "120011153", "story_v_out_120011.awb") / 1000

					if var_627_6 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_6 + var_627_0
					end

					if var_627_2.prefab_name ~= "" and arg_624_1.actors_[var_627_2.prefab_name] ~= nil then
						local var_627_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_2.prefab_name].transform, "story_v_out_120011", "120011153", "story_v_out_120011.awb")

						arg_624_1:RecordAudio("120011153", var_627_7)
						arg_624_1:RecordAudio("120011153", var_627_7)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_120011", "120011153", "story_v_out_120011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_120011", "120011153", "story_v_out_120011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_8 and arg_624_1.time_ < var_627_0 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play120011154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 120011154
		arg_628_1.duration_ = 5.03

		local var_628_0 = {
			zh = 4.333,
			ja = 5.033
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play120011155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0.4

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_1 = arg_628_1:GetWordFromCfg(120011154)
				local var_631_2 = arg_628_1:FormatText(var_631_1.content)

				arg_628_1.text_.text = var_631_2

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_4 = 16 <= 0 and var_631_0 or var_631_0 * (utf8.len(var_631_2) / 16)

				if (16 <= 0 and var_631_0 or var_631_0 * (utf8.len(var_631_2) / 16)) > 0 and var_631_0 < var_631_4 then
					arg_628_1.talkMaxDuration = var_631_4

					if var_631_4 + 0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_4 + 0
					end
				end

				arg_628_1.text_.text = var_631_2
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011154", "story_v_out_120011.awb") ~= 0 then
					local var_631_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011154", "story_v_out_120011.awb") / 1000

					if var_631_5 + 0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_5 + 0
					end

					if var_631_1.prefab_name ~= "" and arg_628_1.actors_[var_631_1.prefab_name] ~= nil then
						local var_631_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_1.prefab_name].transform, "story_v_out_120011", "120011154", "story_v_out_120011.awb")

						arg_628_1:RecordAudio("120011154", var_631_6)
						arg_628_1:RecordAudio("120011154", var_631_6)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_out_120011", "120011154", "story_v_out_120011.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_out_120011", "120011154", "story_v_out_120011.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_7 = math.max(var_631_0, arg_628_1.talkMaxDuration)

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_7 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - 0) / var_631_7

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= 0 + var_631_7 and arg_628_1.time_ < 0 + var_631_7 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play120011155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 120011155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play120011156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(arg_632_1.actors_["1069ui_story"]) and arg_632_1.var_.characterEffect1069ui_story == nil then
				arg_632_1.var_.characterEffect1069ui_story = arg_632_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_0 = 0.2

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 and not isNil(arg_632_1.actors_["1069ui_story"]) then
				if arg_632_1.var_.characterEffect1069ui_story and not isNil(arg_632_1.actors_["1069ui_story"]) then
					arg_632_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_632_1.time_ - 0) / var_635_0)
				end
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 and not isNil(arg_632_1.actors_["1069ui_story"]) and arg_632_1.var_.characterEffect1069ui_story then
				arg_632_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_635_1 = 0
			local var_635_2 = 0.925

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_3 = arg_632_1:FormatText(arg_632_1:GetWordFromCfg(120011155).content)

				arg_632_1.text_.text = var_635_3

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_5 = 37 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 37)

				if (37 <= 0 and var_635_2 or var_635_2 * (utf8.len(var_635_3) / 37)) > 0 and var_635_2 < var_635_5 then
					arg_632_1.talkMaxDuration = var_635_5

					if var_635_5 + var_635_1 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_5 + var_635_1
					end
				end

				arg_632_1.text_.text = var_635_3
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_6 = math.max(var_635_2, arg_632_1.talkMaxDuration)

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_6 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_1) / var_635_6

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_1 + var_635_6 and arg_632_1.time_ < var_635_1 + var_635_6 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play120011156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 120011156
		arg_636_1.duration_ = 1.47

		local var_636_0 = {
			zh = 1.466,
			ja = 0.999999999999
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play120011157(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 and not isNil(arg_636_1.actors_["1069ui_story"]) and arg_636_1.var_.characterEffect1069ui_story == nil then
				arg_636_1.var_.characterEffect1069ui_story = arg_636_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_0 = 0.2

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_0 and not isNil(arg_636_1.actors_["1069ui_story"]) then
				if arg_636_1.var_.characterEffect1069ui_story and not isNil(arg_636_1.actors_["1069ui_story"]) then
					arg_636_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= 0 + var_639_0 and arg_636_1.time_ < 0 + var_639_0 + arg_639_0 and not isNil(arg_636_1.actors_["1069ui_story"]) and arg_636_1.var_.characterEffect1069ui_story then
				arg_636_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_639_2 = 0
			local var_639_3 = 0.125

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_2 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_4 = arg_636_1:GetWordFromCfg(120011156)
				local var_639_5 = arg_636_1:FormatText(var_639_4.content)

				arg_636_1.text_.text = var_639_5

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_7 = 5 <= 0 and var_639_3 or var_639_3 * (utf8.len(var_639_5) / 5)

				if (5 <= 0 and var_639_3 or var_639_3 * (utf8.len(var_639_5) / 5)) > 0 and var_639_3 < var_639_7 then
					arg_636_1.talkMaxDuration = var_639_7

					if var_639_7 + var_639_2 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_7 + var_639_2
					end
				end

				arg_636_1.text_.text = var_639_5
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011156", "story_v_out_120011.awb") ~= 0 then
					local var_639_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011156", "story_v_out_120011.awb") / 1000

					if var_639_8 + var_639_2 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_8 + var_639_2
					end

					if var_639_4.prefab_name ~= "" and arg_636_1.actors_[var_639_4.prefab_name] ~= nil then
						local var_639_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_4.prefab_name].transform, "story_v_out_120011", "120011156", "story_v_out_120011.awb")

						arg_636_1:RecordAudio("120011156", var_639_9)
						arg_636_1:RecordAudio("120011156", var_639_9)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_out_120011", "120011156", "story_v_out_120011.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_out_120011", "120011156", "story_v_out_120011.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_10 = math.max(var_639_3, arg_636_1.talkMaxDuration)

			if var_639_2 <= arg_636_1.time_ and arg_636_1.time_ < var_639_2 + var_639_10 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_2) / var_639_10

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_2 + var_639_10 and arg_636_1.time_ < var_639_2 + var_639_10 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play120011157 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 120011157
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play120011158(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.var_.moveOldPos1084ui_story = arg_640_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_643_0 = 0.001

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_0 then
				arg_640_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_640_1.time_ - 0) / var_643_0)
				arg_640_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).z)
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles = arg_640_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_640_1.time_ >= 0 + var_643_0 and arg_640_1.time_ < 0 + var_643_0 + arg_643_0 then
				arg_640_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_640_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_640_1.actors_["1084ui_story"].transform.position).z)
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_640_1.actors_["1084ui_story"].transform.localEulerAngles = arg_640_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_643_1 = arg_640_1.actors_["1069ui_story"].transform

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.var_.moveOldPos1069ui_story = var_643_1.localPosition
			end

			local var_643_2 = 0.001

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_2 then
				var_643_1.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_640_1.time_ - 0) / var_643_2)
				var_643_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_643_1.position).x, (manager.ui.mainCamera.transform.position - var_643_1.position).y, (manager.ui.mainCamera.transform.position - var_643_1.position).z)
				var_643_1.localEulerAngles.z = 0
				var_643_1.localEulerAngles.x = 0
				var_643_1.localEulerAngles = var_643_1.localEulerAngles
			end

			if arg_640_1.time_ >= 0 + var_643_2 and arg_640_1.time_ < 0 + var_643_2 + arg_643_0 then
				var_643_1.localPosition = Vector3.New(0, 100, 0)
				var_643_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_643_1.position).x, (manager.ui.mainCamera.transform.position - var_643_1.position).y, (manager.ui.mainCamera.transform.position - var_643_1.position).z)
				var_643_1.localEulerAngles.z = 0
				var_643_1.localEulerAngles.x = 0
				var_643_1.localEulerAngles = var_643_1.localEulerAngles
			end

			local var_643_3 = 0
			local var_643_4 = 0.9

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= var_643_3 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, false)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_5 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(120011157).content)

				arg_640_1.text_.text = var_643_5

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_7 = 36 <= 0 and var_643_4 or var_643_4 * (utf8.len(var_643_5) / 36)

				if (36 <= 0 and var_643_4 or var_643_4 * (utf8.len(var_643_5) / 36)) > 0 and var_643_4 < var_643_7 then
					arg_640_1.talkMaxDuration = var_643_7

					if var_643_7 + var_643_3 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_7 + var_643_3
					end
				end

				arg_640_1.text_.text = var_643_5
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_8 = math.max(var_643_4, arg_640_1.talkMaxDuration)

			if var_643_3 <= arg_640_1.time_ and arg_640_1.time_ < var_643_3 + var_643_8 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_3) / var_643_8

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_3 + var_643_8 and arg_640_1.time_ < var_643_3 + var_643_8 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play120011158 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 120011158
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play120011159(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0.15

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				arg_644_1.leftNameTxt_.text = arg_644_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, true)
				arg_644_1.iconController_:SetSelectedState("hero")

				arg_644_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_644_1.callingController_:SetSelectedState("normal")

				arg_644_1.keyicon_.color = Color.New(1, 1, 1)
				arg_644_1.icon_.color = Color.New(1, 1, 1)

				local var_647_1 = arg_644_1:FormatText(arg_644_1:GetWordFromCfg(120011158).content)

				arg_644_1.text_.text = var_647_1

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_3 = 6 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 6)

				if (6 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 6)) > 0 and var_647_0 < var_647_3 then
					arg_644_1.talkMaxDuration = var_647_3

					if var_647_3 + 0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_3 + 0
					end
				end

				arg_644_1.text_.text = var_647_1
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_4 = math.max(var_647_0, arg_644_1.talkMaxDuration)

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_4 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - 0) / var_647_4

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= 0 + var_647_4 and arg_644_1.time_ < 0 + var_647_4 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play120011159 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 120011159
		arg_648_1.duration_ = 2.87

		local var_648_0 = {
			zh = 2.8,
			ja = 2.866
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play120011160(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1.var_.moveOldPos1069ui_story = arg_648_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_651_0 = 0.001

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_0 then
				arg_648_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPos1069ui_story, Vector3.New(0, -1, -6), (arg_648_1.time_ - 0) / var_651_0)
				arg_648_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).z)
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles = arg_648_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_648_1.time_ >= 0 + var_651_0 and arg_648_1.time_ < 0 + var_651_0 + arg_651_0 then
				arg_648_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_648_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_648_1.actors_["1069ui_story"].transform.position).z)
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_648_1.actors_["1069ui_story"].transform.localEulerAngles = arg_648_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_651_1 = arg_648_1.actors_["1069ui_story"]

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 and not isNil(var_651_1) and arg_648_1.var_.characterEffect1069ui_story == nil then
				arg_648_1.var_.characterEffect1069ui_story = var_651_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_651_2 = 0.2

			if 0 <= arg_648_1.time_ and arg_648_1.time_ < 0 + var_651_2 and not isNil(var_651_1) then
				if arg_648_1.var_.characterEffect1069ui_story and not isNil(var_651_1) then
					arg_648_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_648_1.time_ >= 0 + var_651_2 and arg_648_1.time_ < 0 + var_651_2 + arg_651_0 and not isNil(var_651_1) and arg_648_1.var_.characterEffect1069ui_story then
				arg_648_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= 0 + arg_651_0 then
				arg_648_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_651_4 = 0
			local var_651_5 = 0.225

			if 0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_4 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				arg_648_1.leftNameTxt_.text = arg_648_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_6 = arg_648_1:GetWordFromCfg(120011159)
				local var_651_7 = arg_648_1:FormatText(var_651_6.content)

				arg_648_1.text_.text = var_651_7

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_9 = 9 <= 0 and var_651_5 or var_651_5 * (utf8.len(var_651_7) / 9)

				if (9 <= 0 and var_651_5 or var_651_5 * (utf8.len(var_651_7) / 9)) > 0 and var_651_5 < var_651_9 then
					arg_648_1.talkMaxDuration = var_651_9

					if var_651_9 + var_651_4 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_9 + var_651_4
					end
				end

				arg_648_1.text_.text = var_651_7
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011159", "story_v_out_120011.awb") ~= 0 then
					local var_651_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011159", "story_v_out_120011.awb") / 1000

					if var_651_10 + var_651_4 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_10 + var_651_4
					end

					if var_651_6.prefab_name ~= "" and arg_648_1.actors_[var_651_6.prefab_name] ~= nil then
						local var_651_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_6.prefab_name].transform, "story_v_out_120011", "120011159", "story_v_out_120011.awb")

						arg_648_1:RecordAudio("120011159", var_651_11)
						arg_648_1:RecordAudio("120011159", var_651_11)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_out_120011", "120011159", "story_v_out_120011.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_out_120011", "120011159", "story_v_out_120011.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_12 = math.max(var_651_5, arg_648_1.talkMaxDuration)

			if var_651_4 <= arg_648_1.time_ and arg_648_1.time_ < var_651_4 + var_651_12 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_4) / var_651_12

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_4 + var_651_12 and arg_648_1.time_ < var_651_4 + var_651_12 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_648_1:InitPlayNodeList()
	end,
	Play120011160 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 120011160
		arg_652_1.duration_ = 5.23

		local var_652_0 = {
			zh = 1.999999999999,
			ja = 5.233
		}
		local var_652_1 = manager.audio:GetLocalizationFlag()

		if var_652_0[var_652_1] ~= nil then
			arg_652_1.duration_ = var_652_0[var_652_1]
		end

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play120011161(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if arg_652_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_655_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_652_1.stage_.transform)

				var_655_0.name = "1072ui_story"
				var_655_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_652_1.actors_["1072ui_story"] = var_655_0

				local var_655_1 = var_655_0:GetComponentInChildren(typeof(CharacterEffect))

				var_655_1.enabled = true

				local var_655_2 = GameObjectTools.GetOrAddComponent(var_655_0, typeof(DynamicBoneHelper))

				if var_655_2 then
					var_655_2:EnableDynamicBone(false)
				end

				arg_652_1:ShowWeapon(var_655_1.transform, false)

				arg_652_1.var_["1072ui_story" .. "Animator"] = var_655_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_652_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_652_1.var_["1072ui_story" .. "LipSync"] = var_655_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_655_3 = arg_652_1.actors_["1072ui_story"].transform

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.var_.moveOldPos1072ui_story = var_655_3.localPosition

				arg_652_1:ShowWeapon(arg_652_1.var_["1072ui_story" .. "Animator"].transform, false)
			end

			local var_655_4 = 0.001

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_4 then
				var_655_3.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_652_1.time_ - 0) / var_655_4)
				var_655_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_3.position).x, (manager.ui.mainCamera.transform.position - var_655_3.position).y, (manager.ui.mainCamera.transform.position - var_655_3.position).z)
				var_655_3.localEulerAngles.z = 0
				var_655_3.localEulerAngles.x = 0
				var_655_3.localEulerAngles = var_655_3.localEulerAngles
			end

			if arg_652_1.time_ >= 0 + var_655_4 and arg_652_1.time_ < 0 + var_655_4 + arg_655_0 then
				var_655_3.localPosition = Vector3.New(0, -0.71, -6)
				var_655_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_3.position).x, (manager.ui.mainCamera.transform.position - var_655_3.position).y, (manager.ui.mainCamera.transform.position - var_655_3.position).z)
				var_655_3.localEulerAngles.z = 0
				var_655_3.localEulerAngles.x = 0
				var_655_3.localEulerAngles = var_655_3.localEulerAngles
			end

			local var_655_5 = arg_652_1.actors_["1072ui_story"]

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 and not isNil(var_655_5) and arg_652_1.var_.characterEffect1072ui_story == nil then
				arg_652_1.var_.characterEffect1072ui_story = var_655_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_6 = 0.2

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_6 and not isNil(var_655_5) then
				if arg_652_1.var_.characterEffect1072ui_story and not isNil(var_655_5) then
					arg_652_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_652_1.time_ >= 0 + var_655_6 and arg_652_1.time_ < 0 + var_655_6 + arg_655_0 and not isNil(var_655_5) and arg_652_1.var_.characterEffect1072ui_story then
				arg_652_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_655_8 = arg_652_1.actors_["1069ui_story"].transform

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.var_.moveOldPos1069ui_story = var_655_8.localPosition
			end

			local var_655_9 = 0.001

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_9 then
				var_655_8.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_652_1.time_ - 0) / var_655_9)
				var_655_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_8.position).x, (manager.ui.mainCamera.transform.position - var_655_8.position).y, (manager.ui.mainCamera.transform.position - var_655_8.position).z)
				var_655_8.localEulerAngles.z = 0
				var_655_8.localEulerAngles.x = 0
				var_655_8.localEulerAngles = var_655_8.localEulerAngles
			end

			if arg_652_1.time_ >= 0 + var_655_9 and arg_652_1.time_ < 0 + var_655_9 + arg_655_0 then
				var_655_8.localPosition = Vector3.New(0, 100, 0)
				var_655_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_8.position).x, (manager.ui.mainCamera.transform.position - var_655_8.position).y, (manager.ui.mainCamera.transform.position - var_655_8.position).z)
				var_655_8.localEulerAngles.z = 0
				var_655_8.localEulerAngles.x = 0
				var_655_8.localEulerAngles = var_655_8.localEulerAngles
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_655_10 = 0
			local var_655_11 = 0.15

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_10 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				arg_652_1.leftNameTxt_.text = arg_652_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_12 = arg_652_1:GetWordFromCfg(120011160)
				local var_655_13 = arg_652_1:FormatText(var_655_12.content)

				arg_652_1.text_.text = var_655_13

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_15 = 6 <= 0 and var_655_11 or var_655_11 * (utf8.len(var_655_13) / 6)

				if (6 <= 0 and var_655_11 or var_655_11 * (utf8.len(var_655_13) / 6)) > 0 and var_655_11 < var_655_15 then
					arg_652_1.talkMaxDuration = var_655_15

					if var_655_15 + var_655_10 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_15 + var_655_10
					end
				end

				arg_652_1.text_.text = var_655_13
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011160", "story_v_out_120011.awb") ~= 0 then
					local var_655_16 = manager.audio:GetVoiceLength("story_v_out_120011", "120011160", "story_v_out_120011.awb") / 1000

					if var_655_16 + var_655_10 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_16 + var_655_10
					end

					if var_655_12.prefab_name ~= "" and arg_652_1.actors_[var_655_12.prefab_name] ~= nil then
						local var_655_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_652_1.actors_[var_655_12.prefab_name].transform, "story_v_out_120011", "120011160", "story_v_out_120011.awb")

						arg_652_1:RecordAudio("120011160", var_655_17)
						arg_652_1:RecordAudio("120011160", var_655_17)
					else
						arg_652_1:AudioAction("play", "voice", "story_v_out_120011", "120011160", "story_v_out_120011.awb")
					end

					arg_652_1:RecordHistoryTalkVoice("story_v_out_120011", "120011160", "story_v_out_120011.awb")
				end

				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_18 = math.max(var_655_11, arg_652_1.talkMaxDuration)

			if var_655_10 <= arg_652_1.time_ and arg_652_1.time_ < var_655_10 + var_655_18 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_10) / var_655_18

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_10 + var_655_18 and arg_652_1.time_ < var_655_10 + var_655_18 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_652_1:InitPlayNodeList()
	end,
	Play120011161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 120011161
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play120011162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(arg_656_1.actors_["1072ui_story"]) and arg_656_1.var_.characterEffect1072ui_story == nil then
				arg_656_1.var_.characterEffect1072ui_story = arg_656_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_0 = 0.2

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 and not isNil(arg_656_1.actors_["1072ui_story"]) then
				if arg_656_1.var_.characterEffect1072ui_story and not isNil(arg_656_1.actors_["1072ui_story"]) then
					arg_656_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_656_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_656_1.time_ - 0) / var_659_0)
				end
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 and not isNil(arg_656_1.actors_["1072ui_story"]) and arg_656_1.var_.characterEffect1072ui_story then
				arg_656_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_656_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_659_1 = 0
			local var_659_2 = 0.475

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, false)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_3 = arg_656_1:FormatText(arg_656_1:GetWordFromCfg(120011161).content)

				arg_656_1.text_.text = var_659_3

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_5 = 19 <= 0 and var_659_2 or var_659_2 * (utf8.len(var_659_3) / 19)

				if (19 <= 0 and var_659_2 or var_659_2 * (utf8.len(var_659_3) / 19)) > 0 and var_659_2 < var_659_5 then
					arg_656_1.talkMaxDuration = var_659_5

					if var_659_5 + var_659_1 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_5 + var_659_1
					end
				end

				arg_656_1.text_.text = var_659_3
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_6 = math.max(var_659_2, arg_656_1.talkMaxDuration)

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_6 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_1) / var_659_6

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_1 + var_659_6 and arg_656_1.time_ < var_659_1 + var_659_6 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play120011162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 120011162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play120011163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.var_.moveOldPos1072ui_story = arg_660_1.actors_["1072ui_story"].transform.localPosition

				arg_660_1:ShowWeapon(arg_660_1.var_["1072ui_story" .. "Animator"].transform, false)
			end

			local var_663_0 = 0.001

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_0 then
				arg_660_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_660_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_660_1.time_ - 0) / var_663_0)
				arg_660_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).z)
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles = arg_660_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_660_1.time_ >= 0 + var_663_0 and arg_660_1.time_ < 0 + var_663_0 + arg_663_0 then
				arg_660_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_660_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_660_1.actors_["1072ui_story"].transform.position).z)
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_660_1.actors_["1072ui_story"].transform.localEulerAngles = arg_660_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_663_1 = 0
			local var_663_2 = 1.2

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_3 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(120011162).content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 48 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 48)

				if (48 <= 0 and var_663_2 or var_663_2 * (utf8.len(var_663_3) / 48)) > 0 and var_663_2 < var_663_5 then
					arg_660_1.talkMaxDuration = var_663_5

					if var_663_5 + var_663_1 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_5 + var_663_1
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_6 = math.max(var_663_2, arg_660_1.talkMaxDuration)

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_6 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_1) / var_663_6

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_1 + var_663_6 and arg_660_1.time_ < var_663_1 + var_663_6 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_660_1:InitPlayNodeList()
	end,
	Play120011163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 120011163
		arg_664_1.duration_ = 9.6

		local var_664_0 = {
			zh = 2.8,
			ja = 9.6
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play120011164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 and not isNil(arg_664_1.actors_["1072ui_story"]) and arg_664_1.var_.characterEffect1072ui_story == nil then
				arg_664_1.var_.characterEffect1072ui_story = arg_664_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_0 = 0.2

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_0 and not isNil(arg_664_1.actors_["1072ui_story"]) then
				if arg_664_1.var_.characterEffect1072ui_story and not isNil(arg_664_1.actors_["1072ui_story"]) then
					arg_664_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_664_1.time_ >= 0 + var_667_0 and arg_664_1.time_ < 0 + var_667_0 + arg_667_0 and not isNil(arg_664_1.actors_["1072ui_story"]) and arg_664_1.var_.characterEffect1072ui_story then
				arg_664_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_667_2 = arg_664_1.actors_["1072ui_story"].transform

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.var_.moveOldPos1072ui_story = var_667_2.localPosition

				arg_664_1:ShowWeapon(arg_664_1.var_["1072ui_story" .. "Animator"].transform, false)
			end

			local var_667_3 = 0.001

			if 0 <= arg_664_1.time_ and arg_664_1.time_ < 0 + var_667_3 then
				var_667_2.localPosition = Vector3.Lerp(arg_664_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_664_1.time_ - 0) / var_667_3)
				var_667_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_667_2.position).x, (manager.ui.mainCamera.transform.position - var_667_2.position).y, (manager.ui.mainCamera.transform.position - var_667_2.position).z)
				var_667_2.localEulerAngles.z = 0
				var_667_2.localEulerAngles.x = 0
				var_667_2.localEulerAngles = var_667_2.localEulerAngles
			end

			if arg_664_1.time_ >= 0 + var_667_3 and arg_664_1.time_ < 0 + var_667_3 + arg_667_0 then
				var_667_2.localPosition = Vector3.New(0, -0.71, -6)
				var_667_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_667_2.position).x, (manager.ui.mainCamera.transform.position - var_667_2.position).y, (manager.ui.mainCamera.transform.position - var_667_2.position).z)
				var_667_2.localEulerAngles.z = 0
				var_667_2.localEulerAngles.x = 0
				var_667_2.localEulerAngles = var_667_2.localEulerAngles
			end

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_667_4 = 0
			local var_667_5 = 0.25

			if 0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_4 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				arg_664_1.leftNameTxt_.text = arg_664_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_6 = arg_664_1:GetWordFromCfg(120011163)
				local var_667_7 = arg_664_1:FormatText(var_667_6.content)

				arg_664_1.text_.text = var_667_7

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_9 = 10 <= 0 and var_667_5 or var_667_5 * (utf8.len(var_667_7) / 10)

				if (10 <= 0 and var_667_5 or var_667_5 * (utf8.len(var_667_7) / 10)) > 0 and var_667_5 < var_667_9 then
					arg_664_1.talkMaxDuration = var_667_9

					if var_667_9 + var_667_4 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_9 + var_667_4
					end
				end

				arg_664_1.text_.text = var_667_7
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011163", "story_v_out_120011.awb") ~= 0 then
					local var_667_10 = manager.audio:GetVoiceLength("story_v_out_120011", "120011163", "story_v_out_120011.awb") / 1000

					if var_667_10 + var_667_4 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_10 + var_667_4
					end

					if var_667_6.prefab_name ~= "" and arg_664_1.actors_[var_667_6.prefab_name] ~= nil then
						local var_667_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_6.prefab_name].transform, "story_v_out_120011", "120011163", "story_v_out_120011.awb")

						arg_664_1:RecordAudio("120011163", var_667_11)
						arg_664_1:RecordAudio("120011163", var_667_11)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_out_120011", "120011163", "story_v_out_120011.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_out_120011", "120011163", "story_v_out_120011.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_12 = math.max(var_667_5, arg_664_1.talkMaxDuration)

			if var_667_4 <= arg_664_1.time_ and arg_664_1.time_ < var_667_4 + var_667_12 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_4) / var_667_12

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_4 + var_667_12 and arg_664_1.time_ < var_667_4 + var_667_12 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_664_1:InitPlayNodeList()
	end,
	Play120011164 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 120011164
		arg_668_1.duration_ = 5

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play120011165(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 and not isNil(arg_668_1.actors_["1072ui_story"]) and arg_668_1.var_.characterEffect1072ui_story == nil then
				arg_668_1.var_.characterEffect1072ui_story = arg_668_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_0 = 0.2

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_0 and not isNil(arg_668_1.actors_["1072ui_story"]) then
				if arg_668_1.var_.characterEffect1072ui_story and not isNil(arg_668_1.actors_["1072ui_story"]) then
					arg_668_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_668_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_668_1.time_ - 0) / var_671_0)
				end
			end

			if arg_668_1.time_ >= 0 + var_671_0 and arg_668_1.time_ < 0 + var_671_0 + arg_671_0 and not isNil(arg_668_1.actors_["1072ui_story"]) and arg_668_1.var_.characterEffect1072ui_story then
				arg_668_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_668_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_671_1 = 0
			local var_671_2 = 0.875

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				arg_668_1.leftNameTxt_.text = arg_668_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, true)
				arg_668_1.iconController_:SetSelectedState("hero")

				arg_668_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_668_1.callingController_:SetSelectedState("normal")

				arg_668_1.keyicon_.color = Color.New(1, 1, 1)
				arg_668_1.icon_.color = Color.New(1, 1, 1)

				local var_671_3 = arg_668_1:FormatText(arg_668_1:GetWordFromCfg(120011164).content)

				arg_668_1.text_.text = var_671_3

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_5 = 37 <= 0 and var_671_2 or var_671_2 * (utf8.len(var_671_3) / 37)

				if (37 <= 0 and var_671_2 or var_671_2 * (utf8.len(var_671_3) / 37)) > 0 and var_671_2 < var_671_5 then
					arg_668_1.talkMaxDuration = var_671_5

					if var_671_5 + var_671_1 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_5 + var_671_1
					end
				end

				arg_668_1.text_.text = var_671_3
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)
				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_6 = math.max(var_671_2, arg_668_1.talkMaxDuration)

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_6 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_1) / var_671_6

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_1 + var_671_6 and arg_668_1.time_ < var_671_1 + var_671_6 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play120011165 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 120011165
		arg_672_1.duration_ = 4.4

		local var_672_0 = {
			zh = 3.533,
			ja = 4.4
		}
		local var_672_1 = manager.audio:GetLocalizationFlag()

		if var_672_0[var_672_1] ~= nil then
			arg_672_1.duration_ = var_672_0[var_672_1]
		end

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play120011166(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 and not isNil(arg_672_1.actors_["1072ui_story"]) and arg_672_1.var_.characterEffect1072ui_story == nil then
				arg_672_1.var_.characterEffect1072ui_story = arg_672_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_0 = 0.2

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_0 and not isNil(arg_672_1.actors_["1072ui_story"]) then
				if arg_672_1.var_.characterEffect1072ui_story and not isNil(arg_672_1.actors_["1072ui_story"]) then
					arg_672_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_672_1.time_ >= 0 + var_675_0 and arg_672_1.time_ < 0 + var_675_0 + arg_675_0 and not isNil(arg_672_1.actors_["1072ui_story"]) and arg_672_1.var_.characterEffect1072ui_story then
				arg_672_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_675_2 = 0
			local var_675_3 = 0.4

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_2 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				arg_672_1.leftNameTxt_.text = arg_672_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_4 = arg_672_1:GetWordFromCfg(120011165)
				local var_675_5 = arg_672_1:FormatText(var_675_4.content)

				arg_672_1.text_.text = var_675_5

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_7 = 16 <= 0 and var_675_3 or var_675_3 * (utf8.len(var_675_5) / 16)

				if (16 <= 0 and var_675_3 or var_675_3 * (utf8.len(var_675_5) / 16)) > 0 and var_675_3 < var_675_7 then
					arg_672_1.talkMaxDuration = var_675_7

					if var_675_7 + var_675_2 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_7 + var_675_2
					end
				end

				arg_672_1.text_.text = var_675_5
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011165", "story_v_out_120011.awb") ~= 0 then
					local var_675_8 = manager.audio:GetVoiceLength("story_v_out_120011", "120011165", "story_v_out_120011.awb") / 1000

					if var_675_8 + var_675_2 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_8 + var_675_2
					end

					if var_675_4.prefab_name ~= "" and arg_672_1.actors_[var_675_4.prefab_name] ~= nil then
						local var_675_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_4.prefab_name].transform, "story_v_out_120011", "120011165", "story_v_out_120011.awb")

						arg_672_1:RecordAudio("120011165", var_675_9)
						arg_672_1:RecordAudio("120011165", var_675_9)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_out_120011", "120011165", "story_v_out_120011.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_out_120011", "120011165", "story_v_out_120011.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_10 = math.max(var_675_3, arg_672_1.talkMaxDuration)

			if var_675_2 <= arg_672_1.time_ and arg_672_1.time_ < var_675_2 + var_675_10 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_2) / var_675_10

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_2 + var_675_10 and arg_672_1.time_ < var_675_2 + var_675_10 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play120011166 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 120011166
		arg_676_1.duration_ = 0.2

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"

			SetActive(arg_676_1.choicesGo_, true)

			for iter_677_0, iter_677_1 in ipairs(arg_676_1.choices_) do
				SetActive(iter_677_1.go, iter_677_0 <= 2)
			end

			arg_676_1.choices_[1].txt.text = arg_676_1:FormatText(StoryChoiceCfg[366].name)
			arg_676_1.choices_[2].txt.text = arg_676_1:FormatText(StoryChoiceCfg[367].name)
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play120011167(arg_676_1)
			end

			if arg_678_0 == 2 then
				arg_676_0:Play120011167(arg_676_1)
			end

			arg_676_1:RecordChoiceLog(120011166, 366, 367)
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 and not isNil(arg_676_1.actors_["1072ui_story"]) and arg_676_1.var_.characterEffect1072ui_story == nil then
				arg_676_1.var_.characterEffect1072ui_story = arg_676_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_0 = 0.2

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_0 and not isNil(arg_676_1.actors_["1072ui_story"]) then
				if arg_676_1.var_.characterEffect1072ui_story and not isNil(arg_676_1.actors_["1072ui_story"]) then
					arg_676_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_676_1.time_ - 0) / var_679_0)
				end
			end

			if arg_676_1.time_ >= 0 + var_679_0 and arg_676_1.time_ < 0 + var_679_0 + arg_679_0 and not isNil(arg_676_1.actors_["1072ui_story"]) and arg_676_1.var_.characterEffect1072ui_story then
				arg_676_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play120011167 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 120011167
		arg_680_1.duration_ = 9.7

		local var_680_0 = {
			zh = 9.266,
			ja = 9.7
		}
		local var_680_1 = manager.audio:GetLocalizationFlag()

		if var_680_0[var_680_1] ~= nil then
			arg_680_1.duration_ = var_680_0[var_680_1]
		end

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play120011168(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			if arg_680_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_683_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_680_1.stage_.transform)

				var_683_0.name = "1072ui_story"
				var_683_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_680_1.actors_["1072ui_story"] = var_683_0

				local var_683_1 = var_683_0:GetComponentInChildren(typeof(CharacterEffect))

				var_683_1.enabled = true

				local var_683_2 = GameObjectTools.GetOrAddComponent(var_683_0, typeof(DynamicBoneHelper))

				if var_683_2 then
					var_683_2:EnableDynamicBone(false)
				end

				arg_680_1:ShowWeapon(var_683_1.transform, false)

				arg_680_1.var_["1072ui_story" .. "Animator"] = var_683_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_680_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_680_1.var_["1072ui_story" .. "LipSync"] = var_683_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072actionlink/1072action462")
			end

			local var_683_3 = arg_680_1.actors_["1072ui_story"]

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 and not isNil(var_683_3) and arg_680_1.var_.characterEffect1072ui_story == nil then
				arg_680_1.var_.characterEffect1072ui_story = var_683_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_4 = 0.2

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_4 and not isNil(var_683_3) then
				if arg_680_1.var_.characterEffect1072ui_story and not isNil(var_683_3) then
					arg_680_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= 0 + var_683_4 and arg_680_1.time_ < 0 + var_683_4 + arg_683_0 and not isNil(var_683_3) and arg_680_1.var_.characterEffect1072ui_story then
				arg_680_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_683_6 = 0
			local var_683_7 = 1.05

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_6 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				arg_680_1.leftNameTxt_.text = arg_680_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_8 = arg_680_1:GetWordFromCfg(120011167)
				local var_683_9 = arg_680_1:FormatText(var_683_8.content)

				arg_680_1.text_.text = var_683_9

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_11 = 42 <= 0 and var_683_7 or var_683_7 * (utf8.len(var_683_9) / 42)

				if (42 <= 0 and var_683_7 or var_683_7 * (utf8.len(var_683_9) / 42)) > 0 and var_683_7 < var_683_11 then
					arg_680_1.talkMaxDuration = var_683_11

					if var_683_11 + var_683_6 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_11 + var_683_6
					end
				end

				arg_680_1.text_.text = var_683_9
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011167", "story_v_out_120011.awb") ~= 0 then
					local var_683_12 = manager.audio:GetVoiceLength("story_v_out_120011", "120011167", "story_v_out_120011.awb") / 1000

					if var_683_12 + var_683_6 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_12 + var_683_6
					end

					if var_683_8.prefab_name ~= "" and arg_680_1.actors_[var_683_8.prefab_name] ~= nil then
						local var_683_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_8.prefab_name].transform, "story_v_out_120011", "120011167", "story_v_out_120011.awb")

						arg_680_1:RecordAudio("120011167", var_683_13)
						arg_680_1:RecordAudio("120011167", var_683_13)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_out_120011", "120011167", "story_v_out_120011.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_out_120011", "120011167", "story_v_out_120011.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_14 = math.max(var_683_7, arg_680_1.talkMaxDuration)

			if var_683_6 <= arg_680_1.time_ and arg_680_1.time_ < var_683_6 + var_683_14 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_6) / var_683_14

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_6 + var_683_14 and arg_680_1.time_ < var_683_6 + var_683_14 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play120011168 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 120011168
		arg_684_1.duration_ = 9

		local var_684_0 = {
			zh = 6.066,
			ja = 9
		}
		local var_684_1 = manager.audio:GetLocalizationFlag()

		if var_684_0[var_684_1] ~= nil then
			arg_684_1.duration_ = var_684_0[var_684_1]
		end

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play120011169(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0.775

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= 0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, true)

				arg_684_1.leftNameTxt_.text = arg_684_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_1 = arg_684_1:GetWordFromCfg(120011168)
				local var_687_2 = arg_684_1:FormatText(var_687_1.content)

				arg_684_1.text_.text = var_687_2

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_4 = 31 <= 0 and var_687_0 or var_687_0 * (utf8.len(var_687_2) / 31)

				if (31 <= 0 and var_687_0 or var_687_0 * (utf8.len(var_687_2) / 31)) > 0 and var_687_0 < var_687_4 then
					arg_684_1.talkMaxDuration = var_687_4

					if var_687_4 + 0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_4 + 0
					end
				end

				arg_684_1.text_.text = var_687_2
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011168", "story_v_out_120011.awb") ~= 0 then
					local var_687_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011168", "story_v_out_120011.awb") / 1000

					if var_687_5 + 0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_5 + 0
					end

					if var_687_1.prefab_name ~= "" and arg_684_1.actors_[var_687_1.prefab_name] ~= nil then
						local var_687_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_1.prefab_name].transform, "story_v_out_120011", "120011168", "story_v_out_120011.awb")

						arg_684_1:RecordAudio("120011168", var_687_6)
						arg_684_1:RecordAudio("120011168", var_687_6)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_out_120011", "120011168", "story_v_out_120011.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_out_120011", "120011168", "story_v_out_120011.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_7 = math.max(var_687_0, arg_684_1.talkMaxDuration)

			if 0 <= arg_684_1.time_ and arg_684_1.time_ < 0 + var_687_7 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - 0) / var_687_7

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= 0 + var_687_7 and arg_684_1.time_ < 0 + var_687_7 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play120011169 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 120011169
		arg_688_1.duration_ = 4.5

		local var_688_0 = {
			zh = 3.866,
			ja = 4.5
		}
		local var_688_1 = manager.audio:GetLocalizationFlag()

		if var_688_0[var_688_1] ~= nil then
			arg_688_1.duration_ = var_688_0[var_688_1]
		end

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
			arg_688_1.auto_ = false
		end

		function arg_688_1.playNext_(arg_690_0)
			arg_688_1.onStoryFinished_()
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = 0.45

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				arg_688_1.leftNameTxt_.text = arg_688_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, false)
				arg_688_1.callingController_:SetSelectedState("normal")

				local var_691_1 = arg_688_1:GetWordFromCfg(120011169)
				local var_691_2 = arg_688_1:FormatText(var_691_1.content)

				arg_688_1.text_.text = var_691_2

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_4 = 18 <= 0 and var_691_0 or var_691_0 * (utf8.len(var_691_2) / 18)

				if (18 <= 0 and var_691_0 or var_691_0 * (utf8.len(var_691_2) / 18)) > 0 and var_691_0 < var_691_4 then
					arg_688_1.talkMaxDuration = var_691_4

					if var_691_4 + 0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_4 + 0
					end
				end

				arg_688_1.text_.text = var_691_2
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120011", "120011169", "story_v_out_120011.awb") ~= 0 then
					local var_691_5 = manager.audio:GetVoiceLength("story_v_out_120011", "120011169", "story_v_out_120011.awb") / 1000

					if var_691_5 + 0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_5 + 0
					end

					if var_691_1.prefab_name ~= "" and arg_688_1.actors_[var_691_1.prefab_name] ~= nil then
						local var_691_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_688_1.actors_[var_691_1.prefab_name].transform, "story_v_out_120011", "120011169", "story_v_out_120011.awb")

						arg_688_1:RecordAudio("120011169", var_691_6)
						arg_688_1:RecordAudio("120011169", var_691_6)
					else
						arg_688_1:AudioAction("play", "voice", "story_v_out_120011", "120011169", "story_v_out_120011.awb")
					end

					arg_688_1:RecordHistoryTalkVoice("story_v_out_120011", "120011169", "story_v_out_120011.awb")
				end

				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_7 = math.max(var_691_0, arg_688_1.talkMaxDuration)

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_7 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - 0) / var_691_7

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= 0 + var_691_7 and arg_688_1.time_ < 0 + var_691_7 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play120011072 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 120011072
		arg_692_1.duration_ = 5

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play120011073(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = 0.7

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, false)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_1 = arg_692_1:FormatText(arg_692_1:GetWordFromCfg(120011072).content)

				arg_692_1.text_.text = var_695_1

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_3 = 28 <= 0 and var_695_0 or var_695_0 * (utf8.len(var_695_1) / 28)

				if (28 <= 0 and var_695_0 or var_695_0 * (utf8.len(var_695_1) / 28)) > 0 and var_695_0 < var_695_3 then
					arg_692_1.talkMaxDuration = var_695_3

					if var_695_3 + 0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_3 + 0
					end
				end

				arg_692_1.text_.text = var_695_1
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)
				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_4 = math.max(var_695_0, arg_692_1.talkMaxDuration)

			if 0 <= arg_692_1.time_ and arg_692_1.time_ < 0 + var_695_4 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - 0) / var_695_4

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= 0 + var_695_4 and arg_692_1.time_ < 0 + var_695_4 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play120011073 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 120011073
		arg_696_1.duration_ = 5

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play120011074(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = 0.05

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, false)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_1 = arg_696_1:FormatText(arg_696_1:GetWordFromCfg(120011073).content)

				arg_696_1.text_.text = var_699_1

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_3 = 2 <= 0 and var_699_0 or var_699_0 * (utf8.len(var_699_1) / 2)

				if (2 <= 0 and var_699_0 or var_699_0 * (utf8.len(var_699_1) / 2)) > 0 and var_699_0 < var_699_3 then
					arg_696_1.talkMaxDuration = var_699_3

					if var_699_3 + 0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_3 + 0
					end
				end

				arg_696_1.text_.text = var_699_1
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)
				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_4 = math.max(var_699_0, arg_696_1.talkMaxDuration)

			if 0 <= arg_696_1.time_ and arg_696_1.time_ < 0 + var_699_4 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - 0) / var_699_4

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= 0 + var_699_4 and arg_696_1.time_ < 0 + var_699_4 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0101",
		"SofdecAsset/story/101200101.usm",
		"TextureConfig/Background/ST45",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/XH0102a"
	},
	voices = {
		"story_v_out_120011.awb"
	},
	skipMarkers = {
		120011001
	}
}
