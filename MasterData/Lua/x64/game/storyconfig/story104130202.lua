return {
	Play413022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

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

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.4

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413022001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 16 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 16)

				if (16 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 16)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413022002
		arg_9_1.duration_ = 4.7

		local var_9_0 = {
			zh = 4.699999999999,
			ja = 4.532999999999
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
				arg_9_0:Play413022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.bgs_.F08h == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08h")
				var_12_0.name = "F08h"
				var_12_0.transform.parent = arg_9_1.stage_.transform
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_.F08h = var_12_0
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_1 = arg_9_1.bgs_.F08h

				arg_9_1.bgs_.F08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_2 = var_12_1:GetComponent("SpriteRenderer")

				if var_12_2 and var_12_2.sprite then
					local var_12_3 = 2 * (var_12_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_1.transform.localScale = Vector3.New(var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "F08h" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_4 = 1.999999999999

			if 1.999999999999 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_4 + 0.3 and arg_9_1.time_ < var_12_4 + 0.3 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_5 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_6 = 2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 then
				local var_12_7 = Color.New(0, 0, 0)

				var_12_7.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_5) / var_12_6)
				arg_9_1.mask_.color = var_12_7
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 then
				local var_12_8 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_8.a = 0
				arg_9_1.mask_.color = var_12_8
			end

			local var_12_9 = "10092"

			if arg_9_1.actors_["10092"] == nil then
				local var_12_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_12_10) then
					local var_12_11 = Object.Instantiate(var_12_10, arg_9_1.canvasGo_.transform)

					var_12_11.transform:SetSiblingIndex(1)

					var_12_11.name = var_12_9
					var_12_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_9] = var_12_11

					if arg_9_1.isInRecall_ then
						for iter_12_2, iter_12_3 in ipairs((var_12_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_3.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_12 = arg_9_1.actors_["10092"].transform

			if 2 < arg_9_1.time_ and arg_9_1.time_ <= 2 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092", 2)

				for iter_12_4 = 0, var_12_12.childCount - 1 do
					local var_12_13 = var_12_12:GetChild(iter_12_4)

					if var_12_13.name == "split_6" or not string.find(var_12_13.name, "split") then
						var_12_13.gameObject:SetActive(true)
					else
						var_12_13.gameObject:SetActive(false)
					end
				end
			end

			local var_12_14 = 0.001

			if 2 <= arg_9_1.time_ and arg_9_1.time_ < 2 + var_12_14 then
				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_9_1.time_ - 2) / var_12_14)
			end

			if arg_9_1.time_ >= 2 + var_12_14 and arg_9_1.time_ < 2 + var_12_14 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_12_15 = arg_9_1.actors_["10092"]

			if 1.999999999999 < arg_9_1.time_ and arg_9_1.time_ <= 1.999999999999 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps10092 == nil then
				arg_9_1.var_.actorSpriteComps10092 = var_12_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_16 = 2

			if 1.999999999999 <= arg_9_1.time_ and arg_9_1.time_ < 1.999999999999 + var_12_16 and not isNil(var_12_15) then
				if arg_9_1.var_.actorSpriteComps10092 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_12_6 then
							if arg_9_1.isInRecall_ then
								iter_12_6.color = Color.New(Mathf.Lerp(iter_12_6.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 1.999999999999) / var_12_16), Mathf.Lerp(iter_12_6.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 1.999999999999) / var_12_16), (Mathf.Lerp(iter_12_6.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 1.999999999999) / var_12_16)))
							else
								local var_12_17 = Mathf.Lerp(iter_12_6.color.r, 1, (arg_9_1.time_ - 1.999999999999) / var_12_16)

								iter_12_6.color = Color.New(var_12_17, var_12_17, var_12_17)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 1.999999999999 + var_12_16 and arg_9_1.time_ < 1.999999999999 + var_12_16 + arg_12_0 and not isNil(var_12_15) and arg_9_1.var_.actorSpriteComps10092 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_12_8 then
						iter_12_8.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10092 = nil
			end

			if 1.999999999999 < arg_9_1.time_ and arg_9_1.time_ <= 1.999999999999 + arg_12_0 then
				local var_12_18 = arg_9_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_18 then
					arg_9_1.var_.alphaOldValue10092 = var_12_18.alpha
					arg_9_1.var_.characterEffect10092 = var_12_18
				end

				arg_9_1.var_.alphaOldValue10092 = 0
			end

			local var_12_19 = 0.2

			if 1.999999999999 <= arg_9_1.time_ and arg_9_1.time_ < 1.999999999999 + var_12_19 then
				if arg_9_1.var_.characterEffect10092 then
					arg_9_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10092, 1, (arg_9_1.time_ - 1.999999999999) / var_12_19)
				end
			end

			if arg_9_1.time_ >= 1.999999999999 + var_12_19 and arg_9_1.time_ < 1.999999999999 + var_12_19 + arg_12_0 and arg_9_1.var_.characterEffect10092 then
				arg_9_1.var_.characterEffect10092.alpha = 1
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_20 = 1.999999999999
			local var_12_21 = 0.2

			if 1.999999999999 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_22 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_22:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(413022002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 8 <= 0 and var_12_21 or var_12_21 * (utf8.len(var_12_24) / 8)

				if (8 <= 0 and var_12_21 or var_12_21 * (utf8.len(var_12_24) / 8)) > 0 and var_12_21 < var_12_26 then
					arg_9_1.talkMaxDuration = var_12_26
					var_12_20 = var_12_20 + 0.3

					if var_12_26 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022002", "story_v_out_413022.awb") ~= 0 then
					local var_12_27 = manager.audio:GetVoiceLength("story_v_out_413022", "413022002", "story_v_out_413022.awb") / 1000

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_413022", "413022002", "story_v_out_413022.awb")

						arg_9_1:RecordAudio("413022002", var_12_28)
						arg_9_1:RecordAudio("413022002", var_12_28)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413022", "413022002", "story_v_out_413022.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413022", "413022002", "story_v_out_413022.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = var_12_20 + 0.3
			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_29 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_29) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_29 + var_12_30 and arg_9_1.time_ < var_12_29 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play413022003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 413022003
		arg_15_1.duration_ = 3

		local var_15_0 = {
			zh = 2.566,
			ja = 3
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
				arg_15_0:Play413022004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10092 = arg_15_1.actors_["10092"].transform.localPosition
				arg_15_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10092", 2)

				for iter_18_0 = 0, arg_15_1.actors_["10092"].transform.childCount - 1 do
					local var_18_0 = arg_15_1.actors_["10092"].transform:GetChild(iter_18_0)

					if var_18_0.name == "" or not string.find(var_18_0.name, "split") then
						var_18_0.gameObject:SetActive(true)
					else
						var_18_0.gameObject:SetActive(false)
					end
				end
			end

			local var_18_1 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 then
				arg_15_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_15_1.time_ - 0) / var_18_1)
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 then
				arg_15_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_18_2 = "10022"

			if arg_15_1.actors_["10022"] == nil then
				local var_18_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_18_3) then
					local var_18_4 = Object.Instantiate(var_18_3, arg_15_1.canvasGo_.transform)

					var_18_4.transform:SetSiblingIndex(1)

					var_18_4.name = var_18_2
					var_18_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_[var_18_2] = var_18_4

					if arg_15_1.isInRecall_ then
						for iter_18_1, iter_18_2 in ipairs((var_18_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_18_2.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_5 = arg_15_1.actors_["10022"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10022 = var_18_5.localPosition
				var_18_5.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10022", 4)

				for iter_18_3 = 0, var_18_5.childCount - 1 do
					local var_18_6 = var_18_5:GetChild(iter_18_3)

					if var_18_6.name == "split_6" or not string.find(var_18_6.name, "split") then
						var_18_6.gameObject:SetActive(true)
					else
						var_18_6.gameObject:SetActive(false)
					end
				end
			end

			local var_18_7 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_15_1.time_ - 0) / var_18_7)
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(390, -315, -320)
			end

			local var_18_8 = arg_15_1.actors_["10092"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_8) and arg_15_1.var_.actorSpriteComps10092 == nil then
				arg_15_1.var_.actorSpriteComps10092 = var_18_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_9 = 2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 and not isNil(var_18_8) then
				if arg_15_1.var_.actorSpriteComps10092 then
					for iter_18_4, iter_18_5 in pairs(arg_15_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_18_5 then
							if arg_15_1.isInRecall_ then
								iter_18_5.color = Color.New(Mathf.Lerp(iter_18_5.color.r, arg_15_1.hightColor2.r, (arg_15_1.time_ - 0) / var_18_9), Mathf.Lerp(iter_18_5.color.g, arg_15_1.hightColor2.g, (arg_15_1.time_ - 0) / var_18_9), (Mathf.Lerp(iter_18_5.color.b, arg_15_1.hightColor2.b, (arg_15_1.time_ - 0) / var_18_9)))
							else
								local var_18_10 = Mathf.Lerp(iter_18_5.color.r, 0.5, (arg_15_1.time_ - 0) / var_18_9)

								iter_18_5.color = Color.New(var_18_10, var_18_10, var_18_10)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 and not isNil(var_18_8) and arg_15_1.var_.actorSpriteComps10092 then
				for iter_18_6, iter_18_7 in pairs(arg_15_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_18_7 then
						iter_18_7.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_15_1.var_.actorSpriteComps10092 = nil
			end

			local var_18_11 = arg_15_1.actors_["10022"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps10022 == nil then
				arg_15_1.var_.actorSpriteComps10022 = var_18_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_12 = 2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_12 and not isNil(var_18_11) then
				if arg_15_1.var_.actorSpriteComps10022 then
					for iter_18_8, iter_18_9 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_18_9 then
							if arg_15_1.isInRecall_ then
								iter_18_9.color = Color.New(Mathf.Lerp(iter_18_9.color.r, arg_15_1.hightColor1.r, (arg_15_1.time_ - 0) / var_18_12), Mathf.Lerp(iter_18_9.color.g, arg_15_1.hightColor1.g, (arg_15_1.time_ - 0) / var_18_12), (Mathf.Lerp(iter_18_9.color.b, arg_15_1.hightColor1.b, (arg_15_1.time_ - 0) / var_18_12)))
							else
								local var_18_13 = Mathf.Lerp(iter_18_9.color.r, 1, (arg_15_1.time_ - 0) / var_18_12)

								iter_18_9.color = Color.New(var_18_13, var_18_13, var_18_13)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_12 and arg_15_1.time_ < 0 + var_18_12 + arg_18_0 and not isNil(var_18_11) and arg_15_1.var_.actorSpriteComps10022 then
				for iter_18_10, iter_18_11 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_18_11 then
						iter_18_11.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_14 = arg_15_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_14 then
					arg_15_1.var_.alphaOldValue10022 = var_18_14.alpha
					arg_15_1.var_.characterEffect10022 = var_18_14
				end

				arg_15_1.var_.alphaOldValue10022 = 0
			end

			local var_18_15 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_15 then
				if arg_15_1.var_.characterEffect10022 then
					arg_15_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_15_1.var_.alphaOldValue10022, 1, (arg_15_1.time_ - 0) / var_18_15)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_15 and arg_15_1.time_ < 0 + var_18_15 + arg_18_0 and arg_15_1.var_.characterEffect10022 then
				arg_15_1.var_.characterEffect10022.alpha = 1
			end

			local var_18_16 = 0
			local var_18_17 = 0.3

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_16 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_18 = arg_15_1:GetWordFromCfg(413022003)
				local var_18_19 = arg_15_1:FormatText(var_18_18.content)

				arg_15_1.text_.text = var_18_19

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_21 = 12 <= 0 and var_18_17 or var_18_17 * (utf8.len(var_18_19) / 12)

				if (12 <= 0 and var_18_17 or var_18_17 * (utf8.len(var_18_19) / 12)) > 0 and var_18_17 < var_18_21 then
					arg_15_1.talkMaxDuration = var_18_21

					if var_18_21 + var_18_16 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_21 + var_18_16
					end
				end

				arg_15_1.text_.text = var_18_19
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022003", "story_v_out_413022.awb") ~= 0 then
					local var_18_22 = manager.audio:GetVoiceLength("story_v_out_413022", "413022003", "story_v_out_413022.awb") / 1000

					if var_18_22 + var_18_16 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_22 + var_18_16
					end

					if var_18_18.prefab_name ~= "" and arg_15_1.actors_[var_18_18.prefab_name] ~= nil then
						local var_18_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_18.prefab_name].transform, "story_v_out_413022", "413022003", "story_v_out_413022.awb")

						arg_15_1:RecordAudio("413022003", var_18_23)
						arg_15_1:RecordAudio("413022003", var_18_23)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_413022", "413022003", "story_v_out_413022.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_413022", "413022003", "story_v_out_413022.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_24 = math.max(var_18_17, arg_15_1.talkMaxDuration)

			if var_18_16 <= arg_15_1.time_ and arg_15_1.time_ < var_18_16 + var_18_24 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_16) / var_18_24

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_16 + var_18_24 and arg_15_1.time_ < var_18_16 + var_18_24 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play413022004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413022004
		arg_19_1.duration_ = 10.03

		local var_19_0 = {
			zh = 4.166,
			ja = 10.033
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play413022005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["10092"]) and arg_19_1.var_.actorSpriteComps10092 == nil then
				arg_19_1.var_.actorSpriteComps10092 = arg_19_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_0 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["10092"]) then
				if arg_19_1.var_.actorSpriteComps10092 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								iter_22_1.color = Color.New(Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_0), Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_0), (Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_0)))
							else
								local var_22_1 = Mathf.Lerp(iter_22_1.color.r, 1, (arg_19_1.time_ - 0) / var_22_0)

								iter_22_1.color = Color.New(var_22_1, var_22_1, var_22_1)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["10092"]) and arg_19_1.var_.actorSpriteComps10092 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps10092 = nil
			end

			local var_22_2 = arg_19_1.actors_["10022"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps10022 == nil then
				arg_19_1.var_.actorSpriteComps10022 = var_22_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_3 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 and not isNil(var_22_2) then
				if arg_19_1.var_.actorSpriteComps10022 then
					for iter_22_4, iter_22_5 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_22_5 then
							if arg_19_1.isInRecall_ then
								iter_22_5.color = Color.New(Mathf.Lerp(iter_22_5.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_3), Mathf.Lerp(iter_22_5.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_3), (Mathf.Lerp(iter_22_5.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_3)))
							else
								local var_22_4 = Mathf.Lerp(iter_22_5.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_3)

								iter_22_5.color = Color.New(var_22_4, var_22_4, var_22_4)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps10022 then
				for iter_22_6, iter_22_7 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_22_7 then
						iter_22_7.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps10022 = nil
			end

			local var_22_5 = 0
			local var_22_6 = 0.525

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_7 = arg_19_1:GetWordFromCfg(413022004)
				local var_22_8 = arg_19_1:FormatText(var_22_7.content)

				arg_19_1.text_.text = var_22_8

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_10 = 21 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_8) / 21)

				if (21 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_8) / 21)) > 0 and var_22_6 < var_22_10 then
					arg_19_1.talkMaxDuration = var_22_10

					if var_22_10 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_5
					end
				end

				arg_19_1.text_.text = var_22_8
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022004", "story_v_out_413022.awb") ~= 0 then
					local var_22_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022004", "story_v_out_413022.awb") / 1000

					if var_22_11 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_11 + var_22_5
					end

					if var_22_7.prefab_name ~= "" and arg_19_1.actors_[var_22_7.prefab_name] ~= nil then
						local var_22_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_7.prefab_name].transform, "story_v_out_413022", "413022004", "story_v_out_413022.awb")

						arg_19_1:RecordAudio("413022004", var_22_12)
						arg_19_1:RecordAudio("413022004", var_22_12)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413022", "413022004", "story_v_out_413022.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413022", "413022004", "story_v_out_413022.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_13 = math.max(var_22_6, arg_19_1.talkMaxDuration)

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_13 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_5) / var_22_13

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_5 + var_22_13 and arg_19_1.time_ < var_22_5 + var_22_13 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play413022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413022005
		arg_23_1.duration_ = 6.17

		local var_23_0 = {
			zh = 3.866,
			ja = 6.166
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["10092"]) and arg_23_1.var_.actorSpriteComps10092 == nil then
				arg_23_1.var_.actorSpriteComps10092 = arg_23_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["10092"]) then
				if arg_23_1.var_.actorSpriteComps10092 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								iter_26_1.color = Color.New(Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_0), Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_0), (Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_0)))
							else
								local var_26_1 = Mathf.Lerp(iter_26_1.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_0)

								iter_26_1.color = Color.New(var_26_1, var_26_1, var_26_1)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["10092"]) and arg_23_1.var_.actorSpriteComps10092 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps10092 = nil
			end

			local var_26_2 = arg_23_1.actors_["10022"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps10022 == nil then
				arg_23_1.var_.actorSpriteComps10022 = var_26_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_3 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.actorSpriteComps10022 then
					for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_26_5 then
							if arg_23_1.isInRecall_ then
								iter_26_5.color = Color.New(Mathf.Lerp(iter_26_5.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 0) / var_26_3), Mathf.Lerp(iter_26_5.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 0) / var_26_3), (Mathf.Lerp(iter_26_5.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 0) / var_26_3)))
							else
								local var_26_4 = Mathf.Lerp(iter_26_5.color.r, 1, (arg_23_1.time_ - 0) / var_26_3)

								iter_26_5.color = Color.New(var_26_4, var_26_4, var_26_4)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps10022 then
				for iter_26_6, iter_26_7 in pairs(arg_23_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_26_7 then
						iter_26_7.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps10022 = nil
			end

			local var_26_5 = 0
			local var_26_6 = 0.6

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_7 = arg_23_1:GetWordFromCfg(413022005)
				local var_26_8 = arg_23_1:FormatText(var_26_7.content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 24 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 24)

				if (24 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 24)) > 0 and var_26_6 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_5
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022005", "story_v_out_413022.awb") ~= 0 then
					local var_26_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022005", "story_v_out_413022.awb") / 1000

					if var_26_11 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_11 + var_26_5
					end

					if var_26_7.prefab_name ~= "" and arg_23_1.actors_[var_26_7.prefab_name] ~= nil then
						local var_26_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_7.prefab_name].transform, "story_v_out_413022", "413022005", "story_v_out_413022.awb")

						arg_23_1:RecordAudio("413022005", var_26_12)
						arg_23_1:RecordAudio("413022005", var_26_12)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413022", "413022005", "story_v_out_413022.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413022", "413022005", "story_v_out_413022.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_13 = math.max(var_26_6, arg_23_1.talkMaxDuration)

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_13 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_5) / var_26_13

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_5 + var_26_13 and arg_23_1.time_ < var_26_5 + var_26_13 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413022006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413022006
		arg_27_1.duration_ = 5.57

		local var_27_0 = {
			zh = 5.566,
			ja = 4.766
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
				arg_27_0:Play413022007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.8

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:GetWordFromCfg(413022006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 32 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 32)

				if (32 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 32)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022006", "story_v_out_413022.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022006", "story_v_out_413022.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_413022", "413022006", "story_v_out_413022.awb")

						arg_27_1:RecordAudio("413022006", var_30_6)
						arg_27_1:RecordAudio("413022006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413022", "413022006", "story_v_out_413022.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413022", "413022006", "story_v_out_413022.awb")
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
	Play413022007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413022007
		arg_31_1.duration_ = 8.93

		local var_31_0 = {
			zh = 5,
			ja = 8.933
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play413022008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["10022"]) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = arg_31_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_0 = 2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["10022"]) then
				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								iter_34_1.color = Color.New(Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_0), Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_0), (Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_0)))
							else
								local var_34_1 = Mathf.Lerp(iter_34_1.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_0)

								iter_34_1.color = Color.New(var_34_1, var_34_1, var_34_1)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["10022"]) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_2 = 0
			local var_34_3 = 0.575

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_1")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_4 = arg_31_1:GetWordFromCfg(413022007)
				local var_34_5 = arg_31_1:FormatText(var_34_4.content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 23 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 23)

				if (23 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 23)) > 0 and var_34_3 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022007", "story_v_out_413022.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022007", "story_v_out_413022.awb") / 1000

					if var_34_8 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_2
					end

					if var_34_4.prefab_name ~= "" and arg_31_1.actors_[var_34_4.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_4.prefab_name].transform, "story_v_out_413022", "413022007", "story_v_out_413022.awb")

						arg_31_1:RecordAudio("413022007", var_34_9)
						arg_31_1:RecordAudio("413022007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413022", "413022007", "story_v_out_413022.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413022", "413022007", "story_v_out_413022.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_10 and arg_31_1.time_ < var_34_2 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play413022008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413022008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413022009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10022 = arg_35_1.actors_["10022"].transform.localPosition
				arg_35_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10022", 7)

				for iter_38_0 = 0, arg_35_1.actors_["10022"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["10022"].transform:GetChild(iter_38_0)

					if var_38_0.name == "" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10022, Vector3.New(0, -2000, -180), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_38_2 = arg_35_1.actors_["10022"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10022 == nil then
				arg_35_1.var_.actorSpriteComps10022 = var_38_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_3 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.actorSpriteComps10022 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_38_2 then
							if arg_35_1.isInRecall_ then
								iter_38_2.color = Color.New(Mathf.Lerp(iter_38_2.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_3), Mathf.Lerp(iter_38_2.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_3), (Mathf.Lerp(iter_38_2.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_3)))
							else
								local var_38_4 = Mathf.Lerp(iter_38_2.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_3)

								iter_38_2.color = Color.New(var_38_4, var_38_4, var_38_4)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps10022 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_38_4 then
						iter_38_4.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps10022 = nil
			end

			local var_38_5 = arg_35_1.actors_["10092"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = var_38_5.localPosition
				var_38_5.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 7)

				for iter_38_5 = 0, var_38_5.childCount - 1 do
					local var_38_6 = var_38_5:GetChild(iter_38_5)

					if var_38_6.name == "" or not string.find(var_38_6.name, "split") then
						var_38_6.gameObject:SetActive(true)
					else
						var_38_6.gameObject:SetActive(false)
					end
				end
			end

			local var_38_7 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_35_1.time_ - 0) / var_38_7)
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_8 = arg_35_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_8 then
					arg_35_1.var_.alphaOldValue10092 = var_38_8.alpha
					arg_35_1.var_.characterEffect10092 = var_38_8
				end

				arg_35_1.var_.alphaOldValue10092 = 1
			end

			local var_38_9 = 0.5

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_9 then
				if arg_35_1.var_.characterEffect10092 then
					arg_35_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_35_1.var_.alphaOldValue10092, 0, (arg_35_1.time_ - 0) / var_38_9)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_9 and arg_35_1.time_ < 0 + var_38_9 + arg_38_0 and arg_35_1.var_.characterEffect10092 then
				arg_35_1.var_.characterEffect10092.alpha = 0
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_10 = arg_35_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_10 then
					arg_35_1.var_.alphaOldValue10022 = var_38_10.alpha
					arg_35_1.var_.characterEffect10022 = var_38_10
				end

				arg_35_1.var_.alphaOldValue10022 = 1
			end

			local var_38_11 = 0.5

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_11 then
				if arg_35_1.var_.characterEffect10022 then
					arg_35_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_35_1.var_.alphaOldValue10022, 0, (arg_35_1.time_ - 0) / var_38_11)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_11 and arg_35_1.time_ < 0 + var_38_11 + arg_38_0 and arg_35_1.var_.characterEffect10022 then
				arg_35_1.var_.characterEffect10022.alpha = 0
			end

			local var_38_12 = 0
			local var_38_13 = 1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(413022008).content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 40 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 40)

				if (40 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 40)) > 0 and var_38_13 < var_38_16 then
					arg_35_1.talkMaxDuration = var_38_16

					if var_38_16 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_16 + var_38_12
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_17 = math.max(var_38_13, arg_35_1.talkMaxDuration)

			if var_38_12 <= arg_35_1.time_ and arg_35_1.time_ < var_38_12 + var_38_17 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_12) / var_38_17

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_12 + var_38_17 and arg_35_1.time_ < var_38_12 + var_38_17 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play413022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413022009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.15

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(413022009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 46 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 46)

				if (46 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 46)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413022010
		arg_43_1.duration_ = 8.43

		local var_43_0 = {
			zh = 6.99933333333333,
			ja = 8.43333333333333
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
				arg_43_0:Play413022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["10097"] == nil then
				local var_46_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_46_0) then
					local var_46_1 = Object.Instantiate(var_46_0, arg_43_1.canvasGo_.transform)

					var_46_1.transform:SetSiblingIndex(1)

					var_46_1.name = "10097"
					var_46_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_["10097"] = var_46_1

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs((var_46_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_2 = arg_43_1.actors_["10097"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10097 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10097", 3)

				for iter_46_2 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_2)

					if var_46_3.name == "split_2" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_46_5 = arg_43_1.actors_["10097"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10097 == nil then
				arg_43_1.var_.actorSpriteComps10097 = var_46_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_6 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.actorSpriteComps10097 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								iter_46_4.color = Color.New(Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_6), Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_6), (Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_6)))
							else
								local var_46_7 = Mathf.Lerp(iter_46_4.color.r, 1, (arg_43_1.time_ - 0) / var_46_6)

								iter_46_4.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.actorSpriteComps10097 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_46_6 then
						iter_46_6.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_8 = arg_43_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_46_8 then
					arg_43_1.var_.alphaOldValue10097 = var_46_8.alpha
					arg_43_1.var_.characterEffect10097 = var_46_8
				end

				arg_43_1.var_.alphaOldValue10097 = 0
			end

			local var_46_9 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_9 then
				if arg_43_1.var_.characterEffect10097 then
					arg_43_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_43_1.var_.alphaOldValue10097, 1, (arg_43_1.time_ - 0) / var_46_9)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_9 and arg_43_1.time_ < 0 + var_46_9 + arg_46_0 and arg_43_1.var_.characterEffect10097 then
				arg_43_1.var_.characterEffect10097.alpha = 1
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_10 = 0.433333333333333
			local var_46_11 = 0.725

			if 0.433333333333333 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_12 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_12:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_13 = arg_43_1:GetWordFromCfg(413022010)
				local var_46_14 = arg_43_1:FormatText(var_46_13.content)

				arg_43_1.text_.text = var_46_14

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_16 = 29 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_14) / 29)

				if (29 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_14) / 29)) > 0 and var_46_11 < var_46_16 then
					arg_43_1.talkMaxDuration = var_46_16
					var_46_10 = var_46_10 + 0.3

					if var_46_16 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_14
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022010", "story_v_out_413022.awb") ~= 0 then
					local var_46_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022010", "story_v_out_413022.awb") / 1000

					if var_46_17 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_10
					end

					if var_46_13.prefab_name ~= "" and arg_43_1.actors_[var_46_13.prefab_name] ~= nil then
						local var_46_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_13.prefab_name].transform, "story_v_out_413022", "413022010", "story_v_out_413022.awb")

						arg_43_1:RecordAudio("413022010", var_46_18)
						arg_43_1:RecordAudio("413022010", var_46_18)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413022", "413022010", "story_v_out_413022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413022", "413022010", "story_v_out_413022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_19 = var_46_10 + 0.3
			local var_46_20 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_19 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_19) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_19 + var_46_20 and arg_43_1.time_ < var_46_19 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play413022011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413022011
		arg_49_1.duration_ = 5.8

		local var_49_0 = {
			zh = 3.933,
			ja = 5.8
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
				arg_49_0:Play413022012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(413022011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 18 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 18)

				if (18 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 18)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022011", "story_v_out_413022.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022011", "story_v_out_413022.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_413022", "413022011", "story_v_out_413022.awb")

						arg_49_1:RecordAudio("413022011", var_52_6)
						arg_49_1:RecordAudio("413022011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413022", "413022011", "story_v_out_413022.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413022", "413022011", "story_v_out_413022.awb")
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
	Play413022012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413022012
		arg_53_1.duration_ = 2.6

		local var_53_0 = {
			zh = 2.6,
			ja = 1.999999999999
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
				arg_53_0:Play413022013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10097"]) and arg_53_1.var_.actorSpriteComps10097 == nil then
				arg_53_1.var_.actorSpriteComps10097 = arg_53_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10097"]) then
				if arg_53_1.var_.actorSpriteComps10097 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10097"]) and arg_53_1.var_.actorSpriteComps10097 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10097 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(413022012)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 9 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 9)

				if (9 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 9)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022012", "story_v_out_413022.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022012", "story_v_out_413022.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_413022", "413022012", "story_v_out_413022.awb")

						arg_53_1:RecordAudio("413022012", var_56_9)
						arg_53_1:RecordAudio("413022012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413022", "413022012", "story_v_out_413022.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413022", "413022012", "story_v_out_413022.awb")
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
	Play413022013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413022013
		arg_57_1.duration_ = 6.3

		local var_57_0 = {
			zh = 4.8,
			ja = 6.3
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
				arg_57_0:Play413022014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.525

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(413022013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 21 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 21)

				if (21 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 21)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022013", "story_v_out_413022.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022013", "story_v_out_413022.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_413022", "413022013", "story_v_out_413022.awb")

						arg_57_1:RecordAudio("413022013", var_60_6)
						arg_57_1:RecordAudio("413022013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413022", "413022013", "story_v_out_413022.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413022", "413022013", "story_v_out_413022.awb")
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
	Play413022014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413022014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play413022015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.925

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(413022014).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 37 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 37)

				if (37 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 37)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413022015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413022015
		arg_65_1.duration_ = 2.2

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_65_0:Play413022016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["10094"] == nil then
				local var_68_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_68_0) then
					local var_68_1 = Object.Instantiate(var_68_0, arg_65_1.canvasGo_.transform)

					var_68_1.transform:SetSiblingIndex(1)

					var_68_1.name = "10094"
					var_68_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_65_1.actors_["10094"] = var_68_1

					if arg_65_1.isInRecall_ then
						for iter_68_0, iter_68_1 in ipairs((var_68_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_68_1.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_68_2 = arg_65_1.actors_["10094"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10094 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10094", 2)

				for iter_68_2 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_2)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_68_5 = arg_65_1.actors_["10094"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10094 == nil then
				arg_65_1.var_.actorSpriteComps10094 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps10094 then
					for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_68_4 then
							if arg_65_1.isInRecall_ then
								iter_68_4.color = Color.New(Mathf.Lerp(iter_68_4.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_4.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_4.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_4.color.r, 1, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_4.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10094 then
				for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_68_6 then
						iter_68_6.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10094 = nil
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				local var_68_8 = arg_65_1.actors_["10094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_68_8 then
					arg_65_1.var_.alphaOldValue10094 = var_68_8.alpha
					arg_65_1.var_.characterEffect10094 = var_68_8
				end

				arg_65_1.var_.alphaOldValue10094 = 0
			end

			local var_68_9 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 then
				if arg_65_1.var_.characterEffect10094 then
					arg_65_1.var_.characterEffect10094.alpha = Mathf.Lerp(arg_65_1.var_.alphaOldValue10094, 1, (arg_65_1.time_ - 0) / var_68_9)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 and arg_65_1.var_.characterEffect10094 then
				arg_65_1.var_.characterEffect10094.alpha = 1
			end

			local var_68_10 = arg_65_1.actors_["10097"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10097 = var_68_10.localPosition
				var_68_10.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10097", 4)

				for iter_68_7 = 0, var_68_10.childCount - 1 do
					local var_68_11 = var_68_10:GetChild(iter_68_7)

					if var_68_11.name == "split_2" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_12 then
				var_68_10.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_65_1.time_ - 0) / var_68_12)
			end

			if arg_65_1.time_ >= 0 + var_68_12 and arg_65_1.time_ < 0 + var_68_12 + arg_68_0 then
				var_68_10.localPosition = Vector3.New(390, -350, -180)
			end

			local var_68_13 = 0
			local var_68_14 = 0.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(413022015)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 6 <= 0 and var_68_14 or var_68_14 * (utf8.len(var_68_16) / 6)

				if (6 <= 0 and var_68_14 or var_68_14 * (utf8.len(var_68_16) / 6)) > 0 and var_68_14 < var_68_18 then
					arg_65_1.talkMaxDuration = var_68_18

					if var_68_18 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_13
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022015", "story_v_out_413022.awb") ~= 0 then
					local var_68_19 = manager.audio:GetVoiceLength("story_v_out_413022", "413022015", "story_v_out_413022.awb") / 1000

					if var_68_19 + var_68_13 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_13
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_413022", "413022015", "story_v_out_413022.awb")

						arg_65_1:RecordAudio("413022015", var_68_20)
						arg_65_1:RecordAudio("413022015", var_68_20)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413022", "413022015", "story_v_out_413022.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413022", "413022015", "story_v_out_413022.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_14, arg_65_1.talkMaxDuration)

			if var_68_13 <= arg_65_1.time_ and arg_65_1.time_ < var_68_13 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_13) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_13 + var_68_21 and arg_65_1.time_ < var_68_13 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413022016
		arg_69_1.duration_ = 9.93

		local var_69_0 = {
			zh = 7.8,
			ja = 9.933
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
				arg_69_0:Play413022017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10097 = arg_69_1.actors_["10097"].transform.localPosition
				arg_69_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10097", 4)

				for iter_72_0 = 0, arg_69_1.actors_["10097"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10097"].transform:GetChild(iter_72_0)

					if var_72_0.name == "" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_72_2 = arg_69_1.actors_["10094"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10094 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10094", 2)

				for iter_72_1 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_1)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_72_5 = arg_69_1.actors_["10097"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10097 == nil then
				arg_69_1.var_.actorSpriteComps10097 = var_72_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_6 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.actorSpriteComps10097 then
					for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_72_3 then
							if arg_69_1.isInRecall_ then
								iter_72_3.color = Color.New(Mathf.Lerp(iter_72_3.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_6), Mathf.Lerp(iter_72_3.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_6), (Mathf.Lerp(iter_72_3.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_6)))
							else
								local var_72_7 = Mathf.Lerp(iter_72_3.color.r, 1, (arg_69_1.time_ - 0) / var_72_6)

								iter_72_3.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.actorSpriteComps10097 then
				for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_72_5 then
						iter_72_5.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10097 = nil
			end

			local var_72_8 = arg_69_1.actors_["10094"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10094 == nil then
				arg_69_1.var_.actorSpriteComps10094 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.actorSpriteComps10094 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								iter_72_7.color = Color.New(Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_9), Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_9), (Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_9)))
							else
								local var_72_10 = Mathf.Lerp(iter_72_7.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_9)

								iter_72_7.color = Color.New(var_72_10, var_72_10, var_72_10)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10094 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_72_9 then
						iter_72_9.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps10094 = nil
			end

			local var_72_11 = 0
			local var_72_12 = 0.575

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_13 = arg_69_1:GetWordFromCfg(413022016)
				local var_72_14 = arg_69_1:FormatText(var_72_13.content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 23 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 23)

				if (23 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 23)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022016", "story_v_out_413022.awb") ~= 0 then
					local var_72_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022016", "story_v_out_413022.awb") / 1000

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end

					if var_72_13.prefab_name ~= "" and arg_69_1.actors_[var_72_13.prefab_name] ~= nil then
						local var_72_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_13.prefab_name].transform, "story_v_out_413022", "413022016", "story_v_out_413022.awb")

						arg_69_1:RecordAudio("413022016", var_72_18)
						arg_69_1:RecordAudio("413022016", var_72_18)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413022", "413022016", "story_v_out_413022.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413022", "413022016", "story_v_out_413022.awb")
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413022017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413022017
		arg_73_1.duration_ = 4.83

		local var_73_0 = {
			zh = 3.5,
			ja = 4.833
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
				arg_73_0:Play413022018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10097 = arg_73_1.actors_["10097"].transform.localPosition
				arg_73_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10097", 4)

				for iter_76_0 = 0, arg_73_1.actors_["10097"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10097"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_76_2 = arg_73_1.actors_["10094"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10094 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10094", 2)

				for iter_76_1 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_1)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_76_5 = arg_73_1.actors_["10097"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10097 == nil then
				arg_73_1.var_.actorSpriteComps10097 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps10097 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								iter_76_3.color = Color.New(Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_3.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_3.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps10097 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_76_5 then
						iter_76_5.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10097 = nil
			end

			local var_76_8 = arg_73_1.actors_["10094"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10094 == nil then
				arg_73_1.var_.actorSpriteComps10094 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_9 and not isNil(var_76_8) then
				if arg_73_1.var_.actorSpriteComps10094 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								iter_76_7.color = Color.New(Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_9), Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_9), (Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_9)))
							else
								local var_76_10 = Mathf.Lerp(iter_76_7.color.r, 1, (arg_73_1.time_ - 0) / var_76_9)

								iter_76_7.color = Color.New(var_76_10, var_76_10, var_76_10)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_9 and arg_73_1.time_ < 0 + var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps10094 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_76_9 then
						iter_76_9.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10094 = nil
			end

			local var_76_11 = 0
			local var_76_12 = 0.375

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(413022017)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 15 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 15)

				if (15 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 15)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022017", "story_v_out_413022.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022017", "story_v_out_413022.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_413022", "413022017", "story_v_out_413022.awb")

						arg_73_1:RecordAudio("413022017", var_76_18)
						arg_73_1:RecordAudio("413022017", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413022", "413022017", "story_v_out_413022.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413022", "413022017", "story_v_out_413022.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_19 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_19

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_19 and arg_73_1.time_ < var_76_11 + var_76_19 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413022018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413022018
		arg_77_1.duration_ = 4.3

		local var_77_0 = {
			zh = 3.233,
			ja = 4.3
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
				arg_77_0:Play413022019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.325

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(413022018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)

				if (13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022018", "story_v_out_413022.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022018", "story_v_out_413022.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_413022", "413022018", "story_v_out_413022.awb")

						arg_77_1:RecordAudio("413022018", var_80_6)
						arg_77_1:RecordAudio("413022018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413022", "413022018", "story_v_out_413022.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413022", "413022018", "story_v_out_413022.awb")
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
	Play413022019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413022019
		arg_81_1.duration_ = 2.77

		local var_81_0 = {
			zh = 2.766,
			ja = 2.533
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
				arg_81_0:Play413022020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10097 = arg_81_1.actors_["10097"].transform.localPosition
				arg_81_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10097", 4)

				for iter_84_0 = 0, arg_81_1.actors_["10097"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10097"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_84_2 = arg_81_1.actors_["10094"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10094 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10094", 2)

				for iter_84_1 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_1)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_84_5 = arg_81_1.actors_["10097"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10097 == nil then
				arg_81_1.var_.actorSpriteComps10097 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps10097 then
					for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_84_3 then
							if arg_81_1.isInRecall_ then
								iter_84_3.color = Color.New(Mathf.Lerp(iter_84_3.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_3.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_3.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_3.color.r, 1, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_3.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps10097 then
				for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_84_5 then
						iter_84_5.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10097 = nil
			end

			local var_84_8 = arg_81_1.actors_["10094"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10094 == nil then
				arg_81_1.var_.actorSpriteComps10094 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 and not isNil(var_84_8) then
				if arg_81_1.var_.actorSpriteComps10094 then
					for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_84_7 then
							if arg_81_1.isInRecall_ then
								iter_84_7.color = Color.New(Mathf.Lerp(iter_84_7.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_9), Mathf.Lerp(iter_84_7.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_9), (Mathf.Lerp(iter_84_7.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_9)))
							else
								local var_84_10 = Mathf.Lerp(iter_84_7.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_9)

								iter_84_7.color = Color.New(var_84_10, var_84_10, var_84_10)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10094 then
				for iter_84_8, iter_84_9 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_84_9 then
						iter_84_9.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10094 = nil
			end

			local var_84_11 = 0
			local var_84_12 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(413022019)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 11 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 11)

				if (11 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 11)) > 0 and var_84_12 < var_84_16 then
					arg_81_1.talkMaxDuration = var_84_16

					if var_84_16 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022019", "story_v_out_413022.awb") ~= 0 then
					local var_84_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022019", "story_v_out_413022.awb") / 1000

					if var_84_17 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_11
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_413022", "413022019", "story_v_out_413022.awb")

						arg_81_1:RecordAudio("413022019", var_84_18)
						arg_81_1:RecordAudio("413022019", var_84_18)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413022", "413022019", "story_v_out_413022.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413022", "413022019", "story_v_out_413022.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_19 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_19 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_11) / var_84_19

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_11 + var_84_19 and arg_81_1.time_ < var_84_11 + var_84_19 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play413022020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413022020
		arg_85_1.duration_ = 2.67

		local var_85_0 = {
			zh = 2.5,
			ja = 2.666
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
				arg_85_0:Play413022021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10097 = arg_85_1.actors_["10097"].transform.localPosition
				arg_85_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10097", 0)

				for iter_88_0 = 0, arg_85_1.actors_["10097"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10097"].transform:GetChild(iter_88_0)

					if var_88_0.name == "" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_88_2 = arg_85_1.actors_["10094"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10094 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10094", 0)

				for iter_88_1 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_1)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_88_5 = arg_85_1.actors_["10092"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092 = var_88_5.localPosition
				var_88_5.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092", 3)

				for iter_88_2 = 0, var_88_5.childCount - 1 do
					local var_88_6 = var_88_5:GetChild(iter_88_2)

					if var_88_6.name == "split_8" or not string.find(var_88_6.name, "split") then
						var_88_6.gameObject:SetActive(true)
					else
						var_88_6.gameObject:SetActive(false)
					end
				end
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_85_1.time_ - 0) / var_88_7)
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_88_8 = arg_85_1.actors_["10097"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10097 == nil then
				arg_85_1.var_.actorSpriteComps10097 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_9 and not isNil(var_88_8) then
				if arg_85_1.var_.actorSpriteComps10097 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								iter_88_4.color = Color.New(Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_9), Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_9), (Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_9)))
							else
								local var_88_10 = Mathf.Lerp(iter_88_4.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_9)

								iter_88_4.color = Color.New(var_88_10, var_88_10, var_88_10)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_9 and arg_85_1.time_ < 0 + var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10097 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_88_6 then
						iter_88_6.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10097 = nil
			end

			local var_88_11 = arg_85_1.actors_["10094"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.actorSpriteComps10094 == nil then
				arg_85_1.var_.actorSpriteComps10094 = var_88_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_12 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_12 and not isNil(var_88_11) then
				if arg_85_1.var_.actorSpriteComps10094 then
					for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_88_8 then
							if arg_85_1.isInRecall_ then
								iter_88_8.color = Color.New(Mathf.Lerp(iter_88_8.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_12), Mathf.Lerp(iter_88_8.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_12), (Mathf.Lerp(iter_88_8.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_12)))
							else
								local var_88_13 = Mathf.Lerp(iter_88_8.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_12)

								iter_88_8.color = Color.New(var_88_13, var_88_13, var_88_13)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_12 and arg_85_1.time_ < 0 + var_88_12 + arg_88_0 and not isNil(var_88_11) and arg_85_1.var_.actorSpriteComps10094 then
				for iter_88_9, iter_88_10 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_88_10 then
						iter_88_10.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10094 = nil
			end

			local var_88_14 = arg_85_1.actors_["10092"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = var_88_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_15 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_15 and not isNil(var_88_14) then
				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_11, iter_88_12 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_12 then
							if arg_85_1.isInRecall_ then
								iter_88_12.color = Color.New(Mathf.Lerp(iter_88_12.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_15), Mathf.Lerp(iter_88_12.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_15), (Mathf.Lerp(iter_88_12.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_15)))
							else
								local var_88_16 = Mathf.Lerp(iter_88_12.color.r, 1, (arg_85_1.time_ - 0) / var_88_15)

								iter_88_12.color = Color.New(var_88_16, var_88_16, var_88_16)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_15 and arg_85_1.time_ < 0 + var_88_15 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_13, iter_88_14 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_14 then
						iter_88_14.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_17 = arg_85_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_88_17 then
					arg_85_1.var_.alphaOldValue10092 = var_88_17.alpha
					arg_85_1.var_.characterEffect10092 = var_88_17
				end

				arg_85_1.var_.alphaOldValue10092 = 0
			end

			local var_88_18 = 0.034

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_18 then
				if arg_85_1.var_.characterEffect10092 then
					arg_85_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_85_1.var_.alphaOldValue10092, 1, (arg_85_1.time_ - 0) / var_88_18)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_18 and arg_85_1.time_ < 0 + var_88_18 + arg_88_0 and arg_85_1.var_.characterEffect10092 then
				arg_85_1.var_.characterEffect10092.alpha = 1
			end

			local var_88_19 = 0
			local var_88_20 = 0.275

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_21 = arg_85_1:GetWordFromCfg(413022020)
				local var_88_22 = arg_85_1:FormatText(var_88_21.content)

				arg_85_1.text_.text = var_88_22

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 11 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 11)

				if (11 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 11)) > 0 and var_88_20 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24

					if var_88_24 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_19
					end
				end

				arg_85_1.text_.text = var_88_22
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022020", "story_v_out_413022.awb") ~= 0 then
					local var_88_25 = manager.audio:GetVoiceLength("story_v_out_413022", "413022020", "story_v_out_413022.awb") / 1000

					if var_88_25 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_25 + var_88_19
					end

					if var_88_21.prefab_name ~= "" and arg_85_1.actors_[var_88_21.prefab_name] ~= nil then
						local var_88_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_21.prefab_name].transform, "story_v_out_413022", "413022020", "story_v_out_413022.awb")

						arg_85_1:RecordAudio("413022020", var_88_26)
						arg_85_1:RecordAudio("413022020", var_88_26)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413022", "413022020", "story_v_out_413022.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413022", "413022020", "story_v_out_413022.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_27 = math.max(var_88_20, arg_85_1.talkMaxDuration)

			if var_88_19 <= arg_85_1.time_ and arg_85_1.time_ < var_88_19 + var_88_27 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_19) / var_88_27

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_19 + var_88_27 and arg_85_1.time_ < var_88_19 + var_88_27 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413022021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413022021
		arg_89_1.duration_ = 4.87

		local var_89_0 = {
			zh = 4.866,
			ja = 3.466
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
				arg_89_0:Play413022022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10022 = arg_89_1.actors_["10022"].transform.localPosition
				arg_89_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10022", 3)

				for iter_92_0 = 0, arg_89_1.actors_["10022"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10022"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_6" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_92_2 = arg_89_1.actors_["10092"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092", 7)

				for iter_92_1 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_1)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_5 = arg_89_1.actors_["10022"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10022 == nil then
				arg_89_1.var_.actorSpriteComps10022 = var_92_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_6 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.actorSpriteComps10022 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								iter_92_3.color = Color.New(Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_6), Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_6), (Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_6)))
							else
								local var_92_7 = Mathf.Lerp(iter_92_3.color.r, 1, (arg_89_1.time_ - 0) / var_92_6)

								iter_92_3.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.actorSpriteComps10022 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_92_5 then
						iter_92_5.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps10022 = nil
			end

			local var_92_8 = arg_89_1.actors_["10092"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10092 == nil then
				arg_89_1.var_.actorSpriteComps10092 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 and not isNil(var_92_8) then
				if arg_89_1.var_.actorSpriteComps10092 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								iter_92_7.color = Color.New(Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_9), Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_9), (Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_9)))
							else
								local var_92_10 = Mathf.Lerp(iter_92_7.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_9)

								iter_92_7.color = Color.New(var_92_10, var_92_10, var_92_10)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10092 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_92_9 then
						iter_92_9.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				local var_92_11 = arg_89_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_92_11 then
					arg_89_1.var_.alphaOldValue10022 = var_92_11.alpha
					arg_89_1.var_.characterEffect10022 = var_92_11
				end

				arg_89_1.var_.alphaOldValue10022 = 0
			end

			local var_92_12 = 0.034

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_12 then
				if arg_89_1.var_.characterEffect10022 then
					arg_89_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_89_1.var_.alphaOldValue10022, 1, (arg_89_1.time_ - 0) / var_92_12)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_12 and arg_89_1.time_ < 0 + var_92_12 + arg_92_0 and arg_89_1.var_.characterEffect10022 then
				arg_89_1.var_.characterEffect10022.alpha = 1
			end

			local var_92_13 = 0
			local var_92_14 = 0.525

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(413022021)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_18 = 21 <= 0 and var_92_14 or var_92_14 * (utf8.len(var_92_16) / 21)

				if (21 <= 0 and var_92_14 or var_92_14 * (utf8.len(var_92_16) / 21)) > 0 and var_92_14 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18

					if var_92_18 + var_92_13 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_13
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022021", "story_v_out_413022.awb") ~= 0 then
					local var_92_19 = manager.audio:GetVoiceLength("story_v_out_413022", "413022021", "story_v_out_413022.awb") / 1000

					if var_92_19 + var_92_13 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_13
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_413022", "413022021", "story_v_out_413022.awb")

						arg_89_1:RecordAudio("413022021", var_92_20)
						arg_89_1:RecordAudio("413022021", var_92_20)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413022", "413022021", "story_v_out_413022.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413022", "413022021", "story_v_out_413022.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_14, arg_89_1.talkMaxDuration)

			if var_92_13 <= arg_89_1.time_ and arg_89_1.time_ < var_92_13 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_13) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_13 + var_92_21 and arg_89_1.time_ < var_92_13 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413022022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413022022
		arg_93_1.duration_ = 15.9

		local var_93_0 = {
			zh = 9.866,
			ja = 15.9
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
				arg_93_0:Play413022023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10097 = arg_93_1.actors_["10097"].transform.localPosition
				arg_93_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10097", 4)

				for iter_96_0 = 0, arg_93_1.actors_["10097"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10097"].transform:GetChild(iter_96_0)

					if var_96_0.name == "" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_96_2 = arg_93_1.actors_["10097"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10097 == nil then
				arg_93_1.var_.actorSpriteComps10097 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps10097 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps10097 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10097 = nil
			end

			local var_96_5 = arg_93_1.actors_["10022"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_5.localPosition
				var_96_5.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 2)

				for iter_96_5 = 0, var_96_5.childCount - 1 do
					local var_96_6 = var_96_5:GetChild(iter_96_5)

					if var_96_6.name == "split_6" or not string.find(var_96_6.name, "split") then
						var_96_6.gameObject:SetActive(true)
					else
						var_96_6.gameObject:SetActive(false)
					end
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_93_1.time_ - 0) / var_96_7)
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_96_8 = arg_93_1.actors_["10022"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_11 = arg_93_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_96_11 then
					arg_93_1.var_.alphaOldValue10022 = var_96_11.alpha
					arg_93_1.var_.characterEffect10022 = var_96_11
				end

				arg_93_1.var_.alphaOldValue10022 = 0
			end

			local var_96_12 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_12 then
				if arg_93_1.var_.characterEffect10022 then
					arg_93_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_93_1.var_.alphaOldValue10022, 1, (arg_93_1.time_ - 0) / var_96_12)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_12 and arg_93_1.time_ < 0 + var_96_12 + arg_96_0 and arg_93_1.var_.characterEffect10022 then
				arg_93_1.var_.characterEffect10022.alpha = 1
			end

			local var_96_13 = 0
			local var_96_14 = 0.95

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(413022022)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_18 = 38 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 38)

				if (38 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 38)) > 0 and var_96_14 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18

					if var_96_18 + var_96_13 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_13
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022022", "story_v_out_413022.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_413022", "413022022", "story_v_out_413022.awb") / 1000

					if var_96_19 + var_96_13 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_13
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_413022", "413022022", "story_v_out_413022.awb")

						arg_93_1:RecordAudio("413022022", var_96_20)
						arg_93_1:RecordAudio("413022022", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413022", "413022022", "story_v_out_413022.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413022", "413022022", "story_v_out_413022.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_21 = math.max(var_96_14, arg_93_1.talkMaxDuration)

			if var_96_13 <= arg_93_1.time_ and arg_93_1.time_ < var_96_13 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_13) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_13 + var_96_21 and arg_93_1.time_ < var_96_13 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413022023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413022023
		arg_97_1.duration_ = 6.43

		local var_97_0 = {
			zh = 4.666,
			ja = 6.433
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
				arg_97_0:Play413022024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10094 = arg_97_1.actors_["10094"].transform.localPosition
				arg_97_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10094", 2)

				for iter_100_0 = 0, arg_97_1.actors_["10094"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["10094"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_97_1.time_ - 0) / var_100_1)
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_100_2 = arg_97_1.actors_["10097"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10097 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10097", 4)

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
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_100_5 = arg_97_1.actors_["10094"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10094 == nil then
				arg_97_1.var_.actorSpriteComps10094 = var_100_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_6 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.actorSpriteComps10094 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								iter_100_3.color = Color.New(Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_6), Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_6), (Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_6)))
							else
								local var_100_7 = Mathf.Lerp(iter_100_3.color.r, 1, (arg_97_1.time_ - 0) / var_100_6)

								iter_100_3.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.actorSpriteComps10094 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_100_5 then
						iter_100_5.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10094 = nil
			end

			local var_100_8 = arg_97_1.actors_["10097"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10097 == nil then
				arg_97_1.var_.actorSpriteComps10097 = var_100_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_9 and not isNil(var_100_8) then
				if arg_97_1.var_.actorSpriteComps10097 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								iter_100_7.color = Color.New(Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_9), Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_9), (Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_9)))
							else
								local var_100_10 = Mathf.Lerp(iter_100_7.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_9)

								iter_100_7.color = Color.New(var_100_10, var_100_10, var_100_10)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_9 and arg_97_1.time_ < 0 + var_100_9 + arg_100_0 and not isNil(var_100_8) and arg_97_1.var_.actorSpriteComps10097 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_100_9 then
						iter_100_9.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10097 = nil
			end

			local var_100_11 = 0
			local var_100_12 = 0.425

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(413022023)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 17 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 17)

				if (17 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 17)) > 0 and var_100_12 < var_100_16 then
					arg_97_1.talkMaxDuration = var_100_16

					if var_100_16 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022023", "story_v_out_413022.awb") ~= 0 then
					local var_100_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022023", "story_v_out_413022.awb") / 1000

					if var_100_17 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_11
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_413022", "413022023", "story_v_out_413022.awb")

						arg_97_1:RecordAudio("413022023", var_100_18)
						arg_97_1:RecordAudio("413022023", var_100_18)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413022", "413022023", "story_v_out_413022.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413022", "413022023", "story_v_out_413022.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_19 and arg_97_1.time_ < var_100_11 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413022024
		arg_101_1.duration_ = 7.2

		local var_101_0 = {
			zh = 4.566,
			ja = 7.2
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
				arg_101_0:Play413022025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10097 = arg_101_1.actors_["10097"].transform.localPosition
				arg_101_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10097", 4)

				for iter_104_0 = 0, arg_101_1.actors_["10097"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10097"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_2 = arg_101_1.actors_["10094"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10094 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10094", 2)

				for iter_104_1 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_1)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_104_5 = arg_101_1.actors_["10097"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10097 == nil then
				arg_101_1.var_.actorSpriteComps10097 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps10097 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								iter_104_3.color = Color.New(Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_3.color.r, 1, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_3.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10097 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_104_5 then
						iter_104_5.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10097 = nil
			end

			local var_104_8 = arg_101_1.actors_["10094"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10094 == nil then
				arg_101_1.var_.actorSpriteComps10094 = var_104_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 and not isNil(var_104_8) then
				if arg_101_1.var_.actorSpriteComps10094 then
					for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_104_7 then
							if arg_101_1.isInRecall_ then
								iter_104_7.color = Color.New(Mathf.Lerp(iter_104_7.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_9), Mathf.Lerp(iter_104_7.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_9), (Mathf.Lerp(iter_104_7.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_9)))
							else
								local var_104_10 = Mathf.Lerp(iter_104_7.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_9)

								iter_104_7.color = Color.New(var_104_10, var_104_10, var_104_10)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.actorSpriteComps10094 then
				for iter_104_8, iter_104_9 in pairs(arg_101_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_104_9 then
						iter_104_9.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10094 = nil
			end

			local var_104_11 = 0
			local var_104_12 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_11 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_13 = arg_101_1:GetWordFromCfg(413022024)
				local var_104_14 = arg_101_1:FormatText(var_104_13.content)

				arg_101_1.text_.text = var_104_14

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 18 <= 0 and var_104_12 or var_104_12 * (utf8.len(var_104_14) / 18)

				if (18 <= 0 and var_104_12 or var_104_12 * (utf8.len(var_104_14) / 18)) > 0 and var_104_12 < var_104_16 then
					arg_101_1.talkMaxDuration = var_104_16

					if var_104_16 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_11
					end
				end

				arg_101_1.text_.text = var_104_14
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022024", "story_v_out_413022.awb") ~= 0 then
					local var_104_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022024", "story_v_out_413022.awb") / 1000

					if var_104_17 + var_104_11 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_17 + var_104_11
					end

					if var_104_13.prefab_name ~= "" and arg_101_1.actors_[var_104_13.prefab_name] ~= nil then
						local var_104_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_13.prefab_name].transform, "story_v_out_413022", "413022024", "story_v_out_413022.awb")

						arg_101_1:RecordAudio("413022024", var_104_18)
						arg_101_1:RecordAudio("413022024", var_104_18)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413022", "413022024", "story_v_out_413022.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413022", "413022024", "story_v_out_413022.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_19 = math.max(var_104_12, arg_101_1.talkMaxDuration)

			if var_104_11 <= arg_101_1.time_ and arg_101_1.time_ < var_104_11 + var_104_19 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_11) / var_104_19

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_11 + var_104_19 and arg_101_1.time_ < var_104_11 + var_104_19 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413022025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413022025
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play413022026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				local var_108_0 = arg_105_1.bgs_.F08h

				arg_105_1.bgs_.F08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_1 = var_108_0:GetComponent("SpriteRenderer")

				if var_108_1 and var_108_1.sprite then
					local var_108_2 = 2 * (var_108_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_0.transform.localScale = Vector3.New(var_108_2 / var_108_1.sprite.bounds.size.y < var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x and var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x or var_108_2 / var_108_1.sprite.bounds.size.y, var_108_2 / var_108_1.sprite.bounds.size.y < var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x and var_108_2 * manager.ui.mainCameraCom_.aspect / var_108_1.sprite.bounds.size.x or var_108_2 / var_108_1.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "F08h" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_3 = 3.999999999999

			if 3.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			if arg_105_1.time_ >= var_108_3 + 0.3 and arg_105_1.time_ < var_108_3 + 0.3 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_4 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_5 = 2

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_5 then
				local var_108_6 = Color.New(0, 0, 0)

				var_108_6.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_4) / var_108_5)
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.time_ >= var_108_4 + var_108_5 and arg_105_1.time_ < var_108_4 + var_108_5 + arg_108_0 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = 1
				arg_105_1.mask_.color = var_108_7
			end

			local var_108_8 = 1.999999999999

			if 1.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 then
				local var_108_10 = Color.New(0, 0, 0)

				var_108_10.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_8) / var_108_9)
				arg_105_1.mask_.color = var_108_10
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 then
				local var_108_11 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_11.a = 0
				arg_105_1.mask_.color = var_108_11
			end

			local var_108_12 = arg_105_1.actors_["10097"].transform

			if 1.966 < arg_105_1.time_ and arg_105_1.time_ <= 1.966 + arg_108_0 then
				arg_105_1.var_.moveOldPos10097 = var_108_12.localPosition
				var_108_12.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10097", 0)

				for iter_108_2 = 0, var_108_12.childCount - 1 do
					local var_108_13 = var_108_12:GetChild(iter_108_2)

					if var_108_13.name == "" or not string.find(var_108_13.name, "split") then
						var_108_13.gameObject:SetActive(true)
					else
						var_108_13.gameObject:SetActive(false)
					end
				end
			end

			local var_108_14 = 0.001

			if 1.966 <= arg_105_1.time_ and arg_105_1.time_ < 1.966 + var_108_14 then
				var_108_12.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_105_1.time_ - 1.966) / var_108_14)
			end

			if arg_105_1.time_ >= 1.966 + var_108_14 and arg_105_1.time_ < 1.966 + var_108_14 + arg_108_0 then
				var_108_12.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_108_15 = arg_105_1.actors_["10094"].transform

			if 1.966 < arg_105_1.time_ and arg_105_1.time_ <= 1.966 + arg_108_0 then
				arg_105_1.var_.moveOldPos10094 = var_108_15.localPosition
				var_108_15.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10094", 0)

				for iter_108_3 = 0, var_108_15.childCount - 1 do
					local var_108_16 = var_108_15:GetChild(iter_108_3)

					if var_108_16.name == "" or not string.find(var_108_16.name, "split") then
						var_108_16.gameObject:SetActive(true)
					else
						var_108_16.gameObject:SetActive(false)
					end
				end
			end

			local var_108_17 = 0.001

			if 1.966 <= arg_105_1.time_ and arg_105_1.time_ < 1.966 + var_108_17 then
				var_108_15.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_105_1.time_ - 1.966) / var_108_17)
			end

			if arg_105_1.time_ >= 1.966 + var_108_17 and arg_105_1.time_ < 1.966 + var_108_17 + arg_108_0 then
				var_108_15.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_108_18 = arg_105_1.actors_["10097"]

			if 1.966 < arg_105_1.time_ and arg_105_1.time_ <= 1.966 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.actorSpriteComps10097 == nil then
				arg_105_1.var_.actorSpriteComps10097 = var_108_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_19 = 0.034

			if 1.966 <= arg_105_1.time_ and arg_105_1.time_ < 1.966 + var_108_19 and not isNil(var_108_18) then
				if arg_105_1.var_.actorSpriteComps10097 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								iter_108_5.color = Color.New(Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 1.966) / var_108_19), Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 1.966) / var_108_19), (Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 1.966) / var_108_19)))
							else
								local var_108_20 = Mathf.Lerp(iter_108_5.color.r, 0.5, (arg_105_1.time_ - 1.966) / var_108_19)

								iter_108_5.color = Color.New(var_108_20, var_108_20, var_108_20)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 1.966 + var_108_19 and arg_105_1.time_ < 1.966 + var_108_19 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.actorSpriteComps10097 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_108_7 then
						iter_108_7.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10097 = nil
			end

			local var_108_21 = arg_105_1.actors_["10094"]

			if 1.966 < arg_105_1.time_ and arg_105_1.time_ <= 1.966 + arg_108_0 and not isNil(var_108_21) and arg_105_1.var_.actorSpriteComps10094 == nil then
				arg_105_1.var_.actorSpriteComps10094 = var_108_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_22 = 0.034

			if 1.966 <= arg_105_1.time_ and arg_105_1.time_ < 1.966 + var_108_22 and not isNil(var_108_21) then
				if arg_105_1.var_.actorSpriteComps10094 then
					for iter_108_8, iter_108_9 in pairs(arg_105_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_108_9 then
							if arg_105_1.isInRecall_ then
								iter_108_9.color = Color.New(Mathf.Lerp(iter_108_9.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 1.966) / var_108_22), Mathf.Lerp(iter_108_9.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 1.966) / var_108_22), (Mathf.Lerp(iter_108_9.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 1.966) / var_108_22)))
							else
								local var_108_23 = Mathf.Lerp(iter_108_9.color.r, 0.5, (arg_105_1.time_ - 1.966) / var_108_22)

								iter_108_9.color = Color.New(var_108_23, var_108_23, var_108_23)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 1.966 + var_108_22 and arg_105_1.time_ < 1.966 + var_108_22 + arg_108_0 and not isNil(var_108_21) and arg_105_1.var_.actorSpriteComps10094 then
				for iter_108_10, iter_108_11 in pairs(arg_105_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_108_11 then
						iter_108_11.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10094 = nil
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_24 = 4
			local var_108_25 = 1.425

			if 4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_26 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_26:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_27 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(413022025).content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_29 = 57 <= 0 and var_108_25 or var_108_25 * (utf8.len(var_108_27) / 57)

				if (57 <= 0 and var_108_25 or var_108_25 * (utf8.len(var_108_27) / 57)) > 0 and var_108_25 < var_108_29 then
					arg_105_1.talkMaxDuration = var_108_29
					var_108_24 = var_108_24 + 0.3

					if var_108_29 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_29 + var_108_24
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_30 = var_108_24 + 0.3
			local var_108_31 = math.max(var_108_25, arg_105_1.talkMaxDuration)

			if var_108_24 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_31 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_30) / var_108_31

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_30 + var_108_31 and arg_105_1.time_ < var_108_30 + var_108_31 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413022026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413022026
		arg_111_1.duration_ = 17

		local var_111_0 = {
			zh = 12.066,
			ja = 17
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
				arg_111_0:Play413022027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["10096"] == nil then
				local var_114_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_114_0) then
					local var_114_1 = Object.Instantiate(var_114_0, arg_111_1.canvasGo_.transform)

					var_114_1.transform:SetSiblingIndex(1)

					var_114_1.name = "10096"
					var_114_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_111_1.actors_["10096"] = var_114_1

					if arg_111_1.isInRecall_ then
						for iter_114_0, iter_114_1 in ipairs((var_114_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_114_1.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_114_2 = arg_111_1.actors_["10096"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10096 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10096", 3)

				for iter_114_2 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_2)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_111_1.time_ - 0) / var_114_4)
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_114_5 = arg_111_1.actors_["10096"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10096 == nil then
				arg_111_1.var_.actorSpriteComps10096 = var_114_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_6 = 2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.actorSpriteComps10096 then
					for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_114_4 then
							if arg_111_1.isInRecall_ then
								iter_114_4.color = Color.New(Mathf.Lerp(iter_114_4.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_6), Mathf.Lerp(iter_114_4.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_6), (Mathf.Lerp(iter_114_4.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_6)))
							else
								local var_114_7 = Mathf.Lerp(iter_114_4.color.r, 1, (arg_111_1.time_ - 0) / var_114_6)

								iter_114_4.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.actorSpriteComps10096 then
				for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_114_6 then
						iter_114_6.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10096 = nil
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_8 = arg_111_1.actors_["10096"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_114_8 then
					arg_111_1.var_.alphaOldValue10096 = var_114_8.alpha
					arg_111_1.var_.characterEffect10096 = var_114_8
				end

				arg_111_1.var_.alphaOldValue10096 = 0
			end

			local var_114_9 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 then
				if arg_111_1.var_.characterEffect10096 then
					arg_111_1.var_.characterEffect10096.alpha = Mathf.Lerp(arg_111_1.var_.alphaOldValue10096, 1, (arg_111_1.time_ - 0) / var_114_9)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 and arg_111_1.var_.characterEffect10096 then
				arg_111_1.var_.characterEffect10096.alpha = 1
			end

			local var_114_10 = 0
			local var_114_11 = 0.675

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_12 = arg_111_1:GetWordFromCfg(413022026)
				local var_114_13 = arg_111_1:FormatText(var_114_12.content)

				arg_111_1.text_.text = var_114_13

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 27 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 27)

				if (27 <= 0 and var_114_11 or var_114_11 * (utf8.len(var_114_13) / 27)) > 0 and var_114_11 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_13
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022026", "story_v_out_413022.awb") ~= 0 then
					local var_114_16 = manager.audio:GetVoiceLength("story_v_out_413022", "413022026", "story_v_out_413022.awb") / 1000

					if var_114_16 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_10
					end

					if var_114_12.prefab_name ~= "" and arg_111_1.actors_[var_114_12.prefab_name] ~= nil then
						local var_114_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_12.prefab_name].transform, "story_v_out_413022", "413022026", "story_v_out_413022.awb")

						arg_111_1:RecordAudio("413022026", var_114_17)
						arg_111_1:RecordAudio("413022026", var_114_17)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413022", "413022026", "story_v_out_413022.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413022", "413022026", "story_v_out_413022.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_18 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_18 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_18

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_18 and arg_111_1.time_ < var_114_10 + var_114_18 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play413022027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413022027
		arg_115_1.duration_ = 6.63

		local var_115_0 = {
			zh = 5.2,
			ja = 6.633
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
				arg_115_0:Play413022028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.425

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(413022027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 17 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 17)

				if (17 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 17)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022027", "story_v_out_413022.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022027", "story_v_out_413022.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_413022", "413022027", "story_v_out_413022.awb")

						arg_115_1:RecordAudio("413022027", var_118_6)
						arg_115_1:RecordAudio("413022027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413022", "413022027", "story_v_out_413022.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413022", "413022027", "story_v_out_413022.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play413022028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413022028
		arg_119_1.duration_ = 7

		local var_119_0 = {
			zh = 3.866,
			ja = 7
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
				arg_119_0:Play413022029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10096 = arg_119_1.actors_["10096"].transform.localPosition
				arg_119_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10096", 4)

				for iter_122_0 = 0, arg_119_1.actors_["10096"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10096"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10096"].transform.localPosition = Vector3.New(390, -350, -210)
			end

			local var_122_2 = "10095"

			if arg_119_1.actors_["10095"] == nil then
				local var_122_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_122_3) then
					local var_122_4 = Object.Instantiate(var_122_3, arg_119_1.canvasGo_.transform)

					var_122_4.transform:SetSiblingIndex(1)

					var_122_4.name = var_122_2
					var_122_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_119_1.actors_[var_122_2] = var_122_4

					if arg_119_1.isInRecall_ then
						for iter_122_1, iter_122_2 in ipairs((var_122_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_122_2.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_122_5 = arg_119_1.actors_["10095"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10095 = var_122_5.localPosition
				var_122_5.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10095", 2)

				for iter_122_3 = 0, var_122_5.childCount - 1 do
					local var_122_6 = var_122_5:GetChild(iter_122_3)

					if var_122_6.name == "split_1_1" or not string.find(var_122_6.name, "split") then
						var_122_6.gameObject:SetActive(true)
					else
						var_122_6.gameObject:SetActive(false)
					end
				end
			end

			local var_122_7 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				var_122_5.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_119_1.time_ - 0) / var_122_7)
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				var_122_5.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_122_8 = arg_119_1.actors_["10096"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10096 == nil then
				arg_119_1.var_.actorSpriteComps10096 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 and not isNil(var_122_8) then
				if arg_119_1.var_.actorSpriteComps10096 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								iter_122_5.color = Color.New(Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_9), Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_9), (Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_9)))
							else
								local var_122_10 = Mathf.Lerp(iter_122_5.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_9)

								iter_122_5.color = Color.New(var_122_10, var_122_10, var_122_10)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10096 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10096 = nil
			end

			local var_122_11 = arg_119_1.actors_["10095"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.actorSpriteComps10095 == nil then
				arg_119_1.var_.actorSpriteComps10095 = var_122_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_12 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_12 and not isNil(var_122_11) then
				if arg_119_1.var_.actorSpriteComps10095 then
					for iter_122_8, iter_122_9 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_122_9 then
							if arg_119_1.isInRecall_ then
								iter_122_9.color = Color.New(Mathf.Lerp(iter_122_9.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_12), Mathf.Lerp(iter_122_9.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_12), (Mathf.Lerp(iter_122_9.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_12)))
							else
								local var_122_13 = Mathf.Lerp(iter_122_9.color.r, 1, (arg_119_1.time_ - 0) / var_122_12)

								iter_122_9.color = Color.New(var_122_13, var_122_13, var_122_13)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_12 and arg_119_1.time_ < 0 + var_122_12 + arg_122_0 and not isNil(var_122_11) and arg_119_1.var_.actorSpriteComps10095 then
				for iter_122_10, iter_122_11 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_122_11 then
						iter_122_11.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10095 = nil
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				local var_122_14 = arg_119_1.actors_["10095"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_122_14 then
					arg_119_1.var_.alphaOldValue10095 = var_122_14.alpha
					arg_119_1.var_.characterEffect10095 = var_122_14
				end

				arg_119_1.var_.alphaOldValue10095 = 0
			end

			local var_122_15 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_15 then
				if arg_119_1.var_.characterEffect10095 then
					arg_119_1.var_.characterEffect10095.alpha = Mathf.Lerp(arg_119_1.var_.alphaOldValue10095, 1, (arg_119_1.time_ - 0) / var_122_15)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_15 and arg_119_1.time_ < 0 + var_122_15 + arg_122_0 and arg_119_1.var_.characterEffect10095 then
				arg_119_1.var_.characterEffect10095.alpha = 1
			end

			local var_122_16 = 0
			local var_122_17 = 0.275

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(413022028)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 11 <= 0 and var_122_17 or var_122_17 * (utf8.len(var_122_19) / 11)

				if (11 <= 0 and var_122_17 or var_122_17 * (utf8.len(var_122_19) / 11)) > 0 and var_122_17 < var_122_21 then
					arg_119_1.talkMaxDuration = var_122_21

					if var_122_21 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_16
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022028", "story_v_out_413022.awb") ~= 0 then
					local var_122_22 = manager.audio:GetVoiceLength("story_v_out_413022", "413022028", "story_v_out_413022.awb") / 1000

					if var_122_22 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_16
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_413022", "413022028", "story_v_out_413022.awb")

						arg_119_1:RecordAudio("413022028", var_122_23)
						arg_119_1:RecordAudio("413022028", var_122_23)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413022", "413022028", "story_v_out_413022.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413022", "413022028", "story_v_out_413022.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_24 = math.max(var_122_17, arg_119_1.talkMaxDuration)

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_24 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_16) / var_122_24

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_16 + var_122_24 and arg_119_1.time_ < var_122_16 + var_122_24 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play413022029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413022029
		arg_123_1.duration_ = 5.77

		local var_123_0 = {
			zh = 5,
			ja = 5.766
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
				arg_123_0:Play413022030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(413022029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 15 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 15)

				if (15 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 15)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022029", "story_v_out_413022.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022029", "story_v_out_413022.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_413022", "413022029", "story_v_out_413022.awb")

						arg_123_1:RecordAudio("413022029", var_126_6)
						arg_123_1:RecordAudio("413022029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413022", "413022029", "story_v_out_413022.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413022", "413022029", "story_v_out_413022.awb")
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
	Play413022030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413022030
		arg_127_1.duration_ = 12.67

		local var_127_0 = {
			zh = 6.733,
			ja = 12.666
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
				arg_127_0:Play413022031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10096"]) and arg_127_1.var_.actorSpriteComps10096 == nil then
				arg_127_1.var_.actorSpriteComps10096 = arg_127_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10096"]) then
				if arg_127_1.var_.actorSpriteComps10096 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 1, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10096"]) and arg_127_1.var_.actorSpriteComps10096 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10096 = nil
			end

			local var_130_2 = arg_127_1.actors_["10095"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10095 == nil then
				arg_127_1.var_.actorSpriteComps10095 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10095 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								iter_130_5.color = Color.New(Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_5.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_5.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10095 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_130_7 then
						iter_130_7.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10095 = nil
			end

			local var_130_5 = 0
			local var_130_6 = 0.55

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(413022030)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 22 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 22)

				if (22 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 22)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022030", "story_v_out_413022.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022030", "story_v_out_413022.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_413022", "413022030", "story_v_out_413022.awb")

						arg_127_1:RecordAudio("413022030", var_130_12)
						arg_127_1:RecordAudio("413022030", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413022", "413022030", "story_v_out_413022.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413022", "413022030", "story_v_out_413022.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413022031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413022031
		arg_131_1.duration_ = 7

		local var_131_0 = {
			zh = 4.733,
			ja = 7
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
				arg_131_0:Play413022032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.425

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(413022031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)

				if (17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022031", "story_v_out_413022.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022031", "story_v_out_413022.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_413022", "413022031", "story_v_out_413022.awb")

						arg_131_1:RecordAudio("413022031", var_134_6)
						arg_131_1:RecordAudio("413022031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413022", "413022031", "story_v_out_413022.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413022", "413022031", "story_v_out_413022.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413022032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413022032
		arg_135_1.duration_ = 8.47

		local var_135_0 = {
			zh = 8.466,
			ja = 8.4
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
				arg_135_0:Play413022033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10095 = arg_135_1.actors_["10095"].transform.localPosition
				arg_135_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10095", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10095"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10095"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_1_6" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_138_2 = arg_135_1.actors_["10096"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10096 == nil then
				arg_135_1.var_.actorSpriteComps10096 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10096 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10096 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10096 = nil
			end

			local var_138_5 = arg_135_1.actors_["10095"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10095 == nil then
				arg_135_1.var_.actorSpriteComps10095 = var_138_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_6 = 2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.actorSpriteComps10095 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								iter_138_6.color = Color.New(Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_6), Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_6), (Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_6)))
							else
								local var_138_7 = Mathf.Lerp(iter_138_6.color.r, 1, (arg_135_1.time_ - 0) / var_138_6)

								iter_138_6.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.actorSpriteComps10095 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_138_8 then
						iter_138_8.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10095 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.6

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(413022032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 24 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 24)

				if (24 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 24)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022032", "story_v_out_413022.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022032", "story_v_out_413022.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_413022", "413022032", "story_v_out_413022.awb")

						arg_135_1:RecordAudio("413022032", var_138_15)
						arg_135_1:RecordAudio("413022032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413022", "413022032", "story_v_out_413022.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413022", "413022032", "story_v_out_413022.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play413022033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413022033
		arg_139_1.duration_ = 10.2

		local var_139_0 = {
			zh = 9.433,
			ja = 10.2
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
				arg_139_0:Play413022034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10096"]) and arg_139_1.var_.actorSpriteComps10096 == nil then
				arg_139_1.var_.actorSpriteComps10096 = arg_139_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10096"]) then
				if arg_139_1.var_.actorSpriteComps10096 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10096"]) and arg_139_1.var_.actorSpriteComps10096 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10096 = nil
			end

			local var_142_2 = arg_139_1.actors_["10095"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10095 == nil then
				arg_139_1.var_.actorSpriteComps10095 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps10095 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								iter_142_5.color = Color.New(Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_5.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_5.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10095 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_142_7 then
						iter_142_7.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10095 = nil
			end

			local var_142_5 = 0
			local var_142_6 = 0.75

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(413022033)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 30 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 30)

				if (30 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 30)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022033", "story_v_out_413022.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022033", "story_v_out_413022.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_413022", "413022033", "story_v_out_413022.awb")

						arg_139_1:RecordAudio("413022033", var_142_12)
						arg_139_1:RecordAudio("413022033", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413022", "413022033", "story_v_out_413022.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413022", "413022033", "story_v_out_413022.awb")
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

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play413022034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413022034
		arg_143_1.duration_ = 11.3

		local var_143_0 = {
			zh = 5.333,
			ja = 11.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play413022035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.5

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(413022034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 20 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 20)

				if (20 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 20)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022034", "story_v_out_413022.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022034", "story_v_out_413022.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_413022", "413022034", "story_v_out_413022.awb")

						arg_143_1:RecordAudio("413022034", var_146_6)
						arg_143_1:RecordAudio("413022034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413022", "413022034", "story_v_out_413022.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413022", "413022034", "story_v_out_413022.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play413022035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413022035
		arg_147_1.duration_ = 8.2

		local var_147_0 = {
			zh = 4.9,
			ja = 8.2
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
				arg_147_0:Play413022036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(413022035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 12 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 12)

				if (12 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 12)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022035", "story_v_out_413022.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022035", "story_v_out_413022.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_413022", "413022035", "story_v_out_413022.awb")

						arg_147_1:RecordAudio("413022035", var_150_6)
						arg_147_1:RecordAudio("413022035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413022", "413022035", "story_v_out_413022.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413022", "413022035", "story_v_out_413022.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413022036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413022036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play413022037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10096 = arg_151_1.actors_["10096"].transform.localPosition
				arg_151_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10096", 0)

				for iter_154_0 = 0, arg_151_1.actors_["10096"].transform.childCount - 1 do
					local var_154_0 = arg_151_1.actors_["10096"].transform:GetChild(iter_154_0)

					if var_154_0.name == "" or not string.find(var_154_0.name, "split") then
						var_154_0.gameObject:SetActive(true)
					else
						var_154_0.gameObject:SetActive(false)
					end
				end
			end

			local var_154_1 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				arg_151_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10096, Vector3.New(-1500, -350, -180), (arg_151_1.time_ - 0) / var_154_1)
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				arg_151_1.actors_["10096"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_154_2 = arg_151_1.actors_["10095"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10095 = var_154_2.localPosition
				var_154_2.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10095", 0)

				for iter_154_1 = 0, var_154_2.childCount - 1 do
					local var_154_3 = var_154_2:GetChild(iter_154_1)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_2.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10095, Vector3.New(-1500, -350, -180), (arg_151_1.time_ - 0) / var_154_4)
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_154_5 = arg_151_1.actors_["10096"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps10096 == nil then
				arg_151_1.var_.actorSpriteComps10096 = var_154_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_6 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 and not isNil(var_154_5) then
				if arg_151_1.var_.actorSpriteComps10096 then
					for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_154_3 then
							if arg_151_1.isInRecall_ then
								iter_154_3.color = Color.New(Mathf.Lerp(iter_154_3.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_6), Mathf.Lerp(iter_154_3.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_6), (Mathf.Lerp(iter_154_3.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_6)))
							else
								local var_154_7 = Mathf.Lerp(iter_154_3.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_6)

								iter_154_3.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 and not isNil(var_154_5) and arg_151_1.var_.actorSpriteComps10096 then
				for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_154_5 then
						iter_154_5.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10096 = nil
			end

			local var_154_8 = arg_151_1.actors_["10095"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps10095 == nil then
				arg_151_1.var_.actorSpriteComps10095 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_9 = 2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_9 and not isNil(var_154_8) then
				if arg_151_1.var_.actorSpriteComps10095 then
					for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_154_7 then
							if arg_151_1.isInRecall_ then
								iter_154_7.color = Color.New(Mathf.Lerp(iter_154_7.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_9), Mathf.Lerp(iter_154_7.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_9), (Mathf.Lerp(iter_154_7.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_9)))
							else
								local var_154_10 = Mathf.Lerp(iter_154_7.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_9)

								iter_154_7.color = Color.New(var_154_10, var_154_10, var_154_10)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_9 and arg_151_1.time_ < 0 + var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps10095 then
				for iter_154_8, iter_154_9 in pairs(arg_151_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_154_9 then
						iter_154_9.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10095 = nil
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_154_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_13 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_13

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_13
						arg_151_1.bgmTxt2_.text = var_154_13
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_activity_1_1", "se_story_activity_1_1_breeze", "")
			end

			local var_154_15 = 0
			local var_154_16 = 1.35

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_17 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(413022036).content)

				arg_151_1.text_.text = var_154_17

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_19 = 54 <= 0 and var_154_16 or var_154_16 * (utf8.len(var_154_17) / 54)

				if (54 <= 0 and var_154_16 or var_154_16 * (utf8.len(var_154_17) / 54)) > 0 and var_154_16 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19

					if var_154_19 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_17
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_20 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_20

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_20 and arg_151_1.time_ < var_154_15 + var_154_20 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play413022037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 413022037
		arg_156_1.duration_ = 9

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play413022038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.bgs_.ST0601 == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0601")
				var_159_0.name = "ST0601"
				var_159_0.transform.parent = arg_156_1.stage_.transform
				var_159_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_.ST0601 = var_159_0
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				local var_159_1 = arg_156_1.bgs_.ST0601

				arg_156_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_159_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_2 = var_159_1:GetComponent("SpriteRenderer")

				if var_159_2 and var_159_2.sprite then
					local var_159_3 = 2 * (var_159_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_159_1.transform.localScale = Vector3.New(var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, var_159_3 / var_159_2.sprite.bounds.size.y < var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x and var_159_3 * manager.ui.mainCameraCom_.aspect / var_159_2.sprite.bounds.size.x or var_159_3 / var_159_2.sprite.bounds.size.y, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST0601" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_4 = 4

			if 4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			if arg_156_1.time_ >= var_159_4 + 0.3 and arg_156_1.time_ < var_159_4 + 0.3 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_5 = 0

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_6 = 2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 then
				local var_159_7 = Color.New(0, 0, 0)

				var_159_7.a = Mathf.Lerp(0, 1, (arg_156_1.time_ - var_159_5) / var_159_6)
				arg_156_1.mask_.color = var_159_7
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 then
				local var_159_8 = Color.New(0, 0, 0)

				var_159_8.a = 1
				arg_156_1.mask_.color = var_159_8
			end

			local var_159_9 = 2

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_10 = 2

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 then
				local var_159_11 = Color.New(0, 0, 0)

				var_159_11.a = Mathf.Lerp(1, 0, (arg_156_1.time_ - var_159_9) / var_159_10)
				arg_156_1.mask_.color = var_159_11
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 then
				local var_159_12 = Color.New(0, 0, 0)

				arg_156_1.mask_.enabled = false
				var_159_12.a = 0
				arg_156_1.mask_.color = var_159_12
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_159_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_15 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_15

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_15
						arg_156_1.bgmTxt2_.text = var_159_15
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_156_1.time_ and arg_156_1.time_ <= 2 + arg_159_0 then
				arg_156_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_159_18 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_18 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_18

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_18
						arg_156_1.bgmTxt2_.text = var_159_18
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_19 = 4
			local var_159_20 = 1.35

			if 4 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_21 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_21:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_156_1.dialogCg_.alpha = arg_162_0
				end))
				var_159_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_22 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(413022037).content)

				arg_156_1.text_.text = var_159_22

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_24 = 54 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_22) / 54)

				if (54 <= 0 and var_159_20 or var_159_20 * (utf8.len(var_159_22) / 54)) > 0 and var_159_20 < var_159_24 then
					arg_156_1.talkMaxDuration = var_159_24
					var_159_19 = var_159_19 + 0.3

					if var_159_24 + var_159_19 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_24 + var_159_19
					end
				end

				arg_156_1.text_.text = var_159_22
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = var_159_19 + 0.3
			local var_159_26 = math.max(var_159_20, arg_156_1.talkMaxDuration)

			if var_159_19 + 0.3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_25 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_25) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_25 + var_159_26 and arg_156_1.time_ < var_159_25 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play413022038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 413022038
		arg_164_1.duration_ = 7.1

		local var_164_0 = {
			zh = 3.666,
			ja = 7.1
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
				arg_164_0:Play413022039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10094 = arg_164_1.actors_["10094"].transform.localPosition
				arg_164_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10094", 2)

				for iter_167_0 = 0, arg_164_1.actors_["10094"].transform.childCount - 1 do
					local var_167_0 = arg_164_1.actors_["10094"].transform:GetChild(iter_167_0)

					if var_167_0.name == "" or not string.find(var_167_0.name, "split") then
						var_167_0.gameObject:SetActive(true)
					else
						var_167_0.gameObject:SetActive(false)
					end
				end
			end

			local var_167_1 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_1 then
				arg_164_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_164_1.time_ - 0) / var_167_1)
			end

			if arg_164_1.time_ >= 0 + var_167_1 and arg_164_1.time_ < 0 + var_167_1 + arg_167_0 then
				arg_164_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_167_2 = arg_164_1.actors_["10094"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10094 == nil then
				arg_164_1.var_.actorSpriteComps10094 = var_167_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_3 = 2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.actorSpriteComps10094 then
					for iter_167_1, iter_167_2 in pairs(arg_164_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_167_2 then
							if arg_164_1.isInRecall_ then
								iter_167_2.color = Color.New(Mathf.Lerp(iter_167_2.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_3), Mathf.Lerp(iter_167_2.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_3), (Mathf.Lerp(iter_167_2.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_3)))
							else
								local var_167_4 = Mathf.Lerp(iter_167_2.color.r, 1, (arg_164_1.time_ - 0) / var_167_3)

								iter_167_2.color = Color.New(var_167_4, var_167_4, var_167_4)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.actorSpriteComps10094 then
				for iter_167_3, iter_167_4 in pairs(arg_164_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_167_4 then
						iter_167_4.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps10094 = nil
			end

			local var_167_5 = 0
			local var_167_6 = 0.35

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(413022038)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 14 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 14)

				if (14 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 14)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022038", "story_v_out_413022.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022038", "story_v_out_413022.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_413022", "413022038", "story_v_out_413022.awb")

						arg_164_1:RecordAudio("413022038", var_167_12)
						arg_164_1:RecordAudio("413022038", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_413022", "413022038", "story_v_out_413022.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_413022", "413022038", "story_v_out_413022.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play413022039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 413022039
		arg_168_1.duration_ = 11.27

		local var_168_0 = {
			zh = 11.266,
			ja = 9.5
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play413022040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10097 = arg_168_1.actors_["10097"].transform.localPosition
				arg_168_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10097", 4)

				for iter_171_0 = 0, arg_168_1.actors_["10097"].transform.childCount - 1 do
					local var_171_0 = arg_168_1.actors_["10097"].transform:GetChild(iter_171_0)

					if var_171_0.name == "" or not string.find(var_171_0.name, "split") then
						var_171_0.gameObject:SetActive(true)
					else
						var_171_0.gameObject:SetActive(false)
					end
				end
			end

			local var_171_1 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				arg_168_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_168_1.time_ - 0) / var_171_1)
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 then
				arg_168_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_171_2 = arg_168_1.actors_["10094"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10094 = var_171_2.localPosition
				var_171_2.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10094", 2)

				for iter_171_1 = 0, var_171_2.childCount - 1 do
					local var_171_3 = var_171_2:GetChild(iter_171_1)

					if var_171_3.name == "" or not string.find(var_171_3.name, "split") then
						var_171_3.gameObject:SetActive(true)
					else
						var_171_3.gameObject:SetActive(false)
					end
				end
			end

			local var_171_4 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				var_171_2.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_168_1.time_ - 0) / var_171_4)
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				var_171_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_171_5 = arg_168_1.actors_["10097"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.actorSpriteComps10097 == nil then
				arg_168_1.var_.actorSpriteComps10097 = var_171_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_6 = 2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_6 and not isNil(var_171_5) then
				if arg_168_1.var_.actorSpriteComps10097 then
					for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_171_3 then
							if arg_168_1.isInRecall_ then
								iter_171_3.color = Color.New(Mathf.Lerp(iter_171_3.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_6), Mathf.Lerp(iter_171_3.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_6), (Mathf.Lerp(iter_171_3.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_6)))
							else
								local var_171_7 = Mathf.Lerp(iter_171_3.color.r, 1, (arg_168_1.time_ - 0) / var_171_6)

								iter_171_3.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_6 and arg_168_1.time_ < 0 + var_171_6 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.actorSpriteComps10097 then
				for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_171_5 then
						iter_171_5.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps10097 = nil
			end

			local var_171_8 = arg_168_1.actors_["10094"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10094 == nil then
				arg_168_1.var_.actorSpriteComps10094 = var_171_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_9 = 2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_9 and not isNil(var_171_8) then
				if arg_168_1.var_.actorSpriteComps10094 then
					for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_171_7 then
							if arg_168_1.isInRecall_ then
								iter_171_7.color = Color.New(Mathf.Lerp(iter_171_7.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_9), Mathf.Lerp(iter_171_7.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_9), (Mathf.Lerp(iter_171_7.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_9)))
							else
								local var_171_10 = Mathf.Lerp(iter_171_7.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_9)

								iter_171_7.color = Color.New(var_171_10, var_171_10, var_171_10)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_9 and arg_168_1.time_ < 0 + var_171_9 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10094 then
				for iter_171_8, iter_171_9 in pairs(arg_168_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_171_9 then
						iter_171_9.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps10094 = nil
			end

			local var_171_11 = 0
			local var_171_12 = 1.2

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_11 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_13 = arg_168_1:GetWordFromCfg(413022039)
				local var_171_14 = arg_168_1:FormatText(var_171_13.content)

				arg_168_1.text_.text = var_171_14

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_16 = 48 <= 0 and var_171_12 or var_171_12 * (utf8.len(var_171_14) / 48)

				if (48 <= 0 and var_171_12 or var_171_12 * (utf8.len(var_171_14) / 48)) > 0 and var_171_12 < var_171_16 then
					arg_168_1.talkMaxDuration = var_171_16

					if var_171_16 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_11
					end
				end

				arg_168_1.text_.text = var_171_14
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022039", "story_v_out_413022.awb") ~= 0 then
					local var_171_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022039", "story_v_out_413022.awb") / 1000

					if var_171_17 + var_171_11 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_17 + var_171_11
					end

					if var_171_13.prefab_name ~= "" and arg_168_1.actors_[var_171_13.prefab_name] ~= nil then
						local var_171_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_13.prefab_name].transform, "story_v_out_413022", "413022039", "story_v_out_413022.awb")

						arg_168_1:RecordAudio("413022039", var_171_18)
						arg_168_1:RecordAudio("413022039", var_171_18)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_413022", "413022039", "story_v_out_413022.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_413022", "413022039", "story_v_out_413022.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_19 = math.max(var_171_12, arg_168_1.talkMaxDuration)

			if var_171_11 <= arg_168_1.time_ and arg_168_1.time_ < var_171_11 + var_171_19 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_11) / var_171_19

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_11 + var_171_19 and arg_168_1.time_ < var_171_11 + var_171_19 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play413022040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 413022040
		arg_172_1.duration_ = 10.9

		local var_172_0 = {
			zh = 7.666,
			ja = 10.9
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
				arg_172_0:Play413022041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.85

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(413022040)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 34 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 34)

				if (34 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 34)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022040", "story_v_out_413022.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022040", "story_v_out_413022.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_413022", "413022040", "story_v_out_413022.awb")

						arg_172_1:RecordAudio("413022040", var_175_6)
						arg_172_1:RecordAudio("413022040", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_413022", "413022040", "story_v_out_413022.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_413022", "413022040", "story_v_out_413022.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play413022041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 413022041
		arg_176_1.duration_ = 3.43

		local var_176_0 = {
			zh = 2.166,
			ja = 3.433
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play413022042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10097 = arg_176_1.actors_["10097"].transform.localPosition
				arg_176_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10097", 4)

				for iter_179_0 = 0, arg_176_1.actors_["10097"].transform.childCount - 1 do
					local var_179_0 = arg_176_1.actors_["10097"].transform:GetChild(iter_179_0)

					if var_179_0.name == "" or not string.find(var_179_0.name, "split") then
						var_179_0.gameObject:SetActive(true)
					else
						var_179_0.gameObject:SetActive(false)
					end
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_176_1.time_ - 0) / var_179_1)
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_179_2 = arg_176_1.actors_["10094"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10094 = var_179_2.localPosition
				var_179_2.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10094", 2)

				for iter_179_1 = 0, var_179_2.childCount - 1 do
					local var_179_3 = var_179_2:GetChild(iter_179_1)

					if var_179_3.name == "" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				var_179_2.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_176_1.time_ - 0) / var_179_4)
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				var_179_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_179_5 = arg_176_1.actors_["10097"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_5) and arg_176_1.var_.actorSpriteComps10097 == nil then
				arg_176_1.var_.actorSpriteComps10097 = var_179_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_6 = 2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_6 and not isNil(var_179_5) then
				if arg_176_1.var_.actorSpriteComps10097 then
					for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_179_3 then
							if arg_176_1.isInRecall_ then
								iter_179_3.color = Color.New(Mathf.Lerp(iter_179_3.color.r, arg_176_1.hightColor2.r, (arg_176_1.time_ - 0) / var_179_6), Mathf.Lerp(iter_179_3.color.g, arg_176_1.hightColor2.g, (arg_176_1.time_ - 0) / var_179_6), (Mathf.Lerp(iter_179_3.color.b, arg_176_1.hightColor2.b, (arg_176_1.time_ - 0) / var_179_6)))
							else
								local var_179_7 = Mathf.Lerp(iter_179_3.color.r, 0.5, (arg_176_1.time_ - 0) / var_179_6)

								iter_179_3.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_6 and arg_176_1.time_ < 0 + var_179_6 + arg_179_0 and not isNil(var_179_5) and arg_176_1.var_.actorSpriteComps10097 then
				for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_179_5 then
						iter_179_5.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_176_1.var_.actorSpriteComps10097 = nil
			end

			local var_179_8 = arg_176_1.actors_["10094"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10094 == nil then
				arg_176_1.var_.actorSpriteComps10094 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_9 = 2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_9 and not isNil(var_179_8) then
				if arg_176_1.var_.actorSpriteComps10094 then
					for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_179_7 then
							if arg_176_1.isInRecall_ then
								iter_179_7.color = Color.New(Mathf.Lerp(iter_179_7.color.r, arg_176_1.hightColor1.r, (arg_176_1.time_ - 0) / var_179_9), Mathf.Lerp(iter_179_7.color.g, arg_176_1.hightColor1.g, (arg_176_1.time_ - 0) / var_179_9), (Mathf.Lerp(iter_179_7.color.b, arg_176_1.hightColor1.b, (arg_176_1.time_ - 0) / var_179_9)))
							else
								local var_179_10 = Mathf.Lerp(iter_179_7.color.r, 1, (arg_176_1.time_ - 0) / var_179_9)

								iter_179_7.color = Color.New(var_179_10, var_179_10, var_179_10)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= 0 + var_179_9 and arg_176_1.time_ < 0 + var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10094 then
				for iter_179_8, iter_179_9 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_179_9 then
						iter_179_9.color = arg_176_1.isInRecall_ and (arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_176_1.var_.actorSpriteComps10094 = nil
			end

			local var_179_11 = 0
			local var_179_12 = 0.275

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_13 = arg_176_1:GetWordFromCfg(413022041)
				local var_179_14 = arg_176_1:FormatText(var_179_13.content)

				arg_176_1.text_.text = var_179_14

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_16 = 11 <= 0 and var_179_12 or var_179_12 * (utf8.len(var_179_14) / 11)

				if (11 <= 0 and var_179_12 or var_179_12 * (utf8.len(var_179_14) / 11)) > 0 and var_179_12 < var_179_16 then
					arg_176_1.talkMaxDuration = var_179_16

					if var_179_16 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_16 + var_179_11
					end
				end

				arg_176_1.text_.text = var_179_14
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022041", "story_v_out_413022.awb") ~= 0 then
					local var_179_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022041", "story_v_out_413022.awb") / 1000

					if var_179_17 + var_179_11 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_17 + var_179_11
					end

					if var_179_13.prefab_name ~= "" and arg_176_1.actors_[var_179_13.prefab_name] ~= nil then
						local var_179_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_13.prefab_name].transform, "story_v_out_413022", "413022041", "story_v_out_413022.awb")

						arg_176_1:RecordAudio("413022041", var_179_18)
						arg_176_1:RecordAudio("413022041", var_179_18)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_413022", "413022041", "story_v_out_413022.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_413022", "413022041", "story_v_out_413022.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_19 = math.max(var_179_12, arg_176_1.talkMaxDuration)

			if var_179_11 <= arg_176_1.time_ and arg_176_1.time_ < var_179_11 + var_179_19 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_11) / var_179_19

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_11 + var_179_19 and arg_176_1.time_ < var_179_11 + var_179_19 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play413022042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 413022042
		arg_180_1.duration_ = 10.57

		local var_180_0 = {
			zh = 10.366,
			ja = 10.566
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play413022043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10097 = arg_180_1.actors_["10097"].transform.localPosition
				arg_180_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10097", 4)

				for iter_183_0 = 0, arg_180_1.actors_["10097"].transform.childCount - 1 do
					local var_183_0 = arg_180_1.actors_["10097"].transform:GetChild(iter_183_0)

					if var_183_0.name == "" or not string.find(var_183_0.name, "split") then
						var_183_0.gameObject:SetActive(true)
					else
						var_183_0.gameObject:SetActive(false)
					end
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_180_1.time_ - 0) / var_183_1)
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_183_2 = arg_180_1.actors_["10094"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10094 = var_183_2.localPosition
				var_183_2.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10094", 2)

				for iter_183_1 = 0, var_183_2.childCount - 1 do
					local var_183_3 = var_183_2:GetChild(iter_183_1)

					if var_183_3.name == "" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_2.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_180_1.time_ - 0) / var_183_4)
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_2.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_183_5 = arg_180_1.actors_["10097"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps10097 == nil then
				arg_180_1.var_.actorSpriteComps10097 = var_183_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_6 = 2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_6 and not isNil(var_183_5) then
				if arg_180_1.var_.actorSpriteComps10097 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								iter_183_3.color = Color.New(Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_6), Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_6), (Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_6)))
							else
								local var_183_7 = Mathf.Lerp(iter_183_3.color.r, 1, (arg_180_1.time_ - 0) / var_183_6)

								iter_183_3.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_6 and arg_180_1.time_ < 0 + var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.actorSpriteComps10097 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_183_5 then
						iter_183_5.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10097 = nil
			end

			local var_183_8 = arg_180_1.actors_["10094"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10094 == nil then
				arg_180_1.var_.actorSpriteComps10094 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_9 = 2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_9 and not isNil(var_183_8) then
				if arg_180_1.var_.actorSpriteComps10094 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								iter_183_7.color = Color.New(Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_9), Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_9), (Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_9)))
							else
								local var_183_10 = Mathf.Lerp(iter_183_7.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_9)

								iter_183_7.color = Color.New(var_183_10, var_183_10, var_183_10)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_9 and arg_180_1.time_ < 0 + var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10094 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_183_9 then
						iter_183_9.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10094 = nil
			end

			local var_183_11 = 0
			local var_183_12 = 0.925

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_13 = arg_180_1:GetWordFromCfg(413022042)
				local var_183_14 = arg_180_1:FormatText(var_183_13.content)

				arg_180_1.text_.text = var_183_14

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_16 = 37 <= 0 and var_183_12 or var_183_12 * (utf8.len(var_183_14) / 37)

				if (37 <= 0 and var_183_12 or var_183_12 * (utf8.len(var_183_14) / 37)) > 0 and var_183_12 < var_183_16 then
					arg_180_1.talkMaxDuration = var_183_16

					if var_183_16 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_11
					end
				end

				arg_180_1.text_.text = var_183_14
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022042", "story_v_out_413022.awb") ~= 0 then
					local var_183_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022042", "story_v_out_413022.awb") / 1000

					if var_183_17 + var_183_11 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_17 + var_183_11
					end

					if var_183_13.prefab_name ~= "" and arg_180_1.actors_[var_183_13.prefab_name] ~= nil then
						local var_183_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_13.prefab_name].transform, "story_v_out_413022", "413022042", "story_v_out_413022.awb")

						arg_180_1:RecordAudio("413022042", var_183_18)
						arg_180_1:RecordAudio("413022042", var_183_18)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_413022", "413022042", "story_v_out_413022.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_413022", "413022042", "story_v_out_413022.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_19 = math.max(var_183_12, arg_180_1.talkMaxDuration)

			if var_183_11 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_19 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_11) / var_183_19

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_11 + var_183_19 and arg_180_1.time_ < var_183_11 + var_183_19 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play413022043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 413022043
		arg_184_1.duration_ = 5.83

		local var_184_0 = {
			zh = 5.833,
			ja = 3.533
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
				arg_184_0:Play413022044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10097 = arg_184_1.actors_["10097"].transform.localPosition
				arg_184_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10097", 0)

				for iter_187_0 = 0, arg_184_1.actors_["10097"].transform.childCount - 1 do
					local var_187_0 = arg_184_1.actors_["10097"].transform:GetChild(iter_187_0)

					if var_187_0.name == "" or not string.find(var_187_0.name, "split") then
						var_187_0.gameObject:SetActive(true)
					else
						var_187_0.gameObject:SetActive(false)
					end
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_184_1.time_ - 0) / var_187_1)
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_187_2 = arg_184_1.actors_["10094"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10094 = var_187_2.localPosition
				var_187_2.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10094", 0)

				for iter_187_1 = 0, var_187_2.childCount - 1 do
					local var_187_3 = var_187_2:GetChild(iter_187_1)

					if var_187_3.name == "" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				var_187_2.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_184_1.time_ - 0) / var_187_4)
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				var_187_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_187_5 = arg_184_1.actors_["10022"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10022 = var_187_5.localPosition
				var_187_5.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10022", 3)

				for iter_187_2 = 0, var_187_5.childCount - 1 do
					local var_187_6 = var_187_5:GetChild(iter_187_2)

					if var_187_6.name == "split_6" or not string.find(var_187_6.name, "split") then
						var_187_6.gameObject:SetActive(true)
					else
						var_187_6.gameObject:SetActive(false)
					end
				end
			end

			local var_187_7 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				var_187_5.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_184_1.time_ - 0) / var_187_7)
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				var_187_5.localPosition = Vector3.New(0, -315, -320)
			end

			local var_187_8 = arg_184_1.actors_["10097"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10097 == nil then
				arg_184_1.var_.actorSpriteComps10097 = var_187_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_9 = 2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_9 and not isNil(var_187_8) then
				if arg_184_1.var_.actorSpriteComps10097 then
					for iter_187_3, iter_187_4 in pairs(arg_184_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_187_4 then
							if arg_184_1.isInRecall_ then
								iter_187_4.color = Color.New(Mathf.Lerp(iter_187_4.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_9), Mathf.Lerp(iter_187_4.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_9), (Mathf.Lerp(iter_187_4.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_9)))
							else
								local var_187_10 = Mathf.Lerp(iter_187_4.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_9)

								iter_187_4.color = Color.New(var_187_10, var_187_10, var_187_10)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_9 and arg_184_1.time_ < 0 + var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10097 then
				for iter_187_5, iter_187_6 in pairs(arg_184_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_187_6 then
						iter_187_6.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10097 = nil
			end

			local var_187_11 = arg_184_1.actors_["10094"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.actorSpriteComps10094 == nil then
				arg_184_1.var_.actorSpriteComps10094 = var_187_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_12 = 2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_12 and not isNil(var_187_11) then
				if arg_184_1.var_.actorSpriteComps10094 then
					for iter_187_7, iter_187_8 in pairs(arg_184_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_187_8 then
							if arg_184_1.isInRecall_ then
								iter_187_8.color = Color.New(Mathf.Lerp(iter_187_8.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_12), Mathf.Lerp(iter_187_8.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_12), (Mathf.Lerp(iter_187_8.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_12)))
							else
								local var_187_13 = Mathf.Lerp(iter_187_8.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_12)

								iter_187_8.color = Color.New(var_187_13, var_187_13, var_187_13)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_12 and arg_184_1.time_ < 0 + var_187_12 + arg_187_0 and not isNil(var_187_11) and arg_184_1.var_.actorSpriteComps10094 then
				for iter_187_9, iter_187_10 in pairs(arg_184_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_187_10 then
						iter_187_10.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps10094 = nil
			end

			local var_187_14 = arg_184_1.actors_["10022"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_14) and arg_184_1.var_.actorSpriteComps10022 == nil then
				arg_184_1.var_.actorSpriteComps10022 = var_187_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_15 = 2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_15 and not isNil(var_187_14) then
				if arg_184_1.var_.actorSpriteComps10022 then
					for iter_187_11, iter_187_12 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_187_12 then
							if arg_184_1.isInRecall_ then
								iter_187_12.color = Color.New(Mathf.Lerp(iter_187_12.color.r, arg_184_1.hightColor1.r, (arg_184_1.time_ - 0) / var_187_15), Mathf.Lerp(iter_187_12.color.g, arg_184_1.hightColor1.g, (arg_184_1.time_ - 0) / var_187_15), (Mathf.Lerp(iter_187_12.color.b, arg_184_1.hightColor1.b, (arg_184_1.time_ - 0) / var_187_15)))
							else
								local var_187_16 = Mathf.Lerp(iter_187_12.color.r, 1, (arg_184_1.time_ - 0) / var_187_15)

								iter_187_12.color = Color.New(var_187_16, var_187_16, var_187_16)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_15 and arg_184_1.time_ < 0 + var_187_15 + arg_187_0 and not isNil(var_187_14) and arg_184_1.var_.actorSpriteComps10022 then
				for iter_187_13, iter_187_14 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_187_14 then
						iter_187_14.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_184_1.var_.actorSpriteComps10022 = nil
			end

			local var_187_17 = 0
			local var_187_18 = 0.825

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_19 = arg_184_1:GetWordFromCfg(413022043)
				local var_187_20 = arg_184_1:FormatText(var_187_19.content)

				arg_184_1.text_.text = var_187_20

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_22 = 33 <= 0 and var_187_18 or var_187_18 * (utf8.len(var_187_20) / 33)

				if (33 <= 0 and var_187_18 or var_187_18 * (utf8.len(var_187_20) / 33)) > 0 and var_187_18 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_17
					end
				end

				arg_184_1.text_.text = var_187_20
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022043", "story_v_out_413022.awb") ~= 0 then
					local var_187_23 = manager.audio:GetVoiceLength("story_v_out_413022", "413022043", "story_v_out_413022.awb") / 1000

					if var_187_23 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_17
					end

					if var_187_19.prefab_name ~= "" and arg_184_1.actors_[var_187_19.prefab_name] ~= nil then
						local var_187_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_19.prefab_name].transform, "story_v_out_413022", "413022043", "story_v_out_413022.awb")

						arg_184_1:RecordAudio("413022043", var_187_24)
						arg_184_1:RecordAudio("413022043", var_187_24)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_413022", "413022043", "story_v_out_413022.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_413022", "413022043", "story_v_out_413022.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_25 = math.max(var_187_18, arg_184_1.talkMaxDuration)

			if var_187_17 <= arg_184_1.time_ and arg_184_1.time_ < var_187_17 + var_187_25 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_17) / var_187_25

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_17 + var_187_25 and arg_184_1.time_ < var_187_17 + var_187_25 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413022044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 413022044
		arg_188_1.duration_ = 7.47

		local var_188_0 = {
			zh = 6.466,
			ja = 7.466
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play413022045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10097 = arg_188_1.actors_["10097"].transform.localPosition
				arg_188_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10097", 3)

				for iter_191_0 = 0, arg_188_1.actors_["10097"].transform.childCount - 1 do
					local var_191_0 = arg_188_1.actors_["10097"].transform:GetChild(iter_191_0)

					if var_191_0.name == "" or not string.find(var_191_0.name, "split") then
						var_191_0.gameObject:SetActive(true)
					else
						var_191_0.gameObject:SetActive(false)
					end
				end
			end

			local var_191_1 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 then
				arg_188_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_188_1.time_ - 0) / var_191_1)
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 then
				arg_188_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_191_2 = arg_188_1.actors_["10022"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10022 = var_191_2.localPosition
				var_191_2.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10022", 0)

				for iter_191_1 = 0, var_191_2.childCount - 1 do
					local var_191_3 = var_191_2:GetChild(iter_191_1)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_2.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_188_1.time_ - 0) / var_191_4)
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_191_5 = arg_188_1.actors_["10097"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.actorSpriteComps10097 == nil then
				arg_188_1.var_.actorSpriteComps10097 = var_191_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_6 = 2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_6 and not isNil(var_191_5) then
				if arg_188_1.var_.actorSpriteComps10097 then
					for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_191_3 then
							if arg_188_1.isInRecall_ then
								iter_191_3.color = Color.New(Mathf.Lerp(iter_191_3.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_6), Mathf.Lerp(iter_191_3.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_6), (Mathf.Lerp(iter_191_3.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_6)))
							else
								local var_191_7 = Mathf.Lerp(iter_191_3.color.r, 1, (arg_188_1.time_ - 0) / var_191_6)

								iter_191_3.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_6 and arg_188_1.time_ < 0 + var_191_6 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.actorSpriteComps10097 then
				for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_191_5 then
						iter_191_5.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps10097 = nil
			end

			local var_191_8 = arg_188_1.actors_["10022"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10022 == nil then
				arg_188_1.var_.actorSpriteComps10022 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_9 = 2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_9 and not isNil(var_191_8) then
				if arg_188_1.var_.actorSpriteComps10022 then
					for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_191_7 then
							if arg_188_1.isInRecall_ then
								iter_191_7.color = Color.New(Mathf.Lerp(iter_191_7.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_9), Mathf.Lerp(iter_191_7.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_9), (Mathf.Lerp(iter_191_7.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_9)))
							else
								local var_191_10 = Mathf.Lerp(iter_191_7.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_9)

								iter_191_7.color = Color.New(var_191_10, var_191_10, var_191_10)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_9 and arg_188_1.time_ < 0 + var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10022 then
				for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_191_9 then
						iter_191_9.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10022 = nil
			end

			local var_191_11 = 0
			local var_191_12 = 0.75

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(413022044)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 30 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 30)

				if (30 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 30)) > 0 and var_191_12 < var_191_16 then
					arg_188_1.talkMaxDuration = var_191_16

					if var_191_16 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022044", "story_v_out_413022.awb") ~= 0 then
					local var_191_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022044", "story_v_out_413022.awb") / 1000

					if var_191_17 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_11
					end

					if var_191_13.prefab_name ~= "" and arg_188_1.actors_[var_191_13.prefab_name] ~= nil then
						local var_191_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_13.prefab_name].transform, "story_v_out_413022", "413022044", "story_v_out_413022.awb")

						arg_188_1:RecordAudio("413022044", var_191_18)
						arg_188_1:RecordAudio("413022044", var_191_18)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_413022", "413022044", "story_v_out_413022.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_413022", "413022044", "story_v_out_413022.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_19 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_19 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_19

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_19 and arg_188_1.time_ < var_191_11 + var_191_19 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
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
	Play413022045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413022045
		arg_192_1.duration_ = 8.87

		local var_192_0 = {
			zh = 5.7,
			ja = 8.866
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play413022046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10022 = arg_192_1.actors_["10022"].transform.localPosition
				arg_192_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10022", 2)

				for iter_195_0 = 0, arg_192_1.actors_["10022"].transform.childCount - 1 do
					local var_195_0 = arg_192_1.actors_["10022"].transform:GetChild(iter_195_0)

					if var_195_0.name == "split_6" or not string.find(var_195_0.name, "split") then
						var_195_0.gameObject:SetActive(true)
					else
						var_195_0.gameObject:SetActive(false)
					end
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_192_1.time_ - 0) / var_195_1)
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_195_2 = arg_192_1.actors_["10097"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10097 = var_195_2.localPosition
				var_195_2.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10097", 4)

				for iter_195_1 = 0, var_195_2.childCount - 1 do
					local var_195_3 = var_195_2:GetChild(iter_195_1)

					if var_195_3.name == "" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				var_195_2.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_192_1.time_ - 0) / var_195_4)
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_195_5 = arg_192_1.actors_["10022"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_5) and arg_192_1.var_.actorSpriteComps10022 == nil then
				arg_192_1.var_.actorSpriteComps10022 = var_195_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_6 = 2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_6 and not isNil(var_195_5) then
				if arg_192_1.var_.actorSpriteComps10022 then
					for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_195_3 then
							if arg_192_1.isInRecall_ then
								iter_195_3.color = Color.New(Mathf.Lerp(iter_195_3.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_6), Mathf.Lerp(iter_195_3.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_6), (Mathf.Lerp(iter_195_3.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_6)))
							else
								local var_195_7 = Mathf.Lerp(iter_195_3.color.r, 1, (arg_192_1.time_ - 0) / var_195_6)

								iter_195_3.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_6 and arg_192_1.time_ < 0 + var_195_6 + arg_195_0 and not isNil(var_195_5) and arg_192_1.var_.actorSpriteComps10022 then
				for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_195_5 then
						iter_195_5.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10022 = nil
			end

			local var_195_8 = arg_192_1.actors_["10097"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10097 == nil then
				arg_192_1.var_.actorSpriteComps10097 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_9 = 2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_9 and not isNil(var_195_8) then
				if arg_192_1.var_.actorSpriteComps10097 then
					for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_195_7 then
							if arg_192_1.isInRecall_ then
								iter_195_7.color = Color.New(Mathf.Lerp(iter_195_7.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_9), Mathf.Lerp(iter_195_7.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_9), (Mathf.Lerp(iter_195_7.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_9)))
							else
								local var_195_10 = Mathf.Lerp(iter_195_7.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_9)

								iter_195_7.color = Color.New(var_195_10, var_195_10, var_195_10)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_9 and arg_192_1.time_ < 0 + var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10097 then
				for iter_195_8, iter_195_9 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_195_9 then
						iter_195_9.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10097 = nil
			end

			local var_195_11 = 0
			local var_195_12 = 0.8

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_13 = arg_192_1:GetWordFromCfg(413022045)
				local var_195_14 = arg_192_1:FormatText(var_195_13.content)

				arg_192_1.text_.text = var_195_14

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_16 = 33 <= 0 and var_195_12 or var_195_12 * (utf8.len(var_195_14) / 33)

				if (33 <= 0 and var_195_12 or var_195_12 * (utf8.len(var_195_14) / 33)) > 0 and var_195_12 < var_195_16 then
					arg_192_1.talkMaxDuration = var_195_16

					if var_195_16 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_16 + var_195_11
					end
				end

				arg_192_1.text_.text = var_195_14
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022045", "story_v_out_413022.awb") ~= 0 then
					local var_195_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022045", "story_v_out_413022.awb") / 1000

					if var_195_17 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_11
					end

					if var_195_13.prefab_name ~= "" and arg_192_1.actors_[var_195_13.prefab_name] ~= nil then
						local var_195_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_13.prefab_name].transform, "story_v_out_413022", "413022045", "story_v_out_413022.awb")

						arg_192_1:RecordAudio("413022045", var_195_18)
						arg_192_1:RecordAudio("413022045", var_195_18)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413022", "413022045", "story_v_out_413022.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413022", "413022045", "story_v_out_413022.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_19 = math.max(var_195_12, arg_192_1.talkMaxDuration)

			if var_195_11 <= arg_192_1.time_ and arg_192_1.time_ < var_195_11 + var_195_19 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_11) / var_195_19

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_11 + var_195_19 and arg_192_1.time_ < var_195_11 + var_195_19 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413022046
		arg_196_1.duration_ = 3.93

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_196_0:Play413022047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10097 = arg_196_1.actors_["10097"].transform.localPosition
				arg_196_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10097", 4)

				for iter_199_0 = 0, arg_196_1.actors_["10097"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["10097"].transform:GetChild(iter_199_0)

					if var_199_0.name == "" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_199_2 = arg_196_1.actors_["10022"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10022 == nil then
				arg_196_1.var_.actorSpriteComps10022 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10022 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								iter_199_2.color = Color.New(Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_2.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_2.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10022 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_199_4 then
						iter_199_4.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps10022 = nil
			end

			local var_199_5 = arg_196_1.actors_["10097"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.actorSpriteComps10097 == nil then
				arg_196_1.var_.actorSpriteComps10097 = var_199_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_6 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_6 and not isNil(var_199_5) then
				if arg_196_1.var_.actorSpriteComps10097 then
					for iter_199_5, iter_199_6 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_199_6 then
							if arg_196_1.isInRecall_ then
								iter_199_6.color = Color.New(Mathf.Lerp(iter_199_6.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_6), Mathf.Lerp(iter_199_6.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_6), (Mathf.Lerp(iter_199_6.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_6)))
							else
								local var_199_7 = Mathf.Lerp(iter_199_6.color.r, 1, (arg_196_1.time_ - 0) / var_199_6)

								iter_199_6.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_6 and arg_196_1.time_ < 0 + var_199_6 + arg_199_0 and not isNil(var_199_5) and arg_196_1.var_.actorSpriteComps10097 then
				for iter_199_7, iter_199_8 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_199_8 then
						iter_199_8.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10097 = nil
			end

			local var_199_8 = 0
			local var_199_9 = 0.125

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(413022046)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_13 = 5 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 5)

				if (5 <= 0 and var_199_9 or var_199_9 * (utf8.len(var_199_11) / 5)) > 0 and var_199_9 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_8
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022046", "story_v_out_413022.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022046", "story_v_out_413022.awb") / 1000

					if var_199_14 + var_199_8 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_8
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_413022", "413022046", "story_v_out_413022.awb")

						arg_196_1:RecordAudio("413022046", var_199_15)
						arg_196_1:RecordAudio("413022046", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413022", "413022046", "story_v_out_413022.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413022", "413022046", "story_v_out_413022.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_9, arg_196_1.talkMaxDuration)

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_8) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_8 + var_199_16 and arg_196_1.time_ < var_199_8 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413022047
		arg_200_1.duration_ = 10.9

		local var_200_0 = {
			zh = 5.066,
			ja = 10.9
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413022048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10022 = arg_200_1.actors_["10022"].transform.localPosition
				arg_200_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10022", 0)

				for iter_203_0 = 0, arg_200_1.actors_["10022"].transform.childCount - 1 do
					local var_203_0 = arg_200_1.actors_["10022"].transform:GetChild(iter_203_0)

					if var_203_0.name == "" or not string.find(var_203_0.name, "split") then
						var_203_0.gameObject:SetActive(true)
					else
						var_203_0.gameObject:SetActive(false)
					end
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_200_1.time_ - 0) / var_203_1)
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_203_2 = arg_200_1.actors_["10097"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10097 = var_203_2.localPosition
				var_203_2.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10097", 0)

				for iter_203_1 = 0, var_203_2.childCount - 1 do
					local var_203_3 = var_203_2:GetChild(iter_203_1)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				var_203_2.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_200_1.time_ - 0) / var_203_4)
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				var_203_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_203_5 = arg_200_1.actors_["10092"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10092 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10092", 3)

				for iter_203_2 = 0, var_203_5.childCount - 1 do
					local var_203_6 = var_203_5:GetChild(iter_203_2)

					if var_203_6.name == "" or not string.find(var_203_6.name, "split") then
						var_203_6.gameObject:SetActive(true)
					else
						var_203_6.gameObject:SetActive(false)
					end
				end
			end

			local var_203_7 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_200_1.time_ - 0) / var_203_7)
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_203_8 = arg_200_1.actors_["10022"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10022 == nil then
				arg_200_1.var_.actorSpriteComps10022 = var_203_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_9 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_9 and not isNil(var_203_8) then
				if arg_200_1.var_.actorSpriteComps10022 then
					for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_203_4 then
							if arg_200_1.isInRecall_ then
								iter_203_4.color = Color.New(Mathf.Lerp(iter_203_4.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_9), Mathf.Lerp(iter_203_4.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_9), (Mathf.Lerp(iter_203_4.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_9)))
							else
								local var_203_10 = Mathf.Lerp(iter_203_4.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_9)

								iter_203_4.color = Color.New(var_203_10, var_203_10, var_203_10)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_9 and arg_200_1.time_ < 0 + var_203_9 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps10022 then
				for iter_203_5, iter_203_6 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_203_6 then
						iter_203_6.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10022 = nil
			end

			local var_203_11 = arg_200_1.actors_["10097"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.actorSpriteComps10097 == nil then
				arg_200_1.var_.actorSpriteComps10097 = var_203_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_12 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_12 and not isNil(var_203_11) then
				if arg_200_1.var_.actorSpriteComps10097 then
					for iter_203_7, iter_203_8 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_203_8 then
							if arg_200_1.isInRecall_ then
								iter_203_8.color = Color.New(Mathf.Lerp(iter_203_8.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_12), Mathf.Lerp(iter_203_8.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_12), (Mathf.Lerp(iter_203_8.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_12)))
							else
								local var_203_13 = Mathf.Lerp(iter_203_8.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_12)

								iter_203_8.color = Color.New(var_203_13, var_203_13, var_203_13)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_12 and arg_200_1.time_ < 0 + var_203_12 + arg_203_0 and not isNil(var_203_11) and arg_200_1.var_.actorSpriteComps10097 then
				for iter_203_9, iter_203_10 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_203_10 then
						iter_203_10.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10097 = nil
			end

			local var_203_14 = arg_200_1.actors_["10092"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_14) and arg_200_1.var_.actorSpriteComps10092 == nil then
				arg_200_1.var_.actorSpriteComps10092 = var_203_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_15 = 2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_15 and not isNil(var_203_14) then
				if arg_200_1.var_.actorSpriteComps10092 then
					for iter_203_11, iter_203_12 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_203_12 then
							if arg_200_1.isInRecall_ then
								iter_203_12.color = Color.New(Mathf.Lerp(iter_203_12.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_15), Mathf.Lerp(iter_203_12.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_15), (Mathf.Lerp(iter_203_12.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_15)))
							else
								local var_203_16 = Mathf.Lerp(iter_203_12.color.r, 1, (arg_200_1.time_ - 0) / var_203_15)

								iter_203_12.color = Color.New(var_203_16, var_203_16, var_203_16)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_15 and arg_200_1.time_ < 0 + var_203_15 + arg_203_0 and not isNil(var_203_14) and arg_200_1.var_.actorSpriteComps10092 then
				for iter_203_13, iter_203_14 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_203_14 then
						iter_203_14.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				local var_203_17 = arg_200_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_203_17 then
					arg_200_1.var_.alphaOldValue10092 = var_203_17.alpha
					arg_200_1.var_.characterEffect10092 = var_203_17
				end

				arg_200_1.var_.alphaOldValue10092 = 0
			end

			local var_203_18 = 0.0166666666666667

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_18 then
				if arg_200_1.var_.characterEffect10092 then
					arg_200_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_200_1.var_.alphaOldValue10092, 1, (arg_200_1.time_ - 0) / var_203_18)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_18 and arg_200_1.time_ < 0 + var_203_18 + arg_203_0 and arg_200_1.var_.characterEffect10092 then
				arg_200_1.var_.characterEffect10092.alpha = 1
			end

			local var_203_19 = 0
			local var_203_20 = 0.65

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_19 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_21 = arg_200_1:GetWordFromCfg(413022047)
				local var_203_22 = arg_200_1:FormatText(var_203_21.content)

				arg_200_1.text_.text = var_203_22

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_24 = 26 <= 0 and var_203_20 or var_203_20 * (utf8.len(var_203_22) / 26)

				if (26 <= 0 and var_203_20 or var_203_20 * (utf8.len(var_203_22) / 26)) > 0 and var_203_20 < var_203_24 then
					arg_200_1.talkMaxDuration = var_203_24

					if var_203_24 + var_203_19 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_24 + var_203_19
					end
				end

				arg_200_1.text_.text = var_203_22
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022047", "story_v_out_413022.awb") ~= 0 then
					local var_203_25 = manager.audio:GetVoiceLength("story_v_out_413022", "413022047", "story_v_out_413022.awb") / 1000

					if var_203_25 + var_203_19 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_25 + var_203_19
					end

					if var_203_21.prefab_name ~= "" and arg_200_1.actors_[var_203_21.prefab_name] ~= nil then
						local var_203_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_21.prefab_name].transform, "story_v_out_413022", "413022047", "story_v_out_413022.awb")

						arg_200_1:RecordAudio("413022047", var_203_26)
						arg_200_1:RecordAudio("413022047", var_203_26)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_413022", "413022047", "story_v_out_413022.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_413022", "413022047", "story_v_out_413022.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_27 = math.max(var_203_20, arg_200_1.talkMaxDuration)

			if var_203_19 <= arg_200_1.time_ and arg_200_1.time_ < var_203_19 + var_203_27 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_19) / var_203_27

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_19 + var_203_27 and arg_200_1.time_ < var_203_19 + var_203_27 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play413022048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413022048
		arg_204_1.duration_ = 9.73

		local var_204_0 = {
			zh = 3.533,
			ja = 9.733
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413022049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10094 = arg_204_1.actors_["10094"].transform.localPosition
				arg_204_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10094", 3)

				for iter_207_0 = 0, arg_204_1.actors_["10094"].transform.childCount - 1 do
					local var_207_0 = arg_204_1.actors_["10094"].transform:GetChild(iter_207_0)

					if var_207_0.name == "" or not string.find(var_207_0.name, "split") then
						var_207_0.gameObject:SetActive(true)
					else
						var_207_0.gameObject:SetActive(false)
					end
				end
			end

			local var_207_1 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_1 then
				arg_204_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_204_1.time_ - 0) / var_207_1)
			end

			if arg_204_1.time_ >= 0 + var_207_1 and arg_204_1.time_ < 0 + var_207_1 + arg_207_0 then
				arg_204_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_207_2 = arg_204_1.actors_["10092"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10092 = var_207_2.localPosition
				var_207_2.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10092", 0)

				for iter_207_1 = 0, var_207_2.childCount - 1 do
					local var_207_3 = var_207_2:GetChild(iter_207_1)

					if var_207_3.name == "" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				var_207_2.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10092, Vector3.New(-1500, -350, -180), (arg_204_1.time_ - 0) / var_207_4)
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				var_207_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_207_5 = arg_204_1.actors_["10094"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_5) and arg_204_1.var_.actorSpriteComps10094 == nil then
				arg_204_1.var_.actorSpriteComps10094 = var_207_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_6 = 2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_6 and not isNil(var_207_5) then
				if arg_204_1.var_.actorSpriteComps10094 then
					for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_207_3 then
							if arg_204_1.isInRecall_ then
								iter_207_3.color = Color.New(Mathf.Lerp(iter_207_3.color.r, arg_204_1.hightColor1.r, (arg_204_1.time_ - 0) / var_207_6), Mathf.Lerp(iter_207_3.color.g, arg_204_1.hightColor1.g, (arg_204_1.time_ - 0) / var_207_6), (Mathf.Lerp(iter_207_3.color.b, arg_204_1.hightColor1.b, (arg_204_1.time_ - 0) / var_207_6)))
							else
								local var_207_7 = Mathf.Lerp(iter_207_3.color.r, 1, (arg_204_1.time_ - 0) / var_207_6)

								iter_207_3.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_6 and arg_204_1.time_ < 0 + var_207_6 + arg_207_0 and not isNil(var_207_5) and arg_204_1.var_.actorSpriteComps10094 then
				for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_207_5 then
						iter_207_5.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_204_1.var_.actorSpriteComps10094 = nil
			end

			local var_207_8 = arg_204_1.actors_["10092"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps10092 == nil then
				arg_204_1.var_.actorSpriteComps10092 = var_207_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_9 = 2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_9 and not isNil(var_207_8) then
				if arg_204_1.var_.actorSpriteComps10092 then
					for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_207_7 then
							if arg_204_1.isInRecall_ then
								iter_207_7.color = Color.New(Mathf.Lerp(iter_207_7.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_9), Mathf.Lerp(iter_207_7.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_9), (Mathf.Lerp(iter_207_7.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_9)))
							else
								local var_207_10 = Mathf.Lerp(iter_207_7.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_9)

								iter_207_7.color = Color.New(var_207_10, var_207_10, var_207_10)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_9 and arg_204_1.time_ < 0 + var_207_9 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps10092 then
				for iter_207_8, iter_207_9 in pairs(arg_204_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_207_9 then
						iter_207_9.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10092 = nil
			end

			local var_207_11 = 0
			local var_207_12 = 0.425

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_13 = arg_204_1:GetWordFromCfg(413022048)
				local var_207_14 = arg_204_1:FormatText(var_207_13.content)

				arg_204_1.text_.text = var_207_14

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_16 = 17 <= 0 and var_207_12 or var_207_12 * (utf8.len(var_207_14) / 17)

				if (17 <= 0 and var_207_12 or var_207_12 * (utf8.len(var_207_14) / 17)) > 0 and var_207_12 < var_207_16 then
					arg_204_1.talkMaxDuration = var_207_16

					if var_207_16 + var_207_11 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_11
					end
				end

				arg_204_1.text_.text = var_207_14
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022048", "story_v_out_413022.awb") ~= 0 then
					local var_207_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022048", "story_v_out_413022.awb") / 1000

					if var_207_17 + var_207_11 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_17 + var_207_11
					end

					if var_207_13.prefab_name ~= "" and arg_204_1.actors_[var_207_13.prefab_name] ~= nil then
						local var_207_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_13.prefab_name].transform, "story_v_out_413022", "413022048", "story_v_out_413022.awb")

						arg_204_1:RecordAudio("413022048", var_207_18)
						arg_204_1:RecordAudio("413022048", var_207_18)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_413022", "413022048", "story_v_out_413022.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_413022", "413022048", "story_v_out_413022.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_19 = math.max(var_207_12, arg_204_1.talkMaxDuration)

			if var_207_11 <= arg_204_1.time_ and arg_204_1.time_ < var_207_11 + var_207_19 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_11) / var_207_19

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_11 + var_207_19 and arg_204_1.time_ < var_207_11 + var_207_19 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play413022049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413022049
		arg_208_1.duration_ = 13.27

		local var_208_0 = {
			zh = 12.333,
			ja = 13.266
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play413022050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10097 = arg_208_1.actors_["10097"].transform.localPosition
				arg_208_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10097", 3)

				for iter_211_0 = 0, arg_208_1.actors_["10097"].transform.childCount - 1 do
					local var_211_0 = arg_208_1.actors_["10097"].transform:GetChild(iter_211_0)

					if var_211_0.name == "" or not string.find(var_211_0.name, "split") then
						var_211_0.gameObject:SetActive(true)
					else
						var_211_0.gameObject:SetActive(false)
					end
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_208_1.time_ - 0) / var_211_1)
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_211_2 = arg_208_1.actors_["10094"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10094 = var_211_2.localPosition
				var_211_2.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10094", 0)

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
				var_211_2.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10094, Vector3.New(-5000, -340, -414), (arg_208_1.time_ - 0) / var_211_4)
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				var_211_2.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_211_5 = arg_208_1.actors_["10097"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_5) and arg_208_1.var_.actorSpriteComps10097 == nil then
				arg_208_1.var_.actorSpriteComps10097 = var_211_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_6 = 2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_6 and not isNil(var_211_5) then
				if arg_208_1.var_.actorSpriteComps10097 then
					for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_211_3 then
							if arg_208_1.isInRecall_ then
								iter_211_3.color = Color.New(Mathf.Lerp(iter_211_3.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_6), Mathf.Lerp(iter_211_3.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_6), (Mathf.Lerp(iter_211_3.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_6)))
							else
								local var_211_7 = Mathf.Lerp(iter_211_3.color.r, 1, (arg_208_1.time_ - 0) / var_211_6)

								iter_211_3.color = Color.New(var_211_7, var_211_7, var_211_7)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_6 and arg_208_1.time_ < 0 + var_211_6 + arg_211_0 and not isNil(var_211_5) and arg_208_1.var_.actorSpriteComps10097 then
				for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_211_5 then
						iter_211_5.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps10097 = nil
			end

			local var_211_8 = arg_208_1.actors_["10094"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps10094 == nil then
				arg_208_1.var_.actorSpriteComps10094 = var_211_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_9 = 2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_9 and not isNil(var_211_8) then
				if arg_208_1.var_.actorSpriteComps10094 then
					for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_211_7 then
							if arg_208_1.isInRecall_ then
								iter_211_7.color = Color.New(Mathf.Lerp(iter_211_7.color.r, arg_208_1.hightColor2.r, (arg_208_1.time_ - 0) / var_211_9), Mathf.Lerp(iter_211_7.color.g, arg_208_1.hightColor2.g, (arg_208_1.time_ - 0) / var_211_9), (Mathf.Lerp(iter_211_7.color.b, arg_208_1.hightColor2.b, (arg_208_1.time_ - 0) / var_211_9)))
							else
								local var_211_10 = Mathf.Lerp(iter_211_7.color.r, 0.5, (arg_208_1.time_ - 0) / var_211_9)

								iter_211_7.color = Color.New(var_211_10, var_211_10, var_211_10)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_9 and arg_208_1.time_ < 0 + var_211_9 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps10094 then
				for iter_211_8, iter_211_9 in pairs(arg_208_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_211_9 then
						iter_211_9.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_208_1.var_.actorSpriteComps10094 = nil
			end

			local var_211_11 = 0
			local var_211_12 = 1.075

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_13 = arg_208_1:GetWordFromCfg(413022049)
				local var_211_14 = arg_208_1:FormatText(var_211_13.content)

				arg_208_1.text_.text = var_211_14

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_16 = 43 <= 0 and var_211_12 or var_211_12 * (utf8.len(var_211_14) / 43)

				if (43 <= 0 and var_211_12 or var_211_12 * (utf8.len(var_211_14) / 43)) > 0 and var_211_12 < var_211_16 then
					arg_208_1.talkMaxDuration = var_211_16

					if var_211_16 + var_211_11 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_11
					end
				end

				arg_208_1.text_.text = var_211_14
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022049", "story_v_out_413022.awb") ~= 0 then
					local var_211_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022049", "story_v_out_413022.awb") / 1000

					if var_211_17 + var_211_11 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_11
					end

					if var_211_13.prefab_name ~= "" and arg_208_1.actors_[var_211_13.prefab_name] ~= nil then
						local var_211_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_13.prefab_name].transform, "story_v_out_413022", "413022049", "story_v_out_413022.awb")

						arg_208_1:RecordAudio("413022049", var_211_18)
						arg_208_1:RecordAudio("413022049", var_211_18)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413022", "413022049", "story_v_out_413022.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413022", "413022049", "story_v_out_413022.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_19 = math.max(var_211_12, arg_208_1.talkMaxDuration)

			if var_211_11 <= arg_208_1.time_ and arg_208_1.time_ < var_211_11 + var_211_19 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_11) / var_211_19

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_11 + var_211_19 and arg_208_1.time_ < var_211_11 + var_211_19 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413022050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413022050
		arg_212_1.duration_ = 12.97

		local var_212_0 = {
			zh = 8.233,
			ja = 12.966
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
				arg_212_0:Play413022051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.85

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(413022050)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 34 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 34)

				if (34 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 34)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022050", "story_v_out_413022.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022050", "story_v_out_413022.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_413022", "413022050", "story_v_out_413022.awb")

						arg_212_1:RecordAudio("413022050", var_215_6)
						arg_212_1:RecordAudio("413022050", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413022", "413022050", "story_v_out_413022.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413022", "413022050", "story_v_out_413022.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play413022051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413022051
		arg_216_1.duration_ = 11.33

		local var_216_0 = {
			zh = 8.6,
			ja = 11.333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play413022052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.875

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:GetWordFromCfg(413022051)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 35 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 35)

				if (35 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 35)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022051", "story_v_out_413022.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022051", "story_v_out_413022.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_413022", "413022051", "story_v_out_413022.awb")

						arg_216_1:RecordAudio("413022051", var_219_6)
						arg_216_1:RecordAudio("413022051", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413022", "413022051", "story_v_out_413022.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413022", "413022051", "story_v_out_413022.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play413022052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413022052
		arg_220_1.duration_ = 13.2

		local var_220_0 = {
			zh = 9.133,
			ja = 13.2
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
				arg_220_0:Play413022053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10022 = arg_220_1.actors_["10022"].transform.localPosition
				arg_220_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10022", 2)

				for iter_223_0 = 0, arg_220_1.actors_["10022"].transform.childCount - 1 do
					local var_223_0 = arg_220_1.actors_["10022"].transform:GetChild(iter_223_0)

					if var_223_0.name == "" or not string.find(var_223_0.name, "split") then
						var_223_0.gameObject:SetActive(true)
					else
						var_223_0.gameObject:SetActive(false)
					end
				end
			end

			local var_223_1 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 then
				arg_220_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_220_1.time_ - 0) / var_223_1)
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 then
				arg_220_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_223_2 = arg_220_1.actors_["10097"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10097 = var_223_2.localPosition
				var_223_2.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10097", 4)

				for iter_223_1 = 0, var_223_2.childCount - 1 do
					local var_223_3 = var_223_2:GetChild(iter_223_1)

					if var_223_3.name == "" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				var_223_2.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_220_1.time_ - 0) / var_223_4)
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				var_223_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_223_5 = arg_220_1.actors_["10022"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_6 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_6 and not isNil(var_223_5) then
				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_3 then
							if arg_220_1.isInRecall_ then
								iter_223_3.color = Color.New(Mathf.Lerp(iter_223_3.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_6), Mathf.Lerp(iter_223_3.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_6), (Mathf.Lerp(iter_223_3.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_6)))
							else
								local var_223_7 = Mathf.Lerp(iter_223_3.color.r, 1, (arg_220_1.time_ - 0) / var_223_6)

								iter_223_3.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_6 and arg_220_1.time_ < 0 + var_223_6 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_5 then
						iter_223_5.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_8 = arg_220_1.actors_["10097"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_8) and arg_220_1.var_.actorSpriteComps10097 == nil then
				arg_220_1.var_.actorSpriteComps10097 = var_223_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_9 = 2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_9 and not isNil(var_223_8) then
				if arg_220_1.var_.actorSpriteComps10097 then
					for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_223_7 then
							if arg_220_1.isInRecall_ then
								iter_223_7.color = Color.New(Mathf.Lerp(iter_223_7.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 0) / var_223_9), Mathf.Lerp(iter_223_7.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 0) / var_223_9), (Mathf.Lerp(iter_223_7.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 0) / var_223_9)))
							else
								local var_223_10 = Mathf.Lerp(iter_223_7.color.r, 0.5, (arg_220_1.time_ - 0) / var_223_9)

								iter_223_7.color = Color.New(var_223_10, var_223_10, var_223_10)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_9 and arg_220_1.time_ < 0 + var_223_9 + arg_223_0 and not isNil(var_223_8) and arg_220_1.var_.actorSpriteComps10097 then
				for iter_223_8, iter_223_9 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_223_9 then
						iter_223_9.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10097 = nil
			end

			local var_223_11 = 0
			local var_223_12 = 1.25

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_13 = arg_220_1:GetWordFromCfg(413022052)
				local var_223_14 = arg_220_1:FormatText(var_223_13.content)

				arg_220_1.text_.text = var_223_14

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_16 = 50 <= 0 and var_223_12 or var_223_12 * (utf8.len(var_223_14) / 50)

				if (50 <= 0 and var_223_12 or var_223_12 * (utf8.len(var_223_14) / 50)) > 0 and var_223_12 < var_223_16 then
					arg_220_1.talkMaxDuration = var_223_16

					if var_223_16 + var_223_11 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_16 + var_223_11
					end
				end

				arg_220_1.text_.text = var_223_14
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022052", "story_v_out_413022.awb") ~= 0 then
					local var_223_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022052", "story_v_out_413022.awb") / 1000

					if var_223_17 + var_223_11 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_17 + var_223_11
					end

					if var_223_13.prefab_name ~= "" and arg_220_1.actors_[var_223_13.prefab_name] ~= nil then
						local var_223_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_13.prefab_name].transform, "story_v_out_413022", "413022052", "story_v_out_413022.awb")

						arg_220_1:RecordAudio("413022052", var_223_18)
						arg_220_1:RecordAudio("413022052", var_223_18)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413022", "413022052", "story_v_out_413022.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413022", "413022052", "story_v_out_413022.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_19 = math.max(var_223_12, arg_220_1.talkMaxDuration)

			if var_223_11 <= arg_220_1.time_ and arg_220_1.time_ < var_223_11 + var_223_19 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_11) / var_223_19

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_11 + var_223_19 and arg_220_1.time_ < var_223_11 + var_223_19 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413022053
		arg_224_1.duration_ = 11.4

		local var_224_0 = {
			zh = 9.866,
			ja = 11.4
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play413022054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10097 = arg_224_1.actors_["10097"].transform.localPosition
				arg_224_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10097", 4)

				for iter_227_0 = 0, arg_224_1.actors_["10097"].transform.childCount - 1 do
					local var_227_0 = arg_224_1.actors_["10097"].transform:GetChild(iter_227_0)

					if var_227_0.name == "" or not string.find(var_227_0.name, "split") then
						var_227_0.gameObject:SetActive(true)
					else
						var_227_0.gameObject:SetActive(false)
					end
				end
			end

			local var_227_1 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 then
				arg_224_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_224_1.time_ - 0) / var_227_1)
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 then
				arg_224_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_227_2 = arg_224_1.actors_["10022"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10022 == nil then
				arg_224_1.var_.actorSpriteComps10022 = var_227_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_3 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_3 and not isNil(var_227_2) then
				if arg_224_1.var_.actorSpriteComps10022 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								iter_227_2.color = Color.New(Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_3), Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_3), (Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_3)))
							else
								local var_227_4 = Mathf.Lerp(iter_227_2.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_3)

								iter_227_2.color = Color.New(var_227_4, var_227_4, var_227_4)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_3 and arg_224_1.time_ < 0 + var_227_3 + arg_227_0 and not isNil(var_227_2) and arg_224_1.var_.actorSpriteComps10022 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_227_4 then
						iter_227_4.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10022 = nil
			end

			local var_227_5 = arg_224_1.actors_["10097"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.actorSpriteComps10097 == nil then
				arg_224_1.var_.actorSpriteComps10097 = var_227_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_6 = 2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.actorSpriteComps10097 then
					for iter_227_5, iter_227_6 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_227_6 then
							if arg_224_1.isInRecall_ then
								iter_227_6.color = Color.New(Mathf.Lerp(iter_227_6.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_6), Mathf.Lerp(iter_227_6.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_6), (Mathf.Lerp(iter_227_6.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_6)))
							else
								local var_227_7 = Mathf.Lerp(iter_227_6.color.r, 1, (arg_224_1.time_ - 0) / var_227_6)

								iter_227_6.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.actorSpriteComps10097 then
				for iter_227_7, iter_227_8 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_227_8 then
						iter_227_8.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10097 = nil
			end

			local var_227_8 = 0
			local var_227_9 = 0.75

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_10 = arg_224_1:GetWordFromCfg(413022053)
				local var_227_11 = arg_224_1:FormatText(var_227_10.content)

				arg_224_1.text_.text = var_227_11

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 30 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 30)

				if (30 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 30)) > 0 and var_227_9 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_11
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022053", "story_v_out_413022.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022053", "story_v_out_413022.awb") / 1000

					if var_227_14 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_8
					end

					if var_227_10.prefab_name ~= "" and arg_224_1.actors_[var_227_10.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_10.prefab_name].transform, "story_v_out_413022", "413022053", "story_v_out_413022.awb")

						arg_224_1:RecordAudio("413022053", var_227_15)
						arg_224_1:RecordAudio("413022053", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413022", "413022053", "story_v_out_413022.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413022", "413022053", "story_v_out_413022.awb")
				end

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

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play413022054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413022054
		arg_228_1.duration_ = 4.1

		local var_228_0 = {
			zh = 2.4,
			ja = 4.1
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
				arg_228_0:Play413022055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10022 = arg_228_1.actors_["10022"].transform.localPosition
				arg_228_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10022", 0)

				for iter_231_0 = 0, arg_228_1.actors_["10022"].transform.childCount - 1 do
					local var_231_0 = arg_228_1.actors_["10022"].transform:GetChild(iter_231_0)

					if var_231_0.name == "" or not string.find(var_231_0.name, "split") then
						var_231_0.gameObject:SetActive(true)
					else
						var_231_0.gameObject:SetActive(false)
					end
				end
			end

			local var_231_1 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_1 then
				arg_228_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10022, Vector3.New(-1500, -350, -180), (arg_228_1.time_ - 0) / var_231_1)
			end

			if arg_228_1.time_ >= 0 + var_231_1 and arg_228_1.time_ < 0 + var_231_1 + arg_231_0 then
				arg_228_1.actors_["10022"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_2 = arg_228_1.actors_["10097"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10097 = var_231_2.localPosition
				var_231_2.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10097", 0)

				for iter_231_1 = 0, var_231_2.childCount - 1 do
					local var_231_3 = var_231_2:GetChild(iter_231_1)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				var_231_2.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_228_1.time_ - 0) / var_231_4)
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				var_231_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_5 = arg_228_1.actors_["10092"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10092 = var_231_5.localPosition
				var_231_5.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10092", 3)

				for iter_231_2 = 0, var_231_5.childCount - 1 do
					local var_231_6 = var_231_5:GetChild(iter_231_2)

					if var_231_6.name == "split_5" or not string.find(var_231_6.name, "split") then
						var_231_6.gameObject:SetActive(true)
					else
						var_231_6.gameObject:SetActive(false)
					end
				end
			end

			local var_231_7 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				var_231_5.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10092, Vector3.New(0, -350, -180), (arg_228_1.time_ - 0) / var_231_7)
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				var_231_5.localPosition = Vector3.New(0, -350, -180)
			end

			local var_231_8 = arg_228_1.actors_["10022"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_9 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_9 and not isNil(var_231_8) then
				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_4 then
							if arg_228_1.isInRecall_ then
								iter_231_4.color = Color.New(Mathf.Lerp(iter_231_4.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_9), Mathf.Lerp(iter_231_4.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_9), (Mathf.Lerp(iter_231_4.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_9)))
							else
								local var_231_10 = Mathf.Lerp(iter_231_4.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_9)

								iter_231_4.color = Color.New(var_231_10, var_231_10, var_231_10)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_9 and arg_228_1.time_ < 0 + var_231_9 + arg_231_0 and not isNil(var_231_8) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_6 then
						iter_231_6.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_11 = arg_228_1.actors_["10097"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.actorSpriteComps10097 == nil then
				arg_228_1.var_.actorSpriteComps10097 = var_231_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_12 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_12 and not isNil(var_231_11) then
				if arg_228_1.var_.actorSpriteComps10097 then
					for iter_231_7, iter_231_8 in pairs(arg_228_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_231_8 then
							if arg_228_1.isInRecall_ then
								iter_231_8.color = Color.New(Mathf.Lerp(iter_231_8.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_12), Mathf.Lerp(iter_231_8.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_12), (Mathf.Lerp(iter_231_8.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_12)))
							else
								local var_231_13 = Mathf.Lerp(iter_231_8.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_12)

								iter_231_8.color = Color.New(var_231_13, var_231_13, var_231_13)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_12 and arg_228_1.time_ < 0 + var_231_12 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.actorSpriteComps10097 then
				for iter_231_9, iter_231_10 in pairs(arg_228_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_231_10 then
						iter_231_10.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10097 = nil
			end

			local var_231_14 = arg_228_1.actors_["10092"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_14) and arg_228_1.var_.actorSpriteComps10092 == nil then
				arg_228_1.var_.actorSpriteComps10092 = var_231_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_15 = 2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_15 and not isNil(var_231_14) then
				if arg_228_1.var_.actorSpriteComps10092 then
					for iter_231_11, iter_231_12 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_231_12 then
							if arg_228_1.isInRecall_ then
								iter_231_12.color = Color.New(Mathf.Lerp(iter_231_12.color.r, arg_228_1.hightColor1.r, (arg_228_1.time_ - 0) / var_231_15), Mathf.Lerp(iter_231_12.color.g, arg_228_1.hightColor1.g, (arg_228_1.time_ - 0) / var_231_15), (Mathf.Lerp(iter_231_12.color.b, arg_228_1.hightColor1.b, (arg_228_1.time_ - 0) / var_231_15)))
							else
								local var_231_16 = Mathf.Lerp(iter_231_12.color.r, 1, (arg_228_1.time_ - 0) / var_231_15)

								iter_231_12.color = Color.New(var_231_16, var_231_16, var_231_16)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_15 and arg_228_1.time_ < 0 + var_231_15 + arg_231_0 and not isNil(var_231_14) and arg_228_1.var_.actorSpriteComps10092 then
				for iter_231_13, iter_231_14 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_231_14 then
						iter_231_14.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_228_1.var_.actorSpriteComps10092 = nil
			end

			local var_231_17 = 0
			local var_231_18 = 0.275

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_17 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(413022054)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_22 = 11 <= 0 and var_231_18 or var_231_18 * (utf8.len(var_231_20) / 11)

				if (11 <= 0 and var_231_18 or var_231_18 * (utf8.len(var_231_20) / 11)) > 0 and var_231_18 < var_231_22 then
					arg_228_1.talkMaxDuration = var_231_22

					if var_231_22 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_22 + var_231_17
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022054", "story_v_out_413022.awb") ~= 0 then
					local var_231_23 = manager.audio:GetVoiceLength("story_v_out_413022", "413022054", "story_v_out_413022.awb") / 1000

					if var_231_23 + var_231_17 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_17
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_413022", "413022054", "story_v_out_413022.awb")

						arg_228_1:RecordAudio("413022054", var_231_24)
						arg_228_1:RecordAudio("413022054", var_231_24)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413022", "413022054", "story_v_out_413022.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413022", "413022054", "story_v_out_413022.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_25 = math.max(var_231_18, arg_228_1.talkMaxDuration)

			if var_231_17 <= arg_228_1.time_ and arg_228_1.time_ < var_231_17 + var_231_25 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_17) / var_231_25

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_17 + var_231_25 and arg_228_1.time_ < var_231_17 + var_231_25 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play413022055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413022055
		arg_232_1.duration_ = 8.1

		local var_232_0 = {
			zh = 6.133,
			ja = 8.1
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
				arg_232_0:Play413022056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = arg_232_1.actors_["10022"].transform.localPosition
				arg_232_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 3)

				for iter_235_0 = 0, arg_232_1.actors_["10022"].transform.childCount - 1 do
					local var_235_0 = arg_232_1.actors_["10022"].transform:GetChild(iter_235_0)

					if var_235_0.name == "split_3" or not string.find(var_235_0.name, "split") then
						var_235_0.gameObject:SetActive(true)
					else
						var_235_0.gameObject:SetActive(false)
					end
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_232_1.time_ - 0) / var_235_1)
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_235_2 = arg_232_1.actors_["10092"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10092 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10092", 7)

				for iter_235_1 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_1)

					if var_235_3.name == "" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_235_5 = arg_232_1.actors_["10022"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_6 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_6 and not isNil(var_235_5) then
				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								iter_235_3.color = Color.New(Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_6), Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_6), (Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_6)))
							else
								local var_235_7 = Mathf.Lerp(iter_235_3.color.r, 1, (arg_232_1.time_ - 0) / var_235_6)

								iter_235_3.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_6 and arg_232_1.time_ < 0 + var_235_6 + arg_235_0 and not isNil(var_235_5) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_5 then
						iter_235_5.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_8 = arg_232_1.actors_["10092"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10092 == nil then
				arg_232_1.var_.actorSpriteComps10092 = var_235_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_9 = 2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 and not isNil(var_235_8) then
				if arg_232_1.var_.actorSpriteComps10092 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								iter_235_7.color = Color.New(Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor2.r, (arg_232_1.time_ - 0) / var_235_9), Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor2.g, (arg_232_1.time_ - 0) / var_235_9), (Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor2.b, (arg_232_1.time_ - 0) / var_235_9)))
							else
								local var_235_10 = Mathf.Lerp(iter_235_7.color.r, 0.5, (arg_232_1.time_ - 0) / var_235_9)

								iter_235_7.color = Color.New(var_235_10, var_235_10, var_235_10)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 and not isNil(var_235_8) and arg_232_1.var_.actorSpriteComps10092 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_235_9 then
						iter_235_9.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_232_1.var_.actorSpriteComps10092 = nil
			end

			local var_235_11 = 0
			local var_235_12 = 0.85

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_11 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_13 = arg_232_1:GetWordFromCfg(413022055)
				local var_235_14 = arg_232_1:FormatText(var_235_13.content)

				arg_232_1.text_.text = var_235_14

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_16 = 34 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 34)

				if (34 <= 0 and var_235_12 or var_235_12 * (utf8.len(var_235_14) / 34)) > 0 and var_235_12 < var_235_16 then
					arg_232_1.talkMaxDuration = var_235_16

					if var_235_16 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_11
					end
				end

				arg_232_1.text_.text = var_235_14
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022055", "story_v_out_413022.awb") ~= 0 then
					local var_235_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022055", "story_v_out_413022.awb") / 1000

					if var_235_17 + var_235_11 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_17 + var_235_11
					end

					if var_235_13.prefab_name ~= "" and arg_232_1.actors_[var_235_13.prefab_name] ~= nil then
						local var_235_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_13.prefab_name].transform, "story_v_out_413022", "413022055", "story_v_out_413022.awb")

						arg_232_1:RecordAudio("413022055", var_235_18)
						arg_232_1:RecordAudio("413022055", var_235_18)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413022", "413022055", "story_v_out_413022.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413022", "413022055", "story_v_out_413022.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_19 = math.max(var_235_12, arg_232_1.talkMaxDuration)

			if var_235_11 <= arg_232_1.time_ and arg_232_1.time_ < var_235_11 + var_235_19 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_11) / var_235_19

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_11 + var_235_19 and arg_232_1.time_ < var_235_11 + var_235_19 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413022056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413022056
		arg_236_1.duration_ = 13.6

		local var_236_0 = {
			zh = 13.6,
			ja = 12.4
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413022057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10097 = arg_236_1.actors_["10097"].transform.localPosition
				arg_236_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10097", 3)

				for iter_239_0 = 0, arg_236_1.actors_["10097"].transform.childCount - 1 do
					local var_239_0 = arg_236_1.actors_["10097"].transform:GetChild(iter_239_0)

					if var_239_0.name == "split_2" or not string.find(var_239_0.name, "split") then
						var_239_0.gameObject:SetActive(true)
					else
						var_239_0.gameObject:SetActive(false)
					end
				end
			end

			local var_239_1 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_236_1.time_ - 0) / var_239_1)
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_239_2 = arg_236_1.actors_["10097"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10097 == nil then
				arg_236_1.var_.actorSpriteComps10097 = var_239_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_3 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.actorSpriteComps10097 then
					for iter_239_1, iter_239_2 in pairs(arg_236_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_239_2 then
							if arg_236_1.isInRecall_ then
								iter_239_2.color = Color.New(Mathf.Lerp(iter_239_2.color.r, arg_236_1.hightColor1.r, (arg_236_1.time_ - 0) / var_239_3), Mathf.Lerp(iter_239_2.color.g, arg_236_1.hightColor1.g, (arg_236_1.time_ - 0) / var_239_3), (Mathf.Lerp(iter_239_2.color.b, arg_236_1.hightColor1.b, (arg_236_1.time_ - 0) / var_239_3)))
							else
								local var_239_4 = Mathf.Lerp(iter_239_2.color.r, 1, (arg_236_1.time_ - 0) / var_239_3)

								iter_239_2.color = Color.New(var_239_4, var_239_4, var_239_4)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.actorSpriteComps10097 then
				for iter_239_3, iter_239_4 in pairs(arg_236_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_239_4 then
						iter_239_4.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_236_1.var_.actorSpriteComps10097 = nil
			end

			local var_239_5 = arg_236_1.actors_["10022"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_5) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_6 = 2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_6 and not isNil(var_239_5) then
				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_5, iter_239_6 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_6 then
							if arg_236_1.isInRecall_ then
								iter_239_6.color = Color.New(Mathf.Lerp(iter_239_6.color.r, arg_236_1.hightColor2.r, (arg_236_1.time_ - 0) / var_239_6), Mathf.Lerp(iter_239_6.color.g, arg_236_1.hightColor2.g, (arg_236_1.time_ - 0) / var_239_6), (Mathf.Lerp(iter_239_6.color.b, arg_236_1.hightColor2.b, (arg_236_1.time_ - 0) / var_239_6)))
							else
								local var_239_7 = Mathf.Lerp(iter_239_6.color.r, 0.5, (arg_236_1.time_ - 0) / var_239_6)

								iter_239_6.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= 0 + var_239_6 and arg_236_1.time_ < 0 + var_239_6 + arg_239_0 and not isNil(var_239_5) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_7, iter_239_8 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_8 then
						iter_239_8.color = arg_236_1.isInRecall_ and (arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_8 = 0
			local var_239_9 = 1.35

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_10 = arg_236_1:GetWordFromCfg(413022056)
				local var_239_11 = arg_236_1:FormatText(var_239_10.content)

				arg_236_1.text_.text = var_239_11

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_13 = 54 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 54)

				if (54 <= 0 and var_239_9 or var_239_9 * (utf8.len(var_239_11) / 54)) > 0 and var_239_9 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_8
					end
				end

				arg_236_1.text_.text = var_239_11
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022056", "story_v_out_413022.awb") ~= 0 then
					local var_239_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022056", "story_v_out_413022.awb") / 1000

					if var_239_14 + var_239_8 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_14 + var_239_8
					end

					if var_239_10.prefab_name ~= "" and arg_236_1.actors_[var_239_10.prefab_name] ~= nil then
						local var_239_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_10.prefab_name].transform, "story_v_out_413022", "413022056", "story_v_out_413022.awb")

						arg_236_1:RecordAudio("413022056", var_239_15)
						arg_236_1:RecordAudio("413022056", var_239_15)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413022", "413022056", "story_v_out_413022.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413022", "413022056", "story_v_out_413022.awb")
				end

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

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play413022057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413022057
		arg_240_1.duration_ = 11.93

		local var_240_0 = {
			zh = 6.366,
			ja = 11.933
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413022058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10092"]) and arg_240_1.var_.actorSpriteComps10092 == nil then
				arg_240_1.var_.actorSpriteComps10092 = arg_240_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10092"]) then
				if arg_240_1.var_.actorSpriteComps10092 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								iter_243_1.color = Color.New(Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_0), Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_0), (Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_0)))
							else
								local var_243_1 = Mathf.Lerp(iter_243_1.color.r, 1, (arg_240_1.time_ - 0) / var_243_0)

								iter_243_1.color = Color.New(var_243_1, var_243_1, var_243_1)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10092"]) and arg_240_1.var_.actorSpriteComps10092 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10092 = nil
			end

			local var_243_2 = arg_240_1.actors_["10097"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10097 == nil then
				arg_240_1.var_.actorSpriteComps10097 = var_243_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_3 = 2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.actorSpriteComps10097 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								iter_243_5.color = Color.New(Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, (arg_240_1.time_ - 0) / var_243_3), Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, (arg_240_1.time_ - 0) / var_243_3), (Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, (arg_240_1.time_ - 0) / var_243_3)))
							else
								local var_243_4 = Mathf.Lerp(iter_243_5.color.r, 0.5, (arg_240_1.time_ - 0) / var_243_3)

								iter_243_5.color = Color.New(var_243_4, var_243_4, var_243_4)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10097 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_243_7 then
						iter_243_7.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_240_1.var_.actorSpriteComps10097 = nil
			end

			local var_243_5 = arg_240_1.actors_["10097"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10097 = var_243_5.localPosition
				var_243_5.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10097", 4)

				for iter_243_8 = 0, var_243_5.childCount - 1 do
					local var_243_6 = var_243_5:GetChild(iter_243_8)

					if var_243_6.name == "split_2" or not string.find(var_243_6.name, "split") then
						var_243_6.gameObject:SetActive(true)
					else
						var_243_6.gameObject:SetActive(false)
					end
				end
			end

			local var_243_7 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				var_243_5.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_240_1.time_ - 0) / var_243_7)
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				var_243_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_243_8 = arg_240_1.actors_["10092"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10092 = var_243_8.localPosition
				var_243_8.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10092", 2)

				for iter_243_9 = 0, var_243_8.childCount - 1 do
					local var_243_9 = var_243_8:GetChild(iter_243_9)

					if var_243_9.name == "split_1_1" or not string.find(var_243_9.name, "split") then
						var_243_9.gameObject:SetActive(true)
					else
						var_243_9.gameObject:SetActive(false)
					end
				end
			end

			local var_243_10 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_10 then
				var_243_8.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_240_1.time_ - 0) / var_243_10)
			end

			if arg_240_1.time_ >= 0 + var_243_10 and arg_240_1.time_ < 0 + var_243_10 + arg_243_0 then
				var_243_8.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_243_11 = 0
			local var_243_12 = 0.9

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_11 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_13 = arg_240_1:GetWordFromCfg(413022057)
				local var_243_14 = arg_240_1:FormatText(var_243_13.content)

				arg_240_1.text_.text = var_243_14

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_16 = 36 <= 0 and var_243_12 or var_243_12 * (utf8.len(var_243_14) / 36)

				if (36 <= 0 and var_243_12 or var_243_12 * (utf8.len(var_243_14) / 36)) > 0 and var_243_12 < var_243_16 then
					arg_240_1.talkMaxDuration = var_243_16

					if var_243_16 + var_243_11 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_16 + var_243_11
					end
				end

				arg_240_1.text_.text = var_243_14
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022057", "story_v_out_413022.awb") ~= 0 then
					local var_243_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022057", "story_v_out_413022.awb") / 1000

					if var_243_17 + var_243_11 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_17 + var_243_11
					end

					if var_243_13.prefab_name ~= "" and arg_240_1.actors_[var_243_13.prefab_name] ~= nil then
						local var_243_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_13.prefab_name].transform, "story_v_out_413022", "413022057", "story_v_out_413022.awb")

						arg_240_1:RecordAudio("413022057", var_243_18)
						arg_240_1:RecordAudio("413022057", var_243_18)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413022", "413022057", "story_v_out_413022.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413022", "413022057", "story_v_out_413022.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_19 = math.max(var_243_12, arg_240_1.talkMaxDuration)

			if var_243_11 <= arg_240_1.time_ and arg_240_1.time_ < var_243_11 + var_243_19 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_11) / var_243_19

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_11 + var_243_19 and arg_240_1.time_ < var_243_11 + var_243_19 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play413022058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413022058
		arg_244_1.duration_ = 13.5

		local var_244_0 = {
			zh = 13.5,
			ja = 11.133
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
				arg_244_0:Play413022059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10097"]) and arg_244_1.var_.actorSpriteComps10097 == nil then
				arg_244_1.var_.actorSpriteComps10097 = arg_244_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_0 = 2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10097"]) then
				if arg_244_1.var_.actorSpriteComps10097 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 0) / var_247_0), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 0) / var_247_0), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 0) / var_247_0)))
							else
								local var_247_1 = Mathf.Lerp(iter_247_1.color.r, 1, (arg_244_1.time_ - 0) / var_247_0)

								iter_247_1.color = Color.New(var_247_1, var_247_1, var_247_1)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10097"]) and arg_244_1.var_.actorSpriteComps10097 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps10097 = nil
			end

			local var_247_2 = arg_244_1.actors_["10092"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10092 == nil then
				arg_244_1.var_.actorSpriteComps10092 = var_247_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_3 = 2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_3 and not isNil(var_247_2) then
				if arg_244_1.var_.actorSpriteComps10092 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								iter_247_5.color = Color.New(Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_3), Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_3), (Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_3)))
							else
								local var_247_4 = Mathf.Lerp(iter_247_5.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_3)

								iter_247_5.color = Color.New(var_247_4, var_247_4, var_247_4)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_3 and arg_244_1.time_ < 0 + var_247_3 + arg_247_0 and not isNil(var_247_2) and arg_244_1.var_.actorSpriteComps10092 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_247_7 then
						iter_247_7.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10092 = nil
			end

			local var_247_5 = 0
			local var_247_6 = 0.825

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:GetWordFromCfg(413022058)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_10 = 33 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 33)

				if (33 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 33)) > 0 and var_247_6 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022058", "story_v_out_413022.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022058", "story_v_out_413022.awb") / 1000

					if var_247_11 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_5
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_413022", "413022058", "story_v_out_413022.awb")

						arg_244_1:RecordAudio("413022058", var_247_12)
						arg_244_1:RecordAudio("413022058", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_413022", "413022058", "story_v_out_413022.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_413022", "413022058", "story_v_out_413022.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_13 and arg_244_1.time_ < var_247_5 + var_247_13 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play413022059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 413022059
		arg_248_1.duration_ = 20.67

		local var_248_0 = {
			zh = 10.866,
			ja = 20.666
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play413022060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.025

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(413022059)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 41 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 41)

				if (41 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 41)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022059", "story_v_out_413022.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022059", "story_v_out_413022.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_413022", "413022059", "story_v_out_413022.awb")

						arg_248_1:RecordAudio("413022059", var_251_6)
						arg_248_1:RecordAudio("413022059", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_413022", "413022059", "story_v_out_413022.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_413022", "413022059", "story_v_out_413022.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play413022060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 413022060
		arg_252_1.duration_ = 18.03

		local var_252_0 = {
			zh = 8.166,
			ja = 18.033
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
				arg_252_0:Play413022061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10092"]) and arg_252_1.var_.actorSpriteComps10092 == nil then
				arg_252_1.var_.actorSpriteComps10092 = arg_252_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10092"]) then
				if arg_252_1.var_.actorSpriteComps10092 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 1, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10092"]) and arg_252_1.var_.actorSpriteComps10092 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps10092 = nil
			end

			local var_255_2 = arg_252_1.actors_["10097"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10097 == nil then
				arg_252_1.var_.actorSpriteComps10097 = var_255_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_3 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_3 and not isNil(var_255_2) then
				if arg_252_1.var_.actorSpriteComps10097 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								iter_255_5.color = Color.New(Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, (arg_252_1.time_ - 0) / var_255_3), Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, (arg_252_1.time_ - 0) / var_255_3), (Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, (arg_252_1.time_ - 0) / var_255_3)))
							else
								local var_255_4 = Mathf.Lerp(iter_255_5.color.r, 0.5, (arg_252_1.time_ - 0) / var_255_3)

								iter_255_5.color = Color.New(var_255_4, var_255_4, var_255_4)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_3 and arg_252_1.time_ < 0 + var_255_3 + arg_255_0 and not isNil(var_255_2) and arg_252_1.var_.actorSpriteComps10097 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_255_7 then
						iter_255_7.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_252_1.var_.actorSpriteComps10097 = nil
			end

			local var_255_5 = arg_252_1.actors_["10092"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10092 = var_255_5.localPosition
				var_255_5.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10092", 2)

				for iter_255_8 = 0, var_255_5.childCount - 1 do
					local var_255_6 = var_255_5:GetChild(iter_255_8)

					if var_255_6.name == "split_8" or not string.find(var_255_6.name, "split") then
						var_255_6.gameObject:SetActive(true)
					else
						var_255_6.gameObject:SetActive(false)
					end
				end
			end

			local var_255_7 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				var_255_5.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_252_1.time_ - 0) / var_255_7)
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				var_255_5.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_255_8 = 0
			local var_255_9 = 0.825

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:GetWordFromCfg(413022060)
				local var_255_11 = arg_252_1:FormatText(var_255_10.content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 33 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 33)

				if (33 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 33)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022060", "story_v_out_413022.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022060", "story_v_out_413022.awb") / 1000

					if var_255_14 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_8
					end

					if var_255_10.prefab_name ~= "" and arg_252_1.actors_[var_255_10.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_10.prefab_name].transform, "story_v_out_413022", "413022060", "story_v_out_413022.awb")

						arg_252_1:RecordAudio("413022060", var_255_15)
						arg_252_1:RecordAudio("413022060", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_413022", "413022060", "story_v_out_413022.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_413022", "413022060", "story_v_out_413022.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play413022061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 413022061
		arg_256_1.duration_ = 5.03

		local var_256_0 = {
			zh = 5.033,
			ja = 3.3
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play413022062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos10097 = arg_256_1.actors_["10097"].transform.localPosition
				arg_256_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10097", 4)

				for iter_259_0 = 0, arg_256_1.actors_["10097"].transform.childCount - 1 do
					local var_259_0 = arg_256_1.actors_["10097"].transform:GetChild(iter_259_0)

					if var_259_0.name == "split_4" or not string.find(var_259_0.name, "split") then
						var_259_0.gameObject:SetActive(true)
					else
						var_259_0.gameObject:SetActive(false)
					end
				end
			end

			local var_259_1 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_1 then
				arg_256_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_256_1.time_ - 0) / var_259_1)
			end

			if arg_256_1.time_ >= 0 + var_259_1 and arg_256_1.time_ < 0 + var_259_1 + arg_259_0 then
				arg_256_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_259_2 = arg_256_1.actors_["10097"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10097 == nil then
				arg_256_1.var_.actorSpriteComps10097 = var_259_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_3 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 and not isNil(var_259_2) then
				if arg_256_1.var_.actorSpriteComps10097 then
					for iter_259_1, iter_259_2 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_259_2 then
							if arg_256_1.isInRecall_ then
								iter_259_2.color = Color.New(Mathf.Lerp(iter_259_2.color.r, arg_256_1.hightColor1.r, (arg_256_1.time_ - 0) / var_259_3), Mathf.Lerp(iter_259_2.color.g, arg_256_1.hightColor1.g, (arg_256_1.time_ - 0) / var_259_3), (Mathf.Lerp(iter_259_2.color.b, arg_256_1.hightColor1.b, (arg_256_1.time_ - 0) / var_259_3)))
							else
								local var_259_4 = Mathf.Lerp(iter_259_2.color.r, 1, (arg_256_1.time_ - 0) / var_259_3)

								iter_259_2.color = Color.New(var_259_4, var_259_4, var_259_4)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 and not isNil(var_259_2) and arg_256_1.var_.actorSpriteComps10097 then
				for iter_259_3, iter_259_4 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_259_4 then
						iter_259_4.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_256_1.var_.actorSpriteComps10097 = nil
			end

			local var_259_5 = arg_256_1.actors_["10092"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_5) and arg_256_1.var_.actorSpriteComps10092 == nil then
				arg_256_1.var_.actorSpriteComps10092 = var_259_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_6 = 2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_6 and not isNil(var_259_5) then
				if arg_256_1.var_.actorSpriteComps10092 then
					for iter_259_5, iter_259_6 in pairs(arg_256_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_259_6 then
							if arg_256_1.isInRecall_ then
								iter_259_6.color = Color.New(Mathf.Lerp(iter_259_6.color.r, arg_256_1.hightColor2.r, (arg_256_1.time_ - 0) / var_259_6), Mathf.Lerp(iter_259_6.color.g, arg_256_1.hightColor2.g, (arg_256_1.time_ - 0) / var_259_6), (Mathf.Lerp(iter_259_6.color.b, arg_256_1.hightColor2.b, (arg_256_1.time_ - 0) / var_259_6)))
							else
								local var_259_7 = Mathf.Lerp(iter_259_6.color.r, 0.5, (arg_256_1.time_ - 0) / var_259_6)

								iter_259_6.color = Color.New(var_259_7, var_259_7, var_259_7)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_6 and arg_256_1.time_ < 0 + var_259_6 + arg_259_0 and not isNil(var_259_5) and arg_256_1.var_.actorSpriteComps10092 then
				for iter_259_7, iter_259_8 in pairs(arg_256_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_259_8 then
						iter_259_8.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_256_1.var_.actorSpriteComps10092 = nil
			end

			if 1.16666666666667 < arg_256_1.time_ and arg_256_1.time_ <= 1.16666666666667 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_table", "")
			end

			local var_259_9 = 0
			local var_259_10 = 0.425

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_11 = arg_256_1:GetWordFromCfg(413022061)
				local var_259_12 = arg_256_1:FormatText(var_259_11.content)

				arg_256_1.text_.text = var_259_12

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_14 = 17 <= 0 and var_259_10 or var_259_10 * (utf8.len(var_259_12) / 17)

				if (17 <= 0 and var_259_10 or var_259_10 * (utf8.len(var_259_12) / 17)) > 0 and var_259_10 < var_259_14 then
					arg_256_1.talkMaxDuration = var_259_14

					if var_259_14 + var_259_9 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_9
					end
				end

				arg_256_1.text_.text = var_259_12
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022061", "story_v_out_413022.awb") ~= 0 then
					local var_259_15 = manager.audio:GetVoiceLength("story_v_out_413022", "413022061", "story_v_out_413022.awb") / 1000

					if var_259_15 + var_259_9 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_15 + var_259_9
					end

					if var_259_11.prefab_name ~= "" and arg_256_1.actors_[var_259_11.prefab_name] ~= nil then
						local var_259_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_11.prefab_name].transform, "story_v_out_413022", "413022061", "story_v_out_413022.awb")

						arg_256_1:RecordAudio("413022061", var_259_16)
						arg_256_1:RecordAudio("413022061", var_259_16)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_413022", "413022061", "story_v_out_413022.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_413022", "413022061", "story_v_out_413022.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_17 = math.max(var_259_10, arg_256_1.talkMaxDuration)

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_17 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_9) / var_259_17

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_9 + var_259_17 and arg_256_1.time_ < var_259_9 + var_259_17 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play413022062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 413022062
		arg_260_1.duration_ = 12.1

		local var_260_0 = {
			zh = 9.266,
			ja = 12.1
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play413022063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.9

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(413022062)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 36 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 36)

				if (36 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 36)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022062", "story_v_out_413022.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022062", "story_v_out_413022.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_413022", "413022062", "story_v_out_413022.awb")

						arg_260_1:RecordAudio("413022062", var_263_6)
						arg_260_1:RecordAudio("413022062", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_413022", "413022062", "story_v_out_413022.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_413022", "413022062", "story_v_out_413022.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play413022063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 413022063
		arg_264_1.duration_ = 6.63

		local var_264_0 = {
			zh = 6,
			ja = 6.633
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
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play413022064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0.0333333333333333 < arg_264_1.time_ and arg_264_1.time_ <= 0.0333333333333333 + arg_267_0 then
				arg_264_1.var_.shakeOldPos10097 = arg_264_1.actors_["10097"].transform.localPosition
			end

			local var_267_0 = 0.6

			if 0.0333333333333333 <= arg_264_1.time_ and arg_264_1.time_ < 0.0333333333333333 + var_267_0 then
				local var_267_1, var_267_2 = math.modf((arg_264_1.time_ - 0.0333333333333333) / 0.066)

				arg_264_1.actors_["10097"].transform.localPosition = Vector3.New(var_267_2 * 0.13, var_267_2 * 0.13, var_267_2 * 0.13) + arg_264_1.var_.shakeOldPos10097
			end

			if arg_264_1.time_ >= 0.0333333333333333 + var_267_0 and arg_264_1.time_ < 0.0333333333333333 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["10097"].transform.localPosition = arg_264_1.var_.shakeOldPos10097
			end

			local var_267_3 = 0

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			if arg_264_1.time_ >= var_267_3 + 0.633333333333333 and arg_264_1.time_ < var_267_3 + 0.633333333333333 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_4 = 0
			local var_267_5 = 0.475

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(413022063)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 19 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 19)

				if (19 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 19)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022063", "story_v_out_413022.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_413022", "413022063", "story_v_out_413022.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_413022", "413022063", "story_v_out_413022.awb")

						arg_264_1:RecordAudio("413022063", var_267_11)
						arg_264_1:RecordAudio("413022063", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_413022", "413022063", "story_v_out_413022.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_413022", "413022063", "story_v_out_413022.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play413022064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413022064
		arg_268_1.duration_ = 2

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413022065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10092 = arg_268_1.actors_["10092"].transform.localPosition
				arg_268_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10092", 7)

				for iter_271_0 = 0, arg_268_1.actors_["10092"].transform.childCount - 1 do
					local var_271_0 = arg_268_1.actors_["10092"].transform:GetChild(iter_271_0)

					if var_271_0.name == "" or not string.find(var_271_0.name, "split") then
						var_271_0.gameObject:SetActive(true)
					else
						var_271_0.gameObject:SetActive(false)
					end
				end
			end

			local var_271_1 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_1 then
				arg_268_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_268_1.time_ - 0) / var_271_1)
			end

			if arg_268_1.time_ >= 0 + var_271_1 and arg_268_1.time_ < 0 + var_271_1 + arg_271_0 then
				arg_268_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_271_2 = arg_268_1.actors_["10097"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10097 = var_271_2.localPosition
				var_271_2.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10097", 7)

				for iter_271_1 = 0, var_271_2.childCount - 1 do
					local var_271_3 = var_271_2:GetChild(iter_271_1)

					if var_271_3.name == "" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				var_271_2.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_268_1.time_ - 0) / var_271_4)
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				var_271_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_271_5 = "10093"

			if arg_268_1.actors_["10093"] == nil then
				local var_271_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_271_6) then
					local var_271_7 = Object.Instantiate(var_271_6, arg_268_1.canvasGo_.transform)

					var_271_7.transform:SetSiblingIndex(1)

					var_271_7.name = var_271_5
					var_271_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_268_1.actors_[var_271_5] = var_271_7

					if arg_268_1.isInRecall_ then
						for iter_271_2, iter_271_3 in ipairs((var_271_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_271_3.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_271_8 = arg_268_1.actors_["10093"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos10093 = var_271_8.localPosition
				var_271_8.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10093", 3)

				for iter_271_4 = 0, var_271_8.childCount - 1 do
					local var_271_9 = var_271_8:GetChild(iter_271_4)

					if var_271_9.name == "split_4" or not string.find(var_271_9.name, "split") then
						var_271_9.gameObject:SetActive(true)
					else
						var_271_9.gameObject:SetActive(false)
					end
				end
			end

			local var_271_10 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_10 then
				var_271_8.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_268_1.time_ - 0) / var_271_10)
			end

			if arg_268_1.time_ >= 0 + var_271_10 and arg_268_1.time_ < 0 + var_271_10 + arg_271_0 then
				var_271_8.localPosition = Vector3.New(0, -345, -245)
			end

			local var_271_11 = arg_268_1.actors_["10022"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_11) and arg_268_1.var_.actorSpriteComps10022 == nil then
				arg_268_1.var_.actorSpriteComps10022 = var_271_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_12 = 2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_12 and not isNil(var_271_11) then
				if arg_268_1.var_.actorSpriteComps10022 then
					for iter_271_5, iter_271_6 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_271_6 then
							if arg_268_1.isInRecall_ then
								iter_271_6.color = Color.New(Mathf.Lerp(iter_271_6.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_12), Mathf.Lerp(iter_271_6.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_12), (Mathf.Lerp(iter_271_6.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_12)))
							else
								local var_271_13 = Mathf.Lerp(iter_271_6.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_12)

								iter_271_6.color = Color.New(var_271_13, var_271_13, var_271_13)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_12 and arg_268_1.time_ < 0 + var_271_12 + arg_271_0 and not isNil(var_271_11) and arg_268_1.var_.actorSpriteComps10022 then
				for iter_271_7, iter_271_8 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_271_8 then
						iter_271_8.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps10022 = nil
			end

			local var_271_14 = arg_268_1.actors_["10097"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_14) and arg_268_1.var_.actorSpriteComps10097 == nil then
				arg_268_1.var_.actorSpriteComps10097 = var_271_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_15 = 2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_15 and not isNil(var_271_14) then
				if arg_268_1.var_.actorSpriteComps10097 then
					for iter_271_9, iter_271_10 in pairs(arg_268_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_271_10 then
							if arg_268_1.isInRecall_ then
								iter_271_10.color = Color.New(Mathf.Lerp(iter_271_10.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_15), Mathf.Lerp(iter_271_10.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_15), (Mathf.Lerp(iter_271_10.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_15)))
							else
								local var_271_16 = Mathf.Lerp(iter_271_10.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_15)

								iter_271_10.color = Color.New(var_271_16, var_271_16, var_271_16)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_15 and arg_268_1.time_ < 0 + var_271_15 + arg_271_0 and not isNil(var_271_14) and arg_268_1.var_.actorSpriteComps10097 then
				for iter_271_11, iter_271_12 in pairs(arg_268_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_271_12 then
						iter_271_12.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps10097 = nil
			end

			local var_271_17 = arg_268_1.actors_["10093"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_17) and arg_268_1.var_.actorSpriteComps10093 == nil then
				arg_268_1.var_.actorSpriteComps10093 = var_271_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_18 = 2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_18 and not isNil(var_271_17) then
				if arg_268_1.var_.actorSpriteComps10093 then
					for iter_271_13, iter_271_14 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_271_14 then
							if arg_268_1.isInRecall_ then
								iter_271_14.color = Color.New(Mathf.Lerp(iter_271_14.color.r, arg_268_1.hightColor1.r, (arg_268_1.time_ - 0) / var_271_18), Mathf.Lerp(iter_271_14.color.g, arg_268_1.hightColor1.g, (arg_268_1.time_ - 0) / var_271_18), (Mathf.Lerp(iter_271_14.color.b, arg_268_1.hightColor1.b, (arg_268_1.time_ - 0) / var_271_18)))
							else
								local var_271_19 = Mathf.Lerp(iter_271_14.color.r, 1, (arg_268_1.time_ - 0) / var_271_18)

								iter_271_14.color = Color.New(var_271_19, var_271_19, var_271_19)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_18 and arg_268_1.time_ < 0 + var_271_18 + arg_271_0 and not isNil(var_271_17) and arg_268_1.var_.actorSpriteComps10093 then
				for iter_271_15, iter_271_16 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_271_16 then
						iter_271_16.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_268_1.var_.actorSpriteComps10093 = nil
			end

			local var_271_20 = 0
			local var_271_21 = 0.075

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_20 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_22 = arg_268_1:GetWordFromCfg(413022064)
				local var_271_23 = arg_268_1:FormatText(var_271_22.content)

				arg_268_1.text_.text = var_271_23

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_25 = 3 <= 0 and var_271_21 or var_271_21 * (utf8.len(var_271_23) / 3)

				if (3 <= 0 and var_271_21 or var_271_21 * (utf8.len(var_271_23) / 3)) > 0 and var_271_21 < var_271_25 then
					arg_268_1.talkMaxDuration = var_271_25

					if var_271_25 + var_271_20 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_25 + var_271_20
					end
				end

				arg_268_1.text_.text = var_271_23
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022064", "story_v_out_413022.awb") ~= 0 then
					local var_271_26 = manager.audio:GetVoiceLength("story_v_out_413022", "413022064", "story_v_out_413022.awb") / 1000

					if var_271_26 + var_271_20 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_26 + var_271_20
					end

					if var_271_22.prefab_name ~= "" and arg_268_1.actors_[var_271_22.prefab_name] ~= nil then
						local var_271_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_22.prefab_name].transform, "story_v_out_413022", "413022064", "story_v_out_413022.awb")

						arg_268_1:RecordAudio("413022064", var_271_27)
						arg_268_1:RecordAudio("413022064", var_271_27)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413022", "413022064", "story_v_out_413022.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413022", "413022064", "story_v_out_413022.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_28 = math.max(var_271_21, arg_268_1.talkMaxDuration)

			if var_271_20 <= arg_268_1.time_ and arg_268_1.time_ < var_271_20 + var_271_28 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_20) / var_271_28

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_20 + var_271_28 and arg_268_1.time_ < var_271_20 + var_271_28 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play413022065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413022065
		arg_272_1.duration_ = 2

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play413022066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10093 = arg_272_1.actors_["10093"].transform.localPosition
				arg_272_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10093", 7)

				for iter_275_0 = 0, arg_272_1.actors_["10093"].transform.childCount - 1 do
					local var_275_0 = arg_272_1.actors_["10093"].transform:GetChild(iter_275_0)

					if var_275_0.name == "" or not string.find(var_275_0.name, "split") then
						var_275_0.gameObject:SetActive(true)
					else
						var_275_0.gameObject:SetActive(false)
					end
				end
			end

			local var_275_1 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_1 then
				arg_272_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_272_1.time_ - 0) / var_275_1)
			end

			if arg_272_1.time_ >= 0 + var_275_1 and arg_272_1.time_ < 0 + var_275_1 + arg_275_0 then
				arg_272_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_275_2 = arg_272_1.actors_["10092"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10092 = var_275_2.localPosition
				var_275_2.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10092", 3)

				for iter_275_1 = 0, var_275_2.childCount - 1 do
					local var_275_3 = var_275_2:GetChild(iter_275_1)

					if var_275_3.name == "split_8" or not string.find(var_275_3.name, "split") then
						var_275_3.gameObject:SetActive(true)
					else
						var_275_3.gameObject:SetActive(false)
					end
				end
			end

			local var_275_4 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				var_275_2.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_272_1.time_ - 0) / var_275_4)
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				var_275_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_275_5 = arg_272_1.actors_["10093"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_5) and arg_272_1.var_.actorSpriteComps10093 == nil then
				arg_272_1.var_.actorSpriteComps10093 = var_275_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_6 = 2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_6 and not isNil(var_275_5) then
				if arg_272_1.var_.actorSpriteComps10093 then
					for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_275_3 then
							if arg_272_1.isInRecall_ then
								iter_275_3.color = Color.New(Mathf.Lerp(iter_275_3.color.r, arg_272_1.hightColor2.r, (arg_272_1.time_ - 0) / var_275_6), Mathf.Lerp(iter_275_3.color.g, arg_272_1.hightColor2.g, (arg_272_1.time_ - 0) / var_275_6), (Mathf.Lerp(iter_275_3.color.b, arg_272_1.hightColor2.b, (arg_272_1.time_ - 0) / var_275_6)))
							else
								local var_275_7 = Mathf.Lerp(iter_275_3.color.r, 0.5, (arg_272_1.time_ - 0) / var_275_6)

								iter_275_3.color = Color.New(var_275_7, var_275_7, var_275_7)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_6 and arg_272_1.time_ < 0 + var_275_6 + arg_275_0 and not isNil(var_275_5) and arg_272_1.var_.actorSpriteComps10093 then
				for iter_275_4, iter_275_5 in pairs(arg_272_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_275_5 then
						iter_275_5.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_272_1.var_.actorSpriteComps10093 = nil
			end

			local var_275_8 = arg_272_1.actors_["10092"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_8) and arg_272_1.var_.actorSpriteComps10092 == nil then
				arg_272_1.var_.actorSpriteComps10092 = var_275_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_9 = 2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_9 and not isNil(var_275_8) then
				if arg_272_1.var_.actorSpriteComps10092 then
					for iter_275_6, iter_275_7 in pairs(arg_272_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_275_7 then
							if arg_272_1.isInRecall_ then
								iter_275_7.color = Color.New(Mathf.Lerp(iter_275_7.color.r, arg_272_1.hightColor1.r, (arg_272_1.time_ - 0) / var_275_9), Mathf.Lerp(iter_275_7.color.g, arg_272_1.hightColor1.g, (arg_272_1.time_ - 0) / var_275_9), (Mathf.Lerp(iter_275_7.color.b, arg_272_1.hightColor1.b, (arg_272_1.time_ - 0) / var_275_9)))
							else
								local var_275_10 = Mathf.Lerp(iter_275_7.color.r, 1, (arg_272_1.time_ - 0) / var_275_9)

								iter_275_7.color = Color.New(var_275_10, var_275_10, var_275_10)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= 0 + var_275_9 and arg_272_1.time_ < 0 + var_275_9 + arg_275_0 and not isNil(var_275_8) and arg_272_1.var_.actorSpriteComps10092 then
				for iter_275_8, iter_275_9 in pairs(arg_272_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_275_9 then
						iter_275_9.color = arg_272_1.isInRecall_ and (arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_272_1.var_.actorSpriteComps10092 = nil
			end

			local var_275_11 = 0
			local var_275_12 = 0.175

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_11 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_13 = arg_272_1:GetWordFromCfg(413022065)
				local var_275_14 = arg_272_1:FormatText(var_275_13.content)

				arg_272_1.text_.text = var_275_14

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_16 = 7 <= 0 and var_275_12 or var_275_12 * (utf8.len(var_275_14) / 7)

				if (7 <= 0 and var_275_12 or var_275_12 * (utf8.len(var_275_14) / 7)) > 0 and var_275_12 < var_275_16 then
					arg_272_1.talkMaxDuration = var_275_16

					if var_275_16 + var_275_11 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_16 + var_275_11
					end
				end

				arg_272_1.text_.text = var_275_14
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022065", "story_v_out_413022.awb") ~= 0 then
					local var_275_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022065", "story_v_out_413022.awb") / 1000

					if var_275_17 + var_275_11 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_17 + var_275_11
					end

					if var_275_13.prefab_name ~= "" and arg_272_1.actors_[var_275_13.prefab_name] ~= nil then
						local var_275_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_13.prefab_name].transform, "story_v_out_413022", "413022065", "story_v_out_413022.awb")

						arg_272_1:RecordAudio("413022065", var_275_18)
						arg_272_1:RecordAudio("413022065", var_275_18)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413022", "413022065", "story_v_out_413022.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413022", "413022065", "story_v_out_413022.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_19 = math.max(var_275_12, arg_272_1.talkMaxDuration)

			if var_275_11 <= arg_272_1.time_ and arg_272_1.time_ < var_275_11 + var_275_19 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_11) / var_275_19

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_11 + var_275_19 and arg_272_1.time_ < var_275_11 + var_275_19 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play413022066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413022066
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play413022067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10092 = arg_276_1.actors_["10092"].transform.localPosition
				arg_276_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10092", 7)

				for iter_279_0 = 0, arg_276_1.actors_["10092"].transform.childCount - 1 do
					local var_279_0 = arg_276_1.actors_["10092"].transform:GetChild(iter_279_0)

					if var_279_0.name == "" or not string.find(var_279_0.name, "split") then
						var_279_0.gameObject:SetActive(true)
					else
						var_279_0.gameObject:SetActive(false)
					end
				end
			end

			local var_279_1 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_1 then
				arg_276_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10092, Vector3.New(0, -2000, -180), (arg_276_1.time_ - 0) / var_279_1)
			end

			if arg_276_1.time_ >= 0 + var_279_1 and arg_276_1.time_ < 0 + var_279_1 + arg_279_0 then
				arg_276_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_279_2 = arg_276_1.actors_["10092"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps10092 == nil then
				arg_276_1.var_.actorSpriteComps10092 = var_279_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_3 = 2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_3 and not isNil(var_279_2) then
				if arg_276_1.var_.actorSpriteComps10092 then
					for iter_279_1, iter_279_2 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_279_2 then
							if arg_276_1.isInRecall_ then
								iter_279_2.color = Color.New(Mathf.Lerp(iter_279_2.color.r, arg_276_1.hightColor2.r, (arg_276_1.time_ - 0) / var_279_3), Mathf.Lerp(iter_279_2.color.g, arg_276_1.hightColor2.g, (arg_276_1.time_ - 0) / var_279_3), (Mathf.Lerp(iter_279_2.color.b, arg_276_1.hightColor2.b, (arg_276_1.time_ - 0) / var_279_3)))
							else
								local var_279_4 = Mathf.Lerp(iter_279_2.color.r, 0.5, (arg_276_1.time_ - 0) / var_279_3)

								iter_279_2.color = Color.New(var_279_4, var_279_4, var_279_4)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_3 and arg_276_1.time_ < 0 + var_279_3 + arg_279_0 and not isNil(var_279_2) and arg_276_1.var_.actorSpriteComps10092 then
				for iter_279_3, iter_279_4 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_279_4 then
						iter_279_4.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_276_1.var_.actorSpriteComps10092 = nil
			end

			local var_279_5 = 0
			local var_279_6 = 1.15

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_7 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(413022066).content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_9 = 46 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_7) / 46)

				if (46 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_7) / 46)) > 0 and var_279_6 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9

					if var_279_9 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_10 and arg_276_1.time_ < var_279_5 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play413022067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 413022067
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play413022068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 1.9

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(413022067).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 76 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 76)

				if (76 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 76)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play413022068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413022068
		arg_284_1.duration_ = 5.67

		local var_284_0 = {
			zh = 3.3,
			ja = 5.666
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play413022069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10094 = arg_284_1.actors_["10094"].transform.localPosition
				arg_284_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10094", 3)

				for iter_287_0 = 0, arg_284_1.actors_["10094"].transform.childCount - 1 do
					local var_287_0 = arg_284_1.actors_["10094"].transform:GetChild(iter_287_0)

					if var_287_0.name == "" or not string.find(var_287_0.name, "split") then
						var_287_0.gameObject:SetActive(true)
					else
						var_287_0.gameObject:SetActive(false)
					end
				end
			end

			local var_287_1 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_1 then
				arg_284_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_284_1.time_ - 0) / var_287_1)
			end

			if arg_284_1.time_ >= 0 + var_287_1 and arg_284_1.time_ < 0 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_287_2 = arg_284_1.actors_["10094"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.actorSpriteComps10094 == nil then
				arg_284_1.var_.actorSpriteComps10094 = var_287_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_3 = 2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_3 and not isNil(var_287_2) then
				if arg_284_1.var_.actorSpriteComps10094 then
					for iter_287_1, iter_287_2 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_287_2 then
							if arg_284_1.isInRecall_ then
								iter_287_2.color = Color.New(Mathf.Lerp(iter_287_2.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 0) / var_287_3), Mathf.Lerp(iter_287_2.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 0) / var_287_3), (Mathf.Lerp(iter_287_2.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 0) / var_287_3)))
							else
								local var_287_4 = Mathf.Lerp(iter_287_2.color.r, 1, (arg_284_1.time_ - 0) / var_287_3)

								iter_287_2.color = Color.New(var_287_4, var_287_4, var_287_4)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_3 and arg_284_1.time_ < 0 + var_287_3 + arg_287_0 and not isNil(var_287_2) and arg_284_1.var_.actorSpriteComps10094 then
				for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_287_4 then
						iter_287_4.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps10094 = nil
			end

			local var_287_5 = 0
			local var_287_6 = 0.35

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:GetWordFromCfg(413022068)
				local var_287_8 = arg_284_1:FormatText(var_287_7.content)

				arg_284_1.text_.text = var_287_8

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_10 = 14 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 14)

				if (14 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 14)) > 0 and var_287_6 < var_287_10 then
					arg_284_1.talkMaxDuration = var_287_10

					if var_287_10 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_8
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022068", "story_v_out_413022.awb") ~= 0 then
					local var_287_11 = manager.audio:GetVoiceLength("story_v_out_413022", "413022068", "story_v_out_413022.awb") / 1000

					if var_287_11 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_5
					end

					if var_287_7.prefab_name ~= "" and arg_284_1.actors_[var_287_7.prefab_name] ~= nil then
						local var_287_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_7.prefab_name].transform, "story_v_out_413022", "413022068", "story_v_out_413022.awb")

						arg_284_1:RecordAudio("413022068", var_287_12)
						arg_284_1:RecordAudio("413022068", var_287_12)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_413022", "413022068", "story_v_out_413022.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_413022", "413022068", "story_v_out_413022.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_13 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_13 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_13

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_13 and arg_284_1.time_ < var_287_5 + var_287_13 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play413022069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413022069
		arg_288_1.duration_ = 9.5

		local var_288_0 = {
			zh = 9.5,
			ja = 6.466
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play413022070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10097 = arg_288_1.actors_["10097"].transform.localPosition
				arg_288_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10097", 4)

				for iter_291_0 = 0, arg_288_1.actors_["10097"].transform.childCount - 1 do
					local var_291_0 = arg_288_1.actors_["10097"].transform:GetChild(iter_291_0)

					if var_291_0.name == "" or not string.find(var_291_0.name, "split") then
						var_291_0.gameObject:SetActive(true)
					else
						var_291_0.gameObject:SetActive(false)
					end
				end
			end

			local var_291_1 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_1 then
				arg_288_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_288_1.time_ - 0) / var_291_1)
			end

			if arg_288_1.time_ >= 0 + var_291_1 and arg_288_1.time_ < 0 + var_291_1 + arg_291_0 then
				arg_288_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_291_2 = arg_288_1.actors_["10097"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10097 == nil then
				arg_288_1.var_.actorSpriteComps10097 = var_291_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_3 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.actorSpriteComps10097 then
					for iter_291_1, iter_291_2 in pairs(arg_288_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_291_2 then
							if arg_288_1.isInRecall_ then
								iter_291_2.color = Color.New(Mathf.Lerp(iter_291_2.color.r, arg_288_1.hightColor1.r, (arg_288_1.time_ - 0) / var_291_3), Mathf.Lerp(iter_291_2.color.g, arg_288_1.hightColor1.g, (arg_288_1.time_ - 0) / var_291_3), (Mathf.Lerp(iter_291_2.color.b, arg_288_1.hightColor1.b, (arg_288_1.time_ - 0) / var_291_3)))
							else
								local var_291_4 = Mathf.Lerp(iter_291_2.color.r, 1, (arg_288_1.time_ - 0) / var_291_3)

								iter_291_2.color = Color.New(var_291_4, var_291_4, var_291_4)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.actorSpriteComps10097 then
				for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_291_4 then
						iter_291_4.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_288_1.var_.actorSpriteComps10097 = nil
			end

			local var_291_5 = arg_288_1.actors_["10094"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10094 = var_291_5.localPosition
				var_291_5.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10094", 2)

				for iter_291_5 = 0, var_291_5.childCount - 1 do
					local var_291_6 = var_291_5:GetChild(iter_291_5)

					if var_291_6.name == "" or not string.find(var_291_6.name, "split") then
						var_291_6.gameObject:SetActive(true)
					else
						var_291_6.gameObject:SetActive(false)
					end
				end
			end

			local var_291_7 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				var_291_5.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_288_1.time_ - 0) / var_291_7)
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				var_291_5.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_291_8 = arg_288_1.actors_["10094"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_8) and arg_288_1.var_.actorSpriteComps10094 == nil then
				arg_288_1.var_.actorSpriteComps10094 = var_291_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_9 = 2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_9 and not isNil(var_291_8) then
				if arg_288_1.var_.actorSpriteComps10094 then
					for iter_291_6, iter_291_7 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_291_7 then
							if arg_288_1.isInRecall_ then
								iter_291_7.color = Color.New(Mathf.Lerp(iter_291_7.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_9), Mathf.Lerp(iter_291_7.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_9), (Mathf.Lerp(iter_291_7.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_9)))
							else
								local var_291_10 = Mathf.Lerp(iter_291_7.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_9)

								iter_291_7.color = Color.New(var_291_10, var_291_10, var_291_10)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_9 and arg_288_1.time_ < 0 + var_291_9 + arg_291_0 and not isNil(var_291_8) and arg_288_1.var_.actorSpriteComps10094 then
				for iter_291_8, iter_291_9 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_291_9 then
						iter_291_9.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps10094 = nil
			end

			local var_291_11 = 0
			local var_291_12 = 0.3

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_11 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_13 = arg_288_1:GetWordFromCfg(413022069)
				local var_291_14 = arg_288_1:FormatText(var_291_13.content)

				arg_288_1.text_.text = var_291_14

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_16 = 12 <= 0 and var_291_12 or var_291_12 * (utf8.len(var_291_14) / 12)

				if (12 <= 0 and var_291_12 or var_291_12 * (utf8.len(var_291_14) / 12)) > 0 and var_291_12 < var_291_16 then
					arg_288_1.talkMaxDuration = var_291_16

					if var_291_16 + var_291_11 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_16 + var_291_11
					end
				end

				arg_288_1.text_.text = var_291_14
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022069", "story_v_out_413022.awb") ~= 0 then
					local var_291_17 = manager.audio:GetVoiceLength("story_v_out_413022", "413022069", "story_v_out_413022.awb") / 1000

					if var_291_17 + var_291_11 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_17 + var_291_11
					end

					if var_291_13.prefab_name ~= "" and arg_288_1.actors_[var_291_13.prefab_name] ~= nil then
						local var_291_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_13.prefab_name].transform, "story_v_out_413022", "413022069", "story_v_out_413022.awb")

						arg_288_1:RecordAudio("413022069", var_291_18)
						arg_288_1:RecordAudio("413022069", var_291_18)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413022", "413022069", "story_v_out_413022.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413022", "413022069", "story_v_out_413022.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_19 = math.max(var_291_12, arg_288_1.talkMaxDuration)

			if var_291_11 <= arg_288_1.time_ and arg_288_1.time_ < var_291_11 + var_291_19 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_11) / var_291_19

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_11 + var_291_19 and arg_288_1.time_ < var_291_11 + var_291_19 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play413022070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413022070
		arg_292_1.duration_ = 13.67

		local var_292_0 = {
			zh = 8.266,
			ja = 13.666
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play413022071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10022 = arg_292_1.actors_["10022"].transform.localPosition
				arg_292_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10022", 2)

				for iter_295_0 = 0, arg_292_1.actors_["10022"].transform.childCount - 1 do
					local var_295_0 = arg_292_1.actors_["10022"].transform:GetChild(iter_295_0)

					if var_295_0.name == "" or not string.find(var_295_0.name, "split") then
						var_295_0.gameObject:SetActive(true)
					else
						var_295_0.gameObject:SetActive(false)
					end
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_292_1.time_ - 0) / var_295_1)
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_295_2 = arg_292_1.actors_["10097"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10097 = var_295_2.localPosition
				var_295_2.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10097", 4)

				for iter_295_1 = 0, var_295_2.childCount - 1 do
					local var_295_3 = var_295_2:GetChild(iter_295_1)

					if var_295_3.name == "" or not string.find(var_295_3.name, "split") then
						var_295_3.gameObject:SetActive(true)
					else
						var_295_3.gameObject:SetActive(false)
					end
				end
			end

			local var_295_4 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_2.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_292_1.time_ - 0) / var_295_4)
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_295_5 = arg_292_1.actors_["10022"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10022 == nil then
				arg_292_1.var_.actorSpriteComps10022 = var_295_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_6 = 2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_6 and not isNil(var_295_5) then
				if arg_292_1.var_.actorSpriteComps10022 then
					for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_295_3 then
							if arg_292_1.isInRecall_ then
								iter_295_3.color = Color.New(Mathf.Lerp(iter_295_3.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_6), Mathf.Lerp(iter_295_3.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_6), (Mathf.Lerp(iter_295_3.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_6)))
							else
								local var_295_7 = Mathf.Lerp(iter_295_3.color.r, 1, (arg_292_1.time_ - 0) / var_295_6)

								iter_295_3.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_6 and arg_292_1.time_ < 0 + var_295_6 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10022 then
				for iter_295_4, iter_295_5 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_295_5 then
						iter_295_5.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps10022 = nil
			end

			local var_295_8 = 0
			local var_295_9 = 0.925

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_10 = arg_292_1:GetWordFromCfg(413022070)
				local var_295_11 = arg_292_1:FormatText(var_295_10.content)

				arg_292_1.text_.text = var_295_11

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_13 = 37 <= 0 and var_295_9 or var_295_9 * (utf8.len(var_295_11) / 37)

				if (37 <= 0 and var_295_9 or var_295_9 * (utf8.len(var_295_11) / 37)) > 0 and var_295_9 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_11
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022070", "story_v_out_413022.awb") ~= 0 then
					local var_295_14 = manager.audio:GetVoiceLength("story_v_out_413022", "413022070", "story_v_out_413022.awb") / 1000

					if var_295_14 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_14 + var_295_8
					end

					if var_295_10.prefab_name ~= "" and arg_292_1.actors_[var_295_10.prefab_name] ~= nil then
						local var_295_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_10.prefab_name].transform, "story_v_out_413022", "413022070", "story_v_out_413022.awb")

						arg_292_1:RecordAudio("413022070", var_295_15)
						arg_292_1:RecordAudio("413022070", var_295_15)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413022", "413022070", "story_v_out_413022.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413022", "413022070", "story_v_out_413022.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_16 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_16 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_8) / var_295_16

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_8 + var_295_16 and arg_292_1.time_ < var_295_8 + var_295_16 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play413022071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413022071
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play413022072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10022"]) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = arg_296_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10022"]) then
				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10022"]) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			local var_299_2 = arg_296_1.actors_["10097"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10097 = var_299_2.localPosition
				var_299_2.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10097", 7)

				for iter_299_4 = 0, var_299_2.childCount - 1 do
					local var_299_3 = var_299_2:GetChild(iter_299_4)

					if var_299_3.name == "" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_2.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_296_1.time_ - 0) / var_299_4)
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_299_5 = arg_296_1.actors_["10022"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10022 = var_299_5.localPosition
				var_299_5.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10022", 7)

				for iter_299_5 = 0, var_299_5.childCount - 1 do
					local var_299_6 = var_299_5:GetChild(iter_299_5)

					if var_299_6.name == "" or not string.find(var_299_6.name, "split") then
						var_299_6.gameObject:SetActive(true)
					else
						var_299_6.gameObject:SetActive(false)
					end
				end
			end

			local var_299_7 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				var_299_5.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_296_1.time_ - 0) / var_299_7)
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				var_299_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_299_8 = 0
			local var_299_9 = 1.525

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_10 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(413022071).content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_12 = 61 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_10) / 61)

				if (61 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_10) / 61)) > 0 and var_299_9 < var_299_12 then
					arg_296_1.talkMaxDuration = var_299_12

					if var_299_12 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_13 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_13 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_13

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_13 and arg_296_1.time_ < var_299_8 + var_299_13 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play413022072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413022072
		arg_300_1.duration_ = 5.8

		local var_300_0 = {
			zh = 5.8,
			ja = 5.233
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
			arg_300_1.auto_ = false
		end

		function arg_300_1.playNext_(arg_302_0)
			arg_300_1.onStoryFinished_()
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.35

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_3")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:GetWordFromCfg(413022072)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 14 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 14)

				if (14 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 14)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022072", "story_v_out_413022.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_out_413022", "413022072", "story_v_out_413022.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_out_413022", "413022072", "story_v_out_413022.awb")

						arg_300_1:RecordAudio("413022072", var_303_6)
						arg_300_1:RecordAudio("413022072", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413022", "413022072", "story_v_out_413022.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413022", "413022072", "story_v_out_413022.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/F08h",
		"TextureConfig/Background/ST0601"
	},
	voices = {
		"story_v_out_413022.awb"
	}
}
