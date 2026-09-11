return {
	Play929041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 929041001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play929041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0112 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0112")
				var_4_0.name = "ST0112"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0112 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0112

				arg_1_1.bgs_.ST0112.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0112" then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")
			end

			local var_4_14 = 0
			local var_4_15 = 0.1

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(929041001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 4 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 4)

				if (4 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 4)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play929041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 929041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play929041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["10148"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "10148"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["10148"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["10148"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10148 == nil then
				arg_8_1.var_.actorSpriteComps10148 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps10148 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								iter_11_3.color = Color.New(Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, (arg_8_1.time_ - 0) / var_11_3), Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, (arg_8_1.time_ - 0) / var_11_3), (Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, (arg_8_1.time_ - 0) / var_11_3)))
							else
								local var_11_4 = Mathf.Lerp(iter_11_3.color.r, 1, (arg_8_1.time_ - 0) / var_11_3)

								iter_11_3.color = Color.New(var_11_4, var_11_4, var_11_4)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps10148 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps10148 = nil
			end

			local var_11_5 = arg_8_1.actors_["10148"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10148 = var_11_5.localPosition
				var_11_5.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("10148", 3)

				for iter_11_6 = 0, var_11_5.childCount - 1 do
					local var_11_6 = var_11_5:GetChild(iter_11_6)

					if var_11_6.name == "split_2" or not string.find(var_11_6.name, "split") then
						var_11_6.gameObject:SetActive(true)
					else
						var_11_6.gameObject:SetActive(false)
					end
				end
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_8_1.time_ - 0) / var_11_7)
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -350, -270)
			end

			local var_11_8 = 0
			local var_11_9 = 1.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(929041002).content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_12 = 45 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_10) / 45)

				if (45 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_10) / 45)) > 0 and var_11_9 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_13 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_13 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_13

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_13 and arg_8_1.time_ < var_11_8 + var_11_13 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play929041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 929041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play929041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10148 = arg_12_1.actors_["10148"].transform.localPosition
				arg_12_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10148", 3)

				for iter_15_0 = 0, arg_12_1.actors_["10148"].transform.childCount - 1 do
					local var_15_0 = arg_12_1.actors_["10148"].transform:GetChild(iter_15_0)

					if var_15_0.name == "split_2" or not string.find(var_15_0.name, "split") then
						var_15_0.gameObject:SetActive(true)
					else
						var_15_0.gameObject:SetActive(false)
					end
				end
			end

			local var_15_1 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_1 then
				arg_12_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_12_1.time_ - 0) / var_15_1)
			end

			if arg_12_1.time_ >= 0 + var_15_1 and arg_12_1.time_ < 0 + var_15_1 + arg_15_0 then
				arg_12_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_15_2 = 0
			local var_15_3 = 0.975

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(929041003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 39 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 39)

				if (39 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 39)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play929041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 929041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play929041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10148 = arg_16_1.actors_["10148"].transform.localPosition
				arg_16_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("10148", 3)

				for iter_19_0 = 0, arg_16_1.actors_["10148"].transform.childCount - 1 do
					local var_19_0 = arg_16_1.actors_["10148"].transform:GetChild(iter_19_0)

					if var_19_0.name == "" or not string.find(var_19_0.name, "split") then
						var_19_0.gameObject:SetActive(true)
					else
						var_19_0.gameObject:SetActive(false)
					end
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_16_1.time_ - 0) / var_19_1)
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_19_2 = 0
			local var_19_3 = 0.825

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(929041004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 33 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 33)

				if (33 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 33)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play929041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 929041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play929041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10148 = arg_20_1.actors_["10148"].transform.localPosition
				arg_20_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10148", 3)

				for iter_23_0 = 0, arg_20_1.actors_["10148"].transform.childCount - 1 do
					local var_23_0 = arg_20_1.actors_["10148"].transform:GetChild(iter_23_0)

					if var_23_0.name == "" or not string.find(var_23_0.name, "split") then
						var_23_0.gameObject:SetActive(true)
					else
						var_23_0.gameObject:SetActive(false)
					end
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_20_1.time_ - 0) / var_23_1)
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_23_2 = 0
			local var_23_3 = 1.275

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(929041005).content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 51 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 51)

				if (51 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_4) / 51)) > 0 and var_23_3 < var_23_6 then
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
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play929041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 929041006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play929041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1083"] == nil then
				local var_27_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_27_0) then
					local var_27_1 = Object.Instantiate(var_27_0, arg_24_1.canvasGo_.transform)

					var_27_1.transform:SetSiblingIndex(1)

					var_27_1.name = "1083"
					var_27_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_24_1.actors_["1083"] = var_27_1

					if arg_24_1.isInRecall_ then
						for iter_27_0, iter_27_1 in ipairs((var_27_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_27_1.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_27_2 = arg_24_1.actors_["1083"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1083 == nil then
				arg_24_1.var_.actorSpriteComps1083 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps1083 then
					for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1083 then
				for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_27_5 then
						iter_27_5.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_24_1.var_.actorSpriteComps1083 = nil
			end

			local var_27_5 = arg_24_1.actors_["10148"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.actorSpriteComps10148 == nil then
				arg_24_1.var_.actorSpriteComps10148 = var_27_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_6 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 and not isNil(var_27_5) then
				if arg_24_1.var_.actorSpriteComps10148 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.actorSpriteComps10148 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_27_9 then
						iter_27_9.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps10148 = nil
			end

			local var_27_8 = arg_24_1.actors_["1083"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1083 = var_27_8.localPosition
				var_27_8.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1083", 3)

				for iter_27_10 = 0, var_27_8.childCount - 1 do
					local var_27_9 = var_27_8:GetChild(iter_27_10)

					if var_27_9.name == "split_2" or not string.find(var_27_9.name, "split") then
						var_27_9.gameObject:SetActive(true)
					else
						var_27_9.gameObject:SetActive(false)
					end
				end
			end

			local var_27_10 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_10 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_24_1.time_ - 0) / var_27_10)
			end

			if arg_24_1.time_ >= 0 + var_27_10 and arg_24_1.time_ < 0 + var_27_10 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_27_11 = 0
			local var_27_12 = 0.25

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_13 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(929041006).content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 10 <= 0 and var_27_12 or var_27_12 * (utf8.len(var_27_13) / 10)

				if (10 <= 0 and var_27_12 or var_27_12 * (utf8.len(var_27_13) / 10)) > 0 and var_27_12 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_11 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_11
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_12, arg_24_1.talkMaxDuration)

			if var_27_11 <= arg_24_1.time_ and arg_24_1.time_ < var_27_11 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_11) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_11 + var_27_16 and arg_24_1.time_ < var_27_11 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play929041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 929041007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play929041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10148"]) and arg_28_1.var_.actorSpriteComps10148 == nil then
				arg_28_1.var_.actorSpriteComps10148 = arg_28_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10148"]) then
				if arg_28_1.var_.actorSpriteComps10148 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								iter_31_1.color = Color.New(Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor1.r, (arg_28_1.time_ - 0) / var_31_0), Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor1.g, (arg_28_1.time_ - 0) / var_31_0), (Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor1.b, (arg_28_1.time_ - 0) / var_31_0)))
							else
								local var_31_1 = Mathf.Lerp(iter_31_1.color.r, 1, (arg_28_1.time_ - 0) / var_31_0)

								iter_31_1.color = Color.New(var_31_1, var_31_1, var_31_1)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10148"]) and arg_28_1.var_.actorSpriteComps10148 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_28_1.var_.actorSpriteComps10148 = nil
			end

			local var_31_2 = arg_28_1.actors_["1083"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps1083 == nil then
				arg_28_1.var_.actorSpriteComps1083 = var_31_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_3 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.actorSpriteComps1083 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_31_5 then
							if arg_28_1.isInRecall_ then
								iter_31_5.color = Color.New(Mathf.Lerp(iter_31_5.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_3), Mathf.Lerp(iter_31_5.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_3), (Mathf.Lerp(iter_31_5.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_3)))
							else
								local var_31_4 = Mathf.Lerp(iter_31_5.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_3)

								iter_31_5.color = Color.New(var_31_4, var_31_4, var_31_4)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.actorSpriteComps1083 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_31_7 then
						iter_31_7.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps1083 = nil
			end

			local var_31_5 = arg_28_1.actors_["10148"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10148 = var_31_5.localPosition
				var_31_5.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10148", 3)

				for iter_31_8 = 0, var_31_5.childCount - 1 do
					local var_31_6 = var_31_5:GetChild(iter_31_8)

					if var_31_6.name == "split_2" or not string.find(var_31_6.name, "split") then
						var_31_6.gameObject:SetActive(true)
					else
						var_31_6.gameObject:SetActive(false)
					end
				end
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_28_1.time_ - 0) / var_31_7)
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -350, -270)
			end

			local var_31_8 = 0
			local var_31_9 = 0.625

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(929041007).content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_12 = 25 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_10) / 25)

				if (25 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_10) / 25)) > 0 and var_31_9 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_13 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_13 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_13

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_13 and arg_28_1.time_ < var_31_8 + var_31_13 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play929041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 929041008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play929041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10148"]) and arg_32_1.var_.actorSpriteComps10148 == nil then
				arg_32_1.var_.actorSpriteComps10148 = arg_32_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10148"]) then
				if arg_32_1.var_.actorSpriteComps10148 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10148"]) and arg_32_1.var_.actorSpriteComps10148 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_32_1.var_.actorSpriteComps10148 = nil
			end

			local var_35_2 = arg_32_1.actors_["10148"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10148 = var_35_2.localPosition
				var_35_2.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10148", 3)

				for iter_35_4 = 0, var_35_2.childCount - 1 do
					local var_35_3 = var_35_2:GetChild(iter_35_4)

					if var_35_3.name == "split_2" or not string.find(var_35_3.name, "split") then
						var_35_3.gameObject:SetActive(true)
					else
						var_35_3.gameObject:SetActive(false)
					end
				end
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_32_1.time_ - 0) / var_35_4)
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_35_5 = 0
			local var_35_6 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
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

				local var_35_7 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(929041008).content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 3 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_7) / 3)

				if (3 <= 0 and var_35_6 or var_35_6 * (utf8.len(var_35_7) / 3)) > 0 and var_35_6 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_5 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_5
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_6, arg_32_1.talkMaxDuration)

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_5) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_5 + var_35_10 and arg_32_1.time_ < var_35_5 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play929041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 929041009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play929041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10148 = arg_36_1.actors_["10148"].transform.localPosition
				arg_36_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10148", 3)

				for iter_39_0 = 0, arg_36_1.actors_["10148"].transform.childCount - 1 do
					local var_39_0 = arg_36_1.actors_["10148"].transform:GetChild(iter_39_0)

					if var_39_0.name == "split_1" or not string.find(var_39_0.name, "split") then
						var_39_0.gameObject:SetActive(true)
					else
						var_39_0.gameObject:SetActive(false)
					end
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_36_1.time_ - 0) / var_39_1)
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_39_2 = 0
			local var_39_3 = 0.8

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_4 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(929041009).content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 32 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 32)

				if (32 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 32)) > 0 and var_39_3 < var_39_6 then
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
				actorName = "10148",
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
	Play929041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 929041010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play929041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10148"]) and arg_40_1.var_.actorSpriteComps10148 == nil then
				arg_40_1.var_.actorSpriteComps10148 = arg_40_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10148"]) then
				if arg_40_1.var_.actorSpriteComps10148 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10148"]) and arg_40_1.var_.actorSpriteComps10148 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps10148 = nil
			end

			local var_43_2 = arg_40_1.actors_["10148"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10148 = var_43_2.localPosition
				var_43_2.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10148", 3)

				for iter_43_4 = 0, var_43_2.childCount - 1 do
					local var_43_3 = var_43_2:GetChild(iter_43_4)

					if var_43_3.name == "split_3" or not string.find(var_43_3.name, "split") then
						var_43_3.gameObject:SetActive(true)
					else
						var_43_3.gameObject:SetActive(false)
					end
				end
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_40_1.time_ - 0) / var_43_4)
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_43_5 = 0
			local var_43_6 = 0.325

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(929041010).content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 13 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 13)

				if (13 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_7) / 13)) > 0 and var_43_6 < var_43_9 then
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
				actorName = "10148",
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
	Play929041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 929041011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play929041012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1083"]) and arg_44_1.var_.actorSpriteComps1083 == nil then
				arg_44_1.var_.actorSpriteComps1083 = arg_44_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1083"]) then
				if arg_44_1.var_.actorSpriteComps1083 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								iter_47_1.color = Color.New(Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_0), Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_0), (Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_0)))
							else
								local var_47_1 = Mathf.Lerp(iter_47_1.color.r, 1, (arg_44_1.time_ - 0) / var_47_0)

								iter_47_1.color = Color.New(var_47_1, var_47_1, var_47_1)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1083"]) and arg_44_1.var_.actorSpriteComps1083 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_47_3 then
						iter_47_3.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps1083 = nil
			end

			local var_47_2 = arg_44_1.actors_["10148"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps10148 == nil then
				arg_44_1.var_.actorSpriteComps10148 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps10148 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								iter_47_5.color = Color.New(Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_5.color.r, 0.5, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_5.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps10148 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_47_7 then
						iter_47_7.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_44_1.var_.actorSpriteComps10148 = nil
			end

			local var_47_5 = arg_44_1.actors_["1083"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1083 = var_47_5.localPosition
				var_47_5.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1083", 3)

				for iter_47_8 = 0, var_47_5.childCount - 1 do
					local var_47_6 = var_47_5:GetChild(iter_47_8)

					if var_47_6.name == "split_2" or not string.find(var_47_6.name, "split") then
						var_47_6.gameObject:SetActive(true)
					else
						var_47_6.gameObject:SetActive(false)
					end
				end
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_5.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_44_1.time_ - 0) / var_47_7)
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_5.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_47_8 = 0
			local var_47_9 = 0.55

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(929041011).content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_12 = 22 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_10) / 22)

				if (22 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_10) / 22)) > 0 and var_47_9 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_13 and arg_44_1.time_ < var_47_8 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play929041012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 929041012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play929041013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1083"]) and arg_48_1.var_.actorSpriteComps1083 == nil then
				arg_48_1.var_.actorSpriteComps1083 = arg_48_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1083"]) then
				if arg_48_1.var_.actorSpriteComps1083 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1083"]) and arg_48_1.var_.actorSpriteComps1083 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps1083 = nil
			end

			local var_51_2 = arg_48_1.actors_["1083"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1083 = var_51_2.localPosition
				var_51_2.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("1083", 3)

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
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_48_1.time_ - 0) / var_51_4)
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_51_5 = 0
			local var_51_6 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_7 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(929041012).content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 20 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 20)

				if (20 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 20)) > 0 and var_51_6 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_10 and arg_48_1.time_ < var_51_5 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play929041013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 929041013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play929041014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1083 = arg_52_1.actors_["1083"].transform.localPosition
				arg_52_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("1083", 3)

				for iter_55_0 = 0, arg_52_1.actors_["1083"].transform.childCount - 1 do
					local var_55_0 = arg_52_1.actors_["1083"].transform:GetChild(iter_55_0)

					if var_55_0.name == "" or not string.find(var_55_0.name, "split") then
						var_55_0.gameObject:SetActive(true)
					else
						var_55_0.gameObject:SetActive(false)
					end
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_52_1.time_ - 0) / var_55_1)
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_55_2 = 0
			local var_55_3 = 1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
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

				local var_55_4 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(929041013).content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 40 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_4) / 40)

				if (40 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_4) / 40)) > 0 and var_55_3 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_7 and arg_52_1.time_ < var_55_2 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play929041014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 929041014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play929041015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1083"]) and arg_56_1.var_.actorSpriteComps1083 == nil then
				arg_56_1.var_.actorSpriteComps1083 = arg_56_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1083"]) then
				if arg_56_1.var_.actorSpriteComps1083 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 1, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1083"]) and arg_56_1.var_.actorSpriteComps1083 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1083 = nil
			end

			local var_59_2 = arg_56_1.actors_["1083"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1083 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1083", 3)

				for iter_59_4 = 0, var_59_2.childCount - 1 do
					local var_59_3 = var_59_2:GetChild(iter_59_4)

					if var_59_3.name == "split_6" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_59_5 = 0
			local var_59_6 = 1.2

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(929041014).content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 48 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 48)

				if (48 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 48)) > 0 and var_59_6 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_10 and arg_56_1.time_ < var_59_5 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play929041015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 929041015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play929041016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1083"]) and arg_60_1.var_.actorSpriteComps1083 == nil then
				arg_60_1.var_.actorSpriteComps1083 = arg_60_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1083"]) then
				if arg_60_1.var_.actorSpriteComps1083 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor2.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor2.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor2.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 0.5, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1083"]) and arg_60_1.var_.actorSpriteComps1083 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_60_1.var_.actorSpriteComps1083 = nil
			end

			local var_63_2 = arg_60_1.actors_["1083"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1083 = var_63_2.localPosition
				var_63_2.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("1083", 3)

				for iter_63_4 = 0, var_63_2.childCount - 1 do
					local var_63_3 = var_63_2:GetChild(iter_63_4)

					if var_63_3.name == "" or not string.find(var_63_3.name, "split") then
						var_63_3.gameObject:SetActive(true)
					else
						var_63_3.gameObject:SetActive(false)
					end
				end
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_2.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_60_1.time_ - 0) / var_63_4)
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_63_5 = 0
			local var_63_6 = 0.975

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_7 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(929041015).content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 39 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 39)

				if (39 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_7) / 39)) > 0 and var_63_6 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_10 and arg_60_1.time_ < var_63_5 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play929041016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 929041016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play929041017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10148"]) and arg_64_1.var_.actorSpriteComps10148 == nil then
				arg_64_1.var_.actorSpriteComps10148 = arg_64_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10148"]) then
				if arg_64_1.var_.actorSpriteComps10148 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 1, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10148"]) and arg_64_1.var_.actorSpriteComps10148 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps10148 = nil
			end

			local var_67_2 = arg_64_1.actors_["10148"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10148 = var_67_2.localPosition
				var_67_2.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10148", 3)

				for iter_67_4 = 0, var_67_2.childCount - 1 do
					local var_67_3 = var_67_2:GetChild(iter_67_4)

					if var_67_3.name == "split_4" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_2.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_64_1.time_ - 0) / var_67_4)
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_67_5 = 0
			local var_67_6 = 1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_7 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(929041016).content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 40 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 40)

				if (40 <= 0 and var_67_6 or var_67_6 * (utf8.len(var_67_7) / 40)) > 0 and var_67_6 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_5 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_5
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_6, arg_64_1.talkMaxDuration)

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_5) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_5 + var_67_10 and arg_64_1.time_ < var_67_5 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play929041017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 929041017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
			arg_68_1.auto_ = false
		end

		function arg_68_1.playNext_(arg_70_0)
			arg_68_1.onStoryFinished_()
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10148"]) and arg_68_1.var_.actorSpriteComps10148 == nil then
				arg_68_1.var_.actorSpriteComps10148 = arg_68_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10148"]) then
				if arg_68_1.var_.actorSpriteComps10148 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10148"]) and arg_68_1.var_.actorSpriteComps10148 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps10148 = nil
			end

			local var_71_2 = arg_68_1.actors_["10148"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10148 = var_71_2.localPosition
				var_71_2.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10148", 3)

				for iter_71_4 = 0, var_71_2.childCount - 1 do
					local var_71_3 = var_71_2:GetChild(iter_71_4)

					if var_71_3.name == "split_4" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_68_1.time_ - 0) / var_71_4)
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_71_5 = 0
			local var_71_6 = 0.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_7 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(929041017).content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 18 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 18)

				if (18 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_7) / 18)) > 0 and var_71_6 < var_71_9 then
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
				actorName = "10148",
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
	assets = {
		"TextureConfig/Background/ST0112"
	},
	voices = {}
}
