return {
	Play910110001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910110001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910110002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I03")
				var_4_0.name = "I03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I03

				arg_1_1.bgs_.I03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I03" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_8 = 2
			local var_4_9 = 0.85

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[352].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910110001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 34 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 34)

				if (34 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 34)) > 0 and var_4_9 < var_4_13 then
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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play910110002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910110002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910110003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.1

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910110002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 44 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 44)

				if (44 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 44)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play910110003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910110003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910110004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.625

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[352].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910110003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 25)

				if (25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 25)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play910110004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910110004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910110005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.725

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910110004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 29 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 29)

				if (29 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 29)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play910110005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910110005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910110006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 1.125

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910110005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 45 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 45)

				if (45 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 45)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play910110006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910110006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910110007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910110006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 58 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 58)

				if (58 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 58)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play910110007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910110007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910110008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.325

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[352].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910110007).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 13)

				if (13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 13)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play910110008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910110008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910110009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.05

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910110008).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 2 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 2)

				if (2 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 2)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play910110009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910110009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910110010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.325

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910110009).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 13 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 13)

				if (13 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 13)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play910110010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910110010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910110011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.375

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[352].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910110010).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 15 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 15)

				if (15 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 15)) > 0 and var_42_0 < var_42_3 then
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
	Play910110011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910110011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910110012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1.2

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910110011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 48 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 48)

				if (48 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 48)) > 0 and var_46_0 < var_46_3 then
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
	Play910110012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910110012
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910110013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.ST34 == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST34")
				var_50_0.name = "ST34"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.ST34 = var_50_0
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.ST34

				arg_47_1.bgs_.ST34.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST34" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_5 = 2

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_5 then
				local var_50_6 = Color.New(0, 0, 0)

				var_50_6.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_4) / var_50_5)
				arg_47_1.mask_.color = var_50_6
			end

			if arg_47_1.time_ >= var_50_4 + var_50_5 and arg_47_1.time_ < var_50_4 + var_50_5 + arg_50_0 then
				local var_50_7 = Color.New(0, 0, 0)

				var_50_7.a = 1
				arg_47_1.mask_.color = var_50_7
			end

			local var_50_8 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = Color.New(0, 0, 0)

				var_50_10.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_8) / var_50_9)
				arg_47_1.mask_.color = var_50_10
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 then
				local var_50_11 = Color.New(0, 0, 0)

				arg_47_1.mask_.enabled = false
				var_50_11.a = 0
				arg_47_1.mask_.color = var_50_11
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_12 = 4
			local var_50_13 = 1.375

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_14 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_14:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_15 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910110012).content)

				arg_47_1.text_.text = var_50_15

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 55 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 55)

				if (55 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 55)) > 0 and var_50_13 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17
					var_50_12 = var_50_12 + 0.3

					if var_50_17 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_15
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_18 = var_50_12 + 0.3
			local var_50_19 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_18 + var_50_19 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_18) / var_50_19

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_18 + var_50_19 and arg_47_1.time_ < var_50_18 + var_50_19 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play910110013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 910110013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play910110014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(910110013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)

				if (27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play910110014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 910110014
		arg_57_1.duration_ = 7

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play910110015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["1066"] == nil then
				local var_60_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_60_0) then
					local var_60_1 = Object.Instantiate(var_60_0, arg_57_1.canvasGo_.transform)

					var_60_1.transform:SetSiblingIndex(1)

					var_60_1.name = "1066"
					var_60_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_["1066"] = var_60_1

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs((var_60_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_2 = arg_57_1.actors_["1066"].transform

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				arg_57_1.var_.moveOldPos1066 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1066", 3)

				for iter_60_2 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_2)

					if var_60_3.name == "split_1" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 2 <= arg_57_1.time_ and arg_57_1.time_ < 2 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1066, Vector3.New(0, -350, -180), (arg_57_1.time_ - 2) / var_60_4)
			end

			if arg_57_1.time_ >= 2 + var_60_4 and arg_57_1.time_ < 2 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_60_5 = arg_57_1.actors_["1066"]

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps1066 == nil then
				arg_57_1.var_.actorSpriteComps1066 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 0.2

			if 2 <= arg_57_1.time_ and arg_57_1.time_ < 2 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.actorSpriteComps1066 then
					for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_60_4 then
							if arg_57_1.isInRecall_ then
								iter_60_4.color = Color.New(Mathf.Lerp(iter_60_4.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 2) / var_60_6), Mathf.Lerp(iter_60_4.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 2) / var_60_6), (Mathf.Lerp(iter_60_4.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 2) / var_60_6)))
							else
								local var_60_7 = Mathf.Lerp(iter_60_4.color.r, 1, (arg_57_1.time_ - 2) / var_60_6)

								iter_60_4.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 2 + var_60_6 and arg_57_1.time_ < 2 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps1066 then
				for iter_60_5, iter_60_6 in pairs(arg_57_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_60_6 then
						iter_60_6.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1066 = nil
			end

			local var_60_8 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_9 = 2

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				local var_60_10 = Color.New(1, 1, 1)

				var_60_10.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_8) / var_60_9)
				arg_57_1.mask_.color = var_60_10
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				local var_60_11 = Color.New(1, 1, 1)

				arg_57_1.mask_.enabled = false
				var_60_11.a = 0
				arg_57_1.mask_.color = var_60_11
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_12 = 2
			local var_60_13 = 1.35

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_14 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_14:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(910110014).content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 54 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 54)

				if (54 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 54)) > 0 and var_60_13 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17
					var_60_12 = var_60_12 + 0.3

					if var_60_17 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = var_60_12 + 0.3
			local var_60_19 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_18) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_18 + var_60_19 and arg_57_1.time_ < var_60_18 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play910110015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910110015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910110016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1066"]) and arg_63_1.var_.actorSpriteComps1066 == nil then
				arg_63_1.var_.actorSpriteComps1066 = arg_63_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1066"]) then
				if arg_63_1.var_.actorSpriteComps1066 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1066"]) and arg_63_1.var_.actorSpriteComps1066 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps1066 = nil
			end

			local var_66_2 = 0
			local var_66_3 = 0.65

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_4 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(910110015).content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 26 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 26)

				if (26 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 26)) > 0 and var_66_3 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_7 and arg_63_1.time_ < var_66_2 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play910110016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910110016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910110017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.65

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(910110016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)

				if (26 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 26)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play910110017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910110017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play910110018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(910110017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 42 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 42)

				if (42 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 42)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play910110018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910110018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play910110019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.275

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(910110018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 11 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 11)

				if (11 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 11)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play910110019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 910110019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play910110020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1066"]) and arg_79_1.var_.actorSpriteComps1066 == nil then
				arg_79_1.var_.actorSpriteComps1066 = arg_79_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1066"]) then
				if arg_79_1.var_.actorSpriteComps1066 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 1, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1066"]) and arg_79_1.var_.actorSpriteComps1066 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1066 = nil
			end

			if 0.375 < arg_79_1.time_ and arg_79_1.time_ <= 0.375 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door02", "")
			end

			local var_82_3 = manager.ui.mainCamera.transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_3.localPosition
			end

			local var_82_4 = 0.6

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				local var_82_5, var_82_6 = math.modf((arg_79_1.time_ - 0) / 0.066)

				var_82_3.localPosition = Vector3.New(var_82_6 * 0.13, var_82_6 * 0.13, var_82_6 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = arg_79_1.var_.shakeOldPos
			end

			local var_82_7 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_7 + 0.6 and arg_79_1.time_ < var_82_7 + 0.6 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_8 = 0
			local var_82_9 = 0.375

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(910110019).content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 15 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 15)

				if (15 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 15)) > 0 and var_82_9 < var_82_12 then
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

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play910110020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 910110020
		arg_83_1.duration_ = 9

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play910110021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.bgs_.ST17 == nil then
				local var_86_0 = Object.Instantiate(arg_83_1.paintGo_)

				var_86_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_86_0.name = "ST17"
				var_86_0.transform.parent = arg_83_1.stage_.transform
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.bgs_.ST17 = var_86_0
			end

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= 2 + arg_86_0 then
				local var_86_1 = arg_83_1.bgs_.ST17

				arg_83_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_86_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_2 = var_86_1:GetComponent("SpriteRenderer")

				if var_86_2 and var_86_2.sprite then
					local var_86_3 = 2 * (var_86_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_86_1.transform.localScale = Vector3.New(var_86_3 / var_86_2.sprite.bounds.size.y < var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x and var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x or var_86_3 / var_86_2.sprite.bounds.size.y, var_86_3 / var_86_2.sprite.bounds.size.y < var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x and var_86_3 * manager.ui.mainCameraCom_.aspect / var_86_2.sprite.bounds.size.x or var_86_3 / var_86_2.sprite.bounds.size.y, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "ST17" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_4 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_5 = 2

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_5 then
				local var_86_6 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_6.a = Mathf.Lerp(0, 1, (arg_83_1.time_ - var_86_4) / var_86_5)
				arg_83_1.mask_.color = var_86_6
			end

			if arg_83_1.time_ >= var_86_4 + var_86_5 and arg_83_1.time_ < var_86_4 + var_86_5 + arg_86_0 then
				local var_86_7 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_7.a = 1
				arg_83_1.mask_.color = var_86_7
			end

			local var_86_8 = 2

			if 2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_9 = 2

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 then
				local var_86_10 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_10.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_8) / var_86_9)
				arg_83_1.mask_.color = var_86_10
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 then
				local var_86_11 = Color.New(0.01886791, 0.01886791, 0.01886791)

				arg_83_1.mask_.enabled = false
				var_86_11.a = 0
				arg_83_1.mask_.color = var_86_11
			end

			local var_86_12 = arg_83_1.actors_["1066"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1066 = var_86_12.localPosition
				var_86_12.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1066", 7)

				for iter_86_2 = 0, var_86_12.childCount - 1 do
					local var_86_13 = var_86_12:GetChild(iter_86_2)

					if var_86_13.name == "split_1" or not string.find(var_86_13.name, "split") then
						var_86_13.gameObject:SetActive(true)
					else
						var_86_13.gameObject:SetActive(false)
					end
				end
			end

			local var_86_14 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_14 then
				var_86_12.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1066, Vector3.New(0, -2000, -180), (arg_83_1.time_ - 0) / var_86_14)
			end

			if arg_83_1.time_ >= 0 + var_86_14 and arg_83_1.time_ < 0 + var_86_14 + arg_86_0 then
				var_86_12.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_15 = 4
			local var_86_16 = 0.975

			if 4 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_17 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_17:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(910110020).content)

				arg_83_1.text_.text = var_86_18

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 39 <= 0 and var_86_16 or var_86_16 * (utf8.len(var_86_18) / 39)

				if (39 <= 0 and var_86_16 or var_86_16 * (utf8.len(var_86_18) / 39)) > 0 and var_86_16 < var_86_20 then
					arg_83_1.talkMaxDuration = var_86_20
					var_86_15 = var_86_15 + 0.3

					if var_86_20 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_18
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_21 = var_86_15 + 0.3
			local var_86_22 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_21) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_21 + var_86_22 and arg_83_1.time_ < var_86_21 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play910110021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910110021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910110022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.actors_["1070"] == nil then
				local var_92_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1070")

				if not isNil(var_92_0) then
					local var_92_1 = Object.Instantiate(var_92_0, arg_89_1.canvasGo_.transform)

					var_92_1.transform:SetSiblingIndex(1)

					var_92_1.name = "1070"
					var_92_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_89_1.actors_["1070"] = var_92_1

					if arg_89_1.isInRecall_ then
						for iter_92_0, iter_92_1 in ipairs((var_92_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_92_1.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_92_2 = arg_89_1.actors_["1070"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1070 == nil then
				arg_89_1.var_.actorSpriteComps1070 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps1070 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								iter_92_3.color = Color.New(Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor1.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor1.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor1.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_3.color.r, 1, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_3.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps1070 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_92_5 then
						iter_92_5.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1070 = nil
			end

			local var_92_5 = arg_89_1.actors_["1070"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1070 = var_92_5.localPosition
				var_92_5.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1070", 3)

				for iter_92_6 = 0, var_92_5.childCount - 1 do
					local var_92_6 = var_92_5:GetChild(iter_92_6)

					if var_92_6.name == "split_3" or not string.find(var_92_6.name, "split") then
						var_92_6.gameObject:SetActive(true)
					else
						var_92_6.gameObject:SetActive(false)
					end
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_89_1.time_ - 0) / var_92_7)
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				local var_92_8 = arg_89_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_92_8 then
					arg_89_1.var_.alphaOldValue1070 = var_92_8.alpha
					arg_89_1.var_.characterEffect1070 = var_92_8
				end

				arg_89_1.var_.alphaOldValue1070 = 0
			end

			local var_92_9 = 0.5

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_9 then
				if arg_89_1.var_.characterEffect1070 then
					arg_89_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_89_1.var_.alphaOldValue1070, 1, (arg_89_1.time_ - 0) / var_92_9)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_9 and arg_89_1.time_ < 0 + var_92_9 + arg_92_0 and arg_89_1.var_.characterEffect1070 then
				arg_89_1.var_.characterEffect1070.alpha = 1
			end

			local var_92_10 = 0
			local var_92_11 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_12 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(910110021).content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_14 = 37 <= 0 and var_92_11 or var_92_11 * (utf8.len(var_92_12) / 37)

				if (37 <= 0 and var_92_11 or var_92_11 * (utf8.len(var_92_12) / 37)) > 0 and var_92_11 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_10
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_11, arg_89_1.talkMaxDuration)

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_10) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_10 + var_92_15 and arg_89_1.time_ < var_92_10 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
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
	Play910110022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910110022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910110023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1070"]) and arg_93_1.var_.actorSpriteComps1070 == nil then
				arg_93_1.var_.actorSpriteComps1070 = arg_93_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1070"]) then
				if arg_93_1.var_.actorSpriteComps1070 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1070"]) and arg_93_1.var_.actorSpriteComps1070 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1070 = nil
			end

			local var_96_2 = 0
			local var_96_3 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[358].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_4 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(910110022).content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 12)

				if (12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 12)) > 0 and var_96_3 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_7 and arg_93_1.time_ < var_96_2 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play910110023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910110023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910110024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.8

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[358].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(910110023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 32 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 32)

				if (32 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 32)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play910110024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910110024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910110025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(910110024).content)

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
	Play910110025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910110025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910110026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1070"]) and arg_105_1.var_.actorSpriteComps1070 == nil then
				arg_105_1.var_.actorSpriteComps1070 = arg_105_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1070"]) then
				if arg_105_1.var_.actorSpriteComps1070 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1070:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1070"]) and arg_105_1.var_.actorSpriteComps1070 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps1070 = nil
			end

			local var_108_2 = arg_105_1.actors_["1070"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1070 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1070", 3)

				for iter_108_4 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_4)

					if var_108_3.name == "split_2" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_108_5 = 0
			local var_108_6 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(910110025).content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 19 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 19)

				if (19 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 19)) > 0 and var_108_6 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_10 and arg_105_1.time_ < var_108_5 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play910110026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910110026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910110027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1070"]) and arg_109_1.var_.actorSpriteComps1070 == nil then
				arg_109_1.var_.actorSpriteComps1070 = arg_109_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1070"]) then
				if arg_109_1.var_.actorSpriteComps1070 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1070"]) and arg_109_1.var_.actorSpriteComps1070 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps1070 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 0.625

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[359].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_4 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(910110026).content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 25 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 25)

				if (25 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 25)) > 0 and var_112_3 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_7 and arg_109_1.time_ < var_112_2 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play910110027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910110027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910110028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.075

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(910110027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 3 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 3)

				if (3 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 3)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play910110028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910110028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910110029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1070 = arg_117_1.actors_["1070"].transform.localPosition
				arg_117_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1070", 3)

				for iter_120_0 = 0, arg_117_1.actors_["1070"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["1070"].transform:GetChild(iter_120_0)

					if var_120_0.name == "split_1" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_120_2 = arg_117_1.actors_["1070"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1070 == nil then
				arg_117_1.var_.actorSpriteComps1070 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps1070 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 1, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps1070 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1070 = nil
			end

			local var_120_5 = 0
			local var_120_6 = 0.425

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(910110028).content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 17 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_7) / 17)

				if (17 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_7) / 17)) > 0 and var_120_6 < var_120_9 then
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
				actorName = "1070",
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
	Play910110029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910110029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910110030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1070"]) and arg_121_1.var_.actorSpriteComps1070 == nil then
				arg_121_1.var_.actorSpriteComps1070 = arg_121_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1070"]) then
				if arg_121_1.var_.actorSpriteComps1070 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1070"]) and arg_121_1.var_.actorSpriteComps1070 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1070 = nil
			end

			local var_124_2 = 0
			local var_124_3 = 0.075

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_4 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(910110029).content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 3 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 3)

				if (3 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 3)) > 0 and var_124_3 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_7 and arg_121_1.time_ < var_124_2 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play910110030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910110030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910110031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(910110030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 21)

				if (21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 21)) > 0 and var_128_0 < var_128_3 then
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
	Play910110031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910110031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910110032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1070"]) and arg_129_1.var_.actorSpriteComps1070 == nil then
				arg_129_1.var_.actorSpriteComps1070 = arg_129_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1070"]) then
				if arg_129_1.var_.actorSpriteComps1070 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1070:ToTable()) do
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

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1070"]) and arg_129_1.var_.actorSpriteComps1070 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps1070 = nil
			end

			local var_132_2 = arg_129_1.actors_["1070"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1070 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1070", 3)

				for iter_132_4 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_4)

					if var_132_3.name == "split_2" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_132_5 = 0
			local var_132_6 = 0.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(910110031).content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 18 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_7) / 18)

				if (18 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_7) / 18)) > 0 and var_132_6 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_10 and arg_129_1.time_ < var_132_5 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
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
	Play910110032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910110032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910110033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1070"]) and arg_133_1.var_.actorSpriteComps1070 == nil then
				arg_133_1.var_.actorSpriteComps1070 = arg_133_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1070"]) then
				if arg_133_1.var_.actorSpriteComps1070 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1070"]) and arg_133_1.var_.actorSpriteComps1070 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps1070 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.6

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(910110032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 24 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 24)

				if (24 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 24)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play910110033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910110033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910110034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1070 = arg_137_1.actors_["1070"].transform.localPosition
				arg_137_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1070", 7)

				for iter_140_0 = 0, arg_137_1.actors_["1070"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1070"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_2" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1070"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_140_2 = 0
			local var_140_3 = 0.725

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(910110033).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 29 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 29)

				if (29 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 29)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play910110034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910110034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910110035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:AudioAction("play", "effect", "se_story_9", "se_story_9_hit02", "")
			end

			local var_144_1 = manager.ui.mainCamera.transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_1.localPosition
			end

			local var_144_2 = 0.6

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 then
				local var_144_3, var_144_4 = math.modf((arg_141_1.time_ - 0) / 0.066)

				var_144_1.localPosition = Vector3.New(var_144_4 * 0.13, var_144_4 * 0.13, var_144_4 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 then
				var_144_1.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_5 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_5 + 0.6 and arg_141_1.time_ < var_144_5 + 0.6 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_6 = 0
			local var_144_7 = 1.325

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(910110034).content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 53 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_8) / 53)

				if (53 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_8) / 53)) > 0 and var_144_7 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_11 and arg_141_1.time_ < var_144_6 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play910110035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910110035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910110036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1070 = arg_145_1.actors_["1070"].transform.localPosition
				arg_145_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1070", 3)

				for iter_148_0 = 0, arg_145_1.actors_["1070"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1070"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_9" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_148_2 = arg_145_1.actors_["1070"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1070 == nil then
				arg_145_1.var_.actorSpriteComps1070 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.0166666666666667

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps1070 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps1070 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1070 = nil
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				local var_148_5 = arg_145_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_148_5 then
					arg_145_1.var_.alphaOldValue1070 = var_148_5.alpha
					arg_145_1.var_.characterEffect1070 = var_148_5
				end

				arg_145_1.var_.alphaOldValue1070 = 0
			end

			local var_148_6 = 0.5

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 then
				if arg_145_1.var_.characterEffect1070 then
					arg_145_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_145_1.var_.alphaOldValue1070, 1, (arg_145_1.time_ - 0) / var_148_6)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and arg_145_1.var_.characterEffect1070 then
				arg_145_1.var_.characterEffect1070.alpha = 1
			end

			local var_148_7 = 0
			local var_148_8 = 0.425

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_9 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(910110035).content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 17 <= 0 and var_148_8 or var_148_8 * (utf8.len(var_148_9) / 17)

				if (17 <= 0 and var_148_8 or var_148_8 * (utf8.len(var_148_9) / 17)) > 0 and var_148_8 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_7 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_7
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_8, arg_145_1.talkMaxDuration)

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_7) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_7 + var_148_12 and arg_145_1.time_ < var_148_7 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play910110036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910110036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910110037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1070"]) and arg_149_1.var_.actorSpriteComps1070 == nil then
				arg_149_1.var_.actorSpriteComps1070 = arg_149_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1070"]) then
				if arg_149_1.var_.actorSpriteComps1070 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1070"]) and arg_149_1.var_.actorSpriteComps1070 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps1070 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.175

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(910110036).content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 7 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 7)

				if (7 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 7)) > 0 and var_152_3 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_7 and arg_149_1.time_ < var_152_2 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play910110037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 910110037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play910110038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1070"]) and arg_153_1.var_.actorSpriteComps1070 == nil then
				arg_153_1.var_.actorSpriteComps1070 = arg_153_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1070"]) then
				if arg_153_1.var_.actorSpriteComps1070 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1070:ToTable()) do
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

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1070"]) and arg_153_1.var_.actorSpriteComps1070 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps1070 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.3

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(910110037).content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 12 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 12)

				if (12 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 12)) > 0 and var_156_3 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_7 and arg_153_1.time_ < var_156_2 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play910110038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 910110038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play910110039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1070 = arg_157_1.actors_["1070"].transform.localPosition
				arg_157_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1070", 3)

				for iter_160_0 = 0, arg_157_1.actors_["1070"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["1070"].transform:GetChild(iter_160_0)

					if var_160_0.name == "split_1" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_160_2 = arg_157_1.actors_["1070"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1070 == nil then
				arg_157_1.var_.actorSpriteComps1070 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.0166666666666667

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps1070 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps1070 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1070 = nil
			end

			local var_160_5 = 0
			local var_160_6 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(910110038).content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 20 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_7) / 20)

				if (20 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_7) / 20)) > 0 and var_160_6 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_5
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_6, arg_157_1.talkMaxDuration)

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_5) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_5 + var_160_10 and arg_157_1.time_ < var_160_5 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play910110039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910110039
		arg_161_1.duration_ = 0.2

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"

			SetActive(arg_161_1.choicesGo_, true)

			for iter_162_0, iter_162_1 in ipairs(arg_161_1.choices_) do
				SetActive(iter_162_1.go, iter_162_0 <= 2)
			end

			arg_161_1.choices_[1].txt.text = arg_161_1:FormatText(StoryChoiceCfg[292].name)
			arg_161_1.choices_[2].txt.text = arg_161_1:FormatText(StoryChoiceCfg[293].name)
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910110040(arg_161_1)
			end

			if arg_163_0 == 2 then
				arg_161_0:Play910110052(arg_161_1)
			end

			arg_161_1:RecordChoiceLog(910110039, 292, 293)
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1070"]) and arg_161_1.var_.actorSpriteComps1070 == nil then
				arg_161_1.var_.actorSpriteComps1070 = arg_161_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1070"]) then
				if arg_161_1.var_.actorSpriteComps1070 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1070"]) and arg_161_1.var_.actorSpriteComps1070 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps1070 = nil
			end

			local var_164_2 = arg_161_1.actors_["1070"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				for iter_164_4 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_4)

					if var_164_3.name == "split_8" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, Vector3.New(10000, -350, -180), (arg_161_1.time_ - 0) / var_164_4)
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(10000, -350, -180)
			end

			local var_164_5 = arg_161_1.actors_["1070"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				for iter_164_5 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_5)

					if var_164_6.name == "split_6" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, Vector3.New(10000, -350, -180), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(10000, -350, -180)
			end

			local var_164_8 = arg_161_1.actors_["1070"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				for iter_164_6 = 0, var_164_8.childCount - 1 do
					local var_164_9 = var_164_8:GetChild(iter_164_6)

					if var_164_9.name == "split_7" or not string.find(var_164_9.name, "split") then
						var_164_9.gameObject:SetActive(true)
					else
						var_164_9.gameObject:SetActive(false)
					end
				end
			end

			local var_164_10 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_10 then
				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, Vector3.New(10000, -350, -180), (arg_161_1.time_ - 0) / var_164_10)
			end

			if arg_161_1.time_ >= 0 + var_164_10 and arg_161_1.time_ < 0 + var_164_10 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(10000, -350, -180)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play910110040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910110040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910110041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1070 = arg_165_1.actors_["1070"].transform.localPosition
				arg_165_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1070", 3)

				for iter_168_0 = 0, arg_165_1.actors_["1070"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1070"].transform:GetChild(iter_168_0)

					if var_168_0.name == "split_3" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_168_2 = arg_165_1.actors_["1070"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1070 == nil then
				arg_165_1.var_.actorSpriteComps1070 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.0166666666666667

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1070 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								iter_168_2.color = Color.New(Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_2.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_2.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1070 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1070 = nil
			end

			local var_168_5 = 0
			local var_168_6 = 1.1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(910110040).content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 44 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 44)

				if (44 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_7) / 44)) > 0 and var_168_6 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_10 and arg_165_1.time_ < var_168_5 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play910110041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910110041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910110042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070 = arg_169_1.actors_["1070"].transform.localPosition
				arg_169_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1070", 3)

				for iter_172_0 = 0, arg_169_1.actors_["1070"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["1070"].transform:GetChild(iter_172_0)

					if var_172_0.name == "split_8" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_172_2 = arg_169_1.actors_["1070"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1070 == nil then
				arg_169_1.var_.actorSpriteComps1070 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.0166666666666667

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps1070 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 1, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps1070 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps1070 = nil
			end

			local var_172_5 = 0
			local var_172_6 = 1.125

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(910110041).content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 45 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 45)

				if (45 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_7) / 45)) > 0 and var_172_6 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_10 and arg_169_1.time_ < var_172_5 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play910110042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910110042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910110043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1070"]) and arg_173_1.var_.actorSpriteComps1070 == nil then
				arg_173_1.var_.actorSpriteComps1070 = arg_173_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1070"]) then
				if arg_173_1.var_.actorSpriteComps1070 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1070"]) and arg_173_1.var_.actorSpriteComps1070 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps1070 = nil
			end

			local var_176_2 = 0
			local var_176_3 = 0.65

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
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

				local var_176_4 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(910110042).content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_6 = 26 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 26)

				if (26 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 26)) > 0 and var_176_3 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_7 and arg_173_1.time_ < var_176_2 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910110043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910110043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910110044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1070 = arg_177_1.actors_["1070"].transform.localPosition
				arg_177_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1070", 3)

				for iter_180_0 = 0, arg_177_1.actors_["1070"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["1070"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_7" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_180_2 = 0
			local var_180_3 = 0.05

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(910110043).content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 2 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 2)

				if (2 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 2)) > 0 and var_180_3 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_7 and arg_177_1.time_ < var_180_2 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play910110044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910110044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910110045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.075

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(910110044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 3 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 3)

				if (3 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 3)) > 0 and var_184_0 < var_184_3 then
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
	Play910110045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910110045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910110046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(910110045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)

				if (54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)) > 0 and var_188_0 < var_188_3 then
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
	Play910110046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910110046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910110047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1070"]) and arg_189_1.var_.actorSpriteComps1070 == nil then
				arg_189_1.var_.actorSpriteComps1070 = arg_189_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1070"]) then
				if arg_189_1.var_.actorSpriteComps1070 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1070"]) and arg_189_1.var_.actorSpriteComps1070 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps1070 = nil
			end

			local var_192_2 = 0
			local var_192_3 = 1.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_4 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(910110046).content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 49 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 49)

				if (49 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 49)) > 0 and var_192_3 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_7 and arg_189_1.time_ < var_192_2 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play910110047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910110047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910110048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.95

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(910110047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 38 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 38)

				if (38 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 38)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play910110048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910110048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910110049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1070 = arg_197_1.actors_["1070"].transform.localPosition
				arg_197_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1070", 3)

				for iter_200_0 = 0, arg_197_1.actors_["1070"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1070"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_6" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_200_2 = arg_197_1.actors_["1070"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1070 == nil then
				arg_197_1.var_.actorSpriteComps1070 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.0166666666666667

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1070 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1070 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps1070 = nil
			end

			local var_200_5 = 0
			local var_200_6 = 1.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_7 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(910110048).content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 42 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_7) / 42)

				if (42 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_7) / 42)) > 0 and var_200_6 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_10 and arg_197_1.time_ < var_200_5 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play910110049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910110049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910110050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1070"]) and arg_201_1.var_.actorSpriteComps1070 == nil then
				arg_201_1.var_.actorSpriteComps1070 = arg_201_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1070"]) then
				if arg_201_1.var_.actorSpriteComps1070 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1070"]) and arg_201_1.var_.actorSpriteComps1070 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1070 = nil
			end

			local var_204_2 = 0
			local var_204_3 = 0.55

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
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

				local var_204_4 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(910110049).content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_6 = 22 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 22)

				if (22 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 22)) > 0 and var_204_3 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_7 and arg_201_1.time_ < var_204_2 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play910110050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910110050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910110051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1070 = arg_205_1.actors_["1070"].transform.localPosition
				arg_205_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1070", 3)

				for iter_208_0 = 0, arg_205_1.actors_["1070"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["1070"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_2" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_208_2 = arg_205_1.actors_["1070"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1070 == nil then
				arg_205_1.var_.actorSpriteComps1070 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.0166666666666667

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps1070 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps1070 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps1070 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.325

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(910110050).content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 13 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 13)

				if (13 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 13)) > 0 and var_208_6 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_10 and arg_205_1.time_ < var_208_5 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play910110051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910110051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910110052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1070"]) and arg_209_1.var_.actorSpriteComps1070 == nil then
				arg_209_1.var_.actorSpriteComps1070 = arg_209_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1070"]) then
				if arg_209_1.var_.actorSpriteComps1070 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1070"]) and arg_209_1.var_.actorSpriteComps1070 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps1070 = nil
			end

			local var_212_2 = 0
			local var_212_3 = 0.35

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_4 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(910110051).content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 14 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 14)

				if (14 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 14)) > 0 and var_212_3 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_7 and arg_209_1.time_ < var_212_2 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play910110052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 910110052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play910110053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1070 = arg_213_1.actors_["1070"].transform.localPosition
				arg_213_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1070", 3)

				for iter_216_0 = 0, arg_213_1.actors_["1070"].transform.childCount - 1 do
					local var_216_0 = arg_213_1.actors_["1070"].transform:GetChild(iter_216_0)

					if var_216_0.name == "split_1" or not string.find(var_216_0.name, "split") then
						var_216_0.gameObject:SetActive(true)
					else
						var_216_0.gameObject:SetActive(false)
					end
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_213_1.time_ - 0) / var_216_1)
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_216_2 = arg_213_1.actors_["1070"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1070 == nil then
				arg_213_1.var_.actorSpriteComps1070 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 0.0166666666666667

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps1070 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								iter_216_2.color = Color.New(Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_2.color.r, 1, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_2.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps1070 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps1070 = nil
			end

			local var_216_5 = 0
			local var_216_6 = 0.35

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(910110052).content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 14 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 14)

				if (14 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_7) / 14)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_10 and arg_213_1.time_ < var_216_5 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play910110053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 910110053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play910110054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1070"]) and arg_217_1.var_.actorSpriteComps1070 == nil then
				arg_217_1.var_.actorSpriteComps1070 = arg_217_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1070"]) then
				if arg_217_1.var_.actorSpriteComps1070 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1070"]) and arg_217_1.var_.actorSpriteComps1070 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps1070 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_4 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(910110053).content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 10 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 10)

				if (10 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_4) / 10)) > 0 and var_220_3 < var_220_6 then
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
	Play910110054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 910110054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play910110055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1070 = arg_221_1.actors_["1070"].transform.localPosition
				arg_221_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1070", 3)

				for iter_224_0 = 0, arg_221_1.actors_["1070"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["1070"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_5" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_224_2 = arg_221_1.actors_["1070"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1070 == nil then
				arg_221_1.var_.actorSpriteComps1070 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.0166666666666667

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps1070 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 1, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps1070 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1070 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.05

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(910110054).content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 2 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_7) / 2)

				if (2 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_7) / 2)) > 0 and var_224_6 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_10 and arg_221_1.time_ < var_224_5 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play910110055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 910110055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play910110056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.725

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(910110055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 29 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 29)

				if (29 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 29)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play910110056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 910110056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play910110057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1070"]) and arg_229_1.var_.actorSpriteComps1070 == nil then
				arg_229_1.var_.actorSpriteComps1070 = arg_229_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1070"]) then
				if arg_229_1.var_.actorSpriteComps1070 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1070"]) and arg_229_1.var_.actorSpriteComps1070 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps1070 = nil
			end

			local var_232_2 = 0
			local var_232_3 = 0.275

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
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

				local var_232_4 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(910110056).content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 11 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 11)

				if (11 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 11)) > 0 and var_232_3 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_7 and arg_229_1.time_ < var_232_2 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play910110057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910110057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910110058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1070 = arg_233_1.actors_["1070"].transform.localPosition
				arg_233_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1070", 3)

				for iter_236_0 = 0, arg_233_1.actors_["1070"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["1070"].transform:GetChild(iter_236_0)

					if var_236_0.name == "split_4" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_236_2 = arg_233_1.actors_["1070"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1070 == nil then
				arg_233_1.var_.actorSpriteComps1070 = var_236_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_3 = 0.0166666666666667

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.actorSpriteComps1070 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								iter_236_2.color = Color.New(Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_3), Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_3), (Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_3)))
							else
								local var_236_4 = Mathf.Lerp(iter_236_2.color.r, 1, (arg_233_1.time_ - 0) / var_236_3)

								iter_236_2.color = Color.New(var_236_4, var_236_4, var_236_4)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.actorSpriteComps1070 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps1070 = nil
			end

			local var_236_5 = 0
			local var_236_6 = 0.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_7 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(910110057).content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 16 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_7) / 16)

				if (16 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_7) / 16)) > 0 and var_236_6 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_10 and arg_233_1.time_ < var_236_5 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play910110058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910110058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910110059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1070"]) and arg_237_1.var_.actorSpriteComps1070 == nil then
				arg_237_1.var_.actorSpriteComps1070 = arg_237_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1070"]) then
				if arg_237_1.var_.actorSpriteComps1070 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1070"]) and arg_237_1.var_.actorSpriteComps1070 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1070 = nil
			end

			local var_240_2 = 0
			local var_240_3 = 0.25

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_4 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(910110058).content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 10 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 10)

				if (10 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 10)) > 0 and var_240_3 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_7 and arg_237_1.time_ < var_240_2 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play910110059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910110059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910110060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1070"]) and arg_241_1.var_.actorSpriteComps1070 == nil then
				arg_241_1.var_.actorSpriteComps1070 = arg_241_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1070"]) then
				if arg_241_1.var_.actorSpriteComps1070 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								iter_244_1.color = Color.New(Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_0), Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_0), (Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_0)))
							else
								local var_244_1 = Mathf.Lerp(iter_244_1.color.r, 1, (arg_241_1.time_ - 0) / var_244_0)

								iter_244_1.color = Color.New(var_244_1, var_244_1, var_244_1)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1070"]) and arg_241_1.var_.actorSpriteComps1070 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps1070 = nil
			end

			local var_244_2 = 0
			local var_244_3 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(910110059).content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 31 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_4) / 31)

				if (31 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_4) / 31)) > 0 and var_244_3 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_7 and arg_241_1.time_ < var_244_2 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play910110060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 910110060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play910110061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1070"]) and arg_245_1.var_.actorSpriteComps1070 == nil then
				arg_245_1.var_.actorSpriteComps1070 = arg_245_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1070"]) then
				if arg_245_1.var_.actorSpriteComps1070 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1070"]) and arg_245_1.var_.actorSpriteComps1070 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps1070 = nil
			end

			local var_248_2 = 0
			local var_248_3 = 0.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(910110060).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 9 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 9)

				if (9 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 9)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play910110061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 910110061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play910110062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.475

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
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

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(910110061).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 19 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 19)

				if (19 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 19)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play910110062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 910110062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play910110063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1070 = arg_253_1.actors_["1070"].transform.localPosition
				arg_253_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1070", 3)

				for iter_256_0 = 0, arg_253_1.actors_["1070"].transform.childCount - 1 do
					local var_256_0 = arg_253_1.actors_["1070"].transform:GetChild(iter_256_0)

					if var_256_0.name == "split_1" or not string.find(var_256_0.name, "split") then
						var_256_0.gameObject:SetActive(true)
					else
						var_256_0.gameObject:SetActive(false)
					end
				end
			end

			local var_256_1 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 then
				arg_253_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_253_1.time_ - 0) / var_256_1)
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 then
				arg_253_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_256_2 = arg_253_1.actors_["1070"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1070 == nil then
				arg_253_1.var_.actorSpriteComps1070 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.0166666666666667

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps1070 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								iter_256_2.color = Color.New(Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_2.color.r, 1, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_2.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps1070 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps1070 = nil
			end

			local var_256_5 = 0
			local var_256_6 = 0.9

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_7 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(910110062).content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 36 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_7) / 36)

				if (36 <= 0 and var_256_6 or var_256_6 * (utf8.len(var_256_7) / 36)) > 0 and var_256_6 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_5 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_5
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_6, arg_253_1.talkMaxDuration)

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_5) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_5 + var_256_10 and arg_253_1.time_ < var_256_5 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play910110063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 910110063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play910110064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1070"]) and arg_257_1.var_.actorSpriteComps1070 == nil then
				arg_257_1.var_.actorSpriteComps1070 = arg_257_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1070"]) then
				if arg_257_1.var_.actorSpriteComps1070 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1070"]) and arg_257_1.var_.actorSpriteComps1070 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps1070 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 1.275

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_4 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(910110063).content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 51 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 51)

				if (51 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 51)) > 0 and var_260_3 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_7 and arg_257_1.time_ < var_260_2 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play910110064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 910110064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play910110065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1070"]) and arg_261_1.var_.actorSpriteComps1070 == nil then
				arg_261_1.var_.actorSpriteComps1070 = arg_261_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1070"]) then
				if arg_261_1.var_.actorSpriteComps1070 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								iter_264_1.color = Color.New(Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_0), Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_0), (Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_0)))
							else
								local var_264_1 = Mathf.Lerp(iter_264_1.color.r, 1, (arg_261_1.time_ - 0) / var_264_0)

								iter_264_1.color = Color.New(var_264_1, var_264_1, var_264_1)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1070"]) and arg_261_1.var_.actorSpriteComps1070 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1070 = nil
			end

			local var_264_2 = 0
			local var_264_3 = 0.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(910110064).content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_6 = 6 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_4) / 6)

				if (6 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_4) / 6)) > 0 and var_264_3 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_7 and arg_261_1.time_ < var_264_2 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play910110065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 910110065
		arg_265_1.duration_ = 0.2

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"

			SetActive(arg_265_1.choicesGo_, true)

			for iter_266_0, iter_266_1 in ipairs(arg_265_1.choices_) do
				SetActive(iter_266_1.go, iter_266_0 <= 2)
			end

			arg_265_1.choices_[1].txt.text = arg_265_1:FormatText(StoryChoiceCfg[294].name)
			arg_265_1.choices_[2].txt.text = arg_265_1:FormatText(StoryChoiceCfg[295].name)
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play910110066(arg_265_1)
			end

			if arg_267_0 == 2 then
				arg_265_0:Play910110066(arg_265_1)
			end

			arg_265_1:RecordChoiceLog(910110065, 294, 295)
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1070"]) and arg_265_1.var_.actorSpriteComps1070 == nil then
				arg_265_1.var_.actorSpriteComps1070 = arg_265_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1070"]) then
				if arg_265_1.var_.actorSpriteComps1070 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1070"]) and arg_265_1.var_.actorSpriteComps1070 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps1070 = nil
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play910110066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 910110066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play910110067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1070 = arg_269_1.actors_["1070"].transform.localPosition
				arg_269_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1070", 3)

				for iter_272_0 = 0, arg_269_1.actors_["1070"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["1070"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_2" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_272_2 = arg_269_1.actors_["1070"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1070 == nil then
				arg_269_1.var_.actorSpriteComps1070 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 0.0166666666666667

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps1070 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps1070 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1070 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.375

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(910110066).content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 15 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_7) / 15)

				if (15 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_7) / 15)) > 0 and var_272_6 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_10 and arg_269_1.time_ < var_272_5 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play910110067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 910110067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play910110068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1070"]) and arg_273_1.var_.actorSpriteComps1070 == nil then
				arg_273_1.var_.actorSpriteComps1070 = arg_273_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1070"]) then
				if arg_273_1.var_.actorSpriteComps1070 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								iter_276_1.color = Color.New(Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_0), Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_0), (Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_0)))
							else
								local var_276_1 = Mathf.Lerp(iter_276_1.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_0)

								iter_276_1.color = Color.New(var_276_1, var_276_1, var_276_1)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1070"]) and arg_273_1.var_.actorSpriteComps1070 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps1070 = nil
			end

			local var_276_2 = 0
			local var_276_3 = 0.325

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_4 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(910110067).content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 13 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 13)

				if (13 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_4) / 13)) > 0 and var_276_3 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_7 and arg_273_1.time_ < var_276_2 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play910110068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 910110068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play910110069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(910110068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 15)

				if (15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 15)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play910110069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 910110069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play910110070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1070 = arg_281_1.actors_["1070"].transform.localPosition
				arg_281_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1070", 3)

				for iter_284_0 = 0, arg_281_1.actors_["1070"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["1070"].transform:GetChild(iter_284_0)

					if var_284_0.name == "split_1" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_284_2 = arg_281_1.actors_["1070"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1070 == nil then
				arg_281_1.var_.actorSpriteComps1070 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.0166666666666667

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps1070 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 1, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps1070 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps1070 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.25

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(910110069).content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 10 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_7) / 10)

				if (10 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_7) / 10)) > 0 and var_284_6 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_10 and arg_281_1.time_ < var_284_5 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play910110070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 910110070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play910110071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1070"]) and arg_285_1.var_.actorSpriteComps1070 == nil then
				arg_285_1.var_.actorSpriteComps1070 = arg_285_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1070"]) then
				if arg_285_1.var_.actorSpriteComps1070 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1070"]) and arg_285_1.var_.actorSpriteComps1070 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps1070 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.275

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_4 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(910110070).content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 11 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 11)

				if (11 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 11)) > 0 and var_288_3 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_7 and arg_285_1.time_ < var_288_2 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play910110071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 910110071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play910110072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1070 = arg_289_1.actors_["1070"].transform.localPosition
				arg_289_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1070", 3)

				for iter_292_0 = 0, arg_289_1.actors_["1070"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["1070"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_8" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_292_2 = arg_289_1.actors_["1070"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1070 == nil then
				arg_289_1.var_.actorSpriteComps1070 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.0166666666666667

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1070 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 1, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1070 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps1070 = nil
			end

			local var_292_5 = 0
			local var_292_6 = 0.25

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(910110071).content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 10 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_7) / 10)

				if (10 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_7) / 10)) > 0 and var_292_6 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_10 and arg_289_1.time_ < var_292_5 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play910110072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 910110072
		arg_293_1.duration_ = 7.03

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play910110073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if arg_293_1.bgs_.I05 == nil then
				local var_296_0 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05")
				var_296_0.name = "I05"
				var_296_0.transform.parent = arg_293_1.stage_.transform
				var_296_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_.I05 = var_296_0
			end

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				local var_296_1 = arg_293_1.bgs_.I05

				arg_293_1.bgs_.I05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_2 = var_296_1:GetComponent("SpriteRenderer")

				if var_296_2 and var_296_2.sprite then
					local var_296_3 = 2 * (var_296_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_1.transform.localScale = Vector3.New(var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "I05" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_4 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_5 = 2

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_5 then
				local var_296_6 = Color.New(0, 0, 0)

				var_296_6.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_4) / var_296_5)
				arg_293_1.mask_.color = var_296_6
			end

			if arg_293_1.time_ >= var_296_4 + var_296_5 and arg_293_1.time_ < var_296_4 + var_296_5 + arg_296_0 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = 1
				arg_293_1.mask_.color = var_296_7
			end

			local var_296_8 = 2

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_9 = 2

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 then
				local var_296_10 = Color.New(0, 0, 0)

				var_296_10.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_8) / var_296_9)
				arg_293_1.mask_.color = var_296_10
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 then
				local var_296_11 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_11.a = 0
				arg_293_1.mask_.color = var_296_11
			end

			local var_296_12 = arg_293_1.actors_["1070"].transform

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				arg_293_1.var_.moveOldPos1070 = var_296_12.localPosition
				var_296_12.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1070", 3)

				for iter_296_2 = 0, var_296_12.childCount - 1 do
					local var_296_13 = var_296_12:GetChild(iter_296_2)

					if var_296_13.name == "split_2" or not string.find(var_296_13.name, "split") then
						var_296_13.gameObject:SetActive(true)
					else
						var_296_13.gameObject:SetActive(false)
					end
				end
			end

			local var_296_14 = 0.001

			if 2 <= arg_293_1.time_ and arg_293_1.time_ < 2 + var_296_14 then
				var_296_12.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_293_1.time_ - 2) / var_296_14)
			end

			if arg_293_1.time_ >= 2 + var_296_14 and arg_293_1.time_ < 2 + var_296_14 + arg_296_0 then
				var_296_12.localPosition = Vector3.New(0, -350, -180)
			end

			local var_296_15 = arg_293_1.actors_["1070"]

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.actorSpriteComps1070 == nil then
				arg_293_1.var_.actorSpriteComps1070 = var_296_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_16 = 0.0166666666666667

			if 2 <= arg_293_1.time_ and arg_293_1.time_ < 2 + var_296_16 and not isNil(var_296_15) then
				if arg_293_1.var_.actorSpriteComps1070 then
					for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_296_4 then
							if arg_293_1.isInRecall_ then
								iter_296_4.color = Color.New(Mathf.Lerp(iter_296_4.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 2) / var_296_16), Mathf.Lerp(iter_296_4.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 2) / var_296_16), (Mathf.Lerp(iter_296_4.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 2) / var_296_16)))
							else
								local var_296_17 = Mathf.Lerp(iter_296_4.color.r, 1, (arg_293_1.time_ - 2) / var_296_16)

								iter_296_4.color = Color.New(var_296_17, var_296_17, var_296_17)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 2 + var_296_16 and arg_293_1.time_ < 2 + var_296_16 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.actorSpriteComps1070 then
				for iter_296_5, iter_296_6 in pairs(arg_293_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_296_6 then
						iter_296_6.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1070 = nil
			end

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				local var_296_18 = arg_293_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_296_18 then
					arg_293_1.var_.alphaOldValue1070 = var_296_18.alpha
					arg_293_1.var_.characterEffect1070 = var_296_18
				end

				arg_293_1.var_.alphaOldValue1070 = 0
			end

			local var_296_19 = 0.3

			if 2 <= arg_293_1.time_ and arg_293_1.time_ < 2 + var_296_19 then
				if arg_293_1.var_.characterEffect1070 then
					arg_293_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_293_1.var_.alphaOldValue1070, 1, (arg_293_1.time_ - 2) / var_296_19)
				end
			end

			if arg_293_1.time_ >= 2 + var_296_19 and arg_293_1.time_ < 2 + var_296_19 + arg_296_0 and arg_293_1.var_.characterEffect1070 then
				arg_293_1.var_.characterEffect1070.alpha = 1
			end

			local var_296_20 = 2.034
			local var_296_21 = 0.175

			if 2.034 < arg_293_1.time_ and arg_293_1.time_ <= var_296_20 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_22 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(910110072).content)

				arg_293_1.text_.text = var_296_22

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_24 = 7 <= 0 and var_296_21 or var_296_21 * (utf8.len(var_296_22) / 7)

				if (7 <= 0 and var_296_21 or var_296_21 * (utf8.len(var_296_22) / 7)) > 0 and var_296_21 < var_296_24 then
					arg_293_1.talkMaxDuration = var_296_24

					if var_296_24 + var_296_20 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_24 + var_296_20
					end
				end

				arg_293_1.text_.text = var_296_22
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_21, arg_293_1.talkMaxDuration)

			if var_296_20 <= arg_293_1.time_ and arg_293_1.time_ < var_296_20 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_20) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_20 + var_296_25 and arg_293_1.time_ < var_296_20 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play910110073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 910110073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play910110074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1070"]) and arg_297_1.var_.actorSpriteComps1070 == nil then
				arg_297_1.var_.actorSpriteComps1070 = arg_297_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.0166666666666667

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1070"]) then
				if arg_297_1.var_.actorSpriteComps1070 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 0.5, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1070"]) and arg_297_1.var_.actorSpriteComps1070 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_297_1.var_.actorSpriteComps1070 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.6

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_4 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(910110073).content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_6 = 24 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 24)

				if (24 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_4) / 24)) > 0 and var_300_3 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_7 and arg_297_1.time_ < var_300_2 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play910110074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 910110074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play910110075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1070 = arg_301_1.actors_["1070"].transform.localPosition
				arg_301_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1070", 3)

				for iter_304_0 = 0, arg_301_1.actors_["1070"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["1070"].transform:GetChild(iter_304_0)

					if var_304_0.name == "split_3" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_304_2 = arg_301_1.actors_["1070"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1070 == nil then
				arg_301_1.var_.actorSpriteComps1070 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.0166666666666667

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps1070 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 1, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps1070 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps1070 = nil
			end

			local var_304_5 = 0
			local var_304_6 = 1.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(910110074).content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 48 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_7) / 48)

				if (48 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_7) / 48)) > 0 and var_304_6 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_10 and arg_301_1.time_ < var_304_5 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play910110075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 910110075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play910110076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1070"]) and arg_305_1.var_.actorSpriteComps1070 == nil then
				arg_305_1.var_.actorSpriteComps1070 = arg_305_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1070"]) then
				if arg_305_1.var_.actorSpriteComps1070 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								iter_308_1.color = Color.New(Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_0), Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_0), (Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_0)))
							else
								local var_308_1 = Mathf.Lerp(iter_308_1.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_0)

								iter_308_1.color = Color.New(var_308_1, var_308_1, var_308_1)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1070"]) and arg_305_1.var_.actorSpriteComps1070 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps1070 = nil
			end

			local var_308_2 = 0
			local var_308_3 = 1.475

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_4 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(910110075).content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_6 = 59 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_4) / 59)

				if (59 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_4) / 59)) > 0 and var_308_3 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_7 and arg_305_1.time_ < var_308_2 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play910110076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 910110076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play910110077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1070"]) and arg_309_1.var_.actorSpriteComps1070 == nil then
				arg_309_1.var_.actorSpriteComps1070 = arg_309_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1070"]) then
				if arg_309_1.var_.actorSpriteComps1070 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 1, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1070"]) and arg_309_1.var_.actorSpriteComps1070 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps1070 = nil
			end

			local var_312_2 = 0
			local var_312_3 = 0.1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(910110076).content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 4 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 4)

				if (4 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_4) / 4)) > 0 and var_312_3 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_7 and arg_309_1.time_ < var_312_2 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play910110077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910110077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910110078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1070"]) and arg_313_1.var_.actorSpriteComps1070 == nil then
				arg_313_1.var_.actorSpriteComps1070 = arg_313_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1070"]) then
				if arg_313_1.var_.actorSpriteComps1070 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1070"]) and arg_313_1.var_.actorSpriteComps1070 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps1070 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 0.3

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(910110077).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 12 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 12)

				if (12 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 12)) > 0 and var_316_3 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_7 and arg_313_1.time_ < var_316_2 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play910110078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910110078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910110079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.6

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(910110078).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 24 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 24)

				if (24 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 24)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play910110079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910110079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910110080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1070"]) and arg_321_1.var_.actorSpriteComps1070 == nil then
				arg_321_1.var_.actorSpriteComps1070 = arg_321_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.0166666666666667

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1070"]) then
				if arg_321_1.var_.actorSpriteComps1070 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1070"]) and arg_321_1.var_.actorSpriteComps1070 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps1070 = nil
			end

			local var_324_2 = arg_321_1.actors_["1070"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1070 = var_324_2.localPosition
				var_324_2.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1070", 3)

				for iter_324_4 = 0, var_324_2.childCount - 1 do
					local var_324_3 = var_324_2:GetChild(iter_324_4)

					if var_324_3.name == "split_6" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_2.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_321_1.time_ - 0) / var_324_4)
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_324_5 = 0
			local var_324_6 = 1.175

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(910110079).content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 47 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_7) / 47)

				if (47 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_7) / 47)) > 0 and var_324_6 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_10 and arg_321_1.time_ < var_324_5 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play910110080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910110080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910110081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1070"]) and arg_325_1.var_.actorSpriteComps1070 == nil then
				arg_325_1.var_.actorSpriteComps1070 = arg_325_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1070"]) then
				if arg_325_1.var_.actorSpriteComps1070 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1070"]) and arg_325_1.var_.actorSpriteComps1070 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps1070 = nil
			end

			local var_328_2 = 0
			local var_328_3 = 0.9

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(910110080).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 36 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 36)

				if (36 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 36)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play910110081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910110081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910110082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1070"]) and arg_329_1.var_.actorSpriteComps1070 == nil then
				arg_329_1.var_.actorSpriteComps1070 = arg_329_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.0166666666666667

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1070"]) then
				if arg_329_1.var_.actorSpriteComps1070 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								iter_332_1.color = Color.New(Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_0), Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_0), (Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_0)))
							else
								local var_332_1 = Mathf.Lerp(iter_332_1.color.r, 1, (arg_329_1.time_ - 0) / var_332_0)

								iter_332_1.color = Color.New(var_332_1, var_332_1, var_332_1)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1070"]) and arg_329_1.var_.actorSpriteComps1070 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps1070 = nil
			end

			local var_332_2 = arg_329_1.actors_["1070"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1070 = var_332_2.localPosition
				var_332_2.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1070", 3)

				for iter_332_4 = 0, var_332_2.childCount - 1 do
					local var_332_3 = var_332_2:GetChild(iter_332_4)

					if var_332_3.name == "split_3" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_2.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_329_1.time_ - 0) / var_332_4)
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_332_5 = 0
			local var_332_6 = 1.85

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_7 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(910110081).content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 74 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_7) / 74)

				if (74 <= 0 and var_332_6 or var_332_6 * (utf8.len(var_332_7) / 74)) > 0 and var_332_6 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_5 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_5
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_6, arg_329_1.talkMaxDuration)

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_5) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_5 + var_332_10 and arg_329_1.time_ < var_332_5 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play910110082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910110082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910110083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1070"]) and arg_333_1.var_.actorSpriteComps1070 == nil then
				arg_333_1.var_.actorSpriteComps1070 = arg_333_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1070"]) then
				if arg_333_1.var_.actorSpriteComps1070 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1070"]) and arg_333_1.var_.actorSpriteComps1070 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps1070 = nil
			end

			local var_336_2 = 0
			local var_336_3 = 0.25

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_4 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(910110082).content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_6 = 10 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 10)

				if (10 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_4) / 10)) > 0 and var_336_3 < var_336_6 then
					arg_333_1.talkMaxDuration = var_336_6

					if var_336_6 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_7 and arg_333_1.time_ < var_336_2 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play910110083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910110083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910110084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1070"]) and arg_337_1.var_.actorSpriteComps1070 == nil then
				arg_337_1.var_.actorSpriteComps1070 = arg_337_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_0 = 0.0166666666666667

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1070"]) then
				if arg_337_1.var_.actorSpriteComps1070 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								iter_340_1.color = Color.New(Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_0), Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_0), (Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_0)))
							else
								local var_340_1 = Mathf.Lerp(iter_340_1.color.r, 1, (arg_337_1.time_ - 0) / var_340_0)

								iter_340_1.color = Color.New(var_340_1, var_340_1, var_340_1)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1070"]) and arg_337_1.var_.actorSpriteComps1070 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps1070 = nil
			end

			local var_340_2 = arg_337_1.actors_["1070"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1070 = var_340_2.localPosition
				var_340_2.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1070", 3)

				for iter_340_4 = 0, var_340_2.childCount - 1 do
					local var_340_3 = var_340_2:GetChild(iter_340_4)

					if var_340_3.name == "split_1" or not string.find(var_340_3.name, "split") then
						var_340_3.gameObject:SetActive(true)
					else
						var_340_3.gameObject:SetActive(false)
					end
				end
			end

			local var_340_4 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				var_340_2.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_337_1.time_ - 0) / var_340_4)
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				var_340_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_340_5 = 0
			local var_340_6 = 0.75

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_7 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(910110083).content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 30 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 30)

				if (30 <= 0 and var_340_6 or var_340_6 * (utf8.len(var_340_7) / 30)) > 0 and var_340_6 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_5 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_5
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_6, arg_337_1.talkMaxDuration)

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_5) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_5 + var_340_10 and arg_337_1.time_ < var_340_5 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play910110084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910110084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910110085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1070"]) and arg_341_1.var_.actorSpriteComps1070 == nil then
				arg_341_1.var_.actorSpriteComps1070 = arg_341_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1070"]) then
				if arg_341_1.var_.actorSpriteComps1070 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								iter_344_1.color = Color.New(Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_0), Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_0), (Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_0)))
							else
								local var_344_1 = Mathf.Lerp(iter_344_1.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_0)

								iter_344_1.color = Color.New(var_344_1, var_344_1, var_344_1)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1070"]) and arg_341_1.var_.actorSpriteComps1070 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps1070 = nil
			end

			local var_344_2 = 0
			local var_344_3 = 0.2

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_4 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(910110084).content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_6 = 8 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_4) / 8)

				if (8 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_4) / 8)) > 0 and var_344_3 < var_344_6 then
					arg_341_1.talkMaxDuration = var_344_6

					if var_344_6 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_6 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_7 and arg_341_1.time_ < var_344_2 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play910110085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910110085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910110086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1070"]) and arg_345_1.var_.actorSpriteComps1070 == nil then
				arg_345_1.var_.actorSpriteComps1070 = arg_345_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_0 = 0.0166666666666667

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1070"]) then
				if arg_345_1.var_.actorSpriteComps1070 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								iter_348_1.color = Color.New(Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_0), Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_0), (Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_0)))
							else
								local var_348_1 = Mathf.Lerp(iter_348_1.color.r, 1, (arg_345_1.time_ - 0) / var_348_0)

								iter_348_1.color = Color.New(var_348_1, var_348_1, var_348_1)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1070"]) and arg_345_1.var_.actorSpriteComps1070 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_348_3 then
						iter_348_3.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps1070 = nil
			end

			local var_348_2 = 0
			local var_348_3 = 0.6

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(910110085).content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 24 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 24)

				if (24 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 24)) > 0 and var_348_3 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_7 and arg_345_1.time_ < var_348_2 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play910110086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910110086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910110087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.875

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(910110086).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 35 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 35)

				if (35 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 35)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play910110087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910110087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910110088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1070"]) and arg_353_1.var_.actorSpriteComps1070 == nil then
				arg_353_1.var_.actorSpriteComps1070 = arg_353_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1070"]) then
				if arg_353_1.var_.actorSpriteComps1070 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1070"]) and arg_353_1.var_.actorSpriteComps1070 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1070 = nil
			end

			local var_356_2 = 0
			local var_356_3 = 0.225

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_4 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(910110087).content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_6 = 9 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_4) / 9)

				if (9 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_4) / 9)) > 0 and var_356_3 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_7 and arg_353_1.time_ < var_356_2 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play910110088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910110088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910110089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1070"]) and arg_357_1.var_.actorSpriteComps1070 == nil then
				arg_357_1.var_.actorSpriteComps1070 = arg_357_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.0166666666666667

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1070"]) then
				if arg_357_1.var_.actorSpriteComps1070 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 1, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1070"]) and arg_357_1.var_.actorSpriteComps1070 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1070 = nil
			end

			local var_360_2 = arg_357_1.actors_["1070"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1070 = var_360_2.localPosition
				var_360_2.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1070", 3)

				for iter_360_4 = 0, var_360_2.childCount - 1 do
					local var_360_3 = var_360_2:GetChild(iter_360_4)

					if var_360_3.name == "split_2" or not string.find(var_360_3.name, "split") then
						var_360_3.gameObject:SetActive(true)
					else
						var_360_3.gameObject:SetActive(false)
					end
				end
			end

			local var_360_4 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				var_360_2.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_357_1.time_ - 0) / var_360_4)
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				var_360_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_360_5 = 0
			local var_360_6 = 0.7

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(910110088).content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 28 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 28)

				if (28 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 28)) > 0 and var_360_6 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_10 and arg_357_1.time_ < var_360_5 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play910110089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 910110089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play910110090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1070"]) and arg_361_1.var_.actorSpriteComps1070 == nil then
				arg_361_1.var_.actorSpriteComps1070 = arg_361_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1070"]) then
				if arg_361_1.var_.actorSpriteComps1070 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor2.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor2.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor2.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 0.5, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1070"]) and arg_361_1.var_.actorSpriteComps1070 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_361_1.var_.actorSpriteComps1070 = nil
			end

			local var_364_2 = 0
			local var_364_3 = 0.425

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
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

				local var_364_4 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(910110089).content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 17 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 17)

				if (17 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 17)) > 0 and var_364_3 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_7 and arg_361_1.time_ < var_364_2 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play910110090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 910110090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play910110091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 1.525

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

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(910110090).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 61 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 61)

				if (61 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 61)) > 0 and var_368_0 < var_368_3 then
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
	Play910110091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 910110091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play910110092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1070 = arg_369_1.actors_["1070"].transform.localPosition
				arg_369_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1070", 3)

				for iter_372_0 = 0, arg_369_1.actors_["1070"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["1070"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_5" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_372_2 = arg_369_1.actors_["1070"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1070 == nil then
				arg_369_1.var_.actorSpriteComps1070 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.0166666666666667

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps1070 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								iter_372_2.color = Color.New(Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_2.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_2.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps1070 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1070 = nil
			end

			local var_372_5 = 0
			local var_372_6 = 0.4

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(910110091).content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 16 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 16)

				if (16 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_7) / 16)) > 0 and var_372_6 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_10 and arg_369_1.time_ < var_372_5 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play910110092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 910110092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play910110093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if arg_373_1.actors_["1039"] == nil then
				local var_376_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1039")

				if not isNil(var_376_0) then
					local var_376_1 = Object.Instantiate(var_376_0, arg_373_1.canvasGo_.transform)

					var_376_1.transform:SetSiblingIndex(1)

					var_376_1.name = "1039"
					var_376_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_373_1.actors_["1039"] = var_376_1

					if arg_373_1.isInRecall_ then
						for iter_376_0, iter_376_1 in ipairs((var_376_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_376_1.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_376_2 = arg_373_1.actors_["1039"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1039 = var_376_2.localPosition
				var_376_2.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1039", 2)

				for iter_376_2 = 0, var_376_2.childCount - 1 do
					local var_376_3 = var_376_2:GetChild(iter_376_2)

					if var_376_3.name == "split_1" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_4 then
				var_376_2.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1039, Vector3.New(-390, -350, -180), (arg_373_1.time_ - 0) / var_376_4)
			end

			if arg_373_1.time_ >= 0 + var_376_4 and arg_373_1.time_ < 0 + var_376_4 + arg_376_0 then
				var_376_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_376_5 = arg_373_1.actors_["1039"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1039 == nil then
				arg_373_1.var_.actorSpriteComps1039 = var_376_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_6 = 0.0166666666666667

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_6 and not isNil(var_376_5) then
				if arg_373_1.var_.actorSpriteComps1039 then
					for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_376_4 then
							if arg_373_1.isInRecall_ then
								iter_376_4.color = Color.New(Mathf.Lerp(iter_376_4.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_6), Mathf.Lerp(iter_376_4.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_6), (Mathf.Lerp(iter_376_4.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_6)))
							else
								local var_376_7 = Mathf.Lerp(iter_376_4.color.r, 1, (arg_373_1.time_ - 0) / var_376_6)

								iter_376_4.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_6 and arg_373_1.time_ < 0 + var_376_6 + arg_376_0 and not isNil(var_376_5) and arg_373_1.var_.actorSpriteComps1039 then
				for iter_376_5, iter_376_6 in pairs(arg_373_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_376_6 then
						iter_376_6.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps1039 = nil
			end

			local var_376_8 = arg_373_1.actors_["1070"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1070 = var_376_8.localPosition
				var_376_8.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1070", 4)

				for iter_376_7 = 0, var_376_8.childCount - 1 do
					local var_376_9 = var_376_8:GetChild(iter_376_7)

					if var_376_9.name == "split_1" or not string.find(var_376_9.name, "split") then
						var_376_9.gameObject:SetActive(true)
					else
						var_376_9.gameObject:SetActive(false)
					end
				end
			end

			local var_376_10 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_10 then
				var_376_8.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1070, Vector3.New(390, -350, -180), (arg_373_1.time_ - 0) / var_376_10)
			end

			if arg_373_1.time_ >= 0 + var_376_10 and arg_373_1.time_ < 0 + var_376_10 + arg_376_0 then
				var_376_8.localPosition = Vector3.New(390, -350, -180)
			end

			local var_376_11 = arg_373_1.actors_["1070"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_11) and arg_373_1.var_.actorSpriteComps1070 == nil then
				arg_373_1.var_.actorSpriteComps1070 = var_376_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_12 = 0.0166666666666667

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_12 and not isNil(var_376_11) then
				if arg_373_1.var_.actorSpriteComps1070 then
					for iter_376_8, iter_376_9 in pairs(arg_373_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_376_9 then
							if arg_373_1.isInRecall_ then
								iter_376_9.color = Color.New(Mathf.Lerp(iter_376_9.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_12), Mathf.Lerp(iter_376_9.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_12), (Mathf.Lerp(iter_376_9.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_12)))
							else
								local var_376_13 = Mathf.Lerp(iter_376_9.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_12)

								iter_376_9.color = Color.New(var_376_13, var_376_13, var_376_13)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_12 and arg_373_1.time_ < 0 + var_376_12 + arg_376_0 and not isNil(var_376_11) and arg_373_1.var_.actorSpriteComps1070 then
				for iter_376_10, iter_376_11 in pairs(arg_373_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_376_11 then
						iter_376_11.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps1070 = nil
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				local var_376_14 = arg_373_1.actors_["1039"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_14 then
					arg_373_1.var_.alphaOldValue1039 = var_376_14.alpha
					arg_373_1.var_.characterEffect1039 = var_376_14
				end

				arg_373_1.var_.alphaOldValue1039 = 0
			end

			local var_376_15 = 0.6

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_15 then
				if arg_373_1.var_.characterEffect1039 then
					arg_373_1.var_.characterEffect1039.alpha = Mathf.Lerp(arg_373_1.var_.alphaOldValue1039, 1, (arg_373_1.time_ - 0) / var_376_15)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_15 and arg_373_1.time_ < 0 + var_376_15 + arg_376_0 and arg_373_1.var_.characterEffect1039 then
				arg_373_1.var_.characterEffect1039.alpha = 1
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				local var_376_16 = arg_373_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_16 then
					arg_373_1.var_.alphaOldValue1070 = var_376_16.alpha
					arg_373_1.var_.characterEffect1070 = var_376_16
				end

				arg_373_1.var_.alphaOldValue1070 = 0
			end

			local var_376_17 = 0.6

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_17 then
				if arg_373_1.var_.characterEffect1070 then
					arg_373_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_373_1.var_.alphaOldValue1070, 1, (arg_373_1.time_ - 0) / var_376_17)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_17 and arg_373_1.time_ < 0 + var_376_17 + arg_376_0 and arg_373_1.var_.characterEffect1070 then
				arg_373_1.var_.characterEffect1070.alpha = 1
			end

			local var_376_18 = arg_373_1.actors_["1070"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1070 = var_376_18.localPosition
				var_376_18.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1070", 7)

				for iter_376_12 = 0, var_376_18.childCount - 1 do
					local var_376_19 = var_376_18:GetChild(iter_376_12)

					if var_376_19.name == "split_5" or not string.find(var_376_19.name, "split") then
						var_376_19.gameObject:SetActive(true)
					else
						var_376_19.gameObject:SetActive(false)
					end
				end
			end

			local var_376_20 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_20 then
				var_376_18.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_373_1.time_ - 0) / var_376_20)
			end

			if arg_373_1.time_ >= 0 + var_376_20 and arg_373_1.time_ < 0 + var_376_20 + arg_376_0 then
				var_376_18.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_376_21 = 0
			local var_376_22 = 0.25

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_21 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_23 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(910110092).content)

				arg_373_1.text_.text = var_376_23

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_25 = 10 <= 0 and var_376_22 or var_376_22 * (utf8.len(var_376_23) / 10)

				if (10 <= 0 and var_376_22 or var_376_22 * (utf8.len(var_376_23) / 10)) > 0 and var_376_22 < var_376_25 then
					arg_373_1.talkMaxDuration = var_376_25

					if var_376_25 + var_376_21 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_25 + var_376_21
					end
				end

				arg_373_1.text_.text = var_376_23
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_26 = math.max(var_376_22, arg_373_1.talkMaxDuration)

			if var_376_21 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_26 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_21) / var_376_26

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_21 + var_376_26 and arg_373_1.time_ < var_376_21 + var_376_26 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play910110093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 910110093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play910110094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1039"]) and arg_377_1.var_.actorSpriteComps1039 == nil then
				arg_377_1.var_.actorSpriteComps1039 = arg_377_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1039"]) then
				if arg_377_1.var_.actorSpriteComps1039 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1039"]) and arg_377_1.var_.actorSpriteComps1039 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps1039 = nil
			end

			local var_380_2 = arg_377_1.actors_["1070"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1070 == nil then
				arg_377_1.var_.actorSpriteComps1070 = var_380_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_3 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.actorSpriteComps1070 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								iter_380_5.color = Color.New(Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_3), Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_3), (Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_3)))
							else
								local var_380_4 = Mathf.Lerp(iter_380_5.color.r, 1, (arg_377_1.time_ - 0) / var_380_3)

								iter_380_5.color = Color.New(var_380_4, var_380_4, var_380_4)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps1070 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_380_7 then
						iter_380_7.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps1070 = nil
			end

			local var_380_5 = 0
			local var_380_6 = 0.325

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(910110093).content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 13 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_7) / 13)

				if (13 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_7) / 13)) > 0 and var_380_6 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_10 and arg_377_1.time_ < var_380_5 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play910110094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 910110094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play910110095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1070 = arg_381_1.actors_["1070"].transform.localPosition
				arg_381_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1070", 4)

				for iter_384_0 = 0, arg_381_1.actors_["1070"].transform.childCount - 1 do
					local var_384_0 = arg_381_1.actors_["1070"].transform:GetChild(iter_384_0)

					if var_384_0.name == "split_5" or not string.find(var_384_0.name, "split") then
						var_384_0.gameObject:SetActive(true)
					else
						var_384_0.gameObject:SetActive(false)
					end
				end
			end

			local var_384_1 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_1 then
				arg_381_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1070, Vector3.New(390, -350, -180), (arg_381_1.time_ - 0) / var_384_1)
			end

			if arg_381_1.time_ >= 0 + var_384_1 and arg_381_1.time_ < 0 + var_384_1 + arg_384_0 then
				arg_381_1.actors_["1070"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_384_2 = arg_381_1.actors_["1039"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1039 == nil then
				arg_381_1.var_.actorSpriteComps1039 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.0166666666666667

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps1039 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_384_2 then
							if arg_381_1.isInRecall_ then
								iter_384_2.color = Color.New(Mathf.Lerp(iter_384_2.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_2.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_2.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_2.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_2.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1039 then
				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_384_4 then
						iter_384_4.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1039 = nil
			end

			local var_384_5 = 0
			local var_384_6 = 0.2

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(910110094).content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 8 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_7) / 8)

				if (8 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_7) / 8)) > 0 and var_384_6 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_5
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_6, arg_381_1.talkMaxDuration)

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_5) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_5 + var_384_10 and arg_381_1.time_ < var_384_5 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play910110095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 910110095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play910110096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1039"]) and arg_385_1.var_.actorSpriteComps1039 == nil then
				arg_385_1.var_.actorSpriteComps1039 = arg_385_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.0166666666666667

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1039"]) then
				if arg_385_1.var_.actorSpriteComps1039 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 1, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1039"]) and arg_385_1.var_.actorSpriteComps1039 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1039 = nil
			end

			local var_388_2 = arg_385_1.actors_["1070"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1070 == nil then
				arg_385_1.var_.actorSpriteComps1070 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 0.0166666666666667

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps1070 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								iter_388_5.color = Color.New(Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_5.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_5.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1070 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps1070 = nil
			end

			local var_388_5 = 0
			local var_388_6 = 1.3

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(910110095).content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 52 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 52)

				if (52 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 52)) > 0 and var_388_6 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_10 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_10 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_10

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_10 and arg_385_1.time_ < var_388_5 + var_388_10 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play910110096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 910110096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play910110097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1039"]) and arg_389_1.var_.actorSpriteComps1039 == nil then
				arg_389_1.var_.actorSpriteComps1039 = arg_389_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.0166666666666667

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1039"]) then
				if arg_389_1.var_.actorSpriteComps1039 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1039"]) and arg_389_1.var_.actorSpriteComps1039 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps1039 = nil
			end

			local var_392_2 = arg_389_1.actors_["1070"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1070 == nil then
				arg_389_1.var_.actorSpriteComps1070 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 0.0166666666666667

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps1070 then
					for iter_392_4, iter_392_5 in pairs(arg_389_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_392_5 then
							if arg_389_1.isInRecall_ then
								iter_392_5.color = Color.New(Mathf.Lerp(iter_392_5.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_3), Mathf.Lerp(iter_392_5.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_3), (Mathf.Lerp(iter_392_5.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_3)))
							else
								local var_392_4 = Mathf.Lerp(iter_392_5.color.r, 1, (arg_389_1.time_ - 0) / var_392_3)

								iter_392_5.color = Color.New(var_392_4, var_392_4, var_392_4)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps1070 then
				for iter_392_6, iter_392_7 in pairs(arg_389_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_392_7 then
						iter_392_7.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps1070 = nil
			end

			local var_392_5 = 0
			local var_392_6 = 0.575

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(910110096).content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 23 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 23)

				if (23 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_7) / 23)) > 0 and var_392_6 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_10 and arg_389_1.time_ < var_392_5 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play910110097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 910110097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play910110098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1039"]) and arg_393_1.var_.actorSpriteComps1039 == nil then
				arg_393_1.var_.actorSpriteComps1039 = arg_393_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1039"]) then
				if arg_393_1.var_.actorSpriteComps1039 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								iter_396_1.color = Color.New(Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_0), Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_0), (Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_0)))
							else
								local var_396_1 = Mathf.Lerp(iter_396_1.color.r, 1, (arg_393_1.time_ - 0) / var_396_0)

								iter_396_1.color = Color.New(var_396_1, var_396_1, var_396_1)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1039"]) and arg_393_1.var_.actorSpriteComps1039 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1039 = nil
			end

			local var_396_2 = arg_393_1.actors_["1070"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1070 == nil then
				arg_393_1.var_.actorSpriteComps1070 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps1070 then
					for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_396_5 then
							if arg_393_1.isInRecall_ then
								iter_396_5.color = Color.New(Mathf.Lerp(iter_396_5.color.r, arg_393_1.hightColor2.r, (arg_393_1.time_ - 0) / var_396_3), Mathf.Lerp(iter_396_5.color.g, arg_393_1.hightColor2.g, (arg_393_1.time_ - 0) / var_396_3), (Mathf.Lerp(iter_396_5.color.b, arg_393_1.hightColor2.b, (arg_393_1.time_ - 0) / var_396_3)))
							else
								local var_396_4 = Mathf.Lerp(iter_396_5.color.r, 0.5, (arg_393_1.time_ - 0) / var_396_3)

								iter_396_5.color = Color.New(var_396_4, var_396_4, var_396_4)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps1070 then
				for iter_396_6, iter_396_7 in pairs(arg_393_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_396_7 then
						iter_396_7.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_393_1.var_.actorSpriteComps1070 = nil
			end

			local var_396_5 = 0
			local var_396_6 = 0.65

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_7 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(910110097).content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_9 = 26 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_7) / 26)

				if (26 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_7) / 26)) > 0 and var_396_6 < var_396_9 then
					arg_393_1.talkMaxDuration = var_396_9

					if var_396_9 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_9 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_6, arg_393_1.talkMaxDuration)

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_5) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_5 + var_396_10 and arg_393_1.time_ < var_396_5 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play910110098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 910110098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play910110099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1039"]) and arg_397_1.var_.actorSpriteComps1039 == nil then
				arg_397_1.var_.actorSpriteComps1039 = arg_397_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1039"]) then
				if arg_397_1.var_.actorSpriteComps1039 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1039"]) and arg_397_1.var_.actorSpriteComps1039 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1039 = nil
			end

			local var_400_2 = arg_397_1.actors_["1070"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1070 == nil then
				arg_397_1.var_.actorSpriteComps1070 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 0.0166666666666667

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps1070 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_400_5 then
							if arg_397_1.isInRecall_ then
								iter_400_5.color = Color.New(Mathf.Lerp(iter_400_5.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_5.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_5.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_5.color.r, 1, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_5.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps1070 then
				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_400_7 then
						iter_400_7.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps1070 = nil
			end

			local var_400_5 = arg_397_1.actors_["1070"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1070 = var_400_5.localPosition
				var_400_5.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("1070", 4)

				for iter_400_8 = 0, var_400_5.childCount - 1 do
					local var_400_6 = var_400_5:GetChild(iter_400_8)

					if var_400_6.name == "split_2" or not string.find(var_400_6.name, "split") then
						var_400_6.gameObject:SetActive(true)
					else
						var_400_6.gameObject:SetActive(false)
					end
				end
			end

			local var_400_7 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				var_400_5.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1070, Vector3.New(390, -350, -180), (arg_397_1.time_ - 0) / var_400_7)
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				var_400_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_400_8 = 0
			local var_400_9 = 0.375

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(910110098).content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_12 = 15 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_10) / 15)

				if (15 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_10) / 15)) > 0 and var_400_9 < var_400_12 then
					arg_397_1.talkMaxDuration = var_400_12

					if var_400_12 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_13 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_13 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_13

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_13 and arg_397_1.time_ < var_400_8 + var_400_13 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play910110099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 910110099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play910110100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1039"]) and arg_401_1.var_.actorSpriteComps1039 == nil then
				arg_401_1.var_.actorSpriteComps1039 = arg_401_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1039"]) then
				if arg_401_1.var_.actorSpriteComps1039 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 1, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1039"]) and arg_401_1.var_.actorSpriteComps1039 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps1039 = nil
			end

			local var_404_2 = arg_401_1.actors_["1070"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps1070 == nil then
				arg_401_1.var_.actorSpriteComps1070 = var_404_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_3 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 and not isNil(var_404_2) then
				if arg_401_1.var_.actorSpriteComps1070 then
					for iter_404_4, iter_404_5 in pairs(arg_401_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_404_5 then
							if arg_401_1.isInRecall_ then
								iter_404_5.color = Color.New(Mathf.Lerp(iter_404_5.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_3), Mathf.Lerp(iter_404_5.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_3), (Mathf.Lerp(iter_404_5.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_3)))
							else
								local var_404_4 = Mathf.Lerp(iter_404_5.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_3)

								iter_404_5.color = Color.New(var_404_4, var_404_4, var_404_4)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and not isNil(var_404_2) and arg_401_1.var_.actorSpriteComps1070 then
				for iter_404_6, iter_404_7 in pairs(arg_401_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_404_7 then
						iter_404_7.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps1070 = nil
			end

			local var_404_5 = 0
			local var_404_6 = 0.65

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(910110099).content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 26 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_7) / 26)

				if (26 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_7) / 26)) > 0 and var_404_6 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_10 and arg_401_1.time_ < var_404_5 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play910110100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 910110100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play910110101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1039"]) and arg_405_1.var_.actorSpriteComps1039 == nil then
				arg_405_1.var_.actorSpriteComps1039 = arg_405_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_0 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1039"]) then
				if arg_405_1.var_.actorSpriteComps1039 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								iter_408_1.color = Color.New(Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor2.r, (arg_405_1.time_ - 0) / var_408_0), Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor2.g, (arg_405_1.time_ - 0) / var_408_0), (Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor2.b, (arg_405_1.time_ - 0) / var_408_0)))
							else
								local var_408_1 = Mathf.Lerp(iter_408_1.color.r, 0.5, (arg_405_1.time_ - 0) / var_408_0)

								iter_408_1.color = Color.New(var_408_1, var_408_1, var_408_1)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1039"]) and arg_405_1.var_.actorSpriteComps1039 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_408_3 then
						iter_408_3.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_405_1.var_.actorSpriteComps1039 = nil
			end

			local var_408_2 = arg_405_1.actors_["1070"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps1070 == nil then
				arg_405_1.var_.actorSpriteComps1070 = var_408_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_3 = 0.0166666666666667

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_3 and not isNil(var_408_2) then
				if arg_405_1.var_.actorSpriteComps1070 then
					for iter_408_4, iter_408_5 in pairs(arg_405_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_408_5 then
							if arg_405_1.isInRecall_ then
								iter_408_5.color = Color.New(Mathf.Lerp(iter_408_5.color.r, arg_405_1.hightColor1.r, (arg_405_1.time_ - 0) / var_408_3), Mathf.Lerp(iter_408_5.color.g, arg_405_1.hightColor1.g, (arg_405_1.time_ - 0) / var_408_3), (Mathf.Lerp(iter_408_5.color.b, arg_405_1.hightColor1.b, (arg_405_1.time_ - 0) / var_408_3)))
							else
								local var_408_4 = Mathf.Lerp(iter_408_5.color.r, 1, (arg_405_1.time_ - 0) / var_408_3)

								iter_408_5.color = Color.New(var_408_4, var_408_4, var_408_4)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_3 and arg_405_1.time_ < 0 + var_408_3 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps1070 then
				for iter_408_6, iter_408_7 in pairs(arg_405_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_408_7 then
						iter_408_7.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_405_1.var_.actorSpriteComps1070 = nil
			end

			local var_408_5 = arg_405_1.actors_["1070"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1070 = var_408_5.localPosition
				var_408_5.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("1070", 4)

				for iter_408_8 = 0, var_408_5.childCount - 1 do
					local var_408_6 = var_408_5:GetChild(iter_408_8)

					if var_408_6.name == "split_7" or not string.find(var_408_6.name, "split") then
						var_408_6.gameObject:SetActive(true)
					else
						var_408_6.gameObject:SetActive(false)
					end
				end
			end

			local var_408_7 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				var_408_5.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1070, Vector3.New(390, -350, -180), (arg_405_1.time_ - 0) / var_408_7)
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				var_408_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_408_8 = 0
			local var_408_9 = 0.325

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(910110100).content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_12 = 13 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_10) / 13)

				if (13 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_10) / 13)) > 0 and var_408_9 < var_408_12 then
					arg_405_1.talkMaxDuration = var_408_12

					if var_408_12 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_12 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_13 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_13 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_13

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_13 and arg_405_1.time_ < var_408_8 + var_408_13 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play910110101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 910110101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play910110102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1039"]) and arg_409_1.var_.actorSpriteComps1039 == nil then
				arg_409_1.var_.actorSpriteComps1039 = arg_409_1.actors_["1039"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1039"]) then
				if arg_409_1.var_.actorSpriteComps1039 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 1, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1039"]) and arg_409_1.var_.actorSpriteComps1039 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps1039 = nil
			end

			local var_412_2 = arg_409_1.actors_["1070"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1070 == nil then
				arg_409_1.var_.actorSpriteComps1070 = var_412_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_3 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.actorSpriteComps1070 then
					for iter_412_4, iter_412_5 in pairs(arg_409_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_412_5 then
							if arg_409_1.isInRecall_ then
								iter_412_5.color = Color.New(Mathf.Lerp(iter_412_5.color.r, arg_409_1.hightColor2.r, (arg_409_1.time_ - 0) / var_412_3), Mathf.Lerp(iter_412_5.color.g, arg_409_1.hightColor2.g, (arg_409_1.time_ - 0) / var_412_3), (Mathf.Lerp(iter_412_5.color.b, arg_409_1.hightColor2.b, (arg_409_1.time_ - 0) / var_412_3)))
							else
								local var_412_4 = Mathf.Lerp(iter_412_5.color.r, 0.5, (arg_409_1.time_ - 0) / var_412_3)

								iter_412_5.color = Color.New(var_412_4, var_412_4, var_412_4)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1070 then
				for iter_412_6, iter_412_7 in pairs(arg_409_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_412_7 then
						iter_412_7.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_409_1.var_.actorSpriteComps1070 = nil
			end

			local var_412_5 = 0
			local var_412_6 = 0.725

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_7 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(910110101).content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 29 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 29)

				if (29 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 29)) > 0 and var_412_6 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_10 and arg_409_1.time_ < var_412_5 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play910110102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 910110102
		arg_413_1.duration_ = 7

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play910110103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if arg_413_1.bgs_.I05a == nil then
				local var_416_0 = Object.Instantiate(arg_413_1.paintGo_)

				var_416_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_416_0.name = "I05a"
				var_416_0.transform.parent = arg_413_1.stage_.transform
				var_416_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.bgs_.I05a = var_416_0
			end

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= 2 + arg_416_0 then
				local var_416_1 = arg_413_1.bgs_.I05a

				arg_413_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_416_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_2 = var_416_1:GetComponent("SpriteRenderer")

				if var_416_2 and var_416_2.sprite then
					local var_416_3 = 2 * (var_416_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_416_1.transform.localScale = Vector3.New(var_416_3 / var_416_2.sprite.bounds.size.y < var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x and var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x or var_416_3 / var_416_2.sprite.bounds.size.y, var_416_3 / var_416_2.sprite.bounds.size.y < var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x and var_416_3 * manager.ui.mainCameraCom_.aspect / var_416_2.sprite.bounds.size.x or var_416_3 / var_416_2.sprite.bounds.size.y, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "I05a" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_4 = arg_413_1.actors_["1070"].transform

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= 2 + arg_416_0 then
				arg_413_1.var_.moveOldPos1070 = var_416_4.localPosition
				var_416_4.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1070", 3)

				for iter_416_2 = 0, var_416_4.childCount - 1 do
					local var_416_5 = var_416_4:GetChild(iter_416_2)

					if var_416_5.name == "split_2" or not string.find(var_416_5.name, "split") then
						var_416_5.gameObject:SetActive(true)
					else
						var_416_5.gameObject:SetActive(false)
					end
				end
			end

			local var_416_6 = 0.001

			if 2 <= arg_413_1.time_ and arg_413_1.time_ < 2 + var_416_6 then
				var_416_4.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_413_1.time_ - 2) / var_416_6)
			end

			if arg_413_1.time_ >= 2 + var_416_6 and arg_413_1.time_ < 2 + var_416_6 + arg_416_0 then
				var_416_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_416_7 = arg_413_1.actors_["1070"]

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= 2 + arg_416_0 and not isNil(var_416_7) and arg_413_1.var_.actorSpriteComps1070 == nil then
				arg_413_1.var_.actorSpriteComps1070 = var_416_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_8 = 0.0166666666666667

			if 2 <= arg_413_1.time_ and arg_413_1.time_ < 2 + var_416_8 and not isNil(var_416_7) then
				if arg_413_1.var_.actorSpriteComps1070 then
					for iter_416_3, iter_416_4 in pairs(arg_413_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_416_4 then
							if arg_413_1.isInRecall_ then
								iter_416_4.color = Color.New(Mathf.Lerp(iter_416_4.color.r, arg_413_1.hightColor1.r, (arg_413_1.time_ - 2) / var_416_8), Mathf.Lerp(iter_416_4.color.g, arg_413_1.hightColor1.g, (arg_413_1.time_ - 2) / var_416_8), (Mathf.Lerp(iter_416_4.color.b, arg_413_1.hightColor1.b, (arg_413_1.time_ - 2) / var_416_8)))
							else
								local var_416_9 = Mathf.Lerp(iter_416_4.color.r, 1, (arg_413_1.time_ - 2) / var_416_8)

								iter_416_4.color = Color.New(var_416_9, var_416_9, var_416_9)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 2 + var_416_8 and arg_413_1.time_ < 2 + var_416_8 + arg_416_0 and not isNil(var_416_7) and arg_413_1.var_.actorSpriteComps1070 then
				for iter_416_5, iter_416_6 in pairs(arg_413_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_416_6 then
						iter_416_6.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_413_1.var_.actorSpriteComps1070 = nil
			end

			local var_416_10 = arg_413_1.actors_["1070"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1070 = var_416_10.localPosition
				var_416_10.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1070", 7)

				for iter_416_7 = 0, var_416_10.childCount - 1 do
					local var_416_11 = var_416_10:GetChild(iter_416_7)

					if var_416_11.name == "split_7" or not string.find(var_416_11.name, "split") then
						var_416_11.gameObject:SetActive(true)
					else
						var_416_11.gameObject:SetActive(false)
					end
				end
			end

			local var_416_12 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_12 then
				var_416_10.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_413_1.time_ - 0) / var_416_12)
			end

			if arg_413_1.time_ >= 0 + var_416_12 and arg_413_1.time_ < 0 + var_416_12 + arg_416_0 then
				var_416_10.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_416_13 = arg_413_1.actors_["1039"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1039 = var_416_13.localPosition
				var_416_13.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1039", 7)

				for iter_416_8 = 0, var_416_13.childCount - 1 do
					local var_416_14 = var_416_13:GetChild(iter_416_8)

					if var_416_14.name == "split_1" or not string.find(var_416_14.name, "split") then
						var_416_14.gameObject:SetActive(true)
					else
						var_416_14.gameObject:SetActive(false)
					end
				end
			end

			local var_416_15 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_15 then
				var_416_13.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1039, Vector3.New(0, -2000, -180), (arg_413_1.time_ - 0) / var_416_15)
			end

			if arg_413_1.time_ >= 0 + var_416_15 and arg_413_1.time_ < 0 + var_416_15 + arg_416_0 then
				var_416_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_416_16 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_17 = 2

			if var_416_16 <= arg_413_1.time_ and arg_413_1.time_ < var_416_16 + var_416_17 then
				local var_416_18 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_18.a = Mathf.Lerp(0, 1, (arg_413_1.time_ - var_416_16) / var_416_17)
				arg_413_1.mask_.color = var_416_18
			end

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 then
				local var_416_19 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_19.a = 1
				arg_413_1.mask_.color = var_416_19
			end

			local var_416_20 = 2

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= var_416_20 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_21 = 2

			if var_416_20 <= arg_413_1.time_ and arg_413_1.time_ < var_416_20 + var_416_21 then
				local var_416_22 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_22.a = Mathf.Lerp(1, 0, (arg_413_1.time_ - var_416_20) / var_416_21)
				arg_413_1.mask_.color = var_416_22
			end

			if arg_413_1.time_ >= var_416_20 + var_416_21 and arg_413_1.time_ < var_416_20 + var_416_21 + arg_416_0 then
				local var_416_23 = Color.New(0.01886791, 0.01877891, 0.01877891)

				arg_413_1.mask_.enabled = false
				var_416_23.a = 0
				arg_413_1.mask_.color = var_416_23
			end

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= 2 + arg_416_0 then
				local var_416_24 = arg_413_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_24 then
					arg_413_1.var_.alphaOldValue1070 = var_416_24.alpha
					arg_413_1.var_.characterEffect1070 = var_416_24
				end

				arg_413_1.var_.alphaOldValue1070 = 0
			end

			local var_416_25 = 0.566666666666667

			if 2 <= arg_413_1.time_ and arg_413_1.time_ < 2 + var_416_25 then
				if arg_413_1.var_.characterEffect1070 then
					arg_413_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_413_1.var_.alphaOldValue1070, 1, (arg_413_1.time_ - 2) / var_416_25)
				end
			end

			if arg_413_1.time_ >= 2 + var_416_25 and arg_413_1.time_ < 2 + var_416_25 + arg_416_0 and arg_413_1.var_.characterEffect1070 then
				arg_413_1.var_.characterEffect1070.alpha = 1
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				local var_416_26 = arg_413_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_26 then
					arg_413_1.var_.alphaOldValue1070 = var_416_26.alpha
					arg_413_1.var_.characterEffect1070 = var_416_26
				end

				arg_413_1.var_.alphaOldValue1070 = 1
			end

			local var_416_27 = 0.0166666666666667

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_27 then
				if arg_413_1.var_.characterEffect1070 then
					arg_413_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_413_1.var_.alphaOldValue1070, 0, (arg_413_1.time_ - 0) / var_416_27)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_27 and arg_413_1.time_ < 0 + var_416_27 + arg_416_0 and arg_413_1.var_.characterEffect1070 then
				arg_413_1.var_.characterEffect1070.alpha = 0
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				local var_416_28 = arg_413_1.actors_["1039"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_28 then
					arg_413_1.var_.alphaOldValue1039 = var_416_28.alpha
					arg_413_1.var_.characterEffect1039 = var_416_28
				end

				arg_413_1.var_.alphaOldValue1039 = 1
			end

			local var_416_29 = 0.0166666666666667

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_29 then
				if arg_413_1.var_.characterEffect1039 then
					arg_413_1.var_.characterEffect1039.alpha = Mathf.Lerp(arg_413_1.var_.alphaOldValue1039, 0, (arg_413_1.time_ - 0) / var_416_29)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_29 and arg_413_1.time_ < 0 + var_416_29 + arg_416_0 and arg_413_1.var_.characterEffect1039 then
				arg_413_1.var_.characterEffect1039.alpha = 0
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_30 = 2
			local var_416_31 = 1.775

			if 2 < arg_413_1.time_ and arg_413_1.time_ <= var_416_30 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_32 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_32:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_33 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(910110102).content)

				arg_413_1.text_.text = var_416_33

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_35 = 71 <= 0 and var_416_31 or var_416_31 * (utf8.len(var_416_33) / 71)

				if (71 <= 0 and var_416_31 or var_416_31 * (utf8.len(var_416_33) / 71)) > 0 and var_416_31 < var_416_35 then
					arg_413_1.talkMaxDuration = var_416_35
					var_416_30 = var_416_30 + 0.3

					if var_416_35 + var_416_30 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_35 + var_416_30
					end
				end

				arg_413_1.text_.text = var_416_33
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_36 = var_416_30 + 0.3
			local var_416_37 = math.max(var_416_31, arg_413_1.talkMaxDuration)

			if var_416_30 + 0.3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_36 + var_416_37 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_36) / var_416_37

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_36 + var_416_37 and arg_413_1.time_ < var_416_36 + var_416_37 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1039",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play910110103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 910110103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play910110104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.45

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(910110103).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 18 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 18)

				if (18 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 18)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play910110104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 910110104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play910110105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1070"]) and arg_423_1.var_.actorSpriteComps1070 == nil then
				arg_423_1.var_.actorSpriteComps1070 = arg_423_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1070"]) then
				if arg_423_1.var_.actorSpriteComps1070 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								iter_426_1.color = Color.New(Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_0), Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_0), (Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_0)))
							else
								local var_426_1 = Mathf.Lerp(iter_426_1.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_0)

								iter_426_1.color = Color.New(var_426_1, var_426_1, var_426_1)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1070"]) and arg_423_1.var_.actorSpriteComps1070 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps1070 = nil
			end

			local var_426_2 = 0
			local var_426_3 = 0.8

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_4 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(910110104).content)

				arg_423_1.text_.text = var_426_4

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_6 = 32 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_4) / 32)

				if (32 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_4) / 32)) > 0 and var_426_3 < var_426_6 then
					arg_423_1.talkMaxDuration = var_426_6

					if var_426_6 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_6 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_4
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_7 and arg_423_1.time_ < var_426_2 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play910110105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 910110105
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play910110106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.4

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(910110105).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 56 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 56)

				if (56 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 56)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play910110106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 910110106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play910110107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1070"]) and arg_431_1.var_.actorSpriteComps1070 == nil then
				arg_431_1.var_.actorSpriteComps1070 = arg_431_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1070"]) then
				if arg_431_1.var_.actorSpriteComps1070 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								iter_434_1.color = Color.New(Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor1.r, (arg_431_1.time_ - 0) / var_434_0), Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor1.g, (arg_431_1.time_ - 0) / var_434_0), (Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor1.b, (arg_431_1.time_ - 0) / var_434_0)))
							else
								local var_434_1 = Mathf.Lerp(iter_434_1.color.r, 1, (arg_431_1.time_ - 0) / var_434_0)

								iter_434_1.color = Color.New(var_434_1, var_434_1, var_434_1)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1070"]) and arg_431_1.var_.actorSpriteComps1070 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_431_1.var_.actorSpriteComps1070 = nil
			end

			local var_434_2 = 0
			local var_434_3 = 0.15

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_4 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(910110106).content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_6 = 6 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_4) / 6)

				if (6 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_4) / 6)) > 0 and var_434_3 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_7 and arg_431_1.time_ < var_434_2 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play910110107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 910110107
		arg_435_1.duration_ = 0.2

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"

			SetActive(arg_435_1.choicesGo_, true)

			for iter_436_0, iter_436_1 in ipairs(arg_435_1.choices_) do
				SetActive(iter_436_1.go, iter_436_0 <= 2)
			end

			arg_435_1.choices_[1].txt.text = arg_435_1:FormatText(StoryChoiceCfg[296].name)
			arg_435_1.choices_[2].txt.text = arg_435_1:FormatText(StoryChoiceCfg[297].name)
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play910110108(arg_435_1)
			end

			if arg_437_0 == 2 then
				arg_435_0:Play910110108(arg_435_1)
			end

			arg_435_1:RecordChoiceLog(910110107, 296, 297)
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1070"]) and arg_435_1.var_.actorSpriteComps1070 == nil then
				arg_435_1.var_.actorSpriteComps1070 = arg_435_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1070"]) then
				if arg_435_1.var_.actorSpriteComps1070 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								iter_438_1.color = Color.New(Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor2.r, (arg_435_1.time_ - 0) / var_438_0), Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor2.g, (arg_435_1.time_ - 0) / var_438_0), (Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor2.b, (arg_435_1.time_ - 0) / var_438_0)))
							else
								local var_438_1 = Mathf.Lerp(iter_438_1.color.r, 0.5, (arg_435_1.time_ - 0) / var_438_0)

								iter_438_1.color = Color.New(var_438_1, var_438_1, var_438_1)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1070"]) and arg_435_1.var_.actorSpriteComps1070 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_435_1.var_.actorSpriteComps1070 = nil
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play910110108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 910110108
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play910110109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1070"]) and arg_439_1.var_.actorSpriteComps1070 == nil then
				arg_439_1.var_.actorSpriteComps1070 = arg_439_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_0 = 0.0166666666666667

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1070"]) then
				if arg_439_1.var_.actorSpriteComps1070 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_442_1 then
							if arg_439_1.isInRecall_ then
								iter_442_1.color = Color.New(Mathf.Lerp(iter_442_1.color.r, arg_439_1.hightColor1.r, (arg_439_1.time_ - 0) / var_442_0), Mathf.Lerp(iter_442_1.color.g, arg_439_1.hightColor1.g, (arg_439_1.time_ - 0) / var_442_0), (Mathf.Lerp(iter_442_1.color.b, arg_439_1.hightColor1.b, (arg_439_1.time_ - 0) / var_442_0)))
							else
								local var_442_1 = Mathf.Lerp(iter_442_1.color.r, 1, (arg_439_1.time_ - 0) / var_442_0)

								iter_442_1.color = Color.New(var_442_1, var_442_1, var_442_1)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1070"]) and arg_439_1.var_.actorSpriteComps1070 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_442_3 then
						iter_442_3.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_439_1.var_.actorSpriteComps1070 = nil
			end

			local var_442_2 = arg_439_1.actors_["1070"].transform

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1070 = var_442_2.localPosition
				var_442_2.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("1070", 3)

				for iter_442_4 = 0, var_442_2.childCount - 1 do
					local var_442_3 = var_442_2:GetChild(iter_442_4)

					if var_442_3.name == "split_1" or not string.find(var_442_3.name, "split") then
						var_442_3.gameObject:SetActive(true)
					else
						var_442_3.gameObject:SetActive(false)
					end
				end
			end

			local var_442_4 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				var_442_2.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_439_1.time_ - 0) / var_442_4)
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				var_442_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_442_5 = 0
			local var_442_6 = 0.25

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_7 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(910110108).content)

				arg_439_1.text_.text = var_442_7

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_9 = 10 <= 0 and var_442_6 or var_442_6 * (utf8.len(var_442_7) / 10)

				if (10 <= 0 and var_442_6 or var_442_6 * (utf8.len(var_442_7) / 10)) > 0 and var_442_6 < var_442_9 then
					arg_439_1.talkMaxDuration = var_442_9

					if var_442_9 + var_442_5 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_9 + var_442_5
					end
				end

				arg_439_1.text_.text = var_442_7
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_6, arg_439_1.talkMaxDuration)

			if var_442_5 <= arg_439_1.time_ and arg_439_1.time_ < var_442_5 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_5) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_5 + var_442_10 and arg_439_1.time_ < var_442_5 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play910110109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 910110109
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play910110110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["1070"]) and arg_443_1.var_.actorSpriteComps1070 == nil then
				arg_443_1.var_.actorSpriteComps1070 = arg_443_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["1070"]) then
				if arg_443_1.var_.actorSpriteComps1070 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								iter_446_1.color = Color.New(Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_0), Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_0), (Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_0)))
							else
								local var_446_1 = Mathf.Lerp(iter_446_1.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_0)

								iter_446_1.color = Color.New(var_446_1, var_446_1, var_446_1)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["1070"]) and arg_443_1.var_.actorSpriteComps1070 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps1070 = nil
			end

			local var_446_2 = 0
			local var_446_3 = 0.975

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_4 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(910110109).content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_6 = 39 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_4) / 39)

				if (39 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_4) / 39)) > 0 and var_446_3 < var_446_6 then
					arg_443_1.talkMaxDuration = var_446_6

					if var_446_6 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_7 and arg_443_1.time_ < var_446_2 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play910110110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 910110110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play910110111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1070 = arg_447_1.actors_["1070"].transform.localPosition
				arg_447_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("1070", 3)

				for iter_450_0 = 0, arg_447_1.actors_["1070"].transform.childCount - 1 do
					local var_450_0 = arg_447_1.actors_["1070"].transform:GetChild(iter_450_0)

					if var_450_0.name == "split_2" or not string.find(var_450_0.name, "split") then
						var_450_0.gameObject:SetActive(true)
					else
						var_450_0.gameObject:SetActive(false)
					end
				end
			end

			local var_450_1 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_1 then
				arg_447_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_447_1.time_ - 0) / var_450_1)
			end

			if arg_447_1.time_ >= 0 + var_450_1 and arg_447_1.time_ < 0 + var_450_1 + arg_450_0 then
				arg_447_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_450_2 = arg_447_1.actors_["1070"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.actorSpriteComps1070 == nil then
				arg_447_1.var_.actorSpriteComps1070 = var_450_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_3 = 0.0166666666666667

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_3 and not isNil(var_450_2) then
				if arg_447_1.var_.actorSpriteComps1070 then
					for iter_450_1, iter_450_2 in pairs(arg_447_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_450_2 then
							if arg_447_1.isInRecall_ then
								iter_450_2.color = Color.New(Mathf.Lerp(iter_450_2.color.r, arg_447_1.hightColor1.r, (arg_447_1.time_ - 0) / var_450_3), Mathf.Lerp(iter_450_2.color.g, arg_447_1.hightColor1.g, (arg_447_1.time_ - 0) / var_450_3), (Mathf.Lerp(iter_450_2.color.b, arg_447_1.hightColor1.b, (arg_447_1.time_ - 0) / var_450_3)))
							else
								local var_450_4 = Mathf.Lerp(iter_450_2.color.r, 1, (arg_447_1.time_ - 0) / var_450_3)

								iter_450_2.color = Color.New(var_450_4, var_450_4, var_450_4)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= 0 + var_450_3 and arg_447_1.time_ < 0 + var_450_3 + arg_450_0 and not isNil(var_450_2) and arg_447_1.var_.actorSpriteComps1070 then
				for iter_450_3, iter_450_4 in pairs(arg_447_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_450_4 then
						iter_450_4.color = arg_447_1.isInRecall_ and (arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_447_1.var_.actorSpriteComps1070 = nil
			end

			local var_450_5 = 0
			local var_450_6 = 0.15

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_5 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_7 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(910110110).content)

				arg_447_1.text_.text = var_450_7

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_9 = 6 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_7) / 6)

				if (6 <= 0 and var_450_6 or var_450_6 * (utf8.len(var_450_7) / 6)) > 0 and var_450_6 < var_450_9 then
					arg_447_1.talkMaxDuration = var_450_9

					if var_450_9 + var_450_5 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_5
					end
				end

				arg_447_1.text_.text = var_450_7
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_6, arg_447_1.talkMaxDuration)

			if var_450_5 <= arg_447_1.time_ and arg_447_1.time_ < var_450_5 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_5) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_5 + var_450_10 and arg_447_1.time_ < var_450_5 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play910110111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 910110111
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play910110112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(arg_451_1.actors_["1070"]) and arg_451_1.var_.actorSpriteComps1070 == nil then
				arg_451_1.var_.actorSpriteComps1070 = arg_451_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_0 = 0.125

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 and not isNil(arg_451_1.actors_["1070"]) then
				if arg_451_1.var_.actorSpriteComps1070 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_454_1 then
							if arg_451_1.isInRecall_ then
								iter_454_1.color = Color.New(Mathf.Lerp(iter_454_1.color.r, arg_451_1.hightColor2.r, (arg_451_1.time_ - 0) / var_454_0), Mathf.Lerp(iter_454_1.color.g, arg_451_1.hightColor2.g, (arg_451_1.time_ - 0) / var_454_0), (Mathf.Lerp(iter_454_1.color.b, arg_451_1.hightColor2.b, (arg_451_1.time_ - 0) / var_454_0)))
							else
								local var_454_1 = Mathf.Lerp(iter_454_1.color.r, 0.5, (arg_451_1.time_ - 0) / var_454_0)

								iter_454_1.color = Color.New(var_454_1, var_454_1, var_454_1)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 and not isNil(arg_451_1.actors_["1070"]) and arg_451_1.var_.actorSpriteComps1070 then
				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_454_3 then
						iter_454_3.color = arg_451_1.isInRecall_ and (arg_451_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_451_1.var_.actorSpriteComps1070 = nil
			end

			local var_454_2 = 0
			local var_454_3 = 0.425

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_4 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(910110111).content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_6 = 17 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_4) / 17)

				if (17 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_4) / 17)) > 0 and var_454_3 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_7 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_7 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_7

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_7 and arg_451_1.time_ < var_454_2 + var_454_7 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play910110112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 910110112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play910110113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos1070 = arg_455_1.actors_["1070"].transform.localPosition
				arg_455_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("1070", 3)

				for iter_458_0 = 0, arg_455_1.actors_["1070"].transform.childCount - 1 do
					local var_458_0 = arg_455_1.actors_["1070"].transform:GetChild(iter_458_0)

					if var_458_0.name == "split_6" or not string.find(var_458_0.name, "split") then
						var_458_0.gameObject:SetActive(true)
					else
						var_458_0.gameObject:SetActive(false)
					end
				end
			end

			local var_458_1 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_1 then
				arg_455_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_455_1.time_ - 0) / var_458_1)
			end

			if arg_455_1.time_ >= 0 + var_458_1 and arg_455_1.time_ < 0 + var_458_1 + arg_458_0 then
				arg_455_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_458_2 = arg_455_1.actors_["1070"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.actorSpriteComps1070 == nil then
				arg_455_1.var_.actorSpriteComps1070 = var_458_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_3 = 0.0166666666666667

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_3 and not isNil(var_458_2) then
				if arg_455_1.var_.actorSpriteComps1070 then
					for iter_458_1, iter_458_2 in pairs(arg_455_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_458_2 then
							if arg_455_1.isInRecall_ then
								iter_458_2.color = Color.New(Mathf.Lerp(iter_458_2.color.r, arg_455_1.hightColor1.r, (arg_455_1.time_ - 0) / var_458_3), Mathf.Lerp(iter_458_2.color.g, arg_455_1.hightColor1.g, (arg_455_1.time_ - 0) / var_458_3), (Mathf.Lerp(iter_458_2.color.b, arg_455_1.hightColor1.b, (arg_455_1.time_ - 0) / var_458_3)))
							else
								local var_458_4 = Mathf.Lerp(iter_458_2.color.r, 1, (arg_455_1.time_ - 0) / var_458_3)

								iter_458_2.color = Color.New(var_458_4, var_458_4, var_458_4)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_3 and arg_455_1.time_ < 0 + var_458_3 + arg_458_0 and not isNil(var_458_2) and arg_455_1.var_.actorSpriteComps1070 then
				for iter_458_3, iter_458_4 in pairs(arg_455_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_458_4 then
						iter_458_4.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_455_1.var_.actorSpriteComps1070 = nil
			end

			local var_458_5 = 0
			local var_458_6 = 0.725

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_7 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(910110112).content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_9 = 29 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_7) / 29)

				if (29 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_7) / 29)) > 0 and var_458_6 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_5
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_6, arg_455_1.talkMaxDuration)

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_5) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_5 + var_458_10 and arg_455_1.time_ < var_458_5 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play910110113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 910110113
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play910110114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1070"]) and arg_459_1.var_.actorSpriteComps1070 == nil then
				arg_459_1.var_.actorSpriteComps1070 = arg_459_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_0 = 0.2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1070"]) then
				if arg_459_1.var_.actorSpriteComps1070 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_462_1 then
							if arg_459_1.isInRecall_ then
								iter_462_1.color = Color.New(Mathf.Lerp(iter_462_1.color.r, arg_459_1.hightColor2.r, (arg_459_1.time_ - 0) / var_462_0), Mathf.Lerp(iter_462_1.color.g, arg_459_1.hightColor2.g, (arg_459_1.time_ - 0) / var_462_0), (Mathf.Lerp(iter_462_1.color.b, arg_459_1.hightColor2.b, (arg_459_1.time_ - 0) / var_462_0)))
							else
								local var_462_1 = Mathf.Lerp(iter_462_1.color.r, 0.5, (arg_459_1.time_ - 0) / var_462_0)

								iter_462_1.color = Color.New(var_462_1, var_462_1, var_462_1)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1070"]) and arg_459_1.var_.actorSpriteComps1070 then
				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_462_3 then
						iter_462_3.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_459_1.var_.actorSpriteComps1070 = nil
			end

			local var_462_2 = 0
			local var_462_3 = 0.75

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_2 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_4 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(910110113).content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_6 = 30 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_4) / 30)

				if (30 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_4) / 30)) > 0 and var_462_3 < var_462_6 then
					arg_459_1.talkMaxDuration = var_462_6

					if var_462_6 + var_462_2 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_6 + var_462_2
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_7 = math.max(var_462_3, arg_459_1.talkMaxDuration)

			if var_462_2 <= arg_459_1.time_ and arg_459_1.time_ < var_462_2 + var_462_7 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_2) / var_462_7

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_2 + var_462_7 and arg_459_1.time_ < var_462_2 + var_462_7 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play910110114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 910110114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play910110115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 1.7

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(910110114).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 68 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 68)

				if (68 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 68)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play910110115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 910110115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play910110116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1070 = arg_467_1.actors_["1070"].transform.localPosition
				arg_467_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("1070", 3)

				for iter_470_0 = 0, arg_467_1.actors_["1070"].transform.childCount - 1 do
					local var_470_0 = arg_467_1.actors_["1070"].transform:GetChild(iter_470_0)

					if var_470_0.name == "split_8" or not string.find(var_470_0.name, "split") then
						var_470_0.gameObject:SetActive(true)
					else
						var_470_0.gameObject:SetActive(false)
					end
				end
			end

			local var_470_1 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_1 then
				arg_467_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_467_1.time_ - 0) / var_470_1)
			end

			if arg_467_1.time_ >= 0 + var_470_1 and arg_467_1.time_ < 0 + var_470_1 + arg_470_0 then
				arg_467_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_470_2 = 0
			local var_470_3 = 1.3

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_4 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(910110115).content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_6 = 52 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_4) / 52)

				if (52 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_4) / 52)) > 0 and var_470_3 < var_470_6 then
					arg_467_1.talkMaxDuration = var_470_6

					if var_470_6 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_6 + var_470_2
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_7 = math.max(var_470_3, arg_467_1.talkMaxDuration)

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_7 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_2) / var_470_7

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_2 + var_470_7 and arg_467_1.time_ < var_470_2 + var_470_7 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play910110116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 910110116
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play910110117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["1070"]) and arg_471_1.var_.actorSpriteComps1070 == nil then
				arg_471_1.var_.actorSpriteComps1070 = arg_471_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_0 = 0.2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["1070"]) then
				if arg_471_1.var_.actorSpriteComps1070 then
					for iter_474_0, iter_474_1 in pairs(arg_471_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_474_1 then
							if arg_471_1.isInRecall_ then
								iter_474_1.color = Color.New(Mathf.Lerp(iter_474_1.color.r, arg_471_1.hightColor2.r, (arg_471_1.time_ - 0) / var_474_0), Mathf.Lerp(iter_474_1.color.g, arg_471_1.hightColor2.g, (arg_471_1.time_ - 0) / var_474_0), (Mathf.Lerp(iter_474_1.color.b, arg_471_1.hightColor2.b, (arg_471_1.time_ - 0) / var_474_0)))
							else
								local var_474_1 = Mathf.Lerp(iter_474_1.color.r, 0.5, (arg_471_1.time_ - 0) / var_474_0)

								iter_474_1.color = Color.New(var_474_1, var_474_1, var_474_1)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["1070"]) and arg_471_1.var_.actorSpriteComps1070 then
				for iter_474_2, iter_474_3 in pairs(arg_471_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_474_3 then
						iter_474_3.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_471_1.var_.actorSpriteComps1070 = nil
			end

			local var_474_2 = 0
			local var_474_3 = 1.35

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_2 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_4 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(910110116).content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_6 = 54 <= 0 and var_474_3 or var_474_3 * (utf8.len(var_474_4) / 54)

				if (54 <= 0 and var_474_3 or var_474_3 * (utf8.len(var_474_4) / 54)) > 0 and var_474_3 < var_474_6 then
					arg_471_1.talkMaxDuration = var_474_6

					if var_474_6 + var_474_2 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_6 + var_474_2
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_7 = math.max(var_474_3, arg_471_1.talkMaxDuration)

			if var_474_2 <= arg_471_1.time_ and arg_471_1.time_ < var_474_2 + var_474_7 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_2) / var_474_7

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_2 + var_474_7 and arg_471_1.time_ < var_474_2 + var_474_7 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play910110117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 910110117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play910110118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0.05

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(910110117).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 2 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 2)

				if (2 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 2)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play910110118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 910110118
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play910110119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.325

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(910110118).content)

				arg_479_1.text_.text = var_482_1

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_3 = 13 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 13)

				if (13 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 13)) > 0 and var_482_0 < var_482_3 then
					arg_479_1.talkMaxDuration = var_482_3

					if var_482_3 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_3 + 0
					end
				end

				arg_479_1.text_.text = var_482_1
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_4 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_4

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play910110119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 910110119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play910110120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1070 = arg_483_1.actors_["1070"].transform.localPosition
				arg_483_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("1070", 3)

				for iter_486_0 = 0, arg_483_1.actors_["1070"].transform.childCount - 1 do
					local var_486_0 = arg_483_1.actors_["1070"].transform:GetChild(iter_486_0)

					if var_486_0.name == "split_1" or not string.find(var_486_0.name, "split") then
						var_486_0.gameObject:SetActive(true)
					else
						var_486_0.gameObject:SetActive(false)
					end
				end
			end

			local var_486_1 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_1 then
				arg_483_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_483_1.time_ - 0) / var_486_1)
			end

			if arg_483_1.time_ >= 0 + var_486_1 and arg_483_1.time_ < 0 + var_486_1 + arg_486_0 then
				arg_483_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_486_2 = arg_483_1.actors_["1070"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.actorSpriteComps1070 == nil then
				arg_483_1.var_.actorSpriteComps1070 = var_486_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_3 = 0.0166666666666667

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_3 and not isNil(var_486_2) then
				if arg_483_1.var_.actorSpriteComps1070 then
					for iter_486_1, iter_486_2 in pairs(arg_483_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_486_2 then
							if arg_483_1.isInRecall_ then
								iter_486_2.color = Color.New(Mathf.Lerp(iter_486_2.color.r, arg_483_1.hightColor1.r, (arg_483_1.time_ - 0) / var_486_3), Mathf.Lerp(iter_486_2.color.g, arg_483_1.hightColor1.g, (arg_483_1.time_ - 0) / var_486_3), (Mathf.Lerp(iter_486_2.color.b, arg_483_1.hightColor1.b, (arg_483_1.time_ - 0) / var_486_3)))
							else
								local var_486_4 = Mathf.Lerp(iter_486_2.color.r, 1, (arg_483_1.time_ - 0) / var_486_3)

								iter_486_2.color = Color.New(var_486_4, var_486_4, var_486_4)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_3 and arg_483_1.time_ < 0 + var_486_3 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.actorSpriteComps1070 then
				for iter_486_3, iter_486_4 in pairs(arg_483_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_486_4 then
						iter_486_4.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_483_1.var_.actorSpriteComps1070 = nil
			end

			local var_486_5 = 0
			local var_486_6 = 0.15

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_7 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(910110119).content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 6 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_7) / 6)

				if (6 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_7) / 6)) > 0 and var_486_6 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_5
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_6, arg_483_1.talkMaxDuration)

			if var_486_5 <= arg_483_1.time_ and arg_483_1.time_ < var_486_5 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_5) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_5 + var_486_10 and arg_483_1.time_ < var_486_5 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play910110120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 910110120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play910110121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1070"]) and arg_487_1.var_.actorSpriteComps1070 == nil then
				arg_487_1.var_.actorSpriteComps1070 = arg_487_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_0 = 0.2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1070"]) then
				if arg_487_1.var_.actorSpriteComps1070 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								iter_490_1.color = Color.New(Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor2.r, (arg_487_1.time_ - 0) / var_490_0), Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor2.g, (arg_487_1.time_ - 0) / var_490_0), (Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor2.b, (arg_487_1.time_ - 0) / var_490_0)))
							else
								local var_490_1 = Mathf.Lerp(iter_490_1.color.r, 0.5, (arg_487_1.time_ - 0) / var_490_0)

								iter_490_1.color = Color.New(var_490_1, var_490_1, var_490_1)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1070"]) and arg_487_1.var_.actorSpriteComps1070 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_490_3 then
						iter_490_3.color = arg_487_1.isInRecall_ and (arg_487_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_487_1.var_.actorSpriteComps1070 = nil
			end

			local var_490_2 = 0
			local var_490_3 = 0.4

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_2 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_4 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(910110120).content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_6 = 16 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_4) / 16)

				if (16 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_4) / 16)) > 0 and var_490_3 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_2
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_3, arg_487_1.talkMaxDuration)

			if var_490_2 <= arg_487_1.time_ and arg_487_1.time_ < var_490_2 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_2) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_2 + var_490_7 and arg_487_1.time_ < var_490_2 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play910110121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 910110121
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play910110122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1066 = arg_491_1.actors_["1066"].transform.localPosition
				arg_491_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1066", 3)

				for iter_494_0 = 0, arg_491_1.actors_["1066"].transform.childCount - 1 do
					local var_494_0 = arg_491_1.actors_["1066"].transform:GetChild(iter_494_0)

					if var_494_0.name == "split_1" or not string.find(var_494_0.name, "split") then
						var_494_0.gameObject:SetActive(true)
					else
						var_494_0.gameObject:SetActive(false)
					end
				end
			end

			local var_494_1 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_1 then
				arg_491_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1066, Vector3.New(0, -350, -180), (arg_491_1.time_ - 0) / var_494_1)
			end

			if arg_491_1.time_ >= 0 + var_494_1 and arg_491_1.time_ < 0 + var_494_1 + arg_494_0 then
				arg_491_1.actors_["1066"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				local var_494_2 = arg_491_1.actors_["1066"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_494_2 then
					arg_491_1.var_.alphaOldValue1066 = var_494_2.alpha
					arg_491_1.var_.characterEffect1066 = var_494_2
				end

				arg_491_1.var_.alphaOldValue1066 = 0
			end

			local var_494_3 = 0.5

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_3 then
				if arg_491_1.var_.characterEffect1066 then
					arg_491_1.var_.characterEffect1066.alpha = Mathf.Lerp(arg_491_1.var_.alphaOldValue1066, 1, (arg_491_1.time_ - 0) / var_494_3)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_3 and arg_491_1.time_ < 0 + var_494_3 + arg_494_0 and arg_491_1.var_.characterEffect1066 then
				arg_491_1.var_.characterEffect1066.alpha = 1
			end

			local var_494_4 = arg_491_1.actors_["1066"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_4) and arg_491_1.var_.actorSpriteComps1066 == nil then
				arg_491_1.var_.actorSpriteComps1066 = var_494_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_5 = 0.0166666666666667

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_5 and not isNil(var_494_4) then
				if arg_491_1.var_.actorSpriteComps1066 then
					for iter_494_1, iter_494_2 in pairs(arg_491_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_494_2 then
							if arg_491_1.isInRecall_ then
								iter_494_2.color = Color.New(Mathf.Lerp(iter_494_2.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_5), Mathf.Lerp(iter_494_2.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_5), (Mathf.Lerp(iter_494_2.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_5)))
							else
								local var_494_6 = Mathf.Lerp(iter_494_2.color.r, 1, (arg_491_1.time_ - 0) / var_494_5)

								iter_494_2.color = Color.New(var_494_6, var_494_6, var_494_6)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_5 and arg_491_1.time_ < 0 + var_494_5 + arg_494_0 and not isNil(var_494_4) and arg_491_1.var_.actorSpriteComps1066 then
				for iter_494_3, iter_494_4 in pairs(arg_491_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_494_4 then
						iter_494_4.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps1066 = nil
			end

			local var_494_7 = 0
			local var_494_8 = 0.05

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_7 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_9 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(910110121).content)

				arg_491_1.text_.text = var_494_9

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 2 <= 0 and var_494_8 or var_494_8 * (utf8.len(var_494_9) / 2)

				if (2 <= 0 and var_494_8 or var_494_8 * (utf8.len(var_494_9) / 2)) > 0 and var_494_8 < var_494_11 then
					arg_491_1.talkMaxDuration = var_494_11

					if var_494_11 + var_494_7 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_7
					end
				end

				arg_491_1.text_.text = var_494_9
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_12 = math.max(var_494_8, arg_491_1.talkMaxDuration)

			if var_494_7 <= arg_491_1.time_ and arg_491_1.time_ < var_494_7 + var_494_12 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_7) / var_494_12

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_7 + var_494_12 and arg_491_1.time_ < var_494_7 + var_494_12 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play910110122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 910110122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play910110123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["1066"]) and arg_495_1.var_.actorSpriteComps1066 == nil then
				arg_495_1.var_.actorSpriteComps1066 = arg_495_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_0 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["1066"]) then
				if arg_495_1.var_.actorSpriteComps1066 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								iter_498_1.color = Color.New(Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_0), Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_0), (Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_0)))
							else
								local var_498_1 = Mathf.Lerp(iter_498_1.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_0)

								iter_498_1.color = Color.New(var_498_1, var_498_1, var_498_1)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["1066"]) and arg_495_1.var_.actorSpriteComps1066 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps1066 = nil
			end

			local var_498_2 = 0
			local var_498_3 = 0.425

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_4 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(910110122).content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_6 = 17 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 17)

				if (17 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_4) / 17)) > 0 and var_498_3 < var_498_6 then
					arg_495_1.talkMaxDuration = var_498_6

					if var_498_6 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_6 + var_498_2
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_3, arg_495_1.talkMaxDuration)

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_2) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_2 + var_498_7 and arg_495_1.time_ < var_498_2 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play910110123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 910110123
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play910110124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1066 = arg_499_1.actors_["1066"].transform.localPosition
				arg_499_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("1066", 3)

				for iter_502_0 = 0, arg_499_1.actors_["1066"].transform.childCount - 1 do
					local var_502_0 = arg_499_1.actors_["1066"].transform:GetChild(iter_502_0)

					if var_502_0.name == "split_1" or not string.find(var_502_0.name, "split") then
						var_502_0.gameObject:SetActive(true)
					else
						var_502_0.gameObject:SetActive(false)
					end
				end
			end

			local var_502_1 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_1 then
				arg_499_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1066, Vector3.New(0, -350, -180), (arg_499_1.time_ - 0) / var_502_1)
			end

			if arg_499_1.time_ >= 0 + var_502_1 and arg_499_1.time_ < 0 + var_502_1 + arg_502_0 then
				arg_499_1.actors_["1066"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_502_2 = arg_499_1.actors_["1066"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps1066 == nil then
				arg_499_1.var_.actorSpriteComps1066 = var_502_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_3 = 0.0166666666666667

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_3 and not isNil(var_502_2) then
				if arg_499_1.var_.actorSpriteComps1066 then
					for iter_502_1, iter_502_2 in pairs(arg_499_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_502_2 then
							if arg_499_1.isInRecall_ then
								iter_502_2.color = Color.New(Mathf.Lerp(iter_502_2.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_3), Mathf.Lerp(iter_502_2.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_3), (Mathf.Lerp(iter_502_2.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_3)))
							else
								local var_502_4 = Mathf.Lerp(iter_502_2.color.r, 1, (arg_499_1.time_ - 0) / var_502_3)

								iter_502_2.color = Color.New(var_502_4, var_502_4, var_502_4)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_3 and arg_499_1.time_ < 0 + var_502_3 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps1066 then
				for iter_502_3, iter_502_4 in pairs(arg_499_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_502_4 then
						iter_502_4.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps1066 = nil
			end

			local var_502_5 = 0
			local var_502_6 = 0.1

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_7 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(910110123).content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 4 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_7) / 4)

				if (4 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_7) / 4)) > 0 and var_502_6 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_5
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_6, arg_499_1.talkMaxDuration)

			if var_502_5 <= arg_499_1.time_ and arg_499_1.time_ < var_502_5 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_5) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_5 + var_502_10 and arg_499_1.time_ < var_502_5 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play910110124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 910110124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play910110125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.55

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(910110124).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 22 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 22)

				if (22 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 22)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play910110125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 910110125
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play910110126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.175

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(910110125).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 7 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 7)

				if (7 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 7)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play910110126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 910110126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play910110127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1066"]) and arg_511_1.var_.actorSpriteComps1066 == nil then
				arg_511_1.var_.actorSpriteComps1066 = arg_511_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1066"]) then
				if arg_511_1.var_.actorSpriteComps1066 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								iter_514_1.color = Color.New(Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_0), Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_0), (Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_0)))
							else
								local var_514_1 = Mathf.Lerp(iter_514_1.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_0)

								iter_514_1.color = Color.New(var_514_1, var_514_1, var_514_1)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1066"]) and arg_511_1.var_.actorSpriteComps1066 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps1066 = nil
			end

			local var_514_2 = 0
			local var_514_3 = 0.675

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_4 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(910110126).content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_6 = 27 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_4) / 27)

				if (27 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_4) / 27)) > 0 and var_514_3 < var_514_6 then
					arg_511_1.talkMaxDuration = var_514_6

					if var_514_6 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_7 and arg_511_1.time_ < var_514_2 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play910110127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 910110127
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play910110128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 1.35

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(910110127).content)

				arg_515_1.text_.text = var_518_1

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_3 = 54 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 54)

				if (54 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_1) / 54)) > 0 and var_518_0 < var_518_3 then
					arg_515_1.talkMaxDuration = var_518_3

					if var_518_3 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_3 + 0
					end
				end

				arg_515_1.text_.text = var_518_1
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_4 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_4

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play910110128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 910110128
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play910110129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 1.375

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(910110128).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 55 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 55)

				if (55 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 55)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play910110129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 910110129
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play910110130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1070 = arg_523_1.actors_["1070"].transform.localPosition
				arg_523_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("1070", 3)

				for iter_526_0 = 0, arg_523_1.actors_["1070"].transform.childCount - 1 do
					local var_526_0 = arg_523_1.actors_["1070"].transform:GetChild(iter_526_0)

					if var_526_0.name == "split_9" or not string.find(var_526_0.name, "split") then
						var_526_0.gameObject:SetActive(true)
					else
						var_526_0.gameObject:SetActive(false)
					end
				end
			end

			local var_526_1 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_1 then
				arg_523_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_523_1.time_ - 0) / var_526_1)
			end

			if arg_523_1.time_ >= 0 + var_526_1 and arg_523_1.time_ < 0 + var_526_1 + arg_526_0 then
				arg_523_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_526_2 = arg_523_1.actors_["1070"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_2) and arg_523_1.var_.actorSpriteComps1070 == nil then
				arg_523_1.var_.actorSpriteComps1070 = var_526_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_3 = 0.0166666666666667

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_3 and not isNil(var_526_2) then
				if arg_523_1.var_.actorSpriteComps1070 then
					for iter_526_1, iter_526_2 in pairs(arg_523_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_526_2 then
							if arg_523_1.isInRecall_ then
								iter_526_2.color = Color.New(Mathf.Lerp(iter_526_2.color.r, arg_523_1.hightColor1.r, (arg_523_1.time_ - 0) / var_526_3), Mathf.Lerp(iter_526_2.color.g, arg_523_1.hightColor1.g, (arg_523_1.time_ - 0) / var_526_3), (Mathf.Lerp(iter_526_2.color.b, arg_523_1.hightColor1.b, (arg_523_1.time_ - 0) / var_526_3)))
							else
								local var_526_4 = Mathf.Lerp(iter_526_2.color.r, 1, (arg_523_1.time_ - 0) / var_526_3)

								iter_526_2.color = Color.New(var_526_4, var_526_4, var_526_4)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 0 + var_526_3 and arg_523_1.time_ < 0 + var_526_3 + arg_526_0 and not isNil(var_526_2) and arg_523_1.var_.actorSpriteComps1070 then
				for iter_526_3, iter_526_4 in pairs(arg_523_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_526_4 then
						iter_526_4.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_523_1.var_.actorSpriteComps1070 = nil
			end

			local var_526_5 = 0
			local var_526_6 = 0.125

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_5 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_7 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(910110129).content)

				arg_523_1.text_.text = var_526_7

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_9 = 5 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_7) / 5)

				if (5 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_7) / 5)) > 0 and var_526_6 < var_526_9 then
					arg_523_1.talkMaxDuration = var_526_9

					if var_526_9 + var_526_5 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_9 + var_526_5
					end
				end

				arg_523_1.text_.text = var_526_7
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_6, arg_523_1.talkMaxDuration)

			if var_526_5 <= arg_523_1.time_ and arg_523_1.time_ < var_526_5 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_5) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_5 + var_526_10 and arg_523_1.time_ < var_526_5 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play910110130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 910110130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play910110131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1070"]) and arg_527_1.var_.actorSpriteComps1070 == nil then
				arg_527_1.var_.actorSpriteComps1070 = arg_527_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_0 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1070"]) then
				if arg_527_1.var_.actorSpriteComps1070 then
					for iter_530_0, iter_530_1 in pairs(arg_527_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_530_1 then
							if arg_527_1.isInRecall_ then
								iter_530_1.color = Color.New(Mathf.Lerp(iter_530_1.color.r, arg_527_1.hightColor2.r, (arg_527_1.time_ - 0) / var_530_0), Mathf.Lerp(iter_530_1.color.g, arg_527_1.hightColor2.g, (arg_527_1.time_ - 0) / var_530_0), (Mathf.Lerp(iter_530_1.color.b, arg_527_1.hightColor2.b, (arg_527_1.time_ - 0) / var_530_0)))
							else
								local var_530_1 = Mathf.Lerp(iter_530_1.color.r, 0.5, (arg_527_1.time_ - 0) / var_530_0)

								iter_530_1.color = Color.New(var_530_1, var_530_1, var_530_1)
							end
						end
					end
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1070"]) and arg_527_1.var_.actorSpriteComps1070 then
				for iter_530_2, iter_530_3 in pairs(arg_527_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_530_3 then
						iter_530_3.color = arg_527_1.isInRecall_ and (arg_527_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_527_1.var_.actorSpriteComps1070 = nil
			end

			local var_530_2 = 0
			local var_530_3 = 0.4

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_4 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(910110130).content)

				arg_527_1.text_.text = var_530_4

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_6 = 16 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_4) / 16)

				if (16 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_4) / 16)) > 0 and var_530_3 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_4
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_3, arg_527_1.talkMaxDuration)

			if var_530_2 <= arg_527_1.time_ and arg_527_1.time_ < var_530_2 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_2) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_2 + var_530_7 and arg_527_1.time_ < var_530_2 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play910110131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 910110131
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play910110132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.275

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(910110131).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 11 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 11)

				if (11 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 11)) > 0 and var_534_0 < var_534_3 then
					arg_531_1.talkMaxDuration = var_534_3

					if var_534_3 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_3 + 0
					end
				end

				arg_531_1.text_.text = var_534_1
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_4 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_4

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play910110132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 910110132
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play910110133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1070 = arg_535_1.actors_["1070"].transform.localPosition
				arg_535_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_535_1:CheckSpriteTmpPos("1070", 3)

				for iter_538_0 = 0, arg_535_1.actors_["1070"].transform.childCount - 1 do
					local var_538_0 = arg_535_1.actors_["1070"].transform:GetChild(iter_538_0)

					if var_538_0.name == "split_1" or not string.find(var_538_0.name, "split") then
						var_538_0.gameObject:SetActive(true)
					else
						var_538_0.gameObject:SetActive(false)
					end
				end
			end

			local var_538_1 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_1 then
				arg_535_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_535_1.time_ - 0) / var_538_1)
			end

			if arg_535_1.time_ >= 0 + var_538_1 and arg_535_1.time_ < 0 + var_538_1 + arg_538_0 then
				arg_535_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_538_2 = arg_535_1.actors_["1070"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_2) and arg_535_1.var_.actorSpriteComps1070 == nil then
				arg_535_1.var_.actorSpriteComps1070 = var_538_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_3 = 0.0166666666666667

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_3 and not isNil(var_538_2) then
				if arg_535_1.var_.actorSpriteComps1070 then
					for iter_538_1, iter_538_2 in pairs(arg_535_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_538_2 then
							if arg_535_1.isInRecall_ then
								iter_538_2.color = Color.New(Mathf.Lerp(iter_538_2.color.r, arg_535_1.hightColor1.r, (arg_535_1.time_ - 0) / var_538_3), Mathf.Lerp(iter_538_2.color.g, arg_535_1.hightColor1.g, (arg_535_1.time_ - 0) / var_538_3), (Mathf.Lerp(iter_538_2.color.b, arg_535_1.hightColor1.b, (arg_535_1.time_ - 0) / var_538_3)))
							else
								local var_538_4 = Mathf.Lerp(iter_538_2.color.r, 1, (arg_535_1.time_ - 0) / var_538_3)

								iter_538_2.color = Color.New(var_538_4, var_538_4, var_538_4)
							end
						end
					end
				end
			end

			if arg_535_1.time_ >= 0 + var_538_3 and arg_535_1.time_ < 0 + var_538_3 + arg_538_0 and not isNil(var_538_2) and arg_535_1.var_.actorSpriteComps1070 then
				for iter_538_3, iter_538_4 in pairs(arg_535_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_538_4 then
						iter_538_4.color = arg_535_1.isInRecall_ and (arg_535_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_535_1.var_.actorSpriteComps1070 = nil
			end

			local var_538_5 = 0
			local var_538_6 = 0.3

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_5 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_7 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(910110132).content)

				arg_535_1.text_.text = var_538_7

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_9 = 12 <= 0 and var_538_6 or var_538_6 * (utf8.len(var_538_7) / 12)

				if (12 <= 0 and var_538_6 or var_538_6 * (utf8.len(var_538_7) / 12)) > 0 and var_538_6 < var_538_9 then
					arg_535_1.talkMaxDuration = var_538_9

					if var_538_9 + var_538_5 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_9 + var_538_5
					end
				end

				arg_535_1.text_.text = var_538_7
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_6, arg_535_1.talkMaxDuration)

			if var_538_5 <= arg_535_1.time_ and arg_535_1.time_ < var_538_5 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_5) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_5 + var_538_10 and arg_535_1.time_ < var_538_5 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play910110133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 910110133
		arg_539_1.duration_ = 7

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play910110134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if arg_539_1.bgs_.ST01a == nil then
				local var_542_0 = Object.Instantiate(arg_539_1.paintGo_)

				var_542_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a")
				var_542_0.name = "ST01a"
				var_542_0.transform.parent = arg_539_1.stage_.transform
				var_542_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_539_1.bgs_.ST01a = var_542_0
			end

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= 2 + arg_542_0 then
				local var_542_1 = arg_539_1.bgs_.ST01a

				arg_539_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_542_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_542_2 = var_542_1:GetComponent("SpriteRenderer")

				if var_542_2 and var_542_2.sprite then
					local var_542_3 = 2 * (var_542_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_542_1.transform.localScale = Vector3.New(var_542_3 / var_542_2.sprite.bounds.size.y < var_542_3 * manager.ui.mainCameraCom_.aspect / var_542_2.sprite.bounds.size.x and var_542_3 * manager.ui.mainCameraCom_.aspect / var_542_2.sprite.bounds.size.x or var_542_3 / var_542_2.sprite.bounds.size.y, var_542_3 / var_542_2.sprite.bounds.size.y < var_542_3 * manager.ui.mainCameraCom_.aspect / var_542_2.sprite.bounds.size.x and var_542_3 * manager.ui.mainCameraCom_.aspect / var_542_2.sprite.bounds.size.x or var_542_3 / var_542_2.sprite.bounds.size.y, 0)
				end

				for iter_542_0, iter_542_1 in pairs(arg_539_1.bgs_) do
					if iter_542_0 ~= "ST01a" then
						iter_542_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_542_4 = arg_539_1.actors_["1066"].transform

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= 2 + arg_542_0 then
				arg_539_1.var_.moveOldPos1066 = var_542_4.localPosition
				var_542_4.localScale = Vector3.New(1, 1, 1)

				arg_539_1:CheckSpriteTmpPos("1066", 3)

				for iter_542_2 = 0, var_542_4.childCount - 1 do
					local var_542_5 = var_542_4:GetChild(iter_542_2)

					if var_542_5.name == "split_1" or not string.find(var_542_5.name, "split") then
						var_542_5.gameObject:SetActive(true)
					else
						var_542_5.gameObject:SetActive(false)
					end
				end
			end

			local var_542_6 = 0.001

			if 2 <= arg_539_1.time_ and arg_539_1.time_ < 2 + var_542_6 then
				var_542_4.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1066, Vector3.New(0, -350, -180), (arg_539_1.time_ - 2) / var_542_6)
			end

			if arg_539_1.time_ >= 2 + var_542_6 and arg_539_1.time_ < 2 + var_542_6 + arg_542_0 then
				var_542_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_542_7 = 0

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_7 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_8 = 2

			if var_542_7 <= arg_539_1.time_ and arg_539_1.time_ < var_542_7 + var_542_8 then
				local var_542_9 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_9.a = Mathf.Lerp(0, 1, (arg_539_1.time_ - var_542_7) / var_542_8)
				arg_539_1.mask_.color = var_542_9
			end

			if arg_539_1.time_ >= var_542_7 + var_542_8 and arg_539_1.time_ < var_542_7 + var_542_8 + arg_542_0 then
				local var_542_10 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_10.a = 1
				arg_539_1.mask_.color = var_542_10
			end

			local var_542_11 = 2

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= var_542_11 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_12 = 2

			if var_542_11 <= arg_539_1.time_ and arg_539_1.time_ < var_542_11 + var_542_12 then
				local var_542_13 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_13.a = Mathf.Lerp(1, 0, (arg_539_1.time_ - var_542_11) / var_542_12)
				arg_539_1.mask_.color = var_542_13
			end

			if arg_539_1.time_ >= var_542_11 + var_542_12 and arg_539_1.time_ < var_542_11 + var_542_12 + arg_542_0 then
				local var_542_14 = Color.New(0.02830189, 0.0281684, 0.0281684)

				arg_539_1.mask_.enabled = false
				var_542_14.a = 0
				arg_539_1.mask_.color = var_542_14
			end

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= 2 + arg_542_0 then
				local var_542_15 = arg_539_1.actors_["1066"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_542_15 then
					arg_539_1.var_.alphaOldValue1066 = var_542_15.alpha
					arg_539_1.var_.characterEffect1066 = var_542_15
				end

				arg_539_1.var_.alphaOldValue1066 = 0
			end

			local var_542_16 = 1.1

			if 2 <= arg_539_1.time_ and arg_539_1.time_ < 2 + var_542_16 then
				if arg_539_1.var_.characterEffect1066 then
					arg_539_1.var_.characterEffect1066.alpha = Mathf.Lerp(arg_539_1.var_.alphaOldValue1066, 1, (arg_539_1.time_ - 2) / var_542_16)
				end
			end

			if arg_539_1.time_ >= 2 + var_542_16 and arg_539_1.time_ < 2 + var_542_16 + arg_542_0 and arg_539_1.var_.characterEffect1066 then
				arg_539_1.var_.characterEffect1066.alpha = 1
			end

			local var_542_17 = arg_539_1.actors_["1066"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_17) and arg_539_1.var_.actorSpriteComps1066 == nil then
				arg_539_1.var_.actorSpriteComps1066 = var_542_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_18 = 0.0166666666666667

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_18 and not isNil(var_542_17) then
				if arg_539_1.var_.actorSpriteComps1066 then
					for iter_542_3, iter_542_4 in pairs(arg_539_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_542_4 then
							if arg_539_1.isInRecall_ then
								iter_542_4.color = Color.New(Mathf.Lerp(iter_542_4.color.r, arg_539_1.hightColor1.r, (arg_539_1.time_ - 0) / var_542_18), Mathf.Lerp(iter_542_4.color.g, arg_539_1.hightColor1.g, (arg_539_1.time_ - 0) / var_542_18), (Mathf.Lerp(iter_542_4.color.b, arg_539_1.hightColor1.b, (arg_539_1.time_ - 0) / var_542_18)))
							else
								local var_542_19 = Mathf.Lerp(iter_542_4.color.r, 1, (arg_539_1.time_ - 0) / var_542_18)

								iter_542_4.color = Color.New(var_542_19, var_542_19, var_542_19)
							end
						end
					end
				end
			end

			if arg_539_1.time_ >= 0 + var_542_18 and arg_539_1.time_ < 0 + var_542_18 + arg_542_0 and not isNil(var_542_17) and arg_539_1.var_.actorSpriteComps1066 then
				for iter_542_5, iter_542_6 in pairs(arg_539_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_542_6 then
						iter_542_6.color = arg_539_1.isInRecall_ and (arg_539_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_539_1.var_.actorSpriteComps1066 = nil
			end

			local var_542_20 = 2
			local var_542_21 = 0.275

			if 2 < arg_539_1.time_ and arg_539_1.time_ <= var_542_20 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_22 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(910110133).content)

				arg_539_1.text_.text = var_542_22

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_24 = 11 <= 0 and var_542_21 or var_542_21 * (utf8.len(var_542_22) / 11)

				if (11 <= 0 and var_542_21 or var_542_21 * (utf8.len(var_542_22) / 11)) > 0 and var_542_21 < var_542_24 then
					arg_539_1.talkMaxDuration = var_542_24

					if var_542_24 + var_542_20 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_24 + var_542_20
					end
				end

				arg_539_1.text_.text = var_542_22
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_25 = math.max(var_542_21, arg_539_1.talkMaxDuration)

			if var_542_20 <= arg_539_1.time_ and arg_539_1.time_ < var_542_20 + var_542_25 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_20) / var_542_25

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_20 + var_542_25 and arg_539_1.time_ < var_542_20 + var_542_25 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play910110134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 910110134
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play910110135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1066"]) and arg_543_1.var_.actorSpriteComps1066 == nil then
				arg_543_1.var_.actorSpriteComps1066 = arg_543_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_0 = 0.2

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1066"]) then
				if arg_543_1.var_.actorSpriteComps1066 then
					for iter_546_0, iter_546_1 in pairs(arg_543_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_546_1 then
							if arg_543_1.isInRecall_ then
								iter_546_1.color = Color.New(Mathf.Lerp(iter_546_1.color.r, arg_543_1.hightColor2.r, (arg_543_1.time_ - 0) / var_546_0), Mathf.Lerp(iter_546_1.color.g, arg_543_1.hightColor2.g, (arg_543_1.time_ - 0) / var_546_0), (Mathf.Lerp(iter_546_1.color.b, arg_543_1.hightColor2.b, (arg_543_1.time_ - 0) / var_546_0)))
							else
								local var_546_1 = Mathf.Lerp(iter_546_1.color.r, 0.5, (arg_543_1.time_ - 0) / var_546_0)

								iter_546_1.color = Color.New(var_546_1, var_546_1, var_546_1)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1066"]) and arg_543_1.var_.actorSpriteComps1066 then
				for iter_546_2, iter_546_3 in pairs(arg_543_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_546_3 then
						iter_546_3.color = arg_543_1.isInRecall_ and (arg_543_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_543_1.var_.actorSpriteComps1066 = nil
			end

			local var_546_2 = 0
			local var_546_3 = 0.725

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_2 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_4 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(910110134).content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_6 = 29 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_4) / 29)

				if (29 <= 0 and var_546_3 or var_546_3 * (utf8.len(var_546_4) / 29)) > 0 and var_546_3 < var_546_6 then
					arg_543_1.talkMaxDuration = var_546_6

					if var_546_6 + var_546_2 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_6 + var_546_2
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_3, arg_543_1.talkMaxDuration)

			if var_546_2 <= arg_543_1.time_ and arg_543_1.time_ < var_546_2 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_2) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_2 + var_546_7 and arg_543_1.time_ < var_546_2 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play910110135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 910110135
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play910110136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.1

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_1 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(910110135).content)

				arg_547_1.text_.text = var_550_1

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_3 = 4 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 4)

				if (4 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_1) / 4)) > 0 and var_550_0 < var_550_3 then
					arg_547_1.talkMaxDuration = var_550_3

					if var_550_3 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_3 + 0
					end
				end

				arg_547_1.text_.text = var_550_1
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_4 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_4 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_4

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_4 and arg_547_1.time_ < 0 + var_550_4 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play910110136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 910110136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play910110137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.1

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(910110136).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 4 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 4)

				if (4 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 4)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play910110137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 910110137
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play910110138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1070 = arg_555_1.actors_["1070"].transform.localPosition
				arg_555_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("1070", 3)

				for iter_558_0 = 0, arg_555_1.actors_["1070"].transform.childCount - 1 do
					local var_558_0 = arg_555_1.actors_["1070"].transform:GetChild(iter_558_0)

					if var_558_0.name == "split_2" or not string.find(var_558_0.name, "split") then
						var_558_0.gameObject:SetActive(true)
					else
						var_558_0.gameObject:SetActive(false)
					end
				end
			end

			local var_558_1 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_1 then
				arg_555_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_555_1.time_ - 0) / var_558_1)
			end

			if arg_555_1.time_ >= 0 + var_558_1 and arg_555_1.time_ < 0 + var_558_1 + arg_558_0 then
				arg_555_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				local var_558_2 = arg_555_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_558_2 then
					arg_555_1.var_.alphaOldValue1070 = var_558_2.alpha
					arg_555_1.var_.characterEffect1070 = var_558_2
				end

				arg_555_1.var_.alphaOldValue1070 = 0
			end

			local var_558_3 = 0.5

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_3 then
				if arg_555_1.var_.characterEffect1070 then
					arg_555_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_555_1.var_.alphaOldValue1070, 1, (arg_555_1.time_ - 0) / var_558_3)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_3 and arg_555_1.time_ < 0 + var_558_3 + arg_558_0 and arg_555_1.var_.characterEffect1070 then
				arg_555_1.var_.characterEffect1070.alpha = 1
			end

			local var_558_4 = arg_555_1.actors_["1070"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_4) and arg_555_1.var_.actorSpriteComps1070 == nil then
				arg_555_1.var_.actorSpriteComps1070 = var_558_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_5 = 0.0166666666666667

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_5 and not isNil(var_558_4) then
				if arg_555_1.var_.actorSpriteComps1070 then
					for iter_558_1, iter_558_2 in pairs(arg_555_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_558_2 then
							if arg_555_1.isInRecall_ then
								iter_558_2.color = Color.New(Mathf.Lerp(iter_558_2.color.r, arg_555_1.hightColor1.r, (arg_555_1.time_ - 0) / var_558_5), Mathf.Lerp(iter_558_2.color.g, arg_555_1.hightColor1.g, (arg_555_1.time_ - 0) / var_558_5), (Mathf.Lerp(iter_558_2.color.b, arg_555_1.hightColor1.b, (arg_555_1.time_ - 0) / var_558_5)))
							else
								local var_558_6 = Mathf.Lerp(iter_558_2.color.r, 1, (arg_555_1.time_ - 0) / var_558_5)

								iter_558_2.color = Color.New(var_558_6, var_558_6, var_558_6)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= 0 + var_558_5 and arg_555_1.time_ < 0 + var_558_5 + arg_558_0 and not isNil(var_558_4) and arg_555_1.var_.actorSpriteComps1070 then
				for iter_558_3, iter_558_4 in pairs(arg_555_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_558_4 then
						iter_558_4.color = arg_555_1.isInRecall_ and (arg_555_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_555_1.var_.actorSpriteComps1070 = nil
			end

			local var_558_7 = 0
			local var_558_8 = 0.15

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_7 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_9 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(910110137).content)

				arg_555_1.text_.text = var_558_9

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_11 = 6 <= 0 and var_558_8 or var_558_8 * (utf8.len(var_558_9) / 6)

				if (6 <= 0 and var_558_8 or var_558_8 * (utf8.len(var_558_9) / 6)) > 0 and var_558_8 < var_558_11 then
					arg_555_1.talkMaxDuration = var_558_11

					if var_558_11 + var_558_7 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_11 + var_558_7
					end
				end

				arg_555_1.text_.text = var_558_9
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_12 = math.max(var_558_8, arg_555_1.talkMaxDuration)

			if var_558_7 <= arg_555_1.time_ and arg_555_1.time_ < var_558_7 + var_558_12 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_7) / var_558_12

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_7 + var_558_12 and arg_555_1.time_ < var_558_7 + var_558_12 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play910110138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 910110138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play910110139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["1070"]) and arg_559_1.var_.actorSpriteComps1070 == nil then
				arg_559_1.var_.actorSpriteComps1070 = arg_559_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_562_0 = 0.2

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["1070"]) then
				if arg_559_1.var_.actorSpriteComps1070 then
					for iter_562_0, iter_562_1 in pairs(arg_559_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_562_1 then
							if arg_559_1.isInRecall_ then
								iter_562_1.color = Color.New(Mathf.Lerp(iter_562_1.color.r, arg_559_1.hightColor2.r, (arg_559_1.time_ - 0) / var_562_0), Mathf.Lerp(iter_562_1.color.g, arg_559_1.hightColor2.g, (arg_559_1.time_ - 0) / var_562_0), (Mathf.Lerp(iter_562_1.color.b, arg_559_1.hightColor2.b, (arg_559_1.time_ - 0) / var_562_0)))
							else
								local var_562_1 = Mathf.Lerp(iter_562_1.color.r, 0.5, (arg_559_1.time_ - 0) / var_562_0)

								iter_562_1.color = Color.New(var_562_1, var_562_1, var_562_1)
							end
						end
					end
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["1070"]) and arg_559_1.var_.actorSpriteComps1070 then
				for iter_562_2, iter_562_3 in pairs(arg_559_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_562_3 then
						iter_562_3.color = arg_559_1.isInRecall_ and (arg_559_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_559_1.var_.actorSpriteComps1070 = nil
			end

			local var_562_2 = 0
			local var_562_3 = 0.4

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_2 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_4 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(910110138).content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_6 = 16 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_4) / 16)

				if (16 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_4) / 16)) > 0 and var_562_3 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_2
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_3, arg_559_1.talkMaxDuration)

			if var_562_2 <= arg_559_1.time_ and arg_559_1.time_ < var_562_2 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_2) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_2 + var_562_7 and arg_559_1.time_ < var_562_2 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play910110139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 910110139
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play910110140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["1070"]) and arg_563_1.var_.actorSpriteComps1070 == nil then
				arg_563_1.var_.actorSpriteComps1070 = arg_563_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_0 = 0.2

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["1070"]) then
				if arg_563_1.var_.actorSpriteComps1070 then
					for iter_566_0, iter_566_1 in pairs(arg_563_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_566_1 then
							if arg_563_1.isInRecall_ then
								iter_566_1.color = Color.New(Mathf.Lerp(iter_566_1.color.r, arg_563_1.hightColor1.r, (arg_563_1.time_ - 0) / var_566_0), Mathf.Lerp(iter_566_1.color.g, arg_563_1.hightColor1.g, (arg_563_1.time_ - 0) / var_566_0), (Mathf.Lerp(iter_566_1.color.b, arg_563_1.hightColor1.b, (arg_563_1.time_ - 0) / var_566_0)))
							else
								local var_566_1 = Mathf.Lerp(iter_566_1.color.r, 1, (arg_563_1.time_ - 0) / var_566_0)

								iter_566_1.color = Color.New(var_566_1, var_566_1, var_566_1)
							end
						end
					end
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["1070"]) and arg_563_1.var_.actorSpriteComps1070 then
				for iter_566_2, iter_566_3 in pairs(arg_563_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_566_3 then
						iter_566_3.color = arg_563_1.isInRecall_ and (arg_563_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_563_1.var_.actorSpriteComps1070 = nil
			end

			local var_566_2 = 0
			local var_566_3 = 0.65

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_2 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_4 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(910110139).content)

				arg_563_1.text_.text = var_566_4

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_6 = 26 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_4) / 26)

				if (26 <= 0 and var_566_3 or var_566_3 * (utf8.len(var_566_4) / 26)) > 0 and var_566_3 < var_566_6 then
					arg_563_1.talkMaxDuration = var_566_6

					if var_566_6 + var_566_2 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_2
					end
				end

				arg_563_1.text_.text = var_566_4
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_3, arg_563_1.talkMaxDuration)

			if var_566_2 <= arg_563_1.time_ and arg_563_1.time_ < var_566_2 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_2) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_2 + var_566_7 and arg_563_1.time_ < var_566_2 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play910110140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 910110140
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play910110141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1070"]) and arg_567_1.var_.actorSpriteComps1070 == nil then
				arg_567_1.var_.actorSpriteComps1070 = arg_567_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_0 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1070"]) then
				if arg_567_1.var_.actorSpriteComps1070 then
					for iter_570_0, iter_570_1 in pairs(arg_567_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_570_1 then
							if arg_567_1.isInRecall_ then
								iter_570_1.color = Color.New(Mathf.Lerp(iter_570_1.color.r, arg_567_1.hightColor2.r, (arg_567_1.time_ - 0) / var_570_0), Mathf.Lerp(iter_570_1.color.g, arg_567_1.hightColor2.g, (arg_567_1.time_ - 0) / var_570_0), (Mathf.Lerp(iter_570_1.color.b, arg_567_1.hightColor2.b, (arg_567_1.time_ - 0) / var_570_0)))
							else
								local var_570_1 = Mathf.Lerp(iter_570_1.color.r, 0.5, (arg_567_1.time_ - 0) / var_570_0)

								iter_570_1.color = Color.New(var_570_1, var_570_1, var_570_1)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1070"]) and arg_567_1.var_.actorSpriteComps1070 then
				for iter_570_2, iter_570_3 in pairs(arg_567_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_570_3 then
						iter_570_3.color = arg_567_1.isInRecall_ and (arg_567_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_567_1.var_.actorSpriteComps1070 = nil
			end

			local var_570_2 = 0
			local var_570_3 = 0.725

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_2 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_4 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(910110140).content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_6 = 29 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_4) / 29)

				if (29 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_4) / 29)) > 0 and var_570_3 < var_570_6 then
					arg_567_1.talkMaxDuration = var_570_6

					if var_570_6 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_6 + var_570_2
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_3, arg_567_1.talkMaxDuration)

			if var_570_2 <= arg_567_1.time_ and arg_567_1.time_ < var_570_2 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_2) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_2 + var_570_7 and arg_567_1.time_ < var_570_2 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play910110141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 910110141
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play910110142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.var_.moveOldPos1070 = arg_571_1.actors_["1070"].transform.localPosition
				arg_571_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_571_1:CheckSpriteTmpPos("1070", 3)

				for iter_574_0 = 0, arg_571_1.actors_["1070"].transform.childCount - 1 do
					local var_574_0 = arg_571_1.actors_["1070"].transform:GetChild(iter_574_0)

					if var_574_0.name == "split_1" or not string.find(var_574_0.name, "split") then
						var_574_0.gameObject:SetActive(true)
					else
						var_574_0.gameObject:SetActive(false)
					end
				end
			end

			local var_574_1 = 0.001

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_1 then
				arg_571_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_571_1.time_ - 0) / var_574_1)
			end

			if arg_571_1.time_ >= 0 + var_574_1 and arg_571_1.time_ < 0 + var_574_1 + arg_574_0 then
				arg_571_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_574_2 = 0
			local var_574_3 = 0.95

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(910110141).content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_6 = 38 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 38)

				if (38 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 38)) > 0 and var_574_3 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_7 and arg_571_1.time_ < var_574_2 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play910110142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 910110142
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play910110143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1066 = arg_575_1.actors_["1066"].transform.localPosition
				arg_575_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_575_1:CheckSpriteTmpPos("1066", 3)

				for iter_578_0 = 0, arg_575_1.actors_["1066"].transform.childCount - 1 do
					local var_578_0 = arg_575_1.actors_["1066"].transform:GetChild(iter_578_0)

					if var_578_0.name == "split_3" or not string.find(var_578_0.name, "split") then
						var_578_0.gameObject:SetActive(true)
					else
						var_578_0.gameObject:SetActive(false)
					end
				end
			end

			local var_578_1 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_1 then
				arg_575_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1066, Vector3.New(0, -350, -180), (arg_575_1.time_ - 0) / var_578_1)
			end

			if arg_575_1.time_ >= 0 + var_578_1 and arg_575_1.time_ < 0 + var_578_1 + arg_578_0 then
				arg_575_1.actors_["1066"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				local var_578_2 = arg_575_1.actors_["1066"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_578_2 then
					arg_575_1.var_.alphaOldValue1066 = var_578_2.alpha
					arg_575_1.var_.characterEffect1066 = var_578_2
				end

				arg_575_1.var_.alphaOldValue1066 = 0
			end

			local var_578_3 = 0.5

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_3 then
				if arg_575_1.var_.characterEffect1066 then
					arg_575_1.var_.characterEffect1066.alpha = Mathf.Lerp(arg_575_1.var_.alphaOldValue1066, 1, (arg_575_1.time_ - 0) / var_578_3)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_3 and arg_575_1.time_ < 0 + var_578_3 + arg_578_0 and arg_575_1.var_.characterEffect1066 then
				arg_575_1.var_.characterEffect1066.alpha = 1
			end

			local var_578_4 = 0
			local var_578_5 = 0.275

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_4 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_6 = arg_575_1:FormatText(arg_575_1:GetWordFromCfg(910110142).content)

				arg_575_1.text_.text = var_578_6

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_8 = 11 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_6) / 11)

				if (11 <= 0 and var_578_5 or var_578_5 * (utf8.len(var_578_6) / 11)) > 0 and var_578_5 < var_578_8 then
					arg_575_1.talkMaxDuration = var_578_8

					if var_578_8 + var_578_4 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_4
					end
				end

				arg_575_1.text_.text = var_578_6
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_9 = math.max(var_578_5, arg_575_1.talkMaxDuration)

			if var_578_4 <= arg_575_1.time_ and arg_575_1.time_ < var_578_4 + var_578_9 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_4) / var_578_9

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_4 + var_578_9 and arg_575_1.time_ < var_578_4 + var_578_9 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play910110143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 910110143
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play910110144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1066"]) and arg_579_1.var_.actorSpriteComps1066 == nil then
				arg_579_1.var_.actorSpriteComps1066 = arg_579_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_0 = 0.2

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1066"]) then
				if arg_579_1.var_.actorSpriteComps1066 then
					for iter_582_0, iter_582_1 in pairs(arg_579_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_582_1 then
							if arg_579_1.isInRecall_ then
								iter_582_1.color = Color.New(Mathf.Lerp(iter_582_1.color.r, arg_579_1.hightColor2.r, (arg_579_1.time_ - 0) / var_582_0), Mathf.Lerp(iter_582_1.color.g, arg_579_1.hightColor2.g, (arg_579_1.time_ - 0) / var_582_0), (Mathf.Lerp(iter_582_1.color.b, arg_579_1.hightColor2.b, (arg_579_1.time_ - 0) / var_582_0)))
							else
								local var_582_1 = Mathf.Lerp(iter_582_1.color.r, 0.5, (arg_579_1.time_ - 0) / var_582_0)

								iter_582_1.color = Color.New(var_582_1, var_582_1, var_582_1)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1066"]) and arg_579_1.var_.actorSpriteComps1066 then
				for iter_582_2, iter_582_3 in pairs(arg_579_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_582_3 then
						iter_582_3.color = arg_579_1.isInRecall_ and (arg_579_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_579_1.var_.actorSpriteComps1066 = nil
			end

			local var_582_2 = 0
			local var_582_3 = 0.3

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_4 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(910110143).content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_6 = 12 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_4) / 12)

				if (12 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_4) / 12)) > 0 and var_582_3 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_2
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_3, arg_579_1.talkMaxDuration)

			if var_582_2 <= arg_579_1.time_ and arg_579_1.time_ < var_582_2 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_2) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_2 + var_582_7 and arg_579_1.time_ < var_582_2 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play910110144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 910110144
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play910110145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos1070 = arg_583_1.actors_["1070"].transform.localPosition
				arg_583_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_583_1:CheckSpriteTmpPos("1070", 3)

				for iter_586_0 = 0, arg_583_1.actors_["1070"].transform.childCount - 1 do
					local var_586_0 = arg_583_1.actors_["1070"].transform:GetChild(iter_586_0)

					if var_586_0.name == "split_8" or not string.find(var_586_0.name, "split") then
						var_586_0.gameObject:SetActive(true)
					else
						var_586_0.gameObject:SetActive(false)
					end
				end
			end

			local var_586_1 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_1 then
				arg_583_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_583_1.time_ - 0) / var_586_1)
			end

			if arg_583_1.time_ >= 0 + var_586_1 and arg_583_1.time_ < 0 + var_586_1 + arg_586_0 then
				arg_583_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_586_2 = arg_583_1.actors_["1070"]

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(var_586_2) and arg_583_1.var_.actorSpriteComps1070 == nil then
				arg_583_1.var_.actorSpriteComps1070 = var_586_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_586_3 = 0.0166666666666667

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_3 and not isNil(var_586_2) then
				if arg_583_1.var_.actorSpriteComps1070 then
					for iter_586_1, iter_586_2 in pairs(arg_583_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_586_2 then
							if arg_583_1.isInRecall_ then
								iter_586_2.color = Color.New(Mathf.Lerp(iter_586_2.color.r, arg_583_1.hightColor1.r, (arg_583_1.time_ - 0) / var_586_3), Mathf.Lerp(iter_586_2.color.g, arg_583_1.hightColor1.g, (arg_583_1.time_ - 0) / var_586_3), (Mathf.Lerp(iter_586_2.color.b, arg_583_1.hightColor1.b, (arg_583_1.time_ - 0) / var_586_3)))
							else
								local var_586_4 = Mathf.Lerp(iter_586_2.color.r, 1, (arg_583_1.time_ - 0) / var_586_3)

								iter_586_2.color = Color.New(var_586_4, var_586_4, var_586_4)
							end
						end
					end
				end
			end

			if arg_583_1.time_ >= 0 + var_586_3 and arg_583_1.time_ < 0 + var_586_3 + arg_586_0 and not isNil(var_586_2) and arg_583_1.var_.actorSpriteComps1070 then
				for iter_586_3, iter_586_4 in pairs(arg_583_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_586_4 then
						iter_586_4.color = arg_583_1.isInRecall_ and (arg_583_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_583_1.var_.actorSpriteComps1070 = nil
			end

			local var_586_5 = 0
			local var_586_6 = 0.625

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_5 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_7 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(910110144).content)

				arg_583_1.text_.text = var_586_7

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_9 = 25 <= 0 and var_586_6 or var_586_6 * (utf8.len(var_586_7) / 25)

				if (25 <= 0 and var_586_6 or var_586_6 * (utf8.len(var_586_7) / 25)) > 0 and var_586_6 < var_586_9 then
					arg_583_1.talkMaxDuration = var_586_9

					if var_586_9 + var_586_5 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_9 + var_586_5
					end
				end

				arg_583_1.text_.text = var_586_7
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_6, arg_583_1.talkMaxDuration)

			if var_586_5 <= arg_583_1.time_ and arg_583_1.time_ < var_586_5 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_5) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_5 + var_586_10 and arg_583_1.time_ < var_586_5 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play910110145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 910110145
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play910110146(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1070"]) and arg_587_1.var_.actorSpriteComps1070 == nil then
				arg_587_1.var_.actorSpriteComps1070 = arg_587_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_0 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1070"]) then
				if arg_587_1.var_.actorSpriteComps1070 then
					for iter_590_0, iter_590_1 in pairs(arg_587_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_590_1 then
							if arg_587_1.isInRecall_ then
								iter_590_1.color = Color.New(Mathf.Lerp(iter_590_1.color.r, arg_587_1.hightColor2.r, (arg_587_1.time_ - 0) / var_590_0), Mathf.Lerp(iter_590_1.color.g, arg_587_1.hightColor2.g, (arg_587_1.time_ - 0) / var_590_0), (Mathf.Lerp(iter_590_1.color.b, arg_587_1.hightColor2.b, (arg_587_1.time_ - 0) / var_590_0)))
							else
								local var_590_1 = Mathf.Lerp(iter_590_1.color.r, 0.5, (arg_587_1.time_ - 0) / var_590_0)

								iter_590_1.color = Color.New(var_590_1, var_590_1, var_590_1)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1070"]) and arg_587_1.var_.actorSpriteComps1070 then
				for iter_590_2, iter_590_3 in pairs(arg_587_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_590_3 then
						iter_590_3.color = arg_587_1.isInRecall_ and (arg_587_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_587_1.var_.actorSpriteComps1070 = nil
			end

			local var_590_2 = 0
			local var_590_3 = 0.725

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_2 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_4 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(910110145).content)

				arg_587_1.text_.text = var_590_4

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_6 = 29 <= 0 and var_590_3 or var_590_3 * (utf8.len(var_590_4) / 29)

				if (29 <= 0 and var_590_3 or var_590_3 * (utf8.len(var_590_4) / 29)) > 0 and var_590_3 < var_590_6 then
					arg_587_1.talkMaxDuration = var_590_6

					if var_590_6 + var_590_2 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_6 + var_590_2
					end
				end

				arg_587_1.text_.text = var_590_4
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_7 = math.max(var_590_3, arg_587_1.talkMaxDuration)

			if var_590_2 <= arg_587_1.time_ and arg_587_1.time_ < var_590_2 + var_590_7 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_2) / var_590_7

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_2 + var_590_7 and arg_587_1.time_ < var_590_2 + var_590_7 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play910110146 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 910110146
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play910110147(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.var_.moveOldPos1070 = arg_591_1.actors_["1070"].transform.localPosition
				arg_591_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("1070", 3)

				for iter_594_0 = 0, arg_591_1.actors_["1070"].transform.childCount - 1 do
					local var_594_0 = arg_591_1.actors_["1070"].transform:GetChild(iter_594_0)

					if var_594_0.name == "split_6" or not string.find(var_594_0.name, "split") then
						var_594_0.gameObject:SetActive(true)
					else
						var_594_0.gameObject:SetActive(false)
					end
				end
			end

			local var_594_1 = 0.001

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_1 then
				arg_591_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_591_1.time_ - 0) / var_594_1)
			end

			if arg_591_1.time_ >= 0 + var_594_1 and arg_591_1.time_ < 0 + var_594_1 + arg_594_0 then
				arg_591_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_594_2 = arg_591_1.actors_["1070"]

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(var_594_2) and arg_591_1.var_.actorSpriteComps1070 == nil then
				arg_591_1.var_.actorSpriteComps1070 = var_594_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_594_3 = 0.0166666666666667

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_3 and not isNil(var_594_2) then
				if arg_591_1.var_.actorSpriteComps1070 then
					for iter_594_1, iter_594_2 in pairs(arg_591_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_594_2 then
							if arg_591_1.isInRecall_ then
								iter_594_2.color = Color.New(Mathf.Lerp(iter_594_2.color.r, arg_591_1.hightColor1.r, (arg_591_1.time_ - 0) / var_594_3), Mathf.Lerp(iter_594_2.color.g, arg_591_1.hightColor1.g, (arg_591_1.time_ - 0) / var_594_3), (Mathf.Lerp(iter_594_2.color.b, arg_591_1.hightColor1.b, (arg_591_1.time_ - 0) / var_594_3)))
							else
								local var_594_4 = Mathf.Lerp(iter_594_2.color.r, 1, (arg_591_1.time_ - 0) / var_594_3)

								iter_594_2.color = Color.New(var_594_4, var_594_4, var_594_4)
							end
						end
					end
				end
			end

			if arg_591_1.time_ >= 0 + var_594_3 and arg_591_1.time_ < 0 + var_594_3 + arg_594_0 and not isNil(var_594_2) and arg_591_1.var_.actorSpriteComps1070 then
				for iter_594_3, iter_594_4 in pairs(arg_591_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_594_4 then
						iter_594_4.color = arg_591_1.isInRecall_ and (arg_591_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_591_1.var_.actorSpriteComps1070 = nil
			end

			local var_594_5 = 0
			local var_594_6 = 0.225

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_5 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_7 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(910110146).content)

				arg_591_1.text_.text = var_594_7

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_9 = 9 <= 0 and var_594_6 or var_594_6 * (utf8.len(var_594_7) / 9)

				if (9 <= 0 and var_594_6 or var_594_6 * (utf8.len(var_594_7) / 9)) > 0 and var_594_6 < var_594_9 then
					arg_591_1.talkMaxDuration = var_594_9

					if var_594_9 + var_594_5 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_9 + var_594_5
					end
				end

				arg_591_1.text_.text = var_594_7
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_10 = math.max(var_594_6, arg_591_1.talkMaxDuration)

			if var_594_5 <= arg_591_1.time_ and arg_591_1.time_ < var_594_5 + var_594_10 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_5) / var_594_10

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_5 + var_594_10 and arg_591_1.time_ < var_594_5 + var_594_10 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_591_1:InitPlayNodeList()
	end,
	Play910110147 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 910110147
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play910110148(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 1.05

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(910110147).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 42 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 42)

				if (42 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 42)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play910110148 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 910110148
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play910110149(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos1070 = arg_599_1.actors_["1070"].transform.localPosition
				arg_599_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_599_1:CheckSpriteTmpPos("1070", 7)

				for iter_602_0 = 0, arg_599_1.actors_["1070"].transform.childCount - 1 do
					local var_602_0 = arg_599_1.actors_["1070"].transform:GetChild(iter_602_0)

					if var_602_0.name == "split_6" or not string.find(var_602_0.name, "split") then
						var_602_0.gameObject:SetActive(true)
					else
						var_602_0.gameObject:SetActive(false)
					end
				end
			end

			local var_602_1 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_1 then
				arg_599_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_599_1.time_ - 0) / var_602_1)
			end

			if arg_599_1.time_ >= 0 + var_602_1 and arg_599_1.time_ < 0 + var_602_1 + arg_602_0 then
				arg_599_1.actors_["1070"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				local var_602_2 = arg_599_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_602_2 then
					arg_599_1.var_.alphaOldValue1070 = var_602_2.alpha
					arg_599_1.var_.characterEffect1070 = var_602_2
				end

				arg_599_1.var_.alphaOldValue1070 = 1
			end

			local var_602_3 = 0.5

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_3 then
				if arg_599_1.var_.characterEffect1070 then
					arg_599_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_599_1.var_.alphaOldValue1070, 0, (arg_599_1.time_ - 0) / var_602_3)
				end
			end

			if arg_599_1.time_ >= 0 + var_602_3 and arg_599_1.time_ < 0 + var_602_3 + arg_602_0 and arg_599_1.var_.characterEffect1070 then
				arg_599_1.var_.characterEffect1070.alpha = 0
			end

			local var_602_4 = 0
			local var_602_5 = 0.225

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_6 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(910110148).content)

				arg_599_1.text_.text = var_602_6

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_8 = 9 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_6) / 9)

				if (9 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_6) / 9)) > 0 and var_602_5 < var_602_8 then
					arg_599_1.talkMaxDuration = var_602_8

					if var_602_8 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_4
					end
				end

				arg_599_1.text_.text = var_602_6
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_9 = math.max(var_602_5, arg_599_1.talkMaxDuration)

			if var_602_4 <= arg_599_1.time_ and arg_599_1.time_ < var_602_4 + var_602_9 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_4) / var_602_9

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_4 + var_602_9 and arg_599_1.time_ < var_602_4 + var_602_9 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play910110149 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 910110149
		arg_603_1.duration_ = 0.02

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				SetActive(iter_604_1.go, iter_604_0 <= 2)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[298].name)
			arg_603_1.choices_[2].txt.text = arg_603_1:FormatText(StoryChoiceCfg[299].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play910110150(arg_603_1)
			end

			if arg_605_0 == 2 then
				arg_603_0:Play910110150(arg_603_1)
			end

			arg_603_1:RecordChoiceLog(910110149, 298, 299)
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			return
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play910110150 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 910110150
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play910110151(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.35

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_1 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(910110150).content)

				arg_607_1.text_.text = var_610_1

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_3 = 14 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 14)

				if (14 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 14)) > 0 and var_610_0 < var_610_3 then
					arg_607_1.talkMaxDuration = var_610_3

					if var_610_3 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_3 + 0
					end
				end

				arg_607_1.text_.text = var_610_1
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_4 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_4 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_4

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_4 and arg_607_1.time_ < 0 + var_610_4 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play910110151 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 910110151
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play910110152(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 1.45

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_1 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(910110151).content)

				arg_611_1.text_.text = var_614_1

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_3 = 58 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_1) / 58)

				if (58 <= 0 and var_614_0 or var_614_0 * (utf8.len(var_614_1) / 58)) > 0 and var_614_0 < var_614_3 then
					arg_611_1.talkMaxDuration = var_614_3

					if var_614_3 + 0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_3 + 0
					end
				end

				arg_611_1.text_.text = var_614_1
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_4 = math.max(var_614_0, arg_611_1.talkMaxDuration)

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_4 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - 0) / var_614_4

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= 0 + var_614_4 and arg_611_1.time_ < 0 + var_614_4 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play910110152 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 910110152
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play910110153(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.875

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(910110152).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 35 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 35)

				if (35 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 35)) > 0 and var_618_0 < var_618_3 then
					arg_615_1.talkMaxDuration = var_618_3

					if var_618_3 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_3 + 0
					end
				end

				arg_615_1.text_.text = var_618_1
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_4 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_4

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play910110153 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 910110153
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play910110154(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0.075

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_1 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(910110153).content)

				arg_619_1.text_.text = var_622_1

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_3 = 3 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 3)

				if (3 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 3)) > 0 and var_622_0 < var_622_3 then
					arg_619_1.talkMaxDuration = var_622_3

					if var_622_3 + 0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_3 + 0
					end
				end

				arg_619_1.text_.text = var_622_1
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_4 = math.max(var_622_0, arg_619_1.talkMaxDuration)

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - 0) / var_622_4

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play910110154 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 910110154
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play910110155(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1070 = arg_623_1.actors_["1070"].transform.localPosition
				arg_623_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_623_1:CheckSpriteTmpPos("1070", 3)

				for iter_626_0 = 0, arg_623_1.actors_["1070"].transform.childCount - 1 do
					local var_626_0 = arg_623_1.actors_["1070"].transform:GetChild(iter_626_0)

					if var_626_0.name == "split_2" or not string.find(var_626_0.name, "split") then
						var_626_0.gameObject:SetActive(true)
					else
						var_626_0.gameObject:SetActive(false)
					end
				end
			end

			local var_626_1 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_1 then
				arg_623_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_623_1.time_ - 0) / var_626_1)
			end

			if arg_623_1.time_ >= 0 + var_626_1 and arg_623_1.time_ < 0 + var_626_1 + arg_626_0 then
				arg_623_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				local var_626_2 = arg_623_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_626_2 then
					arg_623_1.var_.alphaOldValue1070 = var_626_2.alpha
					arg_623_1.var_.characterEffect1070 = var_626_2
				end

				arg_623_1.var_.alphaOldValue1070 = 0
			end

			local var_626_3 = 0.5

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_3 then
				if arg_623_1.var_.characterEffect1070 then
					arg_623_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_623_1.var_.alphaOldValue1070, 1, (arg_623_1.time_ - 0) / var_626_3)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_3 and arg_623_1.time_ < 0 + var_626_3 + arg_626_0 and arg_623_1.var_.characterEffect1070 then
				arg_623_1.var_.characterEffect1070.alpha = 1
			end

			local var_626_4 = arg_623_1.actors_["1070"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_4) and arg_623_1.var_.actorSpriteComps1070 == nil then
				arg_623_1.var_.actorSpriteComps1070 = var_626_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_626_5 = 0.0166666666666667

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_5 and not isNil(var_626_4) then
				if arg_623_1.var_.actorSpriteComps1070 then
					for iter_626_1, iter_626_2 in pairs(arg_623_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_626_2 then
							if arg_623_1.isInRecall_ then
								iter_626_2.color = Color.New(Mathf.Lerp(iter_626_2.color.r, arg_623_1.hightColor1.r, (arg_623_1.time_ - 0) / var_626_5), Mathf.Lerp(iter_626_2.color.g, arg_623_1.hightColor1.g, (arg_623_1.time_ - 0) / var_626_5), (Mathf.Lerp(iter_626_2.color.b, arg_623_1.hightColor1.b, (arg_623_1.time_ - 0) / var_626_5)))
							else
								local var_626_6 = Mathf.Lerp(iter_626_2.color.r, 1, (arg_623_1.time_ - 0) / var_626_5)

								iter_626_2.color = Color.New(var_626_6, var_626_6, var_626_6)
							end
						end
					end
				end
			end

			if arg_623_1.time_ >= 0 + var_626_5 and arg_623_1.time_ < 0 + var_626_5 + arg_626_0 and not isNil(var_626_4) and arg_623_1.var_.actorSpriteComps1070 then
				for iter_626_3, iter_626_4 in pairs(arg_623_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_626_4 then
						iter_626_4.color = arg_623_1.isInRecall_ and (arg_623_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_623_1.var_.actorSpriteComps1070 = nil
			end

			local var_626_7 = 0
			local var_626_8 = 0.075

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_7 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_9 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(910110154).content)

				arg_623_1.text_.text = var_626_9

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_11 = 3 <= 0 and var_626_8 or var_626_8 * (utf8.len(var_626_9) / 3)

				if (3 <= 0 and var_626_8 or var_626_8 * (utf8.len(var_626_9) / 3)) > 0 and var_626_8 < var_626_11 then
					arg_623_1.talkMaxDuration = var_626_11

					if var_626_11 + var_626_7 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_11 + var_626_7
					end
				end

				arg_623_1.text_.text = var_626_9
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_12 = math.max(var_626_8, arg_623_1.talkMaxDuration)

			if var_626_7 <= arg_623_1.time_ and arg_623_1.time_ < var_626_7 + var_626_12 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_7) / var_626_12

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_7 + var_626_12 and arg_623_1.time_ < var_626_7 + var_626_12 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play910110155 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 910110155
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play910110156(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1070"]) and arg_627_1.var_.actorSpriteComps1070 == nil then
				arg_627_1.var_.actorSpriteComps1070 = arg_627_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1070"]) then
				if arg_627_1.var_.actorSpriteComps1070 then
					for iter_630_0, iter_630_1 in pairs(arg_627_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_630_1 then
							if arg_627_1.isInRecall_ then
								iter_630_1.color = Color.New(Mathf.Lerp(iter_630_1.color.r, arg_627_1.hightColor2.r, (arg_627_1.time_ - 0) / var_630_0), Mathf.Lerp(iter_630_1.color.g, arg_627_1.hightColor2.g, (arg_627_1.time_ - 0) / var_630_0), (Mathf.Lerp(iter_630_1.color.b, arg_627_1.hightColor2.b, (arg_627_1.time_ - 0) / var_630_0)))
							else
								local var_630_1 = Mathf.Lerp(iter_630_1.color.r, 0.5, (arg_627_1.time_ - 0) / var_630_0)

								iter_630_1.color = Color.New(var_630_1, var_630_1, var_630_1)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1070"]) and arg_627_1.var_.actorSpriteComps1070 then
				for iter_630_2, iter_630_3 in pairs(arg_627_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_630_3 then
						iter_630_3.color = arg_627_1.isInRecall_ and (arg_627_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_627_1.var_.actorSpriteComps1070 = nil
			end

			local var_630_2 = 0
			local var_630_3 = 0.2

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_2 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_4 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(910110155).content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_6 = 8 <= 0 and var_630_3 or var_630_3 * (utf8.len(var_630_4) / 8)

				if (8 <= 0 and var_630_3 or var_630_3 * (utf8.len(var_630_4) / 8)) > 0 and var_630_3 < var_630_6 then
					arg_627_1.talkMaxDuration = var_630_6

					if var_630_6 + var_630_2 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_6 + var_630_2
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_7 = math.max(var_630_3, arg_627_1.talkMaxDuration)

			if var_630_2 <= arg_627_1.time_ and arg_627_1.time_ < var_630_2 + var_630_7 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_2) / var_630_7

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_2 + var_630_7 and arg_627_1.time_ < var_630_2 + var_630_7 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play910110156 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 910110156
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play910110157(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1070"]) and arg_631_1.var_.actorSpriteComps1070 == nil then
				arg_631_1.var_.actorSpriteComps1070 = arg_631_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_634_0 = 0.2

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1070"]) then
				if arg_631_1.var_.actorSpriteComps1070 then
					for iter_634_0, iter_634_1 in pairs(arg_631_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_634_1 then
							if arg_631_1.isInRecall_ then
								iter_634_1.color = Color.New(Mathf.Lerp(iter_634_1.color.r, arg_631_1.hightColor1.r, (arg_631_1.time_ - 0) / var_634_0), Mathf.Lerp(iter_634_1.color.g, arg_631_1.hightColor1.g, (arg_631_1.time_ - 0) / var_634_0), (Mathf.Lerp(iter_634_1.color.b, arg_631_1.hightColor1.b, (arg_631_1.time_ - 0) / var_634_0)))
							else
								local var_634_1 = Mathf.Lerp(iter_634_1.color.r, 1, (arg_631_1.time_ - 0) / var_634_0)

								iter_634_1.color = Color.New(var_634_1, var_634_1, var_634_1)
							end
						end
					end
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1070"]) and arg_631_1.var_.actorSpriteComps1070 then
				for iter_634_2, iter_634_3 in pairs(arg_631_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_634_3 then
						iter_634_3.color = arg_631_1.isInRecall_ and (arg_631_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_631_1.var_.actorSpriteComps1070 = nil
			end

			local var_634_2 = 0
			local var_634_3 = 1.45

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_2 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_4 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(910110156).content)

				arg_631_1.text_.text = var_634_4

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_6 = 58 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_4) / 58)

				if (58 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_4) / 58)) > 0 and var_634_3 < var_634_6 then
					arg_631_1.talkMaxDuration = var_634_6

					if var_634_6 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_6 + var_634_2
					end
				end

				arg_631_1.text_.text = var_634_4
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_3, arg_631_1.talkMaxDuration)

			if var_634_2 <= arg_631_1.time_ and arg_631_1.time_ < var_634_2 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_2) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_2 + var_634_7 and arg_631_1.time_ < var_634_2 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play910110157 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 910110157
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play910110158(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["1070"]) and arg_635_1.var_.actorSpriteComps1070 == nil then
				arg_635_1.var_.actorSpriteComps1070 = arg_635_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_638_0 = 0.2

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["1070"]) then
				if arg_635_1.var_.actorSpriteComps1070 then
					for iter_638_0, iter_638_1 in pairs(arg_635_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_638_1 then
							if arg_635_1.isInRecall_ then
								iter_638_1.color = Color.New(Mathf.Lerp(iter_638_1.color.r, arg_635_1.hightColor2.r, (arg_635_1.time_ - 0) / var_638_0), Mathf.Lerp(iter_638_1.color.g, arg_635_1.hightColor2.g, (arg_635_1.time_ - 0) / var_638_0), (Mathf.Lerp(iter_638_1.color.b, arg_635_1.hightColor2.b, (arg_635_1.time_ - 0) / var_638_0)))
							else
								local var_638_1 = Mathf.Lerp(iter_638_1.color.r, 0.5, (arg_635_1.time_ - 0) / var_638_0)

								iter_638_1.color = Color.New(var_638_1, var_638_1, var_638_1)
							end
						end
					end
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["1070"]) and arg_635_1.var_.actorSpriteComps1070 then
				for iter_638_2, iter_638_3 in pairs(arg_635_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_638_3 then
						iter_638_3.color = arg_635_1.isInRecall_ and (arg_635_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_635_1.var_.actorSpriteComps1070 = nil
			end

			local var_638_2 = 0
			local var_638_3 = 0.25

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_2 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_4 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(910110157).content)

				arg_635_1.text_.text = var_638_4

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_6 = 10 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_4) / 10)

				if (10 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_4) / 10)) > 0 and var_638_3 < var_638_6 then
					arg_635_1.talkMaxDuration = var_638_6

					if var_638_6 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_6 + var_638_2
					end
				end

				arg_635_1.text_.text = var_638_4
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_3, arg_635_1.talkMaxDuration)

			if var_638_2 <= arg_635_1.time_ and arg_635_1.time_ < var_638_2 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_2) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_2 + var_638_7 and arg_635_1.time_ < var_638_2 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play910110158 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 910110158
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play910110159(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0.475

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_1 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(910110158).content)

				arg_639_1.text_.text = var_642_1

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_3 = 19 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 19)

				if (19 <= 0 and var_642_0 or var_642_0 * (utf8.len(var_642_1) / 19)) > 0 and var_642_0 < var_642_3 then
					arg_639_1.talkMaxDuration = var_642_3

					if var_642_3 + 0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_3 + 0
					end
				end

				arg_639_1.text_.text = var_642_1
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_4 = math.max(var_642_0, arg_639_1.talkMaxDuration)

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_4 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - 0) / var_642_4

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= 0 + var_642_4 and arg_639_1.time_ < 0 + var_642_4 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play910110159 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 910110159
		arg_643_1.duration_ = 7

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play910110160(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if arg_643_1.bgs_.ST05 == nil then
				local var_646_0 = Object.Instantiate(arg_643_1.paintGo_)

				var_646_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05")
				var_646_0.name = "ST05"
				var_646_0.transform.parent = arg_643_1.stage_.transform
				var_646_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_643_1.bgs_.ST05 = var_646_0
			end

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= 2 + arg_646_0 then
				local var_646_1 = arg_643_1.bgs_.ST05

				arg_643_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_646_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_2 = var_646_1:GetComponent("SpriteRenderer")

				if var_646_2 and var_646_2.sprite then
					local var_646_3 = 2 * (var_646_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_646_1.transform.localScale = Vector3.New(var_646_3 / var_646_2.sprite.bounds.size.y < var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x and var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x or var_646_3 / var_646_2.sprite.bounds.size.y, var_646_3 / var_646_2.sprite.bounds.size.y < var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x and var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x or var_646_3 / var_646_2.sprite.bounds.size.y, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "ST05" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_4 = arg_643_1.actors_["1070"].transform

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= 2 + arg_646_0 then
				arg_643_1.var_.moveOldPos1070 = var_646_4.localPosition
				var_646_4.localScale = Vector3.New(1, 1, 1)

				arg_643_1:CheckSpriteTmpPos("1070", 7)

				for iter_646_2 = 0, var_646_4.childCount - 1 do
					local var_646_5 = var_646_4:GetChild(iter_646_2)

					if var_646_5.name == "split_2" or not string.find(var_646_5.name, "split") then
						var_646_5.gameObject:SetActive(true)
					else
						var_646_5.gameObject:SetActive(false)
					end
				end
			end

			local var_646_6 = 0.001

			if 2 <= arg_643_1.time_ and arg_643_1.time_ < 2 + var_646_6 then
				var_646_4.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_643_1.time_ - 2) / var_646_6)
			end

			if arg_643_1.time_ >= 2 + var_646_6 and arg_643_1.time_ < 2 + var_646_6 + arg_646_0 then
				var_646_4.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_646_7 = 0

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_7 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_8 = 2

			if var_646_7 <= arg_643_1.time_ and arg_643_1.time_ < var_646_7 + var_646_8 then
				local var_646_9 = Color.New(0, 0, 0)

				var_646_9.a = Mathf.Lerp(0, 1, (arg_643_1.time_ - var_646_7) / var_646_8)
				arg_643_1.mask_.color = var_646_9
			end

			if arg_643_1.time_ >= var_646_7 + var_646_8 and arg_643_1.time_ < var_646_7 + var_646_8 + arg_646_0 then
				local var_646_10 = Color.New(0, 0, 0)

				var_646_10.a = 1
				arg_643_1.mask_.color = var_646_10
			end

			local var_646_11 = 2

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_11 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_12 = 2

			if var_646_11 <= arg_643_1.time_ and arg_643_1.time_ < var_646_11 + var_646_12 then
				local var_646_13 = Color.New(0, 0, 0)

				var_646_13.a = Mathf.Lerp(1, 0, (arg_643_1.time_ - var_646_11) / var_646_12)
				arg_643_1.mask_.color = var_646_13
			end

			if arg_643_1.time_ >= var_646_11 + var_646_12 and arg_643_1.time_ < var_646_11 + var_646_12 + arg_646_0 then
				local var_646_14 = Color.New(0, 0, 0)

				arg_643_1.mask_.enabled = false
				var_646_14.a = 0
				arg_643_1.mask_.color = var_646_14
			end

			local var_646_15 = 2
			local var_646_16 = 1.225

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_15 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_17 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(910110159).content)

				arg_643_1.text_.text = var_646_17

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_19 = 49 <= 0 and var_646_16 or var_646_16 * (utf8.len(var_646_17) / 49)

				if (49 <= 0 and var_646_16 or var_646_16 * (utf8.len(var_646_17) / 49)) > 0 and var_646_16 < var_646_19 then
					arg_643_1.talkMaxDuration = var_646_19

					if var_646_19 + var_646_15 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_19 + var_646_15
					end
				end

				arg_643_1.text_.text = var_646_17
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_20 = math.max(var_646_16, arg_643_1.talkMaxDuration)

			if var_646_15 <= arg_643_1.time_ and arg_643_1.time_ < var_646_15 + var_646_20 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_15) / var_646_20

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_15 + var_646_20 and arg_643_1.time_ < var_646_15 + var_646_20 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play910110160 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 910110160
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play910110161(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 1.225

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:FormatText(arg_647_1:GetWordFromCfg(910110160).content)

				arg_647_1.text_.text = var_650_1

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_3 = 49 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 49)

				if (49 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 49)) > 0 and var_650_0 < var_650_3 then
					arg_647_1.talkMaxDuration = var_650_3

					if var_650_3 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_3 + 0
					end
				end

				arg_647_1.text_.text = var_650_1
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_4 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_4 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_4

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_4 and arg_647_1.time_ < 0 + var_650_4 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play910110161 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 910110161
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play910110162(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.var_.moveOldPos1070 = arg_651_1.actors_["1070"].transform.localPosition
				arg_651_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_651_1:CheckSpriteTmpPos("1070", 3)

				for iter_654_0 = 0, arg_651_1.actors_["1070"].transform.childCount - 1 do
					local var_654_0 = arg_651_1.actors_["1070"].transform:GetChild(iter_654_0)

					if var_654_0.name == "split_1" or not string.find(var_654_0.name, "split") then
						var_654_0.gameObject:SetActive(true)
					else
						var_654_0.gameObject:SetActive(false)
					end
				end
			end

			local var_654_1 = 0.001

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_1 then
				arg_651_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_651_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_651_1.time_ - 0) / var_654_1)
			end

			if arg_651_1.time_ >= 0 + var_654_1 and arg_651_1.time_ < 0 + var_654_1 + arg_654_0 then
				arg_651_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_654_2 = arg_651_1.actors_["1070"]

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(var_654_2) and arg_651_1.var_.actorSpriteComps1070 == nil then
				arg_651_1.var_.actorSpriteComps1070 = var_654_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_654_3 = 0.0166666666666667

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_3 and not isNil(var_654_2) then
				if arg_651_1.var_.actorSpriteComps1070 then
					for iter_654_1, iter_654_2 in pairs(arg_651_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_654_2 then
							if arg_651_1.isInRecall_ then
								iter_654_2.color = Color.New(Mathf.Lerp(iter_654_2.color.r, arg_651_1.hightColor1.r, (arg_651_1.time_ - 0) / var_654_3), Mathf.Lerp(iter_654_2.color.g, arg_651_1.hightColor1.g, (arg_651_1.time_ - 0) / var_654_3), (Mathf.Lerp(iter_654_2.color.b, arg_651_1.hightColor1.b, (arg_651_1.time_ - 0) / var_654_3)))
							else
								local var_654_4 = Mathf.Lerp(iter_654_2.color.r, 1, (arg_651_1.time_ - 0) / var_654_3)

								iter_654_2.color = Color.New(var_654_4, var_654_4, var_654_4)
							end
						end
					end
				end
			end

			if arg_651_1.time_ >= 0 + var_654_3 and arg_651_1.time_ < 0 + var_654_3 + arg_654_0 and not isNil(var_654_2) and arg_651_1.var_.actorSpriteComps1070 then
				for iter_654_3, iter_654_4 in pairs(arg_651_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_654_4 then
						iter_654_4.color = arg_651_1.isInRecall_ and (arg_651_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_651_1.var_.actorSpriteComps1070 = nil
			end

			local var_654_5 = 0
			local var_654_6 = 0.575

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_5 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_7 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(910110161).content)

				arg_651_1.text_.text = var_654_7

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_9 = 23 <= 0 and var_654_6 or var_654_6 * (utf8.len(var_654_7) / 23)

				if (23 <= 0 and var_654_6 or var_654_6 * (utf8.len(var_654_7) / 23)) > 0 and var_654_6 < var_654_9 then
					arg_651_1.talkMaxDuration = var_654_9

					if var_654_9 + var_654_5 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_9 + var_654_5
					end
				end

				arg_651_1.text_.text = var_654_7
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_10 = math.max(var_654_6, arg_651_1.talkMaxDuration)

			if var_654_5 <= arg_651_1.time_ and arg_651_1.time_ < var_654_5 + var_654_10 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_5) / var_654_10

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_5 + var_654_10 and arg_651_1.time_ < var_654_5 + var_654_10 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_651_1:InitPlayNodeList()
	end,
	Play910110162 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 910110162
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play910110163(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["1070"]) and arg_655_1.var_.actorSpriteComps1070 == nil then
				arg_655_1.var_.actorSpriteComps1070 = arg_655_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_0 = 0.2

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["1070"]) then
				if arg_655_1.var_.actorSpriteComps1070 then
					for iter_658_0, iter_658_1 in pairs(arg_655_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_658_1 then
							if arg_655_1.isInRecall_ then
								iter_658_1.color = Color.New(Mathf.Lerp(iter_658_1.color.r, arg_655_1.hightColor2.r, (arg_655_1.time_ - 0) / var_658_0), Mathf.Lerp(iter_658_1.color.g, arg_655_1.hightColor2.g, (arg_655_1.time_ - 0) / var_658_0), (Mathf.Lerp(iter_658_1.color.b, arg_655_1.hightColor2.b, (arg_655_1.time_ - 0) / var_658_0)))
							else
								local var_658_1 = Mathf.Lerp(iter_658_1.color.r, 0.5, (arg_655_1.time_ - 0) / var_658_0)

								iter_658_1.color = Color.New(var_658_1, var_658_1, var_658_1)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["1070"]) and arg_655_1.var_.actorSpriteComps1070 then
				for iter_658_2, iter_658_3 in pairs(arg_655_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_658_3 then
						iter_658_3.color = arg_655_1.isInRecall_ and (arg_655_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_655_1.var_.actorSpriteComps1070 = nil
			end

			local var_658_2 = 0
			local var_658_3 = 0.225

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_2 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_4 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(910110162).content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_6 = 9 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_4) / 9)

				if (9 <= 0 and var_658_3 or var_658_3 * (utf8.len(var_658_4) / 9)) > 0 and var_658_3 < var_658_6 then
					arg_655_1.talkMaxDuration = var_658_6

					if var_658_6 + var_658_2 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_6 + var_658_2
					end
				end

				arg_655_1.text_.text = var_658_4
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_7 = math.max(var_658_3, arg_655_1.talkMaxDuration)

			if var_658_2 <= arg_655_1.time_ and arg_655_1.time_ < var_658_2 + var_658_7 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_2) / var_658_7

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_2 + var_658_7 and arg_655_1.time_ < var_658_2 + var_658_7 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play910110163 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 910110163
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play910110164(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0.3

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_1 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(910110163).content)

				arg_659_1.text_.text = var_662_1

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_3 = 12 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 12)

				if (12 <= 0 and var_662_0 or var_662_0 * (utf8.len(var_662_1) / 12)) > 0 and var_662_0 < var_662_3 then
					arg_659_1.talkMaxDuration = var_662_3

					if var_662_3 + 0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_3 + 0
					end
				end

				arg_659_1.text_.text = var_662_1
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_4 = math.max(var_662_0, arg_659_1.talkMaxDuration)

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_4 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - 0) / var_662_4

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= 0 + var_662_4 and arg_659_1.time_ < 0 + var_662_4 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play910110164 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 910110164
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play910110165(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0.65

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_1 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(910110164).content)

				arg_663_1.text_.text = var_666_1

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_3 = 26 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_1) / 26)

				if (26 <= 0 and var_666_0 or var_666_0 * (utf8.len(var_666_1) / 26)) > 0 and var_666_0 < var_666_3 then
					arg_663_1.talkMaxDuration = var_666_3

					if var_666_3 + 0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_3 + 0
					end
				end

				arg_663_1.text_.text = var_666_1
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_4 = math.max(var_666_0, arg_663_1.talkMaxDuration)

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_4 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - 0) / var_666_4

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= 0 + var_666_4 and arg_663_1.time_ < 0 + var_666_4 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play910110165 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 910110165
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play910110166(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 and not isNil(arg_667_1.actors_["1070"]) and arg_667_1.var_.actorSpriteComps1070 == nil then
				arg_667_1.var_.actorSpriteComps1070 = arg_667_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_670_0 = 0.2

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_0 and not isNil(arg_667_1.actors_["1070"]) then
				if arg_667_1.var_.actorSpriteComps1070 then
					for iter_670_0, iter_670_1 in pairs(arg_667_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_670_1 then
							if arg_667_1.isInRecall_ then
								iter_670_1.color = Color.New(Mathf.Lerp(iter_670_1.color.r, arg_667_1.hightColor1.r, (arg_667_1.time_ - 0) / var_670_0), Mathf.Lerp(iter_670_1.color.g, arg_667_1.hightColor1.g, (arg_667_1.time_ - 0) / var_670_0), (Mathf.Lerp(iter_670_1.color.b, arg_667_1.hightColor1.b, (arg_667_1.time_ - 0) / var_670_0)))
							else
								local var_670_1 = Mathf.Lerp(iter_670_1.color.r, 1, (arg_667_1.time_ - 0) / var_670_0)

								iter_670_1.color = Color.New(var_670_1, var_670_1, var_670_1)
							end
						end
					end
				end
			end

			if arg_667_1.time_ >= 0 + var_670_0 and arg_667_1.time_ < 0 + var_670_0 + arg_670_0 and not isNil(arg_667_1.actors_["1070"]) and arg_667_1.var_.actorSpriteComps1070 then
				for iter_670_2, iter_670_3 in pairs(arg_667_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_670_3 then
						iter_670_3.color = arg_667_1.isInRecall_ and (arg_667_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_667_1.var_.actorSpriteComps1070 = nil
			end

			local var_670_2 = 0
			local var_670_3 = 0.175

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_2 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_4 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(910110165).content)

				arg_667_1.text_.text = var_670_4

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_6 = 7 <= 0 and var_670_3 or var_670_3 * (utf8.len(var_670_4) / 7)

				if (7 <= 0 and var_670_3 or var_670_3 * (utf8.len(var_670_4) / 7)) > 0 and var_670_3 < var_670_6 then
					arg_667_1.talkMaxDuration = var_670_6

					if var_670_6 + var_670_2 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_6 + var_670_2
					end
				end

				arg_667_1.text_.text = var_670_4
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_7 = math.max(var_670_3, arg_667_1.talkMaxDuration)

			if var_670_2 <= arg_667_1.time_ and arg_667_1.time_ < var_670_2 + var_670_7 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_2) / var_670_7

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_2 + var_670_7 and arg_667_1.time_ < var_670_2 + var_670_7 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play910110166 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 910110166
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play910110167(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0.6

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_1 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(910110166).content)

				arg_671_1.text_.text = var_674_1

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_3 = 24 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 24)

				if (24 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 24)) > 0 and var_674_0 < var_674_3 then
					arg_671_1.talkMaxDuration = var_674_3

					if var_674_3 + 0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_3 + 0
					end
				end

				arg_671_1.text_.text = var_674_1
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_4 = math.max(var_674_0, arg_671_1.talkMaxDuration)

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_4 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - 0) / var_674_4

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= 0 + var_674_4 and arg_671_1.time_ < 0 + var_674_4 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play910110167 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 910110167
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play910110168(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(arg_675_1.actors_["1070"]) and arg_675_1.var_.actorSpriteComps1070 == nil then
				arg_675_1.var_.actorSpriteComps1070 = arg_675_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_678_0 = 0.2

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 and not isNil(arg_675_1.actors_["1070"]) then
				if arg_675_1.var_.actorSpriteComps1070 then
					for iter_678_0, iter_678_1 in pairs(arg_675_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_678_1 then
							if arg_675_1.isInRecall_ then
								iter_678_1.color = Color.New(Mathf.Lerp(iter_678_1.color.r, arg_675_1.hightColor2.r, (arg_675_1.time_ - 0) / var_678_0), Mathf.Lerp(iter_678_1.color.g, arg_675_1.hightColor2.g, (arg_675_1.time_ - 0) / var_678_0), (Mathf.Lerp(iter_678_1.color.b, arg_675_1.hightColor2.b, (arg_675_1.time_ - 0) / var_678_0)))
							else
								local var_678_1 = Mathf.Lerp(iter_678_1.color.r, 0.5, (arg_675_1.time_ - 0) / var_678_0)

								iter_678_1.color = Color.New(var_678_1, var_678_1, var_678_1)
							end
						end
					end
				end
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 and not isNil(arg_675_1.actors_["1070"]) and arg_675_1.var_.actorSpriteComps1070 then
				for iter_678_2, iter_678_3 in pairs(arg_675_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_678_3 then
						iter_678_3.color = arg_675_1.isInRecall_ and (arg_675_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_675_1.var_.actorSpriteComps1070 = nil
			end

			local var_678_2 = 0
			local var_678_3 = 0.575

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_2 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, true)
				arg_675_1.iconController_:SetSelectedState("hero")

				arg_675_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_675_1.callingController_:SetSelectedState("normal")

				arg_675_1.keyicon_.color = Color.New(1, 1, 1)
				arg_675_1.icon_.color = Color.New(1, 1, 1)

				local var_678_4 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(910110167).content)

				arg_675_1.text_.text = var_678_4

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_6 = 23 <= 0 and var_678_3 or var_678_3 * (utf8.len(var_678_4) / 23)

				if (23 <= 0 and var_678_3 or var_678_3 * (utf8.len(var_678_4) / 23)) > 0 and var_678_3 < var_678_6 then
					arg_675_1.talkMaxDuration = var_678_6

					if var_678_6 + var_678_2 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_6 + var_678_2
					end
				end

				arg_675_1.text_.text = var_678_4
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_7 = math.max(var_678_3, arg_675_1.talkMaxDuration)

			if var_678_2 <= arg_675_1.time_ and arg_675_1.time_ < var_678_2 + var_678_7 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_2) / var_678_7

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_2 + var_678_7 and arg_675_1.time_ < var_678_2 + var_678_7 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play910110168 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 910110168
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play910110169(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0.15

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_679_1.callingController_:SetSelectedState("normal")

				arg_679_1.keyicon_.color = Color.New(1, 1, 1)
				arg_679_1.icon_.color = Color.New(1, 1, 1)

				local var_682_1 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(910110168).content)

				arg_679_1.text_.text = var_682_1

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_3 = 6 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 6)

				if (6 <= 0 and var_682_0 or var_682_0 * (utf8.len(var_682_1) / 6)) > 0 and var_682_0 < var_682_3 then
					arg_679_1.talkMaxDuration = var_682_3

					if var_682_3 + 0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_3 + 0
					end
				end

				arg_679_1.text_.text = var_682_1
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_4 = math.max(var_682_0, arg_679_1.talkMaxDuration)

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_4 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - 0) / var_682_4

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= 0 + var_682_4 and arg_679_1.time_ < 0 + var_682_4 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play910110169 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 910110169
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play910110170(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.575

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_1 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(910110169).content)

				arg_683_1.text_.text = var_686_1

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_3 = 23 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 23)

				if (23 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 23)) > 0 and var_686_0 < var_686_3 then
					arg_683_1.talkMaxDuration = var_686_3

					if var_686_3 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_3 + 0
					end
				end

				arg_683_1.text_.text = var_686_1
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_4 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_4 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_4

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_4 and arg_683_1.time_ < 0 + var_686_4 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play910110170 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 910110170
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play910110171(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 1.725

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_1 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(910110170).content)

				arg_687_1.text_.text = var_690_1

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_3 = 69 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 69)

				if (69 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 69)) > 0 and var_690_0 < var_690_3 then
					arg_687_1.talkMaxDuration = var_690_3

					if var_690_3 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_3 + 0
					end
				end

				arg_687_1.text_.text = var_690_1
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_4 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_4

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play910110171 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 910110171
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play910110172(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["1070"]) and arg_691_1.var_.actorSpriteComps1070 == nil then
				arg_691_1.var_.actorSpriteComps1070 = arg_691_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_0 = 0.2

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["1070"]) then
				if arg_691_1.var_.actorSpriteComps1070 then
					for iter_694_0, iter_694_1 in pairs(arg_691_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_694_1 then
							if arg_691_1.isInRecall_ then
								iter_694_1.color = Color.New(Mathf.Lerp(iter_694_1.color.r, arg_691_1.hightColor1.r, (arg_691_1.time_ - 0) / var_694_0), Mathf.Lerp(iter_694_1.color.g, arg_691_1.hightColor1.g, (arg_691_1.time_ - 0) / var_694_0), (Mathf.Lerp(iter_694_1.color.b, arg_691_1.hightColor1.b, (arg_691_1.time_ - 0) / var_694_0)))
							else
								local var_694_1 = Mathf.Lerp(iter_694_1.color.r, 1, (arg_691_1.time_ - 0) / var_694_0)

								iter_694_1.color = Color.New(var_694_1, var_694_1, var_694_1)
							end
						end
					end
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["1070"]) and arg_691_1.var_.actorSpriteComps1070 then
				for iter_694_2, iter_694_3 in pairs(arg_691_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_694_3 then
						iter_694_3.color = arg_691_1.isInRecall_ and (arg_691_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_691_1.var_.actorSpriteComps1070 = nil
			end

			local var_694_2 = 0
			local var_694_3 = 0.75

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_2 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_4 = arg_691_1:FormatText(arg_691_1:GetWordFromCfg(910110171).content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_6 = 26 <= 0 and var_694_3 or var_694_3 * (utf8.len(var_694_4) / 26)

				if (26 <= 0 and var_694_3 or var_694_3 * (utf8.len(var_694_4) / 26)) > 0 and var_694_3 < var_694_6 then
					arg_691_1.talkMaxDuration = var_694_6

					if var_694_6 + var_694_2 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_6 + var_694_2
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_7 = math.max(var_694_3, arg_691_1.talkMaxDuration)

			if var_694_2 <= arg_691_1.time_ and arg_691_1.time_ < var_694_2 + var_694_7 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_2) / var_694_7

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_2 + var_694_7 and arg_691_1.time_ < var_694_2 + var_694_7 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play910110172 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 910110172
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play910110173(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["1070"]) and arg_695_1.var_.actorSpriteComps1070 == nil then
				arg_695_1.var_.actorSpriteComps1070 = arg_695_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_698_0 = 0.2

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["1070"]) then
				if arg_695_1.var_.actorSpriteComps1070 then
					for iter_698_0, iter_698_1 in pairs(arg_695_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_698_1 then
							if arg_695_1.isInRecall_ then
								iter_698_1.color = Color.New(Mathf.Lerp(iter_698_1.color.r, arg_695_1.hightColor2.r, (arg_695_1.time_ - 0) / var_698_0), Mathf.Lerp(iter_698_1.color.g, arg_695_1.hightColor2.g, (arg_695_1.time_ - 0) / var_698_0), (Mathf.Lerp(iter_698_1.color.b, arg_695_1.hightColor2.b, (arg_695_1.time_ - 0) / var_698_0)))
							else
								local var_698_1 = Mathf.Lerp(iter_698_1.color.r, 0.5, (arg_695_1.time_ - 0) / var_698_0)

								iter_698_1.color = Color.New(var_698_1, var_698_1, var_698_1)
							end
						end
					end
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["1070"]) and arg_695_1.var_.actorSpriteComps1070 then
				for iter_698_2, iter_698_3 in pairs(arg_695_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_698_3 then
						iter_698_3.color = arg_695_1.isInRecall_ and (arg_695_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_695_1.var_.actorSpriteComps1070 = nil
			end

			local var_698_2 = 0
			local var_698_3 = 0.4

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_2 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_4 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(910110172).content)

				arg_695_1.text_.text = var_698_4

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_6 = 16 <= 0 and var_698_3 or var_698_3 * (utf8.len(var_698_4) / 16)

				if (16 <= 0 and var_698_3 or var_698_3 * (utf8.len(var_698_4) / 16)) > 0 and var_698_3 < var_698_6 then
					arg_695_1.talkMaxDuration = var_698_6

					if var_698_6 + var_698_2 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_6 + var_698_2
					end
				end

				arg_695_1.text_.text = var_698_4
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_7 = math.max(var_698_3, arg_695_1.talkMaxDuration)

			if var_698_2 <= arg_695_1.time_ and arg_695_1.time_ < var_698_2 + var_698_7 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_2) / var_698_7

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_2 + var_698_7 and arg_695_1.time_ < var_698_2 + var_698_7 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play910110173 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 910110173
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play910110174(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(arg_699_1.actors_["1070"]) and arg_699_1.var_.actorSpriteComps1070 == nil then
				arg_699_1.var_.actorSpriteComps1070 = arg_699_1.actors_["1070"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_0 = 0.2

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 and not isNil(arg_699_1.actors_["1070"]) then
				if arg_699_1.var_.actorSpriteComps1070 then
					for iter_702_0, iter_702_1 in pairs(arg_699_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_702_1 then
							if arg_699_1.isInRecall_ then
								iter_702_1.color = Color.New(Mathf.Lerp(iter_702_1.color.r, arg_699_1.hightColor1.r, (arg_699_1.time_ - 0) / var_702_0), Mathf.Lerp(iter_702_1.color.g, arg_699_1.hightColor1.g, (arg_699_1.time_ - 0) / var_702_0), (Mathf.Lerp(iter_702_1.color.b, arg_699_1.hightColor1.b, (arg_699_1.time_ - 0) / var_702_0)))
							else
								local var_702_1 = Mathf.Lerp(iter_702_1.color.r, 1, (arg_699_1.time_ - 0) / var_702_0)

								iter_702_1.color = Color.New(var_702_1, var_702_1, var_702_1)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 and not isNil(arg_699_1.actors_["1070"]) and arg_699_1.var_.actorSpriteComps1070 then
				for iter_702_2, iter_702_3 in pairs(arg_699_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_702_3 then
						iter_702_3.color = arg_699_1.isInRecall_ and (arg_699_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_699_1.var_.actorSpriteComps1070 = nil
			end

			local var_702_2 = 0
			local var_702_3 = 0.1

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_2 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_4 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(910110173).content)

				arg_699_1.text_.text = var_702_4

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_6 = 4 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_4) / 4)

				if (4 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_4) / 4)) > 0 and var_702_3 < var_702_6 then
					arg_699_1.talkMaxDuration = var_702_6

					if var_702_6 + var_702_2 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_6 + var_702_2
					end
				end

				arg_699_1.text_.text = var_702_4
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_7 = math.max(var_702_3, arg_699_1.talkMaxDuration)

			if var_702_2 <= arg_699_1.time_ and arg_699_1.time_ < var_702_2 + var_702_7 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_2) / var_702_7

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_2 + var_702_7 and arg_699_1.time_ < var_702_2 + var_702_7 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play910110174 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 910110174
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play910110175(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos1070 = arg_703_1.actors_["1070"].transform.localPosition
				arg_703_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_703_1:CheckSpriteTmpPos("1070", 7)

				for iter_706_0 = 0, arg_703_1.actors_["1070"].transform.childCount - 1 do
					local var_706_0 = arg_703_1.actors_["1070"].transform:GetChild(iter_706_0)

					if var_706_0.name == "split_1" or not string.find(var_706_0.name, "split") then
						var_706_0.gameObject:SetActive(true)
					else
						var_706_0.gameObject:SetActive(false)
					end
				end
			end

			local var_706_1 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_1 then
				arg_703_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1070, Vector3.New(0, -2000, -180), (arg_703_1.time_ - 0) / var_706_1)
			end

			if arg_703_1.time_ >= 0 + var_706_1 and arg_703_1.time_ < 0 + var_706_1 + arg_706_0 then
				arg_703_1.actors_["1070"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_706_2 = 0
			local var_706_3 = 0.25

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_2 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_4 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(910110174).content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_6 = 10 <= 0 and var_706_3 or var_706_3 * (utf8.len(var_706_4) / 10)

				if (10 <= 0 and var_706_3 or var_706_3 * (utf8.len(var_706_4) / 10)) > 0 and var_706_3 < var_706_6 then
					arg_703_1.talkMaxDuration = var_706_6

					if var_706_6 + var_706_2 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_6 + var_706_2
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_7 = math.max(var_706_3, arg_703_1.talkMaxDuration)

			if var_706_2 <= arg_703_1.time_ and arg_703_1.time_ < var_706_2 + var_706_7 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_2) / var_706_7

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_2 + var_706_7 and arg_703_1.time_ < var_706_2 + var_706_7 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play910110175 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 910110175
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play910110176(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0.25

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_707_1.callingController_:SetSelectedState("normal")

				arg_707_1.keyicon_.color = Color.New(1, 1, 1)
				arg_707_1.icon_.color = Color.New(1, 1, 1)

				local var_710_1 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(910110175).content)

				arg_707_1.text_.text = var_710_1

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_3 = 10 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 10)

				if (10 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 10)) > 0 and var_710_0 < var_710_3 then
					arg_707_1.talkMaxDuration = var_710_3

					if var_710_3 + 0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_3 + 0
					end
				end

				arg_707_1.text_.text = var_710_1
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_4 = math.max(var_710_0, arg_707_1.talkMaxDuration)

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_4 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - 0) / var_710_4

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= 0 + var_710_4 and arg_707_1.time_ < 0 + var_710_4 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play910110176 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 910110176
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play910110177(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0.525

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, true)
				arg_711_1.iconController_:SetSelectedState("hero")

				arg_711_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_711_1.callingController_:SetSelectedState("normal")

				arg_711_1.keyicon_.color = Color.New(1, 1, 1)
				arg_711_1.icon_.color = Color.New(1, 1, 1)

				local var_714_1 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(910110176).content)

				arg_711_1.text_.text = var_714_1

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_3 = 21 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_1) / 21)

				if (21 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_1) / 21)) > 0 and var_714_0 < var_714_3 then
					arg_711_1.talkMaxDuration = var_714_3

					if var_714_3 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_3 + 0
					end
				end

				arg_711_1.text_.text = var_714_1
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_4 = math.max(var_714_0, arg_711_1.talkMaxDuration)

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_4 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - 0) / var_714_4

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= 0 + var_714_4 and arg_711_1.time_ < 0 + var_714_4 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play910110177 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 910110177
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play910110178(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0.275

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[354].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, true)
				arg_715_1.iconController_:SetSelectedState("hero")

				arg_715_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_715_1.callingController_:SetSelectedState("normal")

				arg_715_1.keyicon_.color = Color.New(1, 1, 1)
				arg_715_1.icon_.color = Color.New(1, 1, 1)

				local var_718_1 = arg_715_1:FormatText(arg_715_1:GetWordFromCfg(910110177).content)

				arg_715_1.text_.text = var_718_1

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_3 = 11 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_1) / 11)

				if (11 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_1) / 11)) > 0 and var_718_0 < var_718_3 then
					arg_715_1.talkMaxDuration = var_718_3

					if var_718_3 + 0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_3 + 0
					end
				end

				arg_715_1.text_.text = var_718_1
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_4 = math.max(var_718_0, arg_715_1.talkMaxDuration)

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_4 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - 0) / var_718_4

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= 0 + var_718_4 and arg_715_1.time_ < 0 + var_718_4 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play910110178 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 910110178
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play910110179(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 1.75

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, false)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_1 = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(910110178).content)

				arg_719_1.text_.text = var_722_1

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_3 = 70 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 70)

				if (70 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 70)) > 0 and var_722_0 < var_722_3 then
					arg_719_1.talkMaxDuration = var_722_3

					if var_722_3 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_3 + 0
					end
				end

				arg_719_1.text_.text = var_722_1
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_4 = math.max(var_722_0, arg_719_1.talkMaxDuration)

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_4 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - 0) / var_722_4

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= 0 + var_722_4 and arg_719_1.time_ < 0 + var_722_4 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play910110179 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 910110179
		arg_723_1.duration_ = 7

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play910110180(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if arg_723_1.bgs_.ST02 == nil then
				local var_726_0 = Object.Instantiate(arg_723_1.paintGo_)

				var_726_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_726_0.name = "ST02"
				var_726_0.transform.parent = arg_723_1.stage_.transform
				var_726_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_723_1.bgs_.ST02 = var_726_0
			end

			if 2 < arg_723_1.time_ and arg_723_1.time_ <= 2 + arg_726_0 then
				local var_726_1 = arg_723_1.bgs_.ST02

				arg_723_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_726_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_726_2 = var_726_1:GetComponent("SpriteRenderer")

				if var_726_2 and var_726_2.sprite then
					local var_726_3 = 2 * (var_726_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_726_1.transform.localScale = Vector3.New(var_726_3 / var_726_2.sprite.bounds.size.y < var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x and var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x or var_726_3 / var_726_2.sprite.bounds.size.y, var_726_3 / var_726_2.sprite.bounds.size.y < var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x and var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x or var_726_3 / var_726_2.sprite.bounds.size.y, 0)
				end

				for iter_726_0, iter_726_1 in pairs(arg_723_1.bgs_) do
					if iter_726_0 ~= "ST02" then
						iter_726_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_726_4 = 0

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_4 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_5 = 2

			if var_726_4 <= arg_723_1.time_ and arg_723_1.time_ < var_726_4 + var_726_5 then
				local var_726_6 = Color.New(0, 0, 0)

				var_726_6.a = Mathf.Lerp(0, 1, (arg_723_1.time_ - var_726_4) / var_726_5)
				arg_723_1.mask_.color = var_726_6
			end

			if arg_723_1.time_ >= var_726_4 + var_726_5 and arg_723_1.time_ < var_726_4 + var_726_5 + arg_726_0 then
				local var_726_7 = Color.New(0, 0, 0)

				var_726_7.a = 1
				arg_723_1.mask_.color = var_726_7
			end

			local var_726_8 = 2

			if 2 < arg_723_1.time_ and arg_723_1.time_ <= var_726_8 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_9 = 2

			if var_726_8 <= arg_723_1.time_ and arg_723_1.time_ < var_726_8 + var_726_9 then
				local var_726_10 = Color.New(0, 0, 0)

				var_726_10.a = Mathf.Lerp(1, 0, (arg_723_1.time_ - var_726_8) / var_726_9)
				arg_723_1.mask_.color = var_726_10
			end

			if arg_723_1.time_ >= var_726_8 + var_726_9 and arg_723_1.time_ < var_726_8 + var_726_9 + arg_726_0 then
				local var_726_11 = Color.New(0, 0, 0)

				arg_723_1.mask_.enabled = false
				var_726_11.a = 0
				arg_723_1.mask_.color = var_726_11
			end

			if arg_723_1.frameCnt_ <= 1 then
				arg_723_1.dialog_:SetActive(false)
			end

			local var_726_12 = 2
			local var_726_13 = 1.275

			if 2 < arg_723_1.time_ and arg_723_1.time_ <= var_726_12 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				arg_723_1.dialog_:SetActive(true)

				arg_723_1.dialogCg_.alpha = 0

				local var_726_14 = LeanTween.value(arg_723_1.dialog_, 0, 1, 0.3)

				var_726_14:setOnUpdate(LuaHelper.FloatAction(function(arg_727_0)
					arg_723_1.dialogCg_.alpha = arg_727_0
				end))
				var_726_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_723_1.dialog_)
					var_726_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_723_1.duration_ = arg_723_1.duration_ + 0.3

				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_15 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(910110179).content)

				arg_723_1.text_.text = var_726_15

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_17 = 51 <= 0 and var_726_13 or var_726_13 * (utf8.len(var_726_15) / 51)

				if (51 <= 0 and var_726_13 or var_726_13 * (utf8.len(var_726_15) / 51)) > 0 and var_726_13 < var_726_17 then
					arg_723_1.talkMaxDuration = var_726_17
					var_726_12 = var_726_12 + 0.3

					if var_726_17 + var_726_12 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_17 + var_726_12
					end
				end

				arg_723_1.text_.text = var_726_15
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_18 = var_726_12 + 0.3
			local var_726_19 = math.max(var_726_13, arg_723_1.talkMaxDuration)

			if var_726_12 + 0.3 <= arg_723_1.time_ and arg_723_1.time_ < var_726_18 + var_726_19 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_18) / var_726_19

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_18 + var_726_19 and arg_723_1.time_ < var_726_18 + var_726_19 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play910110180 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 910110180
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play910110181(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 1.025

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_729_1.callingController_:SetSelectedState("normal")

				arg_729_1.keyicon_.color = Color.New(1, 1, 1)
				arg_729_1.icon_.color = Color.New(1, 1, 1)

				local var_732_1 = arg_729_1:FormatText(arg_729_1:GetWordFromCfg(910110180).content)

				arg_729_1.text_.text = var_732_1

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_3 = 41 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 41)

				if (41 <= 0 and var_732_0 or var_732_0 * (utf8.len(var_732_1) / 41)) > 0 and var_732_0 < var_732_3 then
					arg_729_1.talkMaxDuration = var_732_3

					if var_732_3 + 0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_3 + 0
					end
				end

				arg_729_1.text_.text = var_732_1
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_4 = math.max(var_732_0, arg_729_1.talkMaxDuration)

			if 0 <= arg_729_1.time_ and arg_729_1.time_ < 0 + var_732_4 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - 0) / var_732_4

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= 0 + var_732_4 and arg_729_1.time_ < 0 + var_732_4 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play910110181 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 910110181
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play910110182(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 0.85

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_733_1.callingController_:SetSelectedState("normal")

				arg_733_1.keyicon_.color = Color.New(1, 1, 1)
				arg_733_1.icon_.color = Color.New(1, 1, 1)

				local var_736_1 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(910110181).content)

				arg_733_1.text_.text = var_736_1

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_3 = 34 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 34)

				if (34 <= 0 and var_736_0 or var_736_0 * (utf8.len(var_736_1) / 34)) > 0 and var_736_0 < var_736_3 then
					arg_733_1.talkMaxDuration = var_736_3

					if var_736_3 + 0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_3 + 0
					end
				end

				arg_733_1.text_.text = var_736_1
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_4 = math.max(var_736_0, arg_733_1.talkMaxDuration)

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_4 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - 0) / var_736_4

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= 0 + var_736_4 and arg_733_1.time_ < 0 + var_736_4 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play910110182 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 910110182
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play910110183(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0.225

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, true)
				arg_737_1.iconController_:SetSelectedState("hero")

				arg_737_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_737_1.callingController_:SetSelectedState("normal")

				arg_737_1.keyicon_.color = Color.New(1, 1, 1)
				arg_737_1.icon_.color = Color.New(1, 1, 1)

				local var_740_1 = arg_737_1:FormatText(arg_737_1:GetWordFromCfg(910110182).content)

				arg_737_1.text_.text = var_740_1

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_3 = 9 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_1) / 9)

				if (9 <= 0 and var_740_0 or var_740_0 * (utf8.len(var_740_1) / 9)) > 0 and var_740_0 < var_740_3 then
					arg_737_1.talkMaxDuration = var_740_3

					if var_740_3 + 0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_3 + 0
					end
				end

				arg_737_1.text_.text = var_740_1
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_4 = math.max(var_740_0, arg_737_1.talkMaxDuration)

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_4 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - 0) / var_740_4

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= 0 + var_740_4 and arg_737_1.time_ < 0 + var_740_4 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play910110183 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 910110183
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play910110184(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1.var_.moveOldPos1070 = arg_741_1.actors_["1070"].transform.localPosition
				arg_741_1.actors_["1070"].transform.localScale = Vector3.New(1, 1, 1)

				arg_741_1:CheckSpriteTmpPos("1070", 3)

				for iter_744_0 = 0, arg_741_1.actors_["1070"].transform.childCount - 1 do
					local var_744_0 = arg_741_1.actors_["1070"].transform:GetChild(iter_744_0)

					if var_744_0.name == "split_2" or not string.find(var_744_0.name, "split") then
						var_744_0.gameObject:SetActive(true)
					else
						var_744_0.gameObject:SetActive(false)
					end
				end
			end

			local var_744_1 = 0.001

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_1 then
				arg_741_1.actors_["1070"].transform.localPosition = Vector3.Lerp(arg_741_1.var_.moveOldPos1070, Vector3.New(0, -350, -180), (arg_741_1.time_ - 0) / var_744_1)
			end

			if arg_741_1.time_ >= 0 + var_744_1 and arg_741_1.time_ < 0 + var_744_1 + arg_744_0 then
				arg_741_1.actors_["1070"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				local var_744_2 = arg_741_1.actors_["1070"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_744_2 then
					arg_741_1.var_.alphaOldValue1070 = var_744_2.alpha
					arg_741_1.var_.characterEffect1070 = var_744_2
				end

				arg_741_1.var_.alphaOldValue1070 = 0
			end

			local var_744_3 = 0.5

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_3 then
				if arg_741_1.var_.characterEffect1070 then
					arg_741_1.var_.characterEffect1070.alpha = Mathf.Lerp(arg_741_1.var_.alphaOldValue1070, 1, (arg_741_1.time_ - 0) / var_744_3)
				end
			end

			if arg_741_1.time_ >= 0 + var_744_3 and arg_741_1.time_ < 0 + var_744_3 + arg_744_0 and arg_741_1.var_.characterEffect1070 then
				arg_741_1.var_.characterEffect1070.alpha = 1
			end

			local var_744_4 = arg_741_1.actors_["1070"]

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 and not isNil(var_744_4) and arg_741_1.var_.actorSpriteComps1070 == nil then
				arg_741_1.var_.actorSpriteComps1070 = var_744_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_744_5 = 0.0166666666666667

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_5 and not isNil(var_744_4) then
				if arg_741_1.var_.actorSpriteComps1070 then
					for iter_744_1, iter_744_2 in pairs(arg_741_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_744_2 then
							if arg_741_1.isInRecall_ then
								iter_744_2.color = Color.New(Mathf.Lerp(iter_744_2.color.r, arg_741_1.hightColor1.r, (arg_741_1.time_ - 0) / var_744_5), Mathf.Lerp(iter_744_2.color.g, arg_741_1.hightColor1.g, (arg_741_1.time_ - 0) / var_744_5), (Mathf.Lerp(iter_744_2.color.b, arg_741_1.hightColor1.b, (arg_741_1.time_ - 0) / var_744_5)))
							else
								local var_744_6 = Mathf.Lerp(iter_744_2.color.r, 1, (arg_741_1.time_ - 0) / var_744_5)

								iter_744_2.color = Color.New(var_744_6, var_744_6, var_744_6)
							end
						end
					end
				end
			end

			if arg_741_1.time_ >= 0 + var_744_5 and arg_741_1.time_ < 0 + var_744_5 + arg_744_0 and not isNil(var_744_4) and arg_741_1.var_.actorSpriteComps1070 then
				for iter_744_3, iter_744_4 in pairs(arg_741_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_744_4 then
						iter_744_4.color = arg_741_1.isInRecall_ and (arg_741_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_741_1.var_.actorSpriteComps1070 = nil
			end

			local var_744_7 = 0
			local var_744_8 = 0.575

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_7 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_9 = arg_741_1:FormatText(arg_741_1:GetWordFromCfg(910110183).content)

				arg_741_1.text_.text = var_744_9

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_11 = 23 <= 0 and var_744_8 or var_744_8 * (utf8.len(var_744_9) / 23)

				if (23 <= 0 and var_744_8 or var_744_8 * (utf8.len(var_744_9) / 23)) > 0 and var_744_8 < var_744_11 then
					arg_741_1.talkMaxDuration = var_744_11

					if var_744_11 + var_744_7 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_11 + var_744_7
					end
				end

				arg_741_1.text_.text = var_744_9
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_12 = math.max(var_744_8, arg_741_1.talkMaxDuration)

			if var_744_7 <= arg_741_1.time_ and arg_741_1.time_ < var_744_7 + var_744_12 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_7) / var_744_12

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_7 + var_744_12 and arg_741_1.time_ < var_744_7 + var_744_12 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_741_1:InitPlayNodeList()
	end,
	Play910110184 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 910110184
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
			arg_745_1.auto_ = false
		end

		function arg_745_1.playNext_(arg_747_0)
			arg_745_1.onStoryFinished_()
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 1.675

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_1 = arg_745_1:FormatText(arg_745_1:GetWordFromCfg(910110184).content)

				arg_745_1.text_.text = var_748_1

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_3 = 67 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 67)

				if (67 <= 0 and var_748_0 or var_748_0 * (utf8.len(var_748_1) / 67)) > 0 and var_748_0 < var_748_3 then
					arg_745_1.talkMaxDuration = var_748_3

					if var_748_3 + 0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_3 + 0
					end
				end

				arg_745_1.text_.text = var_748_1
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_4 = math.max(var_748_0, arg_745_1.talkMaxDuration)

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_4 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - 0) / var_748_4

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= 0 + var_748_4 and arg_745_1.time_ < 0 + var_748_4 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I03",
		"TextureConfig/Background/ST34",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/I05",
		"TextureConfig/Background/I05a",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/ST05",
		"TextureConfig/Background/ST02"
	},
	voices = {}
}
