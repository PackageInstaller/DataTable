return {
	Play910837001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910837001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910837002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST05 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05")
				var_4_0.name = "ST05"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST05 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST05

				arg_1_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST05" then
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

			local var_4_8 = "1071"

			if arg_1_1.actors_["1071"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1071")

				if not isNil(var_4_9) then
					local var_4_10 = Object.Instantiate(var_4_9, arg_1_1.canvasGo_.transform)

					var_4_10.transform:SetSiblingIndex(1)

					var_4_10.name = var_4_8
					var_4_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_8] = var_4_10

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["1071"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1071 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1071", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_1" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_1_1.time_ - 1.8) / var_4_13)
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_4_14 = arg_1_1.actors_["1071"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1071 == nil then
				arg_1_1.var_.actorSpriteComps1071 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps1071 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor2.r, (arg_1_1.time_ - 1.8) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor2.g, (arg_1_1.time_ - 1.8) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor2.b, (arg_1_1.time_ - 1.8) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 0.5, (arg_1_1.time_ - 1.8) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps1071 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_1_1.var_.actorSpriteComps1071 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_lower", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.625

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910837001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 25 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 25)

				if (25 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 25)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play910837002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910837002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910837003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1071 = arg_7_1.actors_["1071"].transform.localPosition
				arg_7_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_7_1:CheckSpriteTmpPos("1071", 3)

				for iter_10_0 = 0, arg_7_1.actors_["1071"].transform.childCount - 1 do
					local var_10_0 = arg_7_1.actors_["1071"].transform:GetChild(iter_10_0)

					if var_10_0.name == "" or not string.find(var_10_0.name, "split") then
						var_10_0.gameObject:SetActive(true)
					else
						var_10_0.gameObject:SetActive(false)
					end
				end
			end

			local var_10_1 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_1 then
				arg_7_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_7_1.time_ - 0) / var_10_1)
			end

			if arg_7_1.time_ >= 0 + var_10_1 and arg_7_1.time_ < 0 + var_10_1 + arg_10_0 then
				arg_7_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_10_2 = arg_7_1.actors_["1071"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.actorSpriteComps1071 == nil then
				arg_7_1.var_.actorSpriteComps1071 = var_10_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_10_3 = 0.034

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 and not isNil(var_10_2) then
				if arg_7_1.var_.actorSpriteComps1071 then
					for iter_10_1, iter_10_2 in pairs(arg_7_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_10_2 then
							if arg_7_1.isInRecall_ then
								iter_10_2.color = Color.New(Mathf.Lerp(iter_10_2.color.r, arg_7_1.hightColor2.r, (arg_7_1.time_ - 0) / var_10_3), Mathf.Lerp(iter_10_2.color.g, arg_7_1.hightColor2.g, (arg_7_1.time_ - 0) / var_10_3), (Mathf.Lerp(iter_10_2.color.b, arg_7_1.hightColor2.b, (arg_7_1.time_ - 0) / var_10_3)))
							else
								local var_10_4 = Mathf.Lerp(iter_10_2.color.r, 0.5, (arg_7_1.time_ - 0) / var_10_3)

								iter_10_2.color = Color.New(var_10_4, var_10_4, var_10_4)
							end
						end
					end
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.actorSpriteComps1071 then
				for iter_10_3, iter_10_4 in pairs(arg_7_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_10_4 then
						iter_10_4.color = arg_7_1.isInRecall_ and (arg_7_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_7_1.var_.actorSpriteComps1071 = nil
			end

			local var_10_5 = 0
			local var_10_6 = 0.7

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_7 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910837002).content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 28 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 28)

				if (28 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 28)) > 0 and var_10_6 < var_10_9 then
					arg_7_1.talkMaxDuration = var_10_9

					if var_10_9 + var_10_5 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_9 + var_10_5
					end
				end

				arg_7_1.text_.text = var_10_7
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_10 = math.max(var_10_6, arg_7_1.talkMaxDuration)

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_10 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_5) / var_10_10

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_5 + var_10_10 and arg_7_1.time_ < var_10_5 + var_10_10 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
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

		arg_7_1:InitPlayNodeList()
	end,
	Play910837003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910837003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910837004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1071 = arg_11_1.actors_["1071"].transform.localPosition
				arg_11_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_11_1:CheckSpriteTmpPos("1071", 3)

				for iter_14_0 = 0, arg_11_1.actors_["1071"].transform.childCount - 1 do
					local var_14_0 = arg_11_1.actors_["1071"].transform:GetChild(iter_14_0)

					if var_14_0.name == "" or not string.find(var_14_0.name, "split") then
						var_14_0.gameObject:SetActive(true)
					else
						var_14_0.gameObject:SetActive(false)
					end
				end
			end

			local var_14_1 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_1 then
				arg_11_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_11_1.time_ - 0) / var_14_1)
			end

			if arg_11_1.time_ >= 0 + var_14_1 and arg_11_1.time_ < 0 + var_14_1 + arg_14_0 then
				arg_11_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_14_2 = arg_11_1.actors_["1071"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.actorSpriteComps1071 == nil then
				arg_11_1.var_.actorSpriteComps1071 = var_14_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_14_3 = 0.034

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 and not isNil(var_14_2) then
				if arg_11_1.var_.actorSpriteComps1071 then
					for iter_14_1, iter_14_2 in pairs(arg_11_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_14_2 then
							if arg_11_1.isInRecall_ then
								iter_14_2.color = Color.New(Mathf.Lerp(iter_14_2.color.r, arg_11_1.hightColor1.r, (arg_11_1.time_ - 0) / var_14_3), Mathf.Lerp(iter_14_2.color.g, arg_11_1.hightColor1.g, (arg_11_1.time_ - 0) / var_14_3), (Mathf.Lerp(iter_14_2.color.b, arg_11_1.hightColor1.b, (arg_11_1.time_ - 0) / var_14_3)))
							else
								local var_14_4 = Mathf.Lerp(iter_14_2.color.r, 1, (arg_11_1.time_ - 0) / var_14_3)

								iter_14_2.color = Color.New(var_14_4, var_14_4, var_14_4)
							end
						end
					end
				end
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.actorSpriteComps1071 then
				for iter_14_3, iter_14_4 in pairs(arg_11_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_14_4 then
						iter_14_4.color = arg_11_1.isInRecall_ and (arg_11_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_11_1.var_.actorSpriteComps1071 = nil
			end

			local var_14_5 = 0
			local var_14_6 = 0.9

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_5 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_7 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910837003).content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 36 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_7) / 36)

				if (36 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_7) / 36)) > 0 and var_14_6 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_5 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_5
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_10 = math.max(var_14_6, arg_11_1.talkMaxDuration)

			if var_14_5 <= arg_11_1.time_ and arg_11_1.time_ < var_14_5 + var_14_10 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_5) / var_14_10

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_5 + var_14_10 and arg_11_1.time_ < var_14_5 + var_14_10 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
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

		arg_11_1:InitPlayNodeList()
	end,
	Play910837004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910837004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910837005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1071 = arg_15_1.actors_["1071"].transform.localPosition
				arg_15_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1071", 3)

				for iter_18_0 = 0, arg_15_1.actors_["1071"].transform.childCount - 1 do
					local var_18_0 = arg_15_1.actors_["1071"].transform:GetChild(iter_18_0)

					if var_18_0.name == "split_1" or not string.find(var_18_0.name, "split") then
						var_18_0.gameObject:SetActive(true)
					else
						var_18_0.gameObject:SetActive(false)
					end
				end
			end

			local var_18_1 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 then
				arg_15_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_15_1.time_ - 0) / var_18_1)
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 then
				arg_15_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_18_2 = arg_15_1.actors_["1071"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1071 == nil then
				arg_15_1.var_.actorSpriteComps1071 = var_18_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_3 = 0.034

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_3 and not isNil(var_18_2) then
				if arg_15_1.var_.actorSpriteComps1071 then
					for iter_18_1, iter_18_2 in pairs(arg_15_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_18_2 then
							if arg_15_1.isInRecall_ then
								iter_18_2.color = Color.New(Mathf.Lerp(iter_18_2.color.r, arg_15_1.hightColor1.r, (arg_15_1.time_ - 0) / var_18_3), Mathf.Lerp(iter_18_2.color.g, arg_15_1.hightColor1.g, (arg_15_1.time_ - 0) / var_18_3), (Mathf.Lerp(iter_18_2.color.b, arg_15_1.hightColor1.b, (arg_15_1.time_ - 0) / var_18_3)))
							else
								local var_18_4 = Mathf.Lerp(iter_18_2.color.r, 1, (arg_15_1.time_ - 0) / var_18_3)

								iter_18_2.color = Color.New(var_18_4, var_18_4, var_18_4)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_3 and arg_15_1.time_ < 0 + var_18_3 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1071 then
				for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_18_4 then
						iter_18_4.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps1071 = nil
			end

			local var_18_5 = 0
			local var_18_6 = 0.775

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_7 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910837004).content)

				arg_15_1.text_.text = var_18_7

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 31 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_7) / 31)

				if (31 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_7) / 31)) > 0 and var_18_6 < var_18_9 then
					arg_15_1.talkMaxDuration = var_18_9

					if var_18_9 + var_18_5 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_9 + var_18_5
					end
				end

				arg_15_1.text_.text = var_18_7
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_10 = math.max(var_18_6, arg_15_1.talkMaxDuration)

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_10 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_5) / var_18_10

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_5 + var_18_10 and arg_15_1.time_ < var_18_5 + var_18_10 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play910837005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910837005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910837006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1071 = arg_19_1.actors_["1071"].transform.localPosition
				arg_19_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1071", 3)

				for iter_22_0 = 0, arg_19_1.actors_["1071"].transform.childCount - 1 do
					local var_22_0 = arg_19_1.actors_["1071"].transform:GetChild(iter_22_0)

					if var_22_0.name == "" or not string.find(var_22_0.name, "split") then
						var_22_0.gameObject:SetActive(true)
					else
						var_22_0.gameObject:SetActive(false)
					end
				end
			end

			local var_22_1 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_1 then
				arg_19_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_19_1.time_ - 0) / var_22_1)
			end

			if arg_19_1.time_ >= 0 + var_22_1 and arg_19_1.time_ < 0 + var_22_1 + arg_22_0 then
				arg_19_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_22_2 = arg_19_1.actors_["1071"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps1071 == nil then
				arg_19_1.var_.actorSpriteComps1071 = var_22_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_3 = 0.034

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 and not isNil(var_22_2) then
				if arg_19_1.var_.actorSpriteComps1071 then
					for iter_22_1, iter_22_2 in pairs(arg_19_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_22_2 then
							if arg_19_1.isInRecall_ then
								iter_22_2.color = Color.New(Mathf.Lerp(iter_22_2.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_3), Mathf.Lerp(iter_22_2.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_3), (Mathf.Lerp(iter_22_2.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_3)))
							else
								local var_22_4 = Mathf.Lerp(iter_22_2.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_3)

								iter_22_2.color = Color.New(var_22_4, var_22_4, var_22_4)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps1071 then
				for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_22_4 then
						iter_22_4.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps1071 = nil
			end

			local var_22_5 = 0
			local var_22_6 = 0.275

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[623].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_7 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910837005).content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 11 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 11)

				if (11 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 11)) > 0 and var_22_6 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_5
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_6, arg_19_1.talkMaxDuration)

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_5) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_5 + var_22_10 and arg_19_1.time_ < var_22_5 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play910837006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910837006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910837007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1071 = arg_23_1.actors_["1071"].transform.localPosition
				arg_23_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1071", 3)

				for iter_26_0 = 0, arg_23_1.actors_["1071"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["1071"].transform:GetChild(iter_26_0)

					if var_26_0.name == "" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_23_1.time_ - 0) / var_26_1)
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_26_2 = arg_23_1.actors_["1071"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1071 == nil then
				arg_23_1.var_.actorSpriteComps1071 = var_26_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_3 = 0.034

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.actorSpriteComps1071 then
					for iter_26_1, iter_26_2 in pairs(arg_23_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_26_2 then
							if arg_23_1.isInRecall_ then
								iter_26_2.color = Color.New(Mathf.Lerp(iter_26_2.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_3), Mathf.Lerp(iter_26_2.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_3), (Mathf.Lerp(iter_26_2.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_3)))
							else
								local var_26_4 = Mathf.Lerp(iter_26_2.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_3)

								iter_26_2.color = Color.New(var_26_4, var_26_4, var_26_4)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1071 then
				for iter_26_3, iter_26_4 in pairs(arg_23_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_26_4 then
						iter_26_4.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps1071 = nil
			end

			local var_26_5 = 0
			local var_26_6 = 0.05

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_7 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910837006).content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 2 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 2)

				if (2 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 2)) > 0 and var_26_6 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_5
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_6, arg_23_1.talkMaxDuration)

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_5) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_5 + var_26_10 and arg_23_1.time_ < var_26_5 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play910837007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910837007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910837008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1071 = arg_27_1.actors_["1071"].transform.localPosition
				arg_27_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1071", 3)

				for iter_30_0 = 0, arg_27_1.actors_["1071"].transform.childCount - 1 do
					local var_30_0 = arg_27_1.actors_["1071"].transform:GetChild(iter_30_0)

					if var_30_0.name == "split_1" or not string.find(var_30_0.name, "split") then
						var_30_0.gameObject:SetActive(true)
					else
						var_30_0.gameObject:SetActive(false)
					end
				end
			end

			local var_30_1 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_1 then
				arg_27_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_27_1.time_ - 0) / var_30_1)
			end

			if arg_27_1.time_ >= 0 + var_30_1 and arg_27_1.time_ < 0 + var_30_1 + arg_30_0 then
				arg_27_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_30_2 = arg_27_1.actors_["1071"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps1071 == nil then
				arg_27_1.var_.actorSpriteComps1071 = var_30_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_3 = 0.034

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.actorSpriteComps1071 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								iter_30_2.color = Color.New(Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_3), Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_3), (Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_3)))
							else
								local var_30_4 = Mathf.Lerp(iter_30_2.color.r, 1, (arg_27_1.time_ - 0) / var_30_3)

								iter_30_2.color = Color.New(var_30_4, var_30_4, var_30_4)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.actorSpriteComps1071 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_30_4 then
						iter_30_4.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1071 = nil
			end

			local var_30_5 = 0
			local var_30_6 = 0.725

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910837007).content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 29 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 29)

				if (29 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_7) / 29)) > 0 and var_30_6 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_10 and arg_27_1.time_ < var_30_5 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play910837008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910837008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910837009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1071 = arg_31_1.actors_["1071"].transform.localPosition
				arg_31_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1071", 3)

				for iter_34_0 = 0, arg_31_1.actors_["1071"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["1071"].transform:GetChild(iter_34_0)

					if var_34_0.name == "" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_34_2 = arg_31_1.actors_["1071"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1071 == nil then
				arg_31_1.var_.actorSpriteComps1071 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 0.034

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps1071 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_34_2 then
							if arg_31_1.isInRecall_ then
								iter_34_2.color = Color.New(Mathf.Lerp(iter_34_2.color.r, arg_31_1.hightColor2.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_2.color.g, arg_31_1.hightColor2.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_2.color.b, arg_31_1.hightColor2.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_2.color.r, 0.5, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_2.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1071 then
				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_34_4 then
						iter_34_4.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_31_1.var_.actorSpriteComps1071 = nil
			end

			local var_34_5 = 0
			local var_34_6 = 0.275

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[623].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910837008).content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 11 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 11)

				if (11 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 11)) > 0 and var_34_6 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_5
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_6, arg_31_1.talkMaxDuration)

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_5) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_5 + var_34_10 and arg_31_1.time_ < var_34_5 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play910837009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910837009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910837010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1071 = arg_35_1.actors_["1071"].transform.localPosition
				arg_35_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1071", 3)

				for iter_38_0 = 0, arg_35_1.actors_["1071"].transform.childCount - 1 do
					local var_38_0 = arg_35_1.actors_["1071"].transform:GetChild(iter_38_0)

					if var_38_0.name == "" or not string.find(var_38_0.name, "split") then
						var_38_0.gameObject:SetActive(true)
					else
						var_38_0.gameObject:SetActive(false)
					end
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_35_1.time_ - 0) / var_38_1)
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_38_2 = arg_35_1.actors_["1071"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps1071 == nil then
				arg_35_1.var_.actorSpriteComps1071 = var_38_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_3 = 0.034

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.actorSpriteComps1071 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps1071:ToTable()) do
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

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps1071 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_38_4 then
						iter_38_4.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps1071 = nil
			end

			local var_38_5 = 0
			local var_38_6 = 0.075

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_7 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910837009).content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_7) / 3)

				if (3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_7) / 3)) > 0 and var_38_6 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_10 and arg_35_1.time_ < var_38_5 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play910837010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910837010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910837011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1071 = arg_39_1.actors_["1071"].transform.localPosition
				arg_39_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1071", 3)

				for iter_42_0 = 0, arg_39_1.actors_["1071"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["1071"].transform:GetChild(iter_42_0)

					if var_42_0.name == "split_2" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_42_2 = arg_39_1.actors_["1071"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps1071 == nil then
				arg_39_1.var_.actorSpriteComps1071 = var_42_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_3 = 0.034

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.actorSpriteComps1071 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								iter_42_2.color = Color.New(Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_3), Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_3), (Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_3)))
							else
								local var_42_4 = Mathf.Lerp(iter_42_2.color.r, 1, (arg_39_1.time_ - 0) / var_42_3)

								iter_42_2.color = Color.New(var_42_4, var_42_4, var_42_4)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.actorSpriteComps1071 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps1071 = nil
			end

			local var_42_5 = 0
			local var_42_6 = 0.7

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910837010).content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 28 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 28)

				if (28 <= 0 and var_42_6 or var_42_6 * (utf8.len(var_42_7) / 28)) > 0 and var_42_6 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_5 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_5
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_6, arg_39_1.talkMaxDuration)

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_5) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_5 + var_42_10 and arg_39_1.time_ < var_42_5 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play910837011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910837011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910837012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1071 = arg_43_1.actors_["1071"].transform.localPosition
				arg_43_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1071", 3)

				for iter_46_0 = 0, arg_43_1.actors_["1071"].transform.childCount - 1 do
					local var_46_0 = arg_43_1.actors_["1071"].transform:GetChild(iter_46_0)

					if var_46_0.name == "" or not string.find(var_46_0.name, "split") then
						var_46_0.gameObject:SetActive(true)
					else
						var_46_0.gameObject:SetActive(false)
					end
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_43_1.time_ - 0) / var_46_1)
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_46_2 = arg_43_1.actors_["1071"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps1071 == nil then
				arg_43_1.var_.actorSpriteComps1071 = var_46_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_3 = 0.034

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.actorSpriteComps1071 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								iter_46_2.color = Color.New(Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_3), Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_3), (Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_3)))
							else
								local var_46_4 = Mathf.Lerp(iter_46_2.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_3)

								iter_46_2.color = Color.New(var_46_4, var_46_4, var_46_4)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.actorSpriteComps1071 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_46_4 then
						iter_46_4.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps1071 = nil
			end

			local var_46_5 = 0
			local var_46_6 = 0.275

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[623].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910837011).content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 11 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_7) / 11)

				if (11 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_7) / 11)) > 0 and var_46_6 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_6, arg_43_1.talkMaxDuration)

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_5) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_5 + var_46_10 and arg_43_1.time_ < var_46_5 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play910837012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910837012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910837013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1071 = arg_47_1.actors_["1071"].transform.localPosition
				arg_47_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1071", 3)

				for iter_50_0 = 0, arg_47_1.actors_["1071"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["1071"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_1" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_50_2 = arg_47_1.actors_["1071"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1071 == nil then
				arg_47_1.var_.actorSpriteComps1071 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 0.034

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps1071 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1071 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps1071 = nil
			end

			local var_50_5 = 0
			local var_50_6 = 0.275

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_7 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910837012).content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 11 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_7) / 11)

				if (11 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_7) / 11)) > 0 and var_50_6 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_10 and arg_47_1.time_ < var_50_5 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play910837013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910837013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
			arg_51_1.auto_ = false
		end

		function arg_51_1.playNext_(arg_53_0)
			arg_51_1.onStoryFinished_()
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1071 = arg_51_1.actors_["1071"].transform.localPosition
				arg_51_1.actors_["1071"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1071", 3)

				for iter_54_0 = 0, arg_51_1.actors_["1071"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["1071"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1071"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1071, Vector3.New(13.6, -446.9, -45.9), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1071"].transform.localPosition = Vector3.New(13.6, -446.9, -45.9)
			end

			local var_54_2 = arg_51_1.actors_["1071"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1071 == nil then
				arg_51_1.var_.actorSpriteComps1071 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.034

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps1071 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								iter_54_2.color = Color.New(Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_2.color.r, 1, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_2.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps1071 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_54_4 then
						iter_54_4.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps1071 = nil
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_54_6 = 0
			local var_54_7 = 0.775

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(910837013).content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 31 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 31)

				if (31 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 31)) > 0 and var_54_7 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_11 and arg_51_1.time_ < var_54_6 + var_54_11 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST05"
	},
	voices = {}
}
