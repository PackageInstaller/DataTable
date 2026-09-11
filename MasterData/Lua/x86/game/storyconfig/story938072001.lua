return {
	Play938072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938072001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I20f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I20f")
				var_4_0.name = "I20f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I20f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I20f

				arg_1_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I20f" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938072001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 21 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 21)

				if (21 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 21)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.675

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(938072002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 67 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 67)

				if (67 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 67)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(938072003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 4 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 4)

				if (4 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 4)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938072004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["10183"] == nil then
				local var_19_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_19_0) then
					local var_19_1 = Object.Instantiate(var_19_0, arg_16_1.canvasGo_.transform)

					var_19_1.transform:SetSiblingIndex(1)

					var_19_1.name = "10183"
					var_19_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_16_1.actors_["10183"] = var_19_1

					if arg_16_1.isInRecall_ then
						for iter_19_0, iter_19_1 in ipairs((var_19_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_19_1.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_19_2 = arg_16_1.actors_["10183"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps10183 == nil then
				arg_16_1.var_.actorSpriteComps10183 = var_19_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_3 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.actorSpriteComps10183 then
					for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_19_3 then
							if arg_16_1.isInRecall_ then
								iter_19_3.color = Color.New(Mathf.Lerp(iter_19_3.color.r, arg_16_1.hightColor1.r, (arg_16_1.time_ - 0) / var_19_3), Mathf.Lerp(iter_19_3.color.g, arg_16_1.hightColor1.g, (arg_16_1.time_ - 0) / var_19_3), (Mathf.Lerp(iter_19_3.color.b, arg_16_1.hightColor1.b, (arg_16_1.time_ - 0) / var_19_3)))
							else
								local var_19_4 = Mathf.Lerp(iter_19_3.color.r, 1, (arg_16_1.time_ - 0) / var_19_3)

								iter_19_3.color = Color.New(var_19_4, var_19_4, var_19_4)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.actorSpriteComps10183 then
				for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_19_5 then
						iter_19_5.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_16_1.var_.actorSpriteComps10183 = nil
			end

			local var_19_5 = arg_16_1.actors_["10183"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10183 = var_19_5.localPosition
				var_19_5.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10183", 3)

				for iter_19_6 = 0, var_19_5.childCount - 1 do
					local var_19_6 = var_19_5:GetChild(iter_19_6)

					if var_19_6.name == "split_9" or not string.find(var_19_6.name, "split") then
						var_19_6.gameObject:SetActive(true)
					else
						var_19_6.gameObject:SetActive(false)
					end
				end
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_16_1.time_ - 0) / var_19_7)
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -475, -325)
			end

			local var_19_8 = 0
			local var_19_9 = 0.4

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(938072004).content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_12 = 16 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 16)

				if (16 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_10) / 16)) > 0 and var_19_9 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_13 and arg_16_1.time_ < var_19_8 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play938072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938072005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10183 = arg_20_1.actors_["10183"].transform.localPosition
				arg_20_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10183", 3)

				for iter_23_0 = 0, arg_20_1.actors_["10183"].transform.childCount - 1 do
					local var_23_0 = arg_20_1.actors_["10183"].transform:GetChild(iter_23_0)

					if var_23_0.name == "split_10" then
						var_23_0:SetAsLastSibling()
						var_23_0.gameObject:SetActive(true)

						arg_20_1.var_.actorSpriteSplit10183 = var_23_0.gameObject:GetComponent(typeof(Image))

						arg_20_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_23_1 = 0.5

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_20_1.time_ - 0) / var_23_1)

				if arg_20_1.var_.actorSpriteSplit10183 ~= nil then
					arg_20_1.var_.actorSpriteSplit10183:SetAlpha((arg_20_1.time_ - 0) / var_23_1)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_20_1.var_.actorSpriteSplit10183 ~= nil then
					arg_20_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_23_2 = 0
			local var_23_3 = 0.85

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(938072005).content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 34 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 34)

				if (34 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 34)) > 0 and var_23_3 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_7 and arg_20_1.time_ < var_23_2 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play938072006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938072006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938072007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["128404"] == nil then
				local var_27_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_27_0) then
					local var_27_1 = Object.Instantiate(var_27_0, arg_24_1.canvasGo_.transform)

					var_27_1.transform:SetSiblingIndex(1)

					var_27_1.name = "128404"
					var_27_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_["128404"] = var_27_1

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs((var_27_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_2 = arg_24_1.actors_["128404"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps128404 == nil then
				arg_24_1.var_.actorSpriteComps128404 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps128404 then
					for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_27_3 then
							if arg_24_1.isInRecall_ then
								iter_27_3.color = Color.New(Mathf.Lerp(iter_27_3.color.r, arg_24_1.hightColor1.r, (arg_24_1.time_ - 0) / var_27_3), Mathf.Lerp(iter_27_3.color.g, arg_24_1.hightColor1.g, (arg_24_1.time_ - 0) / var_27_3), (Mathf.Lerp(iter_27_3.color.b, arg_24_1.hightColor1.b, (arg_24_1.time_ - 0) / var_27_3)))
							else
								local var_27_4 = Mathf.Lerp(iter_27_3.color.r, 1, (arg_24_1.time_ - 0) / var_27_3)

								iter_27_3.color = Color.New(var_27_4, var_27_4, var_27_4)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps128404 then
				for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_27_5 then
						iter_27_5.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps128404 = nil
			end

			local var_27_5 = arg_24_1.actors_["10183"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.actorSpriteComps10183 == nil then
				arg_24_1.var_.actorSpriteComps10183 = var_27_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_6 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 and not isNil(var_27_5) then
				if arg_24_1.var_.actorSpriteComps10183 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								iter_27_7.color = Color.New(Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_6), Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_6), (Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_6)))
							else
								local var_27_7 = Mathf.Lerp(iter_27_7.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_6)

								iter_27_7.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.actorSpriteComps10183 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_27_9 then
						iter_27_9.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps10183 = nil
			end

			local var_27_8 = arg_24_1.actors_["128404"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos128404 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("128404", 4)

				for iter_27_10 = 0, var_27_8.childCount - 1 do
					local var_27_9 = var_27_8:GetChild(iter_27_10)

					if var_27_9.name == "split_10" or not string.find(var_27_9.name, "split") then
						var_27_9.gameObject:SetActive(true)
					else
						var_27_9.gameObject:SetActive(false)
					end
				end
			end

			local var_27_10 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_10 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_24_1.time_ - 0) / var_27_10)
			end

			if arg_24_1.time_ >= 0 + var_27_10 and arg_24_1.time_ < 0 + var_27_10 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_27_11 = arg_24_1.actors_["10183"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10183 = var_27_11.localPosition
				var_27_11.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10183", 2)

				for iter_27_11 = 0, var_27_11.childCount - 1 do
					local var_27_12 = var_27_11:GetChild(iter_27_11)

					if var_27_12.name == "split_9" or not string.find(var_27_12.name, "split") then
						var_27_12.gameObject:SetActive(true)
					else
						var_27_12.gameObject:SetActive(false)
					end
				end
			end

			local var_27_13 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_13 then
				var_27_11.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_24_1.time_ - 0) / var_27_13)
			end

			if arg_24_1.time_ >= 0 + var_27_13 and arg_24_1.time_ < 0 + var_27_13 + arg_27_0 then
				var_27_11.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_27_14 = 0
			local var_27_15 = 0.325

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(938072006).content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_18 = 13 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_16) / 13)

				if (13 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_16) / 13)) > 0 and var_27_15 < var_27_18 then
					arg_24_1.talkMaxDuration = var_27_18

					if var_27_18 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_19 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_19 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_19

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_19 and arg_24_1.time_ < var_27_14 + var_27_19 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play938072007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938072007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938072008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["10144"] == nil then
				local var_31_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_31_0) then
					local var_31_1 = Object.Instantiate(var_31_0, arg_28_1.canvasGo_.transform)

					var_31_1.transform:SetSiblingIndex(1)

					var_31_1.name = "10144"
					var_31_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_28_1.actors_["10144"] = var_31_1

					if arg_28_1.isInRecall_ then
						for iter_31_0, iter_31_1 in ipairs((var_31_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_31_1.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_31_2 = arg_28_1.actors_["10144"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps10144 == nil then
				arg_28_1.var_.actorSpriteComps10144 = var_31_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.actorSpriteComps10144 then
					for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_31_3 then
							if arg_28_1.isInRecall_ then
								iter_31_3.color = Color.New(Mathf.Lerp(iter_31_3.color.r, arg_28_1.hightColor1.r, (arg_28_1.time_ - 0) / var_31_3), Mathf.Lerp(iter_31_3.color.g, arg_28_1.hightColor1.g, (arg_28_1.time_ - 0) / var_31_3), (Mathf.Lerp(iter_31_3.color.b, arg_28_1.hightColor1.b, (arg_28_1.time_ - 0) / var_31_3)))
							else
								local var_31_4 = Mathf.Lerp(iter_31_3.color.r, 1, (arg_28_1.time_ - 0) / var_31_3)

								iter_31_3.color = Color.New(var_31_4, var_31_4, var_31_4)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps10144 then
				for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_31_5 then
						iter_31_5.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps10144 = nil
			end

			local var_31_5 = arg_28_1.actors_["128404"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.actorSpriteComps128404 == nil then
				arg_28_1.var_.actorSpriteComps128404 = var_31_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_6 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.actorSpriteComps128404 then
					for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_31_7 then
							if arg_28_1.isInRecall_ then
								iter_31_7.color = Color.New(Mathf.Lerp(iter_31_7.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_6), Mathf.Lerp(iter_31_7.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_6), (Mathf.Lerp(iter_31_7.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_6)))
							else
								local var_31_7 = Mathf.Lerp(iter_31_7.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_6)

								iter_31_7.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.actorSpriteComps128404 then
				for iter_31_8, iter_31_9 in pairs(arg_28_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_31_9 then
						iter_31_9.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps128404 = nil
			end

			local var_31_8 = arg_28_1.actors_["10144"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10144 = var_31_8.localPosition
				var_31_8.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10144", 3)

				for iter_31_10 = 0, var_31_8.childCount - 1 do
					local var_31_9 = var_31_8:GetChild(iter_31_10)

					if var_31_9.name == "split_11" or not string.find(var_31_9.name, "split") then
						var_31_9.gameObject:SetActive(true)
					else
						var_31_9.gameObject:SetActive(false)
					end
				end
			end

			local var_31_10 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_10 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_28_1.time_ - 0) / var_31_10)
			end

			if arg_28_1.time_ >= 0 + var_31_10 and arg_28_1.time_ < 0 + var_31_10 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_31_11 = arg_28_1.actors_["128404"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos128404 = var_31_11.localPosition
				var_31_11.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("128404", 7)

				for iter_31_11 = 0, var_31_11.childCount - 1 do
					local var_31_12 = var_31_11:GetChild(iter_31_11)

					if var_31_12.name == "" or not string.find(var_31_12.name, "split") then
						var_31_12.gameObject:SetActive(true)
					else
						var_31_12.gameObject:SetActive(false)
					end
				end
			end

			local var_31_13 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_13 then
				var_31_11.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_28_1.time_ - 0) / var_31_13)
			end

			if arg_28_1.time_ >= 0 + var_31_13 and arg_28_1.time_ < 0 + var_31_13 + arg_31_0 then
				var_31_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_14 = arg_28_1.actors_["10183"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10183 = var_31_14.localPosition
				var_31_14.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10183", 7)

				for iter_31_12 = 0, var_31_14.childCount - 1 do
					local var_31_15 = var_31_14:GetChild(iter_31_12)

					if var_31_15.name == "" or not string.find(var_31_15.name, "split") then
						var_31_15.gameObject:SetActive(true)
					else
						var_31_15.gameObject:SetActive(false)
					end
				end
			end

			local var_31_16 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_16 then
				var_31_14.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_28_1.time_ - 0) / var_31_16)
			end

			if arg_28_1.time_ >= 0 + var_31_16 and arg_28_1.time_ < 0 + var_31_16 + arg_31_0 then
				var_31_14.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_17 = 0
			local var_31_18 = 0.8

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_19 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(938072007).content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 32 <= 0 and var_31_18 or var_31_18 * (utf8.len(var_31_19) / 32)

				if (32 <= 0 and var_31_18 or var_31_18 * (utf8.len(var_31_19) / 32)) > 0 and var_31_18 < var_31_21 then
					arg_28_1.talkMaxDuration = var_31_21

					if var_31_21 + var_31_17 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_21 + var_31_17
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_18, arg_28_1.talkMaxDuration)

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_17) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_17 + var_31_22 and arg_28_1.time_ < var_31_17 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938072008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938072008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938072009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10144"]) and arg_32_1.var_.actorSpriteComps10144 == nil then
				arg_32_1.var_.actorSpriteComps10144 = arg_32_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10144"]) then
				if arg_32_1.var_.actorSpriteComps10144 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 0.5, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10144"]) and arg_32_1.var_.actorSpriteComps10144 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps10144 = nil
			end

			local var_35_2 = 0
			local var_35_3 = 0.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_4 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(938072008).content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 10 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 10)

				if (10 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_4) / 10)) > 0 and var_35_3 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_7 and arg_32_1.time_ < var_35_2 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play938072009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938072009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938072010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10144 = arg_36_1.actors_["10144"].transform.localPosition
				arg_36_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10144", 7)

				for iter_39_0 = 0, arg_36_1.actors_["10144"].transform.childCount - 1 do
					local var_39_0 = arg_36_1.actors_["10144"].transform:GetChild(iter_39_0)

					if var_39_0.name == "" or not string.find(var_39_0.name, "split") then
						var_39_0.gameObject:SetActive(true)
					else
						var_39_0.gameObject:SetActive(false)
					end
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_1)
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_2 = 0
			local var_39_3 = 0.7

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(938072009).content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 28 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 28)

				if (28 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 28)) > 0 and var_39_3 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_7 and arg_36_1.time_ < var_39_2 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play938072010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938072010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938072011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10144"]) and arg_40_1.var_.actorSpriteComps10144 == nil then
				arg_40_1.var_.actorSpriteComps10144 = arg_40_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10144"]) then
				if arg_40_1.var_.actorSpriteComps10144 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								iter_43_1.color = Color.New(Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, (arg_40_1.time_ - 0) / var_43_0), Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, (arg_40_1.time_ - 0) / var_43_0), (Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, (arg_40_1.time_ - 0) / var_43_0)))
							else
								local var_43_1 = Mathf.Lerp(iter_43_1.color.r, 1, (arg_40_1.time_ - 0) / var_43_0)

								iter_43_1.color = Color.New(var_43_1, var_43_1, var_43_1)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10144"]) and arg_40_1.var_.actorSpriteComps10144 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps10144 = nil
			end

			local var_43_2 = arg_40_1.actors_["10144"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10144 = var_43_2.localPosition
				var_43_2.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10144", 3)

				for iter_43_4 = 0, var_43_2.childCount - 1 do
					local var_43_3 = var_43_2:GetChild(iter_43_4)

					if var_43_3.name == "split_11" or not string.find(var_43_3.name, "split") then
						var_43_3.gameObject:SetActive(true)
					else
						var_43_3.gameObject:SetActive(false)
					end
				end
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_40_1.time_ - 0) / var_43_4)
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_43_5 = 0
			local var_43_6 = 0.525

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(938072010).content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 21 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 21)

				if (21 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 21)) > 0 and var_43_6 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_10 and arg_40_1.time_ < var_43_5 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play938072011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938072011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938072012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(938072011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)

				if (28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play938072012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938072012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938072013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_9000

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10144"]) and arg_48_1.var_.actorSpriteComps10144 == nil then
				arg_48_1.var_.actorSpriteComps10144 = arg_48_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10144"]) then
				if arg_48_1.var_.actorSpriteComps10144 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10144"]) and arg_48_1.var_.actorSpriteComps10144 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps10144 = nil
			end

			local var_51_2 = arg_48_1.actors_["10144"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10144 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10144", 7)

				for iter_51_4 = 0, var_51_2.childCount - 1 do
					local var_51_3 = var_51_2:GetChild(iter_51_4)

					if var_51_3.name == "" or not string.find(var_51_3.name, "split") then
						var_51_3.gameObject:SetActive(true)
					else
						var_51_3.gameObject:SetActive(false)
					end
				end
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				local var_51_5 = arg_48_1.var_.effectsuipianguangmang1

				if not arg_48_1.var_.effectsuipianguangmang1 then
					var_51_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dataflow"), manager.ui.mainCamera.transform)
					var_51_5.name = "suipianguangmang1"
					arg_48_1.var_.effectsuipianguangmang1 = var_51_5
				else
					var_51_5.transform:SetParent(var_51_9000)
				end

				var_51_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_51_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_51_7 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			if arg_48_1.time_ >= var_51_7 + 1.6 and arg_48_1.time_ < var_51_7 + 1.6 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_8 = 0
			local var_51_9 = 0.8

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(938072012).content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_12 = 32 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 32)

				if (32 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 32)) > 0 and var_51_9 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_13 and arg_48_1.time_ < var_51_8 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play938072013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938072013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938072014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_55_0 = 0.6

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				local var_55_1, var_55_2 = math.modf((arg_52_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_55_2 * 0.13, var_55_2 * 0.13, var_55_2 * 0.13) + arg_52_1.var_.shakeOldPos
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				manager.ui.mainCamera.transform.localPosition = arg_52_1.var_.shakeOldPos
			end

			local var_55_3 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_3 + 0.6 and arg_52_1.time_ < var_55_3 + 0.6 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_4 = 0
			local var_55_5 = 0.125

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_6 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(938072013).content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 5 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_6) / 5)

				if (5 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_6) / 5)) > 0 and var_55_5 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_9 and arg_52_1.time_ < var_55_4 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play938072014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938072014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938072015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if arg_56_1.actors_["106603"] == nil then
				local var_59_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_59_0) then
					local var_59_1 = Object.Instantiate(var_59_0, arg_56_1.canvasGo_.transform)

					var_59_1.transform:SetSiblingIndex(1)

					var_59_1.name = "106603"
					var_59_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_56_1.actors_["106603"] = var_59_1

					if arg_56_1.isInRecall_ then
						for iter_59_0, iter_59_1 in ipairs((var_59_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_59_1.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_59_2 = arg_56_1.actors_["106603"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps106603 == nil then
				arg_56_1.var_.actorSpriteComps106603 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps106603 then
					for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_59_3 then
							if arg_56_1.isInRecall_ then
								iter_59_3.color = Color.New(Mathf.Lerp(iter_59_3.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_3), Mathf.Lerp(iter_59_3.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_3), (Mathf.Lerp(iter_59_3.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_3)))
							else
								local var_59_4 = Mathf.Lerp(iter_59_3.color.r, 1, (arg_56_1.time_ - 0) / var_59_3)

								iter_59_3.color = Color.New(var_59_4, var_59_4, var_59_4)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps106603 then
				for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_59_5 then
						iter_59_5.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps106603 = nil
			end

			local var_59_5 = arg_56_1.actors_["106603"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos106603 = var_59_5.localPosition
				var_59_5.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("106603", 2)

				for iter_59_6 = 0, var_59_5.childCount - 1 do
					local var_59_6 = var_59_5:GetChild(iter_59_6)

					if var_59_6.name == "split_12" or not string.find(var_59_6.name, "split") then
						var_59_6.gameObject:SetActive(true)
					else
						var_59_6.gameObject:SetActive(false)
					end
				end
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_56_1.time_ - 0) / var_59_7)
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_59_8 = 0
			local var_59_9 = 0.225

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(938072014).content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 9 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_10) / 9)

				if (9 <= 0 and var_59_9 or var_59_9 * (utf8.len(var_59_10) / 9)) > 0 and var_59_9 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12

					if var_59_12 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_13 and arg_56_1.time_ < var_59_8 + var_59_13 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play938072015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938072015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938072016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["104902"] == nil then
				local var_63_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_63_0) then
					local var_63_1 = Object.Instantiate(var_63_0, arg_60_1.canvasGo_.transform)

					var_63_1.transform:SetSiblingIndex(1)

					var_63_1.name = "104902"
					var_63_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_60_1.actors_["104902"] = var_63_1

					if arg_60_1.isInRecall_ then
						for iter_63_0, iter_63_1 in ipairs((var_63_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_63_1.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_63_2 = arg_60_1.actors_["104902"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps104902 == nil then
				arg_60_1.var_.actorSpriteComps104902 = var_63_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_3 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.actorSpriteComps104902 then
					for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_63_3 then
							if arg_60_1.isInRecall_ then
								iter_63_3.color = Color.New(Mathf.Lerp(iter_63_3.color.r, arg_60_1.hightColor1.r, (arg_60_1.time_ - 0) / var_63_3), Mathf.Lerp(iter_63_3.color.g, arg_60_1.hightColor1.g, (arg_60_1.time_ - 0) / var_63_3), (Mathf.Lerp(iter_63_3.color.b, arg_60_1.hightColor1.b, (arg_60_1.time_ - 0) / var_63_3)))
							else
								local var_63_4 = Mathf.Lerp(iter_63_3.color.r, 1, (arg_60_1.time_ - 0) / var_63_3)

								iter_63_3.color = Color.New(var_63_4, var_63_4, var_63_4)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.actorSpriteComps104902 then
				for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_63_5 then
						iter_63_5.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps104902 = nil
			end

			local var_63_5 = arg_60_1.actors_["106603"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.actorSpriteComps106603 == nil then
				arg_60_1.var_.actorSpriteComps106603 = var_63_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_6 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 and not isNil(var_63_5) then
				if arg_60_1.var_.actorSpriteComps106603 then
					for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_63_7 then
							if arg_60_1.isInRecall_ then
								iter_63_7.color = Color.New(Mathf.Lerp(iter_63_7.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_6), Mathf.Lerp(iter_63_7.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_6), (Mathf.Lerp(iter_63_7.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_6)))
							else
								local var_63_7 = Mathf.Lerp(iter_63_7.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_6)

								iter_63_7.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.actorSpriteComps106603 then
				for iter_63_8, iter_63_9 in pairs(arg_60_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_63_9 then
						iter_63_9.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps106603 = nil
			end

			local var_63_8 = arg_60_1.actors_["104902"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos104902 = var_63_8.localPosition
				var_63_8.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("104902", 4)

				for iter_63_10 = 0, var_63_8.childCount - 1 do
					local var_63_9 = var_63_8:GetChild(iter_63_10)

					if var_63_9.name == "split_6" or not string.find(var_63_9.name, "split") then
						var_63_9.gameObject:SetActive(true)
					else
						var_63_9.gameObject:SetActive(false)
					end
				end
			end

			local var_63_10 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_10 then
				var_63_8.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_60_1.time_ - 0) / var_63_10)
			end

			if arg_60_1.time_ >= 0 + var_63_10 and arg_60_1.time_ < 0 + var_63_10 + arg_63_0 then
				var_63_8.localPosition = Vector3.New(390, -335, -360)
			end

			local var_63_11 = 0
			local var_63_12 = 0.225

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_13 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(938072015).content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 9 <= 0 and var_63_12 or var_63_12 * (utf8.len(var_63_13) / 9)

				if (9 <= 0 and var_63_12 or var_63_12 * (utf8.len(var_63_13) / 9)) > 0 and var_63_12 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_16 and arg_60_1.time_ < var_63_11 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play938072016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938072016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938072017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["104902"]) and arg_64_1.var_.actorSpriteComps104902 == nil then
				arg_64_1.var_.actorSpriteComps104902 = arg_64_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["104902"]) then
				if arg_64_1.var_.actorSpriteComps104902 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["104902"]) and arg_64_1.var_.actorSpriteComps104902 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps104902 = nil
			end

			local var_67_2 = arg_64_1.actors_["104902"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos104902 = var_67_2.localPosition
				var_67_2.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("104902", 7)

				for iter_67_4 = 0, var_67_2.childCount - 1 do
					local var_67_3 = var_67_2:GetChild(iter_67_4)

					if var_67_3.name == "" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_2.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_64_1.time_ - 0) / var_67_4)
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_2.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_67_5 = arg_64_1.actors_["106603"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos106603 = var_67_5.localPosition
				var_67_5.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("106603", 7)

				for iter_67_5 = 0, var_67_5.childCount - 1 do
					local var_67_6 = var_67_5:GetChild(iter_67_5)

					if var_67_6.name == "" or not string.find(var_67_6.name, "split") then
						var_67_6.gameObject:SetActive(true)
					else
						var_67_6.gameObject:SetActive(false)
					end
				end
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_64_1.time_ - 0) / var_67_7)
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_67_8 = 0
			local var_67_9 = 0.775

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_10 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(938072016).content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_12 = 31 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_10) / 31)

				if (31 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_10) / 31)) > 0 and var_67_9 < var_67_12 then
					arg_64_1.talkMaxDuration = var_67_12

					if var_67_12 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_13 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_13 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_8) / var_67_13

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_8 + var_67_13 and arg_64_1.time_ < var_67_8 + var_67_13 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play938072017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938072017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938072018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10144"]) and arg_68_1.var_.actorSpriteComps10144 == nil then
				arg_68_1.var_.actorSpriteComps10144 = arg_68_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10144"]) then
				if arg_68_1.var_.actorSpriteComps10144 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 1, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10144"]) and arg_68_1.var_.actorSpriteComps10144 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps10144 = nil
			end

			local var_71_2 = arg_68_1.actors_["10144"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10144 = var_71_2.localPosition
				var_71_2.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10144", 2)

				for iter_71_4 = 0, var_71_2.childCount - 1 do
					local var_71_3 = var_71_2:GetChild(iter_71_4)

					if var_71_3.name == "split_12" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_68_1.time_ - 0) / var_71_4)
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_71_5 = 0
			local var_71_6 = 0.65

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_7 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(938072017).content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 26 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 26)

				if (26 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 26)) > 0 and var_71_6 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_10 and arg_68_1.time_ < var_71_5 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play938072018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938072018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938072019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["108301"] == nil then
				local var_75_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_75_0) then
					local var_75_1 = Object.Instantiate(var_75_0, arg_72_1.canvasGo_.transform)

					var_75_1.transform:SetSiblingIndex(1)

					var_75_1.name = "108301"
					var_75_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_72_1.actors_["108301"] = var_75_1

					if arg_72_1.isInRecall_ then
						for iter_75_0, iter_75_1 in ipairs((var_75_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_75_1.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_75_2 = arg_72_1.actors_["108301"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps108301 == nil then
				arg_72_1.var_.actorSpriteComps108301 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps108301 then
					for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_75_3 then
							if arg_72_1.isInRecall_ then
								iter_75_3.color = Color.New(Mathf.Lerp(iter_75_3.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_3.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_3.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_3.color.r, 1, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_3.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps108301 then
				for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_75_5 then
						iter_75_5.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps108301 = nil
			end

			local var_75_5 = arg_72_1.actors_["10144"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.actorSpriteComps10144 == nil then
				arg_72_1.var_.actorSpriteComps10144 = var_75_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_6 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.actorSpriteComps10144 then
					for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_75_7 then
							if arg_72_1.isInRecall_ then
								iter_75_7.color = Color.New(Mathf.Lerp(iter_75_7.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_6), Mathf.Lerp(iter_75_7.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_6), (Mathf.Lerp(iter_75_7.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_6)))
							else
								local var_75_7 = Mathf.Lerp(iter_75_7.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_6)

								iter_75_7.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.actorSpriteComps10144 then
				for iter_75_8, iter_75_9 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_75_9 then
						iter_75_9.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps10144 = nil
			end

			local var_75_8 = arg_72_1.actors_["108301"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos108301 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("108301", 4)

				for iter_75_10 = 0, var_75_8.childCount - 1 do
					local var_75_9 = var_75_8:GetChild(iter_75_10)

					if var_75_9.name == "split_6" or not string.find(var_75_9.name, "split") then
						var_75_9.gameObject:SetActive(true)
					else
						var_75_9.gameObject:SetActive(false)
					end
				end
			end

			local var_75_10 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_10 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_72_1.time_ - 0) / var_75_10)
			end

			if arg_72_1.time_ >= 0 + var_75_10 and arg_72_1.time_ < 0 + var_75_10 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(460, -360, -195)
			end

			local var_75_11 = 0
			local var_75_12 = 0.9

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_13 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(938072018).content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_15 = 36 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_13) / 36)

				if (36 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_13) / 36)) > 0 and var_75_12 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_11
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_12, arg_72_1.talkMaxDuration)

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_11) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_11 + var_75_16 and arg_72_1.time_ < var_75_11 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938072019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 938072019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play938072020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10144"]) and arg_76_1.var_.actorSpriteComps10144 == nil then
				arg_76_1.var_.actorSpriteComps10144 = arg_76_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10144"]) then
				if arg_76_1.var_.actorSpriteComps10144 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 1, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10144"]) and arg_76_1.var_.actorSpriteComps10144 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps10144 = nil
			end

			local var_79_2 = arg_76_1.actors_["108301"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps108301 == nil then
				arg_76_1.var_.actorSpriteComps108301 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps108301 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps108301 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps108301 = nil
			end

			local var_79_5 = arg_76_1.actors_["10144"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10144 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10144", 2)

				for iter_79_8 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_8)

					if var_79_6.name == "split_11" then
						var_79_6:SetAsLastSibling()
						var_79_6.gameObject:SetActive(true)

						arg_76_1.var_.actorSpriteSplit10144 = var_79_6.gameObject:GetComponent(typeof(Image))

						arg_76_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_79_7 = 0.5

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_76_1.time_ - 0) / var_79_7)

				if arg_76_1.var_.actorSpriteSplit10144 ~= nil then
					arg_76_1.var_.actorSpriteSplit10144:SetAlpha((arg_76_1.time_ - 0) / var_79_7)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_76_1.var_.actorSpriteSplit10144 ~= nil then
					arg_76_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_79_8 = 0
			local var_79_9 = 0.425

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(938072019).content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 17 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 17)

				if (17 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 17)) > 0 and var_79_9 < var_79_12 then
					arg_76_1.talkMaxDuration = var_79_12

					if var_79_12 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_13 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_13 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_13

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_13 and arg_76_1.time_ < var_79_8 + var_79_13 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play938072020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 938072020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play938072021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["106603"]) and arg_80_1.var_.actorSpriteComps106603 == nil then
				arg_80_1.var_.actorSpriteComps106603 = arg_80_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["106603"]) then
				if arg_80_1.var_.actorSpriteComps106603 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["106603"]) and arg_80_1.var_.actorSpriteComps106603 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps106603 = nil
			end

			local var_83_2 = arg_80_1.actors_["10144"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps10144 == nil then
				arg_80_1.var_.actorSpriteComps10144 = var_83_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_3 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.actorSpriteComps10144 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								iter_83_5.color = Color.New(Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, (arg_80_1.time_ - 0) / var_83_3), Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, (arg_80_1.time_ - 0) / var_83_3), (Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, (arg_80_1.time_ - 0) / var_83_3)))
							else
								local var_83_4 = Mathf.Lerp(iter_83_5.color.r, 0.5, (arg_80_1.time_ - 0) / var_83_3)

								iter_83_5.color = Color.New(var_83_4, var_83_4, var_83_4)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps10144 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_83_7 then
						iter_83_7.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_80_1.var_.actorSpriteComps10144 = nil
			end

			local var_83_5 = arg_80_1.actors_["106603"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos106603 = var_83_5.localPosition
				var_83_5.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("106603", 4)

				for iter_83_8 = 0, var_83_5.childCount - 1 do
					local var_83_6 = var_83_5:GetChild(iter_83_8)

					if var_83_6.name == "split_12" or not string.find(var_83_6.name, "split") then
						var_83_6.gameObject:SetActive(true)
					else
						var_83_6.gameObject:SetActive(false)
					end
				end
			end

			local var_83_7 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_80_1.time_ - 0) / var_83_7)
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_83_8 = arg_80_1.actors_["108301"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos108301 = var_83_8.localPosition
				var_83_8.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("108301", 7)

				for iter_83_9 = 0, var_83_8.childCount - 1 do
					local var_83_9 = var_83_8:GetChild(iter_83_9)

					if var_83_9.name == "split_7" or not string.find(var_83_9.name, "split") then
						var_83_9.gameObject:SetActive(true)
					else
						var_83_9.gameObject:SetActive(false)
					end
				end
			end

			local var_83_10 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_10 then
				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_80_1.time_ - 0) / var_83_10)
			end

			if arg_80_1.time_ >= 0 + var_83_10 and arg_80_1.time_ < 0 + var_83_10 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_83_11 = 0
			local var_83_12 = 0.075

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(938072020).content)

				arg_80_1.text_.text = var_83_13

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 3 <= 0 and var_83_12 or var_83_12 * (utf8.len(var_83_13) / 3)

				if (3 <= 0 and var_83_12 or var_83_12 * (utf8.len(var_83_13) / 3)) > 0 and var_83_12 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_13
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_16 and arg_80_1.time_ < var_83_11 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play938072021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 938072021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play938072022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10144"]) and arg_84_1.var_.actorSpriteComps10144 == nil then
				arg_84_1.var_.actorSpriteComps10144 = arg_84_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10144"]) then
				if arg_84_1.var_.actorSpriteComps10144 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 1, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10144"]) and arg_84_1.var_.actorSpriteComps10144 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps10144 = nil
			end

			local var_87_2 = arg_84_1.actors_["106603"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps106603 == nil then
				arg_84_1.var_.actorSpriteComps106603 = var_87_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_3 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.actorSpriteComps106603 then
					for iter_87_4, iter_87_5 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_87_5 then
							if arg_84_1.isInRecall_ then
								iter_87_5.color = Color.New(Mathf.Lerp(iter_87_5.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_3), Mathf.Lerp(iter_87_5.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_3), (Mathf.Lerp(iter_87_5.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_3)))
							else
								local var_87_4 = Mathf.Lerp(iter_87_5.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_3)

								iter_87_5.color = Color.New(var_87_4, var_87_4, var_87_4)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps106603 then
				for iter_87_6, iter_87_7 in pairs(arg_84_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_87_7 then
						iter_87_7.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps106603 = nil
			end

			local var_87_5 = arg_84_1.actors_["10144"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10144 = var_87_5.localPosition
				var_87_5.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10144", 2)

				for iter_87_8 = 0, var_87_5.childCount - 1 do
					local var_87_6 = var_87_5:GetChild(iter_87_8)

					if var_87_6.name == "split_11" or not string.find(var_87_6.name, "split") then
						var_87_6.gameObject:SetActive(true)
					else
						var_87_6.gameObject:SetActive(false)
					end
				end
			end

			local var_87_7 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_84_1.time_ - 0) / var_87_7)
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_87_8 = 0
			local var_87_9 = 1.175

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(938072021).content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_12 = 47 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_10) / 47)

				if (47 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_10) / 47)) > 0 and var_87_9 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_13 and arg_84_1.time_ < var_87_8 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play938072022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 938072022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play938072023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(938072022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 50)

				if (50 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 50)) > 0 and var_91_0 < var_91_3 then
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
	Play938072023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 938072023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play938072024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 1.625

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(938072023).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 65 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 65)

				if (65 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 65)) > 0 and var_95_0 < var_95_3 then
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
	Play938072024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 938072024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play938072025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10144"]) and arg_96_1.var_.actorSpriteComps10144 == nil then
				arg_96_1.var_.actorSpriteComps10144 = arg_96_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10144"]) then
				if arg_96_1.var_.actorSpriteComps10144 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10144"]) and arg_96_1.var_.actorSpriteComps10144 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps10144 = nil
			end

			local var_99_2 = 0
			local var_99_3 = 0.7

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(938072024).content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 28 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 28)

				if (28 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 28)) > 0 and var_99_3 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_7 and arg_96_1.time_ < var_99_2 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play938072025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 938072025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play938072026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["106603"]) and arg_100_1.var_.actorSpriteComps106603 == nil then
				arg_100_1.var_.actorSpriteComps106603 = arg_100_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["106603"]) then
				if arg_100_1.var_.actorSpriteComps106603 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["106603"]) and arg_100_1.var_.actorSpriteComps106603 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps106603 = nil
			end

			local var_103_2 = arg_100_1.actors_["106603"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos106603 = var_103_2.localPosition
				var_103_2.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("106603", 4)

				for iter_103_4 = 0, var_103_2.childCount - 1 do
					local var_103_3 = var_103_2:GetChild(iter_103_4)

					if var_103_3.name == "split_12" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_100_1.time_ - 0) / var_103_4)
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_103_5 = 0
			local var_103_6 = 0.825

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(938072025).content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 33 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 33)

				if (33 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_7) / 33)) > 0 and var_103_6 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_10 and arg_100_1.time_ < var_103_5 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play938072026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 938072026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play938072027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10144"]) and arg_104_1.var_.actorSpriteComps10144 == nil then
				arg_104_1.var_.actorSpriteComps10144 = arg_104_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10144"]) then
				if arg_104_1.var_.actorSpriteComps10144 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 1, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10144"]) and arg_104_1.var_.actorSpriteComps10144 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps10144 = nil
			end

			local var_107_2 = arg_104_1.actors_["106603"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps106603 == nil then
				arg_104_1.var_.actorSpriteComps106603 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps106603 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_5.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_5.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps106603 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps106603 = nil
			end

			local var_107_5 = arg_104_1.actors_["10144"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10144 = var_107_5.localPosition
				var_107_5.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10144", 2)

				for iter_107_8 = 0, var_107_5.childCount - 1 do
					local var_107_6 = var_107_5:GetChild(iter_107_8)

					if var_107_6.name == "split_12" or not string.find(var_107_6.name, "split") then
						var_107_6.gameObject:SetActive(true)
					else
						var_107_6.gameObject:SetActive(false)
					end
				end
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_104_1.time_ - 0) / var_107_7)
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_107_8 = 0
			local var_107_9 = 0.475

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(938072026).content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_12 = 19 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_10) / 19)

				if (19 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_10) / 19)) > 0 and var_107_9 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_13 and arg_104_1.time_ < var_107_8 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play938072027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 938072027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play938072028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["104902"]) and arg_108_1.var_.actorSpriteComps104902 == nil then
				arg_108_1.var_.actorSpriteComps104902 = arg_108_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["104902"]) then
				if arg_108_1.var_.actorSpriteComps104902 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["104902"]) and arg_108_1.var_.actorSpriteComps104902 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps104902 = nil
			end

			local var_111_2 = arg_108_1.actors_["10144"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10144 == nil then
				arg_108_1.var_.actorSpriteComps10144 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps10144 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								iter_111_5.color = Color.New(Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_5.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_5.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10144 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_111_7 then
						iter_111_7.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps10144 = nil
			end

			local var_111_5 = arg_108_1.actors_["104902"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos104902 = var_111_5.localPosition
				var_111_5.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("104902", 2)

				for iter_111_8 = 0, var_111_5.childCount - 1 do
					local var_111_6 = var_111_5:GetChild(iter_111_8)

					if var_111_6.name == "split_6" or not string.find(var_111_6.name, "split") then
						var_111_6.gameObject:SetActive(true)
					else
						var_111_6.gameObject:SetActive(false)
					end
				end
			end

			local var_111_7 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				var_111_5.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_108_1.time_ - 0) / var_111_7)
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				var_111_5.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_111_8 = arg_108_1.actors_["10144"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10144 = var_111_8.localPosition
				var_111_8.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("10144", 7)

				for iter_111_9 = 0, var_111_8.childCount - 1 do
					local var_111_9 = var_111_8:GetChild(iter_111_9)

					if var_111_9.name == "" or not string.find(var_111_9.name, "split") then
						var_111_9.gameObject:SetActive(true)
					else
						var_111_9.gameObject:SetActive(false)
					end
				end
			end

			local var_111_10 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_10 then
				var_111_8.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_108_1.time_ - 0) / var_111_10)
			end

			if arg_108_1.time_ >= 0 + var_111_10 and arg_108_1.time_ < 0 + var_111_10 + arg_111_0 then
				var_111_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_111_11 = 0
			local var_111_12 = 0.525

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_13 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(938072027).content)

				arg_108_1.text_.text = var_111_13

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_15 = 21 <= 0 and var_111_12 or var_111_12 * (utf8.len(var_111_13) / 21)

				if (21 <= 0 and var_111_12 or var_111_12 * (utf8.len(var_111_13) / 21)) > 0 and var_111_12 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_13
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_16 and arg_108_1.time_ < var_111_11 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play938072028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 938072028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play938072029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10144"]) and arg_112_1.var_.actorSpriteComps10144 == nil then
				arg_112_1.var_.actorSpriteComps10144 = arg_112_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10144"]) then
				if arg_112_1.var_.actorSpriteComps10144 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10144"]) and arg_112_1.var_.actorSpriteComps10144 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps10144 = nil
			end

			local var_115_2 = arg_112_1.actors_["104902"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps104902 == nil then
				arg_112_1.var_.actorSpriteComps104902 = var_115_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_3 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.actorSpriteComps104902 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								iter_115_5.color = Color.New(Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_3), Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_3), (Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_3)))
							else
								local var_115_4 = Mathf.Lerp(iter_115_5.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_3)

								iter_115_5.color = Color.New(var_115_4, var_115_4, var_115_4)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps104902 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_115_7 then
						iter_115_7.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps104902 = nil
			end

			local var_115_5 = arg_112_1.actors_["10144"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos10144 = var_115_5.localPosition
				var_115_5.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10144", 2)

				for iter_115_8 = 0, var_115_5.childCount - 1 do
					local var_115_6 = var_115_5:GetChild(iter_115_8)

					if var_115_6.name == "split_11" or not string.find(var_115_6.name, "split") then
						var_115_6.gameObject:SetActive(true)
					else
						var_115_6.gameObject:SetActive(false)
					end
				end
			end

			local var_115_7 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_112_1.time_ - 0) / var_115_7)
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_115_8 = 0
			local var_115_9 = 0.4

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(938072028).content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 16 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_10) / 16)

				if (16 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_10) / 16)) > 0 and var_115_9 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_13 and arg_112_1.time_ < var_115_8 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play938072029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 938072029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play938072030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["108301"]) and arg_116_1.var_.actorSpriteComps108301 == nil then
				arg_116_1.var_.actorSpriteComps108301 = arg_116_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["108301"]) then
				if arg_116_1.var_.actorSpriteComps108301 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["108301"]) and arg_116_1.var_.actorSpriteComps108301 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps108301 = nil
			end

			local var_119_2 = arg_116_1.actors_["10144"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10144 == nil then
				arg_116_1.var_.actorSpriteComps10144 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps10144 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_3), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_3), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_3)))
							else
								local var_119_4 = Mathf.Lerp(iter_119_5.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_3)

								iter_119_5.color = Color.New(var_119_4, var_119_4, var_119_4)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10144 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps10144 = nil
			end

			local var_119_5 = arg_116_1.actors_["108301"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos108301 = var_119_5.localPosition
				var_119_5.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("108301", 4)

				for iter_119_8 = 0, var_119_5.childCount - 1 do
					local var_119_6 = var_119_5:GetChild(iter_119_8)

					if var_119_6.name == "split_6" or not string.find(var_119_6.name, "split") then
						var_119_6.gameObject:SetActive(true)
					else
						var_119_6.gameObject:SetActive(false)
					end
				end
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_116_1.time_ - 0) / var_119_7)
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_119_8 = arg_116_1.actors_["106603"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos106603 = var_119_8.localPosition
				var_119_8.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("106603", 7)

				for iter_119_9 = 0, var_119_8.childCount - 1 do
					local var_119_9 = var_119_8:GetChild(iter_119_9)

					if var_119_9.name == "split_12" or not string.find(var_119_9.name, "split") then
						var_119_9.gameObject:SetActive(true)
					else
						var_119_9.gameObject:SetActive(false)
					end
				end
			end

			local var_119_10 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_10 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0) / var_119_10)
			end

			if arg_116_1.time_ >= 0 + var_119_10 and arg_116_1.time_ < 0 + var_119_10 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_11 = 0
			local var_119_12 = 0.525

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_13 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(938072029).content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 21 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 21)

				if (21 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 21)) > 0 and var_119_12 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_16 and arg_116_1.time_ < var_119_11 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play938072030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 938072030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play938072031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["128404"]) and arg_120_1.var_.actorSpriteComps128404 == nil then
				arg_120_1.var_.actorSpriteComps128404 = arg_120_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["128404"]) then
				if arg_120_1.var_.actorSpriteComps128404 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["128404"]) and arg_120_1.var_.actorSpriteComps128404 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps128404 = nil
			end

			local var_123_2 = arg_120_1.actors_["108301"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps108301 == nil then
				arg_120_1.var_.actorSpriteComps108301 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps108301 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps108301 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps108301 = nil
			end

			local var_123_5 = arg_120_1.actors_["128404"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos128404 = var_123_5.localPosition
				var_123_5.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("128404", 4)

				for iter_123_8 = 0, var_123_5.childCount - 1 do
					local var_123_6 = var_123_5:GetChild(iter_123_8)

					if var_123_6.name == "split_10" or not string.find(var_123_6.name, "split") then
						var_123_6.gameObject:SetActive(true)
					else
						var_123_6.gameObject:SetActive(false)
					end
				end
			end

			local var_123_7 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				var_123_5.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_120_1.time_ - 0) / var_123_7)
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				var_123_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_123_8 = arg_120_1.actors_["108301"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos108301 = var_123_8.localPosition
				var_123_8.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("108301", 7)

				for iter_123_9 = 0, var_123_8.childCount - 1 do
					local var_123_9 = var_123_8:GetChild(iter_123_9)

					if var_123_9.name == "" or not string.find(var_123_9.name, "split") then
						var_123_9.gameObject:SetActive(true)
					else
						var_123_9.gameObject:SetActive(false)
					end
				end
			end

			local var_123_10 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_10 then
				var_123_8.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_120_1.time_ - 0) / var_123_10)
			end

			if arg_120_1.time_ >= 0 + var_123_10 and arg_120_1.time_ < 0 + var_123_10 + arg_123_0 then
				var_123_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_123_11 = 0
			local var_123_12 = 0.65

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_13 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(938072030).content)

				arg_120_1.text_.text = var_123_13

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_15 = 26 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 26)

				if (26 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 26)) > 0 and var_123_12 < var_123_15 then
					arg_120_1.talkMaxDuration = var_123_15

					if var_123_15 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_13
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_16 and arg_120_1.time_ < var_123_11 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play938072031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 938072031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play938072032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10144"]) and arg_124_1.var_.actorSpriteComps10144 == nil then
				arg_124_1.var_.actorSpriteComps10144 = arg_124_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10144"]) then
				if arg_124_1.var_.actorSpriteComps10144 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 1, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10144"]) and arg_124_1.var_.actorSpriteComps10144 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps10144 = nil
			end

			local var_127_2 = arg_124_1.actors_["128404"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps128404 == nil then
				arg_124_1.var_.actorSpriteComps128404 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps128404 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps128404 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps128404 = nil
			end

			local var_127_5 = arg_124_1.actors_["10144"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10144 = var_127_5.localPosition
				var_127_5.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10144", 2)

				for iter_127_8 = 0, var_127_5.childCount - 1 do
					local var_127_6 = var_127_5:GetChild(iter_127_8)

					if var_127_6.name == "split_11" or not string.find(var_127_6.name, "split") then
						var_127_6.gameObject:SetActive(true)
					else
						var_127_6.gameObject:SetActive(false)
					end
				end
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_5.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_124_1.time_ - 0) / var_127_7)
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_127_8 = 0
			local var_127_9 = 0.925

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(938072031).content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_12 = 37 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 37)

				if (37 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 37)) > 0 and var_127_9 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_13 and arg_124_1.time_ < var_127_8 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play938072032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 938072032
		arg_128_1.duration_ = 1

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"

			SetActive(arg_128_1.choicesGo_, true)

			for iter_129_0, iter_129_1 in ipairs(arg_128_1.choices_) do
				SetActive(iter_129_1.go, iter_129_0 <= 1)
			end

			arg_128_1.choices_[1].txt.text = arg_128_1:FormatText(StoryChoiceCfg[1790].name)
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play938072033(arg_128_1)
			end

			arg_128_1:RecordChoiceLog(938072032, 1790)
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10144"]) and arg_128_1.var_.actorSpriteComps10144 == nil then
				arg_128_1.var_.actorSpriteComps10144 = arg_128_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10144"]) then
				if arg_128_1.var_.actorSpriteComps10144 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10144"]) and arg_128_1.var_.actorSpriteComps10144 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps10144 = nil
			end

			local var_131_2 = 0

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			if arg_128_1.time_ >= var_131_2 + 0.6 and arg_128_1.time_ < var_131_2 + 0.6 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play938072033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 938072033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play938072034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10144"]) and arg_132_1.var_.actorSpriteComps10144 == nil then
				arg_132_1.var_.actorSpriteComps10144 = arg_132_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10144"]) then
				if arg_132_1.var_.actorSpriteComps10144 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10144"]) and arg_132_1.var_.actorSpriteComps10144 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps10144 = nil
			end

			local var_135_2 = arg_132_1.actors_["10144"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10144 = var_135_2.localPosition
				var_135_2.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10144", 2)

				for iter_135_4 = 0, var_135_2.childCount - 1 do
					local var_135_3 = var_135_2:GetChild(iter_135_4)

					if var_135_3.name == "split_14" or not string.find(var_135_3.name, "split") then
						var_135_3.gameObject:SetActive(true)
					else
						var_135_3.gameObject:SetActive(false)
					end
				end
			end

			local var_135_4 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				var_135_2.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_132_1.time_ - 0) / var_135_4)
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				var_135_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_135_5 = 0
			local var_135_6 = 0.075

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(938072033).content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 3 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_7) / 3)

				if (3 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_7) / 3)) > 0 and var_135_6 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_10 and arg_132_1.time_ < var_135_5 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play938072034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 938072034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play938072035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10144"]) and arg_136_1.var_.actorSpriteComps10144 == nil then
				arg_136_1.var_.actorSpriteComps10144 = arg_136_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10144"]) then
				if arg_136_1.var_.actorSpriteComps10144 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10144"]) and arg_136_1.var_.actorSpriteComps10144 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps10144 = nil
			end

			local var_139_2 = 0
			local var_139_3 = 1.075

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_4 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(938072034).content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_6 = 43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_4) / 43)

				if (43 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_4) / 43)) > 0 and var_139_3 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_7 and arg_136_1.time_ < var_139_2 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play938072035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 938072035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play938072036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.3

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(938072035).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 52 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 52)

				if (52 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 52)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play938072036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 938072036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play938072037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10183"]) and arg_144_1.var_.actorSpriteComps10183 == nil then
				arg_144_1.var_.actorSpriteComps10183 = arg_144_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10183"]) then
				if arg_144_1.var_.actorSpriteComps10183 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 1, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10183"]) and arg_144_1.var_.actorSpriteComps10183 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps10183 = nil
			end

			local var_147_2 = arg_144_1.actors_["10183"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10183 = var_147_2.localPosition
				var_147_2.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("10183", 4)

				for iter_147_4 = 0, var_147_2.childCount - 1 do
					local var_147_3 = var_147_2:GetChild(iter_147_4)

					if var_147_3.name == "split_9" or not string.find(var_147_3.name, "split") then
						var_147_3.gameObject:SetActive(true)
					else
						var_147_3.gameObject:SetActive(false)
					end
				end
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_2.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10183, Vector3.New(300, -475, -325), (arg_144_1.time_ - 0) / var_147_4)
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_2.localPosition = Vector3.New(300, -475, -325)
			end

			local var_147_5 = 0
			local var_147_6 = 0.925

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(938072036).content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 37 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_7) / 37)

				if (37 <= 0 and var_147_6 or var_147_6 * (utf8.len(var_147_7) / 37)) > 0 and var_147_6 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_5 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_5
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_6, arg_144_1.talkMaxDuration)

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_5) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_5 + var_147_10 and arg_144_1.time_ < var_147_5 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play938072037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 938072037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play938072038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.2

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(938072037).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 8 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 8)

				if (8 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 8)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play938072038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 938072038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play938072039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["10183"]) and arg_152_1.var_.actorSpriteComps10183 == nil then
				arg_152_1.var_.actorSpriteComps10183 = arg_152_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["10183"]) then
				if arg_152_1.var_.actorSpriteComps10183 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 0.5, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["10183"]) and arg_152_1.var_.actorSpriteComps10183 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps10183 = nil
			end

			local var_155_2 = manager.ui.mainCamera.transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.shakeOldPos = var_155_2.localPosition
			end

			local var_155_3 = 0.3

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 then
				local var_155_4, var_155_5 = math.modf((arg_152_1.time_ - 0) / 0.066)

				var_155_2.localPosition = Vector3.New(var_155_5 * 0.13, var_155_5 * 0.13, var_155_5 * 0.13) + arg_152_1.var_.shakeOldPos
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 then
				var_155_2.localPosition = arg_152_1.var_.shakeOldPos
			end

			local var_155_6 = manager.ui.mainCamera.transform

			if 0.466666666666667 < arg_152_1.time_ and arg_152_1.time_ <= 0.466666666666667 + arg_155_0 then
				arg_152_1.var_.shakeOldPos = var_155_6.localPosition
			end

			local var_155_7 = 0.3

			if 0.466666666666667 <= arg_152_1.time_ and arg_152_1.time_ < 0.466666666666667 + var_155_7 then
				local var_155_8, var_155_9 = math.modf((arg_152_1.time_ - 0.466666666666667) / 0.066)

				var_155_6.localPosition = Vector3.New(var_155_9 * 0.13, var_155_9 * 0.13, var_155_9 * 0.13) + arg_152_1.var_.shakeOldPos
			end

			if arg_152_1.time_ >= 0.466666666666667 + var_155_7 and arg_152_1.time_ < 0.466666666666667 + var_155_7 + arg_155_0 then
				var_155_6.localPosition = arg_152_1.var_.shakeOldPos
			end

			local var_155_10 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			if arg_152_1.time_ >= var_155_10 + 0.766666666666667 and arg_152_1.time_ < var_155_10 + 0.766666666666667 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_11 = 0
			local var_155_12 = 0.1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_13 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_13:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1565].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_14 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(938072038).content)

				arg_152_1.text_.text = var_155_14

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_16 = 4 <= 0 and var_155_12 or var_155_12 * (utf8.len(var_155_14) / 4)

				if (4 <= 0 and var_155_12 or var_155_12 * (utf8.len(var_155_14) / 4)) > 0 and var_155_12 < var_155_16 then
					arg_152_1.talkMaxDuration = var_155_16
					var_155_11 = var_155_11 + 0.3

					if var_155_16 + var_155_11 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_11
					end
				end

				arg_152_1.text_.text = var_155_14
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_17 = var_155_11 + 0.3
			local var_155_18 = math.max(var_155_12, arg_152_1.talkMaxDuration)

			if var_155_11 + 0.3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_17 + var_155_18 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_17) / var_155_18

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_17 + var_155_18 and arg_152_1.time_ < var_155_17 + var_155_18 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play938072039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938072039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938072040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_9000

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10183 = arg_158_1.actors_["10183"].transform.localPosition
				arg_158_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10183", 7)

				for iter_161_0 = 0, arg_158_1.actors_["10183"].transform.childCount - 1 do
					local var_161_0 = arg_158_1.actors_["10183"].transform:GetChild(iter_161_0)

					if var_161_0.name == "" or not string.find(var_161_0.name, "split") then
						var_161_0.gameObject:SetActive(true)
					else
						var_161_0.gameObject:SetActive(false)
					end
				end
			end

			local var_161_1 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_1 then
				arg_158_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_158_1.time_ - 0) / var_161_1)
			end

			if arg_158_1.time_ >= 0 + var_161_1 and arg_158_1.time_ < 0 + var_161_1 + arg_161_0 then
				arg_158_1.actors_["10183"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_161_2 = arg_158_1.actors_["10144"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10144 = var_161_2.localPosition
				var_161_2.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10144", 7)

				for iter_161_1 = 0, var_161_2.childCount - 1 do
					local var_161_3 = var_161_2:GetChild(iter_161_1)

					if var_161_3.name == "" or not string.find(var_161_3.name, "split") then
						var_161_3.gameObject:SetActive(true)
					else
						var_161_3.gameObject:SetActive(false)
					end
				end
			end

			local var_161_4 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				var_161_2.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_158_1.time_ - 0) / var_161_4)
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				if arg_158_1.var_.effectsuipianguangmang1 then
					Object.Destroy(arg_158_1.var_.effectsuipianguangmang1)

					arg_158_1.var_.effectsuipianguangmang1 = nil
				end
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				local var_161_6 = arg_158_1.var_.effectsuipianguangmang2

				if not arg_158_1.var_.effectsuipianguangmang2 then
					var_161_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_161_6.name = "suipianguangmang2"
					arg_158_1.var_.effectsuipianguangmang2 = var_161_6
				else
					var_161_6.transform:SetParent(var_161_9000)
				end

				var_161_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_161_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.73333333333333 < arg_158_1.time_ and arg_158_1.time_ <= 1.73333333333333 + arg_161_0 then
				if arg_158_1.var_.effectsuipianguangmang2 then
					Object.Destroy(arg_158_1.var_.effectsuipianguangmang2)

					arg_158_1.var_.effectsuipianguangmang2 = nil
				end
			end

			local var_161_9 = arg_158_1.bgs_.I20f.transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPosI20f = var_161_9.localPosition
			end

			local var_161_10 = 0.233333333333333

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_10 then
				var_161_9.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPosI20f, Vector3.New(0, 1, 9.5), (arg_158_1.time_ - 0) / var_161_10)
			end

			if arg_158_1.time_ >= 0 + var_161_10 and arg_158_1.time_ < 0 + var_161_10 + arg_161_0 then
				var_161_9.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_161_11 = 0

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			if arg_158_1.time_ >= var_161_11 + 1.93333333333333 and arg_158_1.time_ < var_161_11 + 1.93333333333333 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_12 = 0
			local var_161_13 = 0.875

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_12 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_14 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(938072039).content)

				arg_158_1.text_.text = var_161_14

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_16 = 35 <= 0 and var_161_13 or var_161_13 * (utf8.len(var_161_14) / 35)

				if (35 <= 0 and var_161_13 or var_161_13 * (utf8.len(var_161_14) / 35)) > 0 and var_161_13 < var_161_16 then
					arg_158_1.talkMaxDuration = var_161_16

					if var_161_16 + var_161_12 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_16 + var_161_12
					end
				end

				arg_158_1.text_.text = var_161_14
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_17 = math.max(var_161_13, arg_158_1.talkMaxDuration)

			if var_161_12 <= arg_158_1.time_ and arg_158_1.time_ < var_161_12 + var_161_17 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_12) / var_161_17

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_12 + var_161_17 and arg_158_1.time_ < var_161_12 + var_161_17 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "I20f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.233333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play938072040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938072040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938072041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.45

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(938072040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 58 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 58)

				if (58 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 58)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play938072041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938072041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938072042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10183"]) and arg_166_1.var_.actorSpriteComps10183 == nil then
				arg_166_1.var_.actorSpriteComps10183 = arg_166_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10183"]) then
				if arg_166_1.var_.actorSpriteComps10183 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 1, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10183"]) and arg_166_1.var_.actorSpriteComps10183 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps10183 = nil
			end

			local var_169_2 = arg_166_1.actors_["10183"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10183 = var_169_2.localPosition
				var_169_2.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10183", 2)

				for iter_169_4 = 0, var_169_2.childCount - 1 do
					local var_169_3 = var_169_2:GetChild(iter_169_4)

					if var_169_3.name == "split_10" or not string.find(var_169_3.name, "split") then
						var_169_3.gameObject:SetActive(true)
					else
						var_169_3.gameObject:SetActive(false)
					end
				end
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_166_1.time_ - 0) / var_169_4)
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_169_5 = 0
			local var_169_6 = 0.5

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(938072041).content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 20 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 20)

				if (20 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 20)) > 0 and var_169_6 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_10 and arg_166_1.time_ < var_169_5 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play938072042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938072042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938072043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10144"]) and arg_170_1.var_.actorSpriteComps10144 == nil then
				arg_170_1.var_.actorSpriteComps10144 = arg_170_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10144"]) then
				if arg_170_1.var_.actorSpriteComps10144 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10144"]) and arg_170_1.var_.actorSpriteComps10144 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps10144 = nil
			end

			local var_173_2 = arg_170_1.actors_["10183"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps10183 == nil then
				arg_170_1.var_.actorSpriteComps10183 = var_173_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_3 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.actorSpriteComps10183 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								iter_173_5.color = Color.New(Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_3), Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_3), (Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_3)))
							else
								local var_173_4 = Mathf.Lerp(iter_173_5.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_3)

								iter_173_5.color = Color.New(var_173_4, var_173_4, var_173_4)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps10183 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_173_7 then
						iter_173_7.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps10183 = nil
			end

			local var_173_5 = arg_170_1.actors_["10144"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10144 = var_173_5.localPosition
				var_173_5.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10144", 4)

				for iter_173_8 = 0, var_173_5.childCount - 1 do
					local var_173_6 = var_173_5:GetChild(iter_173_8)

					if var_173_6.name == "split_13" or not string.find(var_173_6.name, "split") then
						var_173_6.gameObject:SetActive(true)
					else
						var_173_6.gameObject:SetActive(false)
					end
				end
			end

			local var_173_7 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				var_173_5.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_170_1.time_ - 0) / var_173_7)
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				var_173_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_173_8 = 0
			local var_173_9 = 0.15

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(938072042).content)

				arg_170_1.text_.text = var_173_10

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_12 = 6 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_10) / 6)

				if (6 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_10) / 6)) > 0 and var_173_9 < var_173_12 then
					arg_170_1.talkMaxDuration = var_173_12

					if var_173_12 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_10
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_13 and arg_170_1.time_ < var_173_8 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play938072043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938072043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938072044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10183"]) and arg_174_1.var_.actorSpriteComps10183 == nil then
				arg_174_1.var_.actorSpriteComps10183 = arg_174_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10183"]) then
				if arg_174_1.var_.actorSpriteComps10183 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10183"]) and arg_174_1.var_.actorSpriteComps10183 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps10183 = nil
			end

			local var_177_2 = arg_174_1.actors_["10144"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10144 == nil then
				arg_174_1.var_.actorSpriteComps10144 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps10144 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								iter_177_5.color = Color.New(Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_5.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_5.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps10144 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_177_7 then
						iter_177_7.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps10144 = nil
			end

			local var_177_5 = arg_174_1.actors_["10183"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10183 = var_177_5.localPosition
				var_177_5.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10183", 2)

				for iter_177_8 = 0, var_177_5.childCount - 1 do
					local var_177_6 = var_177_5:GetChild(iter_177_8)

					if var_177_6.name == "split_9" then
						var_177_6:SetAsLastSibling()
						var_177_6.gameObject:SetActive(true)

						arg_174_1.var_.actorSpriteSplit10183 = var_177_6.gameObject:GetComponent(typeof(Image))

						arg_174_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_177_7 = 0.5

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_174_1.time_ - 0) / var_177_7)

				if arg_174_1.var_.actorSpriteSplit10183 ~= nil then
					arg_174_1.var_.actorSpriteSplit10183:SetAlpha((arg_174_1.time_ - 0) / var_177_7)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(-300, -475, -325)

				if arg_174_1.var_.actorSpriteSplit10183 ~= nil then
					arg_174_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_177_8 = 0
			local var_177_9 = 0.675

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(938072043).content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 27 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 27)

				if (27 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 27)) > 0 and var_177_9 < var_177_12 then
					arg_174_1.talkMaxDuration = var_177_12

					if var_177_12 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_13 and arg_174_1.time_ < var_177_8 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play938072044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938072044
		arg_178_1.duration_ = 5.4

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938072045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10183"]) and arg_178_1.var_.actorSpriteComps10183 == nil then
				arg_178_1.var_.actorSpriteComps10183 = arg_178_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10183"]) then
				if arg_178_1.var_.actorSpriteComps10183 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10183"]) and arg_178_1.var_.actorSpriteComps10183 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps10183 = nil
			end

			local var_181_2 = arg_178_1.actors_["10183"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10183 = var_181_2.localPosition
				var_181_2.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10183", 7)

				for iter_181_4 = 0, var_181_2.childCount - 1 do
					local var_181_3 = var_181_2:GetChild(iter_181_4)

					if var_181_3.name == "" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				var_181_2.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 0) / var_181_4)
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				var_181_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_5 = arg_178_1.actors_["10144"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos10144 = var_181_5.localPosition
				var_181_5.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10144", 7)

				for iter_181_5 = 0, var_181_5.childCount - 1 do
					local var_181_6 = var_181_5:GetChild(iter_181_5)

					if var_181_6.name == "" or not string.find(var_181_6.name, "split") then
						var_181_6.gameObject:SetActive(true)
					else
						var_181_6.gameObject:SetActive(false)
					end
				end
			end

			local var_181_7 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_178_1.time_ - 0) / var_181_7)
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_8 = manager.ui.mainCamera.transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.shakeOldPos = var_181_8.localPosition
			end

			local var_181_9 = 0.4

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_9 then
				local var_181_10, var_181_11 = math.modf((arg_178_1.time_ - 0) / 0.066)

				var_181_8.localPosition = Vector3.New(var_181_11 * 0.13, var_181_11 * 0.13, var_181_11 * 0.13) + arg_178_1.var_.shakeOldPos
			end

			if arg_178_1.time_ >= 0 + var_181_9 and arg_178_1.time_ < 0 + var_181_9 + arg_181_0 then
				var_181_8.localPosition = arg_178_1.var_.shakeOldPos
			end

			local var_181_12 = 0

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			if arg_178_1.time_ >= var_181_12 + 0.4 and arg_178_1.time_ < var_181_12 + 0.4 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_13 = 0.4
			local var_181_14 = 0.775

			if 0.4 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_15 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_15:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_16 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(938072044).content)

				arg_178_1.text_.text = var_181_16

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_18 = 31 <= 0 and var_181_14 or var_181_14 * (utf8.len(var_181_16) / 31)

				if (31 <= 0 and var_181_14 or var_181_14 * (utf8.len(var_181_16) / 31)) > 0 and var_181_14 < var_181_18 then
					arg_178_1.talkMaxDuration = var_181_18
					var_181_13 = var_181_13 + 0.3

					if var_181_18 + var_181_13 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_18 + var_181_13
					end
				end

				arg_178_1.text_.text = var_181_16
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_19 = var_181_13 + 0.3
			local var_181_20 = math.max(var_181_14, arg_178_1.talkMaxDuration)

			if var_181_13 + 0.3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_19 + var_181_20 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_19) / var_181_20

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_19 + var_181_20 and arg_178_1.time_ < var_181_19 + var_181_20 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play938072045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 938072045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play938072046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10144"]) and arg_184_1.var_.actorSpriteComps10144 == nil then
				arg_184_1.var_.actorSpriteComps10144 = arg_184_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10144"]) then
				if arg_184_1.var_.actorSpriteComps10144 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 1, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10144"]) and arg_184_1.var_.actorSpriteComps10144 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps10144 = nil
			end

			local var_187_2 = arg_184_1.actors_["10144"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10144 = var_187_2.localPosition
				var_187_2.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10144", 3)

				for iter_187_4 = 0, var_187_2.childCount - 1 do
					local var_187_3 = var_187_2:GetChild(iter_187_4)

					if var_187_3.name == "split_14" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				var_187_2.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_184_1.time_ - 0) / var_187_4)
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				var_187_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_187_5 = 0
			local var_187_6 = 0.3

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(938072045).content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 12 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_7) / 12)

				if (12 <= 0 and var_187_6 or var_187_6 * (utf8.len(var_187_7) / 12)) > 0 and var_187_6 < var_187_9 then
					arg_184_1.talkMaxDuration = var_187_9

					if var_187_9 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_10 and arg_184_1.time_ < var_187_5 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play938072046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 938072046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play938072047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10144"]) and arg_188_1.var_.actorSpriteComps10144 == nil then
				arg_188_1.var_.actorSpriteComps10144 = arg_188_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10144"]) then
				if arg_188_1.var_.actorSpriteComps10144 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10144"]) and arg_188_1.var_.actorSpriteComps10144 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10144 = nil
			end

			local var_191_2 = arg_188_1.actors_["10144"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10144 = var_191_2.localPosition
				var_191_2.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10144", 7)

				for iter_191_4 = 0, var_191_2.childCount - 1 do
					local var_191_3 = var_191_2:GetChild(iter_191_4)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_2.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_188_1.time_ - 0) / var_191_4)
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_191_5 = 0
			local var_191_6 = 0.875

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_7 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(938072046).content)

				arg_188_1.text_.text = var_191_7

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 35 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_7) / 35)

				if (35 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_7) / 35)) > 0 and var_191_6 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_5
					end
				end

				arg_188_1.text_.text = var_191_7
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_6, arg_188_1.talkMaxDuration)

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_5) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_5 + var_191_10 and arg_188_1.time_ < var_191_5 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 938072047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play938072048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10183"]) and arg_192_1.var_.actorSpriteComps10183 == nil then
				arg_192_1.var_.actorSpriteComps10183 = arg_192_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10183"]) then
				if arg_192_1.var_.actorSpriteComps10183 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 1, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10183"]) and arg_192_1.var_.actorSpriteComps10183 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10183 = nil
			end

			local var_195_2 = arg_192_1.actors_["10183"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10183 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10183", 2)

				for iter_195_4 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_4)

					if var_195_3.name == "split_12" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10183, Vector3.New(-300, -475, -325), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_195_5 = 0
			local var_195_6 = 0.425

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_7 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(938072047).content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 17 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_7) / 17)

				if (17 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_7) / 17)) > 0 and var_195_6 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_5
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_6, arg_192_1.talkMaxDuration)

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_5) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_5 + var_195_10 and arg_192_1.time_ < var_195_5 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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
	Play938072048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 938072048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play938072049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10144"]) and arg_196_1.var_.actorSpriteComps10144 == nil then
				arg_196_1.var_.actorSpriteComps10144 = arg_196_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10144"]) then
				if arg_196_1.var_.actorSpriteComps10144 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 1, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10144"]) and arg_196_1.var_.actorSpriteComps10144 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10144 = nil
			end

			local var_199_2 = arg_196_1.actors_["10183"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10183 == nil then
				arg_196_1.var_.actorSpriteComps10183 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10183 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								iter_199_5.color = Color.New(Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_5.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_5.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10183 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_199_7 then
						iter_199_7.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps10183 = nil
			end

			local var_199_5 = arg_196_1.actors_["10144"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_5.localPosition
				var_199_5.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 4)

				for iter_199_8 = 0, var_199_5.childCount - 1 do
					local var_199_6 = var_199_5:GetChild(iter_199_8)

					if var_199_6.name == "split_13" or not string.find(var_199_6.name, "split") then
						var_199_6.gameObject:SetActive(true)
					else
						var_199_6.gameObject:SetActive(false)
					end
				end
			end

			local var_199_7 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				var_199_5.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_196_1.time_ - 0) / var_199_7)
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				var_199_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_199_8 = 0
			local var_199_9 = 0.2

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(938072048).content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_12 = 8 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_10) / 8)

				if (8 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_10) / 8)) > 0 and var_199_9 < var_199_12 then
					arg_196_1.talkMaxDuration = var_199_12

					if var_199_12 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_13 and arg_196_1.time_ < var_199_8 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938072049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 938072049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play938072050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10144"]) and arg_200_1.var_.actorSpriteComps10144 == nil then
				arg_200_1.var_.actorSpriteComps10144 = arg_200_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10144"]) then
				if arg_200_1.var_.actorSpriteComps10144 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10144"]) and arg_200_1.var_.actorSpriteComps10144 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10144 = nil
			end

			local var_203_2 = 0
			local var_203_3 = 0.775

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_2 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_4 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(938072049).content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_6 = 31 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 31)

				if (31 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 31)) > 0 and var_203_3 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_2
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_3, arg_200_1.talkMaxDuration)

			if var_203_2 <= arg_200_1.time_ and arg_200_1.time_ < var_203_2 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_2) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_2 + var_203_7 and arg_200_1.time_ < var_203_2 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play938072050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 938072050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play938072051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.85

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(938072050).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 34 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 34)

				if (34 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 34)) > 0 and var_207_0 < var_207_3 then
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
	Play938072051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 938072051
		arg_208_1.duration_ = 6.05

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play938072052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_9000

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10183 = arg_208_1.actors_["10183"].transform.localPosition
				arg_208_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10183", 7)

				for iter_211_0 = 0, arg_208_1.actors_["10183"].transform.childCount - 1 do
					local var_211_0 = arg_208_1.actors_["10183"].transform:GetChild(iter_211_0)

					if var_211_0.name == "" or not string.find(var_211_0.name, "split") then
						var_211_0.gameObject:SetActive(true)
					else
						var_211_0.gameObject:SetActive(false)
					end
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_208_1.time_ - 0) / var_211_1)
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["10183"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_2 = arg_208_1.actors_["10144"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10144 = var_211_2.localPosition
				var_211_2.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10144", 7)

				for iter_211_1 = 0, var_211_2.childCount - 1 do
					local var_211_3 = var_211_2:GetChild(iter_211_1)

					if var_211_3.name == "" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				var_211_2.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_208_1.time_ - 0) / var_211_4)
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				var_211_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_208_1.time_ and arg_208_1.time_ <= 0.3 + arg_211_0 then
				arg_208_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car01", "")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				local var_211_6 = arg_208_1.var_.effectyinqingshengyin1

				if not arg_208_1.var_.effectyinqingshengyin1 then
					var_211_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_211_6.name = "yinqingshengyin1"
					arg_208_1.var_.effectyinqingshengyin1 = var_211_6
				else
					var_211_6.transform:SetParent(var_211_9000)
				end

				var_211_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_211_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_211_6.transform.localScale = Vector3.New(var_211_6.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_211_6.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_211_6.transform.localScale.z)
			end

			local var_211_8 = 0

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_8 + 2 and arg_208_1.time_ < var_211_8 + 2 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_9 = 1.05
			local var_211_10 = 0.95

			if 1.05 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_11 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_11:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_12 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(938072051).content)

				arg_208_1.text_.text = var_211_12

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_14 = 38 <= 0 and var_211_10 or var_211_10 * (utf8.len(var_211_12) / 38)

				if (38 <= 0 and var_211_10 or var_211_10 * (utf8.len(var_211_12) / 38)) > 0 and var_211_10 < var_211_14 then
					arg_208_1.talkMaxDuration = var_211_14
					var_211_9 = var_211_9 + 0.3

					if var_211_14 + var_211_9 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_9
					end
				end

				arg_208_1.text_.text = var_211_12
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_15 = var_211_9 + 0.3
			local var_211_16 = math.max(var_211_10, arg_208_1.talkMaxDuration)

			if var_211_9 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_16 and arg_208_1.time_ < var_211_15 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play938072052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938072052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938072053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.2

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(938072052).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 8 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 8)

				if (8 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 8)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play938072053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938072053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938072054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["106603"]) and arg_218_1.var_.actorSpriteComps106603 == nil then
				arg_218_1.var_.actorSpriteComps106603 = arg_218_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["106603"]) then
				if arg_218_1.var_.actorSpriteComps106603 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["106603"]) and arg_218_1.var_.actorSpriteComps106603 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps106603 = nil
			end

			local var_221_2 = arg_218_1.actors_["106603"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos106603 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("106603", 3)

				for iter_221_4 = 0, var_221_2.childCount - 1 do
					local var_221_3 = var_221_2:GetChild(iter_221_4)

					if var_221_3.name == "split_12" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_221_5 = 0
			local var_221_6 = 0.25

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(938072053).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 10 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 10)

				if (10 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 10)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play938072054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938072054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938072055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["106603"]) and arg_222_1.var_.actorSpriteComps106603 == nil then
				arg_222_1.var_.actorSpriteComps106603 = arg_222_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["106603"]) then
				if arg_222_1.var_.actorSpriteComps106603 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["106603"]) and arg_222_1.var_.actorSpriteComps106603 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps106603 = nil
			end

			local var_225_2 = manager.ui.mainCamera.transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.shakeOldPos = var_225_2.localPosition
			end

			local var_225_3 = 0.6

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 then
				local var_225_4, var_225_5 = math.modf((arg_222_1.time_ - 0) / 0.066)

				var_225_2.localPosition = Vector3.New(var_225_5 * 0.13, var_225_5 * 0.13, var_225_5 * 0.13) + arg_222_1.var_.shakeOldPos
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 then
				var_225_2.localPosition = arg_222_1.var_.shakeOldPos
			end

			local var_225_6 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_6 + 0.6 and arg_222_1.time_ < var_225_6 + 0.6 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_7 = arg_222_1.actors_["128404"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos128404 = var_225_7.localPosition
				var_225_7.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("128404", 2)

				for iter_225_4 = 0, var_225_7.childCount - 1 do
					local var_225_8 = var_225_7:GetChild(iter_225_4)

					if var_225_8.name == "split_7" or not string.find(var_225_8.name, "split") then
						var_225_8.gameObject:SetActive(true)
					else
						var_225_8.gameObject:SetActive(false)
					end
				end
			end

			local var_225_9 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_9 then
				var_225_7.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos128404, Vector3.New(-510.9, -399.1, -303.3), (arg_222_1.time_ - 0) / var_225_9)
			end

			if arg_222_1.time_ >= 0 + var_225_9 and arg_222_1.time_ < 0 + var_225_9 + arg_225_0 then
				var_225_7.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_225_10 = arg_222_1.actors_["108301"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos108301 = var_225_10.localPosition
				var_225_10.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("108301", 4)

				for iter_225_5 = 0, var_225_10.childCount - 1 do
					local var_225_11 = var_225_10:GetChild(iter_225_5)

					if var_225_11.name == "split_6" or not string.find(var_225_11.name, "split") then
						var_225_11.gameObject:SetActive(true)
					else
						var_225_11.gameObject:SetActive(false)
					end
				end
			end

			local var_225_12 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_12 then
				var_225_10.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos108301, Vector3.New(453.9, -399.1, -303.3), (arg_222_1.time_ - 0) / var_225_12)
			end

			if arg_222_1.time_ >= 0 + var_225_12 and arg_222_1.time_ < 0 + var_225_12 + arg_225_0 then
				var_225_10.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_225_13 = arg_222_1.actors_["128404"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_13) and arg_222_1.var_.actorSpriteComps128404 == nil then
				arg_222_1.var_.actorSpriteComps128404 = var_225_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_14 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_14 and not isNil(var_225_13) then
				if arg_222_1.var_.actorSpriteComps128404 then
					for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_225_7 then
							if arg_222_1.isInRecall_ then
								iter_225_7.color = Color.New(Mathf.Lerp(iter_225_7.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_14), Mathf.Lerp(iter_225_7.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_14), (Mathf.Lerp(iter_225_7.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_14)))
							else
								local var_225_15 = Mathf.Lerp(iter_225_7.color.r, 1, (arg_222_1.time_ - 0) / var_225_14)

								iter_225_7.color = Color.New(var_225_15, var_225_15, var_225_15)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_14 and arg_222_1.time_ < 0 + var_225_14 + arg_225_0 and not isNil(var_225_13) and arg_222_1.var_.actorSpriteComps128404 then
				for iter_225_8, iter_225_9 in pairs(arg_222_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_225_9 then
						iter_225_9.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps128404 = nil
			end

			local var_225_16 = arg_222_1.actors_["108301"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_16) and arg_222_1.var_.actorSpriteComps108301 == nil then
				arg_222_1.var_.actorSpriteComps108301 = var_225_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_17 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_17 and not isNil(var_225_16) then
				if arg_222_1.var_.actorSpriteComps108301 then
					for iter_225_10, iter_225_11 in pairs(arg_222_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_225_11 then
							if arg_222_1.isInRecall_ then
								iter_225_11.color = Color.New(Mathf.Lerp(iter_225_11.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_17), Mathf.Lerp(iter_225_11.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_17), (Mathf.Lerp(iter_225_11.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_17)))
							else
								local var_225_18 = Mathf.Lerp(iter_225_11.color.r, 1, (arg_222_1.time_ - 0) / var_225_17)

								iter_225_11.color = Color.New(var_225_18, var_225_18, var_225_18)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_17 and arg_222_1.time_ < 0 + var_225_17 + arg_225_0 and not isNil(var_225_16) and arg_222_1.var_.actorSpriteComps108301 then
				for iter_225_12, iter_225_13 in pairs(arg_222_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_225_13 then
						iter_225_13.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps108301 = nil
			end

			local var_225_19 = 0
			local var_225_20 = 0.175

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_19 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_21 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(938072054).content)

				arg_222_1.text_.text = var_225_21

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_23 = 7 <= 0 and var_225_20 or var_225_20 * (utf8.len(var_225_21) / 7)

				if (7 <= 0 and var_225_20 or var_225_20 * (utf8.len(var_225_21) / 7)) > 0 and var_225_20 < var_225_23 then
					arg_222_1.talkMaxDuration = var_225_23

					if var_225_23 + var_225_19 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_23 + var_225_19
					end
				end

				arg_222_1.text_.text = var_225_21
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_24 = math.max(var_225_20, arg_222_1.talkMaxDuration)

			if var_225_19 <= arg_222_1.time_ and arg_222_1.time_ < var_225_19 + var_225_24 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_19) / var_225_24

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_19 + var_225_24 and arg_222_1.time_ < var_225_19 + var_225_24 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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
				actorName = "108301",
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
	Play938072055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938072055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
			arg_226_1.auto_ = false
		end

		function arg_226_1.playNext_(arg_228_0)
			arg_226_1.onStoryFinished_()
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.075

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(938072055).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 3 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 3)

				if (3 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 3)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I20f"
	},
	voices = {}
}
