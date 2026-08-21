return {
	Play926052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play926052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I21f"

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
				local var_4_5 = arg_1_1.bgs_.I21f

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
					if iter_4_0 ~= "I21f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = ""

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_[""]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps == nil then
				arg_1_1.var_.actorSpriteComps = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps = nil
			end

			local var_4_36 = 0.166666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			local var_4_40 = 0
			local var_4_41 = 0.3

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_42 = "play"
				local var_4_43 = "music"

				arg_1_1:AudioAction(var_4_42, var_4_43, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_44 = ""
				local var_4_45 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_45 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_45 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_45

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_45
						arg_1_1.bgmTxt2_.text = var_4_45
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

			local var_4_46 = 0.500666666666667
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 2
			local var_4_53 = 0.525

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_55

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

				local var_4_56 = arg_1_1:GetWordFromCfg(926052001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 21
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_61 = var_4_52 + 0.3
			local var_4_62 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_61 <= arg_1_1.time_ and arg_1_1.time_ < var_4_61 + var_4_62 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_61) / var_4_62

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_61 + var_4_62 and arg_1_1.time_ < var_4_61 + var_4_62 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play926052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926052002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.95

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(926052002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 38
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play926052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926052003
		arg_13_1.duration_ = 2.97

		local var_13_0 = {
			zh = 2.966,
			ja = 2.1
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play926052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "106103"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["106103"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps106103 == nil then
				arg_13_1.var_.actorSpriteComps106103 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps106103 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps106103 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps106103 = nil
			end

			local var_16_12 = arg_13_1.actors_["106103"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos106103 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("106103", 3)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(-36.6, -398.2, -333.7)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos106103, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_16_19 = 0
			local var_16_20 = 0.225

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_21 = arg_13_1:FormatText(StoryNameCfg[612].name)

				arg_13_1.leftNameTxt_.text = var_16_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_22 = arg_13_1:GetWordFromCfg(926052003)
				local var_16_23 = arg_13_1:FormatText(var_16_22.content)

				arg_13_1.text_.text = var_16_23

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_24 = 9
				local var_16_25 = utf8.len(var_16_23)
				local var_16_26 = var_16_24 <= 0 and var_16_20 or var_16_20 * (var_16_25 / var_16_24)

				if var_16_26 > 0 and var_16_20 < var_16_26 then
					arg_13_1.talkMaxDuration = var_16_26

					if var_16_26 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_26 + var_16_19
					end
				end

				arg_13_1.text_.text = var_16_23
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052003", "story_v_out_926052.awb") ~= 0 then
					local var_16_27 = manager.audio:GetVoiceLength("story_v_out_926052", "926052003", "story_v_out_926052.awb") / 1000

					if var_16_27 + var_16_19 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_19
					end

					if var_16_22.prefab_name ~= "" and arg_13_1.actors_[var_16_22.prefab_name] ~= nil then
						local var_16_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_22.prefab_name].transform, "story_v_out_926052", "926052003", "story_v_out_926052.awb")

						arg_13_1:RecordAudio("926052003", var_16_28)
						arg_13_1:RecordAudio("926052003", var_16_28)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926052", "926052003", "story_v_out_926052.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926052", "926052003", "story_v_out_926052.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_29 = math.max(var_16_20, arg_13_1.talkMaxDuration)

			if var_16_19 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_29 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_29

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_29 and arg_13_1.time_ < var_16_19 + var_16_29 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play926052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926052004
		arg_17_1.duration_ = 7.07

		local var_17_0 = {
			zh = 4.833,
			ja = 7.066
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
				arg_17_0:Play926052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "128404"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["128404"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end

			local var_20_12 = arg_17_1.actors_["106103"]
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps106103 == nil then
				arg_17_1.var_.actorSpriteComps106103 = var_20_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_14 = 0.2

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_14 and not isNil(var_20_12) then
				local var_20_15 = (arg_17_1.time_ - var_20_13) / var_20_14

				if arg_17_1.var_.actorSpriteComps106103 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_16 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_15)
								local var_20_17 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_15)
								local var_20_18 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_15)

								iter_20_7.color = Color.New(var_20_16, var_20_17, var_20_18)
							else
								local var_20_19 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_15)

								iter_20_7.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_13 + var_20_14 and arg_17_1.time_ < var_20_13 + var_20_14 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps106103 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps106103 = nil
			end

			local var_20_20 = arg_17_1.actors_["106103"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos106103 = var_20_20.localPosition
				var_20_20.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("106103", 4)

				local var_20_22 = var_20_20.childCount

				for iter_20_10 = 0, var_20_22 - 1 do
					local var_20_23 = var_20_20:GetChild(iter_20_10)

					if var_20_23.name == "" or not string.find(var_20_23.name, "split") then
						var_20_23.gameObject:SetActive(true)
					else
						var_20_23.gameObject:SetActive(false)
					end
				end
			end

			local var_20_24 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_21) / var_20_24
				local var_20_26 = Vector3.New(442.7, -398.2, -333.7)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos106103, var_20_26, var_20_25)
			end

			if arg_17_1.time_ >= var_20_21 + var_20_24 and arg_17_1.time_ < var_20_21 + var_20_24 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_20_27 = arg_17_1.actors_["128404"].transform
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				arg_17_1.var_.moveOldPos128404 = var_20_27.localPosition
				var_20_27.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("128404", 2)

				local var_20_29 = var_20_27.childCount

				for iter_20_11 = 0, var_20_29 - 1 do
					local var_20_30 = var_20_27:GetChild(iter_20_11)

					if var_20_30.name == "" or not string.find(var_20_30.name, "split") then
						var_20_30.gameObject:SetActive(true)
					else
						var_20_30.gameObject:SetActive(false)
					end
				end
			end

			local var_20_31 = 0.001

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_31 then
				local var_20_32 = (arg_17_1.time_ - var_20_28) / var_20_31
				local var_20_33 = Vector3.New(-428.5, -356, -362.3)

				var_20_27.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos128404, var_20_33, var_20_32)
			end

			if arg_17_1.time_ >= var_20_28 + var_20_31 and arg_17_1.time_ < var_20_28 + var_20_31 + arg_20_0 then
				var_20_27.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_20_34 = 0
			local var_20_35 = 0.7

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(926052004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 28
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052004", "story_v_out_926052.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_926052", "926052004", "story_v_out_926052.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_926052", "926052004", "story_v_out_926052.awb")

						arg_17_1:RecordAudio("926052004", var_20_43)
						arg_17_1:RecordAudio("926052004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926052", "926052004", "story_v_out_926052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926052", "926052004", "story_v_out_926052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play926052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926052005
		arg_21_1.duration_ = 8.7

		local var_21_0 = {
			zh = 8.7,
			ja = 8.366
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
				arg_21_0:Play926052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.025

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(926052005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 41
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052005", "story_v_out_926052.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052005", "story_v_out_926052.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_926052", "926052005", "story_v_out_926052.awb")

						arg_21_1:RecordAudio("926052005", var_24_9)
						arg_21_1:RecordAudio("926052005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926052", "926052005", "story_v_out_926052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926052", "926052005", "story_v_out_926052.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926052006
		arg_25_1.duration_ = 2.23

		local var_25_0 = {
			zh = 2.133,
			ja = 2.233
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
				arg_25_0:Play926052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["106103"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps106103 == nil then
				arg_25_1.var_.actorSpriteComps106103 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps106103 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps106103 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps106103 = nil
			end

			local var_28_8 = arg_25_1.actors_["128404"]
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps128404 == nil then
				arg_25_1.var_.actorSpriteComps128404 = var_28_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_10 = 0.2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 and not isNil(var_28_8) then
				local var_28_11 = (arg_25_1.time_ - var_28_9) / var_28_10

				if arg_25_1.var_.actorSpriteComps128404 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_12 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor2.r, var_28_11)
								local var_28_13 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor2.g, var_28_11)
								local var_28_14 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor2.b, var_28_11)

								iter_28_5.color = Color.New(var_28_12, var_28_13, var_28_14)
							else
								local var_28_15 = Mathf.Lerp(iter_28_5.color.r, 0.5, var_28_11)

								iter_28_5.color = Color.New(var_28_15, var_28_15, var_28_15)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.actorSpriteComps128404 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps128404 = nil
			end

			local var_28_16 = 0
			local var_28_17 = 0.25

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_18 = arg_25_1:FormatText(StoryNameCfg[612].name)

				arg_25_1.leftNameTxt_.text = var_28_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:GetWordFromCfg(926052006)
				local var_28_20 = arg_25_1:FormatText(var_28_19.content)

				arg_25_1.text_.text = var_28_20

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 10
				local var_28_22 = utf8.len(var_28_20)
				local var_28_23 = var_28_21 <= 0 and var_28_17 or var_28_17 * (var_28_22 / var_28_21)

				if var_28_23 > 0 and var_28_17 < var_28_23 then
					arg_25_1.talkMaxDuration = var_28_23

					if var_28_23 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_20
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052006", "story_v_out_926052.awb") ~= 0 then
					local var_28_24 = manager.audio:GetVoiceLength("story_v_out_926052", "926052006", "story_v_out_926052.awb") / 1000

					if var_28_24 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_24 + var_28_16
					end

					if var_28_19.prefab_name ~= "" and arg_25_1.actors_[var_28_19.prefab_name] ~= nil then
						local var_28_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_19.prefab_name].transform, "story_v_out_926052", "926052006", "story_v_out_926052.awb")

						arg_25_1:RecordAudio("926052006", var_28_25)
						arg_25_1:RecordAudio("926052006", var_28_25)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926052", "926052006", "story_v_out_926052.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926052", "926052006", "story_v_out_926052.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_26 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_26 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_26

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_26 and arg_25_1.time_ < var_28_16 + var_28_26 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play926052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926052007
		arg_29_1.duration_ = 4.63

		local var_29_0 = {
			zh = 4.5,
			ja = 4.633
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
				arg_29_0:Play926052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["128404"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps128404 == nil then
				arg_29_1.var_.actorSpriteComps128404 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps128404 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps128404 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps128404 = nil
			end

			local var_32_8 = arg_29_1.actors_["106103"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps106103 == nil then
				arg_29_1.var_.actorSpriteComps106103 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps106103 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps106103 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps106103 = nil
			end

			local var_32_16 = arg_29_1.actors_["128404"].transform
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_16.localPosition
				var_32_16.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 2)

				local var_32_18 = var_32_16.childCount

				for iter_32_8 = 0, var_32_18 - 1 do
					local var_32_19 = var_32_16:GetChild(iter_32_8)

					if var_32_19.name == "" or not string.find(var_32_19.name, "split") then
						var_32_19.gameObject:SetActive(true)
					else
						var_32_19.gameObject:SetActive(false)
					end
				end
			end

			local var_32_20 = 0.001

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_20 then
				local var_32_21 = (arg_29_1.time_ - var_32_17) / var_32_20
				local var_32_22 = Vector3.New(-428.5, -356, -362.3)

				var_32_16.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, var_32_22, var_32_21)
			end

			if arg_29_1.time_ >= var_32_17 + var_32_20 and arg_29_1.time_ < var_32_17 + var_32_20 + arg_32_0 then
				var_32_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_32_23 = 0
			local var_32_24 = 0.525

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(926052007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 21
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052007", "story_v_out_926052.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_926052", "926052007", "story_v_out_926052.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_926052", "926052007", "story_v_out_926052.awb")

						arg_29_1:RecordAudio("926052007", var_32_32)
						arg_29_1:RecordAudio("926052007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926052", "926052007", "story_v_out_926052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926052", "926052007", "story_v_out_926052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play926052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926052008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["128404"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.825

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_10

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

				local var_36_11 = arg_33_1:GetWordFromCfg(926052008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 33
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_9 or var_36_9 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_9 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
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

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926052009
		arg_37_1.duration_ = 5.63

		local var_37_0 = {
			zh = 3.4,
			ja = 5.633
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
				arg_37_0:Play926052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "104701"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(var_40_1, arg_37_1.canvasGo_.transform)

					var_40_2.transform:SetSiblingIndex(1)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs(var_40_3) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_4 = arg_37_1.actors_["104701"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps104701 == nil then
				arg_37_1.var_.actorSpriteComps104701 = var_40_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.actorSpriteComps104701 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_8 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_7)
								local var_40_9 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_7)
								local var_40_10 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_7)

								iter_40_3.color = Color.New(var_40_8, var_40_9, var_40_10)
							else
								local var_40_11 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_7)

								iter_40_3.color = Color.New(var_40_11, var_40_11, var_40_11)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps104701 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps104701 = nil
			end

			local var_40_12 = arg_37_1.actors_["106103"].transform
			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_12.localPosition
				var_40_12.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 7)

				local var_40_14 = var_40_12.childCount

				for iter_40_6 = 0, var_40_14 - 1 do
					local var_40_15 = var_40_12:GetChild(iter_40_6)

					if var_40_15.name == "" or not string.find(var_40_15.name, "split") then
						var_40_15.gameObject:SetActive(true)
					else
						var_40_15.gameObject:SetActive(false)
					end
				end
			end

			local var_40_16 = 0.001

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_16 then
				local var_40_17 = (arg_37_1.time_ - var_40_13) / var_40_16
				local var_40_18 = Vector3.New(0, -2000, 0)

				var_40_12.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, var_40_18, var_40_17)
			end

			if arg_37_1.time_ >= var_40_13 + var_40_16 and arg_37_1.time_ < var_40_13 + var_40_16 + arg_40_0 then
				var_40_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_19 = arg_37_1.actors_["128404"].transform
			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.var_.moveOldPos128404 = var_40_19.localPosition
				var_40_19.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("128404", 7)

				local var_40_21 = var_40_19.childCount

				for iter_40_7 = 0, var_40_21 - 1 do
					local var_40_22 = var_40_19:GetChild(iter_40_7)

					if var_40_22.name == "" or not string.find(var_40_22.name, "split") then
						var_40_22.gameObject:SetActive(true)
					else
						var_40_22.gameObject:SetActive(false)
					end
				end
			end

			local var_40_23 = 0.001

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_23 then
				local var_40_24 = (arg_37_1.time_ - var_40_20) / var_40_23
				local var_40_25 = Vector3.New(0, -2000, 0)

				var_40_19.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos128404, var_40_25, var_40_24)
			end

			if arg_37_1.time_ >= var_40_20 + var_40_23 and arg_37_1.time_ < var_40_20 + var_40_23 + arg_40_0 then
				var_40_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_26 = arg_37_1.actors_["104701"].transform
			local var_40_27 = 0

			if var_40_27 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 then
				arg_37_1.var_.moveOldPos104701 = var_40_26.localPosition
				var_40_26.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("104701", 3)

				local var_40_28 = var_40_26.childCount

				for iter_40_8 = 0, var_40_28 - 1 do
					local var_40_29 = var_40_26:GetChild(iter_40_8)

					if var_40_29.name == "" or not string.find(var_40_29.name, "split") then
						var_40_29.gameObject:SetActive(true)
					else
						var_40_29.gameObject:SetActive(false)
					end
				end
			end

			local var_40_30 = 0.001

			if var_40_27 <= arg_37_1.time_ and arg_37_1.time_ < var_40_27 + var_40_30 then
				local var_40_31 = (arg_37_1.time_ - var_40_27) / var_40_30
				local var_40_32 = Vector3.New(-67.4, -386.8, -295)

				var_40_26.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos104701, var_40_32, var_40_31)
			end

			if arg_37_1.time_ >= var_40_27 + var_40_30 and arg_37_1.time_ < var_40_27 + var_40_30 + arg_40_0 then
				var_40_26.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_40_33 = 0
			local var_40_34 = 0.4

			if var_40_33 < arg_37_1.time_ and arg_37_1.time_ <= var_40_33 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_35 = arg_37_1:FormatText(StoryNameCfg[1296].name)

				arg_37_1.leftNameTxt_.text = var_40_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_36 = arg_37_1:GetWordFromCfg(926052009)
				local var_40_37 = arg_37_1:FormatText(var_40_36.content)

				arg_37_1.text_.text = var_40_37

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_38 = 16
				local var_40_39 = utf8.len(var_40_37)
				local var_40_40 = var_40_38 <= 0 and var_40_34 or var_40_34 * (var_40_39 / var_40_38)

				if var_40_40 > 0 and var_40_34 < var_40_40 then
					arg_37_1.talkMaxDuration = var_40_40

					if var_40_40 + var_40_33 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_40 + var_40_33
					end
				end

				arg_37_1.text_.text = var_40_37
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052009", "story_v_out_926052.awb") ~= 0 then
					local var_40_41 = manager.audio:GetVoiceLength("story_v_out_926052", "926052009", "story_v_out_926052.awb") / 1000

					if var_40_41 + var_40_33 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_41 + var_40_33
					end

					if var_40_36.prefab_name ~= "" and arg_37_1.actors_[var_40_36.prefab_name] ~= nil then
						local var_40_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_36.prefab_name].transform, "story_v_out_926052", "926052009", "story_v_out_926052.awb")

						arg_37_1:RecordAudio("926052009", var_40_42)
						arg_37_1:RecordAudio("926052009", var_40_42)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926052", "926052009", "story_v_out_926052.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926052", "926052009", "story_v_out_926052.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_43 = math.max(var_40_34, arg_37_1.talkMaxDuration)

			if var_40_33 <= arg_37_1.time_ and arg_37_1.time_ < var_40_33 + var_40_43 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_33) / var_40_43

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_33 + var_40_43 and arg_37_1.time_ < var_40_33 + var_40_43 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
			},
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

		arg_37_1:InitPlayNodeList()
	end,
	Play926052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926052010
		arg_41_1.duration_ = 4.23

		local var_41_0 = {
			zh = 4.166,
			ja = 4.233
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
				arg_41_0:Play926052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["106103"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_8 = arg_41_1.actors_["104701"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps104701 == nil then
				arg_41_1.var_.actorSpriteComps104701 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps104701 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps104701 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps104701 = nil
			end

			local var_44_16 = arg_41_1.actors_["104701"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos104701 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("104701", 7)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(0, -2000, 0)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos104701, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_23 = arg_41_1.actors_["106103"].transform
			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.var_.moveOldPos106103 = var_44_23.localPosition
				var_44_23.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106103", 3)

				local var_44_25 = var_44_23.childCount

				for iter_44_9 = 0, var_44_25 - 1 do
					local var_44_26 = var_44_23:GetChild(iter_44_9)

					if var_44_26.name == "split_5" or not string.find(var_44_26.name, "split") then
						var_44_26.gameObject:SetActive(true)
					else
						var_44_26.gameObject:SetActive(false)
					end
				end
			end

			local var_44_27 = 0.001

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_27 then
				local var_44_28 = (arg_41_1.time_ - var_44_24) / var_44_27
				local var_44_29 = Vector3.New(-36.6, -398.2, -333.7)

				var_44_23.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106103, var_44_29, var_44_28)
			end

			if arg_41_1.time_ >= var_44_24 + var_44_27 and arg_41_1.time_ < var_44_24 + var_44_27 + arg_44_0 then
				var_44_23.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_44_30 = 0
			local var_44_31 = 0.325

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(926052010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 13
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052010", "story_v_out_926052.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_926052", "926052010", "story_v_out_926052.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_926052", "926052010", "story_v_out_926052.awb")

						arg_41_1:RecordAudio("926052010", var_44_39)
						arg_41_1:RecordAudio("926052010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926052", "926052010", "story_v_out_926052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926052", "926052010", "story_v_out_926052.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play926052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926052011
		arg_45_1.duration_ = 7.23

		local var_45_0 = {
			zh = 5.999999999999,
			ja = 7.232999999999
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
				arg_45_0:Play926052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "I21g"

			if arg_45_1.bgs_[var_48_0] == nil then
				local var_48_1 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_0)
				var_48_1.name = var_48_0
				var_48_1.transform.parent = arg_45_1.stage_.transform
				var_48_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_0] = var_48_1
			end

			local var_48_2 = 2

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				local var_48_3 = manager.ui.mainCamera.transform.localPosition
				local var_48_4 = Vector3.New(0, 0, 10) + Vector3.New(var_48_3.x, var_48_3.y, 0)
				local var_48_5 = arg_45_1.bgs_.I21g

				var_48_5.transform.localPosition = var_48_4
				var_48_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_6 = var_48_5:GetComponent("SpriteRenderer")

				if var_48_6 and var_48_6.sprite then
					local var_48_7 = (var_48_5.transform.localPosition - var_48_3).z
					local var_48_8 = manager.ui.mainCameraCom_
					local var_48_9 = 2 * var_48_7 * Mathf.Tan(var_48_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_10 = var_48_9 * var_48_8.aspect
					local var_48_11 = var_48_6.sprite.bounds.size.x
					local var_48_12 = var_48_6.sprite.bounds.size.y
					local var_48_13 = var_48_10 / var_48_11
					local var_48_14 = var_48_9 / var_48_12
					local var_48_15 = var_48_14 < var_48_13 and var_48_13 or var_48_14

					var_48_5.transform.localScale = Vector3.New(var_48_15, var_48_15, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I21g" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_16 = 2

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_17 = 0.3

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_18 = 0

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_19 = 2

			if var_48_18 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_19 then
				local var_48_20 = (arg_45_1.time_ - var_48_18) / var_48_19
				local var_48_21 = Color.New(0, 0, 0)

				var_48_21.a = Mathf.Lerp(0, 1, var_48_20)
				arg_45_1.mask_.color = var_48_21
			end

			if arg_45_1.time_ >= var_48_18 + var_48_19 and arg_45_1.time_ < var_48_18 + var_48_19 + arg_48_0 then
				local var_48_22 = Color.New(0, 0, 0)

				var_48_22.a = 1
				arg_45_1.mask_.color = var_48_22
			end

			local var_48_23 = 2

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_24 = 2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24
				local var_48_26 = Color.New(0, 0, 0)

				var_48_26.a = Mathf.Lerp(1, 0, var_48_25)
				arg_45_1.mask_.color = var_48_26
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 then
				local var_48_27 = Color.New(0, 0, 0)
				local var_48_28 = 0

				arg_45_1.mask_.enabled = false
				var_48_27.a = var_48_28
				arg_45_1.mask_.color = var_48_27
			end

			local var_48_29 = arg_45_1.actors_["128404"]
			local var_48_30 = 3.76666666666667

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 and not isNil(var_48_29) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = var_48_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_31 = 0.2

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_31 and not isNil(var_48_29) then
				local var_48_32 = (arg_45_1.time_ - var_48_30) / var_48_31

				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								local var_48_33 = Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, var_48_32)
								local var_48_34 = Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, var_48_32)
								local var_48_35 = Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, var_48_32)

								iter_48_3.color = Color.New(var_48_33, var_48_34, var_48_35)
							else
								local var_48_36 = Mathf.Lerp(iter_48_3.color.r, 1, var_48_32)

								iter_48_3.color = Color.New(var_48_36, var_48_36, var_48_36)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_30 + var_48_31 and arg_45_1.time_ < var_48_30 + var_48_31 + arg_48_0 and not isNil(var_48_29) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end

			local var_48_37 = arg_45_1.actors_["106103"]
			local var_48_38 = 2

			if var_48_38 < arg_45_1.time_ and arg_45_1.time_ <= var_48_38 + arg_48_0 and not isNil(var_48_37) and arg_45_1.var_.actorSpriteComps106103 == nil then
				arg_45_1.var_.actorSpriteComps106103 = var_48_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_39 = 0.2

			if var_48_38 <= arg_45_1.time_ and arg_45_1.time_ < var_48_38 + var_48_39 and not isNil(var_48_37) then
				local var_48_40 = (arg_45_1.time_ - var_48_38) / var_48_39

				if arg_45_1.var_.actorSpriteComps106103 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_41 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_40)
								local var_48_42 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_40)
								local var_48_43 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_40)

								iter_48_7.color = Color.New(var_48_41, var_48_42, var_48_43)
							else
								local var_48_44 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_40)

								iter_48_7.color = Color.New(var_48_44, var_48_44, var_48_44)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_38 + var_48_39 and arg_45_1.time_ < var_48_38 + var_48_39 + arg_48_0 and not isNil(var_48_37) and arg_45_1.var_.actorSpriteComps106103 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps106103 = nil
			end

			local var_48_45 = arg_45_1.actors_["106103"].transform
			local var_48_46 = 2

			if var_48_46 < arg_45_1.time_ and arg_45_1.time_ <= var_48_46 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_45.localPosition
				var_48_45.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

				local var_48_47 = var_48_45.childCount

				for iter_48_10 = 0, var_48_47 - 1 do
					local var_48_48 = var_48_45:GetChild(iter_48_10)

					if var_48_48.name == "" or not string.find(var_48_48.name, "split") then
						var_48_48.gameObject:SetActive(true)
					else
						var_48_48.gameObject:SetActive(false)
					end
				end
			end

			local var_48_49 = 0.001

			if var_48_46 <= arg_45_1.time_ and arg_45_1.time_ < var_48_46 + var_48_49 then
				local var_48_50 = (arg_45_1.time_ - var_48_46) / var_48_49
				local var_48_51 = Vector3.New(0, -2000, 0)

				var_48_45.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, var_48_51, var_48_50)
			end

			if arg_45_1.time_ >= var_48_46 + var_48_49 and arg_45_1.time_ < var_48_46 + var_48_49 + arg_48_0 then
				var_48_45.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_52 = arg_45_1.actors_["128404"].transform
			local var_48_53 = 3.76666666666667

			if var_48_53 < arg_45_1.time_ and arg_45_1.time_ <= var_48_53 + arg_48_0 then
				arg_45_1.var_.moveOldPos128404 = var_48_52.localPosition
				var_48_52.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("128404", 3)

				local var_48_54 = var_48_52.childCount

				for iter_48_11 = 0, var_48_54 - 1 do
					local var_48_55 = var_48_52:GetChild(iter_48_11)

					if var_48_55.name == "" or not string.find(var_48_55.name, "split") then
						var_48_55.gameObject:SetActive(true)
					else
						var_48_55.gameObject:SetActive(false)
					end
				end
			end

			local var_48_56 = 0.001

			if var_48_53 <= arg_45_1.time_ and arg_45_1.time_ < var_48_53 + var_48_56 then
				local var_48_57 = (arg_45_1.time_ - var_48_53) / var_48_56
				local var_48_58 = Vector3.New(-16.1, -362, -375)

				var_48_52.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos128404, var_48_58, var_48_57)
			end

			if arg_45_1.time_ >= var_48_53 + var_48_56 and arg_45_1.time_ < var_48_53 + var_48_56 + arg_48_0 then
				var_48_52.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_48_59 = arg_45_1.actors_["128404"]
			local var_48_60 = 3.76666666666667

			if var_48_60 < arg_45_1.time_ and arg_45_1.time_ <= var_48_60 + arg_48_0 then
				local var_48_61 = var_48_59:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_61 then
					arg_45_1.var_.alphaOldValue128404 = var_48_61.alpha
					arg_45_1.var_.characterEffect128404 = var_48_61
				end

				arg_45_1.var_.alphaOldValue128404 = 0
			end

			local var_48_62 = 0.233333333333333

			if var_48_60 <= arg_45_1.time_ and arg_45_1.time_ < var_48_60 + var_48_62 then
				local var_48_63 = (arg_45_1.time_ - var_48_60) / var_48_62
				local var_48_64 = Mathf.Lerp(arg_45_1.var_.alphaOldValue128404, 1, var_48_63)

				if arg_45_1.var_.characterEffect128404 then
					arg_45_1.var_.characterEffect128404.alpha = var_48_64
				end
			end

			if arg_45_1.time_ >= var_48_60 + var_48_62 and arg_45_1.time_ < var_48_60 + var_48_62 + arg_48_0 and arg_45_1.var_.characterEffect128404 then
				arg_45_1.var_.characterEffect128404.alpha = 1
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_65 = 3.999999999999
			local var_48_66 = 0.175

			if var_48_65 < arg_45_1.time_ and arg_45_1.time_ <= var_48_65 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_67 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_67:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_68 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_69 = arg_45_1:GetWordFromCfg(926052011)
				local var_48_70 = arg_45_1:FormatText(var_48_69.content)

				arg_45_1.text_.text = var_48_70

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_71 = 7
				local var_48_72 = utf8.len(var_48_70)
				local var_48_73 = var_48_71 <= 0 and var_48_66 or var_48_66 * (var_48_72 / var_48_71)

				if var_48_73 > 0 and var_48_66 < var_48_73 then
					arg_45_1.talkMaxDuration = var_48_73
					var_48_65 = var_48_65 + 0.3

					if var_48_73 + var_48_65 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_73 + var_48_65
					end
				end

				arg_45_1.text_.text = var_48_70
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052011", "story_v_out_926052.awb") ~= 0 then
					local var_48_74 = manager.audio:GetVoiceLength("story_v_out_926052", "926052011", "story_v_out_926052.awb") / 1000

					if var_48_74 + var_48_65 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_74 + var_48_65
					end

					if var_48_69.prefab_name ~= "" and arg_45_1.actors_[var_48_69.prefab_name] ~= nil then
						local var_48_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_69.prefab_name].transform, "story_v_out_926052", "926052011", "story_v_out_926052.awb")

						arg_45_1:RecordAudio("926052011", var_48_75)
						arg_45_1:RecordAudio("926052011", var_48_75)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926052", "926052011", "story_v_out_926052.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926052", "926052011", "story_v_out_926052.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_76 = var_48_65 + 0.3
			local var_48_77 = math.max(var_48_66, arg_45_1.talkMaxDuration)

			if var_48_76 <= arg_45_1.time_ and arg_45_1.time_ < var_48_76 + var_48_77 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_76) / var_48_77

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_76 + var_48_77 and arg_45_1.time_ < var_48_76 + var_48_77 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play926052012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 926052012
		arg_51_1.duration_ = 8.67

		local var_51_0 = {
			zh = 3.933,
			ja = 8.666
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
				arg_51_0:Play926052013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = "106603"

			if arg_51_1.actors_[var_54_0] == nil then
				local var_54_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_54_1) then
					local var_54_2 = Object.Instantiate(var_54_1, arg_51_1.canvasGo_.transform)

					var_54_2.transform:SetSiblingIndex(1)

					var_54_2.name = var_54_0
					var_54_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_51_1.actors_[var_54_0] = var_54_2

					local var_54_3 = var_54_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_51_1.isInRecall_ then
						for iter_54_0, iter_54_1 in ipairs(var_54_3) do
							iter_54_1.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_54_4 = arg_51_1.actors_["106603"]
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.actorSpriteComps106603 == nil then
				arg_51_1.var_.actorSpriteComps106603 = var_54_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 0.2

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 and not isNil(var_54_4) then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6

				if arg_51_1.var_.actorSpriteComps106603 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								local var_54_8 = Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, var_54_7)
								local var_54_9 = Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, var_54_7)
								local var_54_10 = Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, var_54_7)

								iter_54_3.color = Color.New(var_54_8, var_54_9, var_54_10)
							else
								local var_54_11 = Mathf.Lerp(iter_54_3.color.r, 1, var_54_7)

								iter_54_3.color = Color.New(var_54_11, var_54_11, var_54_11)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.actorSpriteComps106603 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_54_5 then
						if arg_51_1.isInRecall_ then
							iter_54_5.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps106603 = nil
			end

			local var_54_12 = arg_51_1.actors_["128404"]
			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 and not isNil(var_54_12) and arg_51_1.var_.actorSpriteComps128404 == nil then
				arg_51_1.var_.actorSpriteComps128404 = var_54_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_14 = 0.2

			if var_54_13 <= arg_51_1.time_ and arg_51_1.time_ < var_54_13 + var_54_14 and not isNil(var_54_12) then
				local var_54_15 = (arg_51_1.time_ - var_54_13) / var_54_14

				if arg_51_1.var_.actorSpriteComps128404 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								local var_54_16 = Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, var_54_15)
								local var_54_17 = Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, var_54_15)
								local var_54_18 = Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, var_54_15)

								iter_54_7.color = Color.New(var_54_16, var_54_17, var_54_18)
							else
								local var_54_19 = Mathf.Lerp(iter_54_7.color.r, 0.5, var_54_15)

								iter_54_7.color = Color.New(var_54_19, var_54_19, var_54_19)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_13 + var_54_14 and arg_51_1.time_ < var_54_13 + var_54_14 + arg_54_0 and not isNil(var_54_12) and arg_51_1.var_.actorSpriteComps128404 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_54_9 then
						if arg_51_1.isInRecall_ then
							iter_54_9.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps128404 = nil
			end

			local var_54_20 = arg_51_1.actors_["128404"].transform
			local var_54_21 = 0

			if var_54_21 < arg_51_1.time_ and arg_51_1.time_ <= var_54_21 + arg_54_0 then
				arg_51_1.var_.moveOldPos128404 = var_54_20.localPosition
				var_54_20.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("128404", 7)

				local var_54_22 = var_54_20.childCount

				for iter_54_10 = 0, var_54_22 - 1 do
					local var_54_23 = var_54_20:GetChild(iter_54_10)

					if var_54_23.name == "" or not string.find(var_54_23.name, "split") then
						var_54_23.gameObject:SetActive(true)
					else
						var_54_23.gameObject:SetActive(false)
					end
				end
			end

			local var_54_24 = 0.001

			if var_54_21 <= arg_51_1.time_ and arg_51_1.time_ < var_54_21 + var_54_24 then
				local var_54_25 = (arg_51_1.time_ - var_54_21) / var_54_24
				local var_54_26 = Vector3.New(0, -2000, 0)

				var_54_20.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos128404, var_54_26, var_54_25)
			end

			if arg_51_1.time_ >= var_54_21 + var_54_24 and arg_51_1.time_ < var_54_21 + var_54_24 + arg_54_0 then
				var_54_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_27 = arg_51_1.actors_["106603"].transform
			local var_54_28 = 0

			if var_54_28 < arg_51_1.time_ and arg_51_1.time_ <= var_54_28 + arg_54_0 then
				arg_51_1.var_.moveOldPos106603 = var_54_27.localPosition
				var_54_27.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("106603", 3)

				local var_54_29 = var_54_27.childCount

				for iter_54_11 = 0, var_54_29 - 1 do
					local var_54_30 = var_54_27:GetChild(iter_54_11)

					if var_54_30.name == "" or not string.find(var_54_30.name, "split") then
						var_54_30.gameObject:SetActive(true)
					else
						var_54_30.gameObject:SetActive(false)
					end
				end
			end

			local var_54_31 = 0.001

			if var_54_28 <= arg_51_1.time_ and arg_51_1.time_ < var_54_28 + var_54_31 then
				local var_54_32 = (arg_51_1.time_ - var_54_28) / var_54_31
				local var_54_33 = Vector3.New(-77.5, -399.1, -303.3)

				var_54_27.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos106603, var_54_33, var_54_32)
			end

			if arg_51_1.time_ >= var_54_28 + var_54_31 and arg_51_1.time_ < var_54_28 + var_54_31 + arg_54_0 then
				var_54_27.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_54_34 = 0
			local var_54_35 = 0.45

			if var_54_34 < arg_51_1.time_ and arg_51_1.time_ <= var_54_34 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_36 = arg_51_1:FormatText(StoryNameCfg[32].name)

				arg_51_1.leftNameTxt_.text = var_54_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_37 = arg_51_1:GetWordFromCfg(926052012)
				local var_54_38 = arg_51_1:FormatText(var_54_37.content)

				arg_51_1.text_.text = var_54_38

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_39 = 18
				local var_54_40 = utf8.len(var_54_38)
				local var_54_41 = var_54_39 <= 0 and var_54_35 or var_54_35 * (var_54_40 / var_54_39)

				if var_54_41 > 0 and var_54_35 < var_54_41 then
					arg_51_1.talkMaxDuration = var_54_41

					if var_54_41 + var_54_34 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_41 + var_54_34
					end
				end

				arg_51_1.text_.text = var_54_38
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052012", "story_v_out_926052.awb") ~= 0 then
					local var_54_42 = manager.audio:GetVoiceLength("story_v_out_926052", "926052012", "story_v_out_926052.awb") / 1000

					if var_54_42 + var_54_34 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_42 + var_54_34
					end

					if var_54_37.prefab_name ~= "" and arg_51_1.actors_[var_54_37.prefab_name] ~= nil then
						local var_54_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_37.prefab_name].transform, "story_v_out_926052", "926052012", "story_v_out_926052.awb")

						arg_51_1:RecordAudio("926052012", var_54_43)
						arg_51_1:RecordAudio("926052012", var_54_43)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_926052", "926052012", "story_v_out_926052.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_926052", "926052012", "story_v_out_926052.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_44 = math.max(var_54_35, arg_51_1.talkMaxDuration)

			if var_54_34 <= arg_51_1.time_ and arg_51_1.time_ < var_54_34 + var_54_44 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_34) / var_54_44

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_34 + var_54_44 and arg_51_1.time_ < var_54_34 + var_54_44 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play926052013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 926052013
		arg_55_1.duration_ = 13.1

		local var_55_0 = {
			zh = 7.266,
			ja = 13.1
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play926052014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["106103"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps106103 == nil then
				arg_55_1.var_.actorSpriteComps106103 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps106103 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 1, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps106103 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps106103 = nil
			end

			local var_58_8 = arg_55_1.actors_["106603"]
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps106603 == nil then
				arg_55_1.var_.actorSpriteComps106603 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_10 = 0.2

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 and not isNil(var_58_8) then
				local var_58_11 = (arg_55_1.time_ - var_58_9) / var_58_10

				if arg_55_1.var_.actorSpriteComps106603 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								local var_58_12 = Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor2.r, var_58_11)
								local var_58_13 = Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor2.g, var_58_11)
								local var_58_14 = Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor2.b, var_58_11)

								iter_58_5.color = Color.New(var_58_12, var_58_13, var_58_14)
							else
								local var_58_15 = Mathf.Lerp(iter_58_5.color.r, 0.5, var_58_11)

								iter_58_5.color = Color.New(var_58_15, var_58_15, var_58_15)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps106603 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_58_7 then
						if arg_55_1.isInRecall_ then
							iter_58_7.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps106603 = nil
			end

			local var_58_16 = arg_55_1.actors_["106603"].transform
			local var_58_17 = 0

			if var_58_17 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 then
				arg_55_1.var_.moveOldPos106603 = var_58_16.localPosition
				var_58_16.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("106603", 4)

				local var_58_18 = var_58_16.childCount

				for iter_58_8 = 0, var_58_18 - 1 do
					local var_58_19 = var_58_16:GetChild(iter_58_8)

					if var_58_19.name == "" or not string.find(var_58_19.name, "split") then
						var_58_19.gameObject:SetActive(true)
					else
						var_58_19.gameObject:SetActive(false)
					end
				end
			end

			local var_58_20 = 0.001

			if var_58_17 <= arg_55_1.time_ and arg_55_1.time_ < var_58_17 + var_58_20 then
				local var_58_21 = (arg_55_1.time_ - var_58_17) / var_58_20
				local var_58_22 = Vector3.New(453.9, -399.1, -303.3)

				var_58_16.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos106603, var_58_22, var_58_21)
			end

			if arg_55_1.time_ >= var_58_17 + var_58_20 and arg_55_1.time_ < var_58_17 + var_58_20 + arg_58_0 then
				var_58_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_58_23 = arg_55_1.actors_["106103"].transform
			local var_58_24 = 0

			if var_58_24 < arg_55_1.time_ and arg_55_1.time_ <= var_58_24 + arg_58_0 then
				arg_55_1.var_.moveOldPos106103 = var_58_23.localPosition
				var_58_23.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("106103", 2)

				local var_58_25 = var_58_23.childCount

				for iter_58_9 = 0, var_58_25 - 1 do
					local var_58_26 = var_58_23:GetChild(iter_58_9)

					if var_58_26.name == "" or not string.find(var_58_26.name, "split") then
						var_58_26.gameObject:SetActive(true)
					else
						var_58_26.gameObject:SetActive(false)
					end
				end
			end

			local var_58_27 = 0.001

			if var_58_24 <= arg_55_1.time_ and arg_55_1.time_ < var_58_24 + var_58_27 then
				local var_58_28 = (arg_55_1.time_ - var_58_24) / var_58_27
				local var_58_29 = Vector3.New(-428.4, -398.2, -333.7)

				var_58_23.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos106103, var_58_29, var_58_28)
			end

			if arg_55_1.time_ >= var_58_24 + var_58_27 and arg_55_1.time_ < var_58_24 + var_58_27 + arg_58_0 then
				var_58_23.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_58_30 = 0
			local var_58_31 = 0.875

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_32 = arg_55_1:FormatText(StoryNameCfg[612].name)

				arg_55_1.leftNameTxt_.text = var_58_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_33 = arg_55_1:GetWordFromCfg(926052013)
				local var_58_34 = arg_55_1:FormatText(var_58_33.content)

				arg_55_1.text_.text = var_58_34

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_35 = 35
				local var_58_36 = utf8.len(var_58_34)
				local var_58_37 = var_58_35 <= 0 and var_58_31 or var_58_31 * (var_58_36 / var_58_35)

				if var_58_37 > 0 and var_58_31 < var_58_37 then
					arg_55_1.talkMaxDuration = var_58_37

					if var_58_37 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_37 + var_58_30
					end
				end

				arg_55_1.text_.text = var_58_34
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052013", "story_v_out_926052.awb") ~= 0 then
					local var_58_38 = manager.audio:GetVoiceLength("story_v_out_926052", "926052013", "story_v_out_926052.awb") / 1000

					if var_58_38 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_38 + var_58_30
					end

					if var_58_33.prefab_name ~= "" and arg_55_1.actors_[var_58_33.prefab_name] ~= nil then
						local var_58_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_33.prefab_name].transform, "story_v_out_926052", "926052013", "story_v_out_926052.awb")

						arg_55_1:RecordAudio("926052013", var_58_39)
						arg_55_1:RecordAudio("926052013", var_58_39)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_926052", "926052013", "story_v_out_926052.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_926052", "926052013", "story_v_out_926052.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_40 = math.max(var_58_31, arg_55_1.talkMaxDuration)

			if var_58_30 <= arg_55_1.time_ and arg_55_1.time_ < var_58_30 + var_58_40 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_30) / var_58_40

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_30 + var_58_40 and arg_55_1.time_ < var_58_30 + var_58_40 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play926052014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 926052014
		arg_59_1.duration_ = 11.27

		local var_59_0 = {
			zh = 8.566,
			ja = 11.266
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
				arg_59_0:Play926052015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["106603"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps106603 == nil then
				arg_59_1.var_.actorSpriteComps106603 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps106603 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 1, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps106603 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps106603 = nil
			end

			local var_62_8 = arg_59_1.actors_["106103"]
			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps106103 == nil then
				arg_59_1.var_.actorSpriteComps106103 = var_62_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_10 = 0.2

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_10 and not isNil(var_62_8) then
				local var_62_11 = (arg_59_1.time_ - var_62_9) / var_62_10

				if arg_59_1.var_.actorSpriteComps106103 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								local var_62_12 = Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, var_62_11)
								local var_62_13 = Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, var_62_11)
								local var_62_14 = Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, var_62_11)

								iter_62_5.color = Color.New(var_62_12, var_62_13, var_62_14)
							else
								local var_62_15 = Mathf.Lerp(iter_62_5.color.r, 0.5, var_62_11)

								iter_62_5.color = Color.New(var_62_15, var_62_15, var_62_15)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps106103 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_62_7 then
						if arg_59_1.isInRecall_ then
							iter_62_7.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps106103 = nil
			end

			local var_62_16 = 0
			local var_62_17 = 1

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_18 = arg_59_1:FormatText(StoryNameCfg[32].name)

				arg_59_1.leftNameTxt_.text = var_62_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_19 = arg_59_1:GetWordFromCfg(926052014)
				local var_62_20 = arg_59_1:FormatText(var_62_19.content)

				arg_59_1.text_.text = var_62_20

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_21 = 40
				local var_62_22 = utf8.len(var_62_20)
				local var_62_23 = var_62_21 <= 0 and var_62_17 or var_62_17 * (var_62_22 / var_62_21)

				if var_62_23 > 0 and var_62_17 < var_62_23 then
					arg_59_1.talkMaxDuration = var_62_23

					if var_62_23 + var_62_16 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_16
					end
				end

				arg_59_1.text_.text = var_62_20
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052014", "story_v_out_926052.awb") ~= 0 then
					local var_62_24 = manager.audio:GetVoiceLength("story_v_out_926052", "926052014", "story_v_out_926052.awb") / 1000

					if var_62_24 + var_62_16 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_24 + var_62_16
					end

					if var_62_19.prefab_name ~= "" and arg_59_1.actors_[var_62_19.prefab_name] ~= nil then
						local var_62_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_19.prefab_name].transform, "story_v_out_926052", "926052014", "story_v_out_926052.awb")

						arg_59_1:RecordAudio("926052014", var_62_25)
						arg_59_1:RecordAudio("926052014", var_62_25)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_926052", "926052014", "story_v_out_926052.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_926052", "926052014", "story_v_out_926052.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_26 = math.max(var_62_17, arg_59_1.talkMaxDuration)

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_26 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_16) / var_62_26

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_16 + var_62_26 and arg_59_1.time_ < var_62_16 + var_62_26 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play926052015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 926052015
		arg_63_1.duration_ = 9.67

		local var_63_0 = {
			zh = 5.533,
			ja = 9.666
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play926052016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.7

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[32].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(926052015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 28
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052015", "story_v_out_926052.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052015", "story_v_out_926052.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_926052", "926052015", "story_v_out_926052.awb")

						arg_63_1:RecordAudio("926052015", var_66_9)
						arg_63_1:RecordAudio("926052015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_926052", "926052015", "story_v_out_926052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_926052", "926052015", "story_v_out_926052.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play926052016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 926052016
		arg_67_1.duration_ = 6.63

		local var_67_0 = {
			zh = 4.7,
			ja = 6.633
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
				arg_67_0:Play926052017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["106603"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos106603 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("106603", 4)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "split_1" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(453.9, -399.1, -303.3)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos106603, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_70_7 = 0
			local var_70_8 = 0.6

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_9 = arg_67_1:FormatText(StoryNameCfg[32].name)

				arg_67_1.leftNameTxt_.text = var_70_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:GetWordFromCfg(926052016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_12 = 24
				local var_70_13 = utf8.len(var_70_11)
				local var_70_14 = var_70_12 <= 0 and var_70_8 or var_70_8 * (var_70_13 / var_70_12)

				if var_70_14 > 0 and var_70_8 < var_70_14 then
					arg_67_1.talkMaxDuration = var_70_14

					if var_70_14 + var_70_7 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_7
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052016", "story_v_out_926052.awb") ~= 0 then
					local var_70_15 = manager.audio:GetVoiceLength("story_v_out_926052", "926052016", "story_v_out_926052.awb") / 1000

					if var_70_15 + var_70_7 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_7
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_926052", "926052016", "story_v_out_926052.awb")

						arg_67_1:RecordAudio("926052016", var_70_16)
						arg_67_1:RecordAudio("926052016", var_70_16)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_926052", "926052016", "story_v_out_926052.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_926052", "926052016", "story_v_out_926052.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_17 = math.max(var_70_8, arg_67_1.talkMaxDuration)

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_17 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_7) / var_70_17

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_7 + var_70_17 and arg_67_1.time_ < var_70_7 + var_70_17 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play926052017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 926052017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play926052018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["106603"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps106603 == nil then
				arg_71_1.var_.actorSpriteComps106603 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps106603 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								local var_74_4 = Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, var_74_3)
								local var_74_5 = Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, var_74_3)
								local var_74_6 = Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, var_74_3)

								iter_74_1.color = Color.New(var_74_4, var_74_5, var_74_6)
							else
								local var_74_7 = Mathf.Lerp(iter_74_1.color.r, 0.5, var_74_3)

								iter_74_1.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps106603 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_74_3 then
						if arg_71_1.isInRecall_ then
							iter_74_3.color = arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_74_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps106603 = nil
			end

			local var_74_8 = 0
			local var_74_9 = 0.65

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_10 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_10

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

				local var_74_11 = arg_71_1:GetWordFromCfg(926052017)
				local var_74_12 = arg_71_1:FormatText(var_74_11.content)

				arg_71_1.text_.text = var_74_12

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 26
				local var_74_14 = utf8.len(var_74_12)
				local var_74_15 = var_74_13 <= 0 and var_74_9 or var_74_9 * (var_74_14 / var_74_13)

				if var_74_15 > 0 and var_74_9 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_12
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play926052018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 926052018
		arg_75_1.duration_ = 4.27

		local var_75_0 = {
			zh = 2.533,
			ja = 4.266
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
				arg_75_0:Play926052019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["104701"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps104701 == nil then
				arg_75_1.var_.actorSpriteComps104701 = var_78_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.actorSpriteComps104701 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								local var_78_4 = Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, var_78_3)
								local var_78_5 = Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, var_78_3)
								local var_78_6 = Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, var_78_3)

								iter_78_1.color = Color.New(var_78_4, var_78_5, var_78_6)
							else
								local var_78_7 = Mathf.Lerp(iter_78_1.color.r, 1, var_78_3)

								iter_78_1.color = Color.New(var_78_7, var_78_7, var_78_7)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.actorSpriteComps104701 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_78_3 then
						if arg_75_1.isInRecall_ then
							iter_78_3.color = arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_78_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_75_1.var_.actorSpriteComps104701 = nil
			end

			local var_78_8 = 0
			local var_78_9 = 0.275

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_10 = arg_75_1:FormatText(StoryNameCfg[1296].name)

				arg_75_1.leftNameTxt_.text = var_78_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_11 = arg_75_1:GetWordFromCfg(926052018)
				local var_78_12 = arg_75_1:FormatText(var_78_11.content)

				arg_75_1.text_.text = var_78_12

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 11
				local var_78_14 = utf8.len(var_78_12)
				local var_78_15 = var_78_13 <= 0 and var_78_9 or var_78_9 * (var_78_14 / var_78_13)

				if var_78_15 > 0 and var_78_9 < var_78_15 then
					arg_75_1.talkMaxDuration = var_78_15

					if var_78_15 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_15 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_12
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052018", "story_v_out_926052.awb") ~= 0 then
					local var_78_16 = manager.audio:GetVoiceLength("story_v_out_926052", "926052018", "story_v_out_926052.awb") / 1000

					if var_78_16 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_16 + var_78_8
					end

					if var_78_11.prefab_name ~= "" and arg_75_1.actors_[var_78_11.prefab_name] ~= nil then
						local var_78_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_11.prefab_name].transform, "story_v_out_926052", "926052018", "story_v_out_926052.awb")

						arg_75_1:RecordAudio("926052018", var_78_17)
						arg_75_1:RecordAudio("926052018", var_78_17)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_926052", "926052018", "story_v_out_926052.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_926052", "926052018", "story_v_out_926052.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_18 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_18 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_18

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_18 and arg_75_1.time_ < var_78_8 + var_78_18 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play926052019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 926052019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play926052020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["104701"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps104701 == nil then
				arg_79_1.var_.actorSpriteComps104701 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps104701 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								local var_82_4 = Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, var_82_3)
								local var_82_5 = Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, var_82_3)
								local var_82_6 = Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, var_82_3)

								iter_82_1.color = Color.New(var_82_4, var_82_5, var_82_6)
							else
								local var_82_7 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

								iter_82_1.color = Color.New(var_82_7, var_82_7, var_82_7)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.actorSpriteComps104701 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_82_3 then
						if arg_79_1.isInRecall_ then
							iter_82_3.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps104701 = nil
			end

			local var_82_8 = arg_79_1.actors_["106103"].transform
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 then
				arg_79_1.var_.moveOldPos106103 = var_82_8.localPosition
				var_82_8.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("106103", 7)

				local var_82_10 = var_82_8.childCount

				for iter_82_4 = 0, var_82_10 - 1 do
					local var_82_11 = var_82_8:GetChild(iter_82_4)

					if var_82_11.name == "" or not string.find(var_82_11.name, "split") then
						var_82_11.gameObject:SetActive(true)
					else
						var_82_11.gameObject:SetActive(false)
					end
				end
			end

			local var_82_12 = 0.001

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_9) / var_82_12
				local var_82_14 = Vector3.New(0, -2000, 0)

				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos106103, var_82_14, var_82_13)
			end

			if arg_79_1.time_ >= var_82_9 + var_82_12 and arg_79_1.time_ < var_82_9 + var_82_12 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_15 = arg_79_1.actors_["106603"].transform
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.var_.moveOldPos106603 = var_82_15.localPosition
				var_82_15.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("106603", 7)

				local var_82_17 = var_82_15.childCount

				for iter_82_5 = 0, var_82_17 - 1 do
					local var_82_18 = var_82_15:GetChild(iter_82_5)

					if var_82_18.name == "" or not string.find(var_82_18.name, "split") then
						var_82_18.gameObject:SetActive(true)
					else
						var_82_18.gameObject:SetActive(false)
					end
				end
			end

			local var_82_19 = 0.001

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_19 then
				local var_82_20 = (arg_79_1.time_ - var_82_16) / var_82_19
				local var_82_21 = Vector3.New(0, -2000, 0)

				var_82_15.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos106603, var_82_21, var_82_20)
			end

			if arg_79_1.time_ >= var_82_16 + var_82_19 and arg_79_1.time_ < var_82_16 + var_82_19 + arg_82_0 then
				var_82_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_22 = 0
			local var_82_23 = 1.325

			if var_82_22 < arg_79_1.time_ and arg_79_1.time_ <= var_82_22 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(926052019)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 53
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_23 or var_82_23 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_23 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_22 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_22
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_29 = math.max(var_82_23, arg_79_1.talkMaxDuration)

			if var_82_22 <= arg_79_1.time_ and arg_79_1.time_ < var_82_22 + var_82_29 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_22) / var_82_29

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_22 + var_82_29 and arg_79_1.time_ < var_82_22 + var_82_29 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play926052020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 926052020
		arg_83_1.duration_ = 4.43

		local var_83_0 = {
			zh = 2.7,
			ja = 4.433
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
				arg_83_0:Play926052021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["104701"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps104701 == nil then
				arg_83_1.var_.actorSpriteComps104701 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps104701 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_4 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, var_86_3)
								local var_86_5 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, var_86_3)
								local var_86_6 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, var_86_3)

								iter_86_1.color = Color.New(var_86_4, var_86_5, var_86_6)
							else
								local var_86_7 = Mathf.Lerp(iter_86_1.color.r, 1, var_86_3)

								iter_86_1.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps104701 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps104701 = nil
			end

			local var_86_8 = arg_83_1.actors_["104701"].transform
			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.var_.moveOldPos104701 = var_86_8.localPosition
				var_86_8.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("104701", 3)

				local var_86_10 = var_86_8.childCount

				for iter_86_4 = 0, var_86_10 - 1 do
					local var_86_11 = var_86_8:GetChild(iter_86_4)

					if var_86_11.name == "" or not string.find(var_86_11.name, "split") then
						var_86_11.gameObject:SetActive(true)
					else
						var_86_11.gameObject:SetActive(false)
					end
				end
			end

			local var_86_12 = 0.001

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_9) / var_86_12
				local var_86_14 = Vector3.New(-67.4, -386.8, -295)

				var_86_8.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos104701, var_86_14, var_86_13)
			end

			if arg_83_1.time_ >= var_86_9 + var_86_12 and arg_83_1.time_ < var_86_9 + var_86_12 + arg_86_0 then
				var_86_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_86_15 = 0
			local var_86_16 = 0.325

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[1296].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(926052020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 13
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052020", "story_v_out_926052.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_926052", "926052020", "story_v_out_926052.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_926052", "926052020", "story_v_out_926052.awb")

						arg_83_1:RecordAudio("926052020", var_86_24)
						arg_83_1:RecordAudio("926052020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_926052", "926052020", "story_v_out_926052.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_926052", "926052020", "story_v_out_926052.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_25 and arg_83_1.time_ < var_86_15 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play926052021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 926052021
		arg_87_1.duration_ = 5.2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play926052022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "10144"

			if arg_87_1.actors_[var_90_0] == nil then
				local var_90_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_90_1) then
					local var_90_2 = Object.Instantiate(var_90_1, arg_87_1.canvasGo_.transform)

					var_90_2.transform:SetSiblingIndex(1)

					var_90_2.name = var_90_0
					var_90_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_[var_90_0] = var_90_2

					local var_90_3 = var_90_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_87_1.isInRecall_ then
						for iter_90_0, iter_90_1 in ipairs(var_90_3) do
							iter_90_1.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_4 = arg_87_1.actors_["10144"]
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.actorSpriteComps10144 == nil then
				arg_87_1.var_.actorSpriteComps10144 = var_90_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.2

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 and not isNil(var_90_4) then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6

				if arg_87_1.var_.actorSpriteComps10144 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								local var_90_8 = Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor1.r, var_90_7)
								local var_90_9 = Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor1.g, var_90_7)
								local var_90_10 = Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor1.b, var_90_7)

								iter_90_3.color = Color.New(var_90_8, var_90_9, var_90_10)
							else
								local var_90_11 = Mathf.Lerp(iter_90_3.color.r, 1, var_90_7)

								iter_90_3.color = Color.New(var_90_11, var_90_11, var_90_11)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.actorSpriteComps10144 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_90_5 then
						if arg_87_1.isInRecall_ then
							iter_90_5.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10144 = nil
			end

			local var_90_12 = arg_87_1.actors_["104701"]
			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 and not isNil(var_90_12) and arg_87_1.var_.actorSpriteComps104701 == nil then
				arg_87_1.var_.actorSpriteComps104701 = var_90_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_14 = 0.2

			if var_90_13 <= arg_87_1.time_ and arg_87_1.time_ < var_90_13 + var_90_14 and not isNil(var_90_12) then
				local var_90_15 = (arg_87_1.time_ - var_90_13) / var_90_14

				if arg_87_1.var_.actorSpriteComps104701 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								local var_90_16 = Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor2.r, var_90_15)
								local var_90_17 = Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor2.g, var_90_15)
								local var_90_18 = Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor2.b, var_90_15)

								iter_90_7.color = Color.New(var_90_16, var_90_17, var_90_18)
							else
								local var_90_19 = Mathf.Lerp(iter_90_7.color.r, 0.5, var_90_15)

								iter_90_7.color = Color.New(var_90_19, var_90_19, var_90_19)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_13 + var_90_14 and arg_87_1.time_ < var_90_13 + var_90_14 + arg_90_0 and not isNil(var_90_12) and arg_87_1.var_.actorSpriteComps104701 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_90_9 then
						if arg_87_1.isInRecall_ then
							iter_90_9.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps104701 = nil
			end

			local var_90_20 = arg_87_1.actors_["104701"].transform
			local var_90_21 = 0

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.var_.moveOldPos104701 = var_90_20.localPosition
				var_90_20.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("104701", 7)

				local var_90_22 = var_90_20.childCount

				for iter_90_10 = 0, var_90_22 - 1 do
					local var_90_23 = var_90_20:GetChild(iter_90_10)

					if var_90_23.name == "" or not string.find(var_90_23.name, "split") then
						var_90_23.gameObject:SetActive(true)
					else
						var_90_23.gameObject:SetActive(false)
					end
				end
			end

			local var_90_24 = 0.001

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_24 then
				local var_90_25 = (arg_87_1.time_ - var_90_21) / var_90_24
				local var_90_26 = Vector3.New(0, -2000, 0)

				var_90_20.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos104701, var_90_26, var_90_25)
			end

			if arg_87_1.time_ >= var_90_21 + var_90_24 and arg_87_1.time_ < var_90_21 + var_90_24 + arg_90_0 then
				var_90_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_27 = arg_87_1.actors_["10144"].transform
			local var_90_28 = 0

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 then
				arg_87_1.var_.moveOldPos10144 = var_90_27.localPosition
				var_90_27.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10144", 4)

				local var_90_29 = var_90_27.childCount

				for iter_90_11 = 0, var_90_29 - 1 do
					local var_90_30 = var_90_27:GetChild(iter_90_11)

					if var_90_30.name == "split_5" or not string.find(var_90_30.name, "split") then
						var_90_30.gameObject:SetActive(true)
					else
						var_90_30.gameObject:SetActive(false)
					end
				end
			end

			local var_90_31 = 0.001

			if var_90_28 <= arg_87_1.time_ and arg_87_1.time_ < var_90_28 + var_90_31 then
				local var_90_32 = (arg_87_1.time_ - var_90_28) / var_90_31
				local var_90_33 = Vector3.New(556.3, -365.9, 337)

				var_90_27.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10144, var_90_33, var_90_32)
			end

			if arg_87_1.time_ >= var_90_28 + var_90_31 and arg_87_1.time_ < var_90_28 + var_90_31 + arg_90_0 then
				var_90_27.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_90_34 = arg_87_1.story_ui_effectTrs_.transform
			local var_90_35 = 0.2

			if var_90_35 < arg_87_1.time_ and arg_87_1.time_ <= var_90_35 + arg_90_0 then
				local var_90_36 = arg_87_1.var_.effect798
				local var_90_37
				local var_90_38 = var_90_34

				if not var_90_36 then
					var_90_36 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_heimu_keep"), var_90_38)
					var_90_36.name = "798"
					arg_87_1.var_.effect798 = var_90_36
				else
					var_90_36.transform:SetParent(var_90_38)
				end

				var_90_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_90_36.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_90_39 = manager.ui.mainCameraCom_
				local var_90_40 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_90_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_90_41 = var_90_36.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_90_42 = 15
				local var_90_43 = 2 * var_90_42 * Mathf.Tan(var_90_39.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_90_39.aspect
				local var_90_44 = 1
				local var_90_45 = 1.7777777777777777

				if var_90_45 < var_90_39.aspect then
					var_90_44 = var_90_43 / (2 * var_90_42 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_90_45)
				end

				for iter_90_12, iter_90_13 in ipairs(var_90_41) do
					local var_90_46 = iter_90_13.transform.localScale

					iter_90_13.transform.localScale = Vector3.New(var_90_46.x / var_90_40 * var_90_44, var_90_46.y / var_90_40, var_90_46.z)
				end
			end

			local var_90_47 = manager.ui.mainCamera.transform
			local var_90_48 = 0

			if var_90_48 < arg_87_1.time_ and arg_87_1.time_ <= var_90_48 + arg_90_0 then
				local var_90_49 = arg_87_1.var_.effect777
				local var_90_50
				local var_90_51 = var_90_47

				if not var_90_49 then
					var_90_49 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_voice_keep"), var_90_51)
					var_90_49.name = "777"
					arg_87_1.var_.effect777 = var_90_49
				else
					var_90_49.transform:SetParent(var_90_51)
				end

				var_90_49.transform.localPosition = Vector3.New(-0.07, 0, 1.46)
				var_90_49.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_90_52 = arg_87_1.actors_["10144"]
			local var_90_53 = 0

			if var_90_53 < arg_87_1.time_ and arg_87_1.time_ <= var_90_53 + arg_90_0 then
				local var_90_54 = var_90_52:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_54 then
					arg_87_1.var_.alphaOldValue10144 = var_90_54.alpha
					arg_87_1.var_.characterEffect10144 = var_90_54
				end

				arg_87_1.var_.alphaOldValue10144 = 0
			end

			local var_90_55 = 0.566666666666667

			if var_90_53 <= arg_87_1.time_ and arg_87_1.time_ < var_90_53 + var_90_55 then
				local var_90_56 = (arg_87_1.time_ - var_90_53) / var_90_55
				local var_90_57 = Mathf.Lerp(arg_87_1.var_.alphaOldValue10144, 1, var_90_56)

				if arg_87_1.var_.characterEffect10144 then
					arg_87_1.var_.characterEffect10144.alpha = var_90_57
				end
			end

			if arg_87_1.time_ >= var_90_53 + var_90_55 and arg_87_1.time_ < var_90_53 + var_90_55 + arg_90_0 and arg_87_1.var_.characterEffect10144 then
				arg_87_1.var_.characterEffect10144.alpha = 1
			end

			local var_90_58 = 0.733333333333333
			local var_90_59 = 1

			if var_90_58 < arg_87_1.time_ and arg_87_1.time_ <= var_90_58 + arg_90_0 then
				local var_90_60 = "play"
				local var_90_61 = "effect"

				arg_87_1:AudioAction(var_90_60, var_90_61, "se_story_143", "se_story_143_action_summer1_story_intense_down", "")
			end

			local var_90_62 = 0
			local var_90_63 = 1

			if var_90_62 < arg_87_1.time_ and arg_87_1.time_ <= var_90_62 + arg_90_0 then
				local var_90_64 = "play"
				local var_90_65 = "effect"

				arg_87_1:AudioAction(var_90_64, var_90_65, "se_story_143", "se_story_143_volume_down", "")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_66 = 1.63333333333333
			local var_90_67 = 0.15

			if var_90_66 < arg_87_1.time_ and arg_87_1.time_ <= var_90_66 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_68 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_68:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_69 = arg_87_1:FormatText(StoryNameCfg[1297].name)

				arg_87_1.leftNameTxt_.text = var_90_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_70 = arg_87_1:GetWordFromCfg(926052021)
				local var_90_71 = arg_87_1:FormatText(var_90_70.content)

				arg_87_1.text_.text = var_90_71

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_72 = 6
				local var_90_73 = utf8.len(var_90_71)
				local var_90_74 = var_90_72 <= 0 and var_90_67 or var_90_67 * (var_90_73 / var_90_72)

				if var_90_74 > 0 and var_90_67 < var_90_74 then
					arg_87_1.talkMaxDuration = var_90_74
					var_90_66 = var_90_66 + 0.3

					if var_90_74 + var_90_66 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_74 + var_90_66
					end
				end

				arg_87_1.text_.text = var_90_71
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052021", "story_v_out_926052.awb") ~= 0 then
					local var_90_75 = manager.audio:GetVoiceLength("story_v_out_926052", "926052021", "story_v_out_926052.awb") / 1000

					if var_90_75 + var_90_66 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_75 + var_90_66
					end

					if var_90_70.prefab_name ~= "" and arg_87_1.actors_[var_90_70.prefab_name] ~= nil then
						local var_90_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_70.prefab_name].transform, "story_v_out_926052", "926052021", "story_v_out_926052.awb")

						arg_87_1:RecordAudio("926052021", var_90_76)
						arg_87_1:RecordAudio("926052021", var_90_76)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_926052", "926052021", "story_v_out_926052.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_926052", "926052021", "story_v_out_926052.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_77 = var_90_66 + 0.3
			local var_90_78 = math.max(var_90_67, arg_87_1.talkMaxDuration)

			if var_90_77 <= arg_87_1.time_ and arg_87_1.time_ < var_90_77 + var_90_78 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_77) / var_90_78

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_77 + var_90_78 and arg_87_1.time_ < var_90_77 + var_90_78 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play926052022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926052022
		arg_93_1.duration_ = 10.63

		local var_93_0 = {
			zh = 5.533,
			ja = 10.633
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
				arg_93_0:Play926052023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.725

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1297].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(926052022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 29
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052022", "story_v_out_926052.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052022", "story_v_out_926052.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_926052", "926052022", "story_v_out_926052.awb")

						arg_93_1:RecordAudio("926052022", var_96_9)
						arg_93_1:RecordAudio("926052022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926052", "926052022", "story_v_out_926052.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926052", "926052022", "story_v_out_926052.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play926052023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926052023
		arg_97_1.duration_ = 3.47

		local var_97_0 = {
			zh = 3.466,
			ja = 3.433
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
				arg_97_0:Play926052024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10144"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10144 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10144", 4)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_6" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(556.3, -365.9, 337)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10144, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_100_7 = 0
			local var_100_8 = 0.5

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_9 = arg_97_1:FormatText(StoryNameCfg[1297].name)

				arg_97_1.leftNameTxt_.text = var_100_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(926052023)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 20
				local var_100_13 = utf8.len(var_100_11)
				local var_100_14 = var_100_12 <= 0 and var_100_8 or var_100_8 * (var_100_13 / var_100_12)

				if var_100_14 > 0 and var_100_8 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14

					if var_100_14 + var_100_7 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_7
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052023", "story_v_out_926052.awb") ~= 0 then
					local var_100_15 = manager.audio:GetVoiceLength("story_v_out_926052", "926052023", "story_v_out_926052.awb") / 1000

					if var_100_15 + var_100_7 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_7
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_926052", "926052023", "story_v_out_926052.awb")

						arg_97_1:RecordAudio("926052023", var_100_16)
						arg_97_1:RecordAudio("926052023", var_100_16)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_926052", "926052023", "story_v_out_926052.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_926052", "926052023", "story_v_out_926052.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_17 = math.max(var_100_8, arg_97_1.talkMaxDuration)

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_17 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_7) / var_100_17

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_7 + var_100_17 and arg_97_1.time_ < var_100_7 + var_100_17 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play926052024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926052024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play926052025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10144"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 0.5, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.3

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_10 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_10

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

				local var_104_11 = arg_101_1:GetWordFromCfg(926052024)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 12
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_9 or var_104_9 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_9 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
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

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play926052025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926052025
		arg_105_1.duration_ = 10.53

		local var_105_0 = {
			zh = 6.8,
			ja = 10.533
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
				arg_105_0:Play926052026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10144"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10144 == nil then
				arg_105_1.var_.actorSpriteComps10144 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10144 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10144 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10144 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.85

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[1297].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_11 = arg_105_1:GetWordFromCfg(926052025)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 34
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_9 or var_108_9 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_9 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052025", "story_v_out_926052.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_926052", "926052025", "story_v_out_926052.awb") / 1000

					if var_108_16 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_8
					end

					if var_108_11.prefab_name ~= "" and arg_105_1.actors_[var_108_11.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_11.prefab_name].transform, "story_v_out_926052", "926052025", "story_v_out_926052.awb")

						arg_105_1:RecordAudio("926052025", var_108_17)
						arg_105_1:RecordAudio("926052025", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_926052", "926052025", "story_v_out_926052.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_926052", "926052025", "story_v_out_926052.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_18 and arg_105_1.time_ < var_108_8 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926052026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926052026
		arg_109_1.duration_ = 5.3

		local var_109_0 = {
			zh = 3.8,
			ja = 5.3
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
				arg_109_0:Play926052027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10144"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10144 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10144", 4)

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
				local var_112_6 = Vector3.New(556.3, -365.9, 337)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10144, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_112_7 = 0
			local var_112_8 = 0.525

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_9 = arg_109_1:FormatText(StoryNameCfg[1297].name)

				arg_109_1.leftNameTxt_.text = var_112_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(926052026)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 21
				local var_112_13 = utf8.len(var_112_11)
				local var_112_14 = var_112_12 <= 0 and var_112_8 or var_112_8 * (var_112_13 / var_112_12)

				if var_112_14 > 0 and var_112_8 < var_112_14 then
					arg_109_1.talkMaxDuration = var_112_14

					if var_112_14 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_7
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052026", "story_v_out_926052.awb") ~= 0 then
					local var_112_15 = manager.audio:GetVoiceLength("story_v_out_926052", "926052026", "story_v_out_926052.awb") / 1000

					if var_112_15 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_7
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_926052", "926052026", "story_v_out_926052.awb")

						arg_109_1:RecordAudio("926052026", var_112_16)
						arg_109_1:RecordAudio("926052026", var_112_16)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926052", "926052026", "story_v_out_926052.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926052", "926052026", "story_v_out_926052.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_17 = math.max(var_112_8, arg_109_1.talkMaxDuration)

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_17 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_7) / var_112_17

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_7 + var_112_17 and arg_109_1.time_ < var_112_7 + var_112_17 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play926052027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926052027
		arg_113_1.duration_ = 4.5

		local var_113_0 = {
			zh = 3,
			ja = 4.5
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
				arg_113_0:Play926052028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.45

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[1297].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(926052027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052027", "story_v_out_926052.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052027", "story_v_out_926052.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_926052", "926052027", "story_v_out_926052.awb")

						arg_113_1:RecordAudio("926052027", var_116_9)
						arg_113_1:RecordAudio("926052027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926052", "926052027", "story_v_out_926052.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926052", "926052027", "story_v_out_926052.awb")
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
	Play926052028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926052028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play926052029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10144"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_8 = arg_117_1.actors_["10144"].transform
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 7)

				local var_120_10 = var_120_8.childCount

				for iter_120_4 = 0, var_120_10 - 1 do
					local var_120_11 = var_120_8:GetChild(iter_120_4)

					if var_120_11.name == "" or not string.find(var_120_11.name, "split") then
						var_120_11.gameObject:SetActive(true)
					else
						var_120_11.gameObject:SetActive(false)
					end
				end
			end

			local var_120_12 = 0.001

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_12 then
				local var_120_13 = (arg_117_1.time_ - var_120_9) / var_120_12
				local var_120_14 = Vector3.New(0, -2000, 0)

				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, var_120_14, var_120_13)
			end

			if arg_117_1.time_ >= var_120_9 + var_120_12 and arg_117_1.time_ < var_120_9 + var_120_12 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_15 = 0
			local var_120_16 = 0.675

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_17 = arg_117_1:GetWordFromCfg(926052028)
				local var_120_18 = arg_117_1:FormatText(var_120_17.content)

				arg_117_1.text_.text = var_120_18

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_19 = 27
				local var_120_20 = utf8.len(var_120_18)
				local var_120_21 = var_120_19 <= 0 and var_120_16 or var_120_16 * (var_120_20 / var_120_19)

				if var_120_21 > 0 and var_120_16 < var_120_21 then
					arg_117_1.talkMaxDuration = var_120_21

					if var_120_21 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_21 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_18
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_22 and arg_117_1.time_ < var_120_15 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play926052029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926052029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play926052030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.75

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(926052029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 30
				local var_124_5 = utf8.len(var_124_3)
				local var_124_6 = var_124_4 <= 0 and var_124_1 or var_124_1 * (var_124_5 / var_124_4)

				if var_124_6 > 0 and var_124_1 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_7 and arg_121_1.time_ < var_124_0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play926052030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926052030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926052031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.375

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_2

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

				local var_128_3 = arg_125_1:GetWordFromCfg(926052030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 15
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926052031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926052031
		arg_129_1.duration_ = 2.5

		local var_129_0 = {
			zh = 2.5,
			ja = 2.4
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
				arg_129_0:Play926052032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["128404"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps128404 == nil then
				arg_129_1.var_.actorSpriteComps128404 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps128404 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps128404 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps128404 = nil
			end

			local var_132_8 = arg_129_1.actors_["128404"].transform
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.var_.moveOldPos128404 = var_132_8.localPosition
				var_132_8.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("128404", 2)

				local var_132_10 = var_132_8.childCount

				for iter_132_4 = 0, var_132_10 - 1 do
					local var_132_11 = var_132_8:GetChild(iter_132_4)

					if var_132_11.name == "split_4" or not string.find(var_132_11.name, "split") then
						var_132_11.gameObject:SetActive(true)
					else
						var_132_11.gameObject:SetActive(false)
					end
				end
			end

			local var_132_12 = 0.001

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_12 then
				local var_132_13 = (arg_129_1.time_ - var_132_9) / var_132_12
				local var_132_14 = Vector3.New(-477.4, -374.11, 163.8)

				var_132_8.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos128404, var_132_14, var_132_13)
			end

			if arg_129_1.time_ >= var_132_9 + var_132_12 and arg_129_1.time_ < var_132_9 + var_132_12 + arg_132_0 then
				var_132_8.localPosition = Vector3.New(-477.4, -374.11, 163.8)
			end

			local var_132_15 = 0
			local var_132_16 = 0.225

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(926052031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 9
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052031", "story_v_out_926052.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_926052", "926052031", "story_v_out_926052.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_926052", "926052031", "story_v_out_926052.awb")

						arg_129_1:RecordAudio("926052031", var_132_24)
						arg_129_1:RecordAudio("926052031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926052", "926052031", "story_v_out_926052.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926052", "926052031", "story_v_out_926052.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play926052032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926052032
		arg_133_1.duration_ = 6.07

		local var_133_0 = {
			zh = 3,
			ja = 6.066
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
				arg_133_0:Play926052033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10144"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10144 == nil then
				arg_133_1.var_.actorSpriteComps10144 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps10144 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 1, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps10144 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10144 = nil
			end

			local var_136_8 = arg_133_1.actors_["128404"]
			local var_136_9 = 0

			if var_136_9 < arg_133_1.time_ and arg_133_1.time_ <= var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps128404 == nil then
				arg_133_1.var_.actorSpriteComps128404 = var_136_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_10 = 0.2

			if var_136_9 <= arg_133_1.time_ and arg_133_1.time_ < var_136_9 + var_136_10 and not isNil(var_136_8) then
				local var_136_11 = (arg_133_1.time_ - var_136_9) / var_136_10

				if arg_133_1.var_.actorSpriteComps128404 then
					for iter_136_4, iter_136_5 in pairs(arg_133_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_136_5 then
							if arg_133_1.isInRecall_ then
								local var_136_12 = Mathf.Lerp(iter_136_5.color.r, arg_133_1.hightColor2.r, var_136_11)
								local var_136_13 = Mathf.Lerp(iter_136_5.color.g, arg_133_1.hightColor2.g, var_136_11)
								local var_136_14 = Mathf.Lerp(iter_136_5.color.b, arg_133_1.hightColor2.b, var_136_11)

								iter_136_5.color = Color.New(var_136_12, var_136_13, var_136_14)
							else
								local var_136_15 = Mathf.Lerp(iter_136_5.color.r, 0.5, var_136_11)

								iter_136_5.color = Color.New(var_136_15, var_136_15, var_136_15)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_9 + var_136_10 and arg_133_1.time_ < var_136_9 + var_136_10 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.actorSpriteComps128404 then
				for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_136_7 then
						if arg_133_1.isInRecall_ then
							iter_136_7.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps128404 = nil
			end

			local var_136_16 = arg_133_1.actors_["10144"].transform
			local var_136_17 = 0

			if var_136_17 < arg_133_1.time_ and arg_133_1.time_ <= var_136_17 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = var_136_16.localPosition
				var_136_16.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 4)

				local var_136_18 = var_136_16.childCount

				for iter_136_8 = 0, var_136_18 - 1 do
					local var_136_19 = var_136_16:GetChild(iter_136_8)

					if var_136_19.name == "split_6" or not string.find(var_136_19.name, "split") then
						var_136_19.gameObject:SetActive(true)
					else
						var_136_19.gameObject:SetActive(false)
					end
				end
			end

			local var_136_20 = 0.001

			if var_136_17 <= arg_133_1.time_ and arg_133_1.time_ < var_136_17 + var_136_20 then
				local var_136_21 = (arg_133_1.time_ - var_136_17) / var_136_20
				local var_136_22 = Vector3.New(556.3, -365.9, 337)

				var_136_16.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, var_136_22, var_136_21)
			end

			if arg_133_1.time_ >= var_136_17 + var_136_20 and arg_133_1.time_ < var_136_17 + var_136_20 + arg_136_0 then
				var_136_16.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_136_23 = 0
			local var_136_24 = 0.4

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_25 = arg_133_1:FormatText(StoryNameCfg[1297].name)

				arg_133_1.leftNameTxt_.text = var_136_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_26 = arg_133_1:GetWordFromCfg(926052032)
				local var_136_27 = arg_133_1:FormatText(var_136_26.content)

				arg_133_1.text_.text = var_136_27

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 16
				local var_136_29 = utf8.len(var_136_27)
				local var_136_30 = var_136_28 <= 0 and var_136_24 or var_136_24 * (var_136_29 / var_136_28)

				if var_136_30 > 0 and var_136_24 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30

					if var_136_30 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_27
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052032", "story_v_out_926052.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_926052", "926052032", "story_v_out_926052.awb") / 1000

					if var_136_31 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_23
					end

					if var_136_26.prefab_name ~= "" and arg_133_1.actors_[var_136_26.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_26.prefab_name].transform, "story_v_out_926052", "926052032", "story_v_out_926052.awb")

						arg_133_1:RecordAudio("926052032", var_136_32)
						arg_133_1:RecordAudio("926052032", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926052", "926052032", "story_v_out_926052.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926052", "926052032", "story_v_out_926052.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_33 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_33

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_33 and arg_133_1.time_ < var_136_23 + var_136_33 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play926052033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926052033
		arg_137_1.duration_ = 2.13

		local var_137_0 = {
			zh = 0.999999999999,
			ja = 2.133
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
				arg_137_0:Play926052034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.1

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1297].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(926052033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 4
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052033", "story_v_out_926052.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052033", "story_v_out_926052.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_926052", "926052033", "story_v_out_926052.awb")

						arg_137_1:RecordAudio("926052033", var_140_9)
						arg_137_1:RecordAudio("926052033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_926052", "926052033", "story_v_out_926052.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_926052", "926052033", "story_v_out_926052.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play926052034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926052034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926052035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10144"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_8 = arg_141_1.actors_["10144"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 7)

				local var_144_10 = var_144_8.childCount

				for iter_144_4 = 0, var_144_10 - 1 do
					local var_144_11 = var_144_8:GetChild(iter_144_4)

					if var_144_11.name == "" or not string.find(var_144_11.name, "split") then
						var_144_11.gameObject:SetActive(true)
					else
						var_144_11.gameObject:SetActive(false)
					end
				end
			end

			local var_144_12 = 0.001

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_9) / var_144_12
				local var_144_14 = Vector3.New(0, -2000, 0)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, var_144_14, var_144_13)
			end

			if arg_141_1.time_ >= var_144_9 + var_144_12 and arg_141_1.time_ < var_144_9 + var_144_12 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_15 = arg_141_1.actors_["128404"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos128404 = var_144_15.localPosition
				var_144_15.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("128404", 7)

				local var_144_17 = var_144_15.childCount

				for iter_144_5 = 0, var_144_17 - 1 do
					local var_144_18 = var_144_15:GetChild(iter_144_5)

					if var_144_18.name == "" or not string.find(var_144_18.name, "split") then
						var_144_18.gameObject:SetActive(true)
					else
						var_144_18.gameObject:SetActive(false)
					end
				end
			end

			local var_144_19 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_19 then
				local var_144_20 = (arg_141_1.time_ - var_144_16) / var_144_19
				local var_144_21 = Vector3.New(0, -2000, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos128404, var_144_21, var_144_20)
			end

			if arg_141_1.time_ >= var_144_16 + var_144_19 and arg_141_1.time_ < var_144_16 + var_144_19 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_22 = 0
			local var_144_23 = 0.775

			if var_144_22 < arg_141_1.time_ and arg_141_1.time_ <= var_144_22 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_24 = arg_141_1:GetWordFromCfg(926052034)
				local var_144_25 = arg_141_1:FormatText(var_144_24.content)

				arg_141_1.text_.text = var_144_25

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_26 = 31
				local var_144_27 = utf8.len(var_144_25)
				local var_144_28 = var_144_26 <= 0 and var_144_23 or var_144_23 * (var_144_27 / var_144_26)

				if var_144_28 > 0 and var_144_23 < var_144_28 then
					arg_141_1.talkMaxDuration = var_144_28

					if var_144_28 + var_144_22 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_22
					end
				end

				arg_141_1.text_.text = var_144_25
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_29 = math.max(var_144_23, arg_141_1.talkMaxDuration)

			if var_144_22 <= arg_141_1.time_ and arg_141_1.time_ < var_144_22 + var_144_29 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_22) / var_144_29

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_22 + var_144_29 and arg_141_1.time_ < var_144_22 + var_144_29 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play926052035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926052035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play926052036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.825

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(926052035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 33
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play926052036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926052036
		arg_149_1.duration_ = 2.73

		local var_149_0 = {
			zh = 1.7,
			ja = 2.733
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
				arg_149_0:Play926052037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["128404"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 1, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.2

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[6].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_11 = arg_149_1:GetWordFromCfg(926052036)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 8
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052036", "story_v_out_926052.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_926052", "926052036", "story_v_out_926052.awb") / 1000

					if var_152_16 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_8
					end

					if var_152_11.prefab_name ~= "" and arg_149_1.actors_[var_152_11.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_11.prefab_name].transform, "story_v_out_926052", "926052036", "story_v_out_926052.awb")

						arg_149_1:RecordAudio("926052036", var_152_17)
						arg_149_1:RecordAudio("926052036", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_926052", "926052036", "story_v_out_926052.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_926052", "926052036", "story_v_out_926052.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_18 and arg_149_1.time_ < var_152_8 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926052037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926052037
		arg_153_1.duration_ = 5.1

		local var_153_0 = {
			zh = 3.6,
			ja = 5.1
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
				arg_153_0:Play926052038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10144"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_8 = arg_153_1.actors_["128404"]
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = var_156_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_10 = 0.2

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 and not isNil(var_156_8) then
				local var_156_11 = (arg_153_1.time_ - var_156_9) / var_156_10

				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								local var_156_12 = Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, var_156_11)
								local var_156_13 = Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, var_156_11)
								local var_156_14 = Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, var_156_11)

								iter_156_5.color = Color.New(var_156_12, var_156_13, var_156_14)
							else
								local var_156_15 = Mathf.Lerp(iter_156_5.color.r, 0.5, var_156_11)

								iter_156_5.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 and not isNil(var_156_8) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_7 then
						if arg_153_1.isInRecall_ then
							iter_156_7.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_16 = 0
			local var_156_17 = 0.5

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_18 = arg_153_1:FormatText(StoryNameCfg[1297].name)

				arg_153_1.leftNameTxt_.text = var_156_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_19 = arg_153_1:GetWordFromCfg(926052037)
				local var_156_20 = arg_153_1:FormatText(var_156_19.content)

				arg_153_1.text_.text = var_156_20

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_21 = 20
				local var_156_22 = utf8.len(var_156_20)
				local var_156_23 = var_156_21 <= 0 and var_156_17 or var_156_17 * (var_156_22 / var_156_21)

				if var_156_23 > 0 and var_156_17 < var_156_23 then
					arg_153_1.talkMaxDuration = var_156_23

					if var_156_23 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_16
					end
				end

				arg_153_1.text_.text = var_156_20
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052037", "story_v_out_926052.awb") ~= 0 then
					local var_156_24 = manager.audio:GetVoiceLength("story_v_out_926052", "926052037", "story_v_out_926052.awb") / 1000

					if var_156_24 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_16
					end

					if var_156_19.prefab_name ~= "" and arg_153_1.actors_[var_156_19.prefab_name] ~= nil then
						local var_156_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_19.prefab_name].transform, "story_v_out_926052", "926052037", "story_v_out_926052.awb")

						arg_153_1:RecordAudio("926052037", var_156_25)
						arg_153_1:RecordAudio("926052037", var_156_25)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926052", "926052037", "story_v_out_926052.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926052", "926052037", "story_v_out_926052.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_26 = math.max(var_156_17, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_26 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_16) / var_156_26

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_26 and arg_153_1.time_ < var_156_16 + var_156_26 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play926052038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926052038
		arg_157_1.duration_ = 7.07

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926052039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10144"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 0.5, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_8 = arg_157_1.story_ui_effectTrs_.transform
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				local var_160_10 = arg_157_1.var_.effect666
				local var_160_11
				local var_160_12 = var_160_8

				if not var_160_10 then
					var_160_10 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_heimu_out"), var_160_12)
					var_160_10.name = "666"
					arg_157_1.var_.effect666 = var_160_10
				else
					var_160_10.transform:SetParent(var_160_12)
				end

				var_160_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_160_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_160_13 = manager.ui.mainCameraCom_
				local var_160_14 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_160_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_160_15 = var_160_10.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_160_16 = 15
				local var_160_17 = 2 * var_160_16 * Mathf.Tan(var_160_13.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_160_13.aspect
				local var_160_18 = 1
				local var_160_19 = 1.7777777777777777

				if var_160_19 < var_160_13.aspect then
					var_160_18 = var_160_17 / (2 * var_160_16 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_160_19)
				end

				for iter_160_4, iter_160_5 in ipairs(var_160_15) do
					local var_160_20 = iter_160_5.transform.localScale

					iter_160_5.transform.localScale = Vector3.New(var_160_20.x / var_160_14 * var_160_18, var_160_20.y / var_160_14, var_160_20.z)
				end
			end

			local var_160_21 = manager.ui.mainCamera.transform
			local var_160_22 = 0

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				local var_160_23 = arg_157_1.var_.effect222
				local var_160_24
				local var_160_25 = var_160_21

				if not var_160_23 then
					var_160_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_voice_out"), var_160_25)
					var_160_23.name = "222"
					arg_157_1.var_.effect222 = var_160_23
				else
					var_160_23.transform:SetParent(var_160_25)
				end

				var_160_23.transform.localPosition = Vector3.New(-0.07, 0, 1.46)
				var_160_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_160_26 = arg_157_1.story_ui_effectTrs_.transform
			local var_160_27 = 0

			if var_160_27 < arg_157_1.time_ and arg_157_1.time_ <= var_160_27 + arg_160_0 then
				local var_160_28 = arg_157_1.var_.effect798

				if var_160_28 then
					Object.Destroy(var_160_28)

					arg_157_1.var_.effect798 = nil
				end
			end

			local var_160_29 = manager.ui.mainCamera.transform
			local var_160_30 = 0

			if var_160_30 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				local var_160_31 = arg_157_1.var_.effect777

				if var_160_31 then
					Object.Destroy(var_160_31)

					arg_157_1.var_.effect777 = nil
				end
			end

			local var_160_32 = 0

			if var_160_32 < arg_157_1.time_ and arg_157_1.time_ <= var_160_32 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			local var_160_33 = 2.7

			if arg_157_1.time_ >= var_160_32 + var_160_33 and arg_157_1.time_ < var_160_32 + var_160_33 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_34 = 0.034
			local var_160_35 = 1

			if var_160_34 < arg_157_1.time_ and arg_157_1.time_ <= var_160_34 + arg_160_0 then
				local var_160_36 = "play"
				local var_160_37 = "effect"

				arg_157_1:AudioAction(var_160_36, var_160_37, "se_story_143", "se_story_143_action_summer1_story_intense_up", "")
			end

			local var_160_38 = 0.034
			local var_160_39 = 1

			if var_160_38 < arg_157_1.time_ and arg_157_1.time_ <= var_160_38 + arg_160_0 then
				local var_160_40 = "play"
				local var_160_41 = "effect"

				arg_157_1:AudioAction(var_160_40, var_160_41, "se_story_143", "se_story_143_volume_up", "")
			end

			local var_160_42 = 0
			local var_160_43 = 1

			if var_160_42 < arg_157_1.time_ and arg_157_1.time_ <= var_160_42 + arg_160_0 then
				local var_160_44 = "play"
				local var_160_45 = "effect"

				arg_157_1:AudioAction(var_160_44, var_160_45, "se_story_143", "se_story_143_leaves", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_46 = 2.06666666666667
			local var_160_47 = 1.1

			if var_160_46 < arg_157_1.time_ and arg_157_1.time_ <= var_160_46 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_48 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_48:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_49 = arg_157_1:GetWordFromCfg(926052038)
				local var_160_50 = arg_157_1:FormatText(var_160_49.content)

				arg_157_1.text_.text = var_160_50

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_51 = 44
				local var_160_52 = utf8.len(var_160_50)
				local var_160_53 = var_160_51 <= 0 and var_160_47 or var_160_47 * (var_160_52 / var_160_51)

				if var_160_53 > 0 and var_160_47 < var_160_53 then
					arg_157_1.talkMaxDuration = var_160_53
					var_160_46 = var_160_46 + 0.3

					if var_160_53 + var_160_46 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_53 + var_160_46
					end
				end

				arg_157_1.text_.text = var_160_50
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_54 = var_160_46 + 0.3
			local var_160_55 = math.max(var_160_47, arg_157_1.talkMaxDuration)

			if var_160_54 <= arg_157_1.time_ and arg_157_1.time_ < var_160_54 + var_160_55 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_54) / var_160_55

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_54 + var_160_55 and arg_157_1.time_ < var_160_54 + var_160_55 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play926052039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926052039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play926052040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.075

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(926052039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 3
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play926052040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926052040
		arg_167_1.duration_ = 7.4

		local var_167_0 = {
			zh = 4.266,
			ja = 7.4
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
				arg_167_0:Play926052041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10144"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10144 == nil then
				arg_167_1.var_.actorSpriteComps10144 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10144 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10144 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10144 = nil
			end

			local var_170_8 = arg_167_1.actors_["10144"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos10144 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10144", 4)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "split_4" or not string.find(var_170_11.name, "split") then
						var_170_11.gameObject:SetActive(true)
					else
						var_170_11.gameObject:SetActive(false)
					end
				end
			end

			local var_170_12 = 0.001

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(556.3, -365.9, 337)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10144, var_170_14, var_170_13)
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_170_15 = arg_167_1.actors_["10144"]
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				local var_170_17 = var_170_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_17 then
					arg_167_1.var_.alphaOldValue10144 = var_170_17.alpha
					arg_167_1.var_.characterEffect10144 = var_170_17
				end

				arg_167_1.var_.alphaOldValue10144 = 0
			end

			local var_170_18 = 0.2

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_18 then
				local var_170_19 = (arg_167_1.time_ - var_170_16) / var_170_18
				local var_170_20 = Mathf.Lerp(arg_167_1.var_.alphaOldValue10144, 1, var_170_19)

				if arg_167_1.var_.characterEffect10144 then
					arg_167_1.var_.characterEffect10144.alpha = var_170_20
				end
			end

			if arg_167_1.time_ >= var_170_16 + var_170_18 and arg_167_1.time_ < var_170_16 + var_170_18 + arg_170_0 and arg_167_1.var_.characterEffect10144 then
				arg_167_1.var_.characterEffect10144.alpha = 1
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_21 = 0.2
			local var_170_22 = 0.4

			if var_170_21 < arg_167_1.time_ and arg_167_1.time_ <= var_170_21 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_23 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_23:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_24 = arg_167_1:FormatText(StoryNameCfg[1297].name)

				arg_167_1.leftNameTxt_.text = var_170_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_25 = arg_167_1:GetWordFromCfg(926052040)
				local var_170_26 = arg_167_1:FormatText(var_170_25.content)

				arg_167_1.text_.text = var_170_26

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_27 = 16
				local var_170_28 = utf8.len(var_170_26)
				local var_170_29 = var_170_27 <= 0 and var_170_22 or var_170_22 * (var_170_28 / var_170_27)

				if var_170_29 > 0 and var_170_22 < var_170_29 then
					arg_167_1.talkMaxDuration = var_170_29
					var_170_21 = var_170_21 + 0.3

					if var_170_29 + var_170_21 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_29 + var_170_21
					end
				end

				arg_167_1.text_.text = var_170_26
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052040", "story_v_out_926052.awb") ~= 0 then
					local var_170_30 = manager.audio:GetVoiceLength("story_v_out_926052", "926052040", "story_v_out_926052.awb") / 1000

					if var_170_30 + var_170_21 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_21
					end

					if var_170_25.prefab_name ~= "" and arg_167_1.actors_[var_170_25.prefab_name] ~= nil then
						local var_170_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_25.prefab_name].transform, "story_v_out_926052", "926052040", "story_v_out_926052.awb")

						arg_167_1:RecordAudio("926052040", var_170_31)
						arg_167_1:RecordAudio("926052040", var_170_31)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_926052", "926052040", "story_v_out_926052.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_926052", "926052040", "story_v_out_926052.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_32 = var_170_21 + 0.3
			local var_170_33 = math.max(var_170_22, arg_167_1.talkMaxDuration)

			if var_170_32 <= arg_167_1.time_ and arg_167_1.time_ < var_170_32 + var_170_33 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_32) / var_170_33

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_32 + var_170_33 and arg_167_1.time_ < var_170_32 + var_170_33 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play926052041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926052041
		arg_173_1.duration_ = 2.57

		local var_173_0 = {
			zh = 2,
			ja = 2.566
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
				arg_173_0:Play926052042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["128404"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_8 = arg_173_1.actors_["10144"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps10144 == nil then
				arg_173_1.var_.actorSpriteComps10144 = var_176_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_10 = 0.2

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_10 and not isNil(var_176_8) then
				local var_176_11 = (arg_173_1.time_ - var_176_9) / var_176_10

				if arg_173_1.var_.actorSpriteComps10144 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								local var_176_12 = Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, var_176_11)
								local var_176_13 = Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, var_176_11)
								local var_176_14 = Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, var_176_11)

								iter_176_5.color = Color.New(var_176_12, var_176_13, var_176_14)
							else
								local var_176_15 = Mathf.Lerp(iter_176_5.color.r, 0.5, var_176_11)

								iter_176_5.color = Color.New(var_176_15, var_176_15, var_176_15)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_10 and arg_173_1.time_ < var_176_9 + var_176_10 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps10144 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_176_7 then
						if arg_173_1.isInRecall_ then
							iter_176_7.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10144 = nil
			end

			local var_176_16 = 0
			local var_176_17 = 0.25

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_18 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_19 = arg_173_1:GetWordFromCfg(926052041)
				local var_176_20 = arg_173_1:FormatText(var_176_19.content)

				arg_173_1.text_.text = var_176_20

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_21 = 10
				local var_176_22 = utf8.len(var_176_20)
				local var_176_23 = var_176_21 <= 0 and var_176_17 or var_176_17 * (var_176_22 / var_176_21)

				if var_176_23 > 0 and var_176_17 < var_176_23 then
					arg_173_1.talkMaxDuration = var_176_23

					if var_176_23 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_16
					end
				end

				arg_173_1.text_.text = var_176_20
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052041", "story_v_out_926052.awb") ~= 0 then
					local var_176_24 = manager.audio:GetVoiceLength("story_v_out_926052", "926052041", "story_v_out_926052.awb") / 1000

					if var_176_24 + var_176_16 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_24 + var_176_16
					end

					if var_176_19.prefab_name ~= "" and arg_173_1.actors_[var_176_19.prefab_name] ~= nil then
						local var_176_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_19.prefab_name].transform, "story_v_out_926052", "926052041", "story_v_out_926052.awb")

						arg_173_1:RecordAudio("926052041", var_176_25)
						arg_173_1:RecordAudio("926052041", var_176_25)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_926052", "926052041", "story_v_out_926052.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_926052", "926052041", "story_v_out_926052.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_26 = math.max(var_176_17, arg_173_1.talkMaxDuration)

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_26 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_16) / var_176_26

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_16 + var_176_26 and arg_173_1.time_ < var_176_16 + var_176_26 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play926052042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926052042
		arg_177_1.duration_ = 3.58

		local var_177_0 = {
			zh = 2.783,
			ja = 3.583
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
				arg_177_0:Play926052043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10144"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_8 = arg_177_1.actors_["128404"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps128404 == nil then
				arg_177_1.var_.actorSpriteComps128404 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps128404 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps128404 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps128404 = nil
			end

			local var_180_16 = arg_177_1.actors_["128404"].transform
			local var_180_17 = 0

			if var_180_17 < arg_177_1.time_ and arg_177_1.time_ <= var_180_17 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_16.localPosition
				var_180_16.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 7)

				local var_180_18 = var_180_16.childCount

				for iter_180_8 = 0, var_180_18 - 1 do
					local var_180_19 = var_180_16:GetChild(iter_180_8)

					if var_180_19.name == "" or not string.find(var_180_19.name, "split") then
						var_180_19.gameObject:SetActive(true)
					else
						var_180_19.gameObject:SetActive(false)
					end
				end
			end

			local var_180_20 = 0.001

			if var_180_17 <= arg_177_1.time_ and arg_177_1.time_ < var_180_17 + var_180_20 then
				local var_180_21 = (arg_177_1.time_ - var_180_17) / var_180_20
				local var_180_22 = Vector3.New(0, -2000, 0)

				var_180_16.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, var_180_22, var_180_21)
			end

			if arg_177_1.time_ >= var_180_17 + var_180_20 and arg_177_1.time_ < var_180_17 + var_180_20 + arg_180_0 then
				var_180_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_23 = 0

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_24 = 1

			if var_180_23 <= arg_177_1.time_ and arg_177_1.time_ < var_180_23 + var_180_24 then
				local var_180_25 = (arg_177_1.time_ - var_180_23) / var_180_24
				local var_180_26 = Color.New(1, 1, 1)

				var_180_26.a = Mathf.Lerp(1, 0, var_180_25)
				arg_177_1.mask_.color = var_180_26
			end

			if arg_177_1.time_ >= var_180_23 + var_180_24 and arg_177_1.time_ < var_180_23 + var_180_24 + arg_180_0 then
				local var_180_27 = Color.New(1, 1, 1)
				local var_180_28 = 0

				arg_177_1.mask_.enabled = false
				var_180_27.a = var_180_28
				arg_177_1.mask_.color = var_180_27
			end

			local var_180_29 = manager.ui.mainCamera.transform
			local var_180_30 = 0

			if var_180_30 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = var_180_29.localPosition
			end

			local var_180_31 = 0.6

			if var_180_30 <= arg_177_1.time_ and arg_177_1.time_ < var_180_30 + var_180_31 then
				local var_180_32 = (arg_177_1.time_ - var_180_30) / 0.066
				local var_180_33, var_180_34 = math.modf(var_180_32)

				var_180_29.localPosition = Vector3.New(var_180_34 * 0.13, var_180_34 * 0.13, var_180_34 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= var_180_30 + var_180_31 and arg_177_1.time_ < var_180_30 + var_180_31 + arg_180_0 then
				var_180_29.localPosition = arg_177_1.var_.shakeOldPos
			end

			local var_180_35 = manager.ui.mainCamera.transform
			local var_180_36 = 0

			if var_180_36 < arg_177_1.time_ and arg_177_1.time_ <= var_180_36 + arg_180_0 then
				local var_180_37 = arg_177_1.var_.effect6346
				local var_180_38
				local var_180_39 = var_180_35

				if not var_180_37 then
					var_180_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_180_39)
					var_180_37.name = "6346"
					arg_177_1.var_.effect6346 = var_180_37
				else
					var_180_37.transform:SetParent(var_180_39)
				end

				var_180_37.transform.localPosition = Vector3.New(0, 0, -2.36)
				var_180_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_180_40 = 0

			if var_180_40 < arg_177_1.time_ and arg_177_1.time_ <= var_180_40 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			local var_180_41 = 1.2

			if arg_177_1.time_ >= var_180_40 + var_180_41 and arg_177_1.time_ < var_180_40 + var_180_41 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_42 = arg_177_1.actors_["10144"].transform
			local var_180_43 = 0

			if var_180_43 < arg_177_1.time_ and arg_177_1.time_ <= var_180_43 + arg_180_0 then
				arg_177_1.var_.moveOldPos10144 = var_180_42.localPosition
				var_180_42.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10144", 2)

				local var_180_44 = var_180_42.childCount

				for iter_180_9 = 0, var_180_44 - 1 do
					local var_180_45 = var_180_42:GetChild(iter_180_9)

					if var_180_45.name == "split_5" or not string.find(var_180_45.name, "split") then
						var_180_45.gameObject:SetActive(true)
					else
						var_180_45.gameObject:SetActive(false)
					end
				end
			end

			local var_180_46 = 0.266666666666667

			if var_180_43 <= arg_177_1.time_ and arg_177_1.time_ < var_180_43 + var_180_46 then
				local var_180_47 = (arg_177_1.time_ - var_180_43) / var_180_46
				local var_180_48 = Vector3.New(-199.8, -381.1, -990.8)

				var_180_42.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10144, var_180_48, var_180_47)
			end

			if arg_177_1.time_ >= var_180_43 + var_180_46 and arg_177_1.time_ < var_180_43 + var_180_46 + arg_180_0 then
				var_180_42.localPosition = Vector3.New(-199.8, -381.1, -990.8)
			end

			local var_180_49 = 0.034
			local var_180_50 = 1

			if var_180_49 < arg_177_1.time_ and arg_177_1.time_ <= var_180_49 + arg_180_0 then
				local var_180_51 = "play"
				local var_180_52 = "effect"

				arg_177_1:AudioAction(var_180_51, var_180_52, "se_story_143", "se_story_143_explode", "")
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_53 = 1.05
			local var_180_54 = 0.15

			if var_180_53 < arg_177_1.time_ and arg_177_1.time_ <= var_180_53 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_55 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_55:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_56 = arg_177_1:FormatText(StoryNameCfg[1297].name)

				arg_177_1.leftNameTxt_.text = var_180_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_57 = arg_177_1:GetWordFromCfg(926052042)
				local var_180_58 = arg_177_1:FormatText(var_180_57.content)

				arg_177_1.text_.text = var_180_58

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_59 = 6
				local var_180_60 = utf8.len(var_180_58)
				local var_180_61 = var_180_59 <= 0 and var_180_54 or var_180_54 * (var_180_60 / var_180_59)

				if var_180_61 > 0 and var_180_54 < var_180_61 then
					arg_177_1.talkMaxDuration = var_180_61
					var_180_53 = var_180_53 + 0.3

					if var_180_61 + var_180_53 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_61 + var_180_53
					end
				end

				arg_177_1.text_.text = var_180_58
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052042", "story_v_out_926052.awb") ~= 0 then
					local var_180_62 = manager.audio:GetVoiceLength("story_v_out_926052", "926052042", "story_v_out_926052.awb") / 1000

					if var_180_62 + var_180_53 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_62 + var_180_53
					end

					if var_180_57.prefab_name ~= "" and arg_177_1.actors_[var_180_57.prefab_name] ~= nil then
						local var_180_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_57.prefab_name].transform, "story_v_out_926052", "926052042", "story_v_out_926052.awb")

						arg_177_1:RecordAudio("926052042", var_180_63)
						arg_177_1:RecordAudio("926052042", var_180_63)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926052", "926052042", "story_v_out_926052.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926052", "926052042", "story_v_out_926052.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_64 = var_180_53 + 0.3
			local var_180_65 = math.max(var_180_54, arg_177_1.talkMaxDuration)

			if var_180_64 <= arg_177_1.time_ and arg_177_1.time_ < var_180_64 + var_180_65 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_64) / var_180_65

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_64 + var_180_65 and arg_177_1.time_ < var_180_64 + var_180_65 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.266666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.708,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(556.3, -365.9, 337),
					endPos = Vector3.New(-199.8, -381.1, -990.8),
					easeType = LeanTweenType.easeInBack
				}
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play926052043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926052043
		arg_183_1.duration_ = 7.87

		local var_183_0 = {
			zh = 6.9,
			ja = 7.866
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play926052044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				local var_186_1 = manager.ui.mainCamera.transform.localPosition
				local var_186_2 = Vector3.New(0, 0, 10) + Vector3.New(var_186_1.x, var_186_1.y, 0)
				local var_186_3 = arg_183_1.bgs_.I21f

				var_186_3.transform.localPosition = var_186_2
				var_186_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_4 = var_186_3:GetComponent("SpriteRenderer")

				if var_186_4 and var_186_4.sprite then
					local var_186_5 = (var_186_3.transform.localPosition - var_186_1).z
					local var_186_6 = manager.ui.mainCameraCom_
					local var_186_7 = 2 * var_186_5 * Mathf.Tan(var_186_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_8 = var_186_7 * var_186_6.aspect
					local var_186_9 = var_186_4.sprite.bounds.size.x
					local var_186_10 = var_186_4.sprite.bounds.size.y
					local var_186_11 = var_186_8 / var_186_9
					local var_186_12 = var_186_7 / var_186_10
					local var_186_13 = var_186_12 < var_186_11 and var_186_11 or var_186_12

					var_186_3.transform.localScale = Vector3.New(var_186_13, var_186_13, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "I21f" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_14 = 1

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_15 = 0.3

			if arg_183_1.time_ >= var_186_14 + var_186_15 and arg_183_1.time_ < var_186_14 + var_186_15 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_17 = 1

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17
				local var_186_19 = Color.New(0, 0, 0)

				var_186_19.a = Mathf.Lerp(0, 1, var_186_18)
				arg_183_1.mask_.color = var_186_19
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				local var_186_20 = Color.New(0, 0, 0)

				var_186_20.a = 1
				arg_183_1.mask_.color = var_186_20
			end

			local var_186_21 = 1

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_22 = 2

			if var_186_21 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_22 then
				local var_186_23 = (arg_183_1.time_ - var_186_21) / var_186_22
				local var_186_24 = Color.New(0, 0, 0)

				var_186_24.a = Mathf.Lerp(1, 0, var_186_23)
				arg_183_1.mask_.color = var_186_24
			end

			if arg_183_1.time_ >= var_186_21 + var_186_22 and arg_183_1.time_ < var_186_21 + var_186_22 + arg_186_0 then
				local var_186_25 = Color.New(0, 0, 0)
				local var_186_26 = 0

				arg_183_1.mask_.enabled = false
				var_186_25.a = var_186_26
				arg_183_1.mask_.color = var_186_25
			end

			local var_186_27 = arg_183_1.actors_["128404"]
			local var_186_28 = 2.7

			if var_186_28 < arg_183_1.time_ and arg_183_1.time_ <= var_186_28 + arg_186_0 and not isNil(var_186_27) and arg_183_1.var_.actorSpriteComps128404 == nil then
				arg_183_1.var_.actorSpriteComps128404 = var_186_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_29 = 0.2

			if var_186_28 <= arg_183_1.time_ and arg_183_1.time_ < var_186_28 + var_186_29 and not isNil(var_186_27) then
				local var_186_30 = (arg_183_1.time_ - var_186_28) / var_186_29

				if arg_183_1.var_.actorSpriteComps128404 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								local var_186_31 = Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, var_186_30)
								local var_186_32 = Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, var_186_30)
								local var_186_33 = Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, var_186_30)

								iter_186_3.color = Color.New(var_186_31, var_186_32, var_186_33)
							else
								local var_186_34 = Mathf.Lerp(iter_186_3.color.r, 1, var_186_30)

								iter_186_3.color = Color.New(var_186_34, var_186_34, var_186_34)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_28 + var_186_29 and arg_183_1.time_ < var_186_28 + var_186_29 + arg_186_0 and not isNil(var_186_27) and arg_183_1.var_.actorSpriteComps128404 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_186_5 then
						if arg_183_1.isInRecall_ then
							iter_186_5.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps128404 = nil
			end

			local var_186_35 = arg_183_1.actors_["128404"].transform
			local var_186_36 = 2.7

			if var_186_36 < arg_183_1.time_ and arg_183_1.time_ <= var_186_36 + arg_186_0 then
				arg_183_1.var_.moveOldPos128404 = var_186_35.localPosition
				var_186_35.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("128404", 3)

				local var_186_37 = var_186_35.childCount

				for iter_186_6 = 0, var_186_37 - 1 do
					local var_186_38 = var_186_35:GetChild(iter_186_6)

					if var_186_38.name == "split_5" or not string.find(var_186_38.name, "split") then
						var_186_38.gameObject:SetActive(true)
					else
						var_186_38.gameObject:SetActive(false)
					end
				end
			end

			local var_186_39 = 0.001

			if var_186_36 <= arg_183_1.time_ and arg_183_1.time_ < var_186_36 + var_186_39 then
				local var_186_40 = (arg_183_1.time_ - var_186_36) / var_186_39
				local var_186_41 = Vector3.New(-16.1, -362, -375)

				var_186_35.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos128404, var_186_41, var_186_40)
			end

			if arg_183_1.time_ >= var_186_36 + var_186_39 and arg_183_1.time_ < var_186_36 + var_186_39 + arg_186_0 then
				var_186_35.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_186_42 = arg_183_1.actors_["128404"]
			local var_186_43 = 2.7

			if var_186_43 < arg_183_1.time_ and arg_183_1.time_ <= var_186_43 + arg_186_0 then
				local var_186_44 = var_186_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_44 then
					arg_183_1.var_.alphaOldValue128404 = var_186_44.alpha
					arg_183_1.var_.characterEffect128404 = var_186_44
				end

				arg_183_1.var_.alphaOldValue128404 = 0
			end

			local var_186_45 = 0.2

			if var_186_43 <= arg_183_1.time_ and arg_183_1.time_ < var_186_43 + var_186_45 then
				local var_186_46 = (arg_183_1.time_ - var_186_43) / var_186_45
				local var_186_47 = Mathf.Lerp(arg_183_1.var_.alphaOldValue128404, 1, var_186_46)

				if arg_183_1.var_.characterEffect128404 then
					arg_183_1.var_.characterEffect128404.alpha = var_186_47
				end
			end

			if arg_183_1.time_ >= var_186_43 + var_186_45 and arg_183_1.time_ < var_186_43 + var_186_45 + arg_186_0 and arg_183_1.var_.characterEffect128404 then
				arg_183_1.var_.characterEffect128404.alpha = 1
			end

			local var_186_48 = manager.ui.mainCamera.transform
			local var_186_49 = 1

			if var_186_49 < arg_183_1.time_ and arg_183_1.time_ <= var_186_49 + arg_186_0 then
				local var_186_50 = arg_183_1.var_.effect6346

				if var_186_50 then
					Object.Destroy(var_186_50)

					arg_183_1.var_.effect6346 = nil
				end
			end

			local var_186_51 = arg_183_1.actors_["10144"].transform
			local var_186_52 = 1

			if var_186_52 < arg_183_1.time_ and arg_183_1.time_ <= var_186_52 + arg_186_0 then
				arg_183_1.var_.moveOldPos10144 = var_186_51.localPosition
				var_186_51.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10144", 7)

				local var_186_53 = var_186_51.childCount

				for iter_186_7 = 0, var_186_53 - 1 do
					local var_186_54 = var_186_51:GetChild(iter_186_7)

					if var_186_54.name == "" or not string.find(var_186_54.name, "split") then
						var_186_54.gameObject:SetActive(true)
					else
						var_186_54.gameObject:SetActive(false)
					end
				end
			end

			local var_186_55 = 0.001

			if var_186_52 <= arg_183_1.time_ and arg_183_1.time_ < var_186_52 + var_186_55 then
				local var_186_56 = (arg_183_1.time_ - var_186_52) / var_186_55
				local var_186_57 = Vector3.New(0, -2000, 0)

				var_186_51.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10144, var_186_57, var_186_56)
			end

			if arg_183_1.time_ >= var_186_52 + var_186_55 and arg_183_1.time_ < var_186_52 + var_186_55 + arg_186_0 then
				var_186_51.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_58 = 0
			local var_186_59 = 0.3

			if var_186_58 < arg_183_1.time_ and arg_183_1.time_ <= var_186_58 + arg_186_0 then
				local var_186_60 = "play"
				local var_186_61 = "music"

				arg_183_1:AudioAction(var_186_60, var_186_61, "ui_battle", "ui_battle_stopbgm", "")

				local var_186_62 = ""
				local var_186_63 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_186_63 ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_63 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_63

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_63
						arg_183_1.bgmTxt2_.text = var_186_63
					end

					if arg_183_1.bgmTimer then
						arg_183_1.bgmTimer:Stop()

						arg_183_1.bgmTimer = nil
					end

					if arg_183_1.settingData.show_music_name == 1 then
						arg_183_1.musicController:SetSelectedState("show")
						arg_183_1.musicAnimator_:Play("open", 0, 0)

						if arg_183_1.settingData.music_time ~= 0 then
							arg_183_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_183_1.settingData.music_time), function()
								if arg_183_1 == nil or isNil(arg_183_1.bgmTxt_) then
									return
								end

								arg_183_1.musicController:SetSelectedState("hide")
								arg_183_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_64 = 3
			local var_186_65 = 0.466666666666666

			if var_186_64 < arg_183_1.time_ and arg_183_1.time_ <= var_186_64 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_66 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_66:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_183_1.dialogCg_.alpha = arg_188_0
				end))
				var_186_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_67 = arg_183_1:FormatText(StoryNameCfg[6].name)

				arg_183_1.leftNameTxt_.text = var_186_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_68 = arg_183_1:GetWordFromCfg(926052043)
				local var_186_69 = arg_183_1:FormatText(var_186_68.content)

				arg_183_1.text_.text = var_186_69

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_70 = 13
				local var_186_71 = utf8.len(var_186_69)
				local var_186_72 = var_186_70 <= 0 and var_186_65 or var_186_65 * (var_186_71 / var_186_70)

				if var_186_72 > 0 and var_186_65 < var_186_72 then
					arg_183_1.talkMaxDuration = var_186_72
					var_186_64 = var_186_64 + 0.3

					if var_186_72 + var_186_64 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_72 + var_186_64
					end
				end

				arg_183_1.text_.text = var_186_69
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052043", "story_v_out_926052.awb") ~= 0 then
					local var_186_73 = manager.audio:GetVoiceLength("story_v_out_926052", "926052043", "story_v_out_926052.awb") / 1000

					if var_186_73 + var_186_64 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_73 + var_186_64
					end

					if var_186_68.prefab_name ~= "" and arg_183_1.actors_[var_186_68.prefab_name] ~= nil then
						local var_186_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_68.prefab_name].transform, "story_v_out_926052", "926052043", "story_v_out_926052.awb")

						arg_183_1:RecordAudio("926052043", var_186_74)
						arg_183_1:RecordAudio("926052043", var_186_74)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926052", "926052043", "story_v_out_926052.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926052", "926052043", "story_v_out_926052.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_75 = var_186_64 + 0.3
			local var_186_76 = math.max(var_186_65, arg_183_1.talkMaxDuration)

			if var_186_75 <= arg_183_1.time_ and arg_183_1.time_ < var_186_75 + var_186_76 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_75) / var_186_76

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_75 + var_186_76 and arg_183_1.time_ < var_186_75 + var_186_76 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play926052044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 926052044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play926052045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["128404"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps128404 == nil then
				arg_190_1.var_.actorSpriteComps128404 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps128404 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 0.5, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps128404 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps128404 = nil
			end

			local var_193_8 = arg_190_1.actors_["128404"].transform
			local var_193_9 = 0

			if var_193_9 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.var_.moveOldPos128404 = var_193_8.localPosition
				var_193_8.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("128404", 7)

				local var_193_10 = var_193_8.childCount

				for iter_193_4 = 0, var_193_10 - 1 do
					local var_193_11 = var_193_8:GetChild(iter_193_4)

					if var_193_11.name == "" or not string.find(var_193_11.name, "split") then
						var_193_11.gameObject:SetActive(true)
					else
						var_193_11.gameObject:SetActive(false)
					end
				end
			end

			local var_193_12 = 0.001

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_12 then
				local var_193_13 = (arg_190_1.time_ - var_193_9) / var_193_12
				local var_193_14 = Vector3.New(0, -2000, 0)

				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos128404, var_193_14, var_193_13)
			end

			if arg_190_1.time_ >= var_193_9 + var_193_12 and arg_190_1.time_ < var_193_9 + var_193_12 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_193_15 = 0
			local var_193_16 = 0.2

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				local var_193_17 = "play"
				local var_193_18 = "music"

				arg_190_1:AudioAction(var_193_17, var_193_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_193_19 = ""
				local var_193_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_193_20 ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_20 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_20

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_20
						arg_190_1.bgmTxt2_.text = var_193_20
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_193_21 = 0.2
			local var_193_22 = 1

			if var_193_21 < arg_190_1.time_ and arg_190_1.time_ <= var_193_21 + arg_193_0 then
				local var_193_23 = "play"
				local var_193_24 = "music"

				arg_190_1:AudioAction(var_193_23, var_193_24, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_193_25 = ""
				local var_193_26 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if var_193_26 ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_26 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_26

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_26
						arg_190_1.bgmTxt2_.text = var_193_26
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_193_27 = 0
			local var_193_28 = 0.925

			if var_193_27 < arg_190_1.time_ and arg_190_1.time_ <= var_193_27 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_29 = arg_190_1:GetWordFromCfg(926052044)
				local var_193_30 = arg_190_1:FormatText(var_193_29.content)

				arg_190_1.text_.text = var_193_30

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_31 = 70
				local var_193_32 = utf8.len(var_193_30)
				local var_193_33 = var_193_31 <= 0 and var_193_28 or var_193_28 * (var_193_32 / var_193_31)

				if var_193_33 > 0 and var_193_28 < var_193_33 then
					arg_190_1.talkMaxDuration = var_193_33

					if var_193_33 + var_193_27 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_33 + var_193_27
					end
				end

				arg_190_1.text_.text = var_193_30
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_34 = math.max(var_193_28, arg_190_1.talkMaxDuration)

			if var_193_27 <= arg_190_1.time_ and arg_190_1.time_ < var_193_27 + var_193_34 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_27) / var_193_34

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_27 + var_193_34 and arg_190_1.time_ < var_193_27 + var_193_34 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play926052045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 926052045
		arg_196_1.duration_ = 4.67

		local var_196_0 = {
			zh = 2.466,
			ja = 4.666
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play926052046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10144"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 == nil then
				arg_196_1.var_.actorSpriteComps10144 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps10144 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10144 = nil
			end

			local var_199_8 = arg_196_1.actors_["10144"].transform
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_8.localPosition
				var_199_8.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 3)

				local var_199_10 = var_199_8.childCount

				for iter_199_4 = 0, var_199_10 - 1 do
					local var_199_11 = var_199_8:GetChild(iter_199_4)

					if var_199_11.name == "split_7" or not string.find(var_199_11.name, "split") then
						var_199_11.gameObject:SetActive(true)
					else
						var_199_11.gameObject:SetActive(false)
					end
				end
			end

			local var_199_12 = 0.001

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_12 then
				local var_199_13 = (arg_196_1.time_ - var_199_9) / var_199_12
				local var_199_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_199_8.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, var_199_14, var_199_13)
			end

			if arg_196_1.time_ >= var_199_9 + var_199_12 and arg_196_1.time_ < var_199_9 + var_199_12 + arg_199_0 then
				var_199_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_199_15 = 0
			local var_199_16 = 0.25

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[1297].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(926052045)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 10
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052045", "story_v_out_926052.awb") ~= 0 then
					local var_199_23 = manager.audio:GetVoiceLength("story_v_out_926052", "926052045", "story_v_out_926052.awb") / 1000

					if var_199_23 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_15
					end

					if var_199_18.prefab_name ~= "" and arg_196_1.actors_[var_199_18.prefab_name] ~= nil then
						local var_199_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_18.prefab_name].transform, "story_v_out_926052", "926052045", "story_v_out_926052.awb")

						arg_196_1:RecordAudio("926052045", var_199_24)
						arg_196_1:RecordAudio("926052045", var_199_24)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_926052", "926052045", "story_v_out_926052.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_926052", "926052045", "story_v_out_926052.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_25 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_25 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_25

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_25 and arg_196_1.time_ < var_199_15 + var_199_25 + arg_199_0 then
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
	Play926052046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 926052046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play926052047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10144"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10144 == nil then
				arg_200_1.var_.actorSpriteComps10144 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps10144 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 0.5, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10144 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10144 = nil
			end

			local var_203_8 = 0
			local var_203_9 = 0.3

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_10 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_10

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

				local var_203_11 = arg_200_1:GetWordFromCfg(926052046)
				local var_203_12 = arg_200_1:FormatText(var_203_11.content)

				arg_200_1.text_.text = var_203_12

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_13 = 12
				local var_203_14 = utf8.len(var_203_12)
				local var_203_15 = var_203_13 <= 0 and var_203_9 or var_203_9 * (var_203_14 / var_203_13)

				if var_203_15 > 0 and var_203_9 < var_203_15 then
					arg_200_1.talkMaxDuration = var_203_15

					if var_203_15 + var_203_8 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_8
					end
				end

				arg_200_1.text_.text = var_203_12
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_16 = math.max(var_203_9, arg_200_1.talkMaxDuration)

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_16 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_8) / var_203_16

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_8 + var_203_16 and arg_200_1.time_ < var_203_8 + var_203_16 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play926052047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 926052047
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play926052048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.55

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_2

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

				local var_207_3 = arg_204_1:GetWordFromCfg(926052047)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 22
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play926052048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 926052048
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play926052049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.3

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_2

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

				local var_211_3 = arg_208_1:GetWordFromCfg(926052048)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 12
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play926052049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 926052049
		arg_212_1.duration_ = 6.43

		local var_212_0 = {
			zh = 3.766,
			ja = 6.433
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
				arg_212_0:Play926052050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["128404"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps128404 == nil then
				arg_212_1.var_.actorSpriteComps128404 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps128404 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								local var_215_4 = Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, var_215_3)
								local var_215_5 = Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, var_215_3)
								local var_215_6 = Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, var_215_3)

								iter_215_1.color = Color.New(var_215_4, var_215_5, var_215_6)
							else
								local var_215_7 = Mathf.Lerp(iter_215_1.color.r, 1, var_215_3)

								iter_215_1.color = Color.New(var_215_7, var_215_7, var_215_7)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps128404 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps128404 = nil
			end

			local var_215_8 = arg_212_1.actors_["128404"].transform
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.var_.moveOldPos128404 = var_215_8.localPosition
				var_215_8.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("128404", 3)

				local var_215_10 = var_215_8.childCount

				for iter_215_4 = 0, var_215_10 - 1 do
					local var_215_11 = var_215_8:GetChild(iter_215_4)

					if var_215_11.name == "split_1" or not string.find(var_215_11.name, "split") then
						var_215_11.gameObject:SetActive(true)
					else
						var_215_11.gameObject:SetActive(false)
					end
				end
			end

			local var_215_12 = 0.001

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_12 then
				local var_215_13 = (arg_212_1.time_ - var_215_9) / var_215_12
				local var_215_14 = Vector3.New(-16.1, -362, -375)

				var_215_8.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos128404, var_215_14, var_215_13)
			end

			if arg_212_1.time_ >= var_215_9 + var_215_12 and arg_212_1.time_ < var_215_9 + var_215_12 + arg_215_0 then
				var_215_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_215_15 = arg_212_1.actors_["10144"].transform
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 then
				arg_212_1.var_.moveOldPos10144 = var_215_15.localPosition
				var_215_15.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10144", 7)

				local var_215_17 = var_215_15.childCount

				for iter_215_5 = 0, var_215_17 - 1 do
					local var_215_18 = var_215_15:GetChild(iter_215_5)

					if var_215_18.name == "" or not string.find(var_215_18.name, "split") then
						var_215_18.gameObject:SetActive(true)
					else
						var_215_18.gameObject:SetActive(false)
					end
				end
			end

			local var_215_19 = 0.001

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_19 then
				local var_215_20 = (arg_212_1.time_ - var_215_16) / var_215_19
				local var_215_21 = Vector3.New(0, -2000, 0)

				var_215_15.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10144, var_215_21, var_215_20)
			end

			if arg_212_1.time_ >= var_215_16 + var_215_19 and arg_212_1.time_ < var_215_16 + var_215_19 + arg_215_0 then
				var_215_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_215_22 = 0
			local var_215_23 = 0.45

			if var_215_22 < arg_212_1.time_ and arg_212_1.time_ <= var_215_22 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_24 = arg_212_1:FormatText(StoryNameCfg[6].name)

				arg_212_1.leftNameTxt_.text = var_215_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_25 = arg_212_1:GetWordFromCfg(926052049)
				local var_215_26 = arg_212_1:FormatText(var_215_25.content)

				arg_212_1.text_.text = var_215_26

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_27 = 18
				local var_215_28 = utf8.len(var_215_26)
				local var_215_29 = var_215_27 <= 0 and var_215_23 or var_215_23 * (var_215_28 / var_215_27)

				if var_215_29 > 0 and var_215_23 < var_215_29 then
					arg_212_1.talkMaxDuration = var_215_29

					if var_215_29 + var_215_22 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_29 + var_215_22
					end
				end

				arg_212_1.text_.text = var_215_26
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052049", "story_v_out_926052.awb") ~= 0 then
					local var_215_30 = manager.audio:GetVoiceLength("story_v_out_926052", "926052049", "story_v_out_926052.awb") / 1000

					if var_215_30 + var_215_22 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_30 + var_215_22
					end

					if var_215_25.prefab_name ~= "" and arg_212_1.actors_[var_215_25.prefab_name] ~= nil then
						local var_215_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_25.prefab_name].transform, "story_v_out_926052", "926052049", "story_v_out_926052.awb")

						arg_212_1:RecordAudio("926052049", var_215_31)
						arg_212_1:RecordAudio("926052049", var_215_31)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_926052", "926052049", "story_v_out_926052.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_926052", "926052049", "story_v_out_926052.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_32 = math.max(var_215_23, arg_212_1.talkMaxDuration)

			if var_215_22 <= arg_212_1.time_ and arg_212_1.time_ < var_215_22 + var_215_32 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_22) / var_215_32

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_22 + var_215_32 and arg_212_1.time_ < var_215_22 + var_215_32 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play926052050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 926052050
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play926052051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["128404"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps128404 == nil then
				arg_216_1.var_.actorSpriteComps128404 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps128404 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 0.5, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps128404 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps128404 = nil
			end

			local var_219_8 = 0
			local var_219_9 = 0.625

			if var_219_8 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_10 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_11 = arg_216_1:GetWordFromCfg(926052050)
				local var_219_12 = arg_216_1:FormatText(var_219_11.content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_13 = 25
				local var_219_14 = utf8.len(var_219_12)
				local var_219_15 = var_219_13 <= 0 and var_219_9 or var_219_9 * (var_219_14 / var_219_13)

				if var_219_15 > 0 and var_219_9 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_8) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_8 + var_219_16 and arg_216_1.time_ < var_219_8 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play926052051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 926052051
		arg_220_1.duration_ = 4.5

		local var_220_0 = {
			zh = 2.9,
			ja = 4.5
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
				arg_220_0:Play926052052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10144"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10144 == nil then
				arg_220_1.var_.actorSpriteComps10144 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps10144 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 1, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps10144 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_223_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10144 = nil
			end

			local var_223_8 = arg_220_1.actors_["10144"].transform
			local var_223_9 = 0

			if var_223_9 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 then
				arg_220_1.var_.moveOldPos10144 = var_223_8.localPosition
				var_223_8.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10144", 3)

				local var_223_10 = var_223_8.childCount

				for iter_223_4 = 0, var_223_10 - 1 do
					local var_223_11 = var_223_8:GetChild(iter_223_4)

					if var_223_11.name == "" or not string.find(var_223_11.name, "split") then
						var_223_11.gameObject:SetActive(true)
					else
						var_223_11.gameObject:SetActive(false)
					end
				end
			end

			local var_223_12 = 0.001

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_12 then
				local var_223_13 = (arg_220_1.time_ - var_223_9) / var_223_12
				local var_223_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_223_8.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10144, var_223_14, var_223_13)
			end

			if arg_220_1.time_ >= var_223_9 + var_223_12 and arg_220_1.time_ < var_223_9 + var_223_12 + arg_223_0 then
				var_223_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_223_15 = arg_220_1.actors_["128404"].transform
			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.var_.moveOldPos128404 = var_223_15.localPosition
				var_223_15.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("128404", 7)

				local var_223_17 = var_223_15.childCount

				for iter_223_5 = 0, var_223_17 - 1 do
					local var_223_18 = var_223_15:GetChild(iter_223_5)

					if var_223_18.name == "" or not string.find(var_223_18.name, "split") then
						var_223_18.gameObject:SetActive(true)
					else
						var_223_18.gameObject:SetActive(false)
					end
				end
			end

			local var_223_19 = 0.001

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_19 then
				local var_223_20 = (arg_220_1.time_ - var_223_16) / var_223_19
				local var_223_21 = Vector3.New(0, -2000, 0)

				var_223_15.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos128404, var_223_21, var_223_20)
			end

			if arg_220_1.time_ >= var_223_16 + var_223_19 and arg_220_1.time_ < var_223_16 + var_223_19 + arg_223_0 then
				var_223_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_22 = 0
			local var_223_23 = 0.4

			if var_223_22 < arg_220_1.time_ and arg_220_1.time_ <= var_223_22 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_24 = arg_220_1:FormatText(StoryNameCfg[1297].name)

				arg_220_1.leftNameTxt_.text = var_223_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_25 = arg_220_1:GetWordFromCfg(926052051)
				local var_223_26 = arg_220_1:FormatText(var_223_25.content)

				arg_220_1.text_.text = var_223_26

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_27 = 16
				local var_223_28 = utf8.len(var_223_26)
				local var_223_29 = var_223_27 <= 0 and var_223_23 or var_223_23 * (var_223_28 / var_223_27)

				if var_223_29 > 0 and var_223_23 < var_223_29 then
					arg_220_1.talkMaxDuration = var_223_29

					if var_223_29 + var_223_22 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_29 + var_223_22
					end
				end

				arg_220_1.text_.text = var_223_26
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052051", "story_v_out_926052.awb") ~= 0 then
					local var_223_30 = manager.audio:GetVoiceLength("story_v_out_926052", "926052051", "story_v_out_926052.awb") / 1000

					if var_223_30 + var_223_22 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_30 + var_223_22
					end

					if var_223_25.prefab_name ~= "" and arg_220_1.actors_[var_223_25.prefab_name] ~= nil then
						local var_223_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_25.prefab_name].transform, "story_v_out_926052", "926052051", "story_v_out_926052.awb")

						arg_220_1:RecordAudio("926052051", var_223_31)
						arg_220_1:RecordAudio("926052051", var_223_31)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_926052", "926052051", "story_v_out_926052.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_926052", "926052051", "story_v_out_926052.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_32 = math.max(var_223_23, arg_220_1.talkMaxDuration)

			if var_223_22 <= arg_220_1.time_ and arg_220_1.time_ < var_223_22 + var_223_32 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_22) / var_223_32

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_22 + var_223_32 and arg_220_1.time_ < var_223_22 + var_223_32 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play926052052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 926052052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play926052053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10144"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10144 == nil then
				arg_224_1.var_.actorSpriteComps10144 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps10144 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_4 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor2.r, var_227_3)
								local var_227_5 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor2.g, var_227_3)
								local var_227_6 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor2.b, var_227_3)

								iter_227_1.color = Color.New(var_227_4, var_227_5, var_227_6)
							else
								local var_227_7 = Mathf.Lerp(iter_227_1.color.r, 0.5, var_227_3)

								iter_227_1.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10144 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10144 = nil
			end

			local var_227_8 = 0
			local var_227_9 = 0.375

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_10 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_10

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

				local var_227_11 = arg_224_1:GetWordFromCfg(926052052)
				local var_227_12 = arg_224_1:FormatText(var_227_11.content)

				arg_224_1.text_.text = var_227_12

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 15
				local var_227_14 = utf8.len(var_227_12)
				local var_227_15 = var_227_13 <= 0 and var_227_9 or var_227_9 * (var_227_14 / var_227_13)

				if var_227_15 > 0 and var_227_9 < var_227_15 then
					arg_224_1.talkMaxDuration = var_227_15

					if var_227_15 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_15 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_12
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_16 and arg_224_1.time_ < var_227_8 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play926052053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 926052053
		arg_228_1.duration_ = 6.4

		local var_228_0 = {
			zh = 5.466,
			ja = 6.4
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play926052054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10144"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10144 == nil then
				arg_228_1.var_.actorSpriteComps10144 = var_231_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_2 = 0.2

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.actorSpriteComps10144 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								local var_231_4 = Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor1.r, var_231_3)
								local var_231_5 = Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor1.g, var_231_3)
								local var_231_6 = Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor1.b, var_231_3)

								iter_231_1.color = Color.New(var_231_4, var_231_5, var_231_6)
							else
								local var_231_7 = Mathf.Lerp(iter_231_1.color.r, 1, var_231_3)

								iter_231_1.color = Color.New(var_231_7, var_231_7, var_231_7)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.actorSpriteComps10144 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_231_3 then
						if arg_228_1.isInRecall_ then
							iter_231_3.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10144 = nil
			end

			local var_231_8 = 0
			local var_231_9 = 0.625

			if var_231_8 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_10 = arg_228_1:FormatText(StoryNameCfg[1297].name)

				arg_228_1.leftNameTxt_.text = var_231_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_11 = arg_228_1:GetWordFromCfg(926052053)
				local var_231_12 = arg_228_1:FormatText(var_231_11.content)

				arg_228_1.text_.text = var_231_12

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 25
				local var_231_14 = utf8.len(var_231_12)
				local var_231_15 = var_231_13 <= 0 and var_231_9 or var_231_9 * (var_231_14 / var_231_13)

				if var_231_15 > 0 and var_231_9 < var_231_15 then
					arg_228_1.talkMaxDuration = var_231_15

					if var_231_15 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_8
					end
				end

				arg_228_1.text_.text = var_231_12
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052053", "story_v_out_926052.awb") ~= 0 then
					local var_231_16 = manager.audio:GetVoiceLength("story_v_out_926052", "926052053", "story_v_out_926052.awb") / 1000

					if var_231_16 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_16 + var_231_8
					end

					if var_231_11.prefab_name ~= "" and arg_228_1.actors_[var_231_11.prefab_name] ~= nil then
						local var_231_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_11.prefab_name].transform, "story_v_out_926052", "926052053", "story_v_out_926052.awb")

						arg_228_1:RecordAudio("926052053", var_231_17)
						arg_228_1:RecordAudio("926052053", var_231_17)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_926052", "926052053", "story_v_out_926052.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_926052", "926052053", "story_v_out_926052.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_18 = math.max(var_231_9, arg_228_1.talkMaxDuration)

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_18 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_8) / var_231_18

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_8 + var_231_18 and arg_228_1.time_ < var_231_8 + var_231_18 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play926052054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 926052054
		arg_232_1.duration_ = 5.07

		local var_232_0 = {
			zh = 3.033,
			ja = 5.066
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
				arg_232_0:Play926052055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10144"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10144 = var_235_0.localPosition
				var_235_0.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10144", 3)

				local var_235_2 = var_235_0.childCount

				for iter_235_0 = 0, var_235_2 - 1 do
					local var_235_3 = var_235_0:GetChild(iter_235_0)

					if var_235_3.name == "split_7" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_4 then
				local var_235_5 = (arg_232_1.time_ - var_235_1) / var_235_4
				local var_235_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10144, var_235_6, var_235_5)
			end

			if arg_232_1.time_ >= var_235_1 + var_235_4 and arg_232_1.time_ < var_235_1 + var_235_4 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_235_7 = 0
			local var_235_8 = 0.4

			if var_235_7 < arg_232_1.time_ and arg_232_1.time_ <= var_235_7 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_9 = arg_232_1:FormatText(StoryNameCfg[1297].name)

				arg_232_1.leftNameTxt_.text = var_235_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_10 = arg_232_1:GetWordFromCfg(926052054)
				local var_235_11 = arg_232_1:FormatText(var_235_10.content)

				arg_232_1.text_.text = var_235_11

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_12 = 16
				local var_235_13 = utf8.len(var_235_11)
				local var_235_14 = var_235_12 <= 0 and var_235_8 or var_235_8 * (var_235_13 / var_235_12)

				if var_235_14 > 0 and var_235_8 < var_235_14 then
					arg_232_1.talkMaxDuration = var_235_14

					if var_235_14 + var_235_7 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_14 + var_235_7
					end
				end

				arg_232_1.text_.text = var_235_11
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052054", "story_v_out_926052.awb") ~= 0 then
					local var_235_15 = manager.audio:GetVoiceLength("story_v_out_926052", "926052054", "story_v_out_926052.awb") / 1000

					if var_235_15 + var_235_7 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_7
					end

					if var_235_10.prefab_name ~= "" and arg_232_1.actors_[var_235_10.prefab_name] ~= nil then
						local var_235_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_10.prefab_name].transform, "story_v_out_926052", "926052054", "story_v_out_926052.awb")

						arg_232_1:RecordAudio("926052054", var_235_16)
						arg_232_1:RecordAudio("926052054", var_235_16)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_926052", "926052054", "story_v_out_926052.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_926052", "926052054", "story_v_out_926052.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_17 = math.max(var_235_8, arg_232_1.talkMaxDuration)

			if var_235_7 <= arg_232_1.time_ and arg_232_1.time_ < var_235_7 + var_235_17 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_7) / var_235_17

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_7 + var_235_17 and arg_232_1.time_ < var_235_7 + var_235_17 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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

		arg_232_1:InitPlayNodeList()
	end,
	Play926052055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 926052055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play926052056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10144"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10144 == nil then
				arg_236_1.var_.actorSpriteComps10144 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps10144 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 0.5, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps10144 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10144 = nil
			end

			local var_239_8 = 0
			local var_239_9 = 0.45

			if var_239_8 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_10 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_11 = arg_236_1:GetWordFromCfg(926052055)
				local var_239_12 = arg_236_1:FormatText(var_239_11.content)

				arg_236_1.text_.text = var_239_12

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 18
				local var_239_14 = utf8.len(var_239_12)
				local var_239_15 = var_239_13 <= 0 and var_239_9 or var_239_9 * (var_239_14 / var_239_13)

				if var_239_15 > 0 and var_239_9 < var_239_15 then
					arg_236_1.talkMaxDuration = var_239_15

					if var_239_15 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_15 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_12
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_16 = math.max(var_239_9, arg_236_1.talkMaxDuration)

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_16 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_8) / var_239_16

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_8 + var_239_16 and arg_236_1.time_ < var_239_8 + var_239_16 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play926052056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 926052056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
			arg_240_1.auto_ = false
		end

		function arg_240_1.playNext_(arg_242_0)
			arg_240_1.onStoryFinished_()
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.6

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[7].name)

				arg_240_1.leftNameTxt_.text = var_243_2

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

				local var_243_3 = arg_240_1:GetWordFromCfg(926052056)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 24
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I21f",
		"TextureConfig/Background/I21g"
	},
	voices = {
		"story_v_out_926052.awb"
	}
}
