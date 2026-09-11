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
			if arg_1_1.bgs_.I21f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I21f")
				var_4_0.name = "I21f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I21f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I21f

				arg_1_1.bgs_.I21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I21f" then
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

			local var_4_9 = ""

			if arg_1_1.actors_[""] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "")

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

			local var_4_12 = arg_1_1.actors_[""]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps == nil then
				arg_1_1.var_.actorSpriteComps = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 0) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps = nil
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 2
			local var_4_23 = 0.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(926052001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 21 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 21)

				if (21 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 21)) > 0 and var_4_23 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_22 = var_4_22 + 0.3

					if var_4_27 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_22 + 0.3
			local var_4_29 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
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
			local var_12_0 = 0.95

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(926052002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)

				if (38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
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
			if arg_13_1.actors_["106103"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "106103"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["106103"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["106103"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps106103 == nil then
				arg_13_1.var_.actorSpriteComps106103 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps106103 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								iter_16_3.color = Color.New(Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_3.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_3.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps106103 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps106103 = nil
			end

			local var_16_5 = arg_13_1.actors_["106103"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos106103 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("106103", 3)

				for iter_16_6 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_6)

					if var_16_6.name == "" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_16_8 = 0
			local var_16_9 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(926052003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 9 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 9)

				if (9 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 9)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052003", "story_v_out_926052.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052003", "story_v_out_926052.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_926052", "926052003", "story_v_out_926052.awb")

						arg_13_1:RecordAudio("926052003", var_16_15)
						arg_13_1:RecordAudio("926052003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926052", "926052003", "story_v_out_926052.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926052", "926052003", "story_v_out_926052.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
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
			if arg_17_1.actors_["128404"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "128404"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["128404"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["128404"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end

			local var_20_5 = arg_17_1.actors_["106103"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps106103 == nil then
				arg_17_1.var_.actorSpriteComps106103 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps106103 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								iter_20_7.color = Color.New(Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_7.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_7.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps106103 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_20_9 then
						iter_20_9.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps106103 = nil
			end

			local var_20_8 = arg_17_1.actors_["106103"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos106103 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("106103", 4)

				for iter_20_10 = 0, var_20_8.childCount - 1 do
					local var_20_9 = var_20_8:GetChild(iter_20_10)

					if var_20_9.name == "" or not string.find(var_20_9.name, "split") then
						var_20_9.gameObject:SetActive(true)
					else
						var_20_9.gameObject:SetActive(false)
					end
				end
			end

			local var_20_10 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos106103, Vector3.New(442.7, -398.2, -333.7), (arg_17_1.time_ - 0) / var_20_10)
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_20_11 = arg_17_1.actors_["128404"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos128404 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("128404", 2)

				for iter_20_11 = 0, var_20_11.childCount - 1 do
					local var_20_12 = var_20_11:GetChild(iter_20_11)

					if var_20_12.name == "" or not string.find(var_20_12.name, "split") then
						var_20_12.gameObject:SetActive(true)
					else
						var_20_12.gameObject:SetActive(false)
					end
				end
			end

			local var_20_13 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_13 then
				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_17_1.time_ - 0) / var_20_13)
			end

			if arg_17_1.time_ >= 0 + var_20_13 and arg_17_1.time_ < 0 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_20_14 = 0
			local var_20_15 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
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

				local var_20_16 = arg_17_1:GetWordFromCfg(926052004)
				local var_20_17 = arg_17_1:FormatText(var_20_16.content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 28 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 28)

				if (28 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 28)) > 0 and var_20_15 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052004", "story_v_out_926052.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_926052", "926052004", "story_v_out_926052.awb") / 1000

					if var_20_20 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_14
					end

					if var_20_16.prefab_name ~= "" and arg_17_1.actors_[var_20_16.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_16.prefab_name].transform, "story_v_out_926052", "926052004", "story_v_out_926052.awb")

						arg_17_1:RecordAudio("926052004", var_20_21)
						arg_17_1:RecordAudio("926052004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926052", "926052004", "story_v_out_926052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926052", "926052004", "story_v_out_926052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_22 and arg_17_1.time_ < var_20_14 + var_20_22 + arg_20_0 then
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
			local var_24_0 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(926052005)
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

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052005", "story_v_out_926052.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_926052", "926052005", "story_v_out_926052.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_926052", "926052005", "story_v_out_926052.awb")

						arg_21_1:RecordAudio("926052005", var_24_6)
						arg_21_1:RecordAudio("926052005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926052", "926052005", "story_v_out_926052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926052", "926052005", "story_v_out_926052.awb")
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
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["106103"]) and arg_25_1.var_.actorSpriteComps106103 == nil then
				arg_25_1.var_.actorSpriteComps106103 = arg_25_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["106103"]) then
				if arg_25_1.var_.actorSpriteComps106103 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["106103"]) and arg_25_1.var_.actorSpriteComps106103 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps106103 = nil
			end

			local var_28_2 = arg_25_1.actors_["128404"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps128404 == nil then
				arg_25_1.var_.actorSpriteComps128404 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps128404 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps128404 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps128404 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(926052006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 10 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 10)

				if (10 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 10)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052006", "story_v_out_926052.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052006", "story_v_out_926052.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_926052", "926052006", "story_v_out_926052.awb")

						arg_25_1:RecordAudio("926052006", var_28_12)
						arg_25_1:RecordAudio("926052006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926052", "926052006", "story_v_out_926052.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926052", "926052006", "story_v_out_926052.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
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
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["128404"]) and arg_29_1.var_.actorSpriteComps128404 == nil then
				arg_29_1.var_.actorSpriteComps128404 = arg_29_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["128404"]) then
				if arg_29_1.var_.actorSpriteComps128404 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["128404"]) and arg_29_1.var_.actorSpriteComps128404 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps128404 = nil
			end

			local var_32_2 = arg_29_1.actors_["106103"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps106103 == nil then
				arg_29_1.var_.actorSpriteComps106103 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps106103 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps106103 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps106103 = nil
			end

			local var_32_5 = arg_29_1.actors_["128404"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 2)

				for iter_32_8 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_8)

					if var_32_6.name == "" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_32_8 = 0
			local var_32_9 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
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

				local var_32_10 = arg_29_1:GetWordFromCfg(926052007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 21 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 21)

				if (21 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 21)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052007", "story_v_out_926052.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052007", "story_v_out_926052.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_926052", "926052007", "story_v_out_926052.awb")

						arg_29_1:RecordAudio("926052007", var_32_15)
						arg_29_1:RecordAudio("926052007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926052", "926052007", "story_v_out_926052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926052", "926052007", "story_v_out_926052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
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
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["128404"]) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = arg_33_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["128404"]) then
				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["128404"]) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.825

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

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(926052008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 33 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 33)

				if (33 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 33)) > 0 and var_36_3 < var_36_6 then
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
			if arg_37_1.actors_["104701"] == nil then
				local var_40_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_40_0) then
					local var_40_1 = Object.Instantiate(var_40_0, arg_37_1.canvasGo_.transform)

					var_40_1.transform:SetSiblingIndex(1)

					var_40_1.name = "104701"
					var_40_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_["104701"] = var_40_1

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs((var_40_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_2 = arg_37_1.actors_["104701"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps104701 == nil then
				arg_37_1.var_.actorSpriteComps104701 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps104701 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps104701 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps104701 = nil
			end

			local var_40_5 = arg_37_1.actors_["106103"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 7)

				for iter_40_6 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_6)

					if var_40_6.name == "" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_8 = arg_37_1.actors_["128404"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos128404 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("128404", 7)

				for iter_40_7 = 0, var_40_8.childCount - 1 do
					local var_40_9 = var_40_8:GetChild(iter_40_7)

					if var_40_9.name == "" or not string.find(var_40_9.name, "split") then
						var_40_9.gameObject:SetActive(true)
					else
						var_40_9.gameObject:SetActive(false)
					end
				end
			end

			local var_40_10 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 then
				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_10)
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_11 = arg_37_1.actors_["104701"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos104701 = var_40_11.localPosition
				var_40_11.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("104701", 3)

				for iter_40_8 = 0, var_40_11.childCount - 1 do
					local var_40_12 = var_40_11:GetChild(iter_40_8)

					if var_40_12.name == "" or not string.find(var_40_12.name, "split") then
						var_40_12.gameObject:SetActive(true)
					else
						var_40_12.gameObject:SetActive(false)
					end
				end
			end

			local var_40_13 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_13 then
				var_40_11.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_37_1.time_ - 0) / var_40_13)
			end

			if arg_37_1.time_ >= 0 + var_40_13 and arg_37_1.time_ < 0 + var_40_13 + arg_40_0 then
				var_40_11.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_40_14 = 0
			local var_40_15 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(926052009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 16 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 16)

				if (16 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 16)) > 0 and var_40_15 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052009", "story_v_out_926052.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_926052", "926052009", "story_v_out_926052.awb") / 1000

					if var_40_20 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_14
					end

					if var_40_16.prefab_name ~= "" and arg_37_1.actors_[var_40_16.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_16.prefab_name].transform, "story_v_out_926052", "926052009", "story_v_out_926052.awb")

						arg_37_1:RecordAudio("926052009", var_40_21)
						arg_37_1:RecordAudio("926052009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926052", "926052009", "story_v_out_926052.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926052", "926052009", "story_v_out_926052.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_14) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_14 + var_40_22 and arg_37_1.time_ < var_40_14 + var_40_22 + arg_40_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["106103"]) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = arg_41_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["106103"]) then
				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["106103"]) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_2 = arg_41_1.actors_["104701"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps104701 == nil then
				arg_41_1.var_.actorSpriteComps104701 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps104701 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps104701 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps104701 = nil
			end

			local var_44_5 = arg_41_1.actors_["104701"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos104701 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("104701", 7)

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
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_8 = arg_41_1.actors_["106103"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos106103 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106103", 3)

				for iter_44_9 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_9)

					if var_44_9.name == "split_5" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_44_11 = 0
			local var_44_12 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_13 = arg_41_1:GetWordFromCfg(926052010)
				local var_44_14 = arg_41_1:FormatText(var_44_13.content)

				arg_41_1.text_.text = var_44_14

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 13 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 13)

				if (13 <= 0 and var_44_12 or var_44_12 * (utf8.len(var_44_14) / 13)) > 0 and var_44_12 < var_44_16 then
					arg_41_1.talkMaxDuration = var_44_16

					if var_44_16 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_14
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052010", "story_v_out_926052.awb") ~= 0 then
					local var_44_17 = manager.audio:GetVoiceLength("story_v_out_926052", "926052010", "story_v_out_926052.awb") / 1000

					if var_44_17 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_11
					end

					if var_44_13.prefab_name ~= "" and arg_41_1.actors_[var_44_13.prefab_name] ~= nil then
						local var_44_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_13.prefab_name].transform, "story_v_out_926052", "926052010", "story_v_out_926052.awb")

						arg_41_1:RecordAudio("926052010", var_44_18)
						arg_41_1:RecordAudio("926052010", var_44_18)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926052", "926052010", "story_v_out_926052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926052", "926052010", "story_v_out_926052.awb")
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
			if arg_45_1.bgs_.I21g == nil then
				local var_48_0 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I21g")
				var_48_0.name = "I21g"
				var_48_0.transform.parent = arg_45_1.stage_.transform
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_.I21g = var_48_0
			end

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				local var_48_1 = arg_45_1.bgs_.I21g

				arg_45_1.bgs_.I21g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_2 = var_48_1:GetComponent("SpriteRenderer")

				if var_48_2 and var_48_2.sprite then
					local var_48_3 = 2 * (var_48_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_1.transform.localScale = Vector3.New(var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I21g" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_4 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_4 + 0.3 and arg_45_1.time_ < var_48_4 + 0.3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_5 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_6 = 2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 then
				local var_48_7 = Color.New(0, 0, 0)

				var_48_7.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_5) / var_48_6)
				arg_45_1.mask_.color = var_48_7
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 then
				local var_48_8 = Color.New(0, 0, 0)

				var_48_8.a = 1
				arg_45_1.mask_.color = var_48_8
			end

			local var_48_9 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_10 = 2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 then
				local var_48_11 = Color.New(0, 0, 0)

				var_48_11.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_9) / var_48_10)
				arg_45_1.mask_.color = var_48_11
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 then
				local var_48_12 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_12.a = 0
				arg_45_1.mask_.color = var_48_12
			end

			local var_48_13 = arg_45_1.actors_["128404"]

			if 3.76666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 3.76666666666667 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = var_48_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_14 = 0.2

			if 3.76666666666667 <= arg_45_1.time_ and arg_45_1.time_ < 3.76666666666667 + var_48_14 and not isNil(var_48_13) then
				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								iter_48_3.color = Color.New(Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 3.76666666666667) / var_48_14), Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 3.76666666666667) / var_48_14), (Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 3.76666666666667) / var_48_14)))
							else
								local var_48_15 = Mathf.Lerp(iter_48_3.color.r, 1, (arg_45_1.time_ - 3.76666666666667) / var_48_14)

								iter_48_3.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 3.76666666666667 + var_48_14 and arg_45_1.time_ < 3.76666666666667 + var_48_14 + arg_48_0 and not isNil(var_48_13) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_5 then
						iter_48_5.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end

			local var_48_16 = arg_45_1.actors_["106103"]

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 and not isNil(var_48_16) and arg_45_1.var_.actorSpriteComps106103 == nil then
				arg_45_1.var_.actorSpriteComps106103 = var_48_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.2

			if 2 <= arg_45_1.time_ and arg_45_1.time_ < 2 + var_48_17 and not isNil(var_48_16) then
				if arg_45_1.var_.actorSpriteComps106103 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								iter_48_7.color = Color.New(Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 2) / var_48_17), Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 2) / var_48_17), (Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 2) / var_48_17)))
							else
								local var_48_18 = Mathf.Lerp(iter_48_7.color.r, 0.5, (arg_45_1.time_ - 2) / var_48_17)

								iter_48_7.color = Color.New(var_48_18, var_48_18, var_48_18)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 2 + var_48_17 and arg_45_1.time_ < 2 + var_48_17 + arg_48_0 and not isNil(var_48_16) and arg_45_1.var_.actorSpriteComps106103 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_48_9 then
						iter_48_9.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps106103 = nil
			end

			local var_48_19 = arg_45_1.actors_["106103"].transform

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_19.localPosition
				var_48_19.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

				for iter_48_10 = 0, var_48_19.childCount - 1 do
					local var_48_20 = var_48_19:GetChild(iter_48_10)

					if var_48_20.name == "" or not string.find(var_48_20.name, "split") then
						var_48_20.gameObject:SetActive(true)
					else
						var_48_20.gameObject:SetActive(false)
					end
				end
			end

			local var_48_21 = 0.001

			if 2 <= arg_45_1.time_ and arg_45_1.time_ < 2 + var_48_21 then
				var_48_19.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 2) / var_48_21)
			end

			if arg_45_1.time_ >= 2 + var_48_21 and arg_45_1.time_ < 2 + var_48_21 + arg_48_0 then
				var_48_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_22 = arg_45_1.actors_["128404"].transform

			if 3.76666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 3.76666666666667 + arg_48_0 then
				arg_45_1.var_.moveOldPos128404 = var_48_22.localPosition
				var_48_22.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("128404", 3)

				for iter_48_11 = 0, var_48_22.childCount - 1 do
					local var_48_23 = var_48_22:GetChild(iter_48_11)

					if var_48_23.name == "" or not string.find(var_48_23.name, "split") then
						var_48_23.gameObject:SetActive(true)
					else
						var_48_23.gameObject:SetActive(false)
					end
				end
			end

			local var_48_24 = 0.001

			if 3.76666666666667 <= arg_45_1.time_ and arg_45_1.time_ < 3.76666666666667 + var_48_24 then
				var_48_22.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_45_1.time_ - 3.76666666666667) / var_48_24)
			end

			if arg_45_1.time_ >= 3.76666666666667 + var_48_24 and arg_45_1.time_ < 3.76666666666667 + var_48_24 + arg_48_0 then
				var_48_22.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 3.76666666666667 < arg_45_1.time_ and arg_45_1.time_ <= 3.76666666666667 + arg_48_0 then
				local var_48_25 = arg_45_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_25 then
					arg_45_1.var_.alphaOldValue128404 = var_48_25.alpha
					arg_45_1.var_.characterEffect128404 = var_48_25
				end

				arg_45_1.var_.alphaOldValue128404 = 0
			end

			local var_48_26 = 0.233333333333333

			if 3.76666666666667 <= arg_45_1.time_ and arg_45_1.time_ < 3.76666666666667 + var_48_26 then
				if arg_45_1.var_.characterEffect128404 then
					arg_45_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_45_1.var_.alphaOldValue128404, 1, (arg_45_1.time_ - 3.76666666666667) / var_48_26)
				end
			end

			if arg_45_1.time_ >= 3.76666666666667 + var_48_26 and arg_45_1.time_ < 3.76666666666667 + var_48_26 + arg_48_0 and arg_45_1.var_.characterEffect128404 then
				arg_45_1.var_.characterEffect128404.alpha = 1
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_27 = 3.999999999999
			local var_48_28 = 0.175

			if 3.999999999999 < arg_45_1.time_ and arg_45_1.time_ <= var_48_27 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_29 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_29:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_30 = arg_45_1:GetWordFromCfg(926052011)
				local var_48_31 = arg_45_1:FormatText(var_48_30.content)

				arg_45_1.text_.text = var_48_31

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_33 = 7 <= 0 and var_48_28 or var_48_28 * (utf8.len(var_48_31) / 7)

				if (7 <= 0 and var_48_28 or var_48_28 * (utf8.len(var_48_31) / 7)) > 0 and var_48_28 < var_48_33 then
					arg_45_1.talkMaxDuration = var_48_33
					var_48_27 = var_48_27 + 0.3

					if var_48_33 + var_48_27 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_33 + var_48_27
					end
				end

				arg_45_1.text_.text = var_48_31
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052011", "story_v_out_926052.awb") ~= 0 then
					local var_48_34 = manager.audio:GetVoiceLength("story_v_out_926052", "926052011", "story_v_out_926052.awb") / 1000

					if var_48_34 + var_48_27 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_34 + var_48_27
					end

					if var_48_30.prefab_name ~= "" and arg_45_1.actors_[var_48_30.prefab_name] ~= nil then
						local var_48_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_30.prefab_name].transform, "story_v_out_926052", "926052011", "story_v_out_926052.awb")

						arg_45_1:RecordAudio("926052011", var_48_35)
						arg_45_1:RecordAudio("926052011", var_48_35)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926052", "926052011", "story_v_out_926052.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926052", "926052011", "story_v_out_926052.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_36 = var_48_27 + 0.3
			local var_48_37 = math.max(var_48_28, arg_45_1.talkMaxDuration)

			if var_48_27 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_36 + var_48_37 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_36) / var_48_37

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_36 + var_48_37 and arg_45_1.time_ < var_48_36 + var_48_37 + arg_48_0 then
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
			if arg_51_1.actors_["106603"] == nil then
				local var_54_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_54_0) then
					local var_54_1 = Object.Instantiate(var_54_0, arg_51_1.canvasGo_.transform)

					var_54_1.transform:SetSiblingIndex(1)

					var_54_1.name = "106603"
					var_54_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_51_1.actors_["106603"] = var_54_1

					if arg_51_1.isInRecall_ then
						for iter_54_0, iter_54_1 in ipairs((var_54_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_54_1.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_54_2 = arg_51_1.actors_["106603"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps106603 == nil then
				arg_51_1.var_.actorSpriteComps106603 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps106603 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								iter_54_3.color = Color.New(Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_3.color.r, 1, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_3.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps106603 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_54_5 then
						iter_54_5.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps106603 = nil
			end

			local var_54_5 = arg_51_1.actors_["128404"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps128404 == nil then
				arg_51_1.var_.actorSpriteComps128404 = var_54_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.actorSpriteComps128404 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								iter_54_7.color = Color.New(Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_6), Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_6), (Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_6)))
							else
								local var_54_7 = Mathf.Lerp(iter_54_7.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_6)

								iter_54_7.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps128404 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_54_9 then
						iter_54_9.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps128404 = nil
			end

			local var_54_8 = arg_51_1.actors_["128404"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos128404 = var_54_8.localPosition
				var_54_8.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("128404", 7)

				for iter_54_10 = 0, var_54_8.childCount - 1 do
					local var_54_9 = var_54_8:GetChild(iter_54_10)

					if var_54_9.name == "" or not string.find(var_54_9.name, "split") then
						var_54_9.gameObject:SetActive(true)
					else
						var_54_9.gameObject:SetActive(false)
					end
				end
			end

			local var_54_10 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_10 then
				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0) / var_54_10)
			end

			if arg_51_1.time_ >= 0 + var_54_10 and arg_51_1.time_ < 0 + var_54_10 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_11 = arg_51_1.actors_["106603"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos106603 = var_54_11.localPosition
				var_54_11.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("106603", 3)

				for iter_54_11 = 0, var_54_11.childCount - 1 do
					local var_54_12 = var_54_11:GetChild(iter_54_11)

					if var_54_12.name == "" or not string.find(var_54_12.name, "split") then
						var_54_12.gameObject:SetActive(true)
					else
						var_54_12.gameObject:SetActive(false)
					end
				end
			end

			local var_54_13 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_13 then
				var_54_11.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_51_1.time_ - 0) / var_54_13)
			end

			if arg_51_1.time_ >= 0 + var_54_13 and arg_51_1.time_ < 0 + var_54_13 + arg_54_0 then
				var_54_11.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_54_14 = 0
			local var_54_15 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_16 = arg_51_1:GetWordFromCfg(926052012)
				local var_54_17 = arg_51_1:FormatText(var_54_16.content)

				arg_51_1.text_.text = var_54_17

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 18 <= 0 and var_54_15 or var_54_15 * (utf8.len(var_54_17) / 18)

				if (18 <= 0 and var_54_15 or var_54_15 * (utf8.len(var_54_17) / 18)) > 0 and var_54_15 < var_54_19 then
					arg_51_1.talkMaxDuration = var_54_19

					if var_54_19 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_14
					end
				end

				arg_51_1.text_.text = var_54_17
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052012", "story_v_out_926052.awb") ~= 0 then
					local var_54_20 = manager.audio:GetVoiceLength("story_v_out_926052", "926052012", "story_v_out_926052.awb") / 1000

					if var_54_20 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_20 + var_54_14
					end

					if var_54_16.prefab_name ~= "" and arg_51_1.actors_[var_54_16.prefab_name] ~= nil then
						local var_54_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_16.prefab_name].transform, "story_v_out_926052", "926052012", "story_v_out_926052.awb")

						arg_51_1:RecordAudio("926052012", var_54_21)
						arg_51_1:RecordAudio("926052012", var_54_21)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_926052", "926052012", "story_v_out_926052.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_926052", "926052012", "story_v_out_926052.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_15, arg_51_1.talkMaxDuration)

			if var_54_14 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_14) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_14 + var_54_22 and arg_51_1.time_ < var_54_14 + var_54_22 + arg_54_0 then
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
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["106103"]) and arg_55_1.var_.actorSpriteComps106103 == nil then
				arg_55_1.var_.actorSpriteComps106103 = arg_55_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["106103"]) then
				if arg_55_1.var_.actorSpriteComps106103 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 1, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["106103"]) and arg_55_1.var_.actorSpriteComps106103 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps106103 = nil
			end

			local var_58_2 = arg_55_1.actors_["106603"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps106603 == nil then
				arg_55_1.var_.actorSpriteComps106603 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps106603 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								iter_58_5.color = Color.New(Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_5.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_5.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps106603 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_58_7 then
						iter_58_7.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps106603 = nil
			end

			local var_58_5 = arg_55_1.actors_["106603"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos106603 = var_58_5.localPosition
				var_58_5.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("106603", 4)

				for iter_58_8 = 0, var_58_5.childCount - 1 do
					local var_58_6 = var_58_5:GetChild(iter_58_8)

					if var_58_6.name == "" or not string.find(var_58_6.name, "split") then
						var_58_6.gameObject:SetActive(true)
					else
						var_58_6.gameObject:SetActive(false)
					end
				end
			end

			local var_58_7 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_55_1.time_ - 0) / var_58_7)
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_58_8 = arg_55_1.actors_["106103"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos106103 = var_58_8.localPosition
				var_58_8.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("106103", 2)

				for iter_58_9 = 0, var_58_8.childCount - 1 do
					local var_58_9 = var_58_8:GetChild(iter_58_9)

					if var_58_9.name == "" or not string.find(var_58_9.name, "split") then
						var_58_9.gameObject:SetActive(true)
					else
						var_58_9.gameObject:SetActive(false)
					end
				end
			end

			local var_58_10 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_10 then
				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_55_1.time_ - 0) / var_58_10)
			end

			if arg_55_1.time_ >= 0 + var_58_10 and arg_55_1.time_ < 0 + var_58_10 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_58_11 = 0
			local var_58_12 = 0.875

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_13 = arg_55_1:GetWordFromCfg(926052013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 35 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 35)

				if (35 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 35)) > 0 and var_58_12 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052013", "story_v_out_926052.awb") ~= 0 then
					local var_58_17 = manager.audio:GetVoiceLength("story_v_out_926052", "926052013", "story_v_out_926052.awb") / 1000

					if var_58_17 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_11
					end

					if var_58_13.prefab_name ~= "" and arg_55_1.actors_[var_58_13.prefab_name] ~= nil then
						local var_58_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_13.prefab_name].transform, "story_v_out_926052", "926052013", "story_v_out_926052.awb")

						arg_55_1:RecordAudio("926052013", var_58_18)
						arg_55_1:RecordAudio("926052013", var_58_18)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_926052", "926052013", "story_v_out_926052.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_926052", "926052013", "story_v_out_926052.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_19 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_19 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_19

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_19 and arg_55_1.time_ < var_58_11 + var_58_19 + arg_58_0 then
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
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["106603"]) and arg_59_1.var_.actorSpriteComps106603 == nil then
				arg_59_1.var_.actorSpriteComps106603 = arg_59_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["106603"]) then
				if arg_59_1.var_.actorSpriteComps106603 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["106603"]) and arg_59_1.var_.actorSpriteComps106603 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps106603 = nil
			end

			local var_62_2 = arg_59_1.actors_["106103"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps106103 == nil then
				arg_59_1.var_.actorSpriteComps106103 = var_62_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_3 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.actorSpriteComps106103 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								iter_62_5.color = Color.New(Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_3), Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_3), (Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_3)))
							else
								local var_62_4 = Mathf.Lerp(iter_62_5.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_3)

								iter_62_5.color = Color.New(var_62_4, var_62_4, var_62_4)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.actorSpriteComps106103 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_62_7 then
						iter_62_7.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps106103 = nil
			end

			local var_62_5 = 0
			local var_62_6 = 1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_7 = arg_59_1:GetWordFromCfg(926052014)
				local var_62_8 = arg_59_1:FormatText(var_62_7.content)

				arg_59_1.text_.text = var_62_8

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 40 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 40)

				if (40 <= 0 and var_62_6 or var_62_6 * (utf8.len(var_62_8) / 40)) > 0 and var_62_6 < var_62_10 then
					arg_59_1.talkMaxDuration = var_62_10

					if var_62_10 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_5
					end
				end

				arg_59_1.text_.text = var_62_8
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052014", "story_v_out_926052.awb") ~= 0 then
					local var_62_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052014", "story_v_out_926052.awb") / 1000

					if var_62_11 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_5
					end

					if var_62_7.prefab_name ~= "" and arg_59_1.actors_[var_62_7.prefab_name] ~= nil then
						local var_62_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_7.prefab_name].transform, "story_v_out_926052", "926052014", "story_v_out_926052.awb")

						arg_59_1:RecordAudio("926052014", var_62_12)
						arg_59_1:RecordAudio("926052014", var_62_12)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_926052", "926052014", "story_v_out_926052.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_926052", "926052014", "story_v_out_926052.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_6, arg_59_1.talkMaxDuration)

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_5) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_5 + var_62_13 and arg_59_1.time_ < var_62_5 + var_62_13 + arg_62_0 then
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
			local var_66_0 = 0.7

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(926052015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 28 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 28)

				if (28 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 28)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052015", "story_v_out_926052.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_926052", "926052015", "story_v_out_926052.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_926052", "926052015", "story_v_out_926052.awb")

						arg_63_1:RecordAudio("926052015", var_66_6)
						arg_63_1:RecordAudio("926052015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_926052", "926052015", "story_v_out_926052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_926052", "926052015", "story_v_out_926052.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
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
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos106603 = arg_67_1.actors_["106603"].transform.localPosition
				arg_67_1.actors_["106603"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("106603", 4)

				for iter_70_0 = 0, arg_67_1.actors_["106603"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["106603"].transform:GetChild(iter_70_0)

					if var_70_0.name == "split_1" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["106603"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos106603, Vector3.New(453.9, -399.1, -303.3), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["106603"].transform.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_70_2 = 0
			local var_70_3 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(926052016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 24 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 24)

				if (24 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 24)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052016", "story_v_out_926052.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052016", "story_v_out_926052.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_926052", "926052016", "story_v_out_926052.awb")

						arg_67_1:RecordAudio("926052016", var_70_9)
						arg_67_1:RecordAudio("926052016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_926052", "926052016", "story_v_out_926052.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_926052", "926052016", "story_v_out_926052.awb")
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
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["106603"]) and arg_71_1.var_.actorSpriteComps106603 == nil then
				arg_71_1.var_.actorSpriteComps106603 = arg_71_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["106603"]) then
				if arg_71_1.var_.actorSpriteComps106603 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["106603"]) and arg_71_1.var_.actorSpriteComps106603 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps106603 = nil
			end

			local var_74_2 = 0
			local var_74_3 = 0.65

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
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

				local var_74_4 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(926052017).content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 26 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 26)

				if (26 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 26)) > 0 and var_74_3 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_7 and arg_71_1.time_ < var_74_2 + var_74_7 + arg_74_0 then
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
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["104701"]) and arg_75_1.var_.actorSpriteComps104701 == nil then
				arg_75_1.var_.actorSpriteComps104701 = arg_75_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["104701"]) then
				if arg_75_1.var_.actorSpriteComps104701 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 1, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["104701"]) and arg_75_1.var_.actorSpriteComps104701 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps104701 = nil
			end

			local var_78_2 = 0
			local var_78_3 = 0.275

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1296].name)

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

				local var_78_4 = arg_75_1:GetWordFromCfg(926052018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 11 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 11)

				if (11 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 11)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052018", "story_v_out_926052.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052018", "story_v_out_926052.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_926052", "926052018", "story_v_out_926052.awb")

						arg_75_1:RecordAudio("926052018", var_78_9)
						arg_75_1:RecordAudio("926052018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_926052", "926052018", "story_v_out_926052.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_926052", "926052018", "story_v_out_926052.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
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
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["104701"]) and arg_79_1.var_.actorSpriteComps104701 == nil then
				arg_79_1.var_.actorSpriteComps104701 = arg_79_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["104701"]) then
				if arg_79_1.var_.actorSpriteComps104701 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["104701"]) and arg_79_1.var_.actorSpriteComps104701 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps104701 = nil
			end

			local var_82_2 = arg_79_1.actors_["106103"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos106103 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("106103", 7)

				for iter_82_4 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_4)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_5 = arg_79_1.actors_["106603"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos106603 = var_82_5.localPosition
				var_82_5.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("106603", 7)

				for iter_82_5 = 0, var_82_5.childCount - 1 do
					local var_82_6 = var_82_5:GetChild(iter_82_5)

					if var_82_6.name == "" or not string.find(var_82_6.name, "split") then
						var_82_6.gameObject:SetActive(true)
					else
						var_82_6.gameObject:SetActive(false)
					end
				end
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_5.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0) / var_82_7)
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_8 = 0
			local var_82_9 = 1.325

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(926052019).content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 53 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 53)

				if (53 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 53)) > 0 and var_82_9 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_13 and arg_79_1.time_ < var_82_8 + var_82_13 + arg_82_0 then
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
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["104701"]) and arg_83_1.var_.actorSpriteComps104701 == nil then
				arg_83_1.var_.actorSpriteComps104701 = arg_83_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["104701"]) then
				if arg_83_1.var_.actorSpriteComps104701 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 1, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["104701"]) and arg_83_1.var_.actorSpriteComps104701 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps104701 = nil
			end

			local var_86_2 = arg_83_1.actors_["104701"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos104701 = var_86_2.localPosition
				var_86_2.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("104701", 3)

				for iter_86_4 = 0, var_86_2.childCount - 1 do
					local var_86_3 = var_86_2:GetChild(iter_86_4)

					if var_86_3.name == "" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_2.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_83_1.time_ - 0) / var_86_4)
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_86_5 = 0
			local var_86_6 = 0.325

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(926052020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 13 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 13)

				if (13 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 13)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052020", "story_v_out_926052.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052020", "story_v_out_926052.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_926052", "926052020", "story_v_out_926052.awb")

						arg_83_1:RecordAudio("926052020", var_86_12)
						arg_83_1:RecordAudio("926052020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_926052", "926052020", "story_v_out_926052.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_926052", "926052020", "story_v_out_926052.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_13 and arg_83_1.time_ < var_86_5 + var_86_13 + arg_86_0 then
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
			local var_90_9001
			local var_90_9000

			if arg_87_1.actors_["10144"] == nil then
				local var_90_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_90_0) then
					local var_90_1 = Object.Instantiate(var_90_0, arg_87_1.canvasGo_.transform)

					var_90_1.transform:SetSiblingIndex(1)

					var_90_1.name = "10144"
					var_90_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_["10144"] = var_90_1

					if arg_87_1.isInRecall_ then
						for iter_90_0, iter_90_1 in ipairs((var_90_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_90_1.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_2 = arg_87_1.actors_["10144"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10144 == nil then
				arg_87_1.var_.actorSpriteComps10144 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps10144 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								iter_90_3.color = Color.New(Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_3.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_3.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps10144 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_90_5 then
						iter_90_5.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps10144 = nil
			end

			local var_90_5 = arg_87_1.actors_["104701"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps104701 == nil then
				arg_87_1.var_.actorSpriteComps104701 = var_90_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.actorSpriteComps104701 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								iter_90_7.color = Color.New(Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_6), Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_6), (Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_6)))
							else
								local var_90_7 = Mathf.Lerp(iter_90_7.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_6)

								iter_90_7.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps104701 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_90_9 then
						iter_90_9.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps104701 = nil
			end

			local var_90_8 = arg_87_1.actors_["104701"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos104701 = var_90_8.localPosition
				var_90_8.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("104701", 7)

				for iter_90_10 = 0, var_90_8.childCount - 1 do
					local var_90_9 = var_90_8:GetChild(iter_90_10)

					if var_90_9.name == "" or not string.find(var_90_9.name, "split") then
						var_90_9.gameObject:SetActive(true)
					else
						var_90_9.gameObject:SetActive(false)
					end
				end
			end

			local var_90_10 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_10 then
				var_90_8.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_10)
			end

			if arg_87_1.time_ >= 0 + var_90_10 and arg_87_1.time_ < 0 + var_90_10 + arg_90_0 then
				var_90_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_11 = arg_87_1.actors_["10144"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10144 = var_90_11.localPosition
				var_90_11.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10144", 4)

				for iter_90_11 = 0, var_90_11.childCount - 1 do
					local var_90_12 = var_90_11:GetChild(iter_90_11)

					if var_90_12.name == "split_5" or not string.find(var_90_12.name, "split") then
						var_90_12.gameObject:SetActive(true)
					else
						var_90_12.gameObject:SetActive(false)
					end
				end
			end

			local var_90_13 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_13 then
				var_90_11.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10144, Vector3.New(556.3, -365.9, 337), (arg_87_1.time_ - 0) / var_90_13)
			end

			if arg_87_1.time_ >= 0 + var_90_13 and arg_87_1.time_ < 0 + var_90_13 + arg_90_0 then
				var_90_11.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			if 0.2 < arg_87_1.time_ and arg_87_1.time_ <= 0.2 + arg_90_0 then
				local var_90_14 = arg_87_1.var_.effect798

				if not arg_87_1.var_.effect798 then
					var_90_14 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_heimu_keep"), arg_87_1.story_ui_effectTrs_.transform)
					var_90_14.name = "798"
					arg_87_1.var_.effect798 = var_90_14
				else
					var_90_14.transform:SetParent(var_90_9001)
				end

				var_90_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_90_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_90_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_90_17 = var_90_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_90_12, iter_90_13 in ipairs((var_90_17:ToTable())) do
					iter_90_13.transform.localScale = Vector3.New(iter_90_13.transform.localScale.x / var_90_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_90_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_90_13.transform.localScale.y / var_90_16, iter_90_13.transform.localScale.z)
				end
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_19 = arg_87_1.var_.effect777

				if not arg_87_1.var_.effect777 then
					var_90_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_voice_keep"), manager.ui.mainCamera.transform)
					var_90_19.name = "777"
					arg_87_1.var_.effect777 = var_90_19
				else
					var_90_19.transform:SetParent(var_90_9000)
				end

				var_90_19.transform.localPosition = Vector3.New(-0.07, 0, 1.46)
				var_90_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_21 = arg_87_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_21 then
					arg_87_1.var_.alphaOldValue10144 = var_90_21.alpha
					arg_87_1.var_.characterEffect10144 = var_90_21
				end

				arg_87_1.var_.alphaOldValue10144 = 0
			end

			local var_90_22 = 0.566666666666667

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_22 then
				if arg_87_1.var_.characterEffect10144 then
					arg_87_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_87_1.var_.alphaOldValue10144, 1, (arg_87_1.time_ - 0) / var_90_22)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_22 and arg_87_1.time_ < 0 + var_90_22 + arg_90_0 and arg_87_1.var_.characterEffect10144 then
				arg_87_1.var_.characterEffect10144.alpha = 1
			end

			if 0.733333333333333 < arg_87_1.time_ and arg_87_1.time_ <= 0.733333333333333 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_143", "se_story_143_action_summer1_story_intense_down", "")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_143", "se_story_143_volume_down", "")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_25 = 1.63333333333333
			local var_90_26 = 0.15

			if 1.63333333333333 < arg_87_1.time_ and arg_87_1.time_ <= var_90_25 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_27 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_27:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_28 = arg_87_1:GetWordFromCfg(926052021)
				local var_90_29 = arg_87_1:FormatText(var_90_28.content)

				arg_87_1.text_.text = var_90_29

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_31 = 6 <= 0 and var_90_26 or var_90_26 * (utf8.len(var_90_29) / 6)

				if (6 <= 0 and var_90_26 or var_90_26 * (utf8.len(var_90_29) / 6)) > 0 and var_90_26 < var_90_31 then
					arg_87_1.talkMaxDuration = var_90_31
					var_90_25 = var_90_25 + 0.3

					if var_90_31 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_31 + var_90_25
					end
				end

				arg_87_1.text_.text = var_90_29
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052021", "story_v_out_926052.awb") ~= 0 then
					local var_90_32 = manager.audio:GetVoiceLength("story_v_out_926052", "926052021", "story_v_out_926052.awb") / 1000

					if var_90_32 + var_90_25 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_32 + var_90_25
					end

					if var_90_28.prefab_name ~= "" and arg_87_1.actors_[var_90_28.prefab_name] ~= nil then
						local var_90_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_28.prefab_name].transform, "story_v_out_926052", "926052021", "story_v_out_926052.awb")

						arg_87_1:RecordAudio("926052021", var_90_33)
						arg_87_1:RecordAudio("926052021", var_90_33)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_926052", "926052021", "story_v_out_926052.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_926052", "926052021", "story_v_out_926052.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_34 = var_90_25 + 0.3
			local var_90_35 = math.max(var_90_26, arg_87_1.talkMaxDuration)

			if var_90_25 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_34 + var_90_35 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_34) / var_90_35

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_34 + var_90_35 and arg_87_1.time_ < var_90_34 + var_90_35 + arg_90_0 then
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
			local var_96_0 = 0.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(926052022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 29 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 29)

				if (29 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 29)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052022", "story_v_out_926052.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_926052", "926052022", "story_v_out_926052.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_926052", "926052022", "story_v_out_926052.awb")

						arg_93_1:RecordAudio("926052022", var_96_6)
						arg_93_1:RecordAudio("926052022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926052", "926052022", "story_v_out_926052.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926052", "926052022", "story_v_out_926052.awb")
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
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10144 = arg_97_1.actors_["10144"].transform.localPosition
				arg_97_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10144", 4)

				for iter_100_0 = 0, arg_97_1.actors_["10144"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10144"].transform:GetChild(iter_100_0)

					if var_100_0.name == "split_6" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10144, Vector3.New(556.3, -365.9, 337), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10144"].transform.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_100_2 = 0
			local var_100_3 = 0.5

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(926052023)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 20 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 20)

				if (20 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 20)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052023", "story_v_out_926052.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052023", "story_v_out_926052.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_926052", "926052023", "story_v_out_926052.awb")

						arg_97_1:RecordAudio("926052023", var_100_9)
						arg_97_1:RecordAudio("926052023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_926052", "926052023", "story_v_out_926052.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_926052", "926052023", "story_v_out_926052.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
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
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10144"]) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = arg_101_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10144"]) then
				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10144"]) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_2 = 0
			local var_104_3 = 0.3

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
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

				local var_104_4 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(926052024).content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 12 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_4) / 12)

				if (12 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_4) / 12)) > 0 and var_104_3 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_7 and arg_101_1.time_ < var_104_2 + var_104_7 + arg_104_0 then
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
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10144"]) and arg_105_1.var_.actorSpriteComps10144 == nil then
				arg_105_1.var_.actorSpriteComps10144 = arg_105_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10144"]) then
				if arg_105_1.var_.actorSpriteComps10144 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 1, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10144"]) and arg_105_1.var_.actorSpriteComps10144 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10144 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 0.85

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(926052025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 34 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 34)

				if (34 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 34)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052025", "story_v_out_926052.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052025", "story_v_out_926052.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_926052", "926052025", "story_v_out_926052.awb")

						arg_105_1:RecordAudio("926052025", var_108_9)
						arg_105_1:RecordAudio("926052025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_926052", "926052025", "story_v_out_926052.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_926052", "926052025", "story_v_out_926052.awb")
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
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10144 = arg_109_1.actors_["10144"].transform.localPosition
				arg_109_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10144", 4)

				for iter_112_0 = 0, arg_109_1.actors_["10144"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10144"].transform:GetChild(iter_112_0)

					if var_112_0.name == "split_6" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10144, Vector3.New(556.3, -365.9, 337), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10144"].transform.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_112_2 = 0
			local var_112_3 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(926052026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 21 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 21)

				if (21 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 21)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052026", "story_v_out_926052.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052026", "story_v_out_926052.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_926052", "926052026", "story_v_out_926052.awb")

						arg_109_1:RecordAudio("926052026", var_112_9)
						arg_109_1:RecordAudio("926052026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926052", "926052026", "story_v_out_926052.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926052", "926052026", "story_v_out_926052.awb")
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
			local var_116_0 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(926052027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)

				if (18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 18)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052027", "story_v_out_926052.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_926052", "926052027", "story_v_out_926052.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_926052", "926052027", "story_v_out_926052.awb")

						arg_113_1:RecordAudio("926052027", var_116_6)
						arg_113_1:RecordAudio("926052027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926052", "926052027", "story_v_out_926052.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926052", "926052027", "story_v_out_926052.awb")
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
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = arg_117_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10144"]) then
				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_2 = arg_117_1.actors_["10144"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 7)

				for iter_120_4 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_4)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_5 = 0
			local var_120_6 = 0.675

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(926052028).content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 27 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_7) / 27)

				if (27 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_7) / 27)) > 0 and var_120_6 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_10 and arg_117_1.time_ < var_120_5 + var_120_10 + arg_120_0 then
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
			local var_124_0 = 0.75

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

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(926052029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 30 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 30)

				if (30 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 30)) > 0 and var_124_0 < var_124_3 then
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
			local var_128_0 = 0.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(926052030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 15)

				if (15 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 15)) > 0 and var_128_0 < var_128_3 then
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
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["128404"]) and arg_129_1.var_.actorSpriteComps128404 == nil then
				arg_129_1.var_.actorSpriteComps128404 = arg_129_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["128404"]) then
				if arg_129_1.var_.actorSpriteComps128404 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["128404"]) and arg_129_1.var_.actorSpriteComps128404 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps128404 = nil
			end

			local var_132_2 = arg_129_1.actors_["128404"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos128404 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("128404", 2)

				for iter_132_4 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_4)

					if var_132_3.name == "split_4" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos128404, Vector3.New(-477.4, -374.11, 163.8), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(-477.4, -374.11, 163.8)
			end

			local var_132_5 = 0
			local var_132_6 = 0.225

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(926052031)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 9 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 9)

				if (9 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 9)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052031", "story_v_out_926052.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052031", "story_v_out_926052.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_926052", "926052031", "story_v_out_926052.awb")

						arg_129_1:RecordAudio("926052031", var_132_12)
						arg_129_1:RecordAudio("926052031", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926052", "926052031", "story_v_out_926052.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926052", "926052031", "story_v_out_926052.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10144"]) and arg_133_1.var_.actorSpriteComps10144 == nil then
				arg_133_1.var_.actorSpriteComps10144 = arg_133_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10144"]) then
				if arg_133_1.var_.actorSpriteComps10144 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 1, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10144"]) and arg_133_1.var_.actorSpriteComps10144 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10144 = nil
			end

			local var_136_2 = arg_133_1.actors_["128404"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps128404 == nil then
				arg_133_1.var_.actorSpriteComps128404 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps128404 then
					for iter_136_4, iter_136_5 in pairs(arg_133_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_136_5 then
							if arg_133_1.isInRecall_ then
								iter_136_5.color = Color.New(Mathf.Lerp(iter_136_5.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_5.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_5.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_5.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_5.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps128404 then
				for iter_136_6, iter_136_7 in pairs(arg_133_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_136_7 then
						iter_136_7.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps128404 = nil
			end

			local var_136_5 = arg_133_1.actors_["10144"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = var_136_5.localPosition
				var_136_5.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 4)

				for iter_136_8 = 0, var_136_5.childCount - 1 do
					local var_136_6 = var_136_5:GetChild(iter_136_8)

					if var_136_6.name == "split_6" or not string.find(var_136_6.name, "split") then
						var_136_6.gameObject:SetActive(true)
					else
						var_136_6.gameObject:SetActive(false)
					end
				end
			end

			local var_136_7 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				var_136_5.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, Vector3.New(556.3, -365.9, 337), (arg_133_1.time_ - 0) / var_136_7)
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				var_136_5.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			local var_136_8 = 0
			local var_136_9 = 0.4

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(926052032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 16 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 16)

				if (16 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 16)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052032", "story_v_out_926052.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052032", "story_v_out_926052.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_926052", "926052032", "story_v_out_926052.awb")

						arg_133_1:RecordAudio("926052032", var_136_15)
						arg_133_1:RecordAudio("926052032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926052", "926052032", "story_v_out_926052.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926052", "926052032", "story_v_out_926052.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
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
			local var_140_0 = 0.1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(926052033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 4 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 4)

				if (4 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 4)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052033", "story_v_out_926052.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_926052", "926052033", "story_v_out_926052.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_926052", "926052033", "story_v_out_926052.awb")

						arg_137_1:RecordAudio("926052033", var_140_6)
						arg_137_1:RecordAudio("926052033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_926052", "926052033", "story_v_out_926052.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_926052", "926052033", "story_v_out_926052.awb")
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
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = arg_141_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10144"]) then
				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_2 = arg_141_1.actors_["10144"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 7)

				for iter_144_4 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_4)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_5 = arg_141_1.actors_["128404"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos128404 = var_144_5.localPosition
				var_144_5.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("128404", 7)

				for iter_144_5 = 0, var_144_5.childCount - 1 do
					local var_144_6 = var_144_5:GetChild(iter_144_5)

					if var_144_6.name == "" or not string.find(var_144_6.name, "split") then
						var_144_6.gameObject:SetActive(true)
					else
						var_144_6.gameObject:SetActive(false)
					end
				end
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_141_1.time_ - 0) / var_144_7)
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_8 = 0
			local var_144_9 = 0.775

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(926052034).content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_12 = 31 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_10) / 31)

				if (31 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_10) / 31)) > 0 and var_144_9 < var_144_12 then
					arg_141_1.talkMaxDuration = var_144_12

					if var_144_12 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_13 and arg_141_1.time_ < var_144_8 + var_144_13 + arg_144_0 then
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
			local var_148_0 = 0.825

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(926052035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 33 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 33)

				if (33 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 33)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
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
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = arg_149_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["128404"]) then
				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 1, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.2

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[6].name)

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

				local var_152_4 = arg_149_1:GetWordFromCfg(926052036)
				local var_152_5 = arg_149_1:FormatText(var_152_4.content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 8 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 8)

				if (8 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_5) / 8)) > 0 and var_152_3 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052036", "story_v_out_926052.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052036", "story_v_out_926052.awb") / 1000

					if var_152_8 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_2
					end

					if var_152_4.prefab_name ~= "" and arg_149_1.actors_[var_152_4.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_4.prefab_name].transform, "story_v_out_926052", "926052036", "story_v_out_926052.awb")

						arg_149_1:RecordAudio("926052036", var_152_9)
						arg_149_1:RecordAudio("926052036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_926052", "926052036", "story_v_out_926052.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_926052", "926052036", "story_v_out_926052.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_10 and arg_149_1.time_ < var_152_2 + var_152_10 + arg_152_0 then
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
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10144"]) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = arg_153_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10144"]) then
				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10144"]) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_2 = arg_153_1.actors_["128404"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								iter_156_5.color = Color.New(Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_5.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_5.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_7 then
						iter_156_7.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1297].name)

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

				local var_156_7 = arg_153_1:GetWordFromCfg(926052037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 20 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 20)

				if (20 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 20)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052037", "story_v_out_926052.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052037", "story_v_out_926052.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_926052", "926052037", "story_v_out_926052.awb")

						arg_153_1:RecordAudio("926052037", var_156_12)
						arg_153_1:RecordAudio("926052037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926052", "926052037", "story_v_out_926052.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926052", "926052037", "story_v_out_926052.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
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
			local var_160_9001
			local var_160_9000

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = arg_157_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10144"]) then
				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				local var_160_2 = arg_157_1.var_.effect666

				if not arg_157_1.var_.effect666 then
					var_160_2 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_heimu_out"), arg_157_1.story_ui_effectTrs_.transform)
					var_160_2.name = "666"
					arg_157_1.var_.effect666 = var_160_2
				else
					var_160_2.transform:SetParent(var_160_9001)
				end

				var_160_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_160_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_160_4 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_160_5 = var_160_2.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_160_4, iter_160_5 in ipairs((var_160_5:ToTable())) do
					iter_160_5.transform.localScale = Vector3.New(iter_160_5.transform.localScale.x / var_160_4 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_160_5 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_160_5.transform.localScale.y / var_160_4, iter_160_5.transform.localScale.z)
				end
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				local var_160_7 = arg_157_1.var_.effect222

				if not arg_157_1.var_.effect222 then
					var_160_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_voice_out"), manager.ui.mainCamera.transform)
					var_160_7.name = "222"
					arg_157_1.var_.effect222 = var_160_7
				else
					var_160_7.transform:SetParent(var_160_9000)
				end

				var_160_7.transform.localPosition = Vector3.New(-0.07, 0, 1.46)
				var_160_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				if arg_157_1.var_.effect798 then
					Object.Destroy(arg_157_1.var_.effect798)

					arg_157_1.var_.effect798 = nil
				end
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				if arg_157_1.var_.effect777 then
					Object.Destroy(arg_157_1.var_.effect777)

					arg_157_1.var_.effect777 = nil
				end
			end

			local var_160_11 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_11 + 2.7 and arg_157_1.time_ < var_160_11 + 2.7 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if 0.034 < arg_157_1.time_ and arg_157_1.time_ <= 0.034 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_143", "se_story_143_action_summer1_story_intense_up", "")
			end

			if 0.034 < arg_157_1.time_ and arg_157_1.time_ <= 0.034 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_143", "se_story_143_volume_up", "")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_143", "se_story_143_leaves", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_15 = 2.06666666666667
			local var_160_16 = 1.1

			if 2.06666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_17 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_17:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(926052038).content)

				arg_157_1.text_.text = var_160_18

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 44 <= 0 and var_160_16 or var_160_16 * (utf8.len(var_160_18) / 44)

				if (44 <= 0 and var_160_16 or var_160_16 * (utf8.len(var_160_18) / 44)) > 0 and var_160_16 < var_160_20 then
					arg_157_1.talkMaxDuration = var_160_20
					var_160_15 = var_160_15 + 0.3

					if var_160_20 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_18
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_21 = var_160_15 + 0.3
			local var_160_22 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_22 and arg_157_1.time_ < var_160_21 + var_160_22 + arg_160_0 then
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
			local var_166_0 = 0.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(926052039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 3 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 3)

				if (3 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 3)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
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
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10144"]) and arg_167_1.var_.actorSpriteComps10144 == nil then
				arg_167_1.var_.actorSpriteComps10144 = arg_167_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10144"]) then
				if arg_167_1.var_.actorSpriteComps10144 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 1, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10144"]) and arg_167_1.var_.actorSpriteComps10144 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10144 = nil
			end

			local var_170_2 = arg_167_1.actors_["10144"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10144 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10144", 4)

				for iter_170_4 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_4)

					if var_170_3.name == "split_4" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10144, Vector3.New(556.3, -365.9, 337), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(556.3, -365.9, 337)
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				local var_170_5 = arg_167_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_5 then
					arg_167_1.var_.alphaOldValue10144 = var_170_5.alpha
					arg_167_1.var_.characterEffect10144 = var_170_5
				end

				arg_167_1.var_.alphaOldValue10144 = 0
			end

			local var_170_6 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 then
				if arg_167_1.var_.characterEffect10144 then
					arg_167_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_167_1.var_.alphaOldValue10144, 1, (arg_167_1.time_ - 0) / var_170_6)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and arg_167_1.var_.characterEffect10144 then
				arg_167_1.var_.characterEffect10144.alpha = 1
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_7 = 0.2
			local var_170_8 = 0.4

			if 0.2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_9 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_9:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(926052040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 16 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_11) / 16)

				if (16 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_11) / 16)) > 0 and var_170_8 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13
					var_170_7 = var_170_7 + 0.3

					if var_170_13 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_7
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052040", "story_v_out_926052.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052040", "story_v_out_926052.awb") / 1000

					if var_170_14 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_7
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_926052", "926052040", "story_v_out_926052.awb")

						arg_167_1:RecordAudio("926052040", var_170_15)
						arg_167_1:RecordAudio("926052040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_926052", "926052040", "story_v_out_926052.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_926052", "926052040", "story_v_out_926052.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = var_170_7 + 0.3
			local var_170_17 = math.max(var_170_8, arg_167_1.talkMaxDuration)

			if var_170_7 + 0.3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_16) / var_170_17

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 then
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
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["128404"]) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = arg_173_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["128404"]) then
				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["128404"]) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_2 = arg_173_1.actors_["10144"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10144 == nil then
				arg_173_1.var_.actorSpriteComps10144 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10144 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10144 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_176_7 then
						iter_176_7.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10144 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

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

				local var_176_7 = arg_173_1:GetWordFromCfg(926052041)
				local var_176_8 = arg_173_1:FormatText(var_176_7.content)

				arg_173_1.text_.text = var_176_8

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 10 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 10)

				if (10 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 10)) > 0 and var_176_6 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_8
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052041", "story_v_out_926052.awb") ~= 0 then
					local var_176_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052041", "story_v_out_926052.awb") / 1000

					if var_176_11 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_5
					end

					if var_176_7.prefab_name ~= "" and arg_173_1.actors_[var_176_7.prefab_name] ~= nil then
						local var_176_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_7.prefab_name].transform, "story_v_out_926052", "926052041", "story_v_out_926052.awb")

						arg_173_1:RecordAudio("926052041", var_176_12)
						arg_173_1:RecordAudio("926052041", var_176_12)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_926052", "926052041", "story_v_out_926052.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_926052", "926052041", "story_v_out_926052.awb")
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
			local var_180_9000

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10144"]) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = arg_177_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10144"]) then
				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10144"]) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_2 = arg_177_1.actors_["128404"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps128404 == nil then
				arg_177_1.var_.actorSpriteComps128404 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps128404 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps128404 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps128404 = nil
			end

			local var_180_5 = arg_177_1.actors_["128404"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_5.localPosition
				var_180_5.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 7)

				for iter_180_8 = 0, var_180_5.childCount - 1 do
					local var_180_6 = var_180_5:GetChild(iter_180_8)

					if var_180_6.name == "" or not string.find(var_180_6.name, "split") then
						var_180_6.gameObject:SetActive(true)
					else
						var_180_6.gameObject:SetActive(false)
					end
				end
			end

			local var_180_7 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				var_180_5.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_177_1.time_ - 0) / var_180_7)
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				var_180_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_8 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_9 = 1

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 then
				local var_180_10 = Color.New(1, 1, 1)

				var_180_10.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_8) / var_180_9)
				arg_177_1.mask_.color = var_180_10
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 then
				local var_180_11 = Color.New(1, 1, 1)

				arg_177_1.mask_.enabled = false
				var_180_11.a = 0
				arg_177_1.mask_.color = var_180_11
			end

			local var_180_12 = manager.ui.mainCamera.transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = var_180_12.localPosition
			end

			local var_180_13 = 0.6

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_13 then
				local var_180_14, var_180_15 = math.modf((arg_177_1.time_ - 0) / 0.066)

				var_180_12.localPosition = Vector3.New(var_180_15 * 0.13, var_180_15 * 0.13, var_180_15 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= 0 + var_180_13 and arg_177_1.time_ < 0 + var_180_13 + arg_180_0 then
				var_180_12.localPosition = arg_177_1.var_.shakeOldPos
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_16 = arg_177_1.var_.effect6346

				if not arg_177_1.var_.effect6346 then
					var_180_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_180_16.name = "6346"
					arg_177_1.var_.effect6346 = var_180_16
				else
					var_180_16.transform:SetParent(var_180_9000)
				end

				var_180_16.transform.localPosition = Vector3.New(0, 0, -2.36)
				var_180_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_180_18 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_18 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_18 + 1.2 and arg_177_1.time_ < var_180_18 + 1.2 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_19 = arg_177_1.actors_["10144"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10144 = var_180_19.localPosition
				var_180_19.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10144", 2)

				for iter_180_9 = 0, var_180_19.childCount - 1 do
					local var_180_20 = var_180_19:GetChild(iter_180_9)

					if var_180_20.name == "split_5" or not string.find(var_180_20.name, "split") then
						var_180_20.gameObject:SetActive(true)
					else
						var_180_20.gameObject:SetActive(false)
					end
				end
			end

			local var_180_21 = 0.266666666666667

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_21 then
				var_180_19.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10144, Vector3.New(-199.8, -381.1, -990.8), (arg_177_1.time_ - 0) / var_180_21)
			end

			if arg_177_1.time_ >= 0 + var_180_21 and arg_177_1.time_ < 0 + var_180_21 + arg_180_0 then
				var_180_19.localPosition = Vector3.New(-199.8, -381.1, -990.8)
			end

			if 0.034 < arg_177_1.time_ and arg_177_1.time_ <= 0.034 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_143", "se_story_143_explode", "")
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_23 = 1.05
			local var_180_24 = 0.15

			if 1.05 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_25 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_25:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(926052042)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_29 = 6 <= 0 and var_180_24 or var_180_24 * (utf8.len(var_180_27) / 6)

				if (6 <= 0 and var_180_24 or var_180_24 * (utf8.len(var_180_27) / 6)) > 0 and var_180_24 < var_180_29 then
					arg_177_1.talkMaxDuration = var_180_29
					var_180_23 = var_180_23 + 0.3

					if var_180_29 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_29 + var_180_23
					end
				end

				arg_177_1.text_.text = var_180_27
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052042", "story_v_out_926052.awb") ~= 0 then
					local var_180_30 = manager.audio:GetVoiceLength("story_v_out_926052", "926052042", "story_v_out_926052.awb") / 1000

					if var_180_30 + var_180_23 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_23
					end

					if var_180_26.prefab_name ~= "" and arg_177_1.actors_[var_180_26.prefab_name] ~= nil then
						local var_180_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_26.prefab_name].transform, "story_v_out_926052", "926052042", "story_v_out_926052.awb")

						arg_177_1:RecordAudio("926052042", var_180_31)
						arg_177_1:RecordAudio("926052042", var_180_31)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926052", "926052042", "story_v_out_926052.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926052", "926052042", "story_v_out_926052.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_32 = var_180_23 + 0.3
			local var_180_33 = math.max(var_180_24, arg_177_1.talkMaxDuration)

			if var_180_23 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_32 + var_180_33 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_32) / var_180_33

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_32 + var_180_33 and arg_177_1.time_ < var_180_32 + var_180_33 + arg_180_0 then
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
			if 1 < arg_183_1.time_ and arg_183_1.time_ <= 1 + arg_186_0 then
				local var_186_0 = arg_183_1.bgs_.I21f

				arg_183_1.bgs_.I21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_1 = var_186_0:GetComponent("SpriteRenderer")

				if var_186_1 and var_186_1.sprite then
					local var_186_2 = 2 * (var_186_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_0.transform.localScale = Vector3.New(var_186_2 / var_186_1.sprite.bounds.size.y < var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x and var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x or var_186_2 / var_186_1.sprite.bounds.size.y, var_186_2 / var_186_1.sprite.bounds.size.y < var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x and var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x or var_186_2 / var_186_1.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "I21f" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_3 = 1

			if 1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_3 + 0.3 and arg_183_1.time_ < var_186_3 + 0.3 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_4 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_5 = 1

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_5 then
				local var_186_6 = Color.New(0, 0, 0)

				var_186_6.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_4) / var_186_5)
				arg_183_1.mask_.color = var_186_6
			end

			if arg_183_1.time_ >= var_186_4 + var_186_5 and arg_183_1.time_ < var_186_4 + var_186_5 + arg_186_0 then
				local var_186_7 = Color.New(0, 0, 0)

				var_186_7.a = 1
				arg_183_1.mask_.color = var_186_7
			end

			local var_186_8 = 1

			if 1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_9 = 2

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 then
				local var_186_10 = Color.New(0, 0, 0)

				var_186_10.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_8) / var_186_9)
				arg_183_1.mask_.color = var_186_10
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 then
				local var_186_11 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_11.a = 0
				arg_183_1.mask_.color = var_186_11
			end

			local var_186_12 = arg_183_1.actors_["128404"]

			if 2.7 < arg_183_1.time_ and arg_183_1.time_ <= 2.7 + arg_186_0 and not isNil(var_186_12) and arg_183_1.var_.actorSpriteComps128404 == nil then
				arg_183_1.var_.actorSpriteComps128404 = var_186_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_13 = 0.2

			if 2.7 <= arg_183_1.time_ and arg_183_1.time_ < 2.7 + var_186_13 and not isNil(var_186_12) then
				if arg_183_1.var_.actorSpriteComps128404 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								iter_186_3.color = Color.New(Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 2.7) / var_186_13), Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 2.7) / var_186_13), (Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 2.7) / var_186_13)))
							else
								local var_186_14 = Mathf.Lerp(iter_186_3.color.r, 1, (arg_183_1.time_ - 2.7) / var_186_13)

								iter_186_3.color = Color.New(var_186_14, var_186_14, var_186_14)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 2.7 + var_186_13 and arg_183_1.time_ < 2.7 + var_186_13 + arg_186_0 and not isNil(var_186_12) and arg_183_1.var_.actorSpriteComps128404 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_186_5 then
						iter_186_5.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps128404 = nil
			end

			local var_186_15 = arg_183_1.actors_["128404"].transform

			if 2.7 < arg_183_1.time_ and arg_183_1.time_ <= 2.7 + arg_186_0 then
				arg_183_1.var_.moveOldPos128404 = var_186_15.localPosition
				var_186_15.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("128404", 3)

				for iter_186_6 = 0, var_186_15.childCount - 1 do
					local var_186_16 = var_186_15:GetChild(iter_186_6)

					if var_186_16.name == "split_5" or not string.find(var_186_16.name, "split") then
						var_186_16.gameObject:SetActive(true)
					else
						var_186_16.gameObject:SetActive(false)
					end
				end
			end

			local var_186_17 = 0.001

			if 2.7 <= arg_183_1.time_ and arg_183_1.time_ < 2.7 + var_186_17 then
				var_186_15.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_183_1.time_ - 2.7) / var_186_17)
			end

			if arg_183_1.time_ >= 2.7 + var_186_17 and arg_183_1.time_ < 2.7 + var_186_17 + arg_186_0 then
				var_186_15.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 2.7 < arg_183_1.time_ and arg_183_1.time_ <= 2.7 + arg_186_0 then
				local var_186_18 = arg_183_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_186_18 then
					arg_183_1.var_.alphaOldValue128404 = var_186_18.alpha
					arg_183_1.var_.characterEffect128404 = var_186_18
				end

				arg_183_1.var_.alphaOldValue128404 = 0
			end

			local var_186_19 = 0.2

			if 2.7 <= arg_183_1.time_ and arg_183_1.time_ < 2.7 + var_186_19 then
				if arg_183_1.var_.characterEffect128404 then
					arg_183_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_183_1.var_.alphaOldValue128404, 1, (arg_183_1.time_ - 2.7) / var_186_19)
				end
			end

			if arg_183_1.time_ >= 2.7 + var_186_19 and arg_183_1.time_ < 2.7 + var_186_19 + arg_186_0 and arg_183_1.var_.characterEffect128404 then
				arg_183_1.var_.characterEffect128404.alpha = 1
			end

			if 1 < arg_183_1.time_ and arg_183_1.time_ <= 1 + arg_186_0 then
				if arg_183_1.var_.effect6346 then
					Object.Destroy(arg_183_1.var_.effect6346)

					arg_183_1.var_.effect6346 = nil
				end
			end

			local var_186_21 = arg_183_1.actors_["10144"].transform

			if 1 < arg_183_1.time_ and arg_183_1.time_ <= 1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10144 = var_186_21.localPosition
				var_186_21.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10144", 7)

				for iter_186_7 = 0, var_186_21.childCount - 1 do
					local var_186_22 = var_186_21:GetChild(iter_186_7)

					if var_186_22.name == "" or not string.find(var_186_22.name, "split") then
						var_186_22.gameObject:SetActive(true)
					else
						var_186_22.gameObject:SetActive(false)
					end
				end
			end

			local var_186_23 = 0.001

			if 1 <= arg_183_1.time_ and arg_183_1.time_ < 1 + var_186_23 then
				var_186_21.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 1) / var_186_23)
			end

			if arg_183_1.time_ >= 1 + var_186_23 and arg_183_1.time_ < 1 + var_186_23 + arg_186_0 then
				var_186_21.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_186_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_26 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_26

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_26
						arg_183_1.bgmTxt2_.text = var_186_26
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

			local var_186_27 = 3
			local var_186_28 = 0.466666666666666

			if 3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_27 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_29 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_29:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_183_1.dialogCg_.alpha = arg_188_0
				end))
				var_186_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_30 = arg_183_1:GetWordFromCfg(926052043)
				local var_186_31 = arg_183_1:FormatText(var_186_30.content)

				arg_183_1.text_.text = var_186_31

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_33 = 13 <= 0 and var_186_28 or var_186_28 * (utf8.len(var_186_31) / 13)

				if (13 <= 0 and var_186_28 or var_186_28 * (utf8.len(var_186_31) / 13)) > 0 and var_186_28 < var_186_33 then
					arg_183_1.talkMaxDuration = var_186_33
					var_186_27 = var_186_27 + 0.3

					if var_186_33 + var_186_27 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_33 + var_186_27
					end
				end

				arg_183_1.text_.text = var_186_31
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052043", "story_v_out_926052.awb") ~= 0 then
					local var_186_34 = manager.audio:GetVoiceLength("story_v_out_926052", "926052043", "story_v_out_926052.awb") / 1000

					if var_186_34 + var_186_27 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_34 + var_186_27
					end

					if var_186_30.prefab_name ~= "" and arg_183_1.actors_[var_186_30.prefab_name] ~= nil then
						local var_186_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_30.prefab_name].transform, "story_v_out_926052", "926052043", "story_v_out_926052.awb")

						arg_183_1:RecordAudio("926052043", var_186_35)
						arg_183_1:RecordAudio("926052043", var_186_35)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926052", "926052043", "story_v_out_926052.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926052", "926052043", "story_v_out_926052.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_36 = var_186_27 + 0.3
			local var_186_37 = math.max(var_186_28, arg_183_1.talkMaxDuration)

			if var_186_27 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_36 + var_186_37 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_36) / var_186_37

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_36 + var_186_37 and arg_183_1.time_ < var_186_36 + var_186_37 + arg_186_0 then
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
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["128404"]) and arg_190_1.var_.actorSpriteComps128404 == nil then
				arg_190_1.var_.actorSpriteComps128404 = arg_190_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["128404"]) then
				if arg_190_1.var_.actorSpriteComps128404 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["128404"]) and arg_190_1.var_.actorSpriteComps128404 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps128404 = nil
			end

			local var_193_2 = arg_190_1.actors_["128404"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos128404 = var_193_2.localPosition
				var_193_2.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("128404", 7)

				for iter_193_4 = 0, var_193_2.childCount - 1 do
					local var_193_3 = var_193_2:GetChild(iter_193_4)

					if var_193_3.name == "" or not string.find(var_193_3.name, "split") then
						var_193_3.gameObject:SetActive(true)
					else
						var_193_3.gameObject:SetActive(false)
					end
				end
			end

			local var_193_4 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				var_193_2.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_190_1.time_ - 0) / var_193_4)
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				var_193_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_193_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_7 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_7

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_7
						arg_190_1.bgmTxt2_.text = var_193_7
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

			if 0.2 < arg_190_1.time_ and arg_190_1.time_ <= 0.2 + arg_193_0 then
				arg_190_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_193_10 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_10 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_10

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_10
						arg_190_1.bgmTxt2_.text = var_193_10
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

			local var_193_11 = 0
			local var_193_12 = 0.925

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_11 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_13 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(926052044).content)

				arg_190_1.text_.text = var_193_13

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_15 = 70 <= 0 and var_193_12 or var_193_12 * (utf8.len(var_193_13) / 70)

				if (70 <= 0 and var_193_12 or var_193_12 * (utf8.len(var_193_13) / 70)) > 0 and var_193_12 < var_193_15 then
					arg_190_1.talkMaxDuration = var_193_15

					if var_193_15 + var_193_11 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_15 + var_193_11
					end
				end

				arg_190_1.text_.text = var_193_13
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_16 = math.max(var_193_12, arg_190_1.talkMaxDuration)

			if var_193_11 <= arg_190_1.time_ and arg_190_1.time_ < var_193_11 + var_193_16 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_11) / var_193_16

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_11 + var_193_16 and arg_190_1.time_ < var_193_11 + var_193_16 + arg_193_0 then
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

			local var_199_2 = arg_196_1.actors_["10144"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_2.localPosition
				var_199_2.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 3)

				for iter_199_4 = 0, var_199_2.childCount - 1 do
					local var_199_3 = var_199_2:GetChild(iter_199_4)

					if var_199_3.name == "split_7" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				var_199_2.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_196_1.time_ - 0) / var_199_4)
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				var_199_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_199_5 = 0
			local var_199_6 = 0.25

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
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

				local var_199_7 = arg_196_1:GetWordFromCfg(926052045)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 10 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 10)

				if (10 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 10)) > 0 and var_199_6 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052045", "story_v_out_926052.awb") ~= 0 then
					local var_199_11 = manager.audio:GetVoiceLength("story_v_out_926052", "926052045", "story_v_out_926052.awb") / 1000

					if var_199_11 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_5
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_out_926052", "926052045", "story_v_out_926052.awb")

						arg_196_1:RecordAudio("926052045", var_199_12)
						arg_196_1:RecordAudio("926052045", var_199_12)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_926052", "926052045", "story_v_out_926052.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_926052", "926052045", "story_v_out_926052.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_13 and arg_196_1.time_ < var_199_5 + var_199_13 + arg_199_0 then
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
			local var_203_3 = 0.3

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

				local var_203_4 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(926052046).content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_6 = 12 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 12)

				if (12 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_4) / 12)) > 0 and var_203_3 < var_203_6 then
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
			local var_207_0 = 0.55

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

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(926052047).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 22)

				if (22 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 22)) > 0 and var_207_0 < var_207_3 then
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
			local var_211_0 = 0.3

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

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(926052048).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 12 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 12)

				if (12 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 12)) > 0 and var_211_0 < var_211_3 then
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
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["128404"]) and arg_212_1.var_.actorSpriteComps128404 == nil then
				arg_212_1.var_.actorSpriteComps128404 = arg_212_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["128404"]) then
				if arg_212_1.var_.actorSpriteComps128404 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 1, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["128404"]) and arg_212_1.var_.actorSpriteComps128404 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps128404 = nil
			end

			local var_215_2 = arg_212_1.actors_["128404"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos128404 = var_215_2.localPosition
				var_215_2.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("128404", 3)

				for iter_215_4 = 0, var_215_2.childCount - 1 do
					local var_215_3 = var_215_2:GetChild(iter_215_4)

					if var_215_3.name == "split_1" or not string.find(var_215_3.name, "split") then
						var_215_3.gameObject:SetActive(true)
					else
						var_215_3.gameObject:SetActive(false)
					end
				end
			end

			local var_215_4 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				var_215_2.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_212_1.time_ - 0) / var_215_4)
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				var_215_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_215_5 = arg_212_1.actors_["10144"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10144 = var_215_5.localPosition
				var_215_5.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10144", 7)

				for iter_215_5 = 0, var_215_5.childCount - 1 do
					local var_215_6 = var_215_5:GetChild(iter_215_5)

					if var_215_6.name == "" or not string.find(var_215_6.name, "split") then
						var_215_6.gameObject:SetActive(true)
					else
						var_215_6.gameObject:SetActive(false)
					end
				end
			end

			local var_215_7 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_212_1.time_ - 0) / var_215_7)
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_215_8 = 0
			local var_215_9 = 0.45

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(926052049)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 18 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 18)

				if (18 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 18)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052049", "story_v_out_926052.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052049", "story_v_out_926052.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_926052", "926052049", "story_v_out_926052.awb")

						arg_212_1:RecordAudio("926052049", var_215_15)
						arg_212_1:RecordAudio("926052049", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_926052", "926052049", "story_v_out_926052.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_926052", "926052049", "story_v_out_926052.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
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
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["128404"]) and arg_216_1.var_.actorSpriteComps128404 == nil then
				arg_216_1.var_.actorSpriteComps128404 = arg_216_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["128404"]) then
				if arg_216_1.var_.actorSpriteComps128404 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["128404"]) and arg_216_1.var_.actorSpriteComps128404 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps128404 = nil
			end

			local var_219_2 = 0
			local var_219_3 = 0.625

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

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

				local var_219_4 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(926052050).content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 25 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 25)

				if (25 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 25)) > 0 and var_219_3 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_7 and arg_216_1.time_ < var_219_2 + var_219_7 + arg_219_0 then
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
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10144"]) and arg_220_1.var_.actorSpriteComps10144 == nil then
				arg_220_1.var_.actorSpriteComps10144 = arg_220_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10144"]) then
				if arg_220_1.var_.actorSpriteComps10144 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 1, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10144"]) and arg_220_1.var_.actorSpriteComps10144 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10144 = nil
			end

			local var_223_2 = arg_220_1.actors_["10144"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10144 = var_223_2.localPosition
				var_223_2.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10144", 3)

				for iter_223_4 = 0, var_223_2.childCount - 1 do
					local var_223_3 = var_223_2:GetChild(iter_223_4)

					if var_223_3.name == "" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				var_223_2.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_220_1.time_ - 0) / var_223_4)
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				var_223_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_223_5 = arg_220_1.actors_["128404"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos128404 = var_223_5.localPosition
				var_223_5.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("128404", 7)

				for iter_223_5 = 0, var_223_5.childCount - 1 do
					local var_223_6 = var_223_5:GetChild(iter_223_5)

					if var_223_6.name == "" or not string.find(var_223_6.name, "split") then
						var_223_6.gameObject:SetActive(true)
					else
						var_223_6.gameObject:SetActive(false)
					end
				end
			end

			local var_223_7 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				var_223_5.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_220_1.time_ - 0) / var_223_7)
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				var_223_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_8 = 0
			local var_223_9 = 0.4

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_10 = arg_220_1:GetWordFromCfg(926052051)
				local var_223_11 = arg_220_1:FormatText(var_223_10.content)

				arg_220_1.text_.text = var_223_11

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 16 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 16)

				if (16 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 16)) > 0 and var_223_9 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_11
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052051", "story_v_out_926052.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_out_926052", "926052051", "story_v_out_926052.awb") / 1000

					if var_223_14 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_8
					end

					if var_223_10.prefab_name ~= "" and arg_220_1.actors_[var_223_10.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_10.prefab_name].transform, "story_v_out_926052", "926052051", "story_v_out_926052.awb")

						arg_220_1:RecordAudio("926052051", var_223_15)
						arg_220_1:RecordAudio("926052051", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_926052", "926052051", "story_v_out_926052.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_926052", "926052051", "story_v_out_926052.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_16 and arg_220_1.time_ < var_223_8 + var_223_16 + arg_223_0 then
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
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10144"]) and arg_224_1.var_.actorSpriteComps10144 == nil then
				arg_224_1.var_.actorSpriteComps10144 = arg_224_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10144"]) then
				if arg_224_1.var_.actorSpriteComps10144 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10144"]) and arg_224_1.var_.actorSpriteComps10144 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10144 = nil
			end

			local var_227_2 = 0
			local var_227_3 = 0.375

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
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

				local var_227_4 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(926052052).content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_6 = 15 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_4) / 15)

				if (15 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_4) / 15)) > 0 and var_227_3 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_2
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_3, arg_224_1.talkMaxDuration)

			if var_227_2 <= arg_224_1.time_ and arg_224_1.time_ < var_227_2 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_2) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_2 + var_227_7 and arg_224_1.time_ < var_227_2 + var_227_7 + arg_227_0 then
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
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10144"]) and arg_228_1.var_.actorSpriteComps10144 == nil then
				arg_228_1.var_.actorSpriteComps10144 = arg_228_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10144"]) then
				if arg_228_1.var_.actorSpriteComps10144 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 1, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10144"]) and arg_228_1.var_.actorSpriteComps10144 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps10144 = nil
			end

			local var_231_2 = 0
			local var_231_3 = 0.625

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_4 = arg_228_1:GetWordFromCfg(926052053)
				local var_231_5 = arg_228_1:FormatText(var_231_4.content)

				arg_228_1.text_.text = var_231_5

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_7 = 25 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 25)

				if (25 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_5) / 25)) > 0 and var_231_3 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_5
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052053", "story_v_out_926052.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052053", "story_v_out_926052.awb") / 1000

					if var_231_8 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_2
					end

					if var_231_4.prefab_name ~= "" and arg_228_1.actors_[var_231_4.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_4.prefab_name].transform, "story_v_out_926052", "926052053", "story_v_out_926052.awb")

						arg_228_1:RecordAudio("926052053", var_231_9)
						arg_228_1:RecordAudio("926052053", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_926052", "926052053", "story_v_out_926052.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_926052", "926052053", "story_v_out_926052.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_10 and arg_228_1.time_ < var_231_2 + var_231_10 + arg_231_0 then
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
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10144 = arg_232_1.actors_["10144"].transform.localPosition
				arg_232_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10144", 3)

				for iter_235_0 = 0, arg_232_1.actors_["10144"].transform.childCount - 1 do
					local var_235_0 = arg_232_1.actors_["10144"].transform:GetChild(iter_235_0)

					if var_235_0.name == "split_7" or not string.find(var_235_0.name, "split") then
						var_235_0.gameObject:SetActive(true)
					else
						var_235_0.gameObject:SetActive(false)
					end
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_232_1.time_ - 0) / var_235_1)
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_235_2 = 0
			local var_235_3 = 0.4

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_2 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_4 = arg_232_1:GetWordFromCfg(926052054)
				local var_235_5 = arg_232_1:FormatText(var_235_4.content)

				arg_232_1.text_.text = var_235_5

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_7 = 16 <= 0 and var_235_3 or var_235_3 * (utf8.len(var_235_5) / 16)

				if (16 <= 0 and var_235_3 or var_235_3 * (utf8.len(var_235_5) / 16)) > 0 and var_235_3 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_2 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_2
					end
				end

				arg_232_1.text_.text = var_235_5
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926052", "926052054", "story_v_out_926052.awb") ~= 0 then
					local var_235_8 = manager.audio:GetVoiceLength("story_v_out_926052", "926052054", "story_v_out_926052.awb") / 1000

					if var_235_8 + var_235_2 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_2
					end

					if var_235_4.prefab_name ~= "" and arg_232_1.actors_[var_235_4.prefab_name] ~= nil then
						local var_235_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_4.prefab_name].transform, "story_v_out_926052", "926052054", "story_v_out_926052.awb")

						arg_232_1:RecordAudio("926052054", var_235_9)
						arg_232_1:RecordAudio("926052054", var_235_9)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_926052", "926052054", "story_v_out_926052.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_926052", "926052054", "story_v_out_926052.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_3, arg_232_1.talkMaxDuration)

			if var_235_2 <= arg_232_1.time_ and arg_232_1.time_ < var_235_2 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_2) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_2 + var_235_10 and arg_232_1.time_ < var_235_2 + var_235_10 + arg_235_0 then
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
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["10144"]) and arg_236_1.var_.actorSpriteComps10144 == nil then
				arg_236_1.var_.actorSpriteComps10144 = arg_236_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["10144"]) then
				if arg_236_1.var_.actorSpriteComps10144 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								iter_239_1.color = Color.New(Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_0), Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_0), (Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_0)))
							else
								local var_239_1 = Mathf.Lerp(iter_239_1.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_0)

								iter_239_1.color = Color.New(var_239_1, var_239_1, var_239_1)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["10144"]) and arg_236_1.var_.actorSpriteComps10144 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_239_3 then
						iter_239_3.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10144 = nil
			end

			local var_239_2 = 0
			local var_239_3 = 0.45

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

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

				local var_239_4 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(926052055).content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_6 = 18 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 18)

				if (18 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_4) / 18)) > 0 and var_239_3 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_7 and arg_236_1.time_ < var_239_2 + var_239_7 + arg_239_0 then
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
			local var_243_0 = 0.6

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

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(926052056).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 24 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 24)

				if (24 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 24)) > 0 and var_243_0 < var_243_3 then
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
	assets = {
		"TextureConfig/Background/I21f",
		"TextureConfig/Background/I21g"
	},
	voices = {
		"story_v_out_926052.awb"
	}
}
