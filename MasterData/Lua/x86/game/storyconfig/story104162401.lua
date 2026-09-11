return {
	Play416241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416241001
		arg_1_1.duration_ = 5.87

		local var_1_0 = {
			zh = 4.56666666666667,
			ja = 5.86666666666667
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
				arg_1_0:Play416241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST07b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_4_0.name = "ST07b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST07b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST07b

				arg_1_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST07b" then
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

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

			local var_4_15 = 1.86666666666667
			local var_4_16 = 0.3

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(416241001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 12 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 12)

				if (12 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 12)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241001", "story_v_out_416241.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_416241", "416241001", "story_v_out_416241.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_416241", "416241001", "story_v_out_416241.awb")

						arg_1_1:RecordAudio("416241001", var_4_23)
						arg_1_1:RecordAudio("416241001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416241", "416241001", "story_v_out_416241.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416241", "416241001", "story_v_out_416241.awb")
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
	Play416241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416241002
		arg_9_1.duration_ = 4.17

		local var_9_0 = {
			zh = 2.7,
			ja = 4.166
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
				arg_9_0:Play416241003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(416241002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 13 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 13)

				if (13 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 13)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241002", "story_v_out_416241.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241002", "story_v_out_416241.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_416241", "416241002", "story_v_out_416241.awb")

						arg_9_1:RecordAudio("416241002", var_12_6)
						arg_9_1:RecordAudio("416241002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416241", "416241002", "story_v_out_416241.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416241", "416241002", "story_v_out_416241.awb")
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
	Play416241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416241003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0.0249999999999998 < arg_13_1.time_ and arg_13_1.time_ <= 0.0249999999999998 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_16_1 = 0
			local var_16_2 = 1.025

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(416241003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)

				if (41 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 41)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play416241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416241004
		arg_17_1.duration_ = 7.03

		local var_17_0 = {
			zh = 6.1,
			ja = 7.033
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
				arg_17_0:Play416241005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1086"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "1086"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["1086"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["1086"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1086 == nil then
				arg_17_1.var_.actorSpriteComps1086 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1086 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								iter_20_3.color = Color.New(Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_3.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_3.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1086 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1086 = nil
			end

			local var_20_5 = arg_17_1.actors_["1086"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1086 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1086", 2)

				for iter_20_6 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_6)

					if var_20_6.name == "split_4" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_20_8 = 0
			local var_20_9 = 0.75

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(416241004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 30 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 30)

				if (30 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 30)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241004", "story_v_out_416241.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241004", "story_v_out_416241.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_416241", "416241004", "story_v_out_416241.awb")

						arg_17_1:RecordAudio("416241004", var_20_15)
						arg_17_1:RecordAudio("416241004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416241", "416241004", "story_v_out_416241.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416241", "416241004", "story_v_out_416241.awb")
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
				actorName = "1086",
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
	Play416241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416241005
		arg_21_1.duration_ = 5.43

		local var_21_0 = {
			zh = 4.5,
			ja = 5.433
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
				arg_21_0:Play416241006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1028"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "1028"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["1028"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["1028"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1028 == nil then
				arg_21_1.var_.actorSpriteComps1028 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1028 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_3.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_3.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1028 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1028 = nil
			end

			local var_24_5 = arg_21_1.actors_["1086"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1086 == nil then
				arg_21_1.var_.actorSpriteComps1086 = var_24_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_6 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.actorSpriteComps1086 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								iter_24_7.color = Color.New(Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_6), Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_6), (Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_6)))
							else
								local var_24_7 = Mathf.Lerp(iter_24_7.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_6)

								iter_24_7.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.actorSpriteComps1086 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_24_9 then
						iter_24_9.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1086 = nil
			end

			local var_24_8 = arg_21_1.actors_["1028"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1028 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1028", 4)

				for iter_24_10 = 0, var_24_8.childCount - 1 do
					local var_24_9 = var_24_8:GetChild(iter_24_10)

					if var_24_9.name == "split_6" or not string.find(var_24_9.name, "split") then
						var_24_9.gameObject:SetActive(true)
					else
						var_24_9.gameObject:SetActive(false)
					end
				end
			end

			local var_24_10 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_10 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_21_1.time_ - 0) / var_24_10)
			end

			if arg_21_1.time_ >= 0 + var_24_10 and arg_21_1.time_ < 0 + var_24_10 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_24_11 = 0
			local var_24_12 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_11 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(416241005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 22 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 22)

				if (22 <= 0 and var_24_12 or var_24_12 * (utf8.len(var_24_14) / 22)) > 0 and var_24_12 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_11
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241005", "story_v_out_416241.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241005", "story_v_out_416241.awb") / 1000

					if var_24_17 + var_24_11 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_11
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_416241", "416241005", "story_v_out_416241.awb")

						arg_21_1:RecordAudio("416241005", var_24_18)
						arg_21_1:RecordAudio("416241005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416241", "416241005", "story_v_out_416241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416241", "416241005", "story_v_out_416241.awb")
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
				actorName = "1028",
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
	Play416241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416241006
		arg_25_1.duration_ = 7.93

		local var_25_0 = {
			zh = 4.933,
			ja = 7.933
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
				arg_25_0:Play416241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1086"]) and arg_25_1.var_.actorSpriteComps1086 == nil then
				arg_25_1.var_.actorSpriteComps1086 = arg_25_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1086"]) then
				if arg_25_1.var_.actorSpriteComps1086 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1086"]) and arg_25_1.var_.actorSpriteComps1086 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps1086 = nil
			end

			local var_28_2 = arg_25_1.actors_["1028"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1028 == nil then
				arg_25_1.var_.actorSpriteComps1028 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps1028 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps1028 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps1028 = nil
			end

			local var_28_5 = arg_25_1.actors_["1086"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1086 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1086", 2)

				for iter_28_8 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_8)

					if var_28_6.name == "split_1" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_28_8 = 0
			local var_28_9 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(416241006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 27 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 27)

				if (27 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 27)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241006", "story_v_out_416241.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241006", "story_v_out_416241.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_416241", "416241006", "story_v_out_416241.awb")

						arg_25_1:RecordAudio("416241006", var_28_15)
						arg_25_1:RecordAudio("416241006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416241", "416241006", "story_v_out_416241.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416241", "416241006", "story_v_out_416241.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416241007
		arg_29_1.duration_ = 11.67

		local var_29_0 = {
			zh = 7.266,
			ja = 11.666
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
				arg_29_0:Play416241008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1028"]) and arg_29_1.var_.actorSpriteComps1028 == nil then
				arg_29_1.var_.actorSpriteComps1028 = arg_29_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1028"]) then
				if arg_29_1.var_.actorSpriteComps1028 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1028"]) and arg_29_1.var_.actorSpriteComps1028 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1028 = nil
			end

			local var_32_2 = arg_29_1.actors_["1086"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1086 == nil then
				arg_29_1.var_.actorSpriteComps1086 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps1086 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps1086 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1086 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(416241007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 26 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 26)

				if (26 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 26)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241007", "story_v_out_416241.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241007", "story_v_out_416241.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_416241", "416241007", "story_v_out_416241.awb")

						arg_29_1:RecordAudio("416241007", var_32_12)
						arg_29_1:RecordAudio("416241007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416241", "416241007", "story_v_out_416241.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416241", "416241007", "story_v_out_416241.awb")
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416241008
		arg_33_1.duration_ = 8.47

		local var_33_0 = {
			zh = 6.466,
			ja = 8.466
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
				arg_33_0:Play416241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1086"]) and arg_33_1.var_.actorSpriteComps1086 == nil then
				arg_33_1.var_.actorSpriteComps1086 = arg_33_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1086"]) then
				if arg_33_1.var_.actorSpriteComps1086 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1086"]) and arg_33_1.var_.actorSpriteComps1086 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1086 = nil
			end

			local var_36_2 = arg_33_1.actors_["1028"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1028 == nil then
				arg_33_1.var_.actorSpriteComps1028 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps1028 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps1028 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps1028 = nil
			end

			local var_36_5 = arg_33_1.actors_["1086"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1086 = var_36_5.localPosition
				var_36_5.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1086", 2)

				for iter_36_8 = 0, var_36_5.childCount - 1 do
					local var_36_6 = var_36_5:GetChild(iter_36_8)

					if var_36_6.name == "split_5" or not string.find(var_36_6.name, "split") then
						var_36_6.gameObject:SetActive(true)
					else
						var_36_6.gameObject:SetActive(false)
					end
				end
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1086, Vector3.New(-390, -404.2, -237.9), (arg_33_1.time_ - 0) / var_36_7)
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_36_8 = 0
			local var_36_9 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(416241008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 24 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 24)

				if (24 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 24)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241008", "story_v_out_416241.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241008", "story_v_out_416241.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_416241", "416241008", "story_v_out_416241.awb")

						arg_33_1:RecordAudio("416241008", var_36_15)
						arg_33_1:RecordAudio("416241008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416241", "416241008", "story_v_out_416241.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416241", "416241008", "story_v_out_416241.awb")
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
				actorName = "1086",
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
	Play416241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416241009
		arg_37_1.duration_ = 6.73

		local var_37_0 = {
			zh = 4.233,
			ja = 6.733
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
				arg_37_0:Play416241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["1033"] == nil then
				local var_40_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_40_0) then
					local var_40_1 = Object.Instantiate(var_40_0, arg_37_1.canvasGo_.transform)

					var_40_1.transform:SetSiblingIndex(1)

					var_40_1.name = "1033"
					var_40_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_["1033"] = var_40_1

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs((var_40_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_2 = arg_37_1.actors_["1033"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_3.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_3.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_5 = arg_37_1.actors_["1086"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1086 == nil then
				arg_37_1.var_.actorSpriteComps1086 = var_40_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.actorSpriteComps1086 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								iter_40_7.color = Color.New(Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_6), Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_6), (Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_6)))
							else
								local var_40_7 = Mathf.Lerp(iter_40_7.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_6)

								iter_40_7.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.actorSpriteComps1086 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_40_9 then
						iter_40_9.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1086 = nil
			end

			local var_40_8 = arg_37_1.actors_["1086"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1086 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1086", 7)

				for iter_40_10 = 0, var_40_8.childCount - 1 do
					local var_40_9 = var_40_8:GetChild(iter_40_10)

					if var_40_9.name == "" or not string.find(var_40_9.name, "split") then
						var_40_9.gameObject:SetActive(true)
					else
						var_40_9.gameObject:SetActive(false)
					end
				end
			end

			local var_40_10 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 then
				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_10)
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_11 = arg_37_1.actors_["1028"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1028 = var_40_11.localPosition
				var_40_11.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1028", 7)

				for iter_40_11 = 0, var_40_11.childCount - 1 do
					local var_40_12 = var_40_11:GetChild(iter_40_11)

					if var_40_12.name == "" or not string.find(var_40_12.name, "split") then
						var_40_12.gameObject:SetActive(true)
					else
						var_40_12.gameObject:SetActive(false)
					end
				end
			end

			local var_40_13 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_13 then
				var_40_11.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_13)
			end

			if arg_37_1.time_ >= 0 + var_40_13 and arg_37_1.time_ < 0 + var_40_13 + arg_40_0 then
				var_40_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_14 = arg_37_1.actors_["1033"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1033 = var_40_14.localPosition
				var_40_14.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1033", 3)

				for iter_40_12 = 0, var_40_14.childCount - 1 do
					local var_40_15 = var_40_14:GetChild(iter_40_12)

					if var_40_15.name == "" or not string.find(var_40_15.name, "split") then
						var_40_15.gameObject:SetActive(true)
					else
						var_40_15.gameObject:SetActive(false)
					end
				end
			end

			local var_40_16 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_16 then
				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_37_1.time_ - 0) / var_40_16)
			end

			if arg_37_1.time_ >= 0 + var_40_16 and arg_37_1.time_ < 0 + var_40_16 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(0, -420, 0)
			end

			local var_40_17 = 0
			local var_40_18 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(416241009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_22 = 26 <= 0 and var_40_18 or var_40_18 * (utf8.len(var_40_20) / 26)

				if (26 <= 0 and var_40_18 or var_40_18 * (utf8.len(var_40_20) / 26)) > 0 and var_40_18 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_17
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241009", "story_v_out_416241.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_416241", "416241009", "story_v_out_416241.awb") / 1000

					if var_40_23 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_17
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_416241", "416241009", "story_v_out_416241.awb")

						arg_37_1:RecordAudio("416241009", var_40_24)
						arg_37_1:RecordAudio("416241009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416241", "416241009", "story_v_out_416241.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416241", "416241009", "story_v_out_416241.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_18, arg_37_1.talkMaxDuration)

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_17) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_17 + var_40_25 and arg_37_1.time_ < var_40_17 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play416241010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416241010
		arg_41_1.duration_ = 5.77

		local var_41_0 = {
			zh = 3.5,
			ja = 5.766
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
				arg_41_0:Play416241011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 == nil then
				arg_41_1.var_.actorSpriteComps1028 = arg_41_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1028"]) then
				if arg_41_1.var_.actorSpriteComps1028 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1028"]) and arg_41_1.var_.actorSpriteComps1028 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1028 = nil
			end

			local var_44_2 = arg_41_1.actors_["1033"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1033 == nil then
				arg_41_1.var_.actorSpriteComps1033 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1033 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1033 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1033 = nil
			end

			local var_44_5 = arg_41_1.actors_["1033"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1033 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1033", 7)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_8 = arg_41_1.actors_["1028"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1028 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1028", 3)

				for iter_44_9 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_9)

					if var_44_9.name == "split_7" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_44_11 = 0
			local var_44_12 = 0.475

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(416241010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 19 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 19)

				if (19 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 19)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241010", "story_v_out_416241.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241010", "story_v_out_416241.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_416241", "416241010", "story_v_out_416241.awb")

						arg_41_1:RecordAudio("416241010", var_44_18)
						arg_41_1:RecordAudio("416241010", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416241", "416241010", "story_v_out_416241.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416241", "416241010", "story_v_out_416241.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_19 and arg_41_1.time_ < var_44_11 + var_44_19 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416241011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416241012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1028"]) and arg_45_1.var_.actorSpriteComps1028 == nil then
				arg_45_1.var_.actorSpriteComps1028 = arg_45_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1028"]) then
				if arg_45_1.var_.actorSpriteComps1028 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1028"]) and arg_45_1.var_.actorSpriteComps1028 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1028 = nil
			end

			local var_48_2 = arg_45_1.actors_["1028"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1028 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1028", 7)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_5 = 0
			local var_48_6 = 0.725

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(416241011).content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 29 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 29)

				if (29 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 29)) > 0 and var_48_6 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_10 and arg_45_1.time_ < var_48_5 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416241012
		arg_49_1.duration_ = 11.77

		local var_49_0 = {
			zh = 10.166,
			ja = 11.766
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
				arg_49_0:Play416241013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1028"]) and arg_49_1.var_.actorSpriteComps1028 == nil then
				arg_49_1.var_.actorSpriteComps1028 = arg_49_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1028"]) then
				if arg_49_1.var_.actorSpriteComps1028 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1028"]) and arg_49_1.var_.actorSpriteComps1028 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1028 = nil
			end

			local var_52_2 = arg_49_1.actors_["1028"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1028 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1028", 3)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "split_6" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_52_5 = 0
			local var_52_6 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(416241012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 38 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 38)

				if (38 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 38)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241012", "story_v_out_416241.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241012", "story_v_out_416241.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_416241", "416241012", "story_v_out_416241.awb")

						arg_49_1:RecordAudio("416241012", var_52_12)
						arg_49_1:RecordAudio("416241012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416241", "416241012", "story_v_out_416241.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416241", "416241012", "story_v_out_416241.awb")
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
				actorName = "1028",
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
	Play416241013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416241013
		arg_53_1.duration_ = 4.07

		local var_53_0 = {
			zh = 2.9,
			ja = 4.066
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
				arg_53_0:Play416241014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1028"]) and arg_53_1.var_.actorSpriteComps1028 == nil then
				arg_53_1.var_.actorSpriteComps1028 = arg_53_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1028"]) then
				if arg_53_1.var_.actorSpriteComps1028 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1028"]) and arg_53_1.var_.actorSpriteComps1028 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1028 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_2")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(416241013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)

				if (12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241013", "story_v_out_416241.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241013", "story_v_out_416241.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_416241", "416241013", "story_v_out_416241.awb")

						arg_53_1:RecordAudio("416241013", var_56_9)
						arg_53_1:RecordAudio("416241013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416241", "416241013", "story_v_out_416241.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416241", "416241013", "story_v_out_416241.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416241014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416241014
		arg_57_1.duration_ = 8.8

		local var_57_0 = {
			zh = 7.2,
			ja = 8.8
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
				arg_57_0:Play416241015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["10122"] == nil then
				local var_60_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_60_0) then
					local var_60_1 = Object.Instantiate(var_60_0, arg_57_1.canvasGo_.transform)

					var_60_1.transform:SetSiblingIndex(1)

					var_60_1.name = "10122"
					var_60_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_["10122"] = var_60_1

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs((var_60_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_2 = arg_57_1.actors_["10122"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10122 == nil then
				arg_57_1.var_.actorSpriteComps10122 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10122 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								iter_60_3.color = Color.New(Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_3.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_3.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10122 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_60_5 then
						iter_60_5.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10122 = nil
			end

			local var_60_5 = arg_57_1.actors_["10122"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10122 = var_60_5.localPosition
				var_60_5.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10122", 4)

				for iter_60_6 = 0, var_60_5.childCount - 1 do
					local var_60_6 = var_60_5:GetChild(iter_60_6)

					if var_60_6.name == "split_5" or not string.find(var_60_6.name, "split") then
						var_60_6.gameObject:SetActive(true)
					else
						var_60_6.gameObject:SetActive(false)
					end
				end
			end

			local var_60_7 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_57_1.time_ - 0) / var_60_7)
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(390, -380, -100)
			end

			local var_60_8 = arg_57_1.actors_["1028"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1028 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1028", 2)

				for iter_60_7 = 0, var_60_8.childCount - 1 do
					local var_60_9 = var_60_8:GetChild(iter_60_7)

					if var_60_9.name == "split_6" or not string.find(var_60_9.name, "split") then
						var_60_9.gameObject:SetActive(true)
					else
						var_60_9.gameObject:SetActive(false)
					end
				end
			end

			local var_60_10 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_10 then
				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_57_1.time_ - 0) / var_60_10)
			end

			if arg_57_1.time_ >= 0 + var_60_10 and arg_57_1.time_ < 0 + var_60_10 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_60_11 = 0
			local var_60_12 = 0.775

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:GetWordFromCfg(416241014)
				local var_60_14 = arg_57_1:FormatText(var_60_13.content)

				arg_57_1.text_.text = var_60_14

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 31 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 31)

				if (31 <= 0 and var_60_12 or var_60_12 * (utf8.len(var_60_14) / 31)) > 0 and var_60_12 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_14
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241014", "story_v_out_416241.awb") ~= 0 then
					local var_60_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241014", "story_v_out_416241.awb") / 1000

					if var_60_17 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_11
					end

					if var_60_13.prefab_name ~= "" and arg_57_1.actors_[var_60_13.prefab_name] ~= nil then
						local var_60_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_13.prefab_name].transform, "story_v_out_416241", "416241014", "story_v_out_416241.awb")

						arg_57_1:RecordAudio("416241014", var_60_18)
						arg_57_1:RecordAudio("416241014", var_60_18)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416241", "416241014", "story_v_out_416241.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416241", "416241014", "story_v_out_416241.awb")
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
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416241015
		arg_61_1.duration_ = 8.4

		local var_61_0 = {
			zh = 8.4,
			ja = 8.033
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
				arg_61_0:Play416241016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1028"]) and arg_61_1.var_.actorSpriteComps1028 == nil then
				arg_61_1.var_.actorSpriteComps1028 = arg_61_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1028"]) then
				if arg_61_1.var_.actorSpriteComps1028 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1028"]) and arg_61_1.var_.actorSpriteComps1028 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1028 = nil
			end

			local var_64_2 = arg_61_1.actors_["10122"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10122 == nil then
				arg_61_1.var_.actorSpriteComps10122 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10122 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10122 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10122 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.975

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(416241015)
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

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241015", "story_v_out_416241.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241015", "story_v_out_416241.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_416241", "416241015", "story_v_out_416241.awb")

						arg_61_1:RecordAudio("416241015", var_64_12)
						arg_61_1:RecordAudio("416241015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416241", "416241015", "story_v_out_416241.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416241", "416241015", "story_v_out_416241.awb")
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
	Play416241016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416241016
		arg_65_1.duration_ = 4.07

		local var_65_0 = {
			zh = 3.7,
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
				arg_65_0:Play416241017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10122"]) and arg_65_1.var_.actorSpriteComps10122 == nil then
				arg_65_1.var_.actorSpriteComps10122 = arg_65_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10122"]) then
				if arg_65_1.var_.actorSpriteComps10122 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10122"]) and arg_65_1.var_.actorSpriteComps10122 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10122 = nil
			end

			local var_68_2 = arg_65_1.actors_["1028"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1028 == nil then
				arg_65_1.var_.actorSpriteComps1028 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1028 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1028 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1028 = nil
			end

			local var_68_5 = arg_65_1.actors_["10122"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10122 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10122", 4)

				for iter_68_8 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_8)

					if var_68_6.name == "split_4" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(390, -380, -100)
			end

			local var_68_8 = 0
			local var_68_9 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(416241016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 12 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 12)

				if (12 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 12)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241016", "story_v_out_416241.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241016", "story_v_out_416241.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_416241", "416241016", "story_v_out_416241.awb")

						arg_65_1:RecordAudio("416241016", var_68_15)
						arg_65_1:RecordAudio("416241016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416241", "416241016", "story_v_out_416241.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416241", "416241016", "story_v_out_416241.awb")
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
				actorName = "10122",
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
	Play416241017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416241017
		arg_69_1.duration_ = 3.67

		local var_69_0 = {
			zh = 3.566,
			ja = 3.666
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
				arg_69_0:Play416241018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1033"]) and arg_69_1.var_.actorSpriteComps1033 == nil then
				arg_69_1.var_.actorSpriteComps1033 = arg_69_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1033"]) then
				if arg_69_1.var_.actorSpriteComps1033 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1033"]) and arg_69_1.var_.actorSpriteComps1033 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1033 = nil
			end

			local var_72_2 = arg_69_1.actors_["10122"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10122 == nil then
				arg_69_1.var_.actorSpriteComps10122 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10122 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_5.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10122 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10122 = nil
			end

			local var_72_5 = arg_69_1.actors_["1033"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 2)

				for iter_72_8 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_8)

					if var_72_6.name == "split_6" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_72_8 = arg_69_1.actors_["1028"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1028 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1028", 7)

				for iter_72_9 = 0, var_72_8.childCount - 1 do
					local var_72_9 = var_72_8:GetChild(iter_72_9)

					if var_72_9.name == "" or not string.find(var_72_9.name, "split") then
						var_72_9.gameObject:SetActive(true)
					else
						var_72_9.gameObject:SetActive(false)
					end
				end
			end

			local var_72_10 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_10 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 0) / var_72_10)
			end

			if arg_69_1.time_ >= 0 + var_72_10 and arg_69_1.time_ < 0 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_11 = 0
			local var_72_12 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(416241017)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 16 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 16)

				if (16 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 16)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241017", "story_v_out_416241.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241017", "story_v_out_416241.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_416241", "416241017", "story_v_out_416241.awb")

						arg_69_1:RecordAudio("416241017", var_72_18)
						arg_69_1:RecordAudio("416241017", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_416241", "416241017", "story_v_out_416241.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_416241", "416241017", "story_v_out_416241.awb")
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
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 416241018
		arg_73_1.duration_ = 4.23

		local var_73_0 = {
			zh = 2.933,
			ja = 4.233
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
				arg_73_0:Play416241019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10122"]) and arg_73_1.var_.actorSpriteComps10122 == nil then
				arg_73_1.var_.actorSpriteComps10122 = arg_73_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10122"]) then
				if arg_73_1.var_.actorSpriteComps10122 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10122"]) and arg_73_1.var_.actorSpriteComps10122 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10122 = nil
			end

			local var_76_2 = arg_73_1.actors_["1033"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1033 == nil then
				arg_73_1.var_.actorSpriteComps1033 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1033 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								iter_76_5.color = Color.New(Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_5.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_5.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1033 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1033 = nil
			end

			local var_76_5 = 0
			local var_76_6 = 0.275

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(416241018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 10 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 10)

				if (10 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 10)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241018", "story_v_out_416241.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241018", "story_v_out_416241.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_416241", "416241018", "story_v_out_416241.awb")

						arg_73_1:RecordAudio("416241018", var_76_12)
						arg_73_1:RecordAudio("416241018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_416241", "416241018", "story_v_out_416241.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_416241", "416241018", "story_v_out_416241.awb")
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

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play416241019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 416241019
		arg_77_1.duration_ = 6.8

		local var_77_0 = {
			zh = 5.5,
			ja = 6.8
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
				arg_77_0:Play416241020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1028"]) and arg_77_1.var_.actorSpriteComps1028 == nil then
				arg_77_1.var_.actorSpriteComps1028 = arg_77_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1028"]) then
				if arg_77_1.var_.actorSpriteComps1028 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1028"]) and arg_77_1.var_.actorSpriteComps1028 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1028 = nil
			end

			local var_80_2 = arg_77_1.actors_["10122"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10122 == nil then
				arg_77_1.var_.actorSpriteComps10122 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10122 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10122 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10122 = nil
			end

			local var_80_5 = arg_77_1.actors_["1028"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1028 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1028", 2)

				for iter_80_8 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_8)

					if var_80_6.name == "" or not string.find(var_80_6.name, "split") then
						var_80_6.gameObject:SetActive(true)
					else
						var_80_6.gameObject:SetActive(false)
					end
				end
			end

			local var_80_7 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_77_1.time_ - 0) / var_80_7)
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_80_8 = arg_77_1.actors_["1033"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 7)

				for iter_80_9 = 0, var_80_8.childCount - 1 do
					local var_80_9 = var_80_8:GetChild(iter_80_9)

					if var_80_9.name == "split_6" or not string.find(var_80_9.name, "split") then
						var_80_9.gameObject:SetActive(true)
					else
						var_80_9.gameObject:SetActive(false)
					end
				end
			end

			local var_80_10 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_10 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0) / var_80_10)
			end

			if arg_77_1.time_ >= 0 + var_80_10 and arg_77_1.time_ < 0 + var_80_10 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_11 = 0
			local var_80_12 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(416241019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 28 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 28)

				if (28 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 28)) > 0 and var_80_12 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241019", "story_v_out_416241.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241019", "story_v_out_416241.awb") / 1000

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_416241", "416241019", "story_v_out_416241.awb")

						arg_77_1:RecordAudio("416241019", var_80_18)
						arg_77_1:RecordAudio("416241019", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_416241", "416241019", "story_v_out_416241.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_416241", "416241019", "story_v_out_416241.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_19 and arg_77_1.time_ < var_80_11 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play416241020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416241020
		arg_81_1.duration_ = 5.43

		local var_81_0 = {
			zh = 3.9,
			ja = 5.433
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
				arg_81_0:Play416241021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(416241020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 17 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 17)

				if (17 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 17)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241020", "story_v_out_416241.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241020", "story_v_out_416241.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_416241", "416241020", "story_v_out_416241.awb")

						arg_81_1:RecordAudio("416241020", var_84_6)
						arg_81_1:RecordAudio("416241020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_416241", "416241020", "story_v_out_416241.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_416241", "416241020", "story_v_out_416241.awb")
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
	Play416241021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416241021
		arg_85_1.duration_ = 10.23

		local var_85_0 = {
			zh = 6.7,
			ja = 10.233
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
				arg_85_0:Play416241022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10122"]) and arg_85_1.var_.actorSpriteComps10122 == nil then
				arg_85_1.var_.actorSpriteComps10122 = arg_85_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10122"]) then
				if arg_85_1.var_.actorSpriteComps10122 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10122"]) and arg_85_1.var_.actorSpriteComps10122 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10122 = nil
			end

			local var_88_2 = arg_85_1.actors_["1028"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1028 == nil then
				arg_85_1.var_.actorSpriteComps1028 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1028 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1028 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1028 = nil
			end

			local var_88_5 = arg_85_1.actors_["10122"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10122 = var_88_5.localPosition
				var_88_5.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10122", 4)

				for iter_88_8 = 0, var_88_5.childCount - 1 do
					local var_88_6 = var_88_5:GetChild(iter_88_8)

					if var_88_6.name == "split_5" or not string.find(var_88_6.name, "split") then
						var_88_6.gameObject:SetActive(true)
					else
						var_88_6.gameObject:SetActive(false)
					end
				end
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_85_1.time_ - 0) / var_88_7)
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(390, -380, -100)
			end

			local var_88_8 = 0
			local var_88_9 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(416241021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 26 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 26)

				if (26 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 26)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241021", "story_v_out_416241.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241021", "story_v_out_416241.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_416241", "416241021", "story_v_out_416241.awb")

						arg_85_1:RecordAudio("416241021", var_88_15)
						arg_85_1:RecordAudio("416241021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416241", "416241021", "story_v_out_416241.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416241", "416241021", "story_v_out_416241.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416241022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416241022
		arg_89_1.duration_ = 8.03

		local var_89_0 = {
			zh = 5.366,
			ja = 8.033
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
				arg_89_0:Play416241023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1033"]) and arg_89_1.var_.actorSpriteComps1033 == nil then
				arg_89_1.var_.actorSpriteComps1033 = arg_89_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1033"]) then
				if arg_89_1.var_.actorSpriteComps1033 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								iter_92_1.color = Color.New(Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_0), Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_0), (Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_0)))
							else
								local var_92_1 = Mathf.Lerp(iter_92_1.color.r, 1, (arg_89_1.time_ - 0) / var_92_0)

								iter_92_1.color = Color.New(var_92_1, var_92_1, var_92_1)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1033"]) and arg_89_1.var_.actorSpriteComps1033 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1033 = nil
			end

			local var_92_2 = arg_89_1.actors_["10122"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10122 == nil then
				arg_89_1.var_.actorSpriteComps10122 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10122 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								iter_92_5.color = Color.New(Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_5.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_5.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10122 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_92_7 then
						iter_92_7.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10122 = nil
			end

			local var_92_5 = arg_89_1.actors_["1033"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1033 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1033", 2)

				for iter_92_8 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_8)

					if var_92_6.name == "split_1" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_92_8 = arg_89_1.actors_["1028"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1028 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1028", 7)

				for iter_92_9 = 0, var_92_8.childCount - 1 do
					local var_92_9 = var_92_8:GetChild(iter_92_9)

					if var_92_9.name == "" or not string.find(var_92_9.name, "split") then
						var_92_9.gameObject:SetActive(true)
					else
						var_92_9.gameObject:SetActive(false)
					end
				end
			end

			local var_92_10 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 then
				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_89_1.time_ - 0) / var_92_10)
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_11 = 0
			local var_92_12 = 0.7

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_13 = arg_89_1:GetWordFromCfg(416241022)
				local var_92_14 = arg_89_1:FormatText(var_92_13.content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 28 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 28)

				if (28 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 28)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241022", "story_v_out_416241.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_416241", "416241022", "story_v_out_416241.awb") / 1000

					if var_92_17 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_11
					end

					if var_92_13.prefab_name ~= "" and arg_89_1.actors_[var_92_13.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_13.prefab_name].transform, "story_v_out_416241", "416241022", "story_v_out_416241.awb")

						arg_89_1:RecordAudio("416241022", var_92_18)
						arg_89_1:RecordAudio("416241022", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416241", "416241022", "story_v_out_416241.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416241", "416241022", "story_v_out_416241.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_19 and arg_89_1.time_ < var_92_11 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play416241023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416241023
		arg_93_1.duration_ = 6.07

		local var_93_0 = {
			zh = 6.066,
			ja = 4.433
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
				arg_93_0:Play416241024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10122"]) and arg_93_1.var_.actorSpriteComps10122 == nil then
				arg_93_1.var_.actorSpriteComps10122 = arg_93_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10122"]) then
				if arg_93_1.var_.actorSpriteComps10122 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 1, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10122"]) and arg_93_1.var_.actorSpriteComps10122 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10122 = nil
			end

			local var_96_2 = arg_93_1.actors_["1033"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1033 == nil then
				arg_93_1.var_.actorSpriteComps1033 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1033 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								iter_96_5.color = Color.New(Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_5.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_5.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1033 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_96_7 then
						iter_96_7.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1033 = nil
			end

			local var_96_5 = arg_93_1.actors_["10122"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10122 = var_96_5.localPosition
				var_96_5.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10122", 4)

				for iter_96_8 = 0, var_96_5.childCount - 1 do
					local var_96_6 = var_96_5:GetChild(iter_96_8)

					if var_96_6.name == "split_4" or not string.find(var_96_6.name, "split") then
						var_96_6.gameObject:SetActive(true)
					else
						var_96_6.gameObject:SetActive(false)
					end
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_93_1.time_ - 0) / var_96_7)
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(390, -380, -100)
			end

			local var_96_8 = 0
			local var_96_9 = 0.4

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(416241023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 16 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 16)

				if (16 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 16)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241023", "story_v_out_416241.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241023", "story_v_out_416241.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_416241", "416241023", "story_v_out_416241.awb")

						arg_93_1:RecordAudio("416241023", var_96_15)
						arg_93_1:RecordAudio("416241023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416241", "416241023", "story_v_out_416241.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416241", "416241023", "story_v_out_416241.awb")
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
				actorName = "10122",
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
	Play416241024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416241024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play416241025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1033 = arg_97_1.actors_["1033"].transform.localPosition
				arg_97_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1033", 7)

				for iter_100_0 = 0, arg_97_1.actors_["1033"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["1033"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_2 = arg_97_1.actors_["10122"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10122 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10122", 7)

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
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_97_1.time_ and arg_97_1.time_ <= 0.034 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_139", "se_story_139_bed", "")
			end

			local var_100_6 = 0
			local var_100_7 = 1.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(416241024).content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 53 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 53)

				if (53 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 53)) > 0 and var_100_7 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_11 and arg_97_1.time_ < var_100_6 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10122",
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
	Play416241025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416241025
		arg_101_1.duration_ = 11.03

		local var_101_0 = {
			zh = 8.433,
			ja = 11.033
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
				arg_101_0:Play416241026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.bgs_.ST10 == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_104_0.name = "ST10"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.ST10 = var_104_0
			end

			if 1.5 < arg_101_1.time_ and arg_101_1.time_ <= 1.5 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.ST10

				arg_101_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST10" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = 1.5

			if 1.5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_4 + 0.3 and arg_101_1.time_ < var_104_4 + 0.3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_5 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_6 = 1.5

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_5) / var_104_6)
				arg_101_1.mask_.color = var_104_7
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 then
				local var_104_8 = Color.New(0, 0, 0)

				var_104_8.a = 1
				arg_101_1.mask_.color = var_104_8
			end

			local var_104_9 = 1.5

			if 1.5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_10 = 2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 then
				local var_104_11 = Color.New(0, 0, 0)

				var_104_11.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_9) / var_104_10)
				arg_101_1.mask_.color = var_104_11
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 then
				local var_104_12 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_12.a = 0
				arg_101_1.mask_.color = var_104_12
			end

			local var_104_13 = arg_101_1.actors_["1033"]

			if 3.1 < arg_101_1.time_ and arg_101_1.time_ <= 3.1 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.actorSpriteComps1033 == nil then
				arg_101_1.var_.actorSpriteComps1033 = var_104_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_14 = 0.2

			if 3.1 <= arg_101_1.time_ and arg_101_1.time_ < 3.1 + var_104_14 and not isNil(var_104_13) then
				if arg_101_1.var_.actorSpriteComps1033 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 3.1) / var_104_14), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 3.1) / var_104_14), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 3.1) / var_104_14)))
							else
								local var_104_15 = Mathf.Lerp(iter_104_3.color.r, 1, (arg_101_1.time_ - 3.1) / var_104_14)

								iter_104_3.color = Color.New(var_104_15, var_104_15, var_104_15)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 3.1 + var_104_14 and arg_101_1.time_ < 3.1 + var_104_14 + arg_104_0 and not isNil(var_104_13) and arg_101_1.var_.actorSpriteComps1033 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1033 = nil
			end

			local var_104_16 = arg_101_1.actors_["1033"].transform

			if 3.1 < arg_101_1.time_ and arg_101_1.time_ <= 3.1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1033 = var_104_16.localPosition
				var_104_16.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1033", 3)

				for iter_104_6 = 0, var_104_16.childCount - 1 do
					local var_104_17 = var_104_16:GetChild(iter_104_6)

					if var_104_17.name == "" or not string.find(var_104_17.name, "split") then
						var_104_17.gameObject:SetActive(true)
					else
						var_104_17.gameObject:SetActive(false)
					end
				end
			end

			local var_104_18 = 0.001

			if 3.1 <= arg_101_1.time_ and arg_101_1.time_ < 3.1 + var_104_18 then
				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_101_1.time_ - 3.1) / var_104_18)
			end

			if arg_101_1.time_ >= 3.1 + var_104_18 and arg_101_1.time_ < 3.1 + var_104_18 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, -420, 0)
			end

			if 3.06666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 3.06666666666667 + arg_104_0 then
				local var_104_19 = arg_101_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_104_19 then
					arg_101_1.var_.alphaOldValue1033 = var_104_19.alpha
					arg_101_1.var_.characterEffect1033 = var_104_19
				end

				arg_101_1.var_.alphaOldValue1033 = 0
			end

			local var_104_20 = 0.233333333333333

			if 3.06666666666667 <= arg_101_1.time_ and arg_101_1.time_ < 3.06666666666667 + var_104_20 then
				if arg_101_1.var_.characterEffect1033 then
					arg_101_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_101_1.var_.alphaOldValue1033, 1, (arg_101_1.time_ - 3.06666666666667) / var_104_20)
				end
			end

			if arg_101_1.time_ >= 3.06666666666667 + var_104_20 and arg_101_1.time_ < 3.06666666666667 + var_104_20 + arg_104_0 and arg_101_1.var_.characterEffect1033 then
				arg_101_1.var_.characterEffect1033.alpha = 1
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_21 = 3.5
			local var_104_22 = 0.6

			if 3.5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_23 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_23:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(416241025)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_27 = 24 <= 0 and var_104_22 or var_104_22 * (utf8.len(var_104_25) / 24)

				if (24 <= 0 and var_104_22 or var_104_22 * (utf8.len(var_104_25) / 24)) > 0 and var_104_22 < var_104_27 then
					arg_101_1.talkMaxDuration = var_104_27
					var_104_21 = var_104_21 + 0.3

					if var_104_27 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_27 + var_104_21
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241025", "story_v_out_416241.awb") ~= 0 then
					local var_104_28 = manager.audio:GetVoiceLength("story_v_out_416241", "416241025", "story_v_out_416241.awb") / 1000

					if var_104_28 + var_104_21 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_21
					end

					if var_104_24.prefab_name ~= "" and arg_101_1.actors_[var_104_24.prefab_name] ~= nil then
						local var_104_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_24.prefab_name].transform, "story_v_out_416241", "416241025", "story_v_out_416241.awb")

						arg_101_1:RecordAudio("416241025", var_104_29)
						arg_101_1:RecordAudio("416241025", var_104_29)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416241", "416241025", "story_v_out_416241.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416241", "416241025", "story_v_out_416241.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_30 = var_104_21 + 0.3
			local var_104_31 = math.max(var_104_22, arg_101_1.talkMaxDuration)

			if var_104_21 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_31 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_31

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_31 and arg_101_1.time_ < var_104_30 + var_104_31 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play416241026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416241026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416241027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1033"]) and arg_107_1.var_.actorSpriteComps1033 == nil then
				arg_107_1.var_.actorSpriteComps1033 = arg_107_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1033"]) then
				if arg_107_1.var_.actorSpriteComps1033 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1033"]) and arg_107_1.var_.actorSpriteComps1033 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1033 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.75

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(416241026).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)

				if (30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)) > 0 and var_110_3 < var_110_6 then
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
	Play416241027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416241027
		arg_111_1.duration_ = 10.37

		local var_111_0 = {
			zh = 4.733,
			ja = 10.366
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
				arg_111_0:Play416241028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1033"]) and arg_111_1.var_.actorSpriteComps1033 == nil then
				arg_111_1.var_.actorSpriteComps1033 = arg_111_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1033"]) then
				if arg_111_1.var_.actorSpriteComps1033 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1033"]) and arg_111_1.var_.actorSpriteComps1033 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1033 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.475

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(416241027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 19 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 19)

				if (19 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 19)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241027", "story_v_out_416241.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241027", "story_v_out_416241.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_416241", "416241027", "story_v_out_416241.awb")

						arg_111_1:RecordAudio("416241027", var_114_9)
						arg_111_1:RecordAudio("416241027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_416241", "416241027", "story_v_out_416241.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_416241", "416241027", "story_v_out_416241.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play416241028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416241028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play416241029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1033"]) and arg_115_1.var_.actorSpriteComps1033 == nil then
				arg_115_1.var_.actorSpriteComps1033 = arg_115_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1033"]) then
				if arg_115_1.var_.actorSpriteComps1033 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								iter_118_1.color = Color.New(Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_0), Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_0), (Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_0)))
							else
								local var_118_1 = Mathf.Lerp(iter_118_1.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_0)

								iter_118_1.color = Color.New(var_118_1, var_118_1, var_118_1)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1033"]) and arg_115_1.var_.actorSpriteComps1033 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1033 = nil
			end

			local var_118_2 = 0
			local var_118_3 = 0.8

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_4 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(416241028).content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 32 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 32)

				if (32 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_4) / 32)) > 0 and var_118_3 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_7 and arg_115_1.time_ < var_118_2 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play416241029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416241029
		arg_119_1.duration_ = 9.1

		local var_119_0 = {
			zh = 5.9,
			ja = 9.1
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
				arg_119_0:Play416241030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 == nil then
				arg_119_1.var_.actorSpriteComps1033 = arg_119_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1033"]) then
				if arg_119_1.var_.actorSpriteComps1033 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1033"]) and arg_119_1.var_.actorSpriteComps1033 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1033 = nil
			end

			local var_122_2 = 0
			local var_122_3 = 0.75

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(416241029)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 30 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 30)

				if (30 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 30)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241029", "story_v_out_416241.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241029", "story_v_out_416241.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_416241", "416241029", "story_v_out_416241.awb")

						arg_119_1:RecordAudio("416241029", var_122_9)
						arg_119_1:RecordAudio("416241029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416241", "416241029", "story_v_out_416241.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416241", "416241029", "story_v_out_416241.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416241030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416241030
		arg_123_1.duration_ = 8.33

		local var_123_0 = {
			zh = 4.233,
			ja = 8.333
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
				arg_123_0:Play416241031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(416241030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 24)

				if (24 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 24)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241030", "story_v_out_416241.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241030", "story_v_out_416241.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_416241", "416241030", "story_v_out_416241.awb")

						arg_123_1:RecordAudio("416241030", var_126_6)
						arg_123_1:RecordAudio("416241030", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_416241", "416241030", "story_v_out_416241.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_416241", "416241030", "story_v_out_416241.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play416241031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416241031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play416241032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1033"]) and arg_127_1.var_.actorSpriteComps1033 == nil then
				arg_127_1.var_.actorSpriteComps1033 = arg_127_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1033"]) then
				if arg_127_1.var_.actorSpriteComps1033 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1033"]) and arg_127_1.var_.actorSpriteComps1033 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1033 = nil
			end

			local var_130_2 = 0
			local var_130_3 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_4 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(416241031).content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 29 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 29)

				if (29 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 29)) > 0 and var_130_3 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_7 and arg_127_1.time_ < var_130_2 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play416241032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416241032
		arg_131_1.duration_ = 12.87

		local var_131_0 = {
			zh = 6.266,
			ja = 12.866
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
				arg_131_0:Play416241033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1033"]) and arg_131_1.var_.actorSpriteComps1033 == nil then
				arg_131_1.var_.actorSpriteComps1033 = arg_131_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1033"]) then
				if arg_131_1.var_.actorSpriteComps1033 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1033"]) and arg_131_1.var_.actorSpriteComps1033 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1033 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.75

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(416241032)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 30 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 30)

				if (30 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 30)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241032", "story_v_out_416241.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241032", "story_v_out_416241.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_416241", "416241032", "story_v_out_416241.awb")

						arg_131_1:RecordAudio("416241032", var_134_9)
						arg_131_1:RecordAudio("416241032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_416241", "416241032", "story_v_out_416241.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_416241", "416241032", "story_v_out_416241.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play416241033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416241033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play416241034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1033"]) and arg_135_1.var_.actorSpriteComps1033 == nil then
				arg_135_1.var_.actorSpriteComps1033 = arg_135_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1033"]) then
				if arg_135_1.var_.actorSpriteComps1033 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1033"]) and arg_135_1.var_.actorSpriteComps1033 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1033 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(416241033).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 20 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 20)

				if (20 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 20)) > 0 and var_138_3 < var_138_6 then
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
	Play416241034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416241034
		arg_139_1.duration_ = 3.4

		local var_139_0 = {
			zh = 3,
			ja = 3.4
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
				arg_139_0:Play416241035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1033"]) and arg_139_1.var_.actorSpriteComps1033 == nil then
				arg_139_1.var_.actorSpriteComps1033 = arg_139_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1033"]) then
				if arg_139_1.var_.actorSpriteComps1033 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1033"]) and arg_139_1.var_.actorSpriteComps1033 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1033 = nil
			end

			local var_142_2 = arg_139_1.actors_["1033"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1033 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1033", 3)

				for iter_142_4 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_4)

					if var_142_3.name == "split_2" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_139_1.time_ - 0) / var_142_4)
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_142_5 = 0
			local var_142_6 = 0.175

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(416241034)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 7 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 7)

				if (7 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 7)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241034", "story_v_out_416241.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241034", "story_v_out_416241.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_416241", "416241034", "story_v_out_416241.awb")

						arg_139_1:RecordAudio("416241034", var_142_12)
						arg_139_1:RecordAudio("416241034", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416241", "416241034", "story_v_out_416241.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416241", "416241034", "story_v_out_416241.awb")
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
				actorName = "1033",
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
	Play416241035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416241035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play416241036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1033"]) and arg_143_1.var_.actorSpriteComps1033 == nil then
				arg_143_1.var_.actorSpriteComps1033 = arg_143_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1033"]) then
				if arg_143_1.var_.actorSpriteComps1033 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1033"]) and arg_143_1.var_.actorSpriteComps1033 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1033 = nil
			end

			local var_146_2 = arg_143_1.actors_["1033"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1033 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1033", 7)

				for iter_146_4 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_4)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_146_5 = 0
			local var_146_6 = 1.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(416241035).content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 48 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_7) / 48)

				if (48 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_7) / 48)) > 0 and var_146_6 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_10 and arg_143_1.time_ < var_146_5 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416241036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 416241036
		arg_147_1.duration_ = 11.46

		local var_147_0 = {
			zh = 7.35581580186263,
			ja = 11.4558158018626
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
				arg_147_0:Play416241037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.ST12 == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_150_0.name = "ST12"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.ST12 = var_150_0
			end

			if 1.43333333333333 < arg_147_1.time_ and arg_147_1.time_ <= 1.43333333333333 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.ST12

				arg_147_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST12" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 1.43333333333333

			if 1.43333333333333 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			if arg_147_1.time_ >= var_150_4 + 0.3 and arg_147_1.time_ < var_150_4 + 0.3 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_5 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_6 = 1.43333333333333

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_5) / var_150_6)
				arg_147_1.mask_.color = var_150_7
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 then
				local var_150_8 = Color.New(0, 0, 0)

				var_150_8.a = 1
				arg_147_1.mask_.color = var_150_8
			end

			local var_150_9 = 1.43333333333333

			if 1.43333333333333 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_10 = 1.76666666666667

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 then
				local var_150_11 = Color.New(0, 0, 0)

				var_150_11.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_9) / var_150_10)
				arg_147_1.mask_.color = var_150_11
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 then
				local var_150_12 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_12.a = 0
				arg_147_1.mask_.color = var_150_12
			end

			local var_150_13 = arg_147_1.actors_["1028"]

			if 1.43333333333333 < arg_147_1.time_ and arg_147_1.time_ <= 1.43333333333333 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.actorSpriteComps1028 == nil then
				arg_147_1.var_.actorSpriteComps1028 = var_150_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_14 = 0.2

			if 1.43333333333333 <= arg_147_1.time_ and arg_147_1.time_ < 1.43333333333333 + var_150_14 and not isNil(var_150_13) then
				if arg_147_1.var_.actorSpriteComps1028 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								iter_150_3.color = Color.New(Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 1.43333333333333) / var_150_14), Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 1.43333333333333) / var_150_14), (Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 1.43333333333333) / var_150_14)))
							else
								local var_150_15 = Mathf.Lerp(iter_150_3.color.r, 1, (arg_147_1.time_ - 1.43333333333333) / var_150_14)

								iter_150_3.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 1.43333333333333 + var_150_14 and arg_147_1.time_ < 1.43333333333333 + var_150_14 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.actorSpriteComps1028 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_150_5 then
						iter_150_5.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1028 = nil
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_16 = 2.85581580186263
			local var_150_17 = 0.6

			if 2.85581580186263 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_18 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_18:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_6")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_19 = arg_147_1:GetWordFromCfg(416241036)
				local var_150_20 = arg_147_1:FormatText(var_150_19.content)

				arg_147_1.text_.text = var_150_20

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_22 = 24 <= 0 and var_150_17 or var_150_17 * (utf8.len(var_150_20) / 24)

				if (24 <= 0 and var_150_17 or var_150_17 * (utf8.len(var_150_20) / 24)) > 0 and var_150_17 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22
					var_150_16 = var_150_16 + 0.3

					if var_150_22 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_16
					end
				end

				arg_147_1.text_.text = var_150_20
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241036", "story_v_out_416241.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_416241", "416241036", "story_v_out_416241.awb") / 1000

					if var_150_23 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_16
					end

					if var_150_19.prefab_name ~= "" and arg_147_1.actors_[var_150_19.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_19.prefab_name].transform, "story_v_out_416241", "416241036", "story_v_out_416241.awb")

						arg_147_1:RecordAudio("416241036", var_150_24)
						arg_147_1:RecordAudio("416241036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_416241", "416241036", "story_v_out_416241.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_416241", "416241036", "story_v_out_416241.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = var_150_16 + 0.3
			local var_150_26 = math.max(var_150_17, arg_147_1.talkMaxDuration)

			if var_150_16 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_25) / var_150_26

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play416241037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416241037
		arg_153_1.duration_ = 12.3

		local var_153_0 = {
			zh = 7.766,
			ja = 12.3
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
				arg_153_0:Play416241038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.775

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_5")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(416241037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 31 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 31)

				if (31 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 31)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241037", "story_v_out_416241.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241037", "story_v_out_416241.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_416241", "416241037", "story_v_out_416241.awb")

						arg_153_1:RecordAudio("416241037", var_156_6)
						arg_153_1:RecordAudio("416241037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_416241", "416241037", "story_v_out_416241.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_416241", "416241037", "story_v_out_416241.awb")
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
	Play416241038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416241038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416241039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.95

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(416241038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 38 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 38)

				if (38 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 38)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play416241039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 416241039
		arg_161_1.duration_ = 7.67

		local var_161_0 = {
			zh = 3.466,
			ja = 7.666
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
				arg_161_0:Play416241040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.actors_["1019"] == nil then
				local var_164_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_164_0) then
					local var_164_1 = Object.Instantiate(var_164_0, arg_161_1.canvasGo_.transform)

					var_164_1.transform:SetSiblingIndex(1)

					var_164_1.name = "1019"
					var_164_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_161_1.actors_["1019"] = var_164_1

					if arg_161_1.isInRecall_ then
						for iter_164_0, iter_164_1 in ipairs((var_164_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_164_1.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_164_2 = arg_161_1.actors_["1019"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1019 == nil then
				arg_161_1.var_.actorSpriteComps1019 = var_164_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_3 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.actorSpriteComps1019 then
					for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_164_3 then
							if arg_161_1.isInRecall_ then
								iter_164_3.color = Color.New(Mathf.Lerp(iter_164_3.color.r, arg_161_1.hightColor1.r, (arg_161_1.time_ - 0) / var_164_3), Mathf.Lerp(iter_164_3.color.g, arg_161_1.hightColor1.g, (arg_161_1.time_ - 0) / var_164_3), (Mathf.Lerp(iter_164_3.color.b, arg_161_1.hightColor1.b, (arg_161_1.time_ - 0) / var_164_3)))
							else
								local var_164_4 = Mathf.Lerp(iter_164_3.color.r, 1, (arg_161_1.time_ - 0) / var_164_3)

								iter_164_3.color = Color.New(var_164_4, var_164_4, var_164_4)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.actorSpriteComps1019 then
				for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_164_5 then
						iter_164_5.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_161_1.var_.actorSpriteComps1019 = nil
			end

			local var_164_5 = arg_161_1.actors_["1019"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1019 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1019", 2)

				for iter_164_6 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_6)

					if var_164_6.name == "" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1019, Vector3.New(-400, -290, -300), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_164_8 = 0
			local var_164_9 = 0.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(416241039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 17 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 17)

				if (17 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 17)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241039", "story_v_out_416241.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241039", "story_v_out_416241.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_416241", "416241039", "story_v_out_416241.awb")

						arg_161_1:RecordAudio("416241039", var_164_15)
						arg_161_1:RecordAudio("416241039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_416241", "416241039", "story_v_out_416241.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_416241", "416241039", "story_v_out_416241.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
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
	Play416241040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 416241040
		arg_165_1.duration_ = 5.8

		local var_165_0 = {
			zh = 3.933,
			ja = 5.8
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
				arg_165_0:Play416241041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1028"]) and arg_165_1.var_.actorSpriteComps1028 == nil then
				arg_165_1.var_.actorSpriteComps1028 = arg_165_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1028"]) then
				if arg_165_1.var_.actorSpriteComps1028 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 1, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1028"]) and arg_165_1.var_.actorSpriteComps1028 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1028 = nil
			end

			local var_168_2 = arg_165_1.actors_["1019"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1019 == nil then
				arg_165_1.var_.actorSpriteComps1019 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1019 then
					for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_168_5 then
							if arg_165_1.isInRecall_ then
								iter_168_5.color = Color.New(Mathf.Lerp(iter_168_5.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_5.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_5.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_5.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_5.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1019 then
				for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_168_7 then
						iter_168_7.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1019 = nil
			end

			local var_168_5 = arg_165_1.actors_["1028"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1028 = var_168_5.localPosition
				var_168_5.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1028", 4)

				for iter_168_8 = 0, var_168_5.childCount - 1 do
					local var_168_6 = var_168_5:GetChild(iter_168_8)

					if var_168_6.name == "" or not string.find(var_168_6.name, "split") then
						var_168_6.gameObject:SetActive(true)
					else
						var_168_6.gameObject:SetActive(false)
					end
				end
			end

			local var_168_7 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				var_168_5.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_165_1.time_ - 0) / var_168_7)
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				var_168_5.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_168_8 = 0
			local var_168_9 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(416241040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 22 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 22)

				if (22 <= 0 and var_168_9 or var_168_9 * (utf8.len(var_168_11) / 22)) > 0 and var_168_9 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241040", "story_v_out_416241.awb") ~= 0 then
					local var_168_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241040", "story_v_out_416241.awb") / 1000

					if var_168_14 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_8
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_416241", "416241040", "story_v_out_416241.awb")

						arg_165_1:RecordAudio("416241040", var_168_15)
						arg_165_1:RecordAudio("416241040", var_168_15)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_416241", "416241040", "story_v_out_416241.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_416241", "416241040", "story_v_out_416241.awb")
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
				actorName = "1028",
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
	Play416241041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 416241041
		arg_169_1.duration_ = 12.1

		local var_169_0 = {
			zh = 8.1,
			ja = 12.1
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
				arg_169_0:Play416241042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.8

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(416241041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 32 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 32)

				if (32 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 32)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241041", "story_v_out_416241.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241041", "story_v_out_416241.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_416241", "416241041", "story_v_out_416241.awb")

						arg_169_1:RecordAudio("416241041", var_172_6)
						arg_169_1:RecordAudio("416241041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_416241", "416241041", "story_v_out_416241.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_416241", "416241041", "story_v_out_416241.awb")
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
	Play416241042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 416241042
		arg_173_1.duration_ = 16.8

		local var_173_0 = {
			zh = 9.6,
			ja = 16.8
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
				arg_173_0:Play416241043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1019"]) and arg_173_1.var_.actorSpriteComps1019 == nil then
				arg_173_1.var_.actorSpriteComps1019 = arg_173_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1019"]) then
				if arg_173_1.var_.actorSpriteComps1019 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1019"]) and arg_173_1.var_.actorSpriteComps1019 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps1019 = nil
			end

			local var_176_2 = arg_173_1.actors_["1028"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1028 == nil then
				arg_173_1.var_.actorSpriteComps1028 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps1028 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								iter_176_5.color = Color.New(Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_5.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_5.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps1028 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_176_7 then
						iter_176_7.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps1028 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 1.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:GetWordFromCfg(416241042)
				local var_176_8 = arg_173_1:FormatText(var_176_7.content)

				arg_173_1.text_.text = var_176_8

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 49 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 49)

				if (49 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 49)) > 0 and var_176_6 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_8
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241042", "story_v_out_416241.awb") ~= 0 then
					local var_176_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241042", "story_v_out_416241.awb") / 1000

					if var_176_11 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_5
					end

					if var_176_7.prefab_name ~= "" and arg_173_1.actors_[var_176_7.prefab_name] ~= nil then
						local var_176_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_7.prefab_name].transform, "story_v_out_416241", "416241042", "story_v_out_416241.awb")

						arg_173_1:RecordAudio("416241042", var_176_12)
						arg_173_1:RecordAudio("416241042", var_176_12)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_416241", "416241042", "story_v_out_416241.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_416241", "416241042", "story_v_out_416241.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_13 and arg_173_1.time_ < var_176_5 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play416241043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 416241043
		arg_177_1.duration_ = 7.63

		local var_177_0 = {
			zh = 5.266,
			ja = 7.633
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
				arg_177_0:Play416241044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1028"]) and arg_177_1.var_.actorSpriteComps1028 == nil then
				arg_177_1.var_.actorSpriteComps1028 = arg_177_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1028"]) then
				if arg_177_1.var_.actorSpriteComps1028 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1028"]) and arg_177_1.var_.actorSpriteComps1028 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps1028 = nil
			end

			local var_180_2 = arg_177_1.actors_["1019"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1019 == nil then
				arg_177_1.var_.actorSpriteComps1019 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps1019 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								iter_180_5.color = Color.New(Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_5.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_5.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps1019 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps1019 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.525

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_7 = arg_177_1:GetWordFromCfg(416241043)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 21 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 21)

				if (21 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 21)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241043", "story_v_out_416241.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241043", "story_v_out_416241.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_416241", "416241043", "story_v_out_416241.awb")

						arg_177_1:RecordAudio("416241043", var_180_12)
						arg_177_1:RecordAudio("416241043", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_416241", "416241043", "story_v_out_416241.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_416241", "416241043", "story_v_out_416241.awb")
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

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play416241044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 416241044
		arg_181_1.duration_ = 13.2

		local var_181_0 = {
			zh = 6.566,
			ja = 13.2
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
				arg_181_0:Play416241045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1019"]) and arg_181_1.var_.actorSpriteComps1019 == nil then
				arg_181_1.var_.actorSpriteComps1019 = arg_181_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1019"]) then
				if arg_181_1.var_.actorSpriteComps1019 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1019"]) and arg_181_1.var_.actorSpriteComps1019 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1019 = nil
			end

			local var_184_2 = arg_181_1.actors_["1028"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1028 == nil then
				arg_181_1.var_.actorSpriteComps1028 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1028 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1028 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1028 = nil
			end

			local var_184_5 = arg_181_1.actors_["1019"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1019 = var_184_5.localPosition
				var_184_5.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1019", 2)

				for iter_184_8 = 0, var_184_5.childCount - 1 do
					local var_184_6 = var_184_5:GetChild(iter_184_8)

					if var_184_6.name == "split_2" or not string.find(var_184_6.name, "split") then
						var_184_6.gameObject:SetActive(true)
					else
						var_184_6.gameObject:SetActive(false)
					end
				end
			end

			local var_184_7 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				var_184_5.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1019, Vector3.New(-400, -290, -300), (arg_181_1.time_ - 0) / var_184_7)
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				var_184_5.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_184_8 = 0
			local var_184_9 = 0.8

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(416241044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 32 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 32)

				if (32 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 32)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241044", "story_v_out_416241.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241044", "story_v_out_416241.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_416241", "416241044", "story_v_out_416241.awb")

						arg_181_1:RecordAudio("416241044", var_184_15)
						arg_181_1:RecordAudio("416241044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_416241", "416241044", "story_v_out_416241.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_416241", "416241044", "story_v_out_416241.awb")
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
				actorName = "1019",
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
	Play416241045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 416241045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play416241046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1019"]) and arg_185_1.var_.actorSpriteComps1019 == nil then
				arg_185_1.var_.actorSpriteComps1019 = arg_185_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1019"]) then
				if arg_185_1.var_.actorSpriteComps1019 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1019"]) and arg_185_1.var_.actorSpriteComps1019 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1019 = nil
			end

			local var_188_2 = arg_185_1.actors_["1028"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1028 = var_188_2.localPosition
				var_188_2.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1028", 4)

				for iter_188_4 = 0, var_188_2.childCount - 1 do
					local var_188_3 = var_188_2:GetChild(iter_188_4)

					if var_188_3.name == "split_4" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				var_188_2.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_185_1.time_ - 0) / var_188_4)
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				var_188_2.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_188_5 = 0
			local var_188_6 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_7 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(416241045).content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 20 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 20)

				if (20 <= 0 and var_188_6 or var_188_6 * (utf8.len(var_188_7) / 20)) > 0 and var_188_6 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_10 and arg_185_1.time_ < var_188_5 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 416241046
		arg_189_1.duration_ = 7.9

		local var_189_0 = {
			zh = 5.6,
			ja = 7.9
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
				arg_189_0:Play416241047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1028"]) and arg_189_1.var_.actorSpriteComps1028 == nil then
				arg_189_1.var_.actorSpriteComps1028 = arg_189_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1028"]) then
				if arg_189_1.var_.actorSpriteComps1028 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1028"]) and arg_189_1.var_.actorSpriteComps1028 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1028 = nil
			end

			local var_192_2 = arg_189_1.actors_["1028"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1028 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1028", 4)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "split_6" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1028, Vector3.New(390, -402.7, -156.1), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(390, -402.7, -156.1)
			end

			local var_192_5 = 0
			local var_192_6 = 0.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(416241046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 26 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 26)

				if (26 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 26)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241046", "story_v_out_416241.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241046", "story_v_out_416241.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_416241", "416241046", "story_v_out_416241.awb")

						arg_189_1:RecordAudio("416241046", var_192_12)
						arg_189_1:RecordAudio("416241046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_416241", "416241046", "story_v_out_416241.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_416241", "416241046", "story_v_out_416241.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416241047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 416241047
		arg_193_1.duration_ = 3.4

		local var_193_0 = {
			zh = 2.833,
			ja = 3.4
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
				arg_193_0:Play416241048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1019"]) and arg_193_1.var_.actorSpriteComps1019 == nil then
				arg_193_1.var_.actorSpriteComps1019 = arg_193_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1019"]) then
				if arg_193_1.var_.actorSpriteComps1019 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 1, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1019"]) and arg_193_1.var_.actorSpriteComps1019 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1019 = nil
			end

			local var_196_2 = arg_193_1.actors_["1028"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1028 == nil then
				arg_193_1.var_.actorSpriteComps1028 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps1028 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_5.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_5.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps1028 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1028 = nil
			end

			local var_196_5 = arg_193_1.actors_["1019"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1019 = var_196_5.localPosition
				var_196_5.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1019", 2)

				for iter_196_8 = 0, var_196_5.childCount - 1 do
					local var_196_6 = var_196_5:GetChild(iter_196_8)

					if var_196_6.name == "split_1" or not string.find(var_196_6.name, "split") then
						var_196_6.gameObject:SetActive(true)
					else
						var_196_6.gameObject:SetActive(false)
					end
				end
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1019, Vector3.New(-400, -290, -300), (arg_193_1.time_ - 0) / var_196_7)
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_196_8 = 0
			local var_196_9 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(416241047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 14 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 14)

				if (14 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 14)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241047", "story_v_out_416241.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241047", "story_v_out_416241.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_416241", "416241047", "story_v_out_416241.awb")

						arg_193_1:RecordAudio("416241047", var_196_15)
						arg_193_1:RecordAudio("416241047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_416241", "416241047", "story_v_out_416241.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_416241", "416241047", "story_v_out_416241.awb")
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
				actorName = "1019",
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
	Play416241048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 416241048
		arg_197_1.duration_ = 7.47

		local var_197_0 = {
			zh = 7.466,
			ja = 6.7
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
				arg_197_0:Play416241049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1028"]) and arg_197_1.var_.actorSpriteComps1028 == nil then
				arg_197_1.var_.actorSpriteComps1028 = arg_197_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1028"]) then
				if arg_197_1.var_.actorSpriteComps1028 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_0), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_0), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_0)))
							else
								local var_200_1 = Mathf.Lerp(iter_200_1.color.r, 1, (arg_197_1.time_ - 0) / var_200_0)

								iter_200_1.color = Color.New(var_200_1, var_200_1, var_200_1)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1028"]) and arg_197_1.var_.actorSpriteComps1028 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps1028 = nil
			end

			local var_200_2 = arg_197_1.actors_["1019"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1019 == nil then
				arg_197_1.var_.actorSpriteComps1019 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1019 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								iter_200_5.color = Color.New(Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_5.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_5.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1019 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_200_7 then
						iter_200_7.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps1019 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 0.8

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:GetWordFromCfg(416241048)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 26 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 26)

				if (26 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 26)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241048", "story_v_out_416241.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241048", "story_v_out_416241.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_416241", "416241048", "story_v_out_416241.awb")

						arg_197_1:RecordAudio("416241048", var_200_12)
						arg_197_1:RecordAudio("416241048", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_416241", "416241048", "story_v_out_416241.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_416241", "416241048", "story_v_out_416241.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play416241049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 416241049
		arg_201_1.duration_ = 10.6

		local var_201_0 = {
			zh = 4.8,
			ja = 10.6
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
				arg_201_0:Play416241050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.675

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(416241049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 27 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 27)

				if (27 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 27)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241049", "story_v_out_416241.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241049", "story_v_out_416241.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_416241", "416241049", "story_v_out_416241.awb")

						arg_201_1:RecordAudio("416241049", var_204_6)
						arg_201_1:RecordAudio("416241049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_416241", "416241049", "story_v_out_416241.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_416241", "416241049", "story_v_out_416241.awb")
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
	Play416241050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 416241050
		arg_205_1.duration_ = 11.2

		local var_205_0 = {
			zh = 6.2,
			ja = 11.2
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
				arg_205_0:Play416241051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1019"]) and arg_205_1.var_.actorSpriteComps1019 == nil then
				arg_205_1.var_.actorSpriteComps1019 = arg_205_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1019"]) then
				if arg_205_1.var_.actorSpriteComps1019 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1019"]) and arg_205_1.var_.actorSpriteComps1019 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1019 = nil
			end

			local var_208_2 = arg_205_1.actors_["1028"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1028 == nil then
				arg_205_1.var_.actorSpriteComps1028 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1028 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1028 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_208_7 then
						iter_208_7.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps1028 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.75

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(416241050)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 30 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 30)

				if (30 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 30)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241050", "story_v_out_416241.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241050", "story_v_out_416241.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_416241", "416241050", "story_v_out_416241.awb")

						arg_205_1:RecordAudio("416241050", var_208_12)
						arg_205_1:RecordAudio("416241050", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_416241", "416241050", "story_v_out_416241.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_416241", "416241050", "story_v_out_416241.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_13 and arg_205_1.time_ < var_208_5 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play416241051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 416241051
		arg_209_1.duration_ = 9.63

		local var_209_0 = {
			zh = 6.3,
			ja = 9.633
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
				arg_209_0:Play416241052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_0 = arg_209_1.bgs_.ST12

				arg_209_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_1 = var_212_0:GetComponent("SpriteRenderer")

				if var_212_1 and var_212_1.sprite then
					local var_212_2 = 2 * (var_212_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_0.transform.localScale = Vector3.New(var_212_2 / var_212_1.sprite.bounds.size.y < var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x and var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x or var_212_2 / var_212_1.sprite.bounds.size.y, var_212_2 / var_212_1.sprite.bounds.size.y < var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x and var_212_2 * manager.ui.mainCameraCom_.aspect / var_212_1.sprite.bounds.size.x or var_212_2 / var_212_1.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "ST12" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_3 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= var_212_3 + 0.3 and arg_209_1.time_ < var_212_3 + 0.3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 2

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			local var_212_12 = arg_209_1.actors_["1028"].transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPos1028 = var_212_12.localPosition
				var_212_12.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1028", 7)

				for iter_212_2 = 0, var_212_12.childCount - 1 do
					local var_212_13 = var_212_12:GetChild(iter_212_2)

					if var_212_13.name == "" or not string.find(var_212_13.name, "split") then
						var_212_13.gameObject:SetActive(true)
					else
						var_212_13.gameObject:SetActive(false)
					end
				end
			end

			local var_212_14 = 0.001

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_14 then
				var_212_12.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_209_1.time_ - 2) / var_212_14)
			end

			if arg_209_1.time_ >= 2 + var_212_14 and arg_209_1.time_ < 2 + var_212_14 + arg_212_0 then
				var_212_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_15 = arg_209_1.actors_["1019"].transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPos1019 = var_212_15.localPosition
				var_212_15.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1019", 7)

				for iter_212_3 = 0, var_212_15.childCount - 1 do
					local var_212_16 = var_212_15:GetChild(iter_212_3)

					if var_212_16.name == "" or not string.find(var_212_16.name, "split") then
						var_212_16.gameObject:SetActive(true)
					else
						var_212_16.gameObject:SetActive(false)
					end
				end
			end

			local var_212_17 = 0.001

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_17 then
				var_212_15.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1019, Vector3.New(0, -2000, 0), (arg_209_1.time_ - 2) / var_212_17)
			end

			if arg_209_1.time_ >= 2 + var_212_17 and arg_209_1.time_ < 2 + var_212_17 + arg_212_0 then
				var_212_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_18 = arg_209_1.actors_["1019"].transform

			if 3.66666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 3.66666666666667 + arg_212_0 then
				arg_209_1.var_.moveOldPos1019 = var_212_18.localPosition
				var_212_18.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1019", 3)

				for iter_212_4 = 0, var_212_18.childCount - 1 do
					local var_212_19 = var_212_18:GetChild(iter_212_4)

					if var_212_19.name == "" or not string.find(var_212_19.name, "split") then
						var_212_19.gameObject:SetActive(true)
					else
						var_212_19.gameObject:SetActive(false)
					end
				end
			end

			local var_212_20 = 0.001

			if 3.66666666666667 <= arg_209_1.time_ and arg_209_1.time_ < 3.66666666666667 + var_212_20 then
				var_212_18.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1019, Vector3.New(0, -290, -300), (arg_209_1.time_ - 3.66666666666667) / var_212_20)
			end

			if arg_209_1.time_ >= 3.66666666666667 + var_212_20 and arg_209_1.time_ < 3.66666666666667 + var_212_20 + arg_212_0 then
				var_212_18.localPosition = Vector3.New(0, -290, -300)
			end

			if 3.66666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 3.66666666666667 + arg_212_0 then
				local var_212_21 = arg_209_1.actors_["1019"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_21 then
					arg_209_1.var_.alphaOldValue1019 = var_212_21.alpha
					arg_209_1.var_.characterEffect1019 = var_212_21
				end

				arg_209_1.var_.alphaOldValue1019 = 0
			end

			local var_212_22 = 0.2

			if 3.66666666666667 <= arg_209_1.time_ and arg_209_1.time_ < 3.66666666666667 + var_212_22 then
				if arg_209_1.var_.characterEffect1019 then
					arg_209_1.var_.characterEffect1019.alpha = Mathf.Lerp(arg_209_1.var_.alphaOldValue1019, 1, (arg_209_1.time_ - 3.66666666666667) / var_212_22)
				end
			end

			if arg_209_1.time_ >= 3.66666666666667 + var_212_22 and arg_209_1.time_ < 3.66666666666667 + var_212_22 + arg_212_0 and arg_209_1.var_.characterEffect1019 then
				arg_209_1.var_.characterEffect1019.alpha = 1
			end

			local var_212_23 = arg_209_1.actors_["1019"]

			if 3.66666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 3.66666666666667 + arg_212_0 and not isNil(var_212_23) and arg_209_1.var_.actorSpriteComps1019 == nil then
				arg_209_1.var_.actorSpriteComps1019 = var_212_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_24 = 0.2

			if 3.66666666666667 <= arg_209_1.time_ and arg_209_1.time_ < 3.66666666666667 + var_212_24 and not isNil(var_212_23) then
				if arg_209_1.var_.actorSpriteComps1019 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								iter_212_6.color = Color.New(Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 3.66666666666667) / var_212_24), Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 3.66666666666667) / var_212_24), (Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 3.66666666666667) / var_212_24)))
							else
								local var_212_25 = Mathf.Lerp(iter_212_6.color.r, 1, (arg_209_1.time_ - 3.66666666666667) / var_212_24)

								iter_212_6.color = Color.New(var_212_25, var_212_25, var_212_25)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 3.66666666666667 + var_212_24 and arg_209_1.time_ < 3.66666666666667 + var_212_24 + arg_212_0 and not isNil(var_212_23) and arg_209_1.var_.actorSpriteComps1019 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_212_8 then
						iter_212_8.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1019 = nil
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_26 = 4
			local var_212_27 = 0.25

			if 4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_26 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_28 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_28:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_29 = arg_209_1:GetWordFromCfg(416241051)
				local var_212_30 = arg_209_1:FormatText(var_212_29.content)

				arg_209_1.text_.text = var_212_30

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_32 = 10 <= 0 and var_212_27 or var_212_27 * (utf8.len(var_212_30) / 10)

				if (10 <= 0 and var_212_27 or var_212_27 * (utf8.len(var_212_30) / 10)) > 0 and var_212_27 < var_212_32 then
					arg_209_1.talkMaxDuration = var_212_32
					var_212_26 = var_212_26 + 0.3

					if var_212_32 + var_212_26 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_32 + var_212_26
					end
				end

				arg_209_1.text_.text = var_212_30
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241051", "story_v_out_416241.awb") ~= 0 then
					local var_212_33 = manager.audio:GetVoiceLength("story_v_out_416241", "416241051", "story_v_out_416241.awb") / 1000

					if var_212_33 + var_212_26 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_33 + var_212_26
					end

					if var_212_29.prefab_name ~= "" and arg_209_1.actors_[var_212_29.prefab_name] ~= nil then
						local var_212_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_29.prefab_name].transform, "story_v_out_416241", "416241051", "story_v_out_416241.awb")

						arg_209_1:RecordAudio("416241051", var_212_34)
						arg_209_1:RecordAudio("416241051", var_212_34)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_416241", "416241051", "story_v_out_416241.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_416241", "416241051", "story_v_out_416241.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_35 = var_212_26 + 0.3
			local var_212_36 = math.max(var_212_27, arg_209_1.talkMaxDuration)

			if var_212_26 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_35 + var_212_36 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_35) / var_212_36

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_35 + var_212_36 and arg_209_1.time_ < var_212_35 + var_212_36 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play416241052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416241052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play416241053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1019"]) and arg_215_1.var_.actorSpriteComps1019 == nil then
				arg_215_1.var_.actorSpriteComps1019 = arg_215_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1019"]) then
				if arg_215_1.var_.actorSpriteComps1019 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1019"]) and arg_215_1.var_.actorSpriteComps1019 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps1019 = nil
			end

			local var_218_2 = 0
			local var_218_3 = 1.7

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(416241052).content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_6 = 68 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 68)

				if (68 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_4) / 68)) > 0 and var_218_3 < var_218_6 then
					arg_215_1.talkMaxDuration = var_218_6

					if var_218_6 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_6 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_7 and arg_215_1.time_ < var_218_2 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play416241053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416241053
		arg_219_1.duration_ = 7.4

		local var_219_0 = {
			zh = 5.066,
			ja = 7.4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play416241054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1019"]) and arg_219_1.var_.actorSpriteComps1019 == nil then
				arg_219_1.var_.actorSpriteComps1019 = arg_219_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1019"]) then
				if arg_219_1.var_.actorSpriteComps1019 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								iter_222_1.color = Color.New(Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_0), Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_0), (Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_0)))
							else
								local var_222_1 = Mathf.Lerp(iter_222_1.color.r, 1, (arg_219_1.time_ - 0) / var_222_0)

								iter_222_1.color = Color.New(var_222_1, var_222_1, var_222_1)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1019"]) and arg_219_1.var_.actorSpriteComps1019 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_222_3 then
						iter_222_3.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps1019 = nil
			end

			local var_222_2 = 0
			local var_222_3 = 0.725

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(416241053)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 29 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 29)

				if (29 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 29)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241053", "story_v_out_416241.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241053", "story_v_out_416241.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_416241", "416241053", "story_v_out_416241.awb")

						arg_219_1:RecordAudio("416241053", var_222_9)
						arg_219_1:RecordAudio("416241053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416241", "416241053", "story_v_out_416241.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416241", "416241053", "story_v_out_416241.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play416241054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416241054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play416241055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1019"]) and arg_223_1.var_.actorSpriteComps1019 == nil then
				arg_223_1.var_.actorSpriteComps1019 = arg_223_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1019"]) then
				if arg_223_1.var_.actorSpriteComps1019 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1019"]) and arg_223_1.var_.actorSpriteComps1019 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps1019 = nil
			end

			local var_226_2 = 0
			local var_226_3 = 0.4

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_4 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(416241054).content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 16 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 16)

				if (16 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_4) / 16)) > 0 and var_226_3 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_7 and arg_223_1.time_ < var_226_2 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play416241055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416241055
		arg_227_1.duration_ = 8.87

		local var_227_0 = {
			zh = 4.233,
			ja = 8.866
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
				arg_227_0:Play416241056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1019"]) and arg_227_1.var_.actorSpriteComps1019 == nil then
				arg_227_1.var_.actorSpriteComps1019 = arg_227_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1019"]) then
				if arg_227_1.var_.actorSpriteComps1019 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 1, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1019"]) and arg_227_1.var_.actorSpriteComps1019 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1019 = nil
			end

			local var_230_2 = 0
			local var_230_3 = 0.5

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(416241055)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 20 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 20)

				if (20 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 20)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241055", "story_v_out_416241.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241055", "story_v_out_416241.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_416241", "416241055", "story_v_out_416241.awb")

						arg_227_1:RecordAudio("416241055", var_230_9)
						arg_227_1:RecordAudio("416241055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416241", "416241055", "story_v_out_416241.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416241", "416241055", "story_v_out_416241.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416241056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416241056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play416241057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1019"]) and arg_231_1.var_.actorSpriteComps1019 == nil then
				arg_231_1.var_.actorSpriteComps1019 = arg_231_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1019"]) then
				if arg_231_1.var_.actorSpriteComps1019 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1019"]) and arg_231_1.var_.actorSpriteComps1019 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1019 = nil
			end

			local var_234_2 = 0
			local var_234_3 = 0.625

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_4 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(416241056).content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_6 = 25 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 25)

				if (25 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_4) / 25)) > 0 and var_234_3 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_7 and arg_231_1.time_ < var_234_2 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play416241057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416241057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play416241058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.85

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(416241057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 34 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 34)

				if (34 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 34)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416241058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416241058
		arg_239_1.duration_ = 13.87

		local var_239_0 = {
			zh = 8.6,
			ja = 13.866
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
				arg_239_0:Play416241059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1019"]) and arg_239_1.var_.actorSpriteComps1019 == nil then
				arg_239_1.var_.actorSpriteComps1019 = arg_239_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1019"]) then
				if arg_239_1.var_.actorSpriteComps1019 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1019"]) and arg_239_1.var_.actorSpriteComps1019 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1019 = nil
			end

			local var_242_2 = 0
			local var_242_3 = 1.075

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(416241058)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 43 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 43)

				if (43 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_5) / 43)) > 0 and var_242_3 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241058", "story_v_out_416241.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241058", "story_v_out_416241.awb") / 1000

					if var_242_8 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_2
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_out_416241", "416241058", "story_v_out_416241.awb")

						arg_239_1:RecordAudio("416241058", var_242_9)
						arg_239_1:RecordAudio("416241058", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416241", "416241058", "story_v_out_416241.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416241", "416241058", "story_v_out_416241.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416241059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416241059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play416241060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1019"]) and arg_243_1.var_.actorSpriteComps1019 == nil then
				arg_243_1.var_.actorSpriteComps1019 = arg_243_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1019"]) then
				if arg_243_1.var_.actorSpriteComps1019 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1019"]) and arg_243_1.var_.actorSpriteComps1019 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1019 = nil
			end

			local var_246_2 = 0
			local var_246_3 = 0.825

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_4 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(416241059).content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 33 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 33)

				if (33 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_4) / 33)) > 0 and var_246_3 < var_246_6 then
					arg_243_1.talkMaxDuration = var_246_6

					if var_246_6 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_6 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_7 and arg_243_1.time_ < var_246_2 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416241060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416241060
		arg_247_1.duration_ = 9.9

		local var_247_0 = {
			zh = 8.466,
			ja = 9.9
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
				arg_247_0:Play416241061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1019"]) and arg_247_1.var_.actorSpriteComps1019 == nil then
				arg_247_1.var_.actorSpriteComps1019 = arg_247_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1019"]) then
				if arg_247_1.var_.actorSpriteComps1019 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1019"]) and arg_247_1.var_.actorSpriteComps1019 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps1019 = nil
			end

			local var_250_2 = arg_247_1.actors_["1019"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1019 = var_250_2.localPosition
				var_250_2.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1019", 3)

				for iter_250_4 = 0, var_250_2.childCount - 1 do
					local var_250_3 = var_250_2:GetChild(iter_250_4)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_2.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1019, Vector3.New(0, -290, -300), (arg_247_1.time_ - 0) / var_250_4)
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_2.localPosition = Vector3.New(0, -290, -300)
			end

			local var_250_5 = 0
			local var_250_6 = 0.95

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(416241060)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 38 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 38)

				if (38 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 38)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241060", "story_v_out_416241.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241060", "story_v_out_416241.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_416241", "416241060", "story_v_out_416241.awb")

						arg_247_1:RecordAudio("416241060", var_250_12)
						arg_247_1:RecordAudio("416241060", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416241", "416241060", "story_v_out_416241.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416241", "416241060", "story_v_out_416241.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_13 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_13

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_13 and arg_247_1.time_ < var_250_5 + var_250_13 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play416241061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416241061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play416241062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1019"]) and arg_251_1.var_.actorSpriteComps1019 == nil then
				arg_251_1.var_.actorSpriteComps1019 = arg_251_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1019"]) then
				if arg_251_1.var_.actorSpriteComps1019 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1019:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1019"]) and arg_251_1.var_.actorSpriteComps1019 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps1019 = nil
			end

			local var_254_2 = 0
			local var_254_3 = 0.55

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(416241061).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 22 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 22)

				if (22 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 22)) > 0 and var_254_3 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_7 and arg_251_1.time_ < var_254_2 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416241062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416241062
		arg_255_1.duration_ = 7.77

		local var_255_0 = {
			zh = 7.033,
			ja = 7.766
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
				arg_255_0:Play416241063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1019"]) and arg_255_1.var_.actorSpriteComps1019 == nil then
				arg_255_1.var_.actorSpriteComps1019 = arg_255_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1019"]) then
				if arg_255_1.var_.actorSpriteComps1019 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1019"]) and arg_255_1.var_.actorSpriteComps1019 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1019 = nil
			end

			local var_258_2 = arg_255_1.actors_["1019"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1019 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1019", 3)

				for iter_258_4 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_4)

					if var_258_3.name == "split_1" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1019, Vector3.New(0, -290, -300), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(0, -290, -300)
			end

			local var_258_5 = 0
			local var_258_6 = 0.7

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(416241062)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 28 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 28)

				if (28 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 28)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241062", "story_v_out_416241.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241062", "story_v_out_416241.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_416241", "416241062", "story_v_out_416241.awb")

						arg_255_1:RecordAudio("416241062", var_258_12)
						arg_255_1:RecordAudio("416241062", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416241", "416241062", "story_v_out_416241.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416241", "416241062", "story_v_out_416241.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play416241063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416241063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play416241064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1019"]) and arg_259_1.var_.actorSpriteComps1019 == nil then
				arg_259_1.var_.actorSpriteComps1019 = arg_259_1.actors_["1019"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1019"]) then
				if arg_259_1.var_.actorSpriteComps1019 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1019"]) and arg_259_1.var_.actorSpriteComps1019 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1019 = nil
			end

			local var_262_2 = arg_259_1.actors_["1019"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1019 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("1019", 7)

				for iter_262_4 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_4)

					if var_262_3.name == "" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1019, Vector3.New(0, -2000, 0), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_262_5 = 0
			local var_262_6 = 0.875

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(416241063).content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 35 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_7) / 35)

				if (35 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_7) / 35)) > 0 and var_262_6 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_10 and arg_259_1.time_ < var_262_5 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play416241064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416241064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play416241065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.95

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(416241064).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 38 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 38)

				if (38 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 38)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play416241065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416241065
		arg_267_1.duration_ = 7.63

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416241066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if arg_267_1.bgs_.ST25 == nil then
				local var_270_0 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST25")
				var_270_0.name = "ST25"
				var_270_0.transform.parent = arg_267_1.stage_.transform
				var_270_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_.ST25 = var_270_0
			end

			if 1.2 < arg_267_1.time_ and arg_267_1.time_ <= 1.2 + arg_270_0 then
				local var_270_1 = arg_267_1.bgs_.ST25

				arg_267_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_2 = var_270_1:GetComponent("SpriteRenderer")

				if var_270_2 and var_270_2.sprite then
					local var_270_3 = 2 * (var_270_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_1.transform.localScale = Vector3.New(var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, var_270_3 / var_270_2.sprite.bounds.size.y < var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x and var_270_3 * manager.ui.mainCameraCom_.aspect / var_270_2.sprite.bounds.size.x or var_270_3 / var_270_2.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "ST25" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_4 = 1.2

			if 1.2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_4 + 0.3 and arg_267_1.time_ < var_270_4 + 0.3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_5 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 1.2

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = Mathf.Lerp(0, 1, (arg_267_1.time_ - var_270_5) / var_270_6)
				arg_267_1.mask_.color = var_270_7
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_8 = Color.New(0, 0, 0)

				var_270_8.a = 1
				arg_267_1.mask_.color = var_270_8
			end

			local var_270_9 = 1.2

			if 1.2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_10 = 2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 then
				local var_270_11 = Color.New(0, 0, 0)

				var_270_11.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_9) / var_270_10)
				arg_267_1.mask_.color = var_270_11
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 then
				local var_270_12 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_12.a = 0
				arg_267_1.mask_.color = var_270_12
			end

			if 4 < arg_267_1.time_ and arg_267_1.time_ <= 4 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_10", "se_story_10_crack", "")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_270_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_16 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_16

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_16
						arg_267_1.bgmTxt2_.text = var_270_16
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_267_1.time_ and arg_267_1.time_ <= 0.466666666666667 + arg_270_0 then
				arg_267_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_270_19 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_267_1.bgmTxt_.text ~= var_270_19 and arg_267_1.bgmTxt_.text ~= "" then
						if arg_267_1.bgmTxt2_.text ~= "" then
							arg_267_1.bgmTxt_.text = arg_267_1.bgmTxt2_.text
						end

						arg_267_1.bgmTxt2_.text = var_270_19

						arg_267_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_267_1.bgmTxt_.text = var_270_19
						arg_267_1.bgmTxt2_.text = var_270_19
					end

					if arg_267_1.bgmTimer then
						arg_267_1.bgmTimer:Stop()

						arg_267_1.bgmTimer = nil
					end

					if arg_267_1.settingData.show_music_name == 1 then
						arg_267_1.musicController:SetSelectedState("show")
						arg_267_1.musicAnimator_:Play("open", 0, 0)

						if arg_267_1.settingData.music_time ~= 0 then
							arg_267_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_267_1.settingData.music_time), function()
								if arg_267_1 == nil or isNil(arg_267_1.bgmTxt_) then
									return
								end

								arg_267_1.musicController:SetSelectedState("hide")
								arg_267_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_20 = 2.63333333333333
			local var_270_21 = 2

			if 2.63333333333333 < arg_267_1.time_ and arg_267_1.time_ <= var_270_20 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_22 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_22:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_267_1.dialogCg_.alpha = arg_273_0
				end))
				var_270_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_23 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(416241065).content)

				arg_267_1.text_.text = var_270_23

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_25 = 80 <= 0 and var_270_21 or var_270_21 * (utf8.len(var_270_23) / 80)

				if (80 <= 0 and var_270_21 or var_270_21 * (utf8.len(var_270_23) / 80)) > 0 and var_270_21 < var_270_25 then
					arg_267_1.talkMaxDuration = var_270_25
					var_270_20 = var_270_20 + 0.3

					if var_270_25 + var_270_20 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_25 + var_270_20
					end
				end

				arg_267_1.text_.text = var_270_23
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_26 = var_270_20 + 0.3
			local var_270_27 = math.max(var_270_21, arg_267_1.talkMaxDuration)

			if var_270_20 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_26 + var_270_27 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_26) / var_270_27

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_26 + var_270_27 and arg_267_1.time_ < var_270_26 + var_270_27 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416241066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416241066
		arg_275_1.duration_ = 12.63

		local var_275_0 = {
			zh = 7.366,
			ja = 12.633
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
				arg_275_0:Play416241067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if arg_275_1.actors_["10129"] == nil then
				local var_278_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10129")

				if not isNil(var_278_0) then
					local var_278_1 = Object.Instantiate(var_278_0, arg_275_1.canvasGo_.transform)

					var_278_1.transform:SetSiblingIndex(1)

					var_278_1.name = "10129"
					var_278_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_275_1.actors_["10129"] = var_278_1

					if arg_275_1.isInRecall_ then
						for iter_278_0, iter_278_1 in ipairs((var_278_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_278_1.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_278_2 = arg_275_1.actors_["10129"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10129 == nil then
				arg_275_1.var_.actorSpriteComps10129 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps10129 then
					for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_278_3 then
							if arg_275_1.isInRecall_ then
								iter_278_3.color = Color.New(Mathf.Lerp(iter_278_3.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_3), Mathf.Lerp(iter_278_3.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_3), (Mathf.Lerp(iter_278_3.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_3)))
							else
								local var_278_4 = Mathf.Lerp(iter_278_3.color.r, 1, (arg_275_1.time_ - 0) / var_278_3)

								iter_278_3.color = Color.New(var_278_4, var_278_4, var_278_4)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps10129 then
				for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_278_5 then
						iter_278_5.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10129 = nil
			end

			local var_278_5 = arg_275_1.actors_["10129"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10129 = var_278_5.localPosition
				var_278_5.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10129", 3)

				for iter_278_6 = 0, var_278_5.childCount - 1 do
					local var_278_6 = var_278_5:GetChild(iter_278_6)

					if var_278_6.name == "" or not string.find(var_278_6.name, "split") then
						var_278_6.gameObject:SetActive(true)
					else
						var_278_6.gameObject:SetActive(false)
					end
				end
			end

			local var_278_7 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				var_278_5.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10129, Vector3.New(0, -375, -400), (arg_275_1.time_ - 0) / var_278_7)
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				var_278_5.localPosition = Vector3.New(0, -375, -400)
			end

			local var_278_8 = 0
			local var_278_9 = 0.675

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1095].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(416241066)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 27 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 27)

				if (27 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 27)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241066", "story_v_out_416241.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_416241", "416241066", "story_v_out_416241.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_416241", "416241066", "story_v_out_416241.awb")

						arg_275_1:RecordAudio("416241066", var_278_15)
						arg_275_1:RecordAudio("416241066", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416241", "416241066", "story_v_out_416241.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416241", "416241066", "story_v_out_416241.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
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
	Play416241067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416241067
		arg_279_1.duration_ = 13.17

		local var_279_0 = {
			zh = 8.866,
			ja = 13.166
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
				arg_279_0:Play416241068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10129"]) and arg_279_1.var_.actorSpriteComps10129 == nil then
				arg_279_1.var_.actorSpriteComps10129 = arg_279_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10129"]) then
				if arg_279_1.var_.actorSpriteComps10129 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor2.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor2.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor2.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 0.5, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10129"]) and arg_279_1.var_.actorSpriteComps10129 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10129 = nil
			end

			local var_282_2 = 0
			local var_282_3 = 0.875

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_4 = arg_279_1:GetWordFromCfg(416241067)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 35 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 35)

				if (35 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 35)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241067", "story_v_out_416241.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241067", "story_v_out_416241.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_416241", "416241067", "story_v_out_416241.awb")

						arg_279_1:RecordAudio("416241067", var_282_9)
						arg_279_1:RecordAudio("416241067", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416241", "416241067", "story_v_out_416241.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416241", "416241067", "story_v_out_416241.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play416241068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416241068
		arg_283_1.duration_ = 10.63

		local var_283_0 = {
			zh = 7.233,
			ja = 10.633
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
				arg_283_0:Play416241069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10129"]) and arg_283_1.var_.actorSpriteComps10129 == nil then
				arg_283_1.var_.actorSpriteComps10129 = arg_283_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10129"]) then
				if arg_283_1.var_.actorSpriteComps10129 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10129:ToTable()) do
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

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10129"]) and arg_283_1.var_.actorSpriteComps10129 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps10129 = nil
			end

			local var_286_2 = 0
			local var_286_3 = 0.625

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(416241068)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 25 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 25)

				if (25 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 25)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241068", "story_v_out_416241.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241068", "story_v_out_416241.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_416241", "416241068", "story_v_out_416241.awb")

						arg_283_1:RecordAudio("416241068", var_286_9)
						arg_283_1:RecordAudio("416241068", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_416241", "416241068", "story_v_out_416241.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_416241", "416241068", "story_v_out_416241.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play416241069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416241069
		arg_287_1.duration_ = 6.07

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play416241070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10129"]) and arg_287_1.var_.actorSpriteComps10129 == nil then
				arg_287_1.var_.actorSpriteComps10129 = arg_287_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10129"]) then
				if arg_287_1.var_.actorSpriteComps10129 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								iter_290_1.color = Color.New(Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor2.r, (arg_287_1.time_ - 0) / var_290_0), Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor2.g, (arg_287_1.time_ - 0) / var_290_0), (Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor2.b, (arg_287_1.time_ - 0) / var_290_0)))
							else
								local var_290_1 = Mathf.Lerp(iter_290_1.color.r, 0.5, (arg_287_1.time_ - 0) / var_290_0)

								iter_290_1.color = Color.New(var_290_1, var_290_1, var_290_1)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10129"]) and arg_287_1.var_.actorSpriteComps10129 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps10129 = nil
			end

			local var_290_2 = 0
			local var_290_3 = 0.5

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_4 = arg_287_1:GetWordFromCfg(416241069)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 20 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 20)

				if (20 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 20)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241069", "story_v_out_416241.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241069", "story_v_out_416241.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_416241", "416241069", "story_v_out_416241.awb")

						arg_287_1:RecordAudio("416241069", var_290_9)
						arg_287_1:RecordAudio("416241069", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416241", "416241069", "story_v_out_416241.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416241", "416241069", "story_v_out_416241.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play416241070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416241070
		arg_291_1.duration_ = 12.5

		local var_291_0 = {
			zh = 8.266,
			ja = 12.5
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
				arg_291_0:Play416241071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10129"]) and arg_291_1.var_.actorSpriteComps10129 == nil then
				arg_291_1.var_.actorSpriteComps10129 = arg_291_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10129"]) then
				if arg_291_1.var_.actorSpriteComps10129 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 1, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10129"]) and arg_291_1.var_.actorSpriteComps10129 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps10129 = nil
			end

			local var_294_2 = 0
			local var_294_3 = 0.75

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(416241070)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 30 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 30)

				if (30 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 30)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241070", "story_v_out_416241.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241070", "story_v_out_416241.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_out_416241", "416241070", "story_v_out_416241.awb")

						arg_291_1:RecordAudio("416241070", var_294_9)
						arg_291_1:RecordAudio("416241070", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416241", "416241070", "story_v_out_416241.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416241", "416241070", "story_v_out_416241.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play416241071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416241071
		arg_295_1.duration_ = 8.53

		local var_295_0 = {
			zh = 8.533,
			ja = 6.5
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
				arg_295_0:Play416241072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10129"]) and arg_295_1.var_.actorSpriteComps10129 == nil then
				arg_295_1.var_.actorSpriteComps10129 = arg_295_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10129"]) then
				if arg_295_1.var_.actorSpriteComps10129 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10129"]) and arg_295_1.var_.actorSpriteComps10129 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10129 = nil
			end

			local var_298_2 = 0
			local var_298_3 = 0.625

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_3")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_4 = arg_295_1:GetWordFromCfg(416241071)
				local var_298_5 = arg_295_1:FormatText(var_298_4.content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 25 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 25)

				if (25 <= 0 and var_298_3 or var_298_3 * (utf8.len(var_298_5) / 25)) > 0 and var_298_3 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_2
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241071", "story_v_out_416241.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241071", "story_v_out_416241.awb") / 1000

					if var_298_8 + var_298_2 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_2
					end

					if var_298_4.prefab_name ~= "" and arg_295_1.actors_[var_298_4.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_4.prefab_name].transform, "story_v_out_416241", "416241071", "story_v_out_416241.awb")

						arg_295_1:RecordAudio("416241071", var_298_9)
						arg_295_1:RecordAudio("416241071", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_416241", "416241071", "story_v_out_416241.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_416241", "416241071", "story_v_out_416241.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_3, arg_295_1.talkMaxDuration)

			if var_298_2 <= arg_295_1.time_ and arg_295_1.time_ < var_298_2 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_2) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_2 + var_298_10 and arg_295_1.time_ < var_298_2 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play416241072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416241072
		arg_299_1.duration_ = 12

		local var_299_0 = {
			zh = 12,
			ja = 8.6
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play416241073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10129 = arg_299_1.actors_["10129"].transform.localPosition
				arg_299_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10129", 3)

				for iter_302_0 = 0, arg_299_1.actors_["10129"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10129"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_4" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10129, Vector3.New(0, -375, -400), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10129"].transform.localPosition = Vector3.New(0, -375, -400)
			end

			local var_302_2 = arg_299_1.actors_["10129"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10129 == nil then
				arg_299_1.var_.actorSpriteComps10129 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10129 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 1, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10129 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10129 = nil
			end

			local var_302_5 = 0
			local var_302_6 = 1.075

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(416241072)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 43 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 43)

				if (43 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 43)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241072", "story_v_out_416241.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241072", "story_v_out_416241.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_416241", "416241072", "story_v_out_416241.awb")

						arg_299_1:RecordAudio("416241072", var_302_12)
						arg_299_1:RecordAudio("416241072", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416241", "416241072", "story_v_out_416241.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416241", "416241072", "story_v_out_416241.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_13 = math.max(var_302_6, arg_299_1.talkMaxDuration)

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_13 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_5) / var_302_13

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_5 + var_302_13 and arg_299_1.time_ < var_302_5 + var_302_13 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
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
	Play416241073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416241073
		arg_303_1.duration_ = 11.43

		local var_303_0 = {
			zh = 8.466,
			ja = 11.433
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play416241074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.875

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(416241073)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 35 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 35)

				if (35 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 35)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241073", "story_v_out_416241.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241073", "story_v_out_416241.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_416241", "416241073", "story_v_out_416241.awb")

						arg_303_1:RecordAudio("416241073", var_306_6)
						arg_303_1:RecordAudio("416241073", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416241", "416241073", "story_v_out_416241.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416241", "416241073", "story_v_out_416241.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play416241074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416241074
		arg_307_1.duration_ = 6.57

		local var_307_0 = {
			zh = 4.6,
			ja = 6.566
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play416241075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10129"]) and arg_307_1.var_.actorSpriteComps10129 == nil then
				arg_307_1.var_.actorSpriteComps10129 = arg_307_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10129"]) then
				if arg_307_1.var_.actorSpriteComps10129 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								iter_310_1.color = Color.New(Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_0), Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_0), (Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_0)))
							else
								local var_310_1 = Mathf.Lerp(iter_310_1.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_0)

								iter_310_1.color = Color.New(var_310_1, var_310_1, var_310_1)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10129"]) and arg_307_1.var_.actorSpriteComps10129 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10129 = nil
			end

			local var_310_2 = 0
			local var_310_3 = 0.4

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_3")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_4 = arg_307_1:GetWordFromCfg(416241074)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 16 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 16)

				if (16 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 16)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241074", "story_v_out_416241.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241074", "story_v_out_416241.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_out_416241", "416241074", "story_v_out_416241.awb")

						arg_307_1:RecordAudio("416241074", var_310_9)
						arg_307_1:RecordAudio("416241074", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416241", "416241074", "story_v_out_416241.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416241", "416241074", "story_v_out_416241.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play416241075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416241075
		arg_311_1.duration_ = 12

		local var_311_0 = {
			zh = 7.366,
			ja = 12
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play416241076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.8

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_3")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:GetWordFromCfg(416241075)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 32 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 32)

				if (32 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 32)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241075", "story_v_out_416241.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241075", "story_v_out_416241.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_out_416241", "416241075", "story_v_out_416241.awb")

						arg_311_1:RecordAudio("416241075", var_314_6)
						arg_311_1:RecordAudio("416241075", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416241", "416241075", "story_v_out_416241.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416241", "416241075", "story_v_out_416241.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play416241076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 416241076
		arg_315_1.duration_ = 8.3

		local var_315_0 = {
			zh = 8.3,
			ja = 8.2
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play416241077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10129"]) and arg_315_1.var_.actorSpriteComps10129 == nil then
				arg_315_1.var_.actorSpriteComps10129 = arg_315_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10129"]) then
				if arg_315_1.var_.actorSpriteComps10129 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10129"]) and arg_315_1.var_.actorSpriteComps10129 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10129 = nil
			end

			local var_318_2 = 0
			local var_318_3 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(416241076)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 22 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 22)

				if (22 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 22)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241076", "story_v_out_416241.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241076", "story_v_out_416241.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_out_416241", "416241076", "story_v_out_416241.awb")

						arg_315_1:RecordAudio("416241076", var_318_9)
						arg_315_1:RecordAudio("416241076", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_416241", "416241076", "story_v_out_416241.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_416241", "416241076", "story_v_out_416241.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play416241077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 416241077
		arg_319_1.duration_ = 8.47

		local var_319_0 = {
			zh = 6.166,
			ja = 8.466
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play416241078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10129"]) and arg_319_1.var_.actorSpriteComps10129 == nil then
				arg_319_1.var_.actorSpriteComps10129 = arg_319_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10129"]) then
				if arg_319_1.var_.actorSpriteComps10129 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10129"]) and arg_319_1.var_.actorSpriteComps10129 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10129 = nil
			end

			local var_322_2 = 0
			local var_322_3 = 0.7

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_4")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_4 = arg_319_1:GetWordFromCfg(416241077)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 28 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 28)

				if (28 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 28)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241077", "story_v_out_416241.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241077", "story_v_out_416241.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_416241", "416241077", "story_v_out_416241.awb")

						arg_319_1:RecordAudio("416241077", var_322_9)
						arg_319_1:RecordAudio("416241077", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_416241", "416241077", "story_v_out_416241.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_416241", "416241077", "story_v_out_416241.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play416241078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 416241078
		arg_323_1.duration_ = 10.13

		local var_323_0 = {
			zh = 5.466,
			ja = 10.133
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play416241079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10129 = arg_323_1.actors_["10129"].transform.localPosition
				arg_323_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10129", 3)

				for iter_326_0 = 0, arg_323_1.actors_["10129"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10129"].transform:GetChild(iter_326_0)

					if var_326_0.name == "split_5" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10129, Vector3.New(0, -375, -400), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10129"].transform.localPosition = Vector3.New(0, -375, -400)
			end

			local var_326_2 = arg_323_1.actors_["10129"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10129 == nil then
				arg_323_1.var_.actorSpriteComps10129 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10129 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10129 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10129 = nil
			end

			local var_326_5 = 0
			local var_326_6 = 0.475

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_7 = arg_323_1:GetWordFromCfg(416241078)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 19 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 19)

				if (19 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 19)) > 0 and var_326_6 < var_326_10 then
					arg_323_1.talkMaxDuration = var_326_10

					if var_326_10 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241078", "story_v_out_416241.awb") ~= 0 then
					local var_326_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241078", "story_v_out_416241.awb") / 1000

					if var_326_11 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_5
					end

					if var_326_7.prefab_name ~= "" and arg_323_1.actors_[var_326_7.prefab_name] ~= nil then
						local var_326_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_7.prefab_name].transform, "story_v_out_416241", "416241078", "story_v_out_416241.awb")

						arg_323_1:RecordAudio("416241078", var_326_12)
						arg_323_1:RecordAudio("416241078", var_326_12)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_416241", "416241078", "story_v_out_416241.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_416241", "416241078", "story_v_out_416241.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_5) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_5 + var_326_13 and arg_323_1.time_ < var_326_5 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play416241079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 416241079
		arg_327_1.duration_ = 8.5

		local var_327_0 = {
			zh = 8,
			ja = 8.5
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play416241080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10129"]) and arg_327_1.var_.actorSpriteComps10129 == nil then
				arg_327_1.var_.actorSpriteComps10129 = arg_327_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10129"]) then
				if arg_327_1.var_.actorSpriteComps10129 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10129"]) and arg_327_1.var_.actorSpriteComps10129 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps10129 = nil
			end

			local var_330_2 = 0
			local var_330_3 = 0.7

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_4")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_4 = arg_327_1:GetWordFromCfg(416241079)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 28 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 28)

				if (28 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 28)) > 0 and var_330_3 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241079", "story_v_out_416241.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241079", "story_v_out_416241.awb") / 1000

					if var_330_8 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_2
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_out_416241", "416241079", "story_v_out_416241.awb")

						arg_327_1:RecordAudio("416241079", var_330_9)
						arg_327_1:RecordAudio("416241079", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_416241", "416241079", "story_v_out_416241.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_416241", "416241079", "story_v_out_416241.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_10 and arg_327_1.time_ < var_330_2 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play416241080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 416241080
		arg_331_1.duration_ = 11.17

		local var_331_0 = {
			zh = 5.966,
			ja = 11.166
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play416241081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.5

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_4")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:GetWordFromCfg(416241080)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 20 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 20)

				if (20 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 20)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241080", "story_v_out_416241.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241080", "story_v_out_416241.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_416241", "416241080", "story_v_out_416241.awb")

						arg_331_1:RecordAudio("416241080", var_334_6)
						arg_331_1:RecordAudio("416241080", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_416241", "416241080", "story_v_out_416241.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_416241", "416241080", "story_v_out_416241.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play416241081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 416241081
		arg_335_1.duration_ = 5

		local var_335_0 = {
			zh = 2.533,
			ja = 5
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play416241082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10129 = arg_335_1.actors_["10129"].transform.localPosition
				arg_335_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10129", 3)

				for iter_338_0 = 0, arg_335_1.actors_["10129"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["10129"].transform:GetChild(iter_338_0)

					if var_338_0.name == "" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10129, Vector3.New(0, -375, -400), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["10129"].transform.localPosition = Vector3.New(0, -375, -400)
			end

			local var_338_2 = arg_335_1.actors_["10129"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10129 == nil then
				arg_335_1.var_.actorSpriteComps10129 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10129 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								iter_338_2.color = Color.New(Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_2.color.r, 1, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_2.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10129 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_338_4 then
						iter_338_4.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10129 = nil
			end

			local var_338_5 = 0
			local var_338_6 = 0.25

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(416241081)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 10 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 10)

				if (10 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 10)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241081", "story_v_out_416241.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241081", "story_v_out_416241.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_416241", "416241081", "story_v_out_416241.awb")

						arg_335_1:RecordAudio("416241081", var_338_12)
						arg_335_1:RecordAudio("416241081", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_416241", "416241081", "story_v_out_416241.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_416241", "416241081", "story_v_out_416241.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play416241082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 416241082
		arg_339_1.duration_ = 3.9

		local var_339_0 = {
			zh = 2.866,
			ja = 3.9
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play416241083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10129"]) and arg_339_1.var_.actorSpriteComps10129 == nil then
				arg_339_1.var_.actorSpriteComps10129 = arg_339_1.actors_["10129"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10129"]) then
				if arg_339_1.var_.actorSpriteComps10129 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10129"]) and arg_339_1.var_.actorSpriteComps10129 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10129 = nil
			end

			if 0.1 < arg_339_1.time_ and arg_339_1.time_ <= 0.1 + arg_342_0 then
				arg_339_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			local var_342_3 = 0
			local var_342_4 = 0.275

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_3")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_5 = arg_339_1:GetWordFromCfg(416241082)
				local var_342_6 = arg_339_1:FormatText(var_342_5.content)

				arg_339_1.text_.text = var_342_6

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_8 = 11 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 11)

				if (11 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 11)) > 0 and var_342_4 < var_342_8 then
					arg_339_1.talkMaxDuration = var_342_8

					if var_342_8 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_3
					end
				end

				arg_339_1.text_.text = var_342_6
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241082", "story_v_out_416241.awb") ~= 0 then
					local var_342_9 = manager.audio:GetVoiceLength("story_v_out_416241", "416241082", "story_v_out_416241.awb") / 1000

					if var_342_9 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_3
					end

					if var_342_5.prefab_name ~= "" and arg_339_1.actors_[var_342_5.prefab_name] ~= nil then
						local var_342_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_5.prefab_name].transform, "story_v_out_416241", "416241082", "story_v_out_416241.awb")

						arg_339_1:RecordAudio("416241082", var_342_10)
						arg_339_1:RecordAudio("416241082", var_342_10)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_416241", "416241082", "story_v_out_416241.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_416241", "416241082", "story_v_out_416241.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_11 = math.max(var_342_4, arg_339_1.talkMaxDuration)

			if var_342_3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_3 + var_342_11 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_3) / var_342_11

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_3 + var_342_11 and arg_339_1.time_ < var_342_3 + var_342_11 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play416241083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 416241083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play416241084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10129 = arg_343_1.actors_["10129"].transform.localPosition
				arg_343_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10129", 7)

				for iter_346_0 = 0, arg_343_1.actors_["10129"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10129"].transform:GetChild(iter_346_0)

					if var_346_0.name == "" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10129, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10129"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_2 = "1071"

			if arg_343_1.actors_["1071"] == nil then
				local var_346_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1071")

				if not isNil(var_346_3) then
					local var_346_4 = Object.Instantiate(var_346_3, arg_343_1.canvasGo_.transform)

					var_346_4.transform:SetSiblingIndex(1)

					var_346_4.name = var_346_2
					var_346_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_343_1.actors_[var_346_2] = var_346_4

					if arg_343_1.isInRecall_ then
						for iter_346_1, iter_346_2 in ipairs((var_346_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_346_2.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_346_5 = arg_343_1.actors_["1071"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1071 = var_346_5.localPosition
				var_346_5.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1071", 7)

				for iter_346_3 = 0, var_346_5.childCount - 1 do
					local var_346_6 = var_346_5:GetChild(iter_346_3)

					if var_346_6.name == "" or not string.find(var_346_6.name, "split") then
						var_346_6.gameObject:SetActive(true)
					else
						var_346_6.gameObject:SetActive(false)
					end
				end
			end

			local var_346_7 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				var_346_5.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1071, Vector3.New(0, -2000, 7.24), (arg_343_1.time_ - 0) / var_346_7)
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				var_346_5.localPosition = Vector3.New(0, -2000, 7.24)
			end

			local var_346_8 = 0
			local var_346_9 = 1.725

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(416241083).content)

				arg_343_1.text_.text = var_346_10

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_12 = 69 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_10) / 69)

				if (69 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_10) / 69)) > 0 and var_346_9 < var_346_12 then
					arg_343_1.talkMaxDuration = var_346_12

					if var_346_12 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_10
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_13 and arg_343_1.time_ < var_346_8 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play416241084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 416241084
		arg_347_1.duration_ = 6.3

		local var_347_0 = {
			zh = 4.233,
			ja = 6.3
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play416241085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10129 = arg_347_1.actors_["10129"].transform.localPosition
				arg_347_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10129", 3)

				for iter_350_0 = 0, arg_347_1.actors_["10129"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10129"].transform:GetChild(iter_350_0)

					if var_350_0.name == "split_4" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10129, Vector3.New(0, -375, -400), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10129"].transform.localPosition = Vector3.New(0, -375, -400)
			end

			local var_350_2 = arg_347_1.actors_["10129"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10129 == nil then
				arg_347_1.var_.actorSpriteComps10129 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10129 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10129 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10129 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.4

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(416241084)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 16 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 16)

				if (16 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 16)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241084", "story_v_out_416241.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_416241", "416241084", "story_v_out_416241.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_416241", "416241084", "story_v_out_416241.awb")

						arg_347_1:RecordAudio("416241084", var_350_12)
						arg_347_1:RecordAudio("416241084", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_416241", "416241084", "story_v_out_416241.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_416241", "416241084", "story_v_out_416241.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play416241085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 416241085
		arg_351_1.duration_ = 9.3

		local var_351_0 = {
			zh = 7.533,
			ja = 9.3
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play416241086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.7

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1096].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(416241085)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 28 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 28)

				if (28 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 28)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241085", "story_v_out_416241.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241085", "story_v_out_416241.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_416241", "416241085", "story_v_out_416241.awb")

						arg_351_1:RecordAudio("416241085", var_354_6)
						arg_351_1:RecordAudio("416241085", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_416241", "416241085", "story_v_out_416241.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_416241", "416241085", "story_v_out_416241.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play416241086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 416241086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play416241087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10129 = arg_355_1.actors_["10129"].transform.localPosition
				arg_355_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10129", 7)

				for iter_358_0 = 0, arg_355_1.actors_["10129"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10129"].transform:GetChild(iter_358_0)

					if var_358_0.name == "split_1" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10129, Vector3.New(0, -2000, 0), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10129"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_358_2 = arg_355_1.actors_["10129"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10129 == nil then
				arg_355_1.var_.actorSpriteComps10129 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps10129 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10129:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								iter_358_2.color = Color.New(Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_2.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_2.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10129 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10129:ToTable()) do
					if iter_358_4 then
						iter_358_4.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10129 = nil
			end

			local var_358_5 = 0
			local var_358_6 = 1.4

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(416241086).content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 56 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_7) / 56)

				if (56 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_7) / 56)) > 0 and var_358_6 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_10 and arg_355_1.time_ < var_358_5 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play416241087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 416241087
		arg_359_1.duration_ = 4.6

		local var_359_0 = {
			zh = 4.6,
			ja = 4.166
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play416241088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10129 = arg_359_1.actors_["10129"].transform.localPosition
				arg_359_1.actors_["10129"].transform.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10129", 7)

				for iter_362_0 = 0, arg_359_1.actors_["10129"].transform.childCount - 1 do
					local var_362_0 = arg_359_1.actors_["10129"].transform:GetChild(iter_362_0)

					if var_362_0.name == "" or not string.find(var_362_0.name, "split") then
						var_362_0.gameObject:SetActive(true)
					else
						var_362_0.gameObject:SetActive(false)
					end
				end
			end

			local var_362_1 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 then
				arg_359_1.actors_["10129"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10129, Vector3.New(0, -2000, 0), (arg_359_1.time_ - 0) / var_362_1)
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 then
				arg_359_1.actors_["10129"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_362_2 = 0
			local var_362_3 = 0.275

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_3")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_4 = arg_359_1:GetWordFromCfg(416241087)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 11 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 11)

				if (11 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 11)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241087", "story_v_out_416241.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_416241", "416241087", "story_v_out_416241.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_out_416241", "416241087", "story_v_out_416241.awb")

						arg_359_1:RecordAudio("416241087", var_362_9)
						arg_359_1:RecordAudio("416241087", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_416241", "416241087", "story_v_out_416241.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_416241", "416241087", "story_v_out_416241.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10129",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play416241088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 416241088
		arg_363_1.duration_ = 6.9

		local var_363_0 = {
			zh = 6.9,
			ja = 6.8
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
			arg_363_1.auto_ = false
		end

		function arg_363_1.playNext_(arg_365_0)
			arg_363_1.onStoryFinished_()
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.55

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10123_split_4")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:GetWordFromCfg(416241088)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 22 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 22)

				if (22 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 22)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416241", "416241088", "story_v_out_416241.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_416241", "416241088", "story_v_out_416241.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_416241", "416241088", "story_v_out_416241.awb")

						arg_363_1:RecordAudio("416241088", var_366_6)
						arg_363_1:RecordAudio("416241088", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_416241", "416241088", "story_v_out_416241.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_416241", "416241088", "story_v_out_416241.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST25"
	},
	voices = {
		"story_v_out_416241.awb"
	}
}
