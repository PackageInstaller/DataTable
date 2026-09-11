return {
	Play910822001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910822001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910822002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18a")
				var_4_0.name = "ST18a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST18a

				arg_1_1.bgs_.ST18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18a" then
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

			local var_4_9 = "1111"

			if arg_1_1.actors_["1111"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1111")

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

			local var_4_12 = arg_1_1.actors_["1111"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1111", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_1" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_1_1.time_ - 2) / var_4_14)
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_4_15 = arg_1_1.actors_["1111"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1111 == nil then
				arg_1_1.var_.actorSpriteComps1111 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps1111 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor2.r, (arg_1_1.time_ - 2) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor2.g, (arg_1_1.time_ - 2) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor2.b, (arg_1_1.time_ - 2) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 0.5, (arg_1_1.time_ - 2) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps1111 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_1_1.var_.actorSpriteComps1111 = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_lower", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[623].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910822001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 11 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 11)

				if (11 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 11)) > 0 and var_4_20 < var_4_24 then
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play910822002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910822002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910822003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1111 = arg_7_1.actors_["1111"].transform.localPosition
				arg_7_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_7_1:CheckSpriteTmpPos("1111", 3)

				for iter_10_0 = 0, arg_7_1.actors_["1111"].transform.childCount - 1 do
					local var_10_0 = arg_7_1.actors_["1111"].transform:GetChild(iter_10_0)

					if var_10_0.name == "" or not string.find(var_10_0.name, "split") then
						var_10_0.gameObject:SetActive(true)
					else
						var_10_0.gameObject:SetActive(false)
					end
				end
			end

			local var_10_1 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_1 then
				arg_7_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_7_1.time_ - 0) / var_10_1)
			end

			if arg_7_1.time_ >= 0 + var_10_1 and arg_7_1.time_ < 0 + var_10_1 + arg_10_0 then
				arg_7_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_10_2 = arg_7_1.actors_["1111"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.actorSpriteComps1111 == nil then
				arg_7_1.var_.actorSpriteComps1111 = var_10_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_10_3 = 2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 and not isNil(var_10_2) then
				if arg_7_1.var_.actorSpriteComps1111 then
					for iter_10_1, iter_10_2 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_10_2 then
							if arg_7_1.isInRecall_ then
								iter_10_2.color = Color.New(Mathf.Lerp(iter_10_2.color.r, arg_7_1.hightColor1.r, (arg_7_1.time_ - 0) / var_10_3), Mathf.Lerp(iter_10_2.color.g, arg_7_1.hightColor1.g, (arg_7_1.time_ - 0) / var_10_3), (Mathf.Lerp(iter_10_2.color.b, arg_7_1.hightColor1.b, (arg_7_1.time_ - 0) / var_10_3)))
							else
								local var_10_4 = Mathf.Lerp(iter_10_2.color.r, 1, (arg_7_1.time_ - 0) / var_10_3)

								iter_10_2.color = Color.New(var_10_4, var_10_4, var_10_4)
							end
						end
					end
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.actorSpriteComps1111 then
				for iter_10_3, iter_10_4 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_10_4 then
						iter_10_4.color = arg_7_1.isInRecall_ and (arg_7_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_7_1.var_.actorSpriteComps1111 = nil
			end

			local var_10_5 = 0
			local var_10_6 = 0.55

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_7 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910822002).content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 22 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 22)

				if (22 <= 0 and var_10_6 or var_10_6 * (utf8.len(var_10_7) / 22)) > 0 and var_10_6 < var_10_9 then
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
				actorName = "1111",
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
	Play910822003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910822003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910822004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1111"]) and arg_11_1.var_.actorSpriteComps1111 == nil then
				arg_11_1.var_.actorSpriteComps1111 = arg_11_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_14_0 = 2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1111"]) then
				if arg_11_1.var_.actorSpriteComps1111 then
					for iter_14_0, iter_14_1 in pairs(arg_11_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_14_1 then
							if arg_11_1.isInRecall_ then
								iter_14_1.color = Color.New(Mathf.Lerp(iter_14_1.color.r, arg_11_1.hightColor2.r, (arg_11_1.time_ - 0) / var_14_0), Mathf.Lerp(iter_14_1.color.g, arg_11_1.hightColor2.g, (arg_11_1.time_ - 0) / var_14_0), (Mathf.Lerp(iter_14_1.color.b, arg_11_1.hightColor2.b, (arg_11_1.time_ - 0) / var_14_0)))
							else
								local var_14_1 = Mathf.Lerp(iter_14_1.color.r, 0.5, (arg_11_1.time_ - 0) / var_14_0)

								iter_14_1.color = Color.New(var_14_1, var_14_1, var_14_1)
							end
						end
					end
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1111"]) and arg_11_1.var_.actorSpriteComps1111 then
				for iter_14_2, iter_14_3 in pairs(arg_11_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_14_3 then
						iter_14_3.color = arg_11_1.isInRecall_ and (arg_11_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_11_1.var_.actorSpriteComps1111 = nil
			end

			local var_14_2 = 0
			local var_14_3 = 0.525

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_2 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_4 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910822003).content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_6 = 21 <= 0 and var_14_3 or var_14_3 * (utf8.len(var_14_4) / 21)

				if (21 <= 0 and var_14_3 or var_14_3 * (utf8.len(var_14_4) / 21)) > 0 and var_14_3 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_2 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_2
					end
				end

				arg_11_1.text_.text = var_14_4
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_3, arg_11_1.talkMaxDuration)

			if var_14_2 <= arg_11_1.time_ and arg_11_1.time_ < var_14_2 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_2) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_2 + var_14_7 and arg_11_1.time_ < var_14_2 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play910822004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910822004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910822005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1111 = arg_15_1.actors_["1111"].transform.localPosition
				arg_15_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1111", 3)

				for iter_18_0 = 0, arg_15_1.actors_["1111"].transform.childCount - 1 do
					local var_18_0 = arg_15_1.actors_["1111"].transform:GetChild(iter_18_0)

					if var_18_0.name == "" or not string.find(var_18_0.name, "split") then
						var_18_0.gameObject:SetActive(true)
					else
						var_18_0.gameObject:SetActive(false)
					end
				end
			end

			local var_18_1 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 then
				arg_15_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_15_1.time_ - 0) / var_18_1)
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 then
				arg_15_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_18_2 = arg_15_1.actors_["1111"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1111 == nil then
				arg_15_1.var_.actorSpriteComps1111 = var_18_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_3 = 2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_3 and not isNil(var_18_2) then
				if arg_15_1.var_.actorSpriteComps1111 then
					for iter_18_1, iter_18_2 in pairs(arg_15_1.var_.actorSpriteComps1111:ToTable()) do
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

			if arg_15_1.time_ >= 0 + var_18_3 and arg_15_1.time_ < 0 + var_18_3 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.actorSpriteComps1111 then
				for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_18_4 then
						iter_18_4.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_15_1.var_.actorSpriteComps1111 = nil
			end

			local var_18_5 = 0
			local var_18_6 = 0.45

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_7 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910822004).content)

				arg_15_1.text_.text = var_18_7

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 18 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_7) / 18)

				if (18 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_7) / 18)) > 0 and var_18_6 < var_18_9 then
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
				actorName = "1111",
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
	Play910822005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910822005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910822006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1111"]) and arg_19_1.var_.actorSpriteComps1111 == nil then
				arg_19_1.var_.actorSpriteComps1111 = arg_19_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_0 = 2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1111"]) then
				if arg_19_1.var_.actorSpriteComps1111 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								iter_22_1.color = Color.New(Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_0), Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_0), (Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_0)))
							else
								local var_22_1 = Mathf.Lerp(iter_22_1.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_0)

								iter_22_1.color = Color.New(var_22_1, var_22_1, var_22_1)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1111"]) and arg_19_1.var_.actorSpriteComps1111 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps1111 = nil
			end

			local var_22_2 = 0
			local var_22_3 = 0.05

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_4 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910822005).content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 2 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 2)

				if (2 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 2)) > 0 and var_22_3 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_7 and arg_19_1.time_ < var_22_2 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play910822006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910822006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910822007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1111 = arg_23_1.actors_["1111"].transform.localPosition
				arg_23_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1111", 3)

				for iter_26_0 = 0, arg_23_1.actors_["1111"].transform.childCount - 1 do
					local var_26_0 = arg_23_1.actors_["1111"].transform:GetChild(iter_26_0)

					if var_26_0.name == "split_3" or not string.find(var_26_0.name, "split") then
						var_26_0.gameObject:SetActive(true)
					else
						var_26_0.gameObject:SetActive(false)
					end
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_23_1.time_ - 0) / var_26_1)
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_26_2 = arg_23_1.actors_["1111"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1111 == nil then
				arg_23_1.var_.actorSpriteComps1111 = var_26_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_3 = 2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.actorSpriteComps1111 then
					for iter_26_1, iter_26_2 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_26_2 then
							if arg_23_1.isInRecall_ then
								iter_26_2.color = Color.New(Mathf.Lerp(iter_26_2.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 0) / var_26_3), Mathf.Lerp(iter_26_2.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 0) / var_26_3), (Mathf.Lerp(iter_26_2.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 0) / var_26_3)))
							else
								local var_26_4 = Mathf.Lerp(iter_26_2.color.r, 1, (arg_23_1.time_ - 0) / var_26_3)

								iter_26_2.color = Color.New(var_26_4, var_26_4, var_26_4)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.actorSpriteComps1111 then
				for iter_26_3, iter_26_4 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_26_4 then
						iter_26_4.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps1111 = nil
			end

			local var_26_5 = 0
			local var_26_6 = 0.65

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_7 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910822006).content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 26 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 26)

				if (26 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 26)) > 0 and var_26_6 < var_26_9 then
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
				actorName = "1111",
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
	Play910822007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910822007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910822008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1111"]) and arg_27_1.var_.actorSpriteComps1111 == nil then
				arg_27_1.var_.actorSpriteComps1111 = arg_27_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1111"]) then
				if arg_27_1.var_.actorSpriteComps1111 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1111"]) and arg_27_1.var_.actorSpriteComps1111 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1111 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.75

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910822007).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 30 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 30)

				if (30 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 30)) > 0 and var_30_3 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_7 and arg_27_1.time_ < var_30_2 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play910822008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910822008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910822009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1111 = arg_31_1.actors_["1111"].transform.localPosition
				arg_31_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1111", 3)

				for iter_34_0 = 0, arg_31_1.actors_["1111"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["1111"].transform:GetChild(iter_34_0)

					if var_34_0.name == "split_3" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_34_2 = arg_31_1.actors_["1111"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1111 == nil then
				arg_31_1.var_.actorSpriteComps1111 = var_34_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_3 = 2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.actorSpriteComps1111 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_34_2 then
							if arg_31_1.isInRecall_ then
								iter_34_2.color = Color.New(Mathf.Lerp(iter_34_2.color.r, arg_31_1.hightColor1.r, (arg_31_1.time_ - 0) / var_34_3), Mathf.Lerp(iter_34_2.color.g, arg_31_1.hightColor1.g, (arg_31_1.time_ - 0) / var_34_3), (Mathf.Lerp(iter_34_2.color.b, arg_31_1.hightColor1.b, (arg_31_1.time_ - 0) / var_34_3)))
							else
								local var_34_4 = Mathf.Lerp(iter_34_2.color.r, 1, (arg_31_1.time_ - 0) / var_34_3)

								iter_34_2.color = Color.New(var_34_4, var_34_4, var_34_4)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.actorSpriteComps1111 then
				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_34_4 then
						iter_34_4.color = arg_31_1.isInRecall_ and (arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_31_1.var_.actorSpriteComps1111 = nil
			end

			local var_34_5 = 0
			local var_34_6 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910822008).content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 18 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 18)

				if (18 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_7) / 18)) > 0 and var_34_6 < var_34_9 then
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
				actorName = "1111",
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
	Play910822009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910822009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910822010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1111"]) and arg_35_1.var_.actorSpriteComps1111 == nil then
				arg_35_1.var_.actorSpriteComps1111 = arg_35_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1111"]) then
				if arg_35_1.var_.actorSpriteComps1111 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1111"]) and arg_35_1.var_.actorSpriteComps1111 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps1111 = nil
			end

			local var_38_2 = 0
			local var_38_3 = 0.975

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
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

				local var_38_4 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910822009).content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 39 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 39)

				if (39 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 39)) > 0 and var_38_3 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_7 and arg_35_1.time_ < var_38_2 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play910822010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910822010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910822011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.925

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

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910822010).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 37 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 37)

				if (37 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 37)) > 0 and var_42_0 < var_42_3 then
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
	Play910822011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910822011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910822012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.175

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910822011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 7 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 7)

				if (7 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 7)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play910822012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910822012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910822013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1111 = arg_47_1.actors_["1111"].transform.localPosition
				arg_47_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1111", 3)

				for iter_50_0 = 0, arg_47_1.actors_["1111"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["1111"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_3" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_50_2 = arg_47_1.actors_["1111"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1111 == nil then
				arg_47_1.var_.actorSpriteComps1111 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps1111 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps1111 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps1111 = nil
			end

			local var_50_5 = 0
			local var_50_6 = 0.25

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910822012).content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 10 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_7) / 10)

				if (10 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_7) / 10)) > 0 and var_50_6 < var_50_9 then
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
				actorName = "1111",
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
	Play910822013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910822013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910822014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1111"]) and arg_51_1.var_.actorSpriteComps1111 == nil then
				arg_51_1.var_.actorSpriteComps1111 = arg_51_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1111"]) then
				if arg_51_1.var_.actorSpriteComps1111 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1111"]) and arg_51_1.var_.actorSpriteComps1111 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps1111 = nil
			end

			local var_54_2 = 0
			local var_54_3 = 0.625

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_4 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(910822013).content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 25 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 25)

				if (25 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 25)) > 0 and var_54_3 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_7 and arg_51_1.time_ < var_54_2 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play910822014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910822014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910822015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111 = arg_55_1.actors_["1111"].transform.localPosition
				arg_55_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1111", 3)

				for iter_58_0 = 0, arg_55_1.actors_["1111"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["1111"].transform:GetChild(iter_58_0)

					if var_58_0.name == "split_3" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_58_2 = arg_55_1.actors_["1111"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1111 == nil then
				arg_55_1.var_.actorSpriteComps1111 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps1111 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								iter_58_2.color = Color.New(Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_2.color.r, 1, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_2.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps1111 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps1111 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.15

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(910822014).content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 6 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 6)

				if (6 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_7) / 6)) > 0 and var_58_6 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_10 and arg_55_1.time_ < var_58_5 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111",
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
	Play910822015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910822015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910822016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1111"]) and arg_59_1.var_.actorSpriteComps1111 == nil then
				arg_59_1.var_.actorSpriteComps1111 = arg_59_1.actors_["1111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1111"]) then
				if arg_59_1.var_.actorSpriteComps1111 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1111"]) and arg_59_1.var_.actorSpriteComps1111 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps1111 = nil
			end

			local var_62_2 = 0
			local var_62_3 = 0.6

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(910822015).content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 24 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_4) / 24)

				if (24 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_4) / 24)) > 0 and var_62_3 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_7 and arg_59_1.time_ < var_62_2 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play910822016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910822016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910822017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.15

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(910822016).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 6 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 6)

				if (6 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 6)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play910822017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910822017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
			arg_67_1.auto_ = false
		end

		function arg_67_1.playNext_(arg_69_0)
			arg_67_1.onStoryFinished_()
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1111 = arg_67_1.actors_["1111"].transform.localPosition
				arg_67_1.actors_["1111"].transform.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1111", 3)

				for iter_70_0 = 0, arg_67_1.actors_["1111"].transform.childCount - 1 do
					local var_70_0 = arg_67_1.actors_["1111"].transform:GetChild(iter_70_0)

					if var_70_0.name == "" or not string.find(var_70_0.name, "split") then
						var_70_0.gameObject:SetActive(true)
					else
						var_70_0.gameObject:SetActive(false)
					end
				end
			end

			local var_70_1 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 then
				arg_67_1.actors_["1111"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1111, Vector3.New(-100, -290, -350), (arg_67_1.time_ - 0) / var_70_1)
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 then
				arg_67_1.actors_["1111"].transform.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_70_2 = arg_67_1.actors_["1111"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1111 == nil then
				arg_67_1.var_.actorSpriteComps1111 = var_70_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_3 = 2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.actorSpriteComps1111 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_70_2 then
							if arg_67_1.isInRecall_ then
								iter_70_2.color = Color.New(Mathf.Lerp(iter_70_2.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 0) / var_70_3), Mathf.Lerp(iter_70_2.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 0) / var_70_3), (Mathf.Lerp(iter_70_2.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 0) / var_70_3)))
							else
								local var_70_4 = Mathf.Lerp(iter_70_2.color.r, 1, (arg_67_1.time_ - 0) / var_70_3)

								iter_70_2.color = Color.New(var_70_4, var_70_4, var_70_4)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.actorSpriteComps1111 then
				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_70_4 then
						iter_70_4.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps1111 = nil
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_70_6 = 0
			local var_70_7 = 0.4

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(910822017).content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 16 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_8) / 16)

				if (16 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_8) / 16)) > 0 and var_70_7 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_11 and arg_67_1.time_ < var_70_6 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111",
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
	assets = {
		"TextureConfig/Background/ST18a"
	},
	voices = {}
}
