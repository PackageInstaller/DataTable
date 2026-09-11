return {
	Play61104001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 61104001
		arg_1_1.duration_ = 5.33

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
			arg_1_1.auto_ = false
		end

		function arg_1_1.playNext_(arg_3_0)
			arg_1_1.onStoryFinished_()
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["2530001"] == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_0.transform:SetSiblingIndex(1)

				var_4_0.name = "2530001"

				local var_4_1 = var_4_0:GetComponent(typeof(Image))

				var_4_1.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. "2530001")

				var_4_1:SetNativeSize()

				var_4_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_["2530001"] = var_4_0
			end

			local var_4_2 = arg_1_1.actors_["2530001"].transform

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos2530001 = var_4_2.localPosition
				var_4_2.localScale = Vector3.New(1, 1, 1)
			end

			local var_4_3 = 0.001

			if 0.333333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.333333333333333 + var_4_3 then
				var_4_2.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2530001, Vector3.New(0, -105, -200), (arg_1_1.time_ - 0.333333333333333) / var_4_3)
			end

			if arg_1_1.time_ >= 0.333333333333333 + var_4_3 and arg_1_1.time_ < 0.333333333333333 + var_4_3 + arg_4_0 then
				var_4_2.localPosition = Vector3.New(0, -105, -200)
			end

			local var_4_4 = arg_1_1.actors_["2530001"]

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 and not isNil(var_4_4) then
				local var_4_5 = var_4_4:GetComponent("Image")

				if var_4_5 then
					arg_1_1.var_.highlightMatValue2530001 = var_4_5
				end
			end

			local var_4_6 = 0.2

			if 0.333333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 0.333333333333333 + var_4_6 and not isNil(var_4_4) then
				if arg_1_1.var_.highlightMatValue2530001 then
					local var_4_7 = Mathf.Lerp(0.5, 1, (arg_1_1.time_ - 0.333333333333333) / var_4_6)

					arg_1_1.var_.highlightMatValue2530001.color.r = var_4_7
					arg_1_1.var_.highlightMatValue2530001.color.g = var_4_7
					arg_1_1.var_.highlightMatValue2530001.color.b = var_4_7
					arg_1_1.var_.highlightMatValue2530001.color = arg_1_1.var_.highlightMatValue2530001.color
				end
			end

			if arg_1_1.time_ >= 0.333333333333333 + var_4_6 and arg_1_1.time_ < 0.333333333333333 + var_4_6 + arg_4_0 and not isNil(var_4_4) and arg_1_1.var_.highlightMatValue2530001 then
				var_4_4.transform:SetSiblingIndex(1)

				arg_1_1.var_.highlightMatValue2530001.color.r = 1
				arg_1_1.var_.highlightMatValue2530001.color.g = 1
				arg_1_1.var_.highlightMatValue2530001.color.b = 1
				arg_1_1.var_.highlightMatValue2530001.color = arg_1_1.var_.highlightMatValue2530001.color
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_8 = 0.333333333333333
			local var_4_9 = 0.525

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_10 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_10:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(61104001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 21 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 21)

				if (21 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 21)) > 0 and var_4_9 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_8 = var_4_8 + 0.3

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_11
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_8 + 0.3
			local var_4_15 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2530001",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {}
}
