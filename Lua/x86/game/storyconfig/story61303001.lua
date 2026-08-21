return {
	Play61303001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 61303001
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
			local var_4_0 = "2530006"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_1.transform:SetSiblingIndex(1)

				var_4_1.name = var_4_0

				local var_4_2 = var_4_1:GetComponent(typeof(Image))

				var_4_2.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. "2530006")

				var_4_2:SetNativeSize()

				var_4_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_0] = var_4_1
			end

			local var_4_3 = arg_1_1.actors_["2530006"].transform
			local var_4_4 = 0.333333333333333

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.var_.moveOldPos2530006 = var_4_3.localPosition
				var_4_3.localScale = Vector3.New(1, 1, 1)
			end

			local var_4_5 = 0.001

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = (arg_1_1.time_ - var_4_4) / var_4_5
				local var_4_7 = Vector3.New(0, -50, -235)

				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2530006, var_4_7, var_4_6)
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(0, -50, -235)
			end

			local var_4_8 = arg_1_1.actors_["2530006"]
			local var_4_9 = 0.333333333333333

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 and not isNil(var_4_8) then
				local var_4_10 = var_4_8:GetComponent("Image")

				if var_4_10 then
					arg_1_1.var_.highlightMatValue2530006 = var_4_10
				end
			end

			local var_4_11 = 0.2

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 and not isNil(var_4_8) then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11

				if arg_1_1.var_.highlightMatValue2530006 then
					local var_4_13 = Mathf.Lerp(0.5, 1, var_4_12)
					local var_4_14 = arg_1_1.var_.highlightMatValue2530006
					local var_4_15 = var_4_14.color

					var_4_15.r = var_4_13
					var_4_15.g = var_4_13
					var_4_15.b = var_4_13
					var_4_14.color = var_4_15
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.highlightMatValue2530006 then
				local var_4_16 = 1

				var_4_8.transform:SetSiblingIndex(1)

				local var_4_17 = arg_1_1.var_.highlightMatValue2530006
				local var_4_18 = var_4_17.color

				var_4_18.r = var_4_16
				var_4_18.g = var_4_16
				var_4_18.b = var_4_16
				var_4_17.color = var_4_18
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 0.333333333333333
			local var_4_20 = 0.35

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
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

				local var_4_22 = arg_1_1:FormatText(StoryNameCfg[166].name)

				arg_1_1.leftNameTxt_.text = var_4_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(61303001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 14
				local var_4_26 = utf8.len(var_4_24)
				local var_4_27 = var_4_25 <= 0 and var_4_20 or var_4_20 * (var_4_26 / var_4_25)

				if var_4_27 > 0 and var_4_20 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_19 = var_4_19 + 0.3

					if var_4_27 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2530006",
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
