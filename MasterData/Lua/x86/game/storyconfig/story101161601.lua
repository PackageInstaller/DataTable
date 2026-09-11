return {
	Play116161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116161001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.833,
			ja = 3.633333333332
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
				arg_1_0:Play116161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.SK0103 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0103")
				var_4_0.name = "SK0103"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.SK0103 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.SK0103

				arg_1_1.bgs_.SK0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SK0103" then
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

			local var_4_11 = arg_1_1.bgs_.SK0103.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosSK0103 = var_4_11.localPosition
			end

			local var_4_12 = 3

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSK0103, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_12)
			end

			if arg_1_1.time_ >= 0 + var_4_12 and arg_1_1.time_ < 0 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_13 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 1 and arg_1_1.time_ < var_4_13 + 1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(116161001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 8)

				if (8 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 8)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161001", "story_v_out_116161.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_116161", "116161001", "story_v_out_116161.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_116161", "116161001", "story_v_out_116161.awb")

						arg_1_1:RecordAudio("116161001", var_4_22)
						arg_1_1:RecordAudio("116161001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116161", "116161001", "story_v_out_116161.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116161", "116161001", "story_v_out_116161.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116161002
		arg_8_1.duration_ = 8.33

		local var_8_0 = {
			zh = 8.333,
			ja = 5.666
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.bgs_.SK0112 == nil then
				local var_11_0 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0112")
				var_11_0.name = "SK0112"
				var_11_0.transform.parent = arg_8_1.stage_.transform
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_.SK0112 = var_11_0
			end

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= 2 + arg_11_0 then
				local var_11_1 = arg_8_1.bgs_.SK0112

				arg_8_1.bgs_.SK0112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_2 = var_11_1:GetComponent("SpriteRenderer")

				if var_11_2 and var_11_2.sprite then
					local var_11_3 = 2 * (var_11_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_1.transform.localScale = Vector3.New(var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "SK0112" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_4 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_5 = 2

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_5 then
				local var_11_6 = Color.New(0, 0, 0)

				var_11_6.a = Mathf.Lerp(0, 1, (arg_8_1.time_ - var_11_4) / var_11_5)
				arg_8_1.mask_.color = var_11_6
			end

			if arg_8_1.time_ >= var_11_4 + var_11_5 and arg_8_1.time_ < var_11_4 + var_11_5 + arg_11_0 then
				local var_11_7 = Color.New(0, 0, 0)

				var_11_7.a = 1
				arg_8_1.mask_.color = var_11_7
			end

			local var_11_8 = 2

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_9 = 2

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_9 then
				local var_11_10 = Color.New(0, 0, 0)

				var_11_10.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_8) / var_11_9)
				arg_8_1.mask_.color = var_11_10
			end

			if arg_8_1.time_ >= var_11_8 + var_11_9 and arg_8_1.time_ < var_11_8 + var_11_9 + arg_11_0 then
				local var_11_11 = Color.New(0, 0, 0)

				arg_8_1.mask_.enabled = false
				var_11_11.a = 0
				arg_8_1.mask_.color = var_11_11
			end

			local var_11_12 = arg_8_1.bgs_.SK0112.transform

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= 2 + arg_11_0 then
				arg_8_1.var_.moveOldPosSK0112 = var_11_12.localPosition
			end

			local var_11_13 = 3

			if 2 <= arg_8_1.time_ and arg_8_1.time_ < 2 + var_11_13 then
				var_11_12.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPosSK0112, Vector3.New(0, 1, 9.5), (arg_8_1.time_ - 2) / var_11_13)
			end

			if arg_8_1.time_ >= 2 + var_11_13 and arg_8_1.time_ < 2 + var_11_13 + arg_11_0 then
				var_11_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_11_14 = 4

			if 4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= var_11_14 + 1 and arg_8_1.time_ < var_11_14 + 1 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_15 = 4
			local var_11_16 = 0.375

			if 4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_17 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_17:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_18 = arg_8_1:GetWordFromCfg(116161002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_21 = 15 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_19) / 15)

				if (15 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_19) / 15)) > 0 and var_11_16 < var_11_21 then
					arg_8_1.talkMaxDuration = var_11_21
					var_11_15 = var_11_15 + 0.3

					if var_11_21 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_21 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161002", "story_v_out_116161.awb") ~= 0 then
					local var_11_22 = manager.audio:GetVoiceLength("story_v_out_116161", "116161002", "story_v_out_116161.awb") / 1000

					if var_11_22 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_15
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_116161", "116161002", "story_v_out_116161.awb")

						arg_8_1:RecordAudio("116161002", var_11_23)
						arg_8_1:RecordAudio("116161002", var_11_23)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_116161", "116161002", "story_v_out_116161.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_116161", "116161002", "story_v_out_116161.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_24 = var_11_15 + 0.3
			local var_11_25 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 + 0.3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_24 + var_11_25 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_24) / var_11_25

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_24 + var_11_25 and arg_8_1.time_ < var_11_24 + var_11_25 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0112",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play116161003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116161003
		arg_14_1.duration_ = 7.2

		local var_14_0 = {
			zh = 6.86666666666667,
			ja = 7.19966666666667
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116161004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.bgs_.SK0107 == nil then
				local var_17_0 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0107")
				var_17_0.name = "SK0107"
				var_17_0.transform.parent = arg_14_1.stage_.transform
				var_17_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_.SK0107 = var_17_0
			end

			if 2 < arg_14_1.time_ and arg_14_1.time_ <= 2 + arg_17_0 then
				local var_17_1 = arg_14_1.bgs_.SK0107

				arg_14_1.bgs_.SK0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_17_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_2 = var_17_1:GetComponent("SpriteRenderer")

				if var_17_2 and var_17_2.sprite then
					local var_17_3 = 2 * (var_17_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_17_1.transform.localScale = Vector3.New(var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "SK0107" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_4 = 0

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_5 = 2

			if var_17_4 <= arg_14_1.time_ and arg_14_1.time_ < var_17_4 + var_17_5 then
				local var_17_6 = Color.New(0, 0, 0)

				var_17_6.a = Mathf.Lerp(0, 1, (arg_14_1.time_ - var_17_4) / var_17_5)
				arg_14_1.mask_.color = var_17_6
			end

			if arg_14_1.time_ >= var_17_4 + var_17_5 and arg_14_1.time_ < var_17_4 + var_17_5 + arg_17_0 then
				local var_17_7 = Color.New(0, 0, 0)

				var_17_7.a = 1
				arg_14_1.mask_.color = var_17_7
			end

			local var_17_8 = 2

			if 2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_9 = 2

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_9 then
				local var_17_10 = Color.New(0, 0, 0)

				var_17_10.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_8) / var_17_9)
				arg_14_1.mask_.color = var_17_10
			end

			if arg_14_1.time_ >= var_17_8 + var_17_9 and arg_14_1.time_ < var_17_8 + var_17_9 + arg_17_0 then
				local var_17_11 = Color.New(0, 0, 0)

				arg_14_1.mask_.enabled = false
				var_17_11.a = 0
				arg_14_1.mask_.color = var_17_11
			end

			local var_17_12 = arg_14_1.bgs_.SK0107.transform

			if 2 < arg_14_1.time_ and arg_14_1.time_ <= 2 + arg_17_0 then
				arg_14_1.var_.moveOldPosSK0107 = var_17_12.localPosition
			end

			local var_17_13 = 3

			if 2 <= arg_14_1.time_ and arg_14_1.time_ < 2 + var_17_13 then
				var_17_12.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPosSK0107, Vector3.New(0, 1, 9.5), (arg_14_1.time_ - 2) / var_17_13)
			end

			if arg_14_1.time_ >= 2 + var_17_13 and arg_14_1.time_ < 2 + var_17_13 + arg_17_0 then
				var_17_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_17_14 = 4

			if 4 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_14 + 1 and arg_14_1.time_ < var_17_14 + 1 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_15 = 3.96666666666667
			local var_17_16 = 0.175

			if 3.96666666666667 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_17 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_17:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(116161003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_21 = 7 <= 0 and var_17_16 or var_17_16 * (utf8.len(var_17_19) / 7)

				if (7 <= 0 and var_17_16 or var_17_16 * (utf8.len(var_17_19) / 7)) > 0 and var_17_16 < var_17_21 then
					arg_14_1.talkMaxDuration = var_17_21
					var_17_15 = var_17_15 + 0.3

					if var_17_21 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_21 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161003", "story_v_out_116161.awb") ~= 0 then
					local var_17_22 = manager.audio:GetVoiceLength("story_v_out_116161", "116161003", "story_v_out_116161.awb") / 1000

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_116161", "116161003", "story_v_out_116161.awb")

						arg_14_1:RecordAudio("116161003", var_17_23)
						arg_14_1:RecordAudio("116161003", var_17_23)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_116161", "116161003", "story_v_out_116161.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_116161", "116161003", "story_v_out_116161.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_24 = var_17_15 + 0.3
			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 + 0.3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_24 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_24) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_24 + var_17_25 and arg_14_1.time_ < var_17_24 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116161004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116161004
		arg_20_1.duration_ = 8.7

		local var_20_0 = {
			zh = 8.566,
			ja = 8.7
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play116161005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.bgs_.SK0106 == nil then
				local var_23_0 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0106")
				var_23_0.name = "SK0106"
				var_23_0.transform.parent = arg_20_1.stage_.transform
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_.SK0106 = var_23_0
			end

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= 2 + arg_23_0 then
				if arg_20_0.sceneSettingEffect_ then
					arg_20_1.sceneSettingEffect_.enabled = false
				end

				arg_20_1.sceneSettingGo_:SetActive(true)

				local var_23_1 = arg_20_1.bgs_.SK0106

				arg_20_1.bgs_.SK0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_2 = var_23_1:GetComponent("SpriteRenderer")

				if var_23_2 and var_23_2.sprite then
					local var_23_3 = 2 * (var_23_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_1.transform.localScale = Vector3.New(var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "SK0106" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_4 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_5 = 2

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_5 then
				local var_23_6 = Color.New(0, 0, 0)

				var_23_6.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_4) / var_23_5)
				arg_20_1.mask_.color = var_23_6
			end

			if arg_20_1.time_ >= var_23_4 + var_23_5 and arg_20_1.time_ < var_23_4 + var_23_5 + arg_23_0 then
				local var_23_7 = Color.New(0, 0, 0)

				var_23_7.a = 1
				arg_20_1.mask_.color = var_23_7
			end

			local var_23_8 = 2

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_9 = 2

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_9 then
				local var_23_10 = Color.New(0, 0, 0)

				var_23_10.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_8) / var_23_9)
				arg_20_1.mask_.color = var_23_10
			end

			if arg_20_1.time_ >= var_23_8 + var_23_9 and arg_20_1.time_ < var_23_8 + var_23_9 + arg_23_0 then
				local var_23_11 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_11.a = 0
				arg_20_1.mask_.color = var_23_11
			end

			local var_23_12 = arg_20_1.bgs_.SK0106.transform

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= 2 + arg_23_0 then
				arg_20_1.var_.moveOldPosSK0106 = var_23_12.localPosition
			end

			local var_23_13 = 3

			if 2 <= arg_20_1.time_ and arg_20_1.time_ < 2 + var_23_13 then
				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPosSK0106, Vector3.New(0, 1, 9.5), (arg_20_1.time_ - 2) / var_23_13)
			end

			if arg_20_1.time_ >= 2 + var_23_13 and arg_20_1.time_ < 2 + var_23_13 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_23_14 = 4

			if 4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_14 + 1 and arg_20_1.time_ < var_23_14 + 1 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_15 = 4
			local var_23_16 = 0.366666666666666

			if 4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_17 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_17:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(116161004)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 17 <= 0 and var_23_16 or var_23_16 * (utf8.len(var_23_19) / 17)

				if (17 <= 0 and var_23_16 or var_23_16 * (utf8.len(var_23_19) / 17)) > 0 and var_23_16 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21
					var_23_15 = var_23_15 + 0.3

					if var_23_21 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161004", "story_v_out_116161.awb") ~= 0 then
					local var_23_22 = manager.audio:GetVoiceLength("story_v_out_116161", "116161004", "story_v_out_116161.awb") / 1000

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_116161", "116161004", "story_v_out_116161.awb")

						arg_20_1:RecordAudio("116161004", var_23_23)
						arg_20_1:RecordAudio("116161004", var_23_23)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_116161", "116161004", "story_v_out_116161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_116161", "116161004", "story_v_out_116161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = var_23_15 + 0.3
			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_24 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_24) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_24 + var_23_25 and arg_20_1.time_ < var_23_24 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play116161005 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116161005
		arg_26_1.duration_ = 12.28

		local var_26_0 = {
			zh = 5.71666666666667,
			ja = 12.2826666666667
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116161006(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.bgs_.STblack == nil then
				local var_29_0 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_29_0.name = "STblack"
				var_29_0.transform.parent = arg_26_1.stage_.transform
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_.STblack = var_29_0
			end

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				local var_29_1 = arg_26_1.bgs_.STblack

				arg_26_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_2 = var_29_1:GetComponent("SpriteRenderer")

				if var_29_2 and var_29_2.sprite then
					local var_29_3 = 2 * (var_29_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_1.transform.localScale = Vector3.New(var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "STblack" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_4 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_5 = 2

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_5 then
				local var_29_6 = Color.New(0, 0, 0)

				var_29_6.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_4) / var_29_5)
				arg_26_1.mask_.color = var_29_6
			end

			if arg_26_1.time_ >= var_29_4 + var_29_5 and arg_26_1.time_ < var_29_4 + var_29_5 + arg_29_0 then
				local var_29_7 = Color.New(0, 0, 0)

				var_29_7.a = 1
				arg_26_1.mask_.color = var_29_7
			end

			local var_29_8 = 2

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_9 = 0.0166666666666667

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_9 then
				local var_29_10 = Color.New(0, 0, 0)

				var_29_10.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_8) / var_29_9)
				arg_26_1.mask_.color = var_29_10
			end

			if arg_26_1.time_ >= var_29_8 + var_29_9 and arg_26_1.time_ < var_29_8 + var_29_9 + arg_29_0 then
				local var_29_11 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_11.a = 0
				arg_26_1.mask_.color = var_29_11
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_12 = 2.01666666666667
			local var_29_13 = 0.325

			if 2.01666666666667 < arg_26_1.time_ and arg_26_1.time_ <= var_29_12 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_14 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_14:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_15 = arg_26_1:GetWordFromCfg(116161005)
				local var_29_16 = arg_26_1:FormatText(var_29_15.content)

				arg_26_1.text_.text = var_29_16

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_18 = 13 <= 0 and var_29_13 or var_29_13 * (utf8.len(var_29_16) / 13)

				if (13 <= 0 and var_29_13 or var_29_13 * (utf8.len(var_29_16) / 13)) > 0 and var_29_13 < var_29_18 then
					arg_26_1.talkMaxDuration = var_29_18
					var_29_12 = var_29_12 + 0.3

					if var_29_18 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_18 + var_29_12
					end
				end

				arg_26_1.text_.text = var_29_16
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161005", "story_v_out_116161.awb") ~= 0 then
					local var_29_19 = manager.audio:GetVoiceLength("story_v_out_116161", "116161005", "story_v_out_116161.awb") / 1000

					if var_29_19 + var_29_12 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_19 + var_29_12
					end

					if var_29_15.prefab_name ~= "" and arg_26_1.actors_[var_29_15.prefab_name] ~= nil then
						local var_29_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_15.prefab_name].transform, "story_v_out_116161", "116161005", "story_v_out_116161.awb")

						arg_26_1:RecordAudio("116161005", var_29_20)
						arg_26_1:RecordAudio("116161005", var_29_20)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116161", "116161005", "story_v_out_116161.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116161", "116161005", "story_v_out_116161.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_21 = var_29_12 + 0.3
			local var_29_22 = math.max(var_29_13, arg_26_1.talkMaxDuration)

			if var_29_12 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_21 + var_29_22 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_21) / var_29_22

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_21 + var_29_22 and arg_26_1.time_ < var_29_21 + var_29_22 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116161006 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116161006
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play116161007(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.bgs_.ST01 == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_35_0.name = "ST01"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.ST01 = var_35_0
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.ST01

				arg_32_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST01" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_4 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_5 = 2

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_5 then
				local var_35_6 = Color.New(0, 0, 0)

				var_35_6.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_4) / var_35_5)
				arg_32_1.mask_.color = var_35_6
			end

			if arg_32_1.time_ >= var_35_4 + var_35_5 and arg_32_1.time_ < var_35_4 + var_35_5 + arg_35_0 then
				local var_35_7 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_7.a = 0
				arg_32_1.mask_.color = var_35_7
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_8 = 2
			local var_35_9 = 0.725

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_10 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_10:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(116161006).content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 29 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 29)

				if (29 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 29)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13
					var_35_8 = var_35_8 + 0.3

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = var_35_8 + 0.3
			local var_35_15 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_14) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_14 + var_35_15 and arg_32_1.time_ < var_35_14 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play116161007 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116161007
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116161008(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.525

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(116161007).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 21 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 21)

				if (21 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 21)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play116161008 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116161008
		arg_42_1.duration_ = 9.17

		local var_42_0 = {
			zh = 7.566,
			ja = 9.166
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116161009(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_45_0 = 0.6

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				local var_45_1, var_45_2 = math.modf((arg_42_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_45_2 * 0.13, var_45_2 * 0.13, var_45_2 * 0.13) + arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				manager.ui.mainCamera.transform.localPosition = arg_42_1.var_.shakeOldPos
			end

			local var_45_3 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 0.6 and arg_42_1.time_ < var_45_3 + 0.6 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_45_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_6 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_6

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_6
						arg_42_1.bgmTxt2_.text = var_45_6
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_42_1.time_ and arg_42_1.time_ <= 0.4 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= "" and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = ""

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = ""
						arg_42_1.bgmTxt2_.text = ""
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.575 < arg_42_1.time_ and arg_42_1.time_ <= 0.575 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "dialog", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[95].musicName ~= "" then
					if arg_42_1.bgmTxt_.text ~= MusicRecordCfg[95].musicName and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = MusicRecordCfg[95].musicName

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = MusicRecordCfg[95].musicName
						arg_42_1.bgmTxt2_.text = MusicRecordCfg[95].musicName
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_10 = 0
			local var_45_11 = 0.575

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_12 = arg_42_1:GetWordFromCfg(116161008)
				local var_45_13 = arg_42_1:FormatText(var_45_12.content)

				arg_42_1.text_.text = var_45_13

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_15 = 23 <= 0 and var_45_11 or var_45_11 * (utf8.len(var_45_13) / 23)

				if (23 <= 0 and var_45_11 or var_45_11 * (utf8.len(var_45_13) / 23)) > 0 and var_45_11 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_10
					end
				end

				arg_42_1.text_.text = var_45_13
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161008", "story_v_out_116161.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_116161", "116161008", "story_v_out_116161.awb") / 1000

					if var_45_16 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_10
					end

					if var_45_12.prefab_name ~= "" and arg_42_1.actors_[var_45_12.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_12.prefab_name].transform, "story_v_out_116161", "116161008", "story_v_out_116161.awb")

						arg_42_1:RecordAudio("116161008", var_45_17)
						arg_42_1:RecordAudio("116161008", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_116161", "116161008", "story_v_out_116161.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_116161", "116161008", "story_v_out_116161.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_11, arg_42_1.talkMaxDuration)

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_10) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_10 + var_45_18 and arg_42_1.time_ < var_45_10 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116161009 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116161009
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116161010(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.875

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(116161009).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 35 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 35)

				if (35 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 35)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play116161010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116161010
		arg_53_1.duration_ = 6

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116161011(arg_53_1)
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
				local var_56_1 = Color.New(0, 0, 0)

				var_56_1.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.mask_.color = var_56_1
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				local var_56_2 = Color.New(0, 0, 0)

				var_56_2.a = 1
				arg_53_1.mask_.color = var_56_2
			end

			local var_56_3 = 1

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_4 = 1

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_4 then
				local var_56_5 = Color.New(0, 0, 0)

				var_56_5.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_3) / var_56_4)
				arg_53_1.mask_.color = var_56_5
			end

			if arg_53_1.time_ >= var_56_3 + var_56_4 and arg_53_1.time_ < var_56_3 + var_56_4 + arg_56_0 then
				local var_56_6 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_6.a = 0
				arg_53_1.mask_.color = var_56_6
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door05", "")
			end

			local var_56_8 = "10025ui_story"

			if arg_53_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_56_9 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_53_1.stage_.transform)

				var_56_9.name = var_56_8
				var_56_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_[var_56_8] = var_56_9

				local var_56_10 = var_56_9:GetComponentInChildren(typeof(CharacterEffect))

				var_56_10.enabled = true

				local var_56_11 = GameObjectTools.GetOrAddComponent(var_56_9, typeof(DynamicBoneHelper))

				if var_56_11 then
					var_56_11:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_10.transform, false)

				arg_53_1.var_[var_56_8 .. "Animator"] = var_56_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_[var_56_8 .. "Animator"].applyRootMotion = true
				arg_53_1.var_[var_56_8 .. "LipSync"] = var_56_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_12 = arg_53_1.actors_["10025ui_story"].transform

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= 1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10025ui_story = var_56_12.localPosition
			end

			local var_56_13 = 0.001

			if 1 <= arg_53_1.time_ and arg_53_1.time_ < 1 + var_56_13 then
				var_56_12.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_53_1.time_ - 1) / var_56_13)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			if arg_53_1.time_ >= 1 + var_56_13 and arg_53_1.time_ < 1 + var_56_13 + arg_56_0 then
				var_56_12.localPosition = Vector3.New(0, -1.1, -5.9)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= 1 + arg_56_0 then
				arg_53_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= 1 + arg_56_0 then
				arg_53_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_14 = arg_53_1.actors_["10025ui_story"]

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= 1 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect10025ui_story == nil then
				arg_53_1.var_.characterEffect10025ui_story = var_56_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_15 = 0.2

			if 1 <= arg_53_1.time_ and arg_53_1.time_ < 1 + var_56_15 and not isNil(var_56_14) then
				if arg_53_1.var_.characterEffect10025ui_story and not isNil(var_56_14) then
					arg_53_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 1) / var_56_15)
				end
			end

			if arg_53_1.time_ >= 1 + var_56_15 and arg_53_1.time_ < 1 + var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect10025ui_story then
				arg_53_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_16 = 1
			local var_56_17 = 0.1

			if 1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_18 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_18:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_19 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(116161010).content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 4 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_19) / 4)

				if (4 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_19) / 4)) > 0 and var_56_17 < var_56_21 then
					arg_53_1.talkMaxDuration = var_56_21
					var_56_16 = var_56_16 + 0.3

					if var_56_21 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = var_56_16 + 0.3
			local var_56_23 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_22 + var_56_23 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_22) / var_56_23

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_22 + var_56_23 and arg_53_1.time_ < var_56_22 + var_56_23 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play116161011 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116161011
		arg_59_1.duration_ = 2.9

		local var_59_0 = {
			zh = 2.8,
			ja = 2.9
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
				arg_59_0:Play116161012(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10025ui_story = arg_59_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).z)
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles = arg_59_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_59_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["10025ui_story"].transform.position).z)
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["10025ui_story"].transform.localEulerAngles = arg_59_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["10025ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10025ui_story == nil then
				arg_59_1.var_.characterEffect10025ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect10025ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10025ui_story then
				arg_59_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.15

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(116161011)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 6 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 6)

				if (6 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 6)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161011", "story_v_out_116161.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161011", "story_v_out_116161.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_116161", "116161011", "story_v_out_116161.awb")

						arg_59_1:RecordAudio("116161011", var_62_11)
						arg_59_1:RecordAudio("116161011", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116161", "116161011", "story_v_out_116161.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116161", "116161011", "story_v_out_116161.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play116161012 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116161012
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play116161013(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story == nil then
				arg_63_1.var_.characterEffect10025ui_story = arg_63_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) then
				if arg_63_1.var_.characterEffect10025ui_story and not isNil(arg_63_1.actors_["10025ui_story"]) then
					arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10025ui_story"]) and arg_63_1.var_.characterEffect10025ui_story then
				arg_63_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.5

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(116161012).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 20 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 20)

				if (20 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 20)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116161013 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116161013
		arg_67_1.duration_ = 9.53

		local var_67_0 = {
			zh = 5.233,
			ja = 9.533
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
				arg_67_0:Play116161014(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["10025ui_story"]) and arg_67_1.var_.characterEffect10025ui_story == nil then
				arg_67_1.var_.characterEffect10025ui_story = arg_67_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["10025ui_story"]) then
				if arg_67_1.var_.characterEffect10025ui_story and not isNil(arg_67_1.actors_["10025ui_story"]) then
					arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["10025ui_story"]) and arg_67_1.var_.characterEffect10025ui_story then
				arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action428")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.425

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(116161013)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 17 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 17)

				if (17 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 17)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161013", "story_v_out_116161.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161013", "story_v_out_116161.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_116161", "116161013", "story_v_out_116161.awb")

						arg_67_1:RecordAudio("116161013", var_70_9)
						arg_67_1:RecordAudio("116161013", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116161", "116161013", "story_v_out_116161.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116161", "116161013", "story_v_out_116161.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play116161014 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116161014
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play116161015(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = arg_71_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) then
				if arg_71_1.var_.characterEffect10025ui_story and not isNil(arg_71_1.actors_["10025ui_story"]) then
					arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10025ui_story"]) and arg_71_1.var_.characterEffect10025ui_story then
				arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.225

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(116161014).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 9 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 9)

				if (9 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 9)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play116161015 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116161015
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116161016(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.85

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116161015).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 34 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 34)

				if (34 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 34)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116161016 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116161016
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116161017(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.375

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(116161016).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 15 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 15)

				if (15 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 15)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116161017 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116161017
		arg_83_1.duration_ = 6.37

		local var_83_0 = {
			zh = 3.433,
			ja = 6.366
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
				arg_83_0:Play116161018(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = arg_83_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) then
				if arg_83_1.var_.characterEffect10025ui_story and not isNil(arg_83_1.actors_["10025ui_story"]) then
					arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story then
				arg_83_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action487")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_86_2 = 0
			local var_86_3 = 0.25

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(116161017)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 10 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 10)

				if (10 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 10)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161017", "story_v_out_116161.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161017", "story_v_out_116161.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_116161", "116161017", "story_v_out_116161.awb")

						arg_83_1:RecordAudio("116161017", var_86_9)
						arg_83_1:RecordAudio("116161017", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_116161", "116161017", "story_v_out_116161.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_116161", "116161017", "story_v_out_116161.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116161018 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116161018
		arg_87_1.duration_ = 0.2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"

			SetActive(arg_87_1.choicesGo_, true)

			for iter_88_0, iter_88_1 in ipairs(arg_87_1.choices_) do
				SetActive(iter_88_1.go, iter_88_0 <= 1)
			end

			arg_87_1.choices_[1].txt.text = arg_87_1:FormatText(StoryChoiceCfg[252].name)
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116161019(arg_87_1)
			end

			arg_87_1:RecordChoiceLog(116161018, 252)
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) and arg_87_1.var_.characterEffect10025ui_story == nil then
				arg_87_1.var_.characterEffect10025ui_story = arg_87_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) then
				if arg_87_1.var_.characterEffect10025ui_story and not isNil(arg_87_1.actors_["10025ui_story"]) then
					arg_87_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) and arg_87_1.var_.characterEffect10025ui_story then
				arg_87_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116161019 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116161019
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play116161020(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.65

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(116161019).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 26 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 26)

				if (26 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 26)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116161020 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116161020
		arg_95_1.duration_ = 2.97

		local var_95_0 = {
			zh = 2.966,
			ja = 2.4
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
				arg_95_0:Play116161021(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) and arg_95_1.var_.characterEffect10025ui_story == nil then
				arg_95_1.var_.characterEffect10025ui_story = arg_95_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) then
				if arg_95_1.var_.characterEffect10025ui_story and not isNil(arg_95_1.actors_["10025ui_story"]) then
					arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10025ui_story"]) and arg_95_1.var_.characterEffect10025ui_story then
				arg_95_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action478")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_98_2 = 0
			local var_98_3 = 0.225

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(116161020)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 9 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 9)

				if (9 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 9)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161020", "story_v_out_116161.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161020", "story_v_out_116161.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_116161", "116161020", "story_v_out_116161.awb")

						arg_95_1:RecordAudio("116161020", var_98_9)
						arg_95_1:RecordAudio("116161020", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116161", "116161020", "story_v_out_116161.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116161", "116161020", "story_v_out_116161.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play116161021 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116161021
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116161022(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10025ui_story = arg_99_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).z)
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles = arg_99_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10025ui_story"].transform.position).z)
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10025ui_story"].transform.localEulerAngles = arg_99_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_102_1 = 0
			local var_102_2 = 1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(116161021).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 40 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 40)

				if (40 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 40)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116161022 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116161022
		arg_103_1.duration_ = 7.13

		local var_103_0 = {
			zh = 6.466666666666,
			ja = 7.133
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
				arg_103_0:Play116161023(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.bgs_.I03 == nil then
				local var_106_0 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I03")
				var_106_0.name = "I03"
				var_106_0.transform.parent = arg_103_1.stage_.transform
				var_106_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_.I03 = var_106_0
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_1 = arg_103_1.bgs_.I03

				arg_103_1.bgs_.I03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_2 = var_106_1:GetComponent("SpriteRenderer")

				if var_106_2 and var_106_2.sprite then
					local var_106_3 = 2 * (var_106_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_1.transform.localScale = Vector3.New(var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "I03" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_4 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_5 = 2

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_5 then
				local var_106_6 = Color.New(0, 0, 0)

				var_106_6.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_4) / var_106_5)
				arg_103_1.mask_.color = var_106_6
			end

			if arg_103_1.time_ >= var_106_4 + var_106_5 and arg_103_1.time_ < var_106_4 + var_106_5 + arg_106_0 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = 1
				arg_103_1.mask_.color = var_106_7
			end

			local var_106_8 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_9 = 2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 then
				local var_106_10 = Color.New(0, 0, 0)

				var_106_10.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_8) / var_106_9)
				arg_103_1.mask_.color = var_106_10
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 then
				local var_106_11 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_11.a = 0
				arg_103_1.mask_.color = var_106_11
			end

			local var_106_12 = "1084ui_story"

			if arg_103_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_106_13 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_103_1.stage_.transform)

				var_106_13.name = var_106_12
				var_106_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_12] = var_106_13

				local var_106_14 = var_106_13:GetComponentInChildren(typeof(CharacterEffect))

				var_106_14.enabled = true

				local var_106_15 = GameObjectTools.GetOrAddComponent(var_106_13, typeof(DynamicBoneHelper))

				if var_106_15 then
					var_106_15:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_14.transform, false)

				arg_103_1.var_[var_106_12 .. "Animator"] = var_106_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_12 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_12 .. "LipSync"] = var_106_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_106_16 = arg_103_1.actors_["1084ui_story"].transform

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1.var_.moveOldPos1084ui_story = var_106_16.localPosition
			end

			local var_106_17 = 0.001

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_17 then
				var_106_16.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_103_1.time_ - 3.8) / var_106_17)
				var_106_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_16.position).x, (manager.ui.mainCamera.transform.position - var_106_16.position).y, (manager.ui.mainCamera.transform.position - var_106_16.position).z)
				var_106_16.localEulerAngles.z = 0
				var_106_16.localEulerAngles.x = 0
				var_106_16.localEulerAngles = var_106_16.localEulerAngles
			end

			if arg_103_1.time_ >= 3.8 + var_106_17 and arg_103_1.time_ < 3.8 + var_106_17 + arg_106_0 then
				var_106_16.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_106_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_16.position).x, (manager.ui.mainCamera.transform.position - var_106_16.position).y, (manager.ui.mainCamera.transform.position - var_106_16.position).z)
				var_106_16.localEulerAngles.z = 0
				var_106_16.localEulerAngles.x = 0
				var_106_16.localEulerAngles = var_106_16.localEulerAngles
			end

			local var_106_18 = arg_103_1.actors_["1084ui_story"]

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = var_106_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_19 = 0.2

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_19 and not isNil(var_106_18) then
				if arg_103_1.var_.characterEffect1084ui_story and not isNil(var_106_18) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 3.8 + var_106_19 and arg_103_1.time_ < 3.8 + var_106_19 + arg_106_0 and not isNil(var_106_18) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_106_21 = "1011ui_story"

			if arg_103_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_106_22 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_103_1.stage_.transform)

				var_106_22.name = var_106_21
				var_106_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_[var_106_21] = var_106_22

				local var_106_23 = var_106_22:GetComponentInChildren(typeof(CharacterEffect))

				var_106_23.enabled = true

				local var_106_24 = GameObjectTools.GetOrAddComponent(var_106_22, typeof(DynamicBoneHelper))

				if var_106_24 then
					var_106_24:EnableDynamicBone(false)
				end

				arg_103_1:ShowWeapon(var_106_23.transform, false)

				arg_103_1.var_[var_106_21 .. "Animator"] = var_106_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_103_1.var_[var_106_21 .. "Animator"].applyRootMotion = true
				arg_103_1.var_[var_106_21 .. "LipSync"] = var_106_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_106_25 = arg_103_1.actors_["1011ui_story"].transform

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1.var_.moveOldPos1011ui_story = var_106_25.localPosition
			end

			local var_106_26 = 0.001

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_26 then
				var_106_25.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_103_1.time_ - 3.8) / var_106_26)
				var_106_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_25.position).x, (manager.ui.mainCamera.transform.position - var_106_25.position).y, (manager.ui.mainCamera.transform.position - var_106_25.position).z)
				var_106_25.localEulerAngles.z = 0
				var_106_25.localEulerAngles.x = 0
				var_106_25.localEulerAngles = var_106_25.localEulerAngles
			end

			if arg_103_1.time_ >= 3.8 + var_106_26 and arg_103_1.time_ < 3.8 + var_106_26 + arg_106_0 then
				var_106_25.localPosition = Vector3.New(0.7, -0.71, -6)
				var_106_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_25.position).x, (manager.ui.mainCamera.transform.position - var_106_25.position).y, (manager.ui.mainCamera.transform.position - var_106_25.position).z)
				var_106_25.localEulerAngles.z = 0
				var_106_25.localEulerAngles.x = 0
				var_106_25.localEulerAngles = var_106_25.localEulerAngles
			end

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 then
				arg_103_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_106_27 = arg_103_1.actors_["1011ui_story"]

			if 3.8 < arg_103_1.time_ and arg_103_1.time_ <= 3.8 + arg_106_0 and not isNil(var_106_27) and arg_103_1.var_.characterEffect1011ui_story == nil then
				arg_103_1.var_.characterEffect1011ui_story = var_106_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_28 = 0.2

			if 3.8 <= arg_103_1.time_ and arg_103_1.time_ < 3.8 + var_106_28 and not isNil(var_106_27) then
				if arg_103_1.var_.characterEffect1011ui_story and not isNil(var_106_27) then
					arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 3.8) / var_106_28)
				end
			end

			if arg_103_1.time_ >= 3.8 + var_106_28 and arg_103_1.time_ < 3.8 + var_106_28 + arg_106_0 and not isNil(var_106_27) and arg_103_1.var_.characterEffect1011ui_story then
				arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_106_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_31 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_31

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_31
						arg_103_1.bgmTxt2_.text = var_106_31
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.4 < arg_103_1.time_ and arg_103_1.time_ <= 1.4 + arg_106_0 then
				arg_103_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_106_34 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_34 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_34

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_34
						arg_103_1.bgmTxt2_.text = var_106_34
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_35 = 4
			local var_106_36 = 0.2

			if 4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_35 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_37 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_37:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_103_1.dialogCg_.alpha = arg_109_0
				end))
				var_106_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_38 = arg_103_1:GetWordFromCfg(116161022)
				local var_106_39 = arg_103_1:FormatText(var_106_38.content)

				arg_103_1.text_.text = var_106_39

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_41 = 8 <= 0 and var_106_36 or var_106_36 * (utf8.len(var_106_39) / 8)

				if (8 <= 0 and var_106_36 or var_106_36 * (utf8.len(var_106_39) / 8)) > 0 and var_106_36 < var_106_41 then
					arg_103_1.talkMaxDuration = var_106_41
					var_106_35 = var_106_35 + 0.3

					if var_106_41 + var_106_35 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_41 + var_106_35
					end
				end

				arg_103_1.text_.text = var_106_39
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161022", "story_v_out_116161.awb") ~= 0 then
					local var_106_42 = manager.audio:GetVoiceLength("story_v_out_116161", "116161022", "story_v_out_116161.awb") / 1000

					if var_106_42 + var_106_35 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_42 + var_106_35
					end

					if var_106_38.prefab_name ~= "" and arg_103_1.actors_[var_106_38.prefab_name] ~= nil then
						local var_106_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_38.prefab_name].transform, "story_v_out_116161", "116161022", "story_v_out_116161.awb")

						arg_103_1:RecordAudio("116161022", var_106_43)
						arg_103_1:RecordAudio("116161022", var_106_43)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_116161", "116161022", "story_v_out_116161.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_116161", "116161022", "story_v_out_116161.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_44 = var_106_35 + 0.3
			local var_106_45 = math.max(var_106_36, arg_103_1.talkMaxDuration)

			if var_106_35 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_44 + var_106_45 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_44) / var_106_45

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_44 + var_106_45 and arg_103_1.time_ < var_106_44 + var_106_45 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play116161023 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116161023
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116161024(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = arg_111_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) then
				if arg_111_1.var_.characterEffect1084ui_story and not isNil(arg_111_1.actors_["1084ui_story"]) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.25

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(116161023).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 10 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 10)

				if (10 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 10)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116161024 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116161024
		arg_115_1.duration_ = 4.97

		local var_115_0 = {
			zh = 4.966,
			ja = 3.333
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
				arg_115_0:Play116161025(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_118_0 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_1 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 and not isNil(var_118_0) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_118_3 = 0
			local var_118_4 = 0.625

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:GetWordFromCfg(116161024)
				local var_118_6 = arg_115_1:FormatText(var_118_5.content)

				arg_115_1.text_.text = var_118_6

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_8 = 25 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 25)

				if (25 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 25)) > 0 and var_118_4 < var_118_8 then
					arg_115_1.talkMaxDuration = var_118_8

					if var_118_8 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_6
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161024", "story_v_out_116161.awb") ~= 0 then
					local var_118_9 = manager.audio:GetVoiceLength("story_v_out_116161", "116161024", "story_v_out_116161.awb") / 1000

					if var_118_9 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_3
					end

					if var_118_5.prefab_name ~= "" and arg_115_1.actors_[var_118_5.prefab_name] ~= nil then
						local var_118_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_5.prefab_name].transform, "story_v_out_116161", "116161024", "story_v_out_116161.awb")

						arg_115_1:RecordAudio("116161024", var_118_10)
						arg_115_1:RecordAudio("116161024", var_118_10)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116161", "116161024", "story_v_out_116161.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116161", "116161024", "story_v_out_116161.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_11 and arg_115_1.time_ < var_118_3 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play116161025 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116161025
		arg_119_1.duration_ = 7.4

		local var_119_0 = {
			zh = 7.4,
			ja = 6.766
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
				arg_119_0:Play116161026(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1084ui_story = arg_119_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_119_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1084ui_story"].transform.position).z)
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1084ui_story"].transform.localEulerAngles = arg_119_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1011ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1011ui_story = var_122_1.localPosition
			end

			local var_122_2 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_119_1.time_ - 0) / var_122_2)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(0.7, -0.71, -6)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			local var_122_3 = arg_119_1.actors_["1011ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = var_122_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_4 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 and not isNil(var_122_3) then
				if arg_119_1.var_.characterEffect1011ui_story and not isNil(var_122_3) then
					arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 and not isNil(var_122_3) and arg_119_1.var_.characterEffect1011ui_story then
				arg_119_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_122_6 = arg_119_1.actors_["1084ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 and not isNil(var_122_6) then
				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_7)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1084ui_story then
				arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_122_8 = 0
			local var_122_9 = 0.8

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(116161025)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 32 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 32)

				if (32 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 32)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161025", "story_v_out_116161.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_116161", "116161025", "story_v_out_116161.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_116161", "116161025", "story_v_out_116161.awb")

						arg_119_1:RecordAudio("116161025", var_122_15)
						arg_119_1:RecordAudio("116161025", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_116161", "116161025", "story_v_out_116161.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_116161", "116161025", "story_v_out_116161.awb")
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play116161026 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116161026
		arg_123_1.duration_ = 12.73

		local var_123_0 = {
			zh = 8.333,
			ja = 12.733
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
				arg_123_0:Play116161027(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = arg_123_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(arg_123_1.actors_["1084ui_story"]) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1084ui_story"]) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1011ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1011ui_story == nil then
				arg_123_1.var_.characterEffect1011ui_story = var_126_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.characterEffect1011ui_story and not isNil(var_126_2) then
					arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_3)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.characterEffect1011ui_story then
				arg_123_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.9

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(116161026)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 36 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 36)

				if (36 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 36)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161026", "story_v_out_116161.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161026", "story_v_out_116161.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_116161", "116161026", "story_v_out_116161.awb")

						arg_123_1:RecordAudio("116161026", var_126_11)
						arg_123_1:RecordAudio("116161026", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116161", "116161026", "story_v_out_116161.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116161", "116161026", "story_v_out_116161.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play116161027 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116161027
		arg_127_1.duration_ = 8.2

		local var_127_0 = {
			zh = 5.3,
			ja = 8.2
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
				arg_127_0:Play116161028(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = arg_127_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(arg_127_1.actors_["1084ui_story"]) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["1011ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1011ui_story == nil then
				arg_127_1.var_.characterEffect1011ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1011ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1011ui_story then
				arg_127_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_130_4 = 0
			local var_130_5 = 0.375

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(116161027)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 15 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 15)

				if (15 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 15)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161027", "story_v_out_116161.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161027", "story_v_out_116161.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_116161", "116161027", "story_v_out_116161.awb")

						arg_127_1:RecordAudio("116161027", var_130_11)
						arg_127_1:RecordAudio("116161027", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_116161", "116161027", "story_v_out_116161.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_116161", "116161027", "story_v_out_116161.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play116161028 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 116161028
		arg_131_1.duration_ = 8.83

		local var_131_0 = {
			zh = 7.433,
			ja = 8.833
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
				arg_131_0:Play116161029(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = arg_131_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(arg_131_1.actors_["1084ui_story"]) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1084ui_story"]) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["1011ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1011ui_story == nil then
				arg_131_1.var_.characterEffect1011ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect1011ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1011ui_story then
				arg_131_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.925

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(116161028)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 37 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 37)

				if (37 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 37)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161028", "story_v_out_116161.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161028", "story_v_out_116161.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_116161", "116161028", "story_v_out_116161.awb")

						arg_131_1:RecordAudio("116161028", var_134_11)
						arg_131_1:RecordAudio("116161028", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_116161", "116161028", "story_v_out_116161.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_116161", "116161028", "story_v_out_116161.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play116161029 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116161029
		arg_135_1.duration_ = 4.3

		local var_135_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_135_0:Play116161030(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = arg_135_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) then
				if arg_135_1.var_.characterEffect1084ui_story and not isNil(arg_135_1.actors_["1084ui_story"]) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_138_1 = arg_135_1.actors_["1011ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1011ui_story == nil then
				arg_135_1.var_.characterEffect1011ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1011ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1011ui_story then
				arg_135_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(116161029)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 8 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 8)

				if (8 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 8)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161029", "story_v_out_116161.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161029", "story_v_out_116161.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_116161", "116161029", "story_v_out_116161.awb")

						arg_135_1:RecordAudio("116161029", var_138_11)
						arg_135_1:RecordAudio("116161029", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_116161", "116161029", "story_v_out_116161.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_116161", "116161029", "story_v_out_116161.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116161030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116161030
		arg_139_1.duration_ = 9

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116161031(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.bgs_.I06 == nil then
				local var_142_0 = Object.Instantiate(arg_139_1.paintGo_)

				var_142_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06")
				var_142_0.name = "I06"
				var_142_0.transform.parent = arg_139_1.stage_.transform
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.bgs_.I06 = var_142_0
			end

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= 2 + arg_142_0 then
				local var_142_1 = arg_139_1.bgs_.I06

				arg_139_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_2 = var_142_1:GetComponent("SpriteRenderer")

				if var_142_2 and var_142_2.sprite then
					local var_142_3 = 2 * (var_142_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_1.transform.localScale = Vector3.New(var_142_3 / var_142_2.sprite.bounds.size.y < var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x and var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x or var_142_3 / var_142_2.sprite.bounds.size.y, var_142_3 / var_142_2.sprite.bounds.size.y < var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x and var_142_3 * manager.ui.mainCameraCom_.aspect / var_142_2.sprite.bounds.size.x or var_142_3 / var_142_2.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "I06" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_4 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_5 = 2

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_5 then
				local var_142_6 = Color.New(0, 0, 0)

				var_142_6.a = Mathf.Lerp(0, 1, (arg_139_1.time_ - var_142_4) / var_142_5)
				arg_139_1.mask_.color = var_142_6
			end

			if arg_139_1.time_ >= var_142_4 + var_142_5 and arg_139_1.time_ < var_142_4 + var_142_5 + arg_142_0 then
				local var_142_7 = Color.New(0, 0, 0)

				var_142_7.a = 1
				arg_139_1.mask_.color = var_142_7
			end

			local var_142_8 = 2

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_9 = 2

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 then
				local var_142_10 = Color.New(0, 0, 0)

				var_142_10.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_8) / var_142_9)
				arg_139_1.mask_.color = var_142_10
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 then
				local var_142_11 = Color.New(0, 0, 0)

				arg_139_1.mask_.enabled = false
				var_142_11.a = 0
				arg_139_1.mask_.color = var_142_11
			end

			local var_142_12 = arg_139_1.actors_["1084ui_story"].transform

			if 1.966 < arg_139_1.time_ and arg_139_1.time_ <= 1.966 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_12.localPosition
			end

			local var_142_13 = 0.001

			if 1.966 <= arg_139_1.time_ and arg_139_1.time_ < 1.966 + var_142_13 then
				var_142_12.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 1.966) / var_142_13)
				var_142_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_12.position).x, (manager.ui.mainCamera.transform.position - var_142_12.position).y, (manager.ui.mainCamera.transform.position - var_142_12.position).z)
				var_142_12.localEulerAngles.z = 0
				var_142_12.localEulerAngles.x = 0
				var_142_12.localEulerAngles = var_142_12.localEulerAngles
			end

			if arg_139_1.time_ >= 1.966 + var_142_13 and arg_139_1.time_ < 1.966 + var_142_13 + arg_142_0 then
				var_142_12.localPosition = Vector3.New(0, 100, 0)
				var_142_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_12.position).x, (manager.ui.mainCamera.transform.position - var_142_12.position).y, (manager.ui.mainCamera.transform.position - var_142_12.position).z)
				var_142_12.localEulerAngles.z = 0
				var_142_12.localEulerAngles.x = 0
				var_142_12.localEulerAngles = var_142_12.localEulerAngles
			end

			local var_142_14 = arg_139_1.actors_["1011ui_story"].transform

			if 1.966 < arg_139_1.time_ and arg_139_1.time_ <= 1.966 + arg_142_0 then
				arg_139_1.var_.moveOldPos1011ui_story = var_142_14.localPosition
			end

			local var_142_15 = 0.001

			if 1.966 <= arg_139_1.time_ and arg_139_1.time_ < 1.966 + var_142_15 then
				var_142_14.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 1.966) / var_142_15)
				var_142_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_14.position).x, (manager.ui.mainCamera.transform.position - var_142_14.position).y, (manager.ui.mainCamera.transform.position - var_142_14.position).z)
				var_142_14.localEulerAngles.z = 0
				var_142_14.localEulerAngles.x = 0
				var_142_14.localEulerAngles = var_142_14.localEulerAngles
			end

			if arg_139_1.time_ >= 1.966 + var_142_15 and arg_139_1.time_ < 1.966 + var_142_15 + arg_142_0 then
				var_142_14.localPosition = Vector3.New(0, 100, 0)
				var_142_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_14.position).x, (manager.ui.mainCamera.transform.position - var_142_14.position).y, (manager.ui.mainCamera.transform.position - var_142_14.position).z)
				var_142_14.localEulerAngles.z = 0
				var_142_14.localEulerAngles.x = 0
				var_142_14.localEulerAngles = var_142_14.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_142_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_18 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_18

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_18
						arg_139_1.bgmTxt2_.text = var_142_18
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_19 = 4
			local var_142_20 = 0.75

			if 4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_21 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_21:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_139_1.dialogCg_.alpha = arg_144_0
				end))
				var_142_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_22 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(116161030).content)

				arg_139_1.text_.text = var_142_22

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_24 = 30 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_22) / 30)

				if (30 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_22) / 30)) > 0 and var_142_20 < var_142_24 then
					arg_139_1.talkMaxDuration = var_142_24
					var_142_19 = var_142_19 + 0.3

					if var_142_24 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_19
					end
				end

				arg_139_1.text_.text = var_142_22
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = var_142_19 + 0.3
			local var_142_26 = math.max(var_142_20, arg_139_1.talkMaxDuration)

			if var_142_19 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_25 + var_142_26 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_25) / var_142_26

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play116161031 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116161031
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116161032(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_149_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_2 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_2

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_2
						arg_146_1.bgmTxt2_.text = var_149_2
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_146_1.time_ and arg_146_1.time_ <= 0.4 + arg_149_0 then
				arg_146_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_149_5 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_146_1.bgmTxt_.text ~= var_149_5 and arg_146_1.bgmTxt_.text ~= "" then
						if arg_146_1.bgmTxt2_.text ~= "" then
							arg_146_1.bgmTxt_.text = arg_146_1.bgmTxt2_.text
						end

						arg_146_1.bgmTxt2_.text = var_149_5

						arg_146_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_146_1.bgmTxt_.text = var_149_5
						arg_146_1.bgmTxt2_.text = var_149_5
					end

					if arg_146_1.bgmTimer then
						arg_146_1.bgmTimer:Stop()

						arg_146_1.bgmTimer = nil
					end

					if arg_146_1.settingData.show_music_name == 1 then
						arg_146_1.musicController:SetSelectedState("show")
						arg_146_1.musicAnimator_:Play("open", 0, 0)

						if arg_146_1.settingData.music_time ~= 0 then
							arg_146_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_146_1.settingData.music_time), function()
								if arg_146_1 == nil or isNil(arg_146_1.bgmTxt_) then
									return
								end

								arg_146_1.musicController:SetSelectedState("hide")
								arg_146_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_149_6 = 0
			local var_149_7 = 1.075

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(116161031).content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 43 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 43)

				if (43 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 43)) > 0 and var_149_7 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_11 and arg_146_1.time_ < var_149_6 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116161032 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 116161032
		arg_152_1.duration_ = 5.7

		local var_152_0 = {
			zh = 5.7,
			ja = 2.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play116161033(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["10025ui_story"]) and arg_152_1.var_.characterEffect10025ui_story == nil then
				arg_152_1.var_.characterEffect10025ui_story = arg_152_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["10025ui_story"]) then
				if arg_152_1.var_.characterEffect10025ui_story and not isNil(arg_152_1.actors_["10025ui_story"]) then
					arg_152_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["10025ui_story"]) and arg_152_1.var_.characterEffect10025ui_story then
				arg_152_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_155_2 = arg_152_1.actors_["10025ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10025ui_story = var_155_2.localPosition
			end

			local var_155_3 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_152_1.time_ - 0) / var_155_3)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -1.1, -5.9)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			local var_155_4 = 0
			local var_155_5 = 0.1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(116161032)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 4 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 4)

				if (4 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 4)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161032", "story_v_out_116161.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161032", "story_v_out_116161.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_116161", "116161032", "story_v_out_116161.awb")

						arg_152_1:RecordAudio("116161032", var_155_11)
						arg_152_1:RecordAudio("116161032", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_116161", "116161032", "story_v_out_116161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_116161", "116161032", "story_v_out_116161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play116161033 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116161033
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play116161034(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["10025ui_story"]) and arg_156_1.var_.characterEffect10025ui_story == nil then
				arg_156_1.var_.characterEffect10025ui_story = arg_156_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["10025ui_story"]) then
				if arg_156_1.var_.characterEffect10025ui_story and not isNil(arg_156_1.actors_["10025ui_story"]) then
					arg_156_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["10025ui_story"]) and arg_156_1.var_.characterEffect10025ui_story then
				arg_156_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.775

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(116161033).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 31 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 31)

				if (31 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 31)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play116161034 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116161034
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116161035(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.2

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(116161034).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 8 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 8)

				if (8 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 8)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116161035 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116161035
		arg_164_1.duration_ = 7.27

		local var_164_0 = {
			zh = 5.466,
			ja = 7.266
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play116161036(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10025ui_story"]) and arg_164_1.var_.characterEffect10025ui_story == nil then
				arg_164_1.var_.characterEffect10025ui_story = arg_164_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10025ui_story"]) then
				if arg_164_1.var_.characterEffect10025ui_story and not isNil(arg_164_1.actors_["10025ui_story"]) then
					arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10025ui_story"]) and arg_164_1.var_.characterEffect10025ui_story then
				arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_167_2 = 0
			local var_167_3 = 0.375

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(116161035)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 15 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 15)

				if (15 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 15)) > 0 and var_167_3 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161035", "story_v_out_116161.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161035", "story_v_out_116161.awb") / 1000

					if var_167_8 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_2
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_116161", "116161035", "story_v_out_116161.awb")

						arg_164_1:RecordAudio("116161035", var_167_9)
						arg_164_1:RecordAudio("116161035", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_116161", "116161035", "story_v_out_116161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_116161", "116161035", "story_v_out_116161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_10 and arg_164_1.time_ < var_167_2 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play116161036 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 116161036
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play116161037(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["10025ui_story"]) and arg_168_1.var_.characterEffect10025ui_story == nil then
				arg_168_1.var_.characterEffect10025ui_story = arg_168_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["10025ui_story"]) then
				if arg_168_1.var_.characterEffect10025ui_story and not isNil(arg_168_1.actors_["10025ui_story"]) then
					arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["10025ui_story"]) and arg_168_1.var_.characterEffect10025ui_story then
				arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_171_1 = 0
			local var_171_2 = 0.525

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(116161036).content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 21 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 21)

				if (21 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 21)) > 0 and var_171_2 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_6 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_6 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_6

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_6 and arg_168_1.time_ < var_171_1 + var_171_6 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play116161037 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116161037
		arg_172_1.duration_ = 8.53

		local var_172_0 = {
			zh = 8.533,
			ja = 4.833
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
				arg_172_0:Play116161038(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10025ui_story"]) and arg_172_1.var_.characterEffect10025ui_story == nil then
				arg_172_1.var_.characterEffect10025ui_story = arg_172_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10025ui_story"]) then
				if arg_172_1.var_.characterEffect10025ui_story and not isNil(arg_172_1.actors_["10025ui_story"]) then
					arg_172_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10025ui_story"]) and arg_172_1.var_.characterEffect10025ui_story then
				arg_172_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_175_2 = 0
			local var_175_3 = 0.625

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_4 = arg_172_1:GetWordFromCfg(116161037)
				local var_175_5 = arg_172_1:FormatText(var_175_4.content)

				arg_172_1.text_.text = var_175_5

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_7 = 25 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_5) / 25)

				if (25 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_5) / 25)) > 0 and var_175_3 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_2 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_2
					end
				end

				arg_172_1.text_.text = var_175_5
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161037", "story_v_out_116161.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161037", "story_v_out_116161.awb") / 1000

					if var_175_8 + var_175_2 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_2
					end

					if var_175_4.prefab_name ~= "" and arg_172_1.actors_[var_175_4.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_4.prefab_name].transform, "story_v_out_116161", "116161037", "story_v_out_116161.awb")

						arg_172_1:RecordAudio("116161037", var_175_9)
						arg_172_1:RecordAudio("116161037", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_116161", "116161037", "story_v_out_116161.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_116161", "116161037", "story_v_out_116161.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_3, arg_172_1.talkMaxDuration)

			if var_175_2 <= arg_172_1.time_ and arg_172_1.time_ < var_175_2 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_2) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_2 + var_175_10 and arg_172_1.time_ < var_175_2 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116161038 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116161038
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116161039(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["10025ui_story"]) and arg_176_1.var_.characterEffect10025ui_story == nil then
				arg_176_1.var_.characterEffect10025ui_story = arg_176_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["10025ui_story"]) then
				if arg_176_1.var_.characterEffect10025ui_story and not isNil(arg_176_1.actors_["10025ui_story"]) then
					arg_176_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["10025ui_story"]) and arg_176_1.var_.characterEffect10025ui_story then
				arg_176_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_179_1 = 0
			local var_179_2 = 0.95

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(116161038).content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 38 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 38)

				if (38 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 38)) > 0 and var_179_2 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_6 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_6 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_6

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_6 and arg_176_1.time_ < var_179_1 + var_179_6 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play116161039 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116161039
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116161040(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_183_0 = 0
			local var_183_1 = 1.125

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_2 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(116161039).content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 45 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_2) / 45)

				if (45 <= 0 and var_183_1 or var_183_1 * (utf8.len(var_183_2) / 45)) > 0 and var_183_1 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_5 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_5 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_5

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_5 and arg_180_1.time_ < var_183_0 + var_183_5 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play116161040 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 116161040
		arg_184_1.duration_ = 6.53

		local var_184_0 = {
			zh = 4.866,
			ja = 6.533
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play116161041(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10025ui_story"]) and arg_184_1.var_.characterEffect10025ui_story == nil then
				arg_184_1.var_.characterEffect10025ui_story = arg_184_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10025ui_story"]) then
				if arg_184_1.var_.characterEffect10025ui_story and not isNil(arg_184_1.actors_["10025ui_story"]) then
					arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10025ui_story"]) and arg_184_1.var_.characterEffect10025ui_story then
				arg_184_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_187_2 = 0
			local var_187_3 = 0.325

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(116161040)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 13 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 13)

				if (13 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 13)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161040", "story_v_out_116161.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161040", "story_v_out_116161.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_116161", "116161040", "story_v_out_116161.awb")

						arg_184_1:RecordAudio("116161040", var_187_9)
						arg_184_1:RecordAudio("116161040", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_116161", "116161040", "story_v_out_116161.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_116161", "116161040", "story_v_out_116161.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play116161041 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116161041
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116161042(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10025ui_story"]) and arg_188_1.var_.characterEffect10025ui_story == nil then
				arg_188_1.var_.characterEffect10025ui_story = arg_188_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10025ui_story"]) then
				if arg_188_1.var_.characterEffect10025ui_story and not isNil(arg_188_1.actors_["10025ui_story"]) then
					arg_188_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10025ui_story"]) and arg_188_1.var_.characterEffect10025ui_story then
				arg_188_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.4

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(116161041).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 16 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 16)

				if (16 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 16)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116161042 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 116161042
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play116161043(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 1.075

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(116161042).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 43 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 43)

				if (43 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 43)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play116161043 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 116161043
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play116161044(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.55

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_1 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(116161043).content)

				arg_196_1.text_.text = var_199_1

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_3 = 22 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 22)

				if (22 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 22)) > 0 and var_199_0 < var_199_3 then
					arg_196_1.talkMaxDuration = var_199_3

					if var_199_3 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_3 + 0
					end
				end

				arg_196_1.text_.text = var_199_1
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_4 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_4

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play116161044 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 116161044
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play116161045(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.7

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(116161044).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 28 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 28)

				if (28 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 28)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play116161045 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 116161045
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play116161046(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action453")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_207_0 = 0
			local var_207_1 = 1.25

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(116161045).content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 50 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_2) / 50)

				if (50 <= 0 and var_207_1 or var_207_1 * (utf8.len(var_207_2) / 50)) > 0 and var_207_1 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_5 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_5 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_5

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_5 and arg_204_1.time_ < var_207_0 + var_207_5 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play116161046 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 116161046
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play116161047(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.025

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(116161046).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 41 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 41)

				if (41 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 41)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play116161047 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 116161047
		arg_212_1.duration_ = 3.37

		local var_212_0 = {
			zh = 2.866,
			ja = 3.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play116161048(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10025ui_story"]) and arg_212_1.var_.characterEffect10025ui_story == nil then
				arg_212_1.var_.characterEffect10025ui_story = arg_212_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["10025ui_story"]) then
				if arg_212_1.var_.characterEffect10025ui_story and not isNil(arg_212_1.actors_["10025ui_story"]) then
					arg_212_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["10025ui_story"]) and arg_212_1.var_.characterEffect10025ui_story then
				arg_212_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_215_2 = 0
			local var_215_3 = 0.175

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_4 = arg_212_1:GetWordFromCfg(116161047)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 7 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 7)

				if (7 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 7)) > 0 and var_215_3 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161047", "story_v_out_116161.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161047", "story_v_out_116161.awb") / 1000

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end

					if var_215_4.prefab_name ~= "" and arg_212_1.actors_[var_215_4.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_4.prefab_name].transform, "story_v_out_116161", "116161047", "story_v_out_116161.awb")

						arg_212_1:RecordAudio("116161047", var_215_9)
						arg_212_1:RecordAudio("116161047", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_116161", "116161047", "story_v_out_116161.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_116161", "116161047", "story_v_out_116161.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_10 and arg_212_1.time_ < var_215_2 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play116161048 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 116161048
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play116161049(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10025ui_story = arg_216_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).z)
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles = arg_216_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["10025ui_story"].transform.position).z)
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["10025ui_story"].transform.localEulerAngles = arg_216_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_219_1 = 0
			local var_219_2 = 0.825

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(116161048).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 33 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 33)

				if (33 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 33)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play116161049 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 116161049
		arg_220_1.duration_ = 2.47

		local var_220_0 = {
			zh = 2.466,
			ja = 1.2
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play116161050(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.175

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(116161049)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 7 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 7)

				if (7 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 7)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161049", "story_v_out_116161.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_116161", "116161049", "story_v_out_116161.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_116161", "116161049", "story_v_out_116161.awb")

						arg_220_1:RecordAudio("116161049", var_223_6)
						arg_220_1:RecordAudio("116161049", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_116161", "116161049", "story_v_out_116161.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_116161", "116161049", "story_v_out_116161.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play116161050 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 116161050
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play116161051(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10025ui_story"]) and arg_224_1.var_.characterEffect10025ui_story == nil then
				arg_224_1.var_.characterEffect10025ui_story = arg_224_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10025ui_story"]) then
				if arg_224_1.var_.characterEffect10025ui_story and not isNil(arg_224_1.actors_["10025ui_story"]) then
					arg_224_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10025ui_story"]) and arg_224_1.var_.characterEffect10025ui_story then
				arg_224_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 0.225

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(116161050).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 9 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 9)

				if (9 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 9)) > 0 and var_227_2 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_6 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_6 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_6

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_6 and arg_224_1.time_ < var_227_1 + var_227_6 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play116161051 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 116161051
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play116161052(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10025ui_story = arg_228_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).z)
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles = arg_228_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["10025ui_story"].transform.position).z)
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["10025ui_story"].transform.localEulerAngles = arg_228_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_231_1 = 0
			local var_231_2 = 1.125

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_3 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(116161051).content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 45 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 45)

				if (45 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 45)) > 0 and var_231_2 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_6 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_6 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_6

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_6 and arg_228_1.time_ < var_231_1 + var_231_6 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play116161052 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116161052
		arg_232_1.duration_ = 5.77

		local var_232_0 = {
			zh = 5.766,
			ja = 4.833
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116161053(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["10025ui_story"]) and arg_232_1.var_.characterEffect10025ui_story == nil then
				arg_232_1.var_.characterEffect10025ui_story = arg_232_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["10025ui_story"]) then
				if arg_232_1.var_.characterEffect10025ui_story and not isNil(arg_232_1.actors_["10025ui_story"]) then
					arg_232_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["10025ui_story"]) and arg_232_1.var_.characterEffect10025ui_story then
				arg_232_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_235_2 = arg_232_1.actors_["10025ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10025ui_story = var_235_2.localPosition
			end

			local var_235_3 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_3 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_232_1.time_ - 0) / var_235_3)
				var_235_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_2.position).x, (manager.ui.mainCamera.transform.position - var_235_2.position).y, (manager.ui.mainCamera.transform.position - var_235_2.position).z)
				var_235_2.localEulerAngles.z = 0
				var_235_2.localEulerAngles.x = 0
				var_235_2.localEulerAngles = var_235_2.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_3 and arg_232_1.time_ < 0 + var_235_3 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(0, -1.1, -5.9)
				var_235_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_2.position).x, (manager.ui.mainCamera.transform.position - var_235_2.position).y, (manager.ui.mainCamera.transform.position - var_235_2.position).z)
				var_235_2.localEulerAngles.z = 0
				var_235_2.localEulerAngles.x = 0
				var_235_2.localEulerAngles = var_235_2.localEulerAngles
			end

			local var_235_4 = 0
			local var_235_5 = 0.45

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_6 = arg_232_1:GetWordFromCfg(116161052)
				local var_235_7 = arg_232_1:FormatText(var_235_6.content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 18 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 18)

				if (18 <= 0 and var_235_5 or var_235_5 * (utf8.len(var_235_7) / 18)) > 0 and var_235_5 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161052", "story_v_out_116161.awb") ~= 0 then
					local var_235_10 = manager.audio:GetVoiceLength("story_v_out_116161", "116161052", "story_v_out_116161.awb") / 1000

					if var_235_10 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_4
					end

					if var_235_6.prefab_name ~= "" and arg_232_1.actors_[var_235_6.prefab_name] ~= nil then
						local var_235_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_6.prefab_name].transform, "story_v_out_116161", "116161052", "story_v_out_116161.awb")

						arg_232_1:RecordAudio("116161052", var_235_11)
						arg_232_1:RecordAudio("116161052", var_235_11)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_116161", "116161052", "story_v_out_116161.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_116161", "116161052", "story_v_out_116161.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_12 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_12 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_12

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_12 and arg_232_1.time_ < var_235_4 + var_235_12 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play116161053 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116161053
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play116161054(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10025ui_story"]) and arg_236_1.var_.characterEffect10025ui_story == nil then
				arg_236_1.var_.characterEffect10025ui_story = arg_236_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10025ui_story"]) then
				if arg_236_1.var_.characterEffect10025ui_story and not isNil(arg_236_1.actors_["10025ui_story"]) then
					arg_236_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_0)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10025ui_story"]) and arg_236_1.var_.characterEffect10025ui_story then
				arg_236_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_239_1 = 0
			local var_239_2 = 0.55

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(116161053).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 22 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 22)

				if (22 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 22)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play116161054 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 116161054
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play116161055(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.75

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(116161054).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 30 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 30)

				if (30 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 30)) > 0 and var_243_0 < var_243_3 then
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
	Play116161055 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 116161055
		arg_244_1.duration_ = 3.9

		local var_244_0 = {
			zh = 2.5,
			ja = 3.9
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play116161056(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10025ui_story"]) and arg_244_1.var_.characterEffect10025ui_story == nil then
				arg_244_1.var_.characterEffect10025ui_story = arg_244_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10025ui_story"]) then
				if arg_244_1.var_.characterEffect10025ui_story and not isNil(arg_244_1.actors_["10025ui_story"]) then
					arg_244_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10025ui_story"]) and arg_244_1.var_.characterEffect10025ui_story then
				arg_244_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_247_2 = 0
			local var_247_3 = 0.225

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_4 = arg_244_1:GetWordFromCfg(116161055)
				local var_247_5 = arg_244_1:FormatText(var_247_4.content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 9 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 9)

				if (9 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 9)) > 0 and var_247_3 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_2
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161055", "story_v_out_116161.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161055", "story_v_out_116161.awb") / 1000

					if var_247_8 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_2
					end

					if var_247_4.prefab_name ~= "" and arg_244_1.actors_[var_247_4.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_4.prefab_name].transform, "story_v_out_116161", "116161055", "story_v_out_116161.awb")

						arg_244_1:RecordAudio("116161055", var_247_9)
						arg_244_1:RecordAudio("116161055", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_116161", "116161055", "story_v_out_116161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_116161", "116161055", "story_v_out_116161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_3, arg_244_1.talkMaxDuration)

			if var_247_2 <= arg_244_1.time_ and arg_244_1.time_ < var_247_2 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_2) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_2 + var_247_10 and arg_244_1.time_ < var_247_2 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play116161056 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 116161056
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play116161057(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10025ui_story"]) and arg_248_1.var_.characterEffect10025ui_story == nil then
				arg_248_1.var_.characterEffect10025ui_story = arg_248_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10025ui_story"]) then
				if arg_248_1.var_.characterEffect10025ui_story and not isNil(arg_248_1.actors_["10025ui_story"]) then
					arg_248_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10025ui_story"]) and arg_248_1.var_.characterEffect10025ui_story then
				arg_248_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.6

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(116161056).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 24 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 24)

				if (24 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 24)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play116161057 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 116161057
		arg_252_1.duration_ = 7.03

		local var_252_0 = {
			zh = 5.7,
			ja = 7.033
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play116161058(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10025ui_story"]) and arg_252_1.var_.characterEffect10025ui_story == nil then
				arg_252_1.var_.characterEffect10025ui_story = arg_252_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10025ui_story"]) then
				if arg_252_1.var_.characterEffect10025ui_story and not isNil(arg_252_1.actors_["10025ui_story"]) then
					arg_252_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10025ui_story"]) and arg_252_1.var_.characterEffect10025ui_story then
				arg_252_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_255_2 = 0
			local var_255_3 = 0.425

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_4 = arg_252_1:GetWordFromCfg(116161057)
				local var_255_5 = arg_252_1:FormatText(var_255_4.content)

				arg_252_1.text_.text = var_255_5

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_7 = 17 <= 0 and var_255_3 or var_255_3 * (utf8.len(var_255_5) / 17)

				if (17 <= 0 and var_255_3 or var_255_3 * (utf8.len(var_255_5) / 17)) > 0 and var_255_3 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_2
					end
				end

				arg_252_1.text_.text = var_255_5
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161057", "story_v_out_116161.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161057", "story_v_out_116161.awb") / 1000

					if var_255_8 + var_255_2 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_2
					end

					if var_255_4.prefab_name ~= "" and arg_252_1.actors_[var_255_4.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_4.prefab_name].transform, "story_v_out_116161", "116161057", "story_v_out_116161.awb")

						arg_252_1:RecordAudio("116161057", var_255_9)
						arg_252_1:RecordAudio("116161057", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_116161", "116161057", "story_v_out_116161.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_116161", "116161057", "story_v_out_116161.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_3, arg_252_1.talkMaxDuration)

			if var_255_2 <= arg_252_1.time_ and arg_252_1.time_ < var_255_2 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_2) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_2 + var_255_10 and arg_252_1.time_ < var_255_2 + var_255_10 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play116161058 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 116161058
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play116161059(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10025ui_story"]) and arg_256_1.var_.characterEffect10025ui_story == nil then
				arg_256_1.var_.characterEffect10025ui_story = arg_256_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10025ui_story"]) then
				if arg_256_1.var_.characterEffect10025ui_story and not isNil(arg_256_1.actors_["10025ui_story"]) then
					arg_256_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_0)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10025ui_story"]) and arg_256_1.var_.characterEffect10025ui_story then
				arg_256_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_259_1 = 0
			local var_259_2 = 1.025

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
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

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(116161058).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 41 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 41)

				if (41 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 41)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play116161059 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 116161059
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play116161060(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.6

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(116161059).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 24 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 24)

				if (24 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 24)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play116161060 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 116161060
		arg_264_1.duration_ = 2.93

		local var_264_0 = {
			zh = 2.933,
			ja = 2.9
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
			arg_264_1.auto_ = false
		end

		function arg_264_1.playNext_(arg_266_0)
			arg_264_1.onStoryFinished_()
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["10025ui_story"]) and arg_264_1.var_.characterEffect10025ui_story == nil then
				arg_264_1.var_.characterEffect10025ui_story = arg_264_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["10025ui_story"]) then
				if arg_264_1.var_.characterEffect10025ui_story and not isNil(arg_264_1.actors_["10025ui_story"]) then
					arg_264_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["10025ui_story"]) and arg_264_1.var_.characterEffect10025ui_story then
				arg_264_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_267_2 = 0
			local var_267_3 = 0.15

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:GetWordFromCfg(116161060)
				local var_267_5 = arg_264_1:FormatText(var_267_4.content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 6 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 6)

				if (6 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 6)) > 0 and var_267_3 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116161", "116161060", "story_v_out_116161.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_116161", "116161060", "story_v_out_116161.awb") / 1000

					if var_267_8 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_2
					end

					if var_267_4.prefab_name ~= "" and arg_264_1.actors_[var_267_4.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_4.prefab_name].transform, "story_v_out_116161", "116161060", "story_v_out_116161.awb")

						arg_264_1:RecordAudio("116161060", var_267_9)
						arg_264_1:RecordAudio("116161060", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_116161", "116161060", "story_v_out_116161.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_116161", "116161060", "story_v_out_116161.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_10 and arg_264_1.time_ < var_267_2 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SK0103",
		"TextureConfig/Background/SK0112",
		"TextureConfig/Background/SK0107",
		"TextureConfig/Background/SK0106",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/I03",
		"TextureConfig/Background/I06"
	},
	voices = {
		"story_v_out_116161.awb"
	}
}
