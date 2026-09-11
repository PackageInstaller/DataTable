return {
	Play112011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112011001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_lowpass", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_bubbleloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_3 = 0
			local var_4_4 = 0.725

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_3 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_5 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_5:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_6 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112011001).content)

				arg_1_1.text_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_8 = 29 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_6) / 29)

				if (29 <= 0 and var_4_4 or var_4_4 * (utf8.len(var_4_6) / 29)) > 0 and var_4_4 < var_4_8 then
					arg_1_1.talkMaxDuration = var_4_8
					var_4_3 = var_4_3 + 0.3

					if var_4_8 + var_4_3 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_8 + var_4_3
					end
				end

				arg_1_1.text_.text = var_4_6
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_9 = var_4_3 + 0.3
			local var_4_10 = math.max(var_4_4, arg_1_1.talkMaxDuration)

			if var_4_3 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_9) / var_4_10

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112011002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.05

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(112011002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 42 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 42)

				if (42 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 42)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play112011003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112011003
		arg_11_1.duration_ = 5.7

		local var_11_0 = {
			ja = 5.466,
			ko = 5.7,
			zh = 5.666,
			en = 5.266
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112011004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.bgs_.SA0101 == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0101")
				var_14_0.name = "SA0101"
				var_14_0.transform.parent = arg_11_1.stage_.transform
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_.SA0101 = var_14_0
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				local var_14_1 = arg_11_1.bgs_.SA0101

				arg_11_1.bgs_.SA0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_14_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_2 = var_14_1:GetComponent("SpriteRenderer")

				if var_14_2 and var_14_2.sprite then
					local var_14_3 = 2 * (var_14_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_14_1.transform.localScale = Vector3.New(var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "SA0101" then
						iter_14_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_14_4 = "SA0101_blur"

			if arg_11_1.bgs_.SA0101_blur == nil then
				local var_14_5 = Object.Instantiate(arg_11_1.blurPaintGo_)

				var_14_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_14_4)
				var_14_5.name = var_14_4
				var_14_5.transform.parent = arg_11_1.stage_.transform
				var_14_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_[var_14_4] = var_14_5
			end

			local var_14_6 = 0
			local var_14_7 = arg_11_1.bgs_[var_14_4]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				var_14_7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_14_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_8 = var_14_7:GetComponent("SpriteRenderer")

				if var_14_8 and var_14_8.sprite then
					local var_14_9 = 2 * (var_14_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_14_7.transform.localScale = Vector3.New(var_14_9 / var_14_8.sprite.bounds.size.y < var_14_9 * manager.ui.mainCameraCom_.aspect / var_14_8.sprite.bounds.size.x and var_14_9 * manager.ui.mainCameraCom_.aspect / var_14_8.sprite.bounds.size.x or var_14_9 / var_14_8.sprite.bounds.size.y, var_14_9 / var_14_8.sprite.bounds.size.y < var_14_9 * manager.ui.mainCameraCom_.aspect / var_14_8.sprite.bounds.size.x and var_14_9 * manager.ui.mainCameraCom_.aspect / var_14_8.sprite.bounds.size.x or var_14_9 / var_14_8.sprite.bounds.size.y, 0)
				end
			end

			local var_14_10 = 2

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_10 then
				local var_14_11 = Color.New(1, 1, 1)

				var_14_11.a = Mathf.Lerp(1, 1, (arg_11_1.time_ - var_14_6) / var_14_10)

				var_14_7:GetComponent("SpriteRenderer").material:SetColor("_Color", var_14_11)
			end

			local var_14_12 = 0

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_13 = 2

			if var_14_12 <= arg_11_1.time_ and arg_11_1.time_ < var_14_12 + var_14_13 then
				local var_14_14 = Color.New(0, 0, 0)

				var_14_14.a = Mathf.Lerp(1, 0, (arg_11_1.time_ - var_14_12) / var_14_13)
				arg_11_1.mask_.color = var_14_14
			end

			if arg_11_1.time_ >= var_14_12 + var_14_13 and arg_11_1.time_ < var_14_12 + var_14_13 + arg_14_0 then
				local var_14_15 = Color.New(0, 0, 0)

				arg_11_1.mask_.enabled = false
				var_14_15.a = 0
				arg_11_1.mask_.color = var_14_15
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_bubbleloop", "")
			end

			if 3.45833333333333 < arg_11_1.time_ and arg_11_1.time_ <= 3.45833333333333 + arg_14_0 then
				arg_11_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_14_19 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_11_1.bgmTxt_.text ~= var_14_19 and arg_11_1.bgmTxt_.text ~= "" then
						if arg_11_1.bgmTxt2_.text ~= "" then
							arg_11_1.bgmTxt_.text = arg_11_1.bgmTxt2_.text
						end

						arg_11_1.bgmTxt2_.text = var_14_19

						arg_11_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_11_1.bgmTxt_.text = var_14_19
						arg_11_1.bgmTxt2_.text = var_14_19
					end

					if arg_11_1.bgmTimer then
						arg_11_1.bgmTimer:Stop()

						arg_11_1.bgmTimer = nil
					end

					if arg_11_1.settingData.show_music_name == 1 then
						arg_11_1.musicController:SetSelectedState("show")
						arg_11_1.musicAnimator_:Play("open", 0, 0)

						if arg_11_1.settingData.music_time ~= 0 then
							arg_11_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_11_1.settingData.music_time), function()
								if arg_11_1 == nil or isNil(arg_11_1.bgmTxt_) then
									return
								end

								arg_11_1.musicController:SetSelectedState("hide")
								arg_11_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_11_1.frameCnt_ <= 1 then
				arg_11_1.dialog_:SetActive(false)
			end

			local var_14_20 = 3
			local var_14_21 = 0.225

			if 3 < arg_11_1.time_ and arg_11_1.time_ <= var_14_20 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				arg_11_1.dialog_:SetActive(true)

				arg_11_1.dialogCg_.alpha = 0

				local var_14_22 = LeanTween.value(arg_11_1.dialog_, 0, 1, 0.3)

				var_14_22:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_11_1.dialogCg_.alpha = arg_16_0
				end))
				var_14_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_11_1.dialog_)
					var_14_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_11_1.duration_ = arg_11_1.duration_ + 0.3

				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_23 = arg_11_1:GetWordFromCfg(112011003)
				local var_14_24 = arg_11_1:FormatText(var_14_23.content)

				arg_11_1.text_.text = var_14_24

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_26 = 9 <= 0 and var_14_21 or var_14_21 * (utf8.len(var_14_24) / 9)

				if (9 <= 0 and var_14_21 or var_14_21 * (utf8.len(var_14_24) / 9)) > 0 and var_14_21 < var_14_26 then
					arg_11_1.talkMaxDuration = var_14_26
					var_14_20 = var_14_20 + 0.3

					if var_14_26 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_26 + var_14_20
					end
				end

				arg_11_1.text_.text = var_14_24
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011003", "story_v_out_112011.awb") ~= 0 then
					local var_14_27 = manager.audio:GetVoiceLength("story_v_out_112011", "112011003", "story_v_out_112011.awb") / 1000

					if var_14_27 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_27 + var_14_20
					end

					if var_14_23.prefab_name ~= "" and arg_11_1.actors_[var_14_23.prefab_name] ~= nil then
						local var_14_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_23.prefab_name].transform, "story_v_out_112011", "112011003", "story_v_out_112011.awb")

						arg_11_1:RecordAudio("112011003", var_14_28)
						arg_11_1:RecordAudio("112011003", var_14_28)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112011", "112011003", "story_v_out_112011.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112011", "112011003", "story_v_out_112011.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_29 = var_14_20 + 0.3
			local var_14_30 = math.max(var_14_21, arg_11_1.talkMaxDuration)

			if var_14_20 + 0.3 <= arg_11_1.time_ and arg_11_1.time_ < var_14_29 + var_14_30 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_29) / var_14_30

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_29 + var_14_30 and arg_11_1.time_ < var_14_29 + var_14_30 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play112011004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 112011004
		arg_18_1.duration_ = 12.2

		local var_18_0 = {
			ja = 12.2,
			ko = 5.933,
			zh = 6.233,
			en = 9.266
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play112011005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.575

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(112011004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 23 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 23)

				if (23 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 23)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011004", "story_v_out_112011.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011004", "story_v_out_112011.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_112011", "112011004", "story_v_out_112011.awb")

						arg_18_1:RecordAudio("112011004", var_21_6)
						arg_18_1:RecordAudio("112011004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_112011", "112011004", "story_v_out_112011.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_112011", "112011004", "story_v_out_112011.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play112011005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 112011005
		arg_22_1.duration_ = 5.1

		local var_22_0 = {
			ja = 4.6,
			ko = 3.533,
			zh = 3.6,
			en = 5.1
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play112011006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.3

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:GetWordFromCfg(112011005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 12 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 12)

				if (12 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 12)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011005", "story_v_out_112011.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011005", "story_v_out_112011.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_112011", "112011005", "story_v_out_112011.awb")

						arg_22_1:RecordAudio("112011005", var_25_6)
						arg_22_1:RecordAudio("112011005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_112011", "112011005", "story_v_out_112011.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_112011", "112011005", "story_v_out_112011.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play112011006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 112011006
		arg_26_1.duration_ = 4.27

		local var_26_0 = {
			ja = 3.866,
			ko = 3.866,
			zh = 2.4,
			en = 4.266
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
				arg_26_0:Play112011007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.225

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(112011006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 9 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 9)

				if (9 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 9)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011006", "story_v_out_112011.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011006", "story_v_out_112011.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_112011", "112011006", "story_v_out_112011.awb")

						arg_26_1:RecordAudio("112011006", var_29_6)
						arg_26_1:RecordAudio("112011006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_112011", "112011006", "story_v_out_112011.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_112011", "112011006", "story_v_out_112011.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play112011007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 112011007
		arg_30_1.duration_ = 5.27

		local var_30_0 = {
			ja = 5.266,
			ko = 3.633,
			zh = 3.166,
			en = 3.066
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play112011008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.35

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:GetWordFromCfg(112011007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 14 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 14)

				if (14 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 14)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011007", "story_v_out_112011.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011007", "story_v_out_112011.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_112011", "112011007", "story_v_out_112011.awb")

						arg_30_1:RecordAudio("112011007", var_33_6)
						arg_30_1:RecordAudio("112011007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_112011", "112011007", "story_v_out_112011.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_112011", "112011007", "story_v_out_112011.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play112011008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 112011008
		arg_34_1.duration_ = 6.87

		local var_34_0 = {
			ja = 6.833,
			ko = 5.3,
			zh = 4.9,
			en = 6.866
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play112011009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.5

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:GetWordFromCfg(112011008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 20 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 20)

				if (20 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 20)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011008", "story_v_out_112011.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011008", "story_v_out_112011.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_112011", "112011008", "story_v_out_112011.awb")

						arg_34_1:RecordAudio("112011008", var_37_6)
						arg_34_1:RecordAudio("112011008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_112011", "112011008", "story_v_out_112011.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_112011", "112011008", "story_v_out_112011.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play112011009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 112011009
		arg_38_1.duration_ = 10.23

		local var_38_0 = {
			ja = 10.233,
			ko = 6.2,
			zh = 6.6,
			en = 5.9
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play112011010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.525

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(112011009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 21 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 21)

				if (21 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 21)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011009", "story_v_out_112011.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011009", "story_v_out_112011.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_112011", "112011009", "story_v_out_112011.awb")

						arg_38_1:RecordAudio("112011009", var_41_6)
						arg_38_1:RecordAudio("112011009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_112011", "112011009", "story_v_out_112011.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_112011", "112011009", "story_v_out_112011.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play112011010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 112011010
		arg_42_1.duration_ = 5.43

		local var_42_0 = {
			ja = 4.566,
			ko = 5.433,
			zh = 4.066,
			en = 4.8
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
				arg_42_0:Play112011011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.35

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_1 = arg_42_1:GetWordFromCfg(112011010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 14 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 14)

				if (14 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 14)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011010", "story_v_out_112011.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011010", "story_v_out_112011.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_112011", "112011010", "story_v_out_112011.awb")

						arg_42_1:RecordAudio("112011010", var_45_6)
						arg_42_1:RecordAudio("112011010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_112011", "112011010", "story_v_out_112011.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_112011", "112011010", "story_v_out_112011.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play112011011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 112011011
		arg_46_1.duration_ = 3.57

		local var_46_0 = {
			ja = 3.566,
			ko = 1.966,
			zh = 1.666,
			en = 3.1
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play112011012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.075

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:GetWordFromCfg(112011011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 3 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 3)

				if (3 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 3)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011011", "story_v_out_112011.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011011", "story_v_out_112011.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_112011", "112011011", "story_v_out_112011.awb")

						arg_46_1:RecordAudio("112011011", var_49_6)
						arg_46_1:RecordAudio("112011011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_112011", "112011011", "story_v_out_112011.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_112011", "112011011", "story_v_out_112011.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play112011012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 112011012
		arg_50_1.duration_ = 6.07

		local var_50_0 = {
			ja = 6.066,
			ko = 4,
			zh = 5.566,
			en = 4.4
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play112011013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.575

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:GetWordFromCfg(112011012)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 23 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 23)

				if (23 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 23)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011012", "story_v_out_112011.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011012", "story_v_out_112011.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_112011", "112011012", "story_v_out_112011.awb")

						arg_50_1:RecordAudio("112011012", var_53_6)
						arg_50_1:RecordAudio("112011012", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_112011", "112011012", "story_v_out_112011.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_112011", "112011012", "story_v_out_112011.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play112011013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 112011013
		arg_54_1.duration_ = 4.03

		local var_54_0 = {
			ja = 3.466,
			ko = 3.8,
			zh = 4.033,
			en = 3.633
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play112011014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.3

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(112011013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 12 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 12)

				if (12 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 12)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011013", "story_v_out_112011.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011013", "story_v_out_112011.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_112011", "112011013", "story_v_out_112011.awb")

						arg_54_1:RecordAudio("112011013", var_57_6)
						arg_54_1:RecordAudio("112011013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_112011", "112011013", "story_v_out_112011.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_112011", "112011013", "story_v_out_112011.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play112011014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 112011014
		arg_58_1.duration_ = 6.98

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play112011015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				if arg_58_0.sceneSettingEffect_ then
					arg_58_1.sceneSettingEffect_.enabled = false
				end

				arg_58_1.sceneSettingGo_:SetActive(true)

				local var_61_0 = arg_58_1.bgs_.SA0101

				arg_58_1.bgs_.SA0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_1 = var_61_0:GetComponent("SpriteRenderer")

				if var_61_1 and var_61_1.sprite then
					local var_61_2 = 2 * (var_61_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_0.transform.localScale = Vector3.New(var_61_2 / var_61_1.sprite.bounds.size.y < var_61_2 * manager.ui.mainCameraCom_.aspect / var_61_1.sprite.bounds.size.x and var_61_2 * manager.ui.mainCameraCom_.aspect / var_61_1.sprite.bounds.size.x or var_61_2 / var_61_1.sprite.bounds.size.y, var_61_2 / var_61_1.sprite.bounds.size.y < var_61_2 * manager.ui.mainCameraCom_.aspect / var_61_1.sprite.bounds.size.x and var_61_2 * manager.ui.mainCameraCom_.aspect / var_61_1.sprite.bounds.size.x or var_61_2 / var_61_1.sprite.bounds.size.y, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "SA0101" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_3 = "SA0101_blur"

			if arg_58_1.bgs_.SA0101_blur == nil then
				local var_61_4 = Object.Instantiate(arg_58_1.blurPaintGo_)

				var_61_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_3)
				var_61_4.name = var_61_3
				var_61_4.transform.parent = arg_58_1.stage_.transform
				var_61_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_3] = var_61_4
			end

			local var_61_5 = 0
			local var_61_6 = arg_58_1.bgs_[var_61_3]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				var_61_6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_61_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_7 = var_61_6:GetComponent("SpriteRenderer")

				if var_61_7 and var_61_7.sprite then
					local var_61_8 = 2 * (var_61_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_61_6.transform.localScale = Vector3.New(var_61_8 / var_61_7.sprite.bounds.size.y < var_61_8 * manager.ui.mainCameraCom_.aspect / var_61_7.sprite.bounds.size.x and var_61_8 * manager.ui.mainCameraCom_.aspect / var_61_7.sprite.bounds.size.x or var_61_8 / var_61_7.sprite.bounds.size.y, var_61_8 / var_61_7.sprite.bounds.size.y < var_61_8 * manager.ui.mainCameraCom_.aspect / var_61_7.sprite.bounds.size.x and var_61_8 * manager.ui.mainCameraCom_.aspect / var_61_7.sprite.bounds.size.x or var_61_8 / var_61_7.sprite.bounds.size.y, 0)
				end
			end

			local var_61_9 = 2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_9 then
				local var_61_10 = Color.New(1, 1, 1)

				var_61_10.a = Mathf.Lerp(1, 0, (arg_58_1.time_ - var_61_5) / var_61_9)

				var_61_6:GetComponent("SpriteRenderer").material:SetColor("_Color", var_61_10)
			end

			if 0.6 < arg_58_1.time_ and arg_58_1.time_ <= 0.6 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_lowpass_stop", "")
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_12 = 1.975
			local var_61_13 = 1.425

			if 1.975 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_14 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_14:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_15 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(112011014).content)

				arg_58_1.text_.text = var_61_15

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_17 = 57 <= 0 and var_61_13 or var_61_13 * (utf8.len(var_61_15) / 57)

				if (57 <= 0 and var_61_13 or var_61_13 * (utf8.len(var_61_15) / 57)) > 0 and var_61_13 < var_61_17 then
					arg_58_1.talkMaxDuration = var_61_17
					var_61_12 = var_61_12 + 0.3

					if var_61_17 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_17 + var_61_12
					end
				end

				arg_58_1.text_.text = var_61_15
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_18 = var_61_12 + 0.3
			local var_61_19 = math.max(var_61_13, arg_58_1.talkMaxDuration)

			if var_61_12 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_18) / var_61_19

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play112011015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112011015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play112011016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.075

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(112011015).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 3 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 3)

				if (3 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 3)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play112011016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112011016
		arg_68_1.duration_ = 2.03

		local var_68_0 = {
			ja = 2.033,
			ko = 1.4,
			zh = 1.7,
			en = 1.4
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play112011017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.1

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(112011016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 4 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 4)

				if (4 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 4)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011016", "story_v_out_112011.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011016", "story_v_out_112011.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_112011", "112011016", "story_v_out_112011.awb")

						arg_68_1:RecordAudio("112011016", var_71_6)
						arg_68_1:RecordAudio("112011016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112011", "112011016", "story_v_out_112011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112011", "112011016", "story_v_out_112011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play112011017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112011017
		arg_72_1.duration_ = 2.9

		local var_72_0 = {
			ja = 2.9,
			ko = 1.9,
			zh = 2.5,
			en = 2.9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112011018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.15

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(112011017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 6)

				if (6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 6)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011017", "story_v_out_112011.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011017", "story_v_out_112011.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_112011", "112011017", "story_v_out_112011.awb")

						arg_72_1:RecordAudio("112011017", var_75_6)
						arg_72_1:RecordAudio("112011017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112011", "112011017", "story_v_out_112011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112011", "112011017", "story_v_out_112011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play112011018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112011018
		arg_76_1.duration_ = 7

		local var_76_0 = {
			ja = 6.566,
			ko = 6,
			zh = 7,
			en = 5.633
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112011019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.7

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(112011018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 28 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 28)

				if (28 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 28)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011018", "story_v_out_112011.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011018", "story_v_out_112011.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_112011", "112011018", "story_v_out_112011.awb")

						arg_76_1:RecordAudio("112011018", var_79_6)
						arg_76_1:RecordAudio("112011018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_112011", "112011018", "story_v_out_112011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_112011", "112011018", "story_v_out_112011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play112011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112011019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.25

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(112011019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 10 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 10)

				if (10 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 10)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112011020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112011020
		arg_84_1.duration_ = 10.37

		local var_84_0 = {
			ja = 10.366,
			ko = 7.3,
			zh = 7.266,
			en = 8.9
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play112011021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.775

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(112011020)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)

				if (31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011020", "story_v_out_112011.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011020", "story_v_out_112011.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_112011", "112011020", "story_v_out_112011.awb")

						arg_84_1:RecordAudio("112011020", var_87_6)
						arg_84_1:RecordAudio("112011020", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112011", "112011020", "story_v_out_112011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112011", "112011020", "story_v_out_112011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112011021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(112011021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 44 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 44)

				if (44 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 44)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play112011022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112011022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112011023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.175

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(112011022).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 7 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 7)

				if (7 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 7)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112011023
		arg_96_1.duration_ = 7.9

		local var_96_0 = {
			ja = 7.9,
			ko = 3.966,
			zh = 4.4,
			en = 5.966
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.525

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(112011023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 21 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 21)

				if (21 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 21)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011023", "story_v_out_112011.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011023", "story_v_out_112011.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_112011", "112011023", "story_v_out_112011.awb")

						arg_96_1:RecordAudio("112011023", var_99_6)
						arg_96_1:RecordAudio("112011023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_112011", "112011023", "story_v_out_112011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_112011", "112011023", "story_v_out_112011.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112011024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112011024
		arg_100_1.duration_ = 7

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112011025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.bgs_.H02 == nil then
				local var_103_0 = Object.Instantiate(arg_100_1.paintGo_)

				var_103_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_103_0.name = "H02"
				var_103_0.transform.parent = arg_100_1.stage_.transform
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.bgs_.H02 = var_103_0
			end

			if 1.5 < arg_100_1.time_ and arg_100_1.time_ <= 1.5 + arg_103_0 then
				local var_103_1 = arg_100_1.bgs_.H02

				arg_100_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_103_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_2 = var_103_1:GetComponent("SpriteRenderer")

				if var_103_2 and var_103_2.sprite then
					local var_103_3 = 2 * (var_103_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_103_1.transform.localScale = Vector3.New(var_103_3 / var_103_2.sprite.bounds.size.y < var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x and var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x or var_103_3 / var_103_2.sprite.bounds.size.y, var_103_3 / var_103_2.sprite.bounds.size.y < var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x and var_103_3 * manager.ui.mainCameraCom_.aspect / var_103_2.sprite.bounds.size.x or var_103_3 / var_103_2.sprite.bounds.size.y, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "H02" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				local var_103_4 = arg_100_1.bgs_.SA0101:GetComponent("SpriteRenderer")

				if var_103_4 then
					arg_100_1.var_.alphaOldValueSA0101 = var_103_4.color.a
					arg_100_1.var_.alphaMatValueSA0101 = var_103_4
				end

				arg_100_1.var_.alphaOldValueSA0101 = 1
			end

			local var_103_5 = 1.5

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				if arg_100_1.var_.alphaMatValueSA0101 then
					arg_100_1.var_.alphaMatValueSA0101.color.a = Mathf.Lerp(arg_100_1.var_.alphaOldValueSA0101, 0, (arg_100_1.time_ - 0) / var_103_5)
					arg_100_1.var_.alphaMatValueSA0101.color = arg_100_1.var_.alphaMatValueSA0101.color
				end
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 and arg_100_1.var_.alphaMatValueSA0101 then
				arg_100_1.var_.alphaMatValueSA0101.color.a = 0
				arg_100_1.var_.alphaMatValueSA0101.color = arg_100_1.var_.alphaMatValueSA0101.color
			end

			if 1.5 < arg_100_1.time_ and arg_100_1.time_ <= 1.5 + arg_103_0 then
				local var_103_6 = arg_100_1.bgs_.H02:GetComponent("SpriteRenderer")

				if var_103_6 then
					arg_100_1.var_.alphaOldValueH02 = var_103_6.color.a
					arg_100_1.var_.alphaMatValueH02 = var_103_6
				end

				arg_100_1.var_.alphaOldValueH02 = 0
			end

			local var_103_7 = 1.5

			if 1.5 <= arg_100_1.time_ and arg_100_1.time_ < 1.5 + var_103_7 then
				if arg_100_1.var_.alphaMatValueH02 then
					arg_100_1.var_.alphaMatValueH02.color.a = Mathf.Lerp(arg_100_1.var_.alphaOldValueH02, 1, (arg_100_1.time_ - 1.5) / var_103_7)
					arg_100_1.var_.alphaMatValueH02.color = arg_100_1.var_.alphaMatValueH02.color
				end
			end

			if arg_100_1.time_ >= 1.5 + var_103_7 and arg_100_1.time_ < 1.5 + var_103_7 + arg_103_0 and arg_100_1.var_.alphaMatValueH02 then
				arg_100_1.var_.alphaMatValueH02.color.a = 1
				arg_100_1.var_.alphaMatValueH02.color = arg_100_1.var_.alphaMatValueH02.color
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_8 = 2
			local var_103_9 = 1

			if 2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_10 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_10:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_11 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(112011024).content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 40 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 40)

				if (40 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 40)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13
					var_103_8 = var_103_8 + 0.3

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = var_103_8 + 0.3
			local var_103_15 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 + 0.3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_14 + var_103_15 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_14) / var_103_15

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_14 + var_103_15 and arg_100_1.time_ < var_103_14 + var_103_15 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play112011025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 112011025
		arg_106_1.duration_ = 12.6

		local var_106_0 = {
			ja = 10,
			ko = 9.133,
			zh = 7.133,
			en = 12.6
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play112011026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if arg_106_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_109_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_106_1.stage_.transform)

				var_109_0.name = "1081ui_story"
				var_109_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1081ui_story"] = var_109_0

				local var_109_1 = var_109_0:GetComponentInChildren(typeof(CharacterEffect))

				var_109_1.enabled = true

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end

				arg_106_1:ShowWeapon(var_109_1.transform, false)

				arg_106_1.var_["1081ui_story" .. "Animator"] = var_109_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_106_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_106_1.var_["1081ui_story" .. "LipSync"] = var_109_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_109_3 = arg_106_1.actors_["1081ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1081ui_story = var_109_3.localPosition
			end

			local var_109_4 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				var_109_3.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_106_1.time_ - 0) / var_109_4)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				var_109_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_109_5 = arg_106_1.actors_["1081ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1081ui_story == nil then
				arg_106_1.var_.characterEffect1081ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 and not isNil(var_109_5) then
				if arg_106_1.var_.characterEffect1081ui_story and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1081ui_story then
				arg_106_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_109_8 = 0
			local var_109_9 = 0.8

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(112011025)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 32 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 32)

				if (32 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 32)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011025", "story_v_out_112011.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_112011", "112011025", "story_v_out_112011.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_out_112011", "112011025", "story_v_out_112011.awb")

						arg_106_1:RecordAudio("112011025", var_109_15)
						arg_106_1:RecordAudio("112011025", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_112011", "112011025", "story_v_out_112011.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_112011", "112011025", "story_v_out_112011.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play112011026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 112011026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play112011027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1081ui_story"]) and arg_110_1.var_.characterEffect1081ui_story == nil then
				arg_110_1.var_.characterEffect1081ui_story = arg_110_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1081ui_story"]) then
				if arg_110_1.var_.characterEffect1081ui_story and not isNil(arg_110_1.actors_["1081ui_story"]) then
					arg_110_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1081ui_story"]) and arg_110_1.var_.characterEffect1081ui_story then
				arg_110_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.15

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(112011026).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 6 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 6)

				if (6 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 6)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play112011027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 112011027
		arg_114_1.duration_ = 4.6

		local var_114_0 = {
			ja = 4.6,
			ko = 3,
			zh = 4.3,
			en = 4.033
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play112011028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_117_0 = arg_114_1.actors_["1081ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1081ui_story == nil then
				arg_114_1.var_.characterEffect1081ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_1 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 and not isNil(var_117_0) then
				if arg_114_1.var_.characterEffect1081ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1081ui_story then
				arg_114_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_117_3 = 0
			local var_117_4 = 0.45

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_3 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_5 = arg_114_1:GetWordFromCfg(112011027)
				local var_117_6 = arg_114_1:FormatText(var_117_5.content)

				arg_114_1.text_.text = var_117_6

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_8 = 18 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_6) / 18)

				if (18 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_6) / 18)) > 0 and var_117_4 < var_117_8 then
					arg_114_1.talkMaxDuration = var_117_8

					if var_117_8 + var_117_3 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_3
					end
				end

				arg_114_1.text_.text = var_117_6
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011027", "story_v_out_112011.awb") ~= 0 then
					local var_117_9 = manager.audio:GetVoiceLength("story_v_out_112011", "112011027", "story_v_out_112011.awb") / 1000

					if var_117_9 + var_117_3 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_3
					end

					if var_117_5.prefab_name ~= "" and arg_114_1.actors_[var_117_5.prefab_name] ~= nil then
						local var_117_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_5.prefab_name].transform, "story_v_out_112011", "112011027", "story_v_out_112011.awb")

						arg_114_1:RecordAudio("112011027", var_117_10)
						arg_114_1:RecordAudio("112011027", var_117_10)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_112011", "112011027", "story_v_out_112011.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_112011", "112011027", "story_v_out_112011.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_11 = math.max(var_117_4, arg_114_1.talkMaxDuration)

			if var_117_3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_3 + var_117_11 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_3) / var_117_11

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_3 + var_117_11 and arg_114_1.time_ < var_117_3 + var_117_11 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play112011028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 112011028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play112011029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1081ui_story"]) and arg_118_1.var_.characterEffect1081ui_story == nil then
				arg_118_1.var_.characterEffect1081ui_story = arg_118_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1081ui_story"]) then
				if arg_118_1.var_.characterEffect1081ui_story and not isNil(arg_118_1.actors_["1081ui_story"]) then
					arg_118_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1081ui_story"]) and arg_118_1.var_.characterEffect1081ui_story then
				arg_118_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.675

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(112011028).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 27 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 27)

				if (27 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 27)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play112011029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 112011029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play112011030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1081ui_story = arg_122_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).z)
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles = arg_122_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1081ui_story"].transform.position).z)
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1081ui_story"].transform.localEulerAngles = arg_122_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_125_1 = 0
			local var_125_2 = 0.95

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(112011029).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 38)

				if (38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 38)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play112011030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 112011030
		arg_126_1.duration_ = 9.2

		local var_126_0 = {
			ja = 9.2,
			ko = 4.466,
			zh = 5.8,
			en = 8.133
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play112011031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1081ui_story = arg_126_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).z)
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles = arg_126_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_126_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1081ui_story"].transform.position).z)
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1081ui_story"].transform.localEulerAngles = arg_126_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_129_1 = arg_126_1.actors_["1081ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1081ui_story == nil then
				arg_126_1.var_.characterEffect1081ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect1081ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1081ui_story then
				arg_126_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_129_4 = 0
			local var_129_5 = 0.275

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_6 = arg_126_1:GetWordFromCfg(112011030)
				local var_129_7 = arg_126_1:FormatText(var_129_6.content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 11 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 11)

				if (11 <= 0 and var_129_5 or var_129_5 * (utf8.len(var_129_7) / 11)) > 0 and var_129_5 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_4
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011030", "story_v_out_112011.awb") ~= 0 then
					local var_129_10 = manager.audio:GetVoiceLength("story_v_out_112011", "112011030", "story_v_out_112011.awb") / 1000

					if var_129_10 + var_129_4 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_4
					end

					if var_129_6.prefab_name ~= "" and arg_126_1.actors_[var_129_6.prefab_name] ~= nil then
						local var_129_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_6.prefab_name].transform, "story_v_out_112011", "112011030", "story_v_out_112011.awb")

						arg_126_1:RecordAudio("112011030", var_129_11)
						arg_126_1:RecordAudio("112011030", var_129_11)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_112011", "112011030", "story_v_out_112011.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_112011", "112011030", "story_v_out_112011.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_12 = math.max(var_129_5, arg_126_1.talkMaxDuration)

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_4) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_4 + var_129_12 and arg_126_1.time_ < var_129_4 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play112011031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 112011031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play112011032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1081ui_story"]) and arg_130_1.var_.characterEffect1081ui_story == nil then
				arg_130_1.var_.characterEffect1081ui_story = arg_130_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1081ui_story"]) then
				if arg_130_1.var_.characterEffect1081ui_story and not isNil(arg_130_1.actors_["1081ui_story"]) then
					arg_130_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1081ui_story"]) and arg_130_1.var_.characterEffect1081ui_story then
				arg_130_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 0.275

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(112011031).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 11 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 11)

				if (11 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 11)) > 0 and var_133_2 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_6 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_6 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_6

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_6 and arg_130_1.time_ < var_133_1 + var_133_6 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play112011032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 112011032
		arg_134_1.duration_ = 8.63

		local var_134_0 = {
			ja = 6.8,
			ko = 4.533,
			zh = 3.5,
			en = 8.633
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play112011033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.45

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:GetWordFromCfg(112011032)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 18 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 18)

				if (18 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 18)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011032", "story_v_out_112011.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_112011", "112011032", "story_v_out_112011.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_112011", "112011032", "story_v_out_112011.awb")

						arg_134_1:RecordAudio("112011032", var_137_6)
						arg_134_1:RecordAudio("112011032", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_112011", "112011032", "story_v_out_112011.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_112011", "112011032", "story_v_out_112011.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play112011033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 112011033
		arg_138_1.duration_ = 12.97

		local var_138_0 = {
			ja = 12.966,
			ko = 8.466,
			zh = 6.633,
			en = 12.533
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play112011034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_141_0 = arg_138_1.actors_["1081ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1081ui_story == nil then
				arg_138_1.var_.characterEffect1081ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_1 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 and not isNil(var_141_0) then
				if arg_138_1.var_.characterEffect1081ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1081ui_story then
				arg_138_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_141_3 = 0
			local var_141_4 = 1

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_5 = arg_138_1:GetWordFromCfg(112011033)
				local var_141_6 = arg_138_1:FormatText(var_141_5.content)

				arg_138_1.text_.text = var_141_6

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_8 = 34 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 34)

				if (34 <= 0 and var_141_4 or var_141_4 * (utf8.len(var_141_6) / 34)) > 0 and var_141_4 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_3
					end
				end

				arg_138_1.text_.text = var_141_6
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011033", "story_v_out_112011.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_112011", "112011033", "story_v_out_112011.awb") / 1000

					if var_141_9 + var_141_3 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_3
					end

					if var_141_5.prefab_name ~= "" and arg_138_1.actors_[var_141_5.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_5.prefab_name].transform, "story_v_out_112011", "112011033", "story_v_out_112011.awb")

						arg_138_1:RecordAudio("112011033", var_141_10)
						arg_138_1:RecordAudio("112011033", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_112011", "112011033", "story_v_out_112011.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_112011", "112011033", "story_v_out_112011.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_4, arg_138_1.talkMaxDuration)

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_3) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_3 + var_141_11 and arg_138_1.time_ < var_141_3 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play112011034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 112011034
		arg_142_1.duration_ = 11.37

		local var_142_0 = {
			ja = 11.366,
			ko = 10.266,
			zh = 9.933,
			en = 9.933
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play112011035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_145_0 = 0
			local var_145_1 = 1.225

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(112011034)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 49 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 49)

				if (49 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 49)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011034", "story_v_out_112011.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_112011", "112011034", "story_v_out_112011.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_112011", "112011034", "story_v_out_112011.awb")

						arg_142_1:RecordAudio("112011034", var_145_7)
						arg_142_1:RecordAudio("112011034", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_112011", "112011034", "story_v_out_112011.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_112011", "112011034", "story_v_out_112011.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play112011035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 112011035
		arg_146_1.duration_ = 6.4

		local var_146_0 = {
			ja = 6.4,
			ko = 3.633,
			zh = 4.266,
			en = 5.8
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play112011036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_149_0 = 0
			local var_149_1 = 0.375

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(112011035)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 15 <= 0 and var_149_1 or var_149_1 * (utf8.len(var_149_3) / 15)

				if (15 <= 0 and var_149_1 or var_149_1 * (utf8.len(var_149_3) / 15)) > 0 and var_149_1 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011035", "story_v_out_112011.awb") ~= 0 then
					local var_149_6 = manager.audio:GetVoiceLength("story_v_out_112011", "112011035", "story_v_out_112011.awb") / 1000

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end

					if var_149_2.prefab_name ~= "" and arg_146_1.actors_[var_149_2.prefab_name] ~= nil then
						local var_149_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_2.prefab_name].transform, "story_v_out_112011", "112011035", "story_v_out_112011.awb")

						arg_146_1:RecordAudio("112011035", var_149_7)
						arg_146_1:RecordAudio("112011035", var_149_7)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_112011", "112011035", "story_v_out_112011.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_112011", "112011035", "story_v_out_112011.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_8 and arg_146_1.time_ < var_149_0 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play112011036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 112011036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play112011037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1081ui_story = arg_150_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).z)
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles = arg_150_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1081ui_story"].transform.position).z)
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1081ui_story"].transform.localEulerAngles = arg_150_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_153_1 = 0
			local var_153_2 = 0.25

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(112011036).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 10 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 10)

				if (10 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 10)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play112011037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 112011037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play112011038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(112011037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 44 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 44)

				if (44 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 44)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play112011038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 112011038
		arg_158_1.duration_ = 3.2

		local var_158_0 = {
			ja = 3.2,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play112011039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if arg_158_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_161_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_158_1.stage_.transform)

				var_161_0.name = "1084ui_story"
				var_161_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["1084ui_story"] = var_161_0

				local var_161_1 = var_161_0:GetComponentInChildren(typeof(CharacterEffect))

				var_161_1.enabled = true

				local var_161_2 = GameObjectTools.GetOrAddComponent(var_161_0, typeof(DynamicBoneHelper))

				if var_161_2 then
					var_161_2:EnableDynamicBone(false)
				end

				arg_158_1:ShowWeapon(var_161_1.transform, false)

				arg_158_1.var_["1084ui_story" .. "Animator"] = var_161_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_158_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_158_1.var_["1084ui_story" .. "LipSync"] = var_161_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_161_3 = arg_158_1.actors_["1084ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1084ui_story = var_161_3.localPosition

				arg_158_1:ShowWeapon(arg_158_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_161_4 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				var_161_3.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_158_1.time_ - 0) / var_161_4)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_3.localPosition = Vector3.New(0, -0.97, -6)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_161_5 = arg_158_1.actors_["1084ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_6 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_6 and not isNil(var_161_5) then
				if arg_158_1.var_.characterEffect1084ui_story and not isNil(var_161_5) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_6 and arg_158_1.time_ < 0 + var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_161_8 = 0
			local var_161_9 = 0.125

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:GetWordFromCfg(112011038)
				local var_161_11 = arg_158_1:FormatText(var_161_10.content)

				arg_158_1.text_.text = var_161_11

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 5 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 5)

				if (5 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 5)) > 0 and var_161_9 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_11
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112011", "112011038", "story_v_out_112011.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_112011", "112011038", "story_v_out_112011.awb") / 1000

					if var_161_14 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_8
					end

					if var_161_10.prefab_name ~= "" and arg_158_1.actors_[var_161_10.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_10.prefab_name].transform, "story_v_out_112011", "112011038", "story_v_out_112011.awb")

						arg_158_1:RecordAudio("112011038", var_161_15)
						arg_158_1:RecordAudio("112011038", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_112011", "112011038", "story_v_out_112011.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_112011", "112011038", "story_v_out_112011.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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

		arg_158_1:InitPlayNodeList()
	end,
	Play112011039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 112011039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
			arg_162_1.auto_ = false
		end

		function arg_162_1.playNext_(arg_164_0)
			arg_162_1.onStoryFinished_()
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) and arg_162_1.var_.characterEffect1084ui_story == nil then
				arg_162_1.var_.characterEffect1084ui_story = arg_162_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) then
				if arg_162_1.var_.characterEffect1084ui_story and not isNil(arg_162_1.actors_["1084ui_story"]) then
					arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1084ui_story"]) and arg_162_1.var_.characterEffect1084ui_story then
				arg_162_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 1

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(112011039).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 30 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 30)

				if (30 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 30)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SA0101",
		"TextureConfig/Background/H02"
	},
	voices = {
		"story_v_out_112011.awb"
	}
}
