return {
	Play222081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 222081001
		arg_1_1.duration_ = 13.9

		local var_1_0 = {
			ja = 13.899999999999,
			ko = 10.532999999999,
			zh = 10.565999999999
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
				arg_1_0:Play222081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.YZ0103 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YZ0103")
				var_4_0.name = "YZ0103"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.YZ0103 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.YZ0103

				arg_1_1.bgs_.YZ0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "YZ0103" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_0_battle_jingdu", "bgm_activity_2_0_battle_jingdu")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_quarry", "")
			end

			local var_4_15 = arg_1_1.bgs_.YZ0103.transform

			if 0.0333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.0333333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPosYZ0103 = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 0.0333333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.0333333333333333 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosYZ0103, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0.0333333333333333) / var_4_16)
			end

			if arg_1_1.time_ >= 0.0333333333333333 + var_4_16 and arg_1_1.time_ < 0.0333333333333333 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_17 = arg_1_1.bgs_.YZ0103.transform

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1.var_.moveOldPosYZ0103 = var_4_17.localPosition
			end

			local var_4_18 = 4.5

			if 0.05 <= arg_1_1.time_ and arg_1_1.time_ < 0.05 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosYZ0103, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.05) / var_4_18)
			end

			if arg_1_1.time_ >= 0.05 + var_4_18 and arg_1_1.time_ < 0.05 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_19 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 2.550000000001 and arg_1_1.time_ < var_4_19 + 2.550000000001 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 1.999999999999
			local var_4_21 = 0.825

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(222081001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 33 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 33)

				if (33 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 33)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081001", "story_v_out_222081.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_222081", "222081001", "story_v_out_222081.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_222081", "222081001", "story_v_out_222081.awb")

						arg_1_1:RecordAudio("222081001", var_4_28)
						arg_1_1:RecordAudio("222081001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_222081", "222081001", "story_v_out_222081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_222081", "222081001", "story_v_out_222081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "YZ0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "YZ0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.05,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play222081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 222081002
		arg_9_1.duration_ = 14.6

		local var_9_0 = {
			ja = 14.6,
			ko = 11,
			zh = 11
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
				arg_9_0:Play222081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.025

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(222081002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 39)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081002", "story_v_out_222081.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081002", "story_v_out_222081.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_222081", "222081002", "story_v_out_222081.awb")

						arg_9_1:RecordAudio("222081002", var_12_6)
						arg_9_1:RecordAudio("222081002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_222081", "222081002", "story_v_out_222081.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_222081", "222081002", "story_v_out_222081.awb")
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
	Play222081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 222081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play222081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.925

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(222081003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 37 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 37)

				if (37 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 37)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play222081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 222081004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play222081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(222081004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 25)

				if (25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 25)) > 0 and var_20_0 < var_20_3 then
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
	Play222081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 222081005
		arg_21_1.duration_ = 11.9

		local var_21_0 = {
			ja = 11.9,
			ko = 7.3,
			zh = 7.3
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
				arg_21_0:Play222081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(222081005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 41)

				if (41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 41)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081005", "story_v_out_222081.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081005", "story_v_out_222081.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_222081", "222081005", "story_v_out_222081.awb")

						arg_21_1:RecordAudio("222081005", var_24_6)
						arg_21_1:RecordAudio("222081005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_222081", "222081005", "story_v_out_222081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_222081", "222081005", "story_v_out_222081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play222081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 222081006
		arg_25_1.duration_ = 13.57

		local var_25_0 = {
			ja = 13.566,
			ko = 10.4,
			zh = 10.433
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
				arg_25_0:Play222081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(222081006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 39 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 39)

				if (39 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 39)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081006", "story_v_out_222081.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081006", "story_v_out_222081.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_222081", "222081006", "story_v_out_222081.awb")

						arg_25_1:RecordAudio("222081006", var_28_6)
						arg_25_1:RecordAudio("222081006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_222081", "222081006", "story_v_out_222081.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_222081", "222081006", "story_v_out_222081.awb")
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
	Play222081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 222081007
		arg_29_1.duration_ = 15.2

		local var_29_0 = {
			ja = 15.2,
			ko = 12.433,
			zh = 12.433
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
				arg_29_0:Play222081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(222081007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 53)

				if (53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 53)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081007", "story_v_out_222081.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081007", "story_v_out_222081.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_222081", "222081007", "story_v_out_222081.awb")

						arg_29_1:RecordAudio("222081007", var_32_6)
						arg_29_1:RecordAudio("222081007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_222081", "222081007", "story_v_out_222081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_222081", "222081007", "story_v_out_222081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play222081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 222081008
		arg_33_1.duration_ = 13.9

		local var_33_0 = {
			ja = 11.4,
			ko = 13.9,
			zh = 13.9
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
				arg_33_0:Play222081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(222081008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 55 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 55)

				if (55 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 55)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081008", "story_v_out_222081.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081008", "story_v_out_222081.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_222081", "222081008", "story_v_out_222081.awb")

						arg_33_1:RecordAudio("222081008", var_36_6)
						arg_33_1:RecordAudio("222081008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_222081", "222081008", "story_v_out_222081.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_222081", "222081008", "story_v_out_222081.awb")
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
	Play222081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 222081009
		arg_37_1.duration_ = 10.03

		local var_37_0 = {
			ja = 10.033,
			ko = 6.633,
			zh = 6.633
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
				arg_37_0:Play222081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(222081009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)

				if (29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081009", "story_v_out_222081.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081009", "story_v_out_222081.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_222081", "222081009", "story_v_out_222081.awb")

						arg_37_1:RecordAudio("222081009", var_40_6)
						arg_37_1:RecordAudio("222081009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_222081", "222081009", "story_v_out_222081.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_222081", "222081009", "story_v_out_222081.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play222081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 222081010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play222081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(222081010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 69 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 69)

				if (69 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 69)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play222081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 222081011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play222081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(222081011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)

				if (54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play222081012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 222081012
		arg_49_1.duration_ = 2.67

		local var_49_0 = {
			ja = 2.666,
			ko = 1.5,
			zh = 1.533
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
				arg_49_0:Play222081013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(222081012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 10)

				if (10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 10)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081012", "story_v_out_222081.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081012", "story_v_out_222081.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_222081", "222081012", "story_v_out_222081.awb")

						arg_49_1:RecordAudio("222081012", var_52_6)
						arg_49_1:RecordAudio("222081012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_222081", "222081012", "story_v_out_222081.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_222081", "222081012", "story_v_out_222081.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play222081013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 222081013
		arg_53_1.duration_ = 12.73

		local var_53_0 = {
			ja = 12.733,
			ko = 8.5,
			zh = 8.5
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
				arg_53_0:Play222081014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.95

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[463].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(222081013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 38 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 38)

				if (38 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 38)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081013", "story_v_out_222081.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081013", "story_v_out_222081.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_222081", "222081013", "story_v_out_222081.awb")

						arg_53_1:RecordAudio("222081013", var_56_6)
						arg_53_1:RecordAudio("222081013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_222081", "222081013", "story_v_out_222081.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_222081", "222081013", "story_v_out_222081.awb")
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
	Play222081014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 222081014
		arg_57_1.duration_ = 8.53

		local var_57_0 = {
			ja = 5.366,
			ko = 8.5,
			zh = 8.533
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
				arg_57_0:Play222081015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.775

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(222081014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 31 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 31)

				if (31 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 31)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081014", "story_v_out_222081.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081014", "story_v_out_222081.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_222081", "222081014", "story_v_out_222081.awb")

						arg_57_1:RecordAudio("222081014", var_60_6)
						arg_57_1:RecordAudio("222081014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_222081", "222081014", "story_v_out_222081.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_222081", "222081014", "story_v_out_222081.awb")
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
	Play222081015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 222081015
		arg_61_1.duration_ = 7.3

		local var_61_0 = {
			ja = 6.733,
			ko = 7.3,
			zh = 7.3
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
				arg_61_0:Play222081016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(222081015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)

				if (30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081015", "story_v_out_222081.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081015", "story_v_out_222081.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_222081", "222081015", "story_v_out_222081.awb")

						arg_61_1:RecordAudio("222081015", var_64_6)
						arg_61_1:RecordAudio("222081015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_222081", "222081015", "story_v_out_222081.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_222081", "222081015", "story_v_out_222081.awb")
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
	Play222081016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 222081016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play222081017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.85

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(222081016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 34 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 34)

				if (34 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 34)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play222081017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 222081017
		arg_69_1.duration_ = 10.7

		local var_69_0 = {
			ja = 10,
			ko = 10.7,
			zh = 10.7
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
				arg_69_0:Play222081018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.J03g == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03g")
				var_72_0.name = "J03g"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.J03g = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.J03g

				arg_69_1.bgs_.J03g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "J03g" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 2

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			local var_72_12 = "10057ui_story"

			if arg_69_1.actors_["10057ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10057ui_story"))) then
				local var_72_13 = Object.Instantiate(Asset.Load("Char/" .. "10057ui_story"), arg_69_1.stage_.transform)

				var_72_13.name = var_72_12
				var_72_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_[var_72_12] = var_72_13

				local var_72_14 = var_72_13:GetComponentInChildren(typeof(CharacterEffect))

				var_72_14.enabled = true

				local var_72_15 = GameObjectTools.GetOrAddComponent(var_72_13, typeof(DynamicBoneHelper))

				if var_72_15 then
					var_72_15:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_14.transform, false)

				arg_69_1.var_[var_72_12 .. "Animator"] = var_72_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_[var_72_12 .. "Animator"].applyRootMotion = true
				arg_69_1.var_[var_72_12 .. "LipSync"] = var_72_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_16 = arg_69_1.actors_["10057ui_story"].transform

			if 3.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 3.96666666666667 + arg_72_0 then
				arg_69_1.var_.moveOldPos10057ui_story = var_72_16.localPosition
			end

			local var_72_17 = 0.001

			if 3.96666666666667 <= arg_69_1.time_ and arg_69_1.time_ < 3.96666666666667 + var_72_17 then
				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10057ui_story, Vector3.New(0, -1.13, -5.72), (arg_69_1.time_ - 3.96666666666667) / var_72_17)
				var_72_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_16.position).x, (manager.ui.mainCamera.transform.position - var_72_16.position).y, (manager.ui.mainCamera.transform.position - var_72_16.position).z)
				var_72_16.localEulerAngles.z = 0
				var_72_16.localEulerAngles.x = 0
				var_72_16.localEulerAngles = var_72_16.localEulerAngles
			end

			if arg_69_1.time_ >= 3.96666666666667 + var_72_17 and arg_69_1.time_ < 3.96666666666667 + var_72_17 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(0, -1.13, -5.72)
				var_72_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_16.position).x, (manager.ui.mainCamera.transform.position - var_72_16.position).y, (manager.ui.mainCamera.transform.position - var_72_16.position).z)
				var_72_16.localEulerAngles.z = 0
				var_72_16.localEulerAngles.x = 0
				var_72_16.localEulerAngles = var_72_16.localEulerAngles
			end

			if 3.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 3.96666666666667 + arg_72_0 then
				arg_69_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 3.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 3.96666666666667 + arg_72_0 then
				arg_69_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_18 = arg_69_1.actors_["10057ui_story"]

			if 3.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 3.96666666666667 + arg_72_0 and not isNil(var_72_18) and arg_69_1.var_.characterEffect10057ui_story == nil then
				arg_69_1.var_.characterEffect10057ui_story = var_72_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_19 = 0.2

			if 3.96666666666667 <= arg_69_1.time_ and arg_69_1.time_ < 3.96666666666667 + var_72_19 and not isNil(var_72_18) then
				if arg_69_1.var_.characterEffect10057ui_story and not isNil(var_72_18) then
					arg_69_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 3.96666666666667 + var_72_19 and arg_69_1.time_ < 3.96666666666667 + var_72_19 + arg_72_0 and not isNil(var_72_18) and arg_69_1.var_.characterEffect10057ui_story then
				arg_69_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_21 = 4
			local var_72_22 = 0.6

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_23 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_23:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_24 = arg_69_1:GetWordFromCfg(222081017)
				local var_72_25 = arg_69_1:FormatText(var_72_24.content)

				arg_69_1.text_.text = var_72_25

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_27 = 24 <= 0 and var_72_22 or var_72_22 * (utf8.len(var_72_25) / 24)

				if (24 <= 0 and var_72_22 or var_72_22 * (utf8.len(var_72_25) / 24)) > 0 and var_72_22 < var_72_27 then
					arg_69_1.talkMaxDuration = var_72_27
					var_72_21 = var_72_21 + 0.3

					if var_72_27 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_21
					end
				end

				arg_69_1.text_.text = var_72_25
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081017", "story_v_out_222081.awb") ~= 0 then
					local var_72_28 = manager.audio:GetVoiceLength("story_v_out_222081", "222081017", "story_v_out_222081.awb") / 1000

					if var_72_28 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_21
					end

					if var_72_24.prefab_name ~= "" and arg_69_1.actors_[var_72_24.prefab_name] ~= nil then
						local var_72_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_24.prefab_name].transform, "story_v_out_222081", "222081017", "story_v_out_222081.awb")

						arg_69_1:RecordAudio("222081017", var_72_29)
						arg_69_1:RecordAudio("222081017", var_72_29)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_222081", "222081017", "story_v_out_222081.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_222081", "222081017", "story_v_out_222081.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_30 = var_72_21 + 0.3
			local var_72_31 = math.max(var_72_22, arg_69_1.talkMaxDuration)

			if var_72_21 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_31 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_31

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_31 and arg_69_1.time_ < var_72_30 + var_72_31 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play222081018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 222081018
		arg_75_1.duration_ = 11.2

		local var_75_0 = {
			ja = 11.2,
			ko = 6.8,
			zh = 6.8
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
				arg_75_0:Play222081019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action2_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_0 = 0
			local var_78_1 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(222081018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 27 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 27)

				if (27 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 27)) > 0 and var_78_1 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081018", "story_v_out_222081.awb") ~= 0 then
					local var_78_6 = manager.audio:GetVoiceLength("story_v_out_222081", "222081018", "story_v_out_222081.awb") / 1000

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end

					if var_78_2.prefab_name ~= "" and arg_75_1.actors_[var_78_2.prefab_name] ~= nil then
						local var_78_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_2.prefab_name].transform, "story_v_out_222081", "222081018", "story_v_out_222081.awb")

						arg_75_1:RecordAudio("222081018", var_78_7)
						arg_75_1:RecordAudio("222081018", var_78_7)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_222081", "222081018", "story_v_out_222081.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_222081", "222081018", "story_v_out_222081.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play222081019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 222081019
		arg_79_1.duration_ = 9.83

		local var_79_0 = {
			ja = 8.733,
			ko = 9.833,
			zh = 9.833
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
				arg_79_0:Play222081020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.9

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:GetWordFromCfg(222081019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 36 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 36)

				if (36 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 36)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081019", "story_v_out_222081.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_222081", "222081019", "story_v_out_222081.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_222081", "222081019", "story_v_out_222081.awb")

						arg_79_1:RecordAudio("222081019", var_82_6)
						arg_79_1:RecordAudio("222081019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_222081", "222081019", "story_v_out_222081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_222081", "222081019", "story_v_out_222081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play222081020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 222081020
		arg_83_1.duration_ = 9.1

		local var_83_0 = {
			ja = 9.1,
			ko = 7.4,
			zh = 7.4
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
				arg_83_0:Play222081021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_83_1.stage_.transform)

				var_86_0.name = "1070ui_story"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1070ui_story"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["1070ui_story" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["1070ui_story" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["1070ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1070ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1070ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1070ui_story == nil then
				arg_83_1.var_.characterEffect1070ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1070ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1070ui_story then
				arg_83_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_86_8 = arg_83_1.actors_["10057ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10057ui_story = var_86_8.localPosition
			end

			local var_86_9 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_9 then
				var_86_8.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10057ui_story, Vector3.New(-0.7, -1.13, -5.72), (arg_83_1.time_ - 0) / var_86_9)
				var_86_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_8.position).x, (manager.ui.mainCamera.transform.position - var_86_8.position).y, (manager.ui.mainCamera.transform.position - var_86_8.position).z)
				var_86_8.localEulerAngles.z = 0
				var_86_8.localEulerAngles.x = 0
				var_86_8.localEulerAngles = var_86_8.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_9 and arg_83_1.time_ < 0 + var_86_9 + arg_86_0 then
				var_86_8.localPosition = Vector3.New(-0.7, -1.13, -5.72)
				var_86_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_8.position).x, (manager.ui.mainCamera.transform.position - var_86_8.position).y, (manager.ui.mainCamera.transform.position - var_86_8.position).z)
				var_86_8.localEulerAngles.z = 0
				var_86_8.localEulerAngles.x = 0
				var_86_8.localEulerAngles = var_86_8.localEulerAngles
			end

			local var_86_10 = arg_83_1.actors_["10057ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_10) and arg_83_1.var_.characterEffect10057ui_story == nil then
				arg_83_1.var_.characterEffect10057ui_story = var_86_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_11 and not isNil(var_86_10) then
				if arg_83_1.var_.characterEffect10057ui_story and not isNil(var_86_10) then
					arg_83_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_11)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_11 and arg_83_1.time_ < 0 + var_86_11 + arg_86_0 and not isNil(var_86_10) and arg_83_1.var_.characterEffect10057ui_story then
				arg_83_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_86_12 = 0
			local var_86_13 = 0.95

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_14 = arg_83_1:GetWordFromCfg(222081020)
				local var_86_15 = arg_83_1:FormatText(var_86_14.content)

				arg_83_1.text_.text = var_86_15

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 38 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_15) / 38)

				if (38 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_15) / 38)) > 0 and var_86_13 < var_86_17 then
					arg_83_1.talkMaxDuration = var_86_17

					if var_86_17 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_17 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_15
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081020", "story_v_out_222081.awb") ~= 0 then
					local var_86_18 = manager.audio:GetVoiceLength("story_v_out_222081", "222081020", "story_v_out_222081.awb") / 1000

					if var_86_18 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_12
					end

					if var_86_14.prefab_name ~= "" and arg_83_1.actors_[var_86_14.prefab_name] ~= nil then
						local var_86_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_14.prefab_name].transform, "story_v_out_222081", "222081020", "story_v_out_222081.awb")

						arg_83_1:RecordAudio("222081020", var_86_19)
						arg_83_1:RecordAudio("222081020", var_86_19)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_222081", "222081020", "story_v_out_222081.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_222081", "222081020", "story_v_out_222081.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_20 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_20 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_20

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_20 and arg_83_1.time_ < var_86_12 + var_86_20 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play222081021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 222081021
		arg_87_1.duration_ = 12.57

		local var_87_0 = {
			ja = 12.566,
			ko = 7.066,
			zh = 7.1
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
				arg_87_0:Play222081022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10057ui_story"]) and arg_87_1.var_.characterEffect10057ui_story == nil then
				arg_87_1.var_.characterEffect10057ui_story = arg_87_1.actors_["10057ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10057ui_story"]) then
				if arg_87_1.var_.characterEffect10057ui_story and not isNil(arg_87_1.actors_["10057ui_story"]) then
					arg_87_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10057ui_story"]) and arg_87_1.var_.characterEffect10057ui_story then
				arg_87_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action2_2")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_2 = arg_87_1.actors_["1070ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1070ui_story == nil then
				arg_87_1.var_.characterEffect1070ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.characterEffect1070ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_3)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect1070ui_story then
				arg_87_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_90_4 = 0
			local var_90_5 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(222081021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 21 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 21)

				if (21 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 21)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081021", "story_v_out_222081.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081021", "story_v_out_222081.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_222081", "222081021", "story_v_out_222081.awb")

						arg_87_1:RecordAudio("222081021", var_90_11)
						arg_87_1:RecordAudio("222081021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_222081", "222081021", "story_v_out_222081.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_222081", "222081021", "story_v_out_222081.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play222081022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 222081022
		arg_91_1.duration_ = 3.7

		local var_91_0 = {
			ja = 3.7,
			ko = 2.9,
			zh = 2.866
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
				arg_91_0:Play222081023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1070ui_story"]) and arg_91_1.var_.characterEffect1070ui_story == nil then
				arg_91_1.var_.characterEffect1070ui_story = arg_91_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1070ui_story"]) then
				if arg_91_1.var_.characterEffect1070ui_story and not isNil(arg_91_1.actors_["1070ui_story"]) then
					arg_91_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1070ui_story"]) and arg_91_1.var_.characterEffect1070ui_story then
				arg_91_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_94_2 = arg_91_1.actors_["10057ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect10057ui_story == nil then
				arg_91_1.var_.characterEffect10057ui_story = var_94_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.characterEffect10057ui_story and not isNil(var_94_2) then
					arg_91_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_3)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect10057ui_story then
				arg_91_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_94_4 = 0
			local var_94_5 = 0.275

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(222081022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 11 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 11)

				if (11 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 11)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081022", "story_v_out_222081.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081022", "story_v_out_222081.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_222081", "222081022", "story_v_out_222081.awb")

						arg_91_1:RecordAudio("222081022", var_94_11)
						arg_91_1:RecordAudio("222081022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_222081", "222081022", "story_v_out_222081.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_222081", "222081022", "story_v_out_222081.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play222081023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 222081023
		arg_95_1.duration_ = 16.6

		local var_95_0 = {
			ja = 16.6,
			ko = 11.8,
			zh = 11.8
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
				arg_95_0:Play222081024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10057ui_story = arg_95_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).z)
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles = arg_95_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10057ui_story"].transform.position).z)
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10057ui_story"].transform.localEulerAngles = arg_95_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["10057ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10057ui_story == nil then
				arg_95_1.var_.characterEffect10057ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10057ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10057ui_story then
				arg_95_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_98_3 = "1074ui_story"

			if arg_95_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_98_4 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_95_1.stage_.transform)

				var_98_4.name = var_98_3
				var_98_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_[var_98_3] = var_98_4

				local var_98_5 = var_98_4:GetComponentInChildren(typeof(CharacterEffect))

				var_98_5.enabled = true

				local var_98_6 = GameObjectTools.GetOrAddComponent(var_98_4, typeof(DynamicBoneHelper))

				if var_98_6 then
					var_98_6:EnableDynamicBone(false)
				end

				arg_95_1:ShowWeapon(var_98_5.transform, false)

				arg_95_1.var_[var_98_3 .. "Animator"] = var_98_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_95_1.var_[var_98_3 .. "Animator"].applyRootMotion = true
				arg_95_1.var_[var_98_3 .. "LipSync"] = var_98_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_98_7 = arg_95_1.actors_["1074ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1074ui_story = var_98_7.localPosition
			end

			local var_98_8 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_8 then
				var_98_7.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_95_1.time_ - 0) / var_98_8)
				var_98_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_7.position).x, (manager.ui.mainCamera.transform.position - var_98_7.position).y, (manager.ui.mainCamera.transform.position - var_98_7.position).z)
				var_98_7.localEulerAngles.z = 0
				var_98_7.localEulerAngles.x = 0
				var_98_7.localEulerAngles = var_98_7.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_8 and arg_95_1.time_ < 0 + var_98_8 + arg_98_0 then
				var_98_7.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_98_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_7.position).x, (manager.ui.mainCamera.transform.position - var_98_7.position).y, (manager.ui.mainCamera.transform.position - var_98_7.position).z)
				var_98_7.localEulerAngles.z = 0
				var_98_7.localEulerAngles.x = 0
				var_98_7.localEulerAngles = var_98_7.localEulerAngles
			end

			local var_98_9 = arg_95_1.actors_["1074ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1074ui_story == nil then
				arg_95_1.var_.characterEffect1074ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_10 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_10 and not isNil(var_98_9) then
				if arg_95_1.var_.characterEffect1074ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_10 and arg_95_1.time_ < 0 + var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1074ui_story then
				arg_95_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_12 = arg_95_1.actors_["1070ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_12) and arg_95_1.var_.characterEffect1070ui_story == nil then
				arg_95_1.var_.characterEffect1070ui_story = var_98_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_13 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_13 and not isNil(var_98_12) then
				if arg_95_1.var_.characterEffect1070ui_story and not isNil(var_98_12) then
					arg_95_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_13)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_13 and arg_95_1.time_ < 0 + var_98_13 + arg_98_0 and not isNil(var_98_12) and arg_95_1.var_.characterEffect1070ui_story then
				arg_95_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_98_14 = 0
			local var_98_15 = 1.425

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:GetWordFromCfg(222081023)
				local var_98_17 = arg_95_1:FormatText(var_98_16.content)

				arg_95_1.text_.text = var_98_17

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_19 = 57 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_17) / 57)

				if (57 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_17) / 57)) > 0 and var_98_15 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_17
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081023", "story_v_out_222081.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_222081", "222081023", "story_v_out_222081.awb") / 1000

					if var_98_20 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_14
					end

					if var_98_16.prefab_name ~= "" and arg_95_1.actors_[var_98_16.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_16.prefab_name].transform, "story_v_out_222081", "222081023", "story_v_out_222081.awb")

						arg_95_1:RecordAudio("222081023", var_98_21)
						arg_95_1:RecordAudio("222081023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_222081", "222081023", "story_v_out_222081.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_222081", "222081023", "story_v_out_222081.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_22 and arg_95_1.time_ < var_98_14 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play222081024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 222081024
		arg_99_1.duration_ = 10.8

		local var_99_0 = {
			ja = 10.8,
			ko = 6.366,
			zh = 6.466
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
				arg_99_0:Play222081025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1070ui_story = arg_99_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).z)
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles = arg_99_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1070ui_story"].transform.position).z)
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1070ui_story"].transform.localEulerAngles = arg_99_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1070ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1070ui_story == nil then
				arg_99_1.var_.characterEffect1070ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1070ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1070ui_story then
				arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_102_3 = arg_99_1.actors_["10057ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10057ui_story = var_102_3.localPosition
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10057ui_story, Vector3.New(0.7, -1.13, -5.72), (arg_99_1.time_ - 0) / var_102_4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(0.7, -1.13, -5.72)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			local var_102_5 = arg_99_1.actors_["10057ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect10057ui_story == nil then
				arg_99_1.var_.characterEffect10057ui_story = var_102_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.characterEffect10057ui_story and not isNil(var_102_5) then
					arg_99_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect10057ui_story then
				arg_99_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_8 = arg_99_1.actors_["1074ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.characterEffect1074ui_story == nil then
				arg_99_1.var_.characterEffect1074ui_story = var_102_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_9 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_9 and not isNil(var_102_8) then
				if arg_99_1.var_.characterEffect1074ui_story and not isNil(var_102_8) then
					arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_9)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_9 and arg_99_1.time_ < 0 + var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.characterEffect1074ui_story then
				arg_99_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_102_10 = 0
			local var_102_11 = 0.8

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_12 = arg_99_1:GetWordFromCfg(222081024)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.text_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 32 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 32)

				if (32 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 32)) > 0 and var_102_11 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_13
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081024", "story_v_out_222081.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_222081", "222081024", "story_v_out_222081.awb") / 1000

					if var_102_16 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_10
					end

					if var_102_12.prefab_name ~= "" and arg_99_1.actors_[var_102_12.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_12.prefab_name].transform, "story_v_out_222081", "222081024", "story_v_out_222081.awb")

						arg_99_1:RecordAudio("222081024", var_102_17)
						arg_99_1:RecordAudio("222081024", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_222081", "222081024", "story_v_out_222081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_222081", "222081024", "story_v_out_222081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_18 and arg_99_1.time_ < var_102_10 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play222081025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 222081025
		arg_103_1.duration_ = 8.1

		local var_103_0 = {
			ja = 8.1,
			ko = 5.766,
			zh = 5.766
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
				arg_103_0:Play222081026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1074ui_story"]) and arg_103_1.var_.characterEffect1074ui_story == nil then
				arg_103_1.var_.characterEffect1074ui_story = arg_103_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1074ui_story"]) then
				if arg_103_1.var_.characterEffect1074ui_story and not isNil(arg_103_1.actors_["1074ui_story"]) then
					arg_103_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1074ui_story"]) and arg_103_1.var_.characterEffect1074ui_story then
				arg_103_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_2 = arg_103_1.actors_["10057ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect10057ui_story == nil then
				arg_103_1.var_.characterEffect10057ui_story = var_106_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.characterEffect10057ui_story and not isNil(var_106_2) then
					arg_103_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_3)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect10057ui_story then
				arg_103_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_106_4 = 0
			local var_106_5 = 0.725

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(222081025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 29 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 29)

				if (29 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 29)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081025", "story_v_out_222081.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081025", "story_v_out_222081.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_222081", "222081025", "story_v_out_222081.awb")

						arg_103_1:RecordAudio("222081025", var_106_11)
						arg_103_1:RecordAudio("222081025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_222081", "222081025", "story_v_out_222081.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_222081", "222081025", "story_v_out_222081.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play222081026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 222081026
		arg_107_1.duration_ = 10.63

		local var_107_0 = {
			ja = 10.633,
			ko = 8.966,
			zh = 8.966
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
				arg_107_0:Play222081027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10057ui_story"]) and arg_107_1.var_.characterEffect10057ui_story == nil then
				arg_107_1.var_.characterEffect10057ui_story = arg_107_1.actors_["10057ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10057ui_story"]) then
				if arg_107_1.var_.characterEffect10057ui_story and not isNil(arg_107_1.actors_["10057ui_story"]) then
					arg_107_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10057ui_story"]) and arg_107_1.var_.characterEffect10057ui_story then
				arg_107_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_2 = arg_107_1.actors_["1074ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1074ui_story == nil then
				arg_107_1.var_.characterEffect1074ui_story = var_110_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_3 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.characterEffect1074ui_story and not isNil(var_110_2) then
					arg_107_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_3)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.characterEffect1074ui_story then
				arg_107_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_110_4 = 0
			local var_110_5 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(222081026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 38 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 38)

				if (38 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 38)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081026", "story_v_out_222081.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081026", "story_v_out_222081.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_222081", "222081026", "story_v_out_222081.awb")

						arg_107_1:RecordAudio("222081026", var_110_11)
						arg_107_1:RecordAudio("222081026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_222081", "222081026", "story_v_out_222081.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_222081", "222081026", "story_v_out_222081.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play222081027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 222081027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play222081028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10057ui_story = arg_111_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).z)
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles = arg_111_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10057ui_story"].transform.position).z)
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10057ui_story"].transform.localEulerAngles = arg_111_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["10057ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10057ui_story == nil then
				arg_111_1.var_.characterEffect10057ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect10057ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_2)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10057ui_story then
				arg_111_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_114_3 = arg_111_1.actors_["1074ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1074ui_story = var_114_3.localPosition
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0, 100, 0)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = arg_111_1.actors_["1074ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1074ui_story == nil then
				arg_111_1.var_.characterEffect1074ui_story = var_114_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.characterEffect1074ui_story and not isNil(var_114_5) then
					arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_6)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1074ui_story then
				arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_114_7 = 0
			local var_114_8 = 0.75

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(222081027).content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 30 <= 0 and var_114_8 or var_114_8 * (utf8.len(var_114_9) / 30)

				if (30 <= 0 and var_114_8 or var_114_8 * (utf8.len(var_114_9) / 30)) > 0 and var_114_8 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_7 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_7
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_8, arg_111_1.talkMaxDuration)

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_7) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_7 + var_114_12 and arg_111_1.time_ < var_114_7 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play222081028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 222081028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play222081029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.425

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(222081028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 57 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 57)

				if (57 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 57)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play222081029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 222081029
		arg_119_1.duration_ = 4.93

		local var_119_0 = {
			ja = 3.666,
			ko = 4.9,
			zh = 4.933
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
				arg_119_0:Play222081030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1074ui_story = arg_119_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).z)
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles = arg_119_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_119_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1074ui_story"].transform.position).z)
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1074ui_story"].transform.localEulerAngles = arg_119_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1074ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(222081029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)

				if (25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081029", "story_v_out_222081.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081029", "story_v_out_222081.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_222081", "222081029", "story_v_out_222081.awb")

						arg_119_1:RecordAudio("222081029", var_122_11)
						arg_119_1:RecordAudio("222081029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_222081", "222081029", "story_v_out_222081.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_222081", "222081029", "story_v_out_222081.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play222081030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 222081030
		arg_123_1.duration_ = 6.7

		local var_123_0 = {
			ja = 6.7,
			ko = 4.933,
			zh = 4.933
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
				arg_123_0:Play222081031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1070ui_story = arg_123_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).z)
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles = arg_123_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_123_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1070ui_story"].transform.position).z)
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1070ui_story"].transform.localEulerAngles = arg_123_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1070ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1070ui_story == nil then
				arg_123_1.var_.characterEffect1070ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1070ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1070ui_story then
				arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_126_4 = arg_123_1.actors_["1074ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1074ui_story == nil then
				arg_123_1.var_.characterEffect1074ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_5 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 and not isNil(var_126_4) then
				if arg_123_1.var_.characterEffect1074ui_story and not isNil(var_126_4) then
					arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_5)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1074ui_story then
				arg_123_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_126_6 = 0
			local var_126_7 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(222081030)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 25 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 25)

				if (25 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 25)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081030", "story_v_out_222081.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081030", "story_v_out_222081.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_222081", "222081030", "story_v_out_222081.awb")

						arg_123_1:RecordAudio("222081030", var_126_13)
						arg_123_1:RecordAudio("222081030", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_222081", "222081030", "story_v_out_222081.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_222081", "222081030", "story_v_out_222081.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play222081031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 222081031
		arg_127_1.duration_ = 4.9

		local var_127_0 = {
			ja = 4.9,
			ko = 3.766,
			zh = 3.766
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
				arg_127_0:Play222081032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1074ui_story = arg_127_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).z)
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles = arg_127_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).z)
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles = arg_127_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1074ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1074ui_story == nil then
				arg_127_1.var_.characterEffect1074ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1074ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_2)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1074ui_story then
				arg_127_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_130_3 = arg_127_1.actors_["10057ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10057ui_story = var_130_3.localPosition
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10057ui_story, Vector3.New(-0.7, -1.13, -5.72), (arg_127_1.time_ - 0) / var_130_4)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(-0.7, -1.13, -5.72)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			local var_130_5 = arg_127_1.actors_["10057ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10057ui_story == nil then
				arg_127_1.var_.characterEffect10057ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.characterEffect10057ui_story and not isNil(var_130_5) then
					arg_127_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10057ui_story then
				arg_127_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_8 = arg_127_1.actors_["1070ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.characterEffect1070ui_story == nil then
				arg_127_1.var_.characterEffect1070ui_story = var_130_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_9 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.characterEffect1070ui_story and not isNil(var_130_8) then
					arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_9)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.characterEffect1070ui_story then
				arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_130_10 = 0
			local var_130_11 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_12 = arg_127_1:GetWordFromCfg(222081031)
				local var_130_13 = arg_127_1:FormatText(var_130_12.content)

				arg_127_1.text_.text = var_130_13

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_15 = 14 <= 0 and var_130_11 or var_130_11 * (utf8.len(var_130_13) / 14)

				if (14 <= 0 and var_130_11 or var_130_11 * (utf8.len(var_130_13) / 14)) > 0 and var_130_11 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_10
					end
				end

				arg_127_1.text_.text = var_130_13
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081031", "story_v_out_222081.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_222081", "222081031", "story_v_out_222081.awb") / 1000

					if var_130_16 + var_130_10 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_10
					end

					if var_130_12.prefab_name ~= "" and arg_127_1.actors_[var_130_12.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_12.prefab_name].transform, "story_v_out_222081", "222081031", "story_v_out_222081.awb")

						arg_127_1:RecordAudio("222081031", var_130_17)
						arg_127_1:RecordAudio("222081031", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_222081", "222081031", "story_v_out_222081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_222081", "222081031", "story_v_out_222081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_11, arg_127_1.talkMaxDuration)

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_10) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_10 + var_130_18 and arg_127_1.time_ < var_130_10 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play222081032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 222081032
		arg_131_1.duration_ = 4.7

		local var_131_0 = {
			ja = 4.7,
			ko = 4.4,
			zh = 4.4
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
				arg_131_0:Play222081033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1070ui_story = arg_131_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).z)
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles = arg_131_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_131_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1070ui_story"].transform.position).z)
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1070ui_story"].transform.localEulerAngles = arg_131_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1070ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1070ui_story == nil then
				arg_131_1.var_.characterEffect1070ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1070ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1070ui_story then
				arg_131_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = arg_131_1.actors_["10057ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10057ui_story == nil then
				arg_131_1.var_.characterEffect10057ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect10057ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10057ui_story then
				arg_131_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_134_6 = 0
			local var_134_7 = 0.6

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(222081032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 24 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 24)

				if (24 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 24)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081032", "story_v_out_222081.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081032", "story_v_out_222081.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_222081", "222081032", "story_v_out_222081.awb")

						arg_131_1:RecordAudio("222081032", var_134_13)
						arg_131_1:RecordAudio("222081032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_222081", "222081032", "story_v_out_222081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_222081", "222081032", "story_v_out_222081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play222081033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 222081033
		arg_135_1.duration_ = 7.03

		local var_135_0 = {
			ja = 7.033,
			ko = 4.933,
			zh = 4.933
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
				arg_135_0:Play222081034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10057ui_story"]) and arg_135_1.var_.characterEffect10057ui_story == nil then
				arg_135_1.var_.characterEffect10057ui_story = arg_135_1.actors_["10057ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10057ui_story"]) then
				if arg_135_1.var_.characterEffect10057ui_story and not isNil(arg_135_1.actors_["10057ui_story"]) then
					arg_135_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10057ui_story"]) and arg_135_1.var_.characterEffect10057ui_story then
				arg_135_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_2 = arg_135_1.actors_["1070ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1070ui_story == nil then
				arg_135_1.var_.characterEffect1070ui_story = var_138_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_3 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.characterEffect1070ui_story and not isNil(var_138_2) then
					arg_135_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_3)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1070ui_story then
				arg_135_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_138_4 = 0
			local var_138_5 = 0.35

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(222081033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 14 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 14)

				if (14 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 14)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081033", "story_v_out_222081.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081033", "story_v_out_222081.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_222081", "222081033", "story_v_out_222081.awb")

						arg_135_1:RecordAudio("222081033", var_138_11)
						arg_135_1:RecordAudio("222081033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_222081", "222081033", "story_v_out_222081.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_222081", "222081033", "story_v_out_222081.awb")
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
	Play222081034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 222081034
		arg_139_1.duration_ = 5.47

		local var_139_0 = {
			ja = 5,
			ko = 5.466,
			zh = 5.466
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
				arg_139_0:Play222081035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1070ui_story = arg_139_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).z)
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles = arg_139_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_139_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1070ui_story"].transform.position).z)
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1070ui_story"].transform.localEulerAngles = arg_139_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1070ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1070ui_story == nil then
				arg_139_1.var_.characterEffect1070ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1070ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1070ui_story then
				arg_139_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_142_4 = arg_139_1.actors_["10057ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10057ui_story == nil then
				arg_139_1.var_.characterEffect10057ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_5 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 and not isNil(var_142_4) then
				if arg_139_1.var_.characterEffect10057ui_story and not isNil(var_142_4) then
					arg_139_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_5)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10057ui_story then
				arg_139_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_142_6 = 0
			local var_142_7 = 0.8

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(222081034)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 32 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 32)

				if (32 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 32)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081034", "story_v_out_222081.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081034", "story_v_out_222081.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_222081", "222081034", "story_v_out_222081.awb")

						arg_139_1:RecordAudio("222081034", var_142_13)
						arg_139_1:RecordAudio("222081034", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_222081", "222081034", "story_v_out_222081.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_222081", "222081034", "story_v_out_222081.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play222081035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 222081035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play222081036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1070ui_story = arg_143_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).z)
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles = arg_143_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).z)
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles = arg_143_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1070ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1070ui_story == nil then
				arg_143_1.var_.characterEffect1070ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1070ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1070ui_story then
				arg_143_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_146_3 = arg_143_1.actors_["10057ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10057ui_story = var_146_3.localPosition
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_3.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_4)
				var_146_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_3.position).x, (manager.ui.mainCamera.transform.position - var_146_3.position).y, (manager.ui.mainCamera.transform.position - var_146_3.position).z)
				var_146_3.localEulerAngles.z = 0
				var_146_3.localEulerAngles.x = 0
				var_146_3.localEulerAngles = var_146_3.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_3.localPosition = Vector3.New(0, 100, 0)
				var_146_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_3.position).x, (manager.ui.mainCamera.transform.position - var_146_3.position).y, (manager.ui.mainCamera.transform.position - var_146_3.position).z)
				var_146_3.localEulerAngles.z = 0
				var_146_3.localEulerAngles.x = 0
				var_146_3.localEulerAngles = var_146_3.localEulerAngles
			end

			local var_146_5 = arg_143_1.actors_["10057ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.characterEffect10057ui_story == nil then
				arg_143_1.var_.characterEffect10057ui_story = var_146_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_6 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_6 and not isNil(var_146_5) then
				if arg_143_1.var_.characterEffect10057ui_story and not isNil(var_146_5) then
					arg_143_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_6)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_6 and arg_143_1.time_ < 0 + var_146_6 + arg_146_0 and not isNil(var_146_5) and arg_143_1.var_.characterEffect10057ui_story then
				arg_143_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_gun", "")
			end

			local var_146_8 = manager.ui.mainCamera.transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_8.localPosition
			end

			local var_146_9 = 0.6

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_9 then
				local var_146_10, var_146_11 = math.modf((arg_143_1.time_ - 0) / 0.066)

				var_146_8.localPosition = Vector3.New(var_146_11 * 0.13, var_146_11 * 0.13, var_146_11 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= 0 + var_146_9 and arg_143_1.time_ < 0 + var_146_9 + arg_146_0 then
				var_146_8.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_12 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_12 + 0.6 and arg_143_1.time_ < var_146_12 + 0.6 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_13 = 0
			local var_146_14 = 1.075

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_15 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(222081035).content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_17 = 43 <= 0 and var_146_14 or var_146_14 * (utf8.len(var_146_15) / 43)

				if (43 <= 0 and var_146_14 or var_146_14 * (utf8.len(var_146_15) / 43)) > 0 and var_146_14 < var_146_17 then
					arg_143_1.talkMaxDuration = var_146_17

					if var_146_17 + var_146_13 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_17 + var_146_13
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_18 = math.max(var_146_14, arg_143_1.talkMaxDuration)

			if var_146_13 <= arg_143_1.time_ and arg_143_1.time_ < var_146_13 + var_146_18 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_13) / var_146_18

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_13 + var_146_18 and arg_143_1.time_ < var_146_13 + var_146_18 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play222081036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 222081036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			ja = 5.566,
			ko = 4.8,
			zh = 4.8
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
				arg_147_0:Play222081037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1070ui_story = arg_147_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).z)
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles = arg_147_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_147_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1070ui_story"].transform.position).z)
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1070ui_story"].transform.localEulerAngles = arg_147_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1070ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1070ui_story == nil then
				arg_147_1.var_.characterEffect1070ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1070ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1070ui_story then
				arg_147_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_4 = arg_147_1.actors_["10057ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect10057ui_story == nil then
				arg_147_1.var_.characterEffect10057ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_5 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 and not isNil(var_150_4) then
				if arg_147_1.var_.characterEffect10057ui_story and not isNil(var_150_4) then
					arg_147_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_5)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect10057ui_story then
				arg_147_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_150_6 = 0
			local var_150_7 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(222081036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 20 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 20)

				if (20 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 20)) > 0 and var_150_7 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081036", "story_v_out_222081.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081036", "story_v_out_222081.awb") / 1000

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_222081", "222081036", "story_v_out_222081.awb")

						arg_147_1:RecordAudio("222081036", var_150_13)
						arg_147_1:RecordAudio("222081036", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_222081", "222081036", "story_v_out_222081.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_222081", "222081036", "story_v_out_222081.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play222081037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 222081037
		arg_151_1.duration_ = 8.43

		local var_151_0 = {
			ja = 8.433,
			ko = 6.1,
			zh = 6.1
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
				arg_151_0:Play222081038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1070ui_story = arg_151_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).z)
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles = arg_151_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1070ui_story"].transform.position).z)
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1070ui_story"].transform.localEulerAngles = arg_151_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1070ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1070ui_story == nil then
				arg_151_1.var_.characterEffect1070ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1070ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1070ui_story then
				arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_154_3 = arg_151_1.actors_["10057ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10057ui_story = var_154_3.localPosition
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_3.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10057ui_story, Vector3.New(0, -1.13, -5.72), (arg_151_1.time_ - 0) / var_154_4)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_3.localPosition = Vector3.New(0, -1.13, -5.72)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			local var_154_5 = arg_151_1.actors_["10057ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect10057ui_story == nil then
				arg_151_1.var_.characterEffect10057ui_story = var_154_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_6 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.characterEffect10057ui_story and not isNil(var_154_5) then
					arg_151_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.characterEffect10057ui_story then
				arg_151_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_154_8 = 0
			local var_154_9 = 0.65

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:GetWordFromCfg(222081037)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 26 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 26)

				if (26 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_11) / 26)) > 0 and var_154_9 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081037", "story_v_out_222081.awb") ~= 0 then
					local var_154_14 = manager.audio:GetVoiceLength("story_v_out_222081", "222081037", "story_v_out_222081.awb") / 1000

					if var_154_14 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_8
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_222081", "222081037", "story_v_out_222081.awb")

						arg_151_1:RecordAudio("222081037", var_154_15)
						arg_151_1:RecordAudio("222081037", var_154_15)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_222081", "222081037", "story_v_out_222081.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_222081", "222081037", "story_v_out_222081.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_16 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_16 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_16

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_16 and arg_151_1.time_ < var_154_8 + var_154_16 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play222081038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 222081038
		arg_155_1.duration_ = 6

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play222081039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10057ui_story"]) and arg_155_1.var_.characterEffect10057ui_story == nil then
				arg_155_1.var_.characterEffect10057ui_story = arg_155_1.actors_["10057ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10057ui_story"]) then
				if arg_155_1.var_.characterEffect10057ui_story and not isNil(arg_155_1.actors_["10057ui_story"]) then
					arg_155_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10057ui_story"]) and arg_155_1.var_.characterEffect10057ui_story then
				arg_155_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_rockcollapse", "")
			end

			local var_158_2 = arg_155_1.actors_["10057ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10057ui_story = var_158_2.localPosition
			end

			local var_158_3 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 then
				var_158_2.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_3)
				var_158_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_2.position).x, (manager.ui.mainCamera.transform.position - var_158_2.position).y, (manager.ui.mainCamera.transform.position - var_158_2.position).z)
				var_158_2.localEulerAngles.z = 0
				var_158_2.localEulerAngles.x = 0
				var_158_2.localEulerAngles = var_158_2.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 then
				var_158_2.localPosition = Vector3.New(0, 100, 0)
				var_158_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_2.position).x, (manager.ui.mainCamera.transform.position - var_158_2.position).y, (manager.ui.mainCamera.transform.position - var_158_2.position).z)
				var_158_2.localEulerAngles.z = 0
				var_158_2.localEulerAngles.x = 0
				var_158_2.localEulerAngles = var_158_2.localEulerAngles
			end

			local var_158_4 = manager.ui.mainCamera.transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.shakeOldPos = var_158_4.localPosition
			end

			local var_158_5 = 2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 then
				local var_158_6, var_158_7 = math.modf((arg_155_1.time_ - 0) / 0.066)

				var_158_4.localPosition = Vector3.New(var_158_7 * 0.13, var_158_7 * 0.13, var_158_7 * 0.13) + arg_155_1.var_.shakeOldPos
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 then
				var_158_4.localPosition = arg_155_1.var_.shakeOldPos
			end

			local var_158_8 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_9 = 2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 then
				local var_158_10 = Color.New(1, 1, 1)

				var_158_10.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_8) / var_158_9)
				arg_155_1.mask_.color = var_158_10
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 then
				local var_158_11 = Color.New(1, 1, 1)

				arg_155_1.mask_.enabled = false
				var_158_11.a = 0
				arg_155_1.mask_.color = var_158_11
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_12 = 1
			local var_158_13 = 1.125

			if 1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_14 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_14:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(222081038).content)

				arg_155_1.text_.text = var_158_15

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 45 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 45)

				if (45 <= 0 and var_158_13 or var_158_13 * (utf8.len(var_158_15) / 45)) > 0 and var_158_13 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17
					var_158_12 = var_158_12 + 0.3

					if var_158_17 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_15
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_18 = var_158_12 + 0.3
			local var_158_19 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_18 + var_158_19 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_18) / var_158_19

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_18 + var_158_19 and arg_155_1.time_ < var_158_18 + var_158_19 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play222081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 222081039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play222081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.5

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(222081039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 60 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 60)

				if (60 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 60)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play222081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 222081040
		arg_165_1.duration_ = 6.07

		local var_165_0 = {
			ja = 6.066,
			ko = 5.166,
			zh = 5.133
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
				arg_165_0:Play222081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1074ui_story = arg_165_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).z)
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles = arg_165_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_165_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1074ui_story"].transform.position).z)
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1074ui_story"].transform.localEulerAngles = arg_165_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1074ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1074ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1074ui_story then
				arg_165_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.675

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(222081040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 27 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 27)

				if (27 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 27)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081040", "story_v_out_222081.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081040", "story_v_out_222081.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_222081", "222081040", "story_v_out_222081.awb")

						arg_165_1:RecordAudio("222081040", var_168_11)
						arg_165_1:RecordAudio("222081040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_222081", "222081040", "story_v_out_222081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_222081", "222081040", "story_v_out_222081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play222081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 222081041
		arg_169_1.duration_ = 9.03

		local var_169_0 = {
			ja = 6.1,
			ko = 9.033,
			zh = 9.033
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
				arg_169_0:Play222081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070ui_story = arg_169_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).z)
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles = arg_169_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_169_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1070ui_story"].transform.position).z)
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1070ui_story"].transform.localEulerAngles = arg_169_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1070ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1070ui_story == nil then
				arg_169_1.var_.characterEffect1070ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1070ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1070ui_story then
				arg_169_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_172_4 = arg_169_1.actors_["1074ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect1074ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1074ui_story then
				arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_172_6 = 0
			local var_172_7 = 1.4

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(222081041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 56 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 56)

				if (56 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 56)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081041", "story_v_out_222081.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081041", "story_v_out_222081.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_222081", "222081041", "story_v_out_222081.awb")

						arg_169_1:RecordAudio("222081041", var_172_13)
						arg_169_1:RecordAudio("222081041", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_222081", "222081041", "story_v_out_222081.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_222081", "222081041", "story_v_out_222081.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play222081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 222081042
		arg_173_1.duration_ = 2.97

		local var_173_0 = {
			ja = 2.966,
			ko = 2.6,
			zh = 2.6
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
				arg_173_0:Play222081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1074ui_story"]) and arg_173_1.var_.characterEffect1074ui_story == nil then
				arg_173_1.var_.characterEffect1074ui_story = arg_173_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1074ui_story"]) then
				if arg_173_1.var_.characterEffect1074ui_story and not isNil(arg_173_1.actors_["1074ui_story"]) then
					arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1074ui_story"]) and arg_173_1.var_.characterEffect1074ui_story then
				arg_173_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_2 = arg_173_1.actors_["1070ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1070ui_story == nil then
				arg_173_1.var_.characterEffect1070ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect1070ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1070ui_story then
				arg_173_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_176_4 = 0
			local var_176_5 = 0.275

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(222081042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 11 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 11)

				if (11 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 11)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081042", "story_v_out_222081.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081042", "story_v_out_222081.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_222081", "222081042", "story_v_out_222081.awb")

						arg_173_1:RecordAudio("222081042", var_176_11)
						arg_173_1:RecordAudio("222081042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_222081", "222081042", "story_v_out_222081.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_222081", "222081042", "story_v_out_222081.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play222081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 222081043
		arg_177_1.duration_ = 8.5

		local var_177_0 = {
			ja = 8.5,
			ko = 5.566,
			zh = 5.566
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
				arg_177_0:Play222081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1074ui_story"]) and arg_177_1.var_.characterEffect1074ui_story == nil then
				arg_177_1.var_.characterEffect1074ui_story = arg_177_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1074ui_story"]) then
				if arg_177_1.var_.characterEffect1074ui_story and not isNil(arg_177_1.actors_["1074ui_story"]) then
					arg_177_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1074ui_story"]) and arg_177_1.var_.characterEffect1074ui_story then
				arg_177_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_180_2 = 0
			local var_180_3 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(222081043)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 35 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 35)

				if (35 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 35)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081043", "story_v_out_222081.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081043", "story_v_out_222081.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_out_222081", "222081043", "story_v_out_222081.awb")

						arg_177_1:RecordAudio("222081043", var_180_9)
						arg_177_1:RecordAudio("222081043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_222081", "222081043", "story_v_out_222081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_222081", "222081043", "story_v_out_222081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play222081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 222081044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play222081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1074ui_story = arg_181_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).z)
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles = arg_181_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1074ui_story"].transform.position).z)
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1074ui_story"].transform.localEulerAngles = arg_181_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1074ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1074ui_story == nil then
				arg_181_1.var_.characterEffect1074ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1074ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1074ui_story then
				arg_181_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["1070ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1070ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, 100, 0)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = arg_181_1.actors_["1070ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1070ui_story == nil then
				arg_181_1.var_.characterEffect1070ui_story = var_184_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.characterEffect1070ui_story and not isNil(var_184_5) then
					arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_6)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1070ui_story then
				arg_181_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_184_7 = manager.ui.mainCamera.transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.shakeOldPos = var_184_7.localPosition
			end

			local var_184_8 = 1

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_8 then
				local var_184_9, var_184_10 = math.modf((arg_181_1.time_ - 0) / 0.066)

				var_184_7.localPosition = Vector3.New(var_184_10 * 0.13, var_184_10 * 0.13, var_184_10 * 0.13) + arg_181_1.var_.shakeOldPos
			end

			if arg_181_1.time_ >= 0 + var_184_8 and arg_181_1.time_ < 0 + var_184_8 + arg_184_0 then
				var_184_7.localPosition = arg_181_1.var_.shakeOldPos
			end

			local var_184_11 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_11 + 1 and arg_181_1.time_ < var_184_11 + 1 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_12 = 0
			local var_184_13 = 1.675

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_12 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(222081044).content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 67 <= 0 and var_184_13 or var_184_13 * (utf8.len(var_184_14) / 67)

				if (67 <= 0 and var_184_13 or var_184_13 * (utf8.len(var_184_14) / 67)) > 0 and var_184_13 < var_184_16 then
					arg_181_1.talkMaxDuration = var_184_16

					if var_184_16 + var_184_12 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_12
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_17 = math.max(var_184_13, arg_181_1.talkMaxDuration)

			if var_184_12 <= arg_181_1.time_ and arg_181_1.time_ < var_184_12 + var_184_17 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_12) / var_184_17

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_12 + var_184_17 and arg_181_1.time_ < var_184_12 + var_184_17 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play222081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 222081045
		arg_185_1.duration_ = 6.67

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play222081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_mosterenergy", "")
			end

			local var_188_1 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_2 = 2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = Color.New(1, 1, 1)

				var_188_3.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_1) / var_188_2)
				arg_185_1.mask_.color = var_188_3
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				local var_188_4 = Color.New(1, 1, 1)

				arg_185_1.mask_.enabled = false
				var_188_4.a = 0
				arg_185_1.mask_.color = var_188_4
			end

			local var_188_5 = manager.ui.mainCamera.transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.shakeOldPos = var_188_5.localPosition
			end

			local var_188_6 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 then
				local var_188_7, var_188_8 = math.modf((arg_185_1.time_ - 0) / 0.066)

				var_188_5.localPosition = Vector3.New(var_188_8 * 0.13, var_188_8 * 0.13, var_188_8 * 0.13) + arg_185_1.var_.shakeOldPos
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 then
				var_188_5.localPosition = arg_185_1.var_.shakeOldPos
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_9 = 1.66666666666667
			local var_188_10 = 0.8

			if 1.66666666666667 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_11 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_11:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_12 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(222081045).content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_14 = 32 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 32)

				if (32 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 32)) > 0 and var_188_10 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14
					var_188_9 = var_188_9 + 0.3

					if var_188_14 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_15 = var_188_9 + 0.3
			local var_188_16 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_16 and arg_185_1.time_ < var_188_15 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play222081046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 222081046
		arg_191_1.duration_ = 5.7

		local var_191_0 = {
			ja = 5.7,
			ko = 2.266,
			zh = 2.266
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
				arg_191_0:Play222081047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1070ui_story = arg_191_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).z)
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles = arg_191_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_191_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1070ui_story"].transform.position).z)
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1070ui_story"].transform.localEulerAngles = arg_191_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1070ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1070ui_story == nil then
				arg_191_1.var_.characterEffect1070ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1070ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1070ui_story then
				arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.225

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(222081046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 9 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 9)

				if (9 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 9)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081046", "story_v_out_222081.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081046", "story_v_out_222081.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_222081", "222081046", "story_v_out_222081.awb")

						arg_191_1:RecordAudio("222081046", var_194_11)
						arg_191_1:RecordAudio("222081046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_222081", "222081046", "story_v_out_222081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_222081", "222081046", "story_v_out_222081.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play222081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 222081047
		arg_195_1.duration_ = 2

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play222081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1074ui_story = arg_195_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).z)
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles = arg_195_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_195_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1074ui_story"].transform.position).z)
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1074ui_story"].transform.localEulerAngles = arg_195_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1074ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1074ui_story == nil then
				arg_195_1.var_.characterEffect1074ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1074ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1074ui_story then
				arg_195_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_198_4 = arg_195_1.actors_["1070ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1070ui_story == nil then
				arg_195_1.var_.characterEffect1070ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect1070ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_5)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1070ui_story then
				arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_198_6 = 0
			local var_198_7 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(222081047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 4 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 4)

				if (4 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 4)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081047", "story_v_out_222081.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081047", "story_v_out_222081.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_222081", "222081047", "story_v_out_222081.awb")

						arg_195_1:RecordAudio("222081047", var_198_13)
						arg_195_1:RecordAudio("222081047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_222081", "222081047", "story_v_out_222081.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_222081", "222081047", "story_v_out_222081.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play222081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 222081048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play222081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1074ui_story = arg_199_1.actors_["1074ui_story"].transform.localPosition

				arg_199_1:ShowWeapon(arg_199_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).z)
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles = arg_199_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1074ui_story"].transform.position).z)
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1074ui_story"].transform.localEulerAngles = arg_199_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1074ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1074ui_story == nil then
				arg_199_1.var_.characterEffect1074ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1074ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_2)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1074ui_story then
				arg_199_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_202_3 = arg_199_1.actors_["1070ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1070ui_story = var_202_3.localPosition
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_3.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_4)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_3.localPosition = Vector3.New(0, 100, 0)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			local var_202_5 = arg_199_1.actors_["1070ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1070ui_story == nil then
				arg_199_1.var_.characterEffect1070ui_story = var_202_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.characterEffect1070ui_story and not isNil(var_202_5) then
					arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_6)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1070ui_story then
				arg_199_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_202_7 = 0
			local var_202_8 = 0.775

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_9 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(222081048).content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 31 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_9) / 31)

				if (31 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_9) / 31)) > 0 and var_202_8 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_7 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_7
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_8, arg_199_1.talkMaxDuration)

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_7) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_7 + var_202_12 and arg_199_1.time_ < var_202_7 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play222081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 222081049
		arg_203_1.duration_ = 6.8

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play222081050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:AudioAction("stop", "effect", "se_story_222_00", "se_story_222_00_quarry", "")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_enchantment_start", "")
			end

			local var_206_2 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_3 = 2

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_3 then
				local var_206_4 = Color.New(1, 1, 1)

				var_206_4.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_2) / var_206_3)
				arg_203_1.mask_.color = var_206_4
			end

			if arg_203_1.time_ >= var_206_2 + var_206_3 and arg_203_1.time_ < var_206_2 + var_206_3 + arg_206_0 then
				local var_206_5 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_5.a = 0
				arg_203_1.mask_.color = var_206_5
			end

			local var_206_6 = "ST52"

			if arg_203_1.bgs_.ST52 == nil then
				local var_206_7 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_6)
				var_206_7.name = var_206_6
				var_206_7.transform.parent = arg_203_1.stage_.transform
				var_206_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_6] = var_206_7
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_8 = arg_203_1.bgs_.ST52

				arg_203_1.bgs_.ST52.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_9 = var_206_8:GetComponent("SpriteRenderer")

				if var_206_9 and var_206_9.sprite then
					local var_206_10 = 2 * (var_206_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_8.transform.localScale = Vector3.New(var_206_10 / var_206_9.sprite.bounds.size.y < var_206_10 * manager.ui.mainCameraCom_.aspect / var_206_9.sprite.bounds.size.x and var_206_10 * manager.ui.mainCameraCom_.aspect / var_206_9.sprite.bounds.size.x or var_206_10 / var_206_9.sprite.bounds.size.y, var_206_10 / var_206_9.sprite.bounds.size.y < var_206_10 * manager.ui.mainCameraCom_.aspect / var_206_9.sprite.bounds.size.x and var_206_10 * manager.ui.mainCameraCom_.aspect / var_206_9.sprite.bounds.size.x or var_206_10 / var_206_9.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST52" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_11 = arg_203_1.bgs_.ST52.transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPosST52 = var_206_11.localPosition
			end

			local var_206_12 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_12 then
				var_206_11.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosST52, Vector3.New(0, 1, 9.5), (arg_203_1.time_ - 0) / var_206_12)
			end

			if arg_203_1.time_ >= 0 + var_206_12 and arg_203_1.time_ < 0 + var_206_12 + arg_206_0 then
				var_206_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_206_13 = arg_203_1.bgs_.ST52.transform

			if 0.0166666666666667 < arg_203_1.time_ and arg_203_1.time_ <= 0.0166666666666667 + arg_206_0 then
				arg_203_1.var_.moveOldPosST52 = var_206_13.localPosition
			end

			local var_206_14 = 4.083333

			if 0.0166666666666667 <= arg_203_1.time_ and arg_203_1.time_ < 0.0166666666666667 + var_206_14 then
				var_206_13.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosST52, Vector3.New(0, 1, 10), (arg_203_1.time_ - 0.0166666666666667) / var_206_14)
			end

			if arg_203_1.time_ >= 0.0166666666666667 + var_206_14 and arg_203_1.time_ < 0.0166666666666667 + var_206_14 + arg_206_0 then
				var_206_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_206_15 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_15 + 2.09999966666667 and arg_203_1.time_ < var_206_15 + 2.09999966666667 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_16 = 1.8
			local var_206_17 = 0.875

			if 1.8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_18 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_18:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_19 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(222081049).content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_21 = 35 <= 0 and var_206_17 or var_206_17 * (utf8.len(var_206_19) / 35)

				if (35 <= 0 and var_206_17 or var_206_17 * (utf8.len(var_206_19) / 35)) > 0 and var_206_17 < var_206_21 then
					arg_203_1.talkMaxDuration = var_206_21
					var_206_16 = var_206_16 + 0.3

					if var_206_21 + var_206_16 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_21 + var_206_16
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_22 = var_206_16 + 0.3
			local var_206_23 = math.max(var_206_17, arg_203_1.talkMaxDuration)

			if var_206_16 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_22 + var_206_23 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_22) / var_206_23

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_22 + var_206_23 and arg_203_1.time_ < var_206_22 + var_206_23 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST52",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST52",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.083333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play222081050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 222081050
		arg_209_1.duration_ = 3.47

		local var_209_0 = {
			ja = 2.9,
			ko = 3.433,
			zh = 3.466
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
				arg_209_0:Play222081051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1074ui_story = arg_209_1.actors_["1074ui_story"].transform.localPosition

				arg_209_1:ShowWeapon(arg_209_1.var_["1074ui_story" .. "Animator"].transform, true)
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).z)
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles = arg_209_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_209_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1074ui_story"].transform.position).z)
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1074ui_story"].transform.localEulerAngles = arg_209_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1074ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1074ui_story == nil then
				arg_209_1.var_.characterEffect1074ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1074ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1074ui_story then
				arg_209_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action7_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.375

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(222081050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 15 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 15)

				if (15 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 15)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081050", "story_v_out_222081.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081050", "story_v_out_222081.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_222081", "222081050", "story_v_out_222081.awb")

						arg_209_1:RecordAudio("222081050", var_212_11)
						arg_209_1:RecordAudio("222081050", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_222081", "222081050", "story_v_out_222081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_222081", "222081050", "story_v_out_222081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play222081051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 222081051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play222081052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1074ui_story = arg_213_1.actors_["1074ui_story"].transform.localPosition

				arg_213_1:ShowWeapon(arg_213_1.var_["1074ui_story" .. "Animator"].transform, false)
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).z)
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles = arg_213_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1074ui_story"].transform.position).z)
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1074ui_story"].transform.localEulerAngles = arg_213_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1074ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1074ui_story == nil then
				arg_213_1.var_.characterEffect1074ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1074ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_2)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1074ui_story then
				arg_213_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_216_3 = 0
			local var_216_4 = 1.15

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(222081051).content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 46 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_5) / 46)

				if (46 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_5) / 46)) > 0 and var_216_4 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_3
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_4, arg_213_1.talkMaxDuration)

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_3) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_3 + var_216_8 and arg_213_1.time_ < var_216_3 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play222081052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 222081052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play222081053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.775

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(222081052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 31 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 31)

				if (31 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 31)) > 0 and var_220_0 < var_220_3 then
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
	Play222081053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 222081053
		arg_221_1.duration_ = 6.97

		local var_221_0 = {
			ja = 5.866,
			ko = 6.966,
			zh = 6.966
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
				arg_221_0:Play222081054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_224_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_221_1.stage_.transform)

				var_224_0.name = "1071ui_story"
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1071ui_story"] = var_224_0

				local var_224_1 = var_224_0:GetComponentInChildren(typeof(CharacterEffect))

				var_224_1.enabled = true

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end

				arg_221_1:ShowWeapon(var_224_1.transform, false)

				arg_221_1.var_["1071ui_story" .. "Animator"] = var_224_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_221_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_221_1.var_["1071ui_story" .. "LipSync"] = var_224_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_224_3 = arg_221_1.actors_["1071ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1071ui_story = var_224_3.localPosition
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_3.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_221_1.time_ - 0) / var_224_4)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_3.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			local var_224_5 = arg_221_1.actors_["1071ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect1071ui_story == nil then
				arg_221_1.var_.characterEffect1071ui_story = var_224_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.characterEffect1071ui_story and not isNil(var_224_5) then
					arg_221_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect1071ui_story then
				arg_221_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_224_8 = 0
			local var_224_9 = 0.825

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(222081053)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 33 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 33)

				if (33 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 33)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081053", "story_v_out_222081.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_222081", "222081053", "story_v_out_222081.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_222081", "222081053", "story_v_out_222081.awb")

						arg_221_1:RecordAudio("222081053", var_224_15)
						arg_221_1:RecordAudio("222081053", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_222081", "222081053", "story_v_out_222081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_222081", "222081053", "story_v_out_222081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play222081054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 222081054
		arg_225_1.duration_ = 8.5

		local var_225_0 = {
			ja = 8.5,
			ko = 6.033,
			zh = 6.033
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
				arg_225_0:Play222081055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10057ui_story = arg_225_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10057ui_story, Vector3.New(0.7, -1.13, -5.72), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).z)
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles = arg_225_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(0.7, -1.13, -5.72)
				arg_225_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10057ui_story"].transform.position).z)
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10057ui_story"].transform.localEulerAngles = arg_225_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["10057ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10057ui_story == nil then
				arg_225_1.var_.characterEffect10057ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect10057ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10057ui_story then
				arg_225_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action1_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_228_4 = arg_225_1.actors_["1071ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1071ui_story == nil then
				arg_225_1.var_.characterEffect1071ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_5 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 and not isNil(var_228_4) then
				if arg_225_1.var_.characterEffect1071ui_story and not isNil(var_228_4) then
					arg_225_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_5)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1071ui_story then
				arg_225_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_228_6 = 0
			local var_228_7 = 0.65

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(222081054)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 26 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 26)

				if (26 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 26)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081054", "story_v_out_222081.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081054", "story_v_out_222081.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_222081", "222081054", "story_v_out_222081.awb")

						arg_225_1:RecordAudio("222081054", var_228_13)
						arg_225_1:RecordAudio("222081054", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_222081", "222081054", "story_v_out_222081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_222081", "222081054", "story_v_out_222081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play222081055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 222081055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play222081056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10057ui_story = arg_229_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).z)
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles = arg_229_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10057ui_story"].transform.position).z)
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10057ui_story"].transform.localEulerAngles = arg_229_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["10057ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10057ui_story == nil then
				arg_229_1.var_.characterEffect10057ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect10057ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_2)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10057ui_story then
				arg_229_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_232_3 = arg_229_1.actors_["1071ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1071ui_story = var_232_3.localPosition
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_4)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0, 100, 0)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			local var_232_5 = arg_229_1.actors_["1071ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect1071ui_story == nil then
				arg_229_1.var_.characterEffect1071ui_story = var_232_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.characterEffect1071ui_story and not isNil(var_232_5) then
					arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_6)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect1071ui_story then
				arg_229_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_232_7 = 0
			local var_232_8 = 1.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(222081055).content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 49 <= 0 and var_232_8 or var_232_8 * (utf8.len(var_232_9) / 49)

				if (49 <= 0 and var_232_8 or var_232_8 * (utf8.len(var_232_9) / 49)) > 0 and var_232_8 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_7 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_7
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_8, arg_229_1.talkMaxDuration)

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_7) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_7 + var_232_12 and arg_229_1.time_ < var_232_7 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play222081056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 222081056
		arg_233_1.duration_ = 3.47

		local var_233_0 = {
			ja = 3.466,
			ko = 2.633,
			zh = 2.633
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
				arg_233_0:Play222081057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_236_0 = 0.6

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				local var_236_1, var_236_2 = math.modf((arg_233_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_236_2 * 0.13, var_236_2 * 0.13, var_236_2 * 0.13) + arg_233_1.var_.shakeOldPos
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				manager.ui.mainCamera.transform.localPosition = arg_233_1.var_.shakeOldPos
			end

			local var_236_3 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_3 + 0.6 and arg_233_1.time_ < var_236_3 + 0.6 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_4 = 0
			local var_236_5 = 0.3

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_6 = arg_233_1:GetWordFromCfg(222081056)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 12)

				if (12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 12)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081056", "story_v_out_222081.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081056", "story_v_out_222081.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_222081", "222081056", "story_v_out_222081.awb")

						arg_233_1:RecordAudio("222081056", var_236_11)
						arg_233_1:RecordAudio("222081056", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_222081", "222081056", "story_v_out_222081.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_222081", "222081056", "story_v_out_222081.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play222081057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 222081057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play222081058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_240_1 = 0
			local var_240_2 = 0.95

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(222081057).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 38 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 38)

				if (38 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 38)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play222081058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 222081058
		arg_241_1.duration_ = 8.77

		local var_241_0 = {
			ja = 8.766,
			ko = 5.933,
			zh = 5.9
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
				arg_241_0:Play222081059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1070ui_story = arg_241_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).z)
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles = arg_241_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_241_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).z)
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles = arg_241_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1070ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1070ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1070ui_story then
				arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(222081058)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 31)

				if (31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 31)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081058", "story_v_out_222081.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081058", "story_v_out_222081.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_222081", "222081058", "story_v_out_222081.awb")

						arg_241_1:RecordAudio("222081058", var_244_11)
						arg_241_1:RecordAudio("222081058", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_222081", "222081058", "story_v_out_222081.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_222081", "222081058", "story_v_out_222081.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play222081059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 222081059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play222081060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) and arg_245_1.var_.characterEffect1070ui_story == nil then
				arg_245_1.var_.characterEffect1070ui_story = arg_245_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) then
				if arg_245_1.var_.characterEffect1070ui_story and not isNil(arg_245_1.actors_["1070ui_story"]) then
					arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) and arg_245_1.var_.characterEffect1070ui_story then
				arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.825

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(222081059).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 33 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 33)

				if (33 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 33)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play222081060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 222081060
		arg_249_1.duration_ = 3.17

		local var_249_0 = {
			ja = 2.8,
			ko = 3.166,
			zh = 3.166
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
				arg_249_0:Play222081061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) and arg_249_1.var_.characterEffect1070ui_story == nil then
				arg_249_1.var_.characterEffect1070ui_story = arg_249_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) then
				if arg_249_1.var_.characterEffect1070ui_story and not isNil(arg_249_1.actors_["1070ui_story"]) then
					arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) and arg_249_1.var_.characterEffect1070ui_story then
				arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.25

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(222081060)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 10 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 10)

				if (10 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 10)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081060", "story_v_out_222081.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_222081", "222081060", "story_v_out_222081.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_out_222081", "222081060", "story_v_out_222081.awb")

						arg_249_1:RecordAudio("222081060", var_252_9)
						arg_249_1:RecordAudio("222081060", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_222081", "222081060", "story_v_out_222081.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_222081", "222081060", "story_v_out_222081.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play222081061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 222081061
		arg_253_1.duration_ = 7.8

		local var_253_0 = {
			ja = 7.366,
			ko = 7.8,
			zh = 7.8
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
				arg_253_0:Play222081062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1070ui_story = arg_253_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).z)
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles = arg_253_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_253_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1070ui_story"].transform.position).z)
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1070ui_story"].transform.localEulerAngles = arg_253_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1070ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1070ui_story == nil then
				arg_253_1.var_.characterEffect1070ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1070ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_2)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1070ui_story then
				arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_256_3 = arg_253_1.actors_["1071ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1071ui_story = var_256_3.localPosition
			end

			local var_256_4 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				var_256_3.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_253_1.time_ - 0) / var_256_4)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				var_256_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_256_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_3.position).x, (manager.ui.mainCamera.transform.position - var_256_3.position).y, (manager.ui.mainCamera.transform.position - var_256_3.position).z)
				var_256_3.localEulerAngles.z = 0
				var_256_3.localEulerAngles.x = 0
				var_256_3.localEulerAngles = var_256_3.localEulerAngles
			end

			local var_256_5 = arg_253_1.actors_["1071ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect1071ui_story == nil then
				arg_253_1.var_.characterEffect1071ui_story = var_256_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 and not isNil(var_256_5) then
				if arg_253_1.var_.characterEffect1071ui_story and not isNil(var_256_5) then
					arg_253_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and not isNil(var_256_5) and arg_253_1.var_.characterEffect1071ui_story then
				arg_253_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_8 = 0
			local var_256_9 = 0.875

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(222081061)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 35 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 35)

				if (35 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 35)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081061", "story_v_out_222081.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_222081", "222081061", "story_v_out_222081.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_222081", "222081061", "story_v_out_222081.awb")

						arg_253_1:RecordAudio("222081061", var_256_15)
						arg_253_1:RecordAudio("222081061", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_222081", "222081061", "story_v_out_222081.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_222081", "222081061", "story_v_out_222081.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play222081062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 222081062
		arg_257_1.duration_ = 7.47

		local var_257_0 = {
			ja = 6.933,
			ko = 7.466,
			zh = 7.466
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
				arg_257_0:Play222081063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_260_1 = 0
			local var_260_2 = 0.925

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(222081062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 37 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 37)

				if (37 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 37)) > 0 and var_260_2 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081062", "story_v_out_222081.awb") ~= 0 then
					local var_260_7 = manager.audio:GetVoiceLength("story_v_out_222081", "222081062", "story_v_out_222081.awb") / 1000

					if var_260_7 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_1
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_222081", "222081062", "story_v_out_222081.awb")

						arg_257_1:RecordAudio("222081062", var_260_8)
						arg_257_1:RecordAudio("222081062", var_260_8)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_222081", "222081062", "story_v_out_222081.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_222081", "222081062", "story_v_out_222081.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_9 and arg_257_1.time_ < var_260_1 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play222081063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 222081063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play222081064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1071ui_story = arg_261_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).z)
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles = arg_261_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1071ui_story"].transform.position).z)
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1071ui_story"].transform.localEulerAngles = arg_261_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1071ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1071ui_story == nil then
				arg_261_1.var_.characterEffect1071ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1071ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_2)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1071ui_story then
				arg_261_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_264_3 = arg_261_1.actors_["1070ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1070ui_story = var_264_3.localPosition
			end

			local var_264_4 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				var_264_3.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_4)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				var_264_3.localPosition = Vector3.New(0, 100, 0)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			local var_264_5 = arg_261_1.actors_["1070ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1070ui_story == nil then
				arg_261_1.var_.characterEffect1070ui_story = var_264_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.characterEffect1070ui_story and not isNil(var_264_5) then
					arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_6)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.characterEffect1070ui_story then
				arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_finger", "")
			end

			local var_264_8 = 0
			local var_264_9 = 1.425

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(222081063).content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_12 = 57 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_10) / 57)

				if (57 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_10) / 57)) > 0 and var_264_9 < var_264_12 then
					arg_261_1.talkMaxDuration = var_264_12

					if var_264_12 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_13 and arg_261_1.time_ < var_264_8 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play222081064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 222081064
		arg_265_1.duration_ = 2.47

		local var_265_0 = {
			ja = 2.466,
			ko = 2.333,
			zh = 2.366
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
				arg_265_0:Play222081065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10057ui_story = arg_265_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10057ui_story, Vector3.New(-0.7, -1.13, -5.72), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).z)
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles = arg_265_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(-0.7, -1.13, -5.72)
				arg_265_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10057ui_story"].transform.position).z)
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10057ui_story"].transform.localEulerAngles = arg_265_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["10057ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10057ui_story == nil then
				arg_265_1.var_.characterEffect10057ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect10057ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect10057ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10057ui_story then
				arg_265_1.var_.characterEffect10057ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/story10057/story10057action/10057action6_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10057ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.175

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[464].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(222081064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 7 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 7)

				if (7 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 7)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081064", "story_v_out_222081.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081064", "story_v_out_222081.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_222081", "222081064", "story_v_out_222081.awb")

						arg_265_1:RecordAudio("222081064", var_268_11)
						arg_265_1:RecordAudio("222081064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_222081", "222081064", "story_v_out_222081.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_222081", "222081064", "story_v_out_222081.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play222081065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 222081065
		arg_269_1.duration_ = 3.53

		local var_269_0 = {
			ja = 3.533,
			ko = 2.433,
			zh = 2.433
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
				arg_269_0:Play222081066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["10057ui_story"]) and arg_269_1.var_.characterEffect10057ui_story == nil then
				arg_269_1.var_.characterEffect10057ui_story = arg_269_1.actors_["10057ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["10057ui_story"]) then
				if arg_269_1.var_.characterEffect10057ui_story and not isNil(arg_269_1.actors_["10057ui_story"]) then
					arg_269_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["10057ui_story"]) and arg_269_1.var_.characterEffect10057ui_story then
				arg_269_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_272_1 = arg_269_1.actors_["1071ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1071ui_story = var_272_1.localPosition
			end

			local var_272_2 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 then
				var_272_1.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_269_1.time_ - 0) / var_272_2)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 then
				var_272_1.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			local var_272_3 = arg_269_1.actors_["1071ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_3) and arg_269_1.var_.characterEffect1071ui_story == nil then
				arg_269_1.var_.characterEffect1071ui_story = var_272_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_4 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 and not isNil(var_272_3) then
				if arg_269_1.var_.characterEffect1071ui_story and not isNil(var_272_3) then
					arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 and not isNil(var_272_3) and arg_269_1.var_.characterEffect1071ui_story then
				arg_269_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_6 = 0
			local var_272_7 = 0.275

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(222081065)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 11 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 11)

				if (11 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 11)) > 0 and var_272_7 < var_272_11 then
					arg_269_1.talkMaxDuration = var_272_11

					if var_272_11 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081065", "story_v_out_222081.awb") ~= 0 then
					local var_272_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081065", "story_v_out_222081.awb") / 1000

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_out_222081", "222081065", "story_v_out_222081.awb")

						arg_269_1:RecordAudio("222081065", var_272_13)
						arg_269_1:RecordAudio("222081065", var_272_13)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_222081", "222081065", "story_v_out_222081.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_222081", "222081065", "story_v_out_222081.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play222081066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 222081066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play222081067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10057ui_story = arg_273_1.actors_["10057ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10057ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10057ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).z)
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles = arg_273_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10057ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["10057ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10057ui_story"].transform.position).z)
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10057ui_story"].transform.localEulerAngles = arg_273_1.actors_["10057ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10057ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10057ui_story == nil then
				arg_273_1.var_.characterEffect10057ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10057ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10057ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10057ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_2)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10057ui_story then
				arg_273_1.var_.characterEffect10057ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10057ui_story.fillRatio = 0.5
			end

			local var_276_3 = arg_273_1.actors_["1071ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1071ui_story = var_276_3.localPosition
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_3.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_4)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_3.localPosition = Vector3.New(0, 100, 0)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			local var_276_5 = arg_273_1.actors_["1071ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1071ui_story == nil then
				arg_273_1.var_.characterEffect1071ui_story = var_276_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_6 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.characterEffect1071ui_story and not isNil(var_276_5) then
					arg_273_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_6)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect1071ui_story then
				arg_273_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_276_7 = 0
			local var_276_8 = 1.625

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_7 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_9 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(222081066).content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 65 <= 0 and var_276_8 or var_276_8 * (utf8.len(var_276_9) / 65)

				if (65 <= 0 and var_276_8 or var_276_8 * (utf8.len(var_276_9) / 65)) > 0 and var_276_8 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_7 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_7
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_8, arg_273_1.talkMaxDuration)

			if var_276_7 <= arg_273_1.time_ and arg_273_1.time_ < var_276_7 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_7) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_7 + var_276_12 and arg_273_1.time_ < var_276_7 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10057ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play222081067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 222081067
		arg_277_1.duration_ = 7.2

		local var_277_0 = {
			ja = 7.2,
			ko = 3.433,
			zh = 3.433
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
				arg_277_0:Play222081068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1070ui_story = arg_277_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).z)
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles = arg_277_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_277_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1070ui_story"].transform.position).z)
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1070ui_story"].transform.localEulerAngles = arg_277_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1070ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1070ui_story == nil then
				arg_277_1.var_.characterEffect1070ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1070ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1070ui_story then
				arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.4

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(222081067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 16 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 16)

				if (16 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 16)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081067", "story_v_out_222081.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_222081", "222081067", "story_v_out_222081.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_222081", "222081067", "story_v_out_222081.awb")

						arg_277_1:RecordAudio("222081067", var_280_11)
						arg_277_1:RecordAudio("222081067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_222081", "222081067", "story_v_out_222081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_222081", "222081067", "story_v_out_222081.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play222081068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 222081068
		arg_281_1.duration_ = 2.4

		local var_281_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_281_0:Play222081069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1074ui_story = arg_281_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).z)
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles = arg_281_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_281_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1074ui_story"].transform.position).z)
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1074ui_story"].transform.localEulerAngles = arg_281_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1074ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1074ui_story == nil then
				arg_281_1.var_.characterEffect1074ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1074ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1074ui_story then
				arg_281_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_284_4 = arg_281_1.actors_["1070ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1070ui_story == nil then
				arg_281_1.var_.characterEffect1070ui_story = var_284_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_5 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 and not isNil(var_284_4) then
				if arg_281_1.var_.characterEffect1070ui_story and not isNil(var_284_4) then
					arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_5)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1070ui_story then
				arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_284_6 = 0
			local var_284_7 = 0.15

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_8 = arg_281_1:GetWordFromCfg(222081068)
				local var_284_9 = arg_281_1:FormatText(var_284_8.content)

				arg_281_1.text_.text = var_284_9

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_11 = 6 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 6)

				if (6 <= 0 and var_284_7 or var_284_7 * (utf8.len(var_284_9) / 6)) > 0 and var_284_7 < var_284_11 then
					arg_281_1.talkMaxDuration = var_284_11

					if var_284_11 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_6
					end
				end

				arg_281_1.text_.text = var_284_9
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_222081", "222081068", "story_v_out_222081.awb") ~= 0 then
					local var_284_12 = manager.audio:GetVoiceLength("story_v_out_222081", "222081068", "story_v_out_222081.awb") / 1000

					if var_284_12 + var_284_6 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_12 + var_284_6
					end

					if var_284_8.prefab_name ~= "" and arg_281_1.actors_[var_284_8.prefab_name] ~= nil then
						local var_284_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_8.prefab_name].transform, "story_v_out_222081", "222081068", "story_v_out_222081.awb")

						arg_281_1:RecordAudio("222081068", var_284_13)
						arg_281_1:RecordAudio("222081068", var_284_13)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_222081", "222081068", "story_v_out_222081.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_222081", "222081068", "story_v_out_222081.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_14 = math.max(var_284_7, arg_281_1.talkMaxDuration)

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_14 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_6) / var_284_14

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_6 + var_284_14 and arg_281_1.time_ < var_284_6 + var_284_14 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play222081069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 222081069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
			arg_285_1.auto_ = false
		end

		function arg_285_1.playNext_(arg_287_0)
			arg_285_1.onStoryFinished_()
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1070ui_story = arg_285_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).z)
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles = arg_285_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1070ui_story"].transform.position).z)
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1070ui_story"].transform.localEulerAngles = arg_285_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1070ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1070ui_story == nil then
				arg_285_1.var_.characterEffect1070ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1070ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_2)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1070ui_story then
				arg_285_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_288_3 = arg_285_1.actors_["1074ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1074ui_story = var_288_3.localPosition
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_3.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_4)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_3.localPosition = Vector3.New(0, 100, 0)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			local var_288_5 = arg_285_1.actors_["1074ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = var_288_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.characterEffect1074ui_story and not isNil(var_288_5) then
					arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_6)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1074ui_story then
				arg_285_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_288_7 = 0
			local var_288_8 = 0.65

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_9 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(222081069).content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 26 <= 0 and var_288_8 or var_288_8 * (utf8.len(var_288_9) / 26)

				if (26 <= 0 and var_288_8 or var_288_8 * (utf8.len(var_288_9) / 26)) > 0 and var_288_8 < var_288_11 then
					arg_285_1.talkMaxDuration = var_288_11

					if var_288_11 + var_288_7 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_7
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_8, arg_285_1.talkMaxDuration)

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_7) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_7 + var_288_12 and arg_285_1.time_ < var_288_7 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/YZ0103",
		"TextureConfig/Background/J03g",
		"TextureConfig/Background/ST52"
	},
	voices = {
		"story_v_out_222081.awb"
	}
}
