return {
	Play1102004001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102004001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102004002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0503 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0503")
				var_4_0.name = "ST0503"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0503 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0503

				arg_1_1.bgs_.ST0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0503" then
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

			local var_4_9 = arg_1_1.actors_.ui_story

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_10 and arg_1_1.time_ < 2 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			if 0.125 < arg_1_1.time_ and arg_1_1.time_ <= 0.125 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_street", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1102004001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 19 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 19)

				if (19 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 19)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1102004002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102004002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102004003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.433333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.433333333333333 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door04", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1.15

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1102004002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 46 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 46)

				if (46 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 46)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1102004003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102004003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102004004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.9

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1102004003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)

				if (36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 36)) > 0 and var_16_0 < var_16_3 then
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
	Play1102004004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102004004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102004005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.875

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1102004004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)

				if (35 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 35)) > 0 and var_20_0 < var_20_3 then
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
	Play1102004005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102004005
		arg_21_1.duration_ = 3.77

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102004006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1020ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1020ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1020ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1020ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1020ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1020ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1020ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1020ui_story == nil then
				arg_21_1.var_.characterEffect1020ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1020ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1020ui_story then
				arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_8 = 0
			local var_24_9 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(1102004005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 12 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 12)

				if (12 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 12)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004005", "story_v_side_new_1102004.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004005", "story_v_side_new_1102004.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_side_new_1102004", "1102004005", "story_v_side_new_1102004.awb")

						arg_21_1:RecordAudio("1102004005", var_24_15)
						arg_21_1:RecordAudio("1102004005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004005", "story_v_side_new_1102004.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004005", "story_v_side_new_1102004.awb")
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
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102004006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102004006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102004007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1020ui_story"]) and arg_25_1.var_.characterEffect1020ui_story == nil then
				arg_25_1.var_.characterEffect1020ui_story = arg_25_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1020ui_story"]) then
				if arg_25_1.var_.characterEffect1020ui_story and not isNil(arg_25_1.actors_["1020ui_story"]) then
					arg_25_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1020ui_story"]) and arg_25_1.var_.characterEffect1020ui_story then
				arg_25_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.05

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1102004006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 42 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 42)

				if (42 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 42)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102004007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102004007
		arg_29_1.duration_ = 2.9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1102004008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story == nil then
				arg_29_1.var_.characterEffect1020ui_story = arg_29_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) then
				if arg_29_1.var_.characterEffect1020ui_story and not isNil(arg_29_1.actors_["1020ui_story"]) then
					arg_29_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story then
				arg_29_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_32_2 = 0
			local var_32_3 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1102004007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 10 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 10)

				if (10 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 10)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004007", "story_v_side_new_1102004.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004007", "story_v_side_new_1102004.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1102004", "1102004007", "story_v_side_new_1102004.awb")

						arg_29_1:RecordAudio("1102004007", var_32_9)
						arg_29_1:RecordAudio("1102004007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004007", "story_v_side_new_1102004.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004007", "story_v_side_new_1102004.awb")
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
	Play1102004008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102004008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102004009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story == nil then
				arg_33_1.var_.characterEffect1020ui_story = arg_33_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) then
				if arg_33_1.var_.characterEffect1020ui_story and not isNil(arg_33_1.actors_["1020ui_story"]) then
					arg_33_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story then
				arg_33_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.4 < arg_33_1.time_ and arg_33_1.time_ <= 0.4 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_footstep_walk", "")
			end

			local var_36_2 = 0
			local var_36_3 = 1.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1102004008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 51 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 51)

				if (51 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 51)) > 0 and var_36_3 < var_36_6 then
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
	Play1102004009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102004009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102004010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story == nil then
				arg_37_1.var_.characterEffect1020ui_story = arg_37_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) then
				if arg_37_1.var_.characterEffect1020ui_story and not isNil(arg_37_1.actors_["1020ui_story"]) then
					arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story then
				arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_2 = 0
			local var_40_3 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(1102004009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 7 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 7)

				if (7 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 7)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004009", "story_v_side_new_1102004.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004009", "story_v_side_new_1102004.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_new_1102004", "1102004009", "story_v_side_new_1102004.awb")

						arg_37_1:RecordAudio("1102004009", var_40_9)
						arg_37_1:RecordAudio("1102004009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004009", "story_v_side_new_1102004.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004009", "story_v_side_new_1102004.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1102004010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102004010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102004011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story == nil then
				arg_41_1.var_.characterEffect1020ui_story = arg_41_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) then
				if arg_41_1.var_.characterEffect1020ui_story and not isNil(arg_41_1.actors_["1020ui_story"]) then
					arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story then
				arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.725

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1102004010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 29 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 29)

				if (29 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 29)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102004011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102004011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102004012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.55

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

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1102004011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 62 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 62)

				if (62 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 62)) > 0 and var_48_0 < var_48_3 then
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
	Play1102004012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102004012
		arg_49_1.duration_ = 3.97

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1102004013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) and arg_49_1.var_.characterEffect1020ui_story == nil then
				arg_49_1.var_.characterEffect1020ui_story = arg_49_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) then
				if arg_49_1.var_.characterEffect1020ui_story and not isNil(arg_49_1.actors_["1020ui_story"]) then
					arg_49_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) and arg_49_1.var_.characterEffect1020ui_story then
				arg_49_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_52_2 = 0
			local var_52_3 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(1102004012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 18 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 18)

				if (18 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 18)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004012", "story_v_side_new_1102004.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004012", "story_v_side_new_1102004.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_new_1102004", "1102004012", "story_v_side_new_1102004.awb")

						arg_49_1:RecordAudio("1102004012", var_52_9)
						arg_49_1:RecordAudio("1102004012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004012", "story_v_side_new_1102004.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004012", "story_v_side_new_1102004.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1102004013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102004013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1102004014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) and arg_53_1.var_.characterEffect1020ui_story == nil then
				arg_53_1.var_.characterEffect1020ui_story = arg_53_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) then
				if arg_53_1.var_.characterEffect1020ui_story and not isNil(arg_53_1.actors_["1020ui_story"]) then
					arg_53_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) and arg_53_1.var_.characterEffect1020ui_story then
				arg_53_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
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

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1102004013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 9 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 9)

				if (9 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 9)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1102004014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1102004014
		arg_57_1.duration_ = 2.9

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1102004015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) and arg_57_1.var_.characterEffect1020ui_story == nil then
				arg_57_1.var_.characterEffect1020ui_story = arg_57_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) then
				if arg_57_1.var_.characterEffect1020ui_story and not isNil(arg_57_1.actors_["1020ui_story"]) then
					arg_57_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) and arg_57_1.var_.characterEffect1020ui_story then
				arg_57_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_2 = 0
			local var_60_3 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1102004014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 14 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 14)

				if (14 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 14)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004014", "story_v_side_new_1102004.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004014", "story_v_side_new_1102004.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1102004", "1102004014", "story_v_side_new_1102004.awb")

						arg_57_1:RecordAudio("1102004014", var_60_9)
						arg_57_1:RecordAudio("1102004014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004014", "story_v_side_new_1102004.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004014", "story_v_side_new_1102004.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1102004015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1102004015
		arg_61_1.duration_ = 2.9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1102004016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_0 = 0
			local var_64_1 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(1102004015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 13 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 13)

				if (13 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 13)) > 0 and var_64_1 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004015", "story_v_side_new_1102004.awb") ~= 0 then
					local var_64_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004015", "story_v_side_new_1102004.awb") / 1000

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end

					if var_64_2.prefab_name ~= "" and arg_61_1.actors_[var_64_2.prefab_name] ~= nil then
						local var_64_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_2.prefab_name].transform, "story_v_side_new_1102004", "1102004015", "story_v_side_new_1102004.awb")

						arg_61_1:RecordAudio("1102004015", var_64_7)
						arg_61_1:RecordAudio("1102004015", var_64_7)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004015", "story_v_side_new_1102004.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004015", "story_v_side_new_1102004.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1102004016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1102004016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1102004017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1020ui_story"]) and arg_65_1.var_.characterEffect1020ui_story == nil then
				arg_65_1.var_.characterEffect1020ui_story = arg_65_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1020ui_story"]) then
				if arg_65_1.var_.characterEffect1020ui_story and not isNil(arg_65_1.actors_["1020ui_story"]) then
					arg_65_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1020ui_story"]) and arg_65_1.var_.characterEffect1020ui_story then
				arg_65_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.075

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
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

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1102004016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 3 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 3)

				if (3 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 3)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1102004017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1102004017
		arg_69_1.duration_ = 10.17

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1102004018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story == nil then
				arg_69_1.var_.characterEffect1020ui_story = arg_69_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) then
				if arg_69_1.var_.characterEffect1020ui_story and not isNil(arg_69_1.actors_["1020ui_story"]) then
					arg_69_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story then
				arg_69_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_72_2 = 0
			local var_72_3 = 1.05

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(1102004017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 42 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 42)

				if (42 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 42)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004017", "story_v_side_new_1102004.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004017", "story_v_side_new_1102004.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_side_new_1102004", "1102004017", "story_v_side_new_1102004.awb")

						arg_69_1:RecordAudio("1102004017", var_72_9)
						arg_69_1:RecordAudio("1102004017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004017", "story_v_side_new_1102004.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004017", "story_v_side_new_1102004.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1102004018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1102004018
		arg_73_1.duration_ = 5.37

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1102004019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(1102004018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)

				if (23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004018", "story_v_side_new_1102004.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004018", "story_v_side_new_1102004.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_side_new_1102004", "1102004018", "story_v_side_new_1102004.awb")

						arg_73_1:RecordAudio("1102004018", var_76_6)
						arg_73_1:RecordAudio("1102004018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004018", "story_v_side_new_1102004.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004018", "story_v_side_new_1102004.awb")
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
	Play1102004019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1102004019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1102004020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) and arg_77_1.var_.characterEffect1020ui_story == nil then
				arg_77_1.var_.characterEffect1020ui_story = arg_77_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) then
				if arg_77_1.var_.characterEffect1020ui_story and not isNil(arg_77_1.actors_["1020ui_story"]) then
					arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) and arg_77_1.var_.characterEffect1020ui_story then
				arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
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

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1102004019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 4 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 4)

				if (4 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 4)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1102004020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1102004020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1102004021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.475

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
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

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1102004020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 19 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 19)

				if (19 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 19)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1102004021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1102004021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1102004022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1020ui_story = arg_85_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).z)
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles = arg_85_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1020ui_story"].transform.position).z)
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1020ui_story"].transform.localEulerAngles = arg_85_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_88_1 = 0
			local var_88_2 = 0.925

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1102004021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 37 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 37)

				if (37 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 37)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play1102004022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1102004022
		arg_89_1.duration_ = 4.9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1102004023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1020ui_story"]) and arg_89_1.var_.characterEffect1020ui_story == nil then
				arg_89_1.var_.characterEffect1020ui_story = arg_89_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1020ui_story"]) then
				if arg_89_1.var_.characterEffect1020ui_story and not isNil(arg_89_1.actors_["1020ui_story"]) then
					arg_89_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1020ui_story"]) and arg_89_1.var_.characterEffect1020ui_story then
				arg_89_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_92_2 = arg_89_1.actors_["1020ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1020ui_story = var_92_2.localPosition
			end

			local var_92_3 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_89_1.time_ - 0) / var_92_3)
				var_92_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_2.position).x, (manager.ui.mainCamera.transform.position - var_92_2.position).y, (manager.ui.mainCamera.transform.position - var_92_2.position).z)
				var_92_2.localEulerAngles.z = 0
				var_92_2.localEulerAngles.x = 0
				var_92_2.localEulerAngles = var_92_2.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -0.85, -6.25)
				var_92_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_2.position).x, (manager.ui.mainCamera.transform.position - var_92_2.position).y, (manager.ui.mainCamera.transform.position - var_92_2.position).z)
				var_92_2.localEulerAngles.z = 0
				var_92_2.localEulerAngles.x = 0
				var_92_2.localEulerAngles = var_92_2.localEulerAngles
			end

			local var_92_4 = 0
			local var_92_5 = 0.525

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(1102004022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 21 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 21)

				if (21 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 21)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004022", "story_v_side_new_1102004.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004022", "story_v_side_new_1102004.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_new_1102004", "1102004022", "story_v_side_new_1102004.awb")

						arg_89_1:RecordAudio("1102004022", var_92_11)
						arg_89_1:RecordAudio("1102004022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004022", "story_v_side_new_1102004.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004022", "story_v_side_new_1102004.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1102004023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1102004023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1102004024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_96_0 = 0
			local var_96_1 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(1102004023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 8 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 8)

				if (8 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 8)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004023", "story_v_side_new_1102004.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004023", "story_v_side_new_1102004.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_side_new_1102004", "1102004023", "story_v_side_new_1102004.awb")

						arg_93_1:RecordAudio("1102004023", var_96_7)
						arg_93_1:RecordAudio("1102004023", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004023", "story_v_side_new_1102004.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004023", "story_v_side_new_1102004.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1102004024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1102004024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1102004025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) and arg_97_1.var_.characterEffect1020ui_story == nil then
				arg_97_1.var_.characterEffect1020ui_story = arg_97_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) then
				if arg_97_1.var_.characterEffect1020ui_story and not isNil(arg_97_1.actors_["1020ui_story"]) then
					arg_97_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) and arg_97_1.var_.characterEffect1020ui_story then
				arg_97_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.875

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1102004024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 35 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 35)

				if (35 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 35)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1102004025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1102004025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1102004026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1102004025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 10 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 10)

				if (10 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 10)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1102004026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1102004026
		arg_105_1.duration_ = 4.23

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1102004027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) and arg_105_1.var_.characterEffect1020ui_story == nil then
				arg_105_1.var_.characterEffect1020ui_story = arg_105_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) then
				if arg_105_1.var_.characterEffect1020ui_story and not isNil(arg_105_1.actors_["1020ui_story"]) then
					arg_105_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) and arg_105_1.var_.characterEffect1020ui_story then
				arg_105_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_108_2 = 0
			local var_108_3 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(1102004026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 19 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 19)

				if (19 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 19)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004026", "story_v_side_new_1102004.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004026", "story_v_side_new_1102004.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_new_1102004", "1102004026", "story_v_side_new_1102004.awb")

						arg_105_1:RecordAudio("1102004026", var_108_9)
						arg_105_1:RecordAudio("1102004026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004026", "story_v_side_new_1102004.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004026", "story_v_side_new_1102004.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1102004027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1102004027
		arg_109_1.duration_ = 1.27

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1102004028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(1102004027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 8 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 8)

				if (8 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 8)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004027", "story_v_side_new_1102004.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004027", "story_v_side_new_1102004.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_side_new_1102004", "1102004027", "story_v_side_new_1102004.awb")

						arg_109_1:RecordAudio("1102004027", var_112_6)
						arg_109_1:RecordAudio("1102004027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004027", "story_v_side_new_1102004.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004027", "story_v_side_new_1102004.awb")
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
	Play1102004028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1102004028
		arg_113_1.duration_ = 7

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1102004029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_116_0 = 0
			local var_116_1 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(1102004028)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 21 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 21)

				if (21 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 21)) > 0 and var_116_1 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004028", "story_v_side_new_1102004.awb") ~= 0 then
					local var_116_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004028", "story_v_side_new_1102004.awb") / 1000

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end

					if var_116_2.prefab_name ~= "" and arg_113_1.actors_[var_116_2.prefab_name] ~= nil then
						local var_116_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_2.prefab_name].transform, "story_v_side_new_1102004", "1102004028", "story_v_side_new_1102004.awb")

						arg_113_1:RecordAudio("1102004028", var_116_7)
						arg_113_1:RecordAudio("1102004028", var_116_7)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004028", "story_v_side_new_1102004.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004028", "story_v_side_new_1102004.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1102004029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1102004029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1102004030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1020ui_story = arg_117_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).z)
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles = arg_117_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1020ui_story"].transform.position).z)
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1020ui_story"].transform.localEulerAngles = arg_117_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1020ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1020ui_story == nil then
				arg_117_1.var_.characterEffect1020ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1020ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1020ui_story then
				arg_117_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_120_3 = 0
			local var_120_4 = 0.05

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_5 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1102004029).content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 2 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 2)

				if (2 <= 0 and var_120_4 or var_120_4 * (utf8.len(var_120_5) / 2)) > 0 and var_120_4 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_3 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_3
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_4, arg_117_1.talkMaxDuration)

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_3) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_3 + var_120_8 and arg_117_1.time_ < var_120_3 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1102004030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1102004030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1102004031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1102004030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 64 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 64)

				if (64 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 64)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1102004031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1102004031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1102004032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1102004031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 50 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 50)

				if (50 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 50)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1102004032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1102004032
		arg_129_1.duration_ = 10.4

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1102004033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1020ui_story = arg_129_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).z)
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles = arg_129_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_129_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1020ui_story"].transform.position).z)
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1020ui_story"].transform.localEulerAngles = arg_129_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1020ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1020ui_story == nil then
				arg_129_1.var_.characterEffect1020ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1020ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1020ui_story then
				arg_129_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_132_4 = 0
			local var_132_5 = 1.025

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1102004032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)

				if (41 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 41)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004032", "story_v_side_new_1102004.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004032", "story_v_side_new_1102004.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1102004", "1102004032", "story_v_side_new_1102004.awb")

						arg_129_1:RecordAudio("1102004032", var_132_11)
						arg_129_1:RecordAudio("1102004032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004032", "story_v_side_new_1102004.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004032", "story_v_side_new_1102004.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1102004033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1102004033
		arg_133_1.duration_ = 9.07

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1102004034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.8

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(1102004033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 32 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 32)

				if (32 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 32)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004033", "story_v_side_new_1102004.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004033", "story_v_side_new_1102004.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_side_new_1102004", "1102004033", "story_v_side_new_1102004.awb")

						arg_133_1:RecordAudio("1102004033", var_136_6)
						arg_133_1:RecordAudio("1102004033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004033", "story_v_side_new_1102004.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004033", "story_v_side_new_1102004.awb")
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
	Play1102004034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1102004034
		arg_137_1.duration_ = 3.67

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1102004035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_140_0 = 0
			local var_140_1 = 0.3

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(1102004034)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 12 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 12)

				if (12 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 12)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004034", "story_v_side_new_1102004.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004034", "story_v_side_new_1102004.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_side_new_1102004", "1102004034", "story_v_side_new_1102004.awb")

						arg_137_1:RecordAudio("1102004034", var_140_7)
						arg_137_1:RecordAudio("1102004034", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004034", "story_v_side_new_1102004.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004034", "story_v_side_new_1102004.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1102004035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1102004035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1102004036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1020ui_story"]) and arg_141_1.var_.characterEffect1020ui_story == nil then
				arg_141_1.var_.characterEffect1020ui_story = arg_141_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1020ui_story"]) then
				if arg_141_1.var_.characterEffect1020ui_story and not isNil(arg_141_1.actors_["1020ui_story"]) then
					arg_141_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1020ui_story"]) and arg_141_1.var_.characterEffect1020ui_story then
				arg_141_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
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

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1102004035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 3 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 3)

				if (3 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 3)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1102004036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1102004036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1102004037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1020ui_story = arg_145_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).z)
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles = arg_145_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1020ui_story"].transform.position).z)
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1020ui_story"].transform.localEulerAngles = arg_145_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_148_1 = 0
			local var_148_2 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1102004036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 20 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 20)

				if (20 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 20)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1102004037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1102004037
		arg_149_1.duration_ = 1

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"

			SetActive(arg_149_1.choicesGo_, true)

			for iter_150_0, iter_150_1 in ipairs(arg_149_1.choices_) do
				SetActive(iter_150_1.go, iter_150_0 <= 2)
			end

			arg_149_1.choices_[1].txt.text = arg_149_1:FormatText(StoryChoiceCfg[1196].name)
			arg_149_1.choices_[2].txt.text = arg_149_1:FormatText(StoryChoiceCfg[1197].name)
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1102004038(arg_149_1)
			end

			if arg_151_0 == 2 then
				arg_149_0:Play1102004038(arg_149_1)
			end

			arg_149_1:RecordChoiceLog(1102004037, 1196, 1197)
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= 0 + 0.6 and arg_149_1.time_ < 0 + 0.6 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1102004038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1102004038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1102004039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.025

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1102004038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 41 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 41)

				if (41 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 41)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1102004039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1102004039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1102004040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
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

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1102004039).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 4 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 4)

				if (4 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 4)) > 0 and var_160_0 < var_160_3 then
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
	Play1102004040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1102004040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1102004041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.725

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

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1102004040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 29 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 29)

				if (29 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 29)) > 0 and var_164_0 < var_164_3 then
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
	Play1102004041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1102004041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1102004042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1102004041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 10 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 10)

				if (10 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 10)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1102004042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1102004042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1102004043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.6

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1102004042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 24 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 24)

				if (24 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 24)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1102004043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1102004043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1102004044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.525

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1102004043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 21 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 21)

				if (21 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 21)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1102004044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1102004044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1102004045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.525

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1102004044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 21 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 21)

				if (21 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 21)) > 0 and var_180_0 < var_180_3 then
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
	Play1102004045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1102004045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1102004046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.575

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1102004045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 23 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 23)

				if (23 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 23)) > 0 and var_184_0 < var_184_3 then
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
	Play1102004046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1102004046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1102004047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1

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

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1102004046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 40)

				if (40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 40)) > 0 and var_188_0 < var_188_3 then
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
	Play1102004047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1102004047
		arg_189_1.duration_ = 2.4

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1102004048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1020ui_story = arg_189_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).z)
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles = arg_189_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_189_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1020ui_story"].transform.position).z)
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1020ui_story"].transform.localEulerAngles = arg_189_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1020ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1020ui_story == nil then
				arg_189_1.var_.characterEffect1020ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1020ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1020ui_story then
				arg_189_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.55

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(1102004047)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 22 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 22)

				if (22 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 22)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004047", "story_v_side_new_1102004.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004047", "story_v_side_new_1102004.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_side_new_1102004", "1102004047", "story_v_side_new_1102004.awb")

						arg_189_1:RecordAudio("1102004047", var_192_11)
						arg_189_1:RecordAudio("1102004047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004047", "story_v_side_new_1102004.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004047", "story_v_side_new_1102004.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play1102004048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1102004048
		arg_193_1.duration_ = 4.6

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1102004049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action486")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_196_0 = 0
			local var_196_1 = 0.575

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(1102004048)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 23 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 23)

				if (23 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_3) / 23)) > 0 and var_196_1 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004048", "story_v_side_new_1102004.awb") ~= 0 then
					local var_196_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004048", "story_v_side_new_1102004.awb") / 1000

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end

					if var_196_2.prefab_name ~= "" and arg_193_1.actors_[var_196_2.prefab_name] ~= nil then
						local var_196_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_2.prefab_name].transform, "story_v_side_new_1102004", "1102004048", "story_v_side_new_1102004.awb")

						arg_193_1:RecordAudio("1102004048", var_196_7)
						arg_193_1:RecordAudio("1102004048", var_196_7)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004048", "story_v_side_new_1102004.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004048", "story_v_side_new_1102004.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1102004049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1102004049
		arg_197_1.duration_ = 2

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1102004050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_0 = 0
			local var_200_1 = 0.175

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(1102004049)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 7 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 7)

				if (7 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 7)) > 0 and var_200_1 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004049", "story_v_side_new_1102004.awb") ~= 0 then
					local var_200_6 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004049", "story_v_side_new_1102004.awb") / 1000

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end

					if var_200_2.prefab_name ~= "" and arg_197_1.actors_[var_200_2.prefab_name] ~= nil then
						local var_200_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_2.prefab_name].transform, "story_v_side_new_1102004", "1102004049", "story_v_side_new_1102004.awb")

						arg_197_1:RecordAudio("1102004049", var_200_7)
						arg_197_1:RecordAudio("1102004049", var_200_7)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004049", "story_v_side_new_1102004.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004049", "story_v_side_new_1102004.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1102004050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1102004050
		arg_201_1.duration_ = 9

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1102004051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.bgs_.L02h == nil then
				local var_204_0 = Object.Instantiate(arg_201_1.paintGo_)

				var_204_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02h")
				var_204_0.name = "L02h"
				var_204_0.transform.parent = arg_201_1.stage_.transform
				var_204_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.bgs_.L02h = var_204_0
			end

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= 2 + arg_204_0 then
				local var_204_1 = arg_201_1.bgs_.L02h

				arg_201_1.bgs_.L02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_204_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_2 = var_204_1:GetComponent("SpriteRenderer")

				if var_204_2 and var_204_2.sprite then
					local var_204_3 = 2 * (var_204_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_204_1.transform.localScale = Vector3.New(var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, var_204_3 / var_204_2.sprite.bounds.size.y < var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x and var_204_3 * manager.ui.mainCameraCom_.aspect / var_204_2.sprite.bounds.size.x or var_204_3 / var_204_2.sprite.bounds.size.y, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "L02h" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_4 = 4

			if 4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			if arg_201_1.time_ >= var_204_4 + 0.3 and arg_201_1.time_ < var_204_4 + 0.3 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_5 = 0

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_6 = 2

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 then
				local var_204_7 = Color.New(0, 0, 0)

				var_204_7.a = Mathf.Lerp(0, 1, (arg_201_1.time_ - var_204_5) / var_204_6)
				arg_201_1.mask_.color = var_204_7
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 then
				local var_204_8 = Color.New(0, 0, 0)

				var_204_8.a = 1
				arg_201_1.mask_.color = var_204_8
			end

			local var_204_9 = 2

			if 2 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 then
				local var_204_11 = Color.New(0, 0, 0)

				var_204_11.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - var_204_9) / var_204_10)
				arg_201_1.mask_.color = var_204_11
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 then
				local var_204_12 = Color.New(0, 0, 0)

				arg_201_1.mask_.enabled = false
				var_204_12.a = 0
				arg_201_1.mask_.color = var_204_12
			end

			local var_204_13 = arg_201_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 then
				arg_201_1.var_.moveOldPos1020ui_story = var_204_13.localPosition
			end

			local var_204_14 = 0.001

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_14 then
				var_204_13.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 1.96599999815226) / var_204_14)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_14 and arg_201_1.time_ < 1.96599999815226 + var_204_14 + arg_204_0 then
				var_204_13.localPosition = Vector3.New(0, 100, 0)
				var_204_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_13.position).x, (manager.ui.mainCamera.transform.position - var_204_13.position).y, (manager.ui.mainCamera.transform.position - var_204_13.position).z)
				var_204_13.localEulerAngles.z = 0
				var_204_13.localEulerAngles.x = 0
				var_204_13.localEulerAngles = var_204_13.localEulerAngles
			end

			local var_204_15 = arg_201_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_201_1.time_ and arg_201_1.time_ <= 1.96599999815226 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect1020ui_story == nil then
				arg_201_1.var_.characterEffect1020ui_story = var_204_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_16 = 0.034000001847744

			if 1.96599999815226 <= arg_201_1.time_ and arg_201_1.time_ < 1.96599999815226 + var_204_16 and not isNil(var_204_15) then
				if arg_201_1.var_.characterEffect1020ui_story and not isNil(var_204_15) then
					arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 1.96599999815226) / var_204_16)
				end
			end

			if arg_201_1.time_ >= 1.96599999815226 + var_204_16 and arg_201_1.time_ < 1.96599999815226 + var_204_16 + arg_204_0 and not isNil(var_204_15) and arg_201_1.var_.characterEffect1020ui_story then
				arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_201_1.time_ and arg_201_1.time_ <= 0.125 + arg_204_0 then
				arg_201_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_street", "")
			end

			if 1.6 < arg_201_1.time_ and arg_201_1.time_ <= 1.6 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_204_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_21 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_21

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_21
						arg_201_1.bgmTxt2_.text = var_204_21
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_201_1.time_ and arg_201_1.time_ <= 0.4 + arg_204_0 then
				arg_201_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_204_24 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_201_1.bgmTxt_.text ~= var_204_24 and arg_201_1.bgmTxt_.text ~= "" then
						if arg_201_1.bgmTxt2_.text ~= "" then
							arg_201_1.bgmTxt_.text = arg_201_1.bgmTxt2_.text
						end

						arg_201_1.bgmTxt2_.text = var_204_24

						arg_201_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_201_1.bgmTxt_.text = var_204_24
						arg_201_1.bgmTxt2_.text = var_204_24
					end

					if arg_201_1.bgmTimer then
						arg_201_1.bgmTimer:Stop()

						arg_201_1.bgmTimer = nil
					end

					if arg_201_1.settingData.show_music_name == 1 then
						arg_201_1.musicController:SetSelectedState("show")
						arg_201_1.musicAnimator_:Play("open", 0, 0)

						if arg_201_1.settingData.music_time ~= 0 then
							arg_201_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_201_1.settingData.music_time), function()
								if arg_201_1 == nil or isNil(arg_201_1.bgmTxt_) then
									return
								end

								arg_201_1.musicController:SetSelectedState("hide")
								arg_201_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_25 = 4
			local var_204_26 = 0.15

			if 4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_25 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_27 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_27:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_201_1.dialogCg_.alpha = arg_207_0
				end))
				var_204_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_28 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1102004050).content)

				arg_201_1.text_.text = var_204_28

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_30 = 6 <= 0 and var_204_26 or var_204_26 * (utf8.len(var_204_28) / 6)

				if (6 <= 0 and var_204_26 or var_204_26 * (utf8.len(var_204_28) / 6)) > 0 and var_204_26 < var_204_30 then
					arg_201_1.talkMaxDuration = var_204_30
					var_204_25 = var_204_25 + 0.3

					if var_204_30 + var_204_25 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_30 + var_204_25
					end
				end

				arg_201_1.text_.text = var_204_28
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_31 = var_204_25 + 0.3
			local var_204_32 = math.max(var_204_26, arg_201_1.talkMaxDuration)

			if var_204_25 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_31 + var_204_32 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_31) / var_204_32

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_31 + var_204_32 and arg_201_1.time_ < var_204_31 + var_204_32 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play1102004051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1102004051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1102004052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.25

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1102004051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 50 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 50)

				if (50 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 50)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1102004052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1102004052
		arg_213_1.duration_ = 2.1

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1102004053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1020ui_story = arg_213_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).z)
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles = arg_213_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_213_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1020ui_story"].transform.position).z)
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1020ui_story"].transform.localEulerAngles = arg_213_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1020ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1020ui_story == nil then
				arg_213_1.var_.characterEffect1020ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1020ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1020ui_story then
				arg_213_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_4 = 0
			local var_216_5 = 0.15

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(1102004052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 6 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 6)

				if (6 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 6)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004052", "story_v_side_new_1102004.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004052", "story_v_side_new_1102004.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_side_new_1102004", "1102004052", "story_v_side_new_1102004.awb")

						arg_213_1:RecordAudio("1102004052", var_216_11)
						arg_213_1:RecordAudio("1102004052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004052", "story_v_side_new_1102004.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004052", "story_v_side_new_1102004.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102004053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1102004053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1102004054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) and arg_217_1.var_.characterEffect1020ui_story == nil then
				arg_217_1.var_.characterEffect1020ui_story = arg_217_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) then
				if arg_217_1.var_.characterEffect1020ui_story and not isNil(arg_217_1.actors_["1020ui_story"]) then
					arg_217_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1020ui_story"]) and arg_217_1.var_.characterEffect1020ui_story then
				arg_217_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_217_1.time_ and arg_217_1.time_ <= 0.125 + arg_220_0 then
				arg_217_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_bag01", "")
			end

			local var_220_2 = 0
			local var_220_3 = 1.05

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1102004053).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 42 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 42)

				if (42 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 42)) > 0 and var_220_3 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_7 and arg_217_1.time_ < var_220_2 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1102004054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1102004054
		arg_221_1.duration_ = 7.03

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1102004055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = arg_221_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) then
				if arg_221_1.var_.characterEffect1020ui_story and not isNil(arg_221_1.actors_["1020ui_story"]) then
					arg_221_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1020ui_story"]) and arg_221_1.var_.characterEffect1020ui_story then
				arg_221_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_224_2 = 0
			local var_224_3 = 0.7

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1102004054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 28 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 28)

				if (28 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 28)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004054", "story_v_side_new_1102004.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004054", "story_v_side_new_1102004.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1102004", "1102004054", "story_v_side_new_1102004.awb")

						arg_221_1:RecordAudio("1102004054", var_224_9)
						arg_221_1:RecordAudio("1102004054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004054", "story_v_side_new_1102004.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004054", "story_v_side_new_1102004.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1102004055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1102004055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1102004056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1020ui_story"]) and arg_225_1.var_.characterEffect1020ui_story == nil then
				arg_225_1.var_.characterEffect1020ui_story = arg_225_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1020ui_story"]) then
				if arg_225_1.var_.characterEffect1020ui_story and not isNil(arg_225_1.actors_["1020ui_story"]) then
					arg_225_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1020ui_story"]) and arg_225_1.var_.characterEffect1020ui_story then
				arg_225_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.825

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1102004055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 33 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 33)

				if (33 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 33)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1102004056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1102004056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1102004057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.85

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(1102004056).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 34 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 34)

				if (34 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 34)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1102004057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1102004057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1102004058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1020ui_story = arg_233_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_236_1 = 0
			local var_236_2 = 0.7

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1102004057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 28 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 28)

				if (28 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 28)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1102004058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1102004058
		arg_237_1.duration_ = 3.5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1102004059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1020ui_story = arg_237_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).z)
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles = arg_237_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_237_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1020ui_story"].transform.position).z)
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1020ui_story"].transform.localEulerAngles = arg_237_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1020ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1020ui_story == nil then
				arg_237_1.var_.characterEffect1020ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1020ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1020ui_story then
				arg_237_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_240_4 = 0
			local var_240_5 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(1102004058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 16 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 16)

				if (16 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 16)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004058", "story_v_side_new_1102004.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004058", "story_v_side_new_1102004.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_new_1102004", "1102004058", "story_v_side_new_1102004.awb")

						arg_237_1:RecordAudio("1102004058", var_240_11)
						arg_237_1:RecordAudio("1102004058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004058", "story_v_side_new_1102004.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004058", "story_v_side_new_1102004.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1102004059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1102004059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1102004060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1020ui_story"]) and arg_241_1.var_.characterEffect1020ui_story == nil then
				arg_241_1.var_.characterEffect1020ui_story = arg_241_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1020ui_story"]) then
				if arg_241_1.var_.characterEffect1020ui_story and not isNil(arg_241_1.actors_["1020ui_story"]) then
					arg_241_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1020ui_story"]) and arg_241_1.var_.characterEffect1020ui_story then
				arg_241_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1102004059).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 32 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 32)

				if (32 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 32)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1102004060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1102004060
		arg_245_1.duration_ = 3.93

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1102004061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1020ui_story"]) and arg_245_1.var_.characterEffect1020ui_story == nil then
				arg_245_1.var_.characterEffect1020ui_story = arg_245_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1020ui_story"]) then
				if arg_245_1.var_.characterEffect1020ui_story and not isNil(arg_245_1.actors_["1020ui_story"]) then
					arg_245_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1020ui_story"]) and arg_245_1.var_.characterEffect1020ui_story then
				arg_245_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_248_2 = 0
			local var_248_3 = 0.15

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(1102004060)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 6 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 6)

				if (6 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 6)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004060", "story_v_side_new_1102004.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004060", "story_v_side_new_1102004.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_side_new_1102004", "1102004060", "story_v_side_new_1102004.awb")

						arg_245_1:RecordAudio("1102004060", var_248_9)
						arg_245_1:RecordAudio("1102004060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004060", "story_v_side_new_1102004.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004060", "story_v_side_new_1102004.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1102004061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1102004061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1102004062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1020ui_story"]) and arg_249_1.var_.characterEffect1020ui_story == nil then
				arg_249_1.var_.characterEffect1020ui_story = arg_249_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1020ui_story"]) then
				if arg_249_1.var_.characterEffect1020ui_story and not isNil(arg_249_1.actors_["1020ui_story"]) then
					arg_249_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1020ui_story"]) and arg_249_1.var_.characterEffect1020ui_story then
				arg_249_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.225

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1102004061).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 9 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 9)

				if (9 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 9)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1102004062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1102004062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1102004063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1102004062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 6 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 6)

				if (6 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 6)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1102004063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1102004063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1102004064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1020ui_story = arg_257_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 0.425

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1102004063).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 17 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 17)

				if (17 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 17)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1102004064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1102004064
		arg_261_1.duration_ = 9

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1102004065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.bgs_.R2001 == nil then
				local var_264_0 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R2001")
				var_264_0.name = "R2001"
				var_264_0.transform.parent = arg_261_1.stage_.transform
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_.R2001 = var_264_0
			end

			if 1.98333333333333 < arg_261_1.time_ and arg_261_1.time_ <= 1.98333333333333 + arg_264_0 then
				local var_264_1 = arg_261_1.bgs_.R2001

				arg_261_1.bgs_.R2001.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_2 = var_264_1:GetComponent("SpriteRenderer")

				if var_264_2 and var_264_2.sprite then
					local var_264_3 = 2 * (var_264_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_1.transform.localScale = Vector3.New(var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "R2001" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_4 = 3.999999999999

			if 3.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_4 + 0.3 and arg_261_1.time_ < var_264_4 + 0.3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_5 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_6 = 2

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_5) / var_264_6)
				arg_261_1.mask_.color = var_264_7
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 then
				local var_264_8 = Color.New(0, 0, 0)

				var_264_8.a = 1
				arg_261_1.mask_.color = var_264_8
			end

			local var_264_9 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_10 = 2.5

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 then
				local var_264_11 = Color.New(0, 0, 0)

				var_264_11.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_9) / var_264_10)
				arg_261_1.mask_.color = var_264_11
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 then
				local var_264_12 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_12.a = 0
				arg_261_1.mask_.color = var_264_12
			end

			local var_264_13 = arg_261_1.bgs_.R2001.transform

			if 1.98333333333333 < arg_261_1.time_ and arg_261_1.time_ <= 1.98333333333333 + arg_264_0 then
				arg_261_1.var_.moveOldPosR2001 = var_264_13.localPosition
			end

			local var_264_14 = 0.001

			if 1.98333333333333 <= arg_261_1.time_ and arg_261_1.time_ < 1.98333333333333 + var_264_14 then
				var_264_13.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosR2001, Vector3.New(-0.74, -1.18, 0), (arg_261_1.time_ - 1.98333333333333) / var_264_14)
			end

			if arg_261_1.time_ >= 1.98333333333333 + var_264_14 and arg_261_1.time_ < 1.98333333333333 + var_264_14 + arg_264_0 then
				var_264_13.localPosition = Vector3.New(-0.74, -1.18, 0)
			end

			local var_264_15 = arg_261_1.bgs_.R2001.transform

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				arg_261_1.var_.moveOldPosR2001 = var_264_15.localPosition
			end

			local var_264_16 = 3.5

			if 2 <= arg_261_1.time_ and arg_261_1.time_ < 2 + var_264_16 then
				var_264_15.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosR2001, Vector3.New(-0.74, -1.22, 0), (arg_261_1.time_ - 2) / var_264_16)
			end

			if arg_261_1.time_ >= 2 + var_264_16 and arg_261_1.time_ < 2 + var_264_16 + arg_264_0 then
				var_264_15.localPosition = Vector3.New(-0.74, -1.22, 0)
			end

			local var_264_17 = 4

			if 4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_17 + 1.6 and arg_261_1.time_ < var_264_17 + 1.6 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			if 0.125 < arg_261_1.time_ and arg_261_1.time_ <= 0.125 + arg_264_0 then
				arg_261_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.56666666666667 < arg_261_1.time_ and arg_261_1.time_ <= 1.56666666666667 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_field", "")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_20 = 3.999999999999
			local var_264_21 = 0.55

			if 3.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_20 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_22 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_22:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_23 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1102004064).content)

				arg_261_1.text_.text = var_264_23

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_25 = 22 <= 0 and var_264_21 or var_264_21 * (utf8.len(var_264_23) / 22)

				if (22 <= 0 and var_264_21 or var_264_21 * (utf8.len(var_264_23) / 22)) > 0 and var_264_21 < var_264_25 then
					arg_261_1.talkMaxDuration = var_264_25
					var_264_20 = var_264_20 + 0.3

					if var_264_25 + var_264_20 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_25 + var_264_20
					end
				end

				arg_261_1.text_.text = var_264_23
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_26 = var_264_20 + 0.3
			local var_264_27 = math.max(var_264_21, arg_261_1.talkMaxDuration)

			if var_264_20 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_26 + var_264_27 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_26) / var_264_27

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_26 + var_264_27 and arg_261_1.time_ < var_264_26 + var_264_27 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R2001",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R2001",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1102004065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102004065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102004066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.9

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1102004065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 36 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 36)

				if (36 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 36)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1102004066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1102004066
		arg_271_1.duration_ = 6.23

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1102004067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1020ui_story"]) and arg_271_1.var_.characterEffect1020ui_story == nil then
				arg_271_1.var_.characterEffect1020ui_story = arg_271_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1020ui_story"]) then
				if arg_271_1.var_.characterEffect1020ui_story and not isNil(arg_271_1.actors_["1020ui_story"]) then
					arg_271_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1020ui_story"]) and arg_271_1.var_.characterEffect1020ui_story then
				arg_271_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_274_2 = 0
			local var_274_3 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(1102004066)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 19 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 19)

				if (19 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 19)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004066", "story_v_side_new_1102004.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004066", "story_v_side_new_1102004.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_side_new_1102004", "1102004066", "story_v_side_new_1102004.awb")

						arg_271_1:RecordAudio("1102004066", var_274_9)
						arg_271_1:RecordAudio("1102004066", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004066", "story_v_side_new_1102004.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004066", "story_v_side_new_1102004.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1102004067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1102004067
		arg_275_1.duration_ = 8.27

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1102004068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.925

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(1102004067)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 37)

				if (37 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 37)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004067", "story_v_side_new_1102004.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004067", "story_v_side_new_1102004.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_side_new_1102004", "1102004067", "story_v_side_new_1102004.awb")

						arg_275_1:RecordAudio("1102004067", var_278_6)
						arg_275_1:RecordAudio("1102004067", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004067", "story_v_side_new_1102004.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004067", "story_v_side_new_1102004.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1102004068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1102004068
		arg_279_1.duration_ = 1

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1102004069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.05

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(1102004068)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 2 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 2)

				if (2 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 2)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004068", "story_v_side_new_1102004.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004068", "story_v_side_new_1102004.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_side_new_1102004", "1102004068", "story_v_side_new_1102004.awb")

						arg_279_1:RecordAudio("1102004068", var_282_6)
						arg_279_1:RecordAudio("1102004068", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004068", "story_v_side_new_1102004.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004068", "story_v_side_new_1102004.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1102004069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1102004069
		arg_283_1.duration_ = 7.5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1102004070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_9001
			local var_286_9000

			if 1.46666666666667 < arg_283_1.time_ and arg_283_1.time_ <= 1.46666666666667 + arg_286_0 then
				local var_286_0 = arg_283_1.bgs_.R2001

				arg_283_1.bgs_.R2001.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_286_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_286_1 = var_286_0:GetComponent("SpriteRenderer")

				if var_286_1 and var_286_1.sprite then
					local var_286_2 = 2 * (var_286_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_286_0.transform.localScale = Vector3.New(var_286_2 / var_286_1.sprite.bounds.size.y < var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x and var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x or var_286_2 / var_286_1.sprite.bounds.size.y, var_286_2 / var_286_1.sprite.bounds.size.y < var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x and var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x or var_286_2 / var_286_1.sprite.bounds.size.y, 0)
				end

				for iter_286_0, iter_286_1 in pairs(arg_283_1.bgs_) do
					if iter_286_0 ~= "R2001" then
						iter_286_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				local var_286_3 = arg_283_1.var_.effectfantianxinlian3

				if not arg_283_1.var_.effectfantianxinlian3 then
					var_286_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_286_3.name = "fantianxinlian3"
					arg_283_1.var_.effectfantianxinlian3 = var_286_3
				else
					var_286_3.transform:SetParent(var_286_9001)
				end

				var_286_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_286_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_286_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_286_2, iter_286_3 in ipairs((var_286_3.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_286_3.transform.localScale = Vector3.New(iter_286_3.transform.localScale.x / var_286_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_286_3.transform.localScale.y / var_286_5, iter_286_3.transform.localScale.z)
				end
			end

			if 1.5 < arg_283_1.time_ and arg_283_1.time_ <= 1.5 + arg_286_0 then
				if arg_283_1.var_.effectfantianxinlian3 then
					Object.Destroy(arg_283_1.var_.effectfantianxinlian3)

					arg_283_1.var_.effectfantianxinlian3 = nil
				end
			end

			if 1.7 < arg_283_1.time_ and arg_283_1.time_ <= 1.7 + arg_286_0 then
				local var_286_8 = arg_283_1.var_.effectfantianxinlian4

				if not arg_283_1.var_.effectfantianxinlian4 then
					var_286_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_286_8.name = "fantianxinlian4"
					arg_283_1.var_.effectfantianxinlian4 = var_286_8
				else
					var_286_8.transform:SetParent(var_286_9000)
				end

				var_286_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_286_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_286_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_286_4, iter_286_5 in ipairs((var_286_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_286_5.transform.localScale = Vector3.New(iter_286_5.transform.localScale.x / var_286_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_286_5.transform.localScale.y / var_286_10, iter_286_5.transform.localScale.z)
				end
			end

			local var_286_12 = arg_283_1.bgs_.R2001.transform

			if 1.46666666666667 < arg_283_1.time_ and arg_283_1.time_ <= 1.46666666666667 + arg_286_0 then
				arg_283_1.var_.moveOldPosR2001 = var_286_12.localPosition
			end

			local var_286_13 = 0.001

			if 1.46666666666667 <= arg_283_1.time_ and arg_283_1.time_ < 1.46666666666667 + var_286_13 then
				var_286_12.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPosR2001, Vector3.New(0, 1, 9.5), (arg_283_1.time_ - 1.46666666666667) / var_286_13)
			end

			if arg_283_1.time_ >= 1.46666666666667 + var_286_13 and arg_283_1.time_ < 1.46666666666667 + var_286_13 + arg_286_0 then
				var_286_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_286_14 = arg_283_1.bgs_.R2001.transform

			if 1.5 < arg_283_1.time_ and arg_283_1.time_ <= 1.5 + arg_286_0 then
				arg_283_1.var_.moveOldPosR2001 = var_286_14.localPosition
			end

			local var_286_15 = 4

			if 1.5 <= arg_283_1.time_ and arg_283_1.time_ < 1.5 + var_286_15 then
				var_286_14.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPosR2001, Vector3.New(0, 1, 10), (arg_283_1.time_ - 1.5) / var_286_15)
			end

			if arg_283_1.time_ >= 1.5 + var_286_15 and arg_283_1.time_ < 1.5 + var_286_15 + arg_286_0 then
				var_286_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_286_16 = 3.2

			if 3.2 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.allBtn_.enabled = false
			end

			if arg_283_1.time_ >= var_286_16 + 2.4 and arg_283_1.time_ < var_286_16 + 2.4 + arg_286_0 then
				arg_283_1.allBtn_.enabled = true
			end

			if arg_283_1.frameCnt_ <= 1 then
				arg_283_1.dialog_:SetActive(false)
			end

			local var_286_17 = 2.5
			local var_286_18 = 0.825

			if 2.5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_17 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0

				arg_283_1.dialog_:SetActive(true)

				arg_283_1.dialogCg_.alpha = 0

				local var_286_19 = LeanTween.value(arg_283_1.dialog_, 0, 1, 0.3)

				var_286_19:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_283_1.dialogCg_.alpha = arg_287_0
				end))
				var_286_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_283_1.dialog_)
					var_286_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_283_1.duration_ = arg_283_1.duration_ + 0.3

				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_20 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1102004069).content)

				arg_283_1.text_.text = var_286_20

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_22 = 33 <= 0 and var_286_18 or var_286_18 * (utf8.len(var_286_20) / 33)

				if (33 <= 0 and var_286_18 or var_286_18 * (utf8.len(var_286_20) / 33)) > 0 and var_286_18 < var_286_22 then
					arg_283_1.talkMaxDuration = var_286_22
					var_286_17 = var_286_17 + 0.3

					if var_286_22 + var_286_17 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_22 + var_286_17
					end
				end

				arg_283_1.text_.text = var_286_20
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_23 = var_286_17 + 0.3
			local var_286_24 = math.max(var_286_18, arg_283_1.talkMaxDuration)

			if var_286_17 + 0.3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_23 + var_286_24 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_23) / var_286_24

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_23 + var_286_24 and arg_283_1.time_ < var_286_23 + var_286_24 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R2001",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333334,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R2001",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play1102004070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1102004070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1102004071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.85

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1102004070).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 34 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 34)

				if (34 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 34)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1102004071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1102004071
		arg_293_1.duration_ = 5.53

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1102004072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = arg_293_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) then
				if arg_293_1.var_.characterEffect1020ui_story and not isNil(arg_293_1.actors_["1020ui_story"]) then
					arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story then
				arg_293_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_296_2 = 0
			local var_296_3 = 0.35

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(1102004071)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 14 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 14)

				if (14 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 14)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004071", "story_v_side_new_1102004.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004071", "story_v_side_new_1102004.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_side_new_1102004", "1102004071", "story_v_side_new_1102004.awb")

						arg_293_1:RecordAudio("1102004071", var_296_9)
						arg_293_1:RecordAudio("1102004071", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004071", "story_v_side_new_1102004.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004071", "story_v_side_new_1102004.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1102004072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1102004072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1102004073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) and arg_297_1.var_.characterEffect1020ui_story == nil then
				arg_297_1.var_.characterEffect1020ui_story = arg_297_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) then
				if arg_297_1.var_.characterEffect1020ui_story and not isNil(arg_297_1.actors_["1020ui_story"]) then
					arg_297_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) and arg_297_1.var_.characterEffect1020ui_story then
				arg_297_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 1.125

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1102004072).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 45 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 45)

				if (45 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 45)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1102004073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1102004073
		arg_301_1.duration_ = 9

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1102004074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if arg_301_1.bgs_.R2001a == nil then
				local var_304_0 = Object.Instantiate(arg_301_1.paintGo_)

				var_304_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R2001a")
				var_304_0.name = "R2001a"
				var_304_0.transform.parent = arg_301_1.stage_.transform
				var_304_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.bgs_.R2001a = var_304_0
			end

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= 2 + arg_304_0 then
				local var_304_1 = arg_301_1.bgs_.R2001a

				arg_301_1.bgs_.R2001a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_304_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_2 = var_304_1:GetComponent("SpriteRenderer")

				if var_304_2 and var_304_2.sprite then
					local var_304_3 = 2 * (var_304_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_304_1.transform.localScale = Vector3.New(var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "R2001a" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_4 = 4

			if 4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			if arg_301_1.time_ >= var_304_4 + 0.3 and arg_301_1.time_ < var_304_4 + 0.3 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_5 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_6 = 2

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_6 then
				local var_304_7 = Color.New(0, 0, 0)

				var_304_7.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - var_304_5) / var_304_6)
				arg_301_1.mask_.color = var_304_7
			end

			if arg_301_1.time_ >= var_304_5 + var_304_6 and arg_301_1.time_ < var_304_5 + var_304_6 + arg_304_0 then
				local var_304_8 = Color.New(0, 0, 0)

				var_304_8.a = 1
				arg_301_1.mask_.color = var_304_8
			end

			local var_304_9 = 2

			if 2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_10 = 2

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_10 then
				local var_304_11 = Color.New(0, 0, 0)

				var_304_11.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_9) / var_304_10)
				arg_301_1.mask_.color = var_304_11
			end

			if arg_301_1.time_ >= var_304_9 + var_304_10 and arg_301_1.time_ < var_304_9 + var_304_10 + arg_304_0 then
				local var_304_12 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_12.a = 0
				arg_301_1.mask_.color = var_304_12
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_13 = 4
			local var_304_14 = 0.175

			if 4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_15 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_15:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_16 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1102004073).content)

				arg_301_1.text_.text = var_304_16

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_18 = 7 <= 0 and var_304_14 or var_304_14 * (utf8.len(var_304_16) / 7)

				if (7 <= 0 and var_304_14 or var_304_14 * (utf8.len(var_304_16) / 7)) > 0 and var_304_14 < var_304_18 then
					arg_301_1.talkMaxDuration = var_304_18
					var_304_13 = var_304_13 + 0.3

					if var_304_18 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_18 + var_304_13
					end
				end

				arg_301_1.text_.text = var_304_16
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_19 = var_304_13 + 0.3
			local var_304_20 = math.max(var_304_14, arg_301_1.talkMaxDuration)

			if var_304_13 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_19 + var_304_20 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_19) / var_304_20

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_19 + var_304_20 and arg_301_1.time_ < var_304_19 + var_304_20 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1102004074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1102004074
		arg_307_1.duration_ = 1.73

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1102004075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1020ui_story"]) and arg_307_1.var_.characterEffect1020ui_story == nil then
				arg_307_1.var_.characterEffect1020ui_story = arg_307_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1020ui_story"]) then
				if arg_307_1.var_.characterEffect1020ui_story and not isNil(arg_307_1.actors_["1020ui_story"]) then
					arg_307_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1020ui_story"]) and arg_307_1.var_.characterEffect1020ui_story then
				arg_307_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_310_2 = 0
			local var_310_3 = 0.2

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(1102004074)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 8 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 8)

				if (8 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 8)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004074", "story_v_side_new_1102004.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004074", "story_v_side_new_1102004.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1102004", "1102004074", "story_v_side_new_1102004.awb")

						arg_307_1:RecordAudio("1102004074", var_310_9)
						arg_307_1:RecordAudio("1102004074", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004074", "story_v_side_new_1102004.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004074", "story_v_side_new_1102004.awb")
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
	Play1102004075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1102004075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1102004076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1020ui_story"]) and arg_311_1.var_.characterEffect1020ui_story == nil then
				arg_311_1.var_.characterEffect1020ui_story = arg_311_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1020ui_story"]) then
				if arg_311_1.var_.characterEffect1020ui_story and not isNil(arg_311_1.actors_["1020ui_story"]) then
					arg_311_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1020ui_story"]) and arg_311_1.var_.characterEffect1020ui_story then
				arg_311_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.175

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1102004075).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 7 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 7)

				if (7 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 7)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1102004076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1102004076
		arg_315_1.duration_ = 4.83

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1102004077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1020ui_story"]) and arg_315_1.var_.characterEffect1020ui_story == nil then
				arg_315_1.var_.characterEffect1020ui_story = arg_315_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1020ui_story"]) then
				if arg_315_1.var_.characterEffect1020ui_story and not isNil(arg_315_1.actors_["1020ui_story"]) then
					arg_315_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1020ui_story"]) and arg_315_1.var_.characterEffect1020ui_story then
				arg_315_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_318_2 = 0
			local var_318_3 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(1102004076)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004076", "story_v_side_new_1102004.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004076", "story_v_side_new_1102004.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_side_new_1102004", "1102004076", "story_v_side_new_1102004.awb")

						arg_315_1:RecordAudio("1102004076", var_318_9)
						arg_315_1:RecordAudio("1102004076", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004076", "story_v_side_new_1102004.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004076", "story_v_side_new_1102004.awb")
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
	Play1102004077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1102004077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1102004078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1020ui_story"]) and arg_319_1.var_.characterEffect1020ui_story == nil then
				arg_319_1.var_.characterEffect1020ui_story = arg_319_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1020ui_story"]) then
				if arg_319_1.var_.characterEffect1020ui_story and not isNil(arg_319_1.actors_["1020ui_story"]) then
					arg_319_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1020ui_story"]) and arg_319_1.var_.characterEffect1020ui_story then
				arg_319_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 1.075

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1102004077).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 43 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 43)

				if (43 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 43)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1102004078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1102004078
		arg_323_1.duration_ = 3.43

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1102004079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1020ui_story"]) and arg_323_1.var_.characterEffect1020ui_story == nil then
				arg_323_1.var_.characterEffect1020ui_story = arg_323_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1020ui_story"]) then
				if arg_323_1.var_.characterEffect1020ui_story and not isNil(arg_323_1.actors_["1020ui_story"]) then
					arg_323_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1020ui_story"]) and arg_323_1.var_.characterEffect1020ui_story then
				arg_323_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_326_2 = 0
			local var_326_3 = 0.4

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(1102004078)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 16 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 16)

				if (16 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 16)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004078", "story_v_side_new_1102004.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004078", "story_v_side_new_1102004.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_side_new_1102004", "1102004078", "story_v_side_new_1102004.awb")

						arg_323_1:RecordAudio("1102004078", var_326_9)
						arg_323_1:RecordAudio("1102004078", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004078", "story_v_side_new_1102004.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004078", "story_v_side_new_1102004.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1102004079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1102004079
		arg_327_1.duration_ = 11.77

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1102004080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 1.25

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(1102004079)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 50 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 50)

				if (50 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 50)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004079", "story_v_side_new_1102004.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004079", "story_v_side_new_1102004.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_side_new_1102004", "1102004079", "story_v_side_new_1102004.awb")

						arg_327_1:RecordAudio("1102004079", var_330_6)
						arg_327_1:RecordAudio("1102004079", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004079", "story_v_side_new_1102004.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004079", "story_v_side_new_1102004.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1102004080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1102004080
		arg_331_1.duration_ = 2.2

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1102004081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.175

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(1102004080)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 7 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 7)

				if (7 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 7)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004080", "story_v_side_new_1102004.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004080", "story_v_side_new_1102004.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_side_new_1102004", "1102004080", "story_v_side_new_1102004.awb")

						arg_331_1:RecordAudio("1102004080", var_334_6)
						arg_331_1:RecordAudio("1102004080", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004080", "story_v_side_new_1102004.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004080", "story_v_side_new_1102004.awb")
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
	Play1102004081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1102004081
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1102004082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1020ui_story"]) and arg_335_1.var_.characterEffect1020ui_story == nil then
				arg_335_1.var_.characterEffect1020ui_story = arg_335_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1020ui_story"]) then
				if arg_335_1.var_.characterEffect1020ui_story and not isNil(arg_335_1.actors_["1020ui_story"]) then
					arg_335_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1020ui_story"]) and arg_335_1.var_.characterEffect1020ui_story then
				arg_335_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.6

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1102004081).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 24 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 24)

				if (24 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 24)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1102004082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1102004082
		arg_339_1.duration_ = 3.47

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1102004083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1020ui_story"]) and arg_339_1.var_.characterEffect1020ui_story == nil then
				arg_339_1.var_.characterEffect1020ui_story = arg_339_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1020ui_story"]) then
				if arg_339_1.var_.characterEffect1020ui_story and not isNil(arg_339_1.actors_["1020ui_story"]) then
					arg_339_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1020ui_story"]) and arg_339_1.var_.characterEffect1020ui_story then
				arg_339_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_342_2 = 0
			local var_342_3 = 0.45

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_4 = arg_339_1:GetWordFromCfg(1102004082)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 18 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 18)

				if (18 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 18)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004082", "story_v_side_new_1102004.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004082", "story_v_side_new_1102004.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_side_new_1102004", "1102004082", "story_v_side_new_1102004.awb")

						arg_339_1:RecordAudio("1102004082", var_342_9)
						arg_339_1:RecordAudio("1102004082", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004082", "story_v_side_new_1102004.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004082", "story_v_side_new_1102004.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1102004083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1102004083
		arg_343_1.duration_ = 5.33

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1102004084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.525

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(1102004083)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 21 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 21)

				if (21 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 21)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004083", "story_v_side_new_1102004.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004083", "story_v_side_new_1102004.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_side_new_1102004", "1102004083", "story_v_side_new_1102004.awb")

						arg_343_1:RecordAudio("1102004083", var_346_6)
						arg_343_1:RecordAudio("1102004083", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004083", "story_v_side_new_1102004.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004083", "story_v_side_new_1102004.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1102004084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1102004084
		arg_347_1.duration_ = 1

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"

			SetActive(arg_347_1.choicesGo_, true)

			for iter_348_0, iter_348_1 in ipairs(arg_347_1.choices_) do
				SetActive(iter_348_1.go, iter_348_0 <= 1)
			end

			arg_347_1.choices_[1].txt.text = arg_347_1:FormatText(StoryChoiceCfg[1198].name)
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1102004085(arg_347_1)
			end

			arg_347_1:RecordChoiceLog(1102004084, 1198)
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1020ui_story"]) and arg_347_1.var_.characterEffect1020ui_story == nil then
				arg_347_1.var_.characterEffect1020ui_story = arg_347_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1020ui_story"]) then
				if arg_347_1.var_.characterEffect1020ui_story and not isNil(arg_347_1.actors_["1020ui_story"]) then
					arg_347_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1020ui_story"]) and arg_347_1.var_.characterEffect1020ui_story then
				arg_347_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.allBtn_.enabled = false
			end

			if arg_347_1.time_ >= var_350_1 + 0.6 and arg_347_1.time_ < var_350_1 + 0.6 + arg_350_0 then
				arg_347_1.allBtn_.enabled = true
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1102004085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1102004085
		arg_351_1.duration_ = 3.17

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1102004086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1020ui_story"]) and arg_351_1.var_.characterEffect1020ui_story == nil then
				arg_351_1.var_.characterEffect1020ui_story = arg_351_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1020ui_story"]) then
				if arg_351_1.var_.characterEffect1020ui_story and not isNil(arg_351_1.actors_["1020ui_story"]) then
					arg_351_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1020ui_story"]) and arg_351_1.var_.characterEffect1020ui_story then
				arg_351_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_354_2 = 0
			local var_354_3 = 0.425

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(1102004085)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 17 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 17)

				if (17 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 17)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004085", "story_v_side_new_1102004.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004085", "story_v_side_new_1102004.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_side_new_1102004", "1102004085", "story_v_side_new_1102004.awb")

						arg_351_1:RecordAudio("1102004085", var_354_9)
						arg_351_1:RecordAudio("1102004085", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004085", "story_v_side_new_1102004.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004085", "story_v_side_new_1102004.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1102004086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1102004086
		arg_355_1.duration_ = 8.67

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1102004087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 2 < arg_355_1.time_ and arg_355_1.time_ <= 2 + arg_358_0 then
				local var_358_0 = arg_355_1.bgs_.L02h

				arg_355_1.bgs_.L02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_358_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_358_1 = var_358_0:GetComponent("SpriteRenderer")

				if var_358_1 and var_358_1.sprite then
					local var_358_2 = 2 * (var_358_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_358_0.transform.localScale = Vector3.New(var_358_2 / var_358_1.sprite.bounds.size.y < var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x and var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x or var_358_2 / var_358_1.sprite.bounds.size.y, var_358_2 / var_358_1.sprite.bounds.size.y < var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x and var_358_2 * manager.ui.mainCameraCom_.aspect / var_358_1.sprite.bounds.size.x or var_358_2 / var_358_1.sprite.bounds.size.y, 0)
				end

				for iter_358_0, iter_358_1 in pairs(arg_355_1.bgs_) do
					if iter_358_0 ~= "L02h" then
						iter_358_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_358_3 = 4

			if 4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_3 + arg_358_0 then
				arg_355_1.allBtn_.enabled = false
			end

			if arg_355_1.time_ >= var_358_3 + 0.3 and arg_355_1.time_ < var_358_3 + 0.3 + arg_358_0 then
				arg_355_1.allBtn_.enabled = true
			end

			local var_358_4 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_5 = 2

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_5 then
				local var_358_6 = Color.New(0, 0, 0)

				var_358_6.a = Mathf.Lerp(0, 1, (arg_355_1.time_ - var_358_4) / var_358_5)
				arg_355_1.mask_.color = var_358_6
			end

			if arg_355_1.time_ >= var_358_4 + var_358_5 and arg_355_1.time_ < var_358_4 + var_358_5 + arg_358_0 then
				local var_358_7 = Color.New(0, 0, 0)

				var_358_7.a = 1
				arg_355_1.mask_.color = var_358_7
			end

			local var_358_8 = 2

			if 2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = true

				arg_355_1:SetGaussion(false)
			end

			local var_358_9 = 2

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_9 then
				local var_358_10 = Color.New(0, 0, 0)

				var_358_10.a = Mathf.Lerp(1, 0, (arg_355_1.time_ - var_358_8) / var_358_9)
				arg_355_1.mask_.color = var_358_10
			end

			if arg_355_1.time_ >= var_358_8 + var_358_9 and arg_355_1.time_ < var_358_8 + var_358_9 + arg_358_0 then
				local var_358_11 = Color.New(0, 0, 0)

				arg_355_1.mask_.enabled = false
				var_358_11.a = 0
				arg_355_1.mask_.color = var_358_11
			end

			local var_358_12 = arg_355_1.actors_["1020ui_story"].transform

			if 3.8 < arg_355_1.time_ and arg_355_1.time_ <= 3.8 + arg_358_0 then
				arg_355_1.var_.moveOldPos1020ui_story = var_358_12.localPosition
			end

			local var_358_13 = 0.001

			if 3.8 <= arg_355_1.time_ and arg_355_1.time_ < 3.8 + var_358_13 then
				var_358_12.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_355_1.time_ - 3.8) / var_358_13)
				var_358_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_12.position).x, (manager.ui.mainCamera.transform.position - var_358_12.position).y, (manager.ui.mainCamera.transform.position - var_358_12.position).z)
				var_358_12.localEulerAngles.z = 0
				var_358_12.localEulerAngles.x = 0
				var_358_12.localEulerAngles = var_358_12.localEulerAngles
			end

			if arg_355_1.time_ >= 3.8 + var_358_13 and arg_355_1.time_ < 3.8 + var_358_13 + arg_358_0 then
				var_358_12.localPosition = Vector3.New(0, -0.85, -6.25)
				var_358_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_12.position).x, (manager.ui.mainCamera.transform.position - var_358_12.position).y, (manager.ui.mainCamera.transform.position - var_358_12.position).z)
				var_358_12.localEulerAngles.z = 0
				var_358_12.localEulerAngles.x = 0
				var_358_12.localEulerAngles = var_358_12.localEulerAngles
			end

			if 3.8 < arg_355_1.time_ and arg_355_1.time_ <= 3.8 + arg_358_0 then
				arg_355_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 3.8 < arg_355_1.time_ and arg_355_1.time_ <= 3.8 + arg_358_0 then
				arg_355_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_358_14 = arg_355_1.actors_["1020ui_story"]

			if 3.8 < arg_355_1.time_ and arg_355_1.time_ <= 3.8 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.characterEffect1020ui_story == nil then
				arg_355_1.var_.characterEffect1020ui_story = var_358_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_15 = 0.2

			if 3.8 <= arg_355_1.time_ and arg_355_1.time_ < 3.8 + var_358_15 and not isNil(var_358_14) then
				if arg_355_1.var_.characterEffect1020ui_story and not isNil(var_358_14) then
					arg_355_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 3.8 + var_358_15 and arg_355_1.time_ < 3.8 + var_358_15 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.characterEffect1020ui_story then
				arg_355_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0.333333333333333 < arg_355_1.time_ and arg_355_1.time_ <= 0.333333333333333 + arg_358_0 then
				arg_355_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_field", "")
			end

			if 1.56666666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.56666666666667 + arg_358_0 then
				arg_355_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_355_1.frameCnt_ <= 1 then
				arg_355_1.dialog_:SetActive(false)
			end

			local var_358_19 = 4
			local var_358_20 = 0.6

			if 4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_19 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				arg_355_1.dialog_:SetActive(true)

				arg_355_1.dialogCg_.alpha = 0

				local var_358_21 = LeanTween.value(arg_355_1.dialog_, 0, 1, 0.3)

				var_358_21:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_355_1.dialogCg_.alpha = arg_359_0
				end))
				var_358_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_355_1.dialog_)
					var_358_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_355_1.duration_ = arg_355_1.duration_ + 0.3

				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_22 = arg_355_1:GetWordFromCfg(1102004086)
				local var_358_23 = arg_355_1:FormatText(var_358_22.content)

				arg_355_1.text_.text = var_358_23

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_25 = 24 <= 0 and var_358_20 or var_358_20 * (utf8.len(var_358_23) / 24)

				if (24 <= 0 and var_358_20 or var_358_20 * (utf8.len(var_358_23) / 24)) > 0 and var_358_20 < var_358_25 then
					arg_355_1.talkMaxDuration = var_358_25
					var_358_19 = var_358_19 + 0.3

					if var_358_25 + var_358_19 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_25 + var_358_19
					end
				end

				arg_355_1.text_.text = var_358_23
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004086", "story_v_side_new_1102004.awb") ~= 0 then
					local var_358_26 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004086", "story_v_side_new_1102004.awb") / 1000

					if var_358_26 + var_358_19 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_26 + var_358_19
					end

					if var_358_22.prefab_name ~= "" and arg_355_1.actors_[var_358_22.prefab_name] ~= nil then
						local var_358_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_22.prefab_name].transform, "story_v_side_new_1102004", "1102004086", "story_v_side_new_1102004.awb")

						arg_355_1:RecordAudio("1102004086", var_358_27)
						arg_355_1:RecordAudio("1102004086", var_358_27)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004086", "story_v_side_new_1102004.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004086", "story_v_side_new_1102004.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_28 = var_358_19 + 0.3
			local var_358_29 = math.max(var_358_20, arg_355_1.talkMaxDuration)

			if var_358_19 + 0.3 <= arg_355_1.time_ and arg_355_1.time_ < var_358_28 + var_358_29 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_28) / var_358_29

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_28 + var_358_29 and arg_355_1.time_ < var_358_28 + var_358_29 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play1102004087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1102004087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1102004088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) and arg_361_1.var_.characterEffect1020ui_story == nil then
				arg_361_1.var_.characterEffect1020ui_story = arg_361_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) then
				if arg_361_1.var_.characterEffect1020ui_story and not isNil(arg_361_1.actors_["1020ui_story"]) then
					arg_361_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) and arg_361_1.var_.characterEffect1020ui_story then
				arg_361_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.9

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1102004087).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 36 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 36)

				if (36 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 36)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1102004088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1102004088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1102004089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.775

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1102004088).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 31 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 31)

				if (31 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 31)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1102004089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1102004089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1102004090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1020ui_story = arg_369_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).z)
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles = arg_369_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1020ui_story"].transform.position).z)
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1020ui_story"].transform.localEulerAngles = arg_369_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_372_1 = 0
			local var_372_2 = 1.125

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1102004089).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 45 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 45)

				if (45 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 45)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play1102004090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1102004090
		arg_373_1.duration_ = 7.5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1102004091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1020ui_story = arg_373_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).z)
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles = arg_373_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_373_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1020ui_story"].transform.position).z)
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1020ui_story"].transform.localEulerAngles = arg_373_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1020ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1020ui_story == nil then
				arg_373_1.var_.characterEffect1020ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect1020ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1020ui_story then
				arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_376_4 = 0
			local var_376_5 = 0.675

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:GetWordFromCfg(1102004090)
				local var_376_7 = arg_373_1:FormatText(var_376_6.content)

				arg_373_1.text_.text = var_376_7

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_9 = 27 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 27)

				if (27 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_7) / 27)) > 0 and var_376_5 < var_376_9 then
					arg_373_1.talkMaxDuration = var_376_9

					if var_376_9 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_7
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004090", "story_v_side_new_1102004.awb") ~= 0 then
					local var_376_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004090", "story_v_side_new_1102004.awb") / 1000

					if var_376_10 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_4
					end

					if var_376_6.prefab_name ~= "" and arg_373_1.actors_[var_376_6.prefab_name] ~= nil then
						local var_376_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_6.prefab_name].transform, "story_v_side_new_1102004", "1102004090", "story_v_side_new_1102004.awb")

						arg_373_1:RecordAudio("1102004090", var_376_11)
						arg_373_1:RecordAudio("1102004090", var_376_11)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004090", "story_v_side_new_1102004.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004090", "story_v_side_new_1102004.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_12 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_12 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_12

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_12 and arg_373_1.time_ < var_376_4 + var_376_12 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1102004091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1102004091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1102004092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story == nil then
				arg_377_1.var_.characterEffect1020ui_story = arg_377_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) then
				if arg_377_1.var_.characterEffect1020ui_story and not isNil(arg_377_1.actors_["1020ui_story"]) then
					arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story then
				arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.15

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1102004091).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 6 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 6)

				if (6 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 6)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1102004092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1102004092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1102004093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1020ui_story = arg_381_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).z)
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles = arg_381_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_381_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1020ui_story"].transform.position).z)
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1020ui_story"].transform.localEulerAngles = arg_381_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_384_1 = 0
			local var_384_2 = 0.875

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_3 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(1102004092).content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 35 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 35)

				if (35 <= 0 and var_384_2 or var_384_2 * (utf8.len(var_384_3) / 35)) > 0 and var_384_2 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_1 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_1
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_6 = math.max(var_384_2, arg_381_1.talkMaxDuration)

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_6 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_1) / var_384_6

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_1 + var_384_6 and arg_381_1.time_ < var_384_1 + var_384_6 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play1102004093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1102004093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1102004094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_388_0 = 0.6

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				local var_388_1, var_388_2 = math.modf((arg_385_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_388_2 * 0.13, var_388_2 * 0.13, var_388_2 * 0.13) + arg_385_1.var_.shakeOldPos
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				manager.ui.mainCamera.transform.localPosition = arg_385_1.var_.shakeOldPos
			end

			local var_388_3 = 0

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_3 + arg_388_0 then
				arg_385_1.allBtn_.enabled = false
			end

			if arg_385_1.time_ >= var_388_3 + 0.6 and arg_385_1.time_ < var_388_3 + 0.6 + arg_388_0 then
				arg_385_1.allBtn_.enabled = true
			end

			local var_388_4 = 0
			local var_388_5 = 0.1

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_6 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1102004093).content)

				arg_385_1.text_.text = var_388_6

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_8 = 4 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 4)

				if (4 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 4)) > 0 and var_388_5 < var_388_8 then
					arg_385_1.talkMaxDuration = var_388_8

					if var_388_8 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_6
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_9 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_9 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_9

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_9 and arg_385_1.time_ < var_388_4 + var_388_9 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1102004094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1102004094
		arg_389_1.duration_ = 4.4

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1102004095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1020ui_story = arg_389_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).z)
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles = arg_389_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_389_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).z)
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles = arg_389_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1020ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1020ui_story == nil then
				arg_389_1.var_.characterEffect1020ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1020ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1020ui_story then
				arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action487")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_392_4 = 0
			local var_392_5 = 0.275

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:GetWordFromCfg(1102004094)
				local var_392_7 = arg_389_1:FormatText(var_392_6.content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 11 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 11)

				if (11 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 11)) > 0 and var_392_5 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004094", "story_v_side_new_1102004.awb") ~= 0 then
					local var_392_10 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004094", "story_v_side_new_1102004.awb") / 1000

					if var_392_10 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_4
					end

					if var_392_6.prefab_name ~= "" and arg_389_1.actors_[var_392_6.prefab_name] ~= nil then
						local var_392_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_6.prefab_name].transform, "story_v_side_new_1102004", "1102004094", "story_v_side_new_1102004.awb")

						arg_389_1:RecordAudio("1102004094", var_392_11)
						arg_389_1:RecordAudio("1102004094", var_392_11)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004094", "story_v_side_new_1102004.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004094", "story_v_side_new_1102004.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_12 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_12 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_12

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_12 and arg_389_1.time_ < var_392_4 + var_392_12 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play1102004095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1102004095
		arg_393_1.duration_ = 9

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1102004096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if arg_393_1.bgs_.ST12 == nil then
				local var_396_0 = Object.Instantiate(arg_393_1.paintGo_)

				var_396_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_396_0.name = "ST12"
				var_396_0.transform.parent = arg_393_1.stage_.transform
				var_396_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_393_1.bgs_.ST12 = var_396_0
			end

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= 2 + arg_396_0 then
				local var_396_1 = arg_393_1.bgs_.ST12

				arg_393_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_2 = var_396_1:GetComponent("SpriteRenderer")

				if var_396_2 and var_396_2.sprite then
					local var_396_3 = 2 * (var_396_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_1.transform.localScale = Vector3.New(var_396_3 / var_396_2.sprite.bounds.size.y < var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x and var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x or var_396_3 / var_396_2.sprite.bounds.size.y, var_396_3 / var_396_2.sprite.bounds.size.y < var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x and var_396_3 * manager.ui.mainCameraCom_.aspect / var_396_2.sprite.bounds.size.x or var_396_3 / var_396_2.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "ST12" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_4 = 4

			if 4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			if arg_393_1.time_ >= var_396_4 + 0.3 and arg_393_1.time_ < var_396_4 + 0.3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_5 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_6 = 2

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_6 then
				local var_396_7 = Color.New(0, 0, 0)

				var_396_7.a = Mathf.Lerp(0, 1, (arg_393_1.time_ - var_396_5) / var_396_6)
				arg_393_1.mask_.color = var_396_7
			end

			if arg_393_1.time_ >= var_396_5 + var_396_6 and arg_393_1.time_ < var_396_5 + var_396_6 + arg_396_0 then
				local var_396_8 = Color.New(0, 0, 0)

				var_396_8.a = 1
				arg_393_1.mask_.color = var_396_8
			end

			local var_396_9 = 2

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_10 = 2

			if var_396_9 <= arg_393_1.time_ and arg_393_1.time_ < var_396_9 + var_396_10 then
				local var_396_11 = Color.New(0, 0, 0)

				var_396_11.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_9) / var_396_10)
				arg_393_1.mask_.color = var_396_11
			end

			if arg_393_1.time_ >= var_396_9 + var_396_10 and arg_393_1.time_ < var_396_9 + var_396_10 + arg_396_0 then
				local var_396_12 = Color.New(0, 0, 0)

				arg_393_1.mask_.enabled = false
				var_396_12.a = 0
				arg_393_1.mask_.color = var_396_12
			end

			local var_396_13 = arg_393_1.actors_["1020ui_story"]

			if 1.98333333333333 < arg_393_1.time_ and arg_393_1.time_ <= 1.98333333333333 + arg_396_0 and not isNil(var_396_13) and arg_393_1.var_.characterEffect1020ui_story == nil then
				arg_393_1.var_.characterEffect1020ui_story = var_396_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_14 = 0.0166666666666666

			if 1.98333333333333 <= arg_393_1.time_ and arg_393_1.time_ < 1.98333333333333 + var_396_14 and not isNil(var_396_13) then
				if arg_393_1.var_.characterEffect1020ui_story and not isNil(var_396_13) then
					arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 1.98333333333333) / var_396_14)
				end
			end

			if arg_393_1.time_ >= 1.98333333333333 + var_396_14 and arg_393_1.time_ < 1.98333333333333 + var_396_14 + arg_396_0 and not isNil(var_396_13) and arg_393_1.var_.characterEffect1020ui_story then
				arg_393_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_396_15 = arg_393_1.actors_["1020ui_story"].transform

			if 1.98333333333333 < arg_393_1.time_ and arg_393_1.time_ <= 1.98333333333333 + arg_396_0 then
				arg_393_1.var_.moveOldPos1020ui_story = var_396_15.localPosition
			end

			local var_396_16 = 0.001

			if 1.98333333333333 <= arg_393_1.time_ and arg_393_1.time_ < 1.98333333333333 + var_396_16 then
				var_396_15.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 1.98333333333333) / var_396_16)
				var_396_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_15.position).x, (manager.ui.mainCamera.transform.position - var_396_15.position).y, (manager.ui.mainCamera.transform.position - var_396_15.position).z)
				var_396_15.localEulerAngles.z = 0
				var_396_15.localEulerAngles.x = 0
				var_396_15.localEulerAngles = var_396_15.localEulerAngles
			end

			if arg_393_1.time_ >= 1.98333333333333 + var_396_16 and arg_393_1.time_ < 1.98333333333333 + var_396_16 + arg_396_0 then
				var_396_15.localPosition = Vector3.New(0, 100, 0)
				var_396_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_15.position).x, (manager.ui.mainCamera.transform.position - var_396_15.position).y, (manager.ui.mainCamera.transform.position - var_396_15.position).z)
				var_396_15.localEulerAngles.z = 0
				var_396_15.localEulerAngles.x = 0
				var_396_15.localEulerAngles = var_396_15.localEulerAngles
			end

			if 1.53333333333333 < arg_393_1.time_ and arg_393_1.time_ <= 1.53333333333333 + arg_396_0 then
				arg_393_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 0.125 < arg_393_1.time_ and arg_393_1.time_ <= 0.125 + arg_396_0 then
				arg_393_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_19 = 4
			local var_396_20 = 1

			if 4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_19 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_21 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_21:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_22 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1102004095).content)

				arg_393_1.text_.text = var_396_22

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_24 = 40 <= 0 and var_396_20 or var_396_20 * (utf8.len(var_396_22) / 40)

				if (40 <= 0 and var_396_20 or var_396_20 * (utf8.len(var_396_22) / 40)) > 0 and var_396_20 < var_396_24 then
					arg_393_1.talkMaxDuration = var_396_24
					var_396_19 = var_396_19 + 0.3

					if var_396_24 + var_396_19 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_24 + var_396_19
					end
				end

				arg_393_1.text_.text = var_396_22
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = var_396_19 + 0.3
			local var_396_26 = math.max(var_396_20, arg_393_1.talkMaxDuration)

			if var_396_19 + 0.3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_25 + var_396_26 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_25) / var_396_26

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_25 + var_396_26 and arg_393_1.time_ < var_396_25 + var_396_26 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1102004096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1102004096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1102004097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0.05 < arg_399_1.time_ and arg_399_1.time_ <= 0.05 + arg_402_0 then
				arg_399_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sign", "")
			end

			local var_402_1 = 0
			local var_402_2 = 1.35

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1102004096).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 54 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 54)

				if (54 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 54)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1102004097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1102004097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1102004098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.5

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1102004097).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 20 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 20)

				if (20 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 20)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1102004098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1102004098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1102004099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0.375 < arg_407_1.time_ and arg_407_1.time_ <= 0.375 + arg_410_0 then
				arg_407_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_pictures", "")
			end

			local var_410_1 = 0
			local var_410_2 = 0.375

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1102004098).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 15 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 15)

				if (15 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 15)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1102004099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1102004099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1102004100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.375

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1102004099).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 4 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 4)

				if (4 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 4)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1102004100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1102004100
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1102004101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1102004100).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 20 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 20)

				if (20 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 20)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1102004101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1102004101
		arg_419_1.duration_ = 4.37

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1102004102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.5

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:GetWordFromCfg(1102004101)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 28 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 28)

				if (28 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 28)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004101", "story_v_side_new_1102004.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004101", "story_v_side_new_1102004.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_side_new_1102004", "1102004101", "story_v_side_new_1102004.awb")

						arg_419_1:RecordAudio("1102004101", var_422_6)
						arg_419_1:RecordAudio("1102004101", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004101", "story_v_side_new_1102004.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004101", "story_v_side_new_1102004.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1102004102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1102004102
		arg_423_1.duration_ = 5.03

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
			arg_423_1.auto_ = false
		end

		function arg_423_1.playNext_(arg_425_0)
			arg_423_1.onStoryFinished_()
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.7

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:GetWordFromCfg(1102004102)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 19 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 19)

				if (19 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 19)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004102", "story_v_side_new_1102004.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_side_new_1102004", "1102004102", "story_v_side_new_1102004.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_side_new_1102004", "1102004102", "story_v_side_new_1102004.awb")

						arg_423_1:RecordAudio("1102004102", var_426_6)
						arg_423_1:RecordAudio("1102004102", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1102004", "1102004102", "story_v_side_new_1102004.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1102004", "1102004102", "story_v_side_new_1102004.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0503",
		"TextureConfig/Background/L02h",
		"TextureConfig/Background/R2001",
		"TextureConfig/Background/R2001a",
		"TextureConfig/Background/ST12"
	},
	voices = {
		"story_v_side_new_1102004.awb"
	}
}
